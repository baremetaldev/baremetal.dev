from htmlgen import nil

const styleSheet = ""

const javascript = ""

const xmlEncoding = """<?xml version="1.0" encoding="UTF-8"?>"""
const doctypeString = """<!DOCTYPE html>"""

# Blogger extra requirements
# TODO proper htmlgen.xmlEncoding() version of this
const skinOpen = """<b:skin><![CDATA["""
const skinClose = """]]></b:skin>"""
const bloggerStyle = skinOpen & styleSheet & skinClose
const bloggerSection = """<b:section id="1"></b:section>"""

let document = htmlgen.html(
  htmlgen.head(
    # TODO header
    bloggerStyle
  ),
  htmlgen.body(
    htmlgen.h1(htmlgen.a(href="https://baremetal.dev", "baremetal.dev")),
    htmlgen.script(javascript),
    bloggerSection
  )
)

let htmlDocument = xmlEncoding & doctypeString & document

var htmlFile = open("index.html", fmWrite)
htmlFile.write(htmlDocument)
htmlFile.close()

# echo htmlDocument
