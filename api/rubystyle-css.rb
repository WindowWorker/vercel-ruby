

def rubystyle()
  
 return <<-TEXT
 
#header_content>a{
  background:  url(https://archives.bulbagarden.net/media/upload/e/ed/Spr_5b_383.png) 
  no-repeat left 8px !important;
  background-size: 20% !important;
}

@media screen and (min-width: 768px) {

  a.download-link{
    background:#CC342D url(https://archives.bulbagarden.net/media/upload/8/8e/Ani383OD.png) no-repeat 8px center !important;
    background-size: 25% !important;
    background-position-y: bottom !important;
  }
  
}

html[window-location*="ruby-doc.com"] #header{
background:url(https://archives.bulbagarden.net/media/upload/7/7d/Spr_3e_383.png) 850px 0 no-repeat !important;
}



html[window-location*="sapphire"]:not([framed]){
filter:hue-rotate(-120deg);
}

html[window-location*="sapphire"] #header_content>a{
  background:  url(https://archives.bulbagarden.net/media/upload/1/10/Spr_5b_382.png) 
  no-repeat left 8px !important;
  background-size: 25% !important;
  background-position-y: bottom !important;
  filter:hue-rotate(120deg);
}


@media screen and (min-width: 768px) {

 html[window-location*="sapphire"] a.download-link{
    background:#CC342D url(https://archives.bulbagarden.net/media/upload/c/c6/Ani382OD.png) no-repeat 8px center !important;
    background-size: 25% !important;
    background-position-y: bottom !important;
  }

}

html[window-location*="sapphire"][window-location*="ruby-doc.com"] #header{
background:url(https://archives.bulbagarden.net/media/upload/8/80/Spr_3e_382.png) 850px 0 no-repeat !important;
}


html[window-location*="docs.ruby-lang.org"] a,
html[window-location*="ruby-doc.com"] a,
html[window-location*="ruby-doc.com"] h1,
html[window-location*="stdlib"] a,
html[window-location*="stdlib"] h1{
color: #CC342D !important;
}

.carbonad,[data-attributes*="carbon"]{display:none !important;}

TEXT
end