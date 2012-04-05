# RSLT

RSLT lets you describe a transformation between one XML format and another. 
The idea is it's as functional as XSLT, but encourages stylesheets which are readable, modular and easy to test.

I've extracted it from an app I built for my work at Lonely Planet.

Use it instead of XSLT if you have any complex transformation rules.


![Build Status](https://secure.travis-ci.org/DanielHeath/rslt.png "Build Status")

## FEATURES

Nice syntax.
Testable, reusable xml transformation
In live use on REE 1.8.7 and MRI 1.9.3, and tested against several others via TravisCI.

## Example

    class MyStylesheet < RSLT::Stylesheet
      def rules
        render('parent > child')     { builder.p(:style => "child_content" ) { child_content }  }
        render('parent')             { builder.p(:style => "parent_content") { child_content }  }
        render('text()')             { add element.to_xml.upcase                                }
      end
    end

    MyStylesheet.transform <<-XML
    <parent>
      <child>Use RSLT</child>
    </parent>
    XML
    -> <p style="parent_content"><p style="child_content">USE RSLT</p></p>

## REQUIREMENTS:

* Nokogiri, Builder

## INSTALL:

* gem install rslt

## LICENSE:

(The MIT License)

Copyright (c) 2010 Daniel Heath

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
