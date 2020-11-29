from htmlgen import nil

macro bsection(e: varargs[untyped]): untyped =
  ## Generates the blogger html ``b:section`` element.
  result = htmlgen.xmlCheckedTag(e, "b:section", htmlgen.commonAttr)

macro bskin(e: varargs[untyped]): untyped =
  ## Generates the blogger html ``b:skin`` element.
  result = htmlgen.xmlCheckedTag(e, "b:skin", htmlgen.commonAttr)

func cdata(content: string): string =
  ## Encloses content in ``CDATA`` html element.
  result = """<![CDATA[""" & content & """]]>"""

const styleSheet = readFile("src/style.css")

# Generate the javascript.
exec "nim js -r ../src/script.nim --outdir temp"
const javascript = readFile("src/script.js")

const xmlEncoding = """<?xml version="1.0" encoding="UTF-8"?>"""
const doctypeString = """<!DOCTYPE html>"""

let document = htmlgen.html(
  htmlgen.head(
    htmlgen.title("baremetal.dev"),
    htmlgen.meta(charset = "utf-8"),   # TODO description etc
    bskin(cdata(styleSheet))
  ),
  htmlgen.body(
    htmlgen.h1(htmlgen.a(href = "https://baremetal.dev", "baremetal.dev")),
    htmlgen.script(cdata(javascript)),
    bsection(id = "1") # required for blogger
  )
)

let htmlDocument = xmlEncoding & doctypeString & document

writeFile("index.html", htmlDocument)

# echo htmlDocument
