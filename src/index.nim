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

var styleFile = open("src/style.css", fmRead)

let styleSheet = styleFile.readAll()

const javascript = ""

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
    htmlgen.script(javascript),
    bsection(id = "1") # required for blogger
  )
)

let htmlDocument = xmlEncoding & doctypeString & document

var htmlFile = open("index.html", fmWrite)
htmlFile.write(htmlDocument)
htmlFile.close()

echo htmlDocument
