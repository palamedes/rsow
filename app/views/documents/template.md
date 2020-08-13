---
published: false
sitemap: true
title:
excerpt:
date: 
layout: post
tags:
categories:
image: 
gallery:
ribbon:
document_class:
private: false
allow_comments: true
duration:
costs: 
updates: 
slug: template
icon: 
audio: 
audioautoplay: false
audioloop: false
---

published: true|false
 ^ Is this file published and should it show up at all
 
sitemap: true|false
 ^ Should this file be included in the site map?


title: {title string, try to keep it under 100 characters }
 ^ This is the title link that shows up at the top of the page, and in lists

excerpt: {blurb string, try to keep it under 500 characters }
 ^ A short expert from the content (or not) that shows up under the title in the lists and in meta data.  Important.

date: {Date of initial publish}
 ^ This is the order things will be sorted in for blog posts.  Not required for static pages.

layout: post|page|none|{etc...}
 ^ Which layout/background/window style etc.. does this content use for display?  

tags: A,B,C {or..}
 - A
 - B
 - C
 ^ An array of all the tags that this sucker belongs to.  Probably a good idea to be uniform and consistent about your naming schemes.

categories:
 ^ Categories is an array of special tags.

image: /images/.....jpg
 ^ What is the cover page image if there is one?
 
gallery:
 - /images/.....jpg
 - /images/.....jpg
 ^ an array of all the images in the gallery

document_class:
 ^ any class you want to go to the page/post as it's displayed, goes here

private: true|false
 ^ Should this file show up in lists?

allow_comments: true|false
 ^ Should this file allow comments to be posted?
 
duration:
 ^ Adds a little clock symbol with the time it took 
  
costs:
 ^ adds a little costs symbol with a $ by it to show how much this costs 
 
updates:
 ^ Array of the dates the file was updated ( will be converted to a date in the template )

slug: {unique name}
 ^ Typically the file name, this is the name that will be assigned to the document for desktop tracking purposes

icon: {small icon name}
 ^ This is the semantic icon string used to create the icon in the task bar and in the window - defaults to "file outline"

audio: {link to audio file}
 ^ This is used by those pages that have an imbeded audio file of the page.. music.. a reading.. whatever.

audioautoplay: true|false
 ^ Do we auto play this file or no?  
 
audioloop: true|false
 ^ Should we loop this audio?
 

LEGACY NO LONGER USED:

type: post|page
 ^ Legacy from WP.  Is this a blog post, or a static page (irony!).
   Posts show up in lists and pay attention to dates, Pages do not.
   There are other types including "special" which is treated as a page but doesn't show up in menus. ( /tags/ for example)
   Coming soon are gallery and store front types too.. stay tuned.
   LEGACY NO LONGER USED... Documents directory structure now defines this

ribbon:
 ^ On the front page, what corner banner should we use? {may change}


tile_position: default|topright|topleft
 ^ The idea behind this is we either do nothing and let it cascade to where ever it needs to {default} or we then try to place it top right, or top left

tile_size:
  ^ {width}x{height} of the tile on the listing pages.  Default is always 1x1 unless its the very first post in the list
    then its 2x2.  The system supports tiles up to 10 columns wide and as tall as you want to make them, but your canvas
    determines the ultimate width.  You obviously can't put a 10 width tile in a 4 column canvas! (it will crop it to 4)

tile_main_top:
  ^ height in pixels or percent the main to start.  Default is 50%, but if you have a really short image then that looks odd and you can 
  adjust it here.  Using percent means the site scales better.

tile_image_offset: 50% 0
  ^ default is "50% 0" or "center top" however if you want to change that you can do it here.  Right number is top, to move it up
  you need to apply a negative number.

tile_color:
  ^ Hex value of the color of the tile, or it will randomly pick one form the css list of like 20 or so.

tile_class:
  ^ any class you want to add to the block that shows up on the index pages, goes here






 ----------
 
 This is a demo of all styled elements in the site as of now. 
 
 [View the markdown used to create this post](https://raw.githubusercontent.com/barryclark/www.jekyllnow.com/gh-pages/_posts/2014-6-19-Markdown-Style-Guide.md).
 
 This is a paragraph, it's surrounded by whitespace. Next up are some headers, they're heavily influenced by GitHub's markdown style.
 
 ## Header 2 (H1 is reserved for post titles)##
 
 ### Header 3
 
 #### Header 4
  
 ##### H5 - Reserved for in document right floated text that grabs focus
   
 ###### H6 - Reserved for legacy comments.
   
 A link to [Jekyll Now](http://github.com/barryclark/jekyll-now/). A big ass literal link <http://github.com/barryclark/jekyll-now/>
   
 An image, located within /images
 
 ![an image alt text]({{ site.baseurl }}/images/jekyll-logo.png "an image title")
 
 * A bulletted list
 - alternative syntax 1
 + alternative syntax 2
   - an indented list item
 
 1. An
 2. ordered
 3. list
 
 Inline markup styles: 
 
 - _italics_
 - **bold**
 - `code()` 
  
 > Blockquote
 >> Nested Blockquote 
  
 Syntax highlighting can be used by wrapping your code in a liquid tag like so:
 
 {{ "{% highlight javascript " }}%}  
 /* Some pointless Javascript */
 var rawr = ["r", "a", "w", "r"];
 {{ "{% endhighlight " }}%}  
 
 creates...
 
 {% highlight javascript %}
 /* Some pointless Javascript */
 var rawr = ["r", "a", "w", "r"];
 {% endhighlight %}
  
 Use two trailing spaces  
 on the right  
 to create linebreak tags  
  
 Finally, horizontal lines
  
 ----
 ****