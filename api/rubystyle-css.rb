

def rubystyle()
  
 return <<-TEXT
 
#header_content>a{
  background:  url(https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/e/ed/Spr_5b_383.png) 
  no-repeat left 8px !important;
  background-size: 20% !important;
}

@media screen and (min-width: 768px) {

  a.download-link{
    background:#CC342D url(https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/8/8e/Ani383OD.png) no-repeat 8px center !important;
    background-size: 25% !important;
    background-position-x: left !important;
    background-position-y: bottom !important;
  }
  
}

html[window-location*="ruby-doc.com"] #header{
background:url(https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/7/7d/Spr_3e_383.png) 850px 0 no-repeat !important;
}







html[window-location*="sapphire"]:not([framed]){
filter:hue-rotate(-120deg);
}

html[window-location*="sapphire"] #header_content>a{
  background:  url(https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/1/10/Spr_5b_382.png) 
  no-repeat left 8px !important;
  background-size: 25% !important;
  background-position-y: bottom !important;
  filter:hue-rotate(120deg);
}


@media screen and (min-width: 768px) {

 html[window-location*="sapphire"] a.download-link{
    background:#CC342D url(https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/c/c6/Ani382OD.png) no-repeat 8px center !important;
background-size: 20% !important;
    background-position-x: left !important;
    background-position-y: -10px !important;
    filter: hue-rotate(120deg);
      background-color: #2D34CC !important;
      border: 2px solid #161c9b !important;
      -webkit-box-shadow: 0 2px 0 #161c9b !important;
      -moz-box-shadow: 0 2px 0 #161c9b !important;
      box-shadow: 0 2px 0 #161c9b !important;

  }

}

html[window-location*="sapphire"][window-location*="ruby-doc.com"] #header{
background:url(https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/8/80/Spr_3e_382.png) 850px 0 no-repeat !important;
filter: hue-rotate(120deg);

}

html[window-location*="sapphire"][window-location*="ruby-doc.com"] #header a{
  filter:hue-rotate(-120deg);
  color:#CC342D !important;
}





html[window-location*="emerald"]:not([framed]){
filter:hue-rotate(135deg);
}

html[window-location*="emerald"] #header_content>a{
  background:  url(https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/5/55/Spr_5b_384.png) 
  no-repeat left 8px !important;
  background-size: 25% !important;
  background-position-y: bottom !important;
  filter:hue-rotate(-135deg);
}


@media screen and (min-width: 768px) {

 html[window-location*="emerald"] a.download-link{
    background:#CC342D url(https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/2/27/Box_XD_384.png) no-repeat 8px center !important;
    background-size: 18% !important;
    background-position-y: bottom !important;
    filter: hue-rotate(-135deg);
      background-color: #34CC2D !important;
      border: 2px solid #1c9b16 !important;
      -webkit-box-shadow: 0 2px 0 #1c9b16 !important;
      -moz-box-shadow: 0 2px 0 #1c9b16 !important;
      box-shadow: 0 2px 0 #1c9b16 !important;

  }

}

html[window-location*="emerald"][window-location*="ruby-doc.com"] #header{
  background:url(https://api.typescripts.org/corsFetch/https://archives.bulbagarden.net/media/upload/4/4f/Spr_3e_384.png) 850px 0 no-repeat !important;
  filter:hue-rotate(-135deg)
}
html[window-location*="emerald"][window-location*="ruby-doc.com"] #header a{
  filter:hue-rotate(135deg);
  color:#34CC2D !important;
}






html[window-location*="docs.ruby-lang.org"] a,
html[window-location*="ruby-doc.com"] a,
html[window-location*="ruby-doc.com"] h1,
html[window-location*="stdlib"] a,
html[window-location*="stdlib"] h1{
color: #CC342D !important;
1px 1px 2px white, -1px -1px 2px white, -1px 1px 2px white, 1px -1px 2px white;
}

.carbonad,[data-attributes*="carbon"]{display:none !important;}

[comment="highlight"]{display:none;}

.language-ruby{
border-radius: 1vmax;
}

TEXT
end