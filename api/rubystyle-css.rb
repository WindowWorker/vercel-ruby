def rubystyle()
  
 return <<-TEXT
 
#header_content>a{
  background:  url(https://archives.bulbagarden.net/media/upload/e/ed/Spr_5b_383.png) 
  no-repeat left 8px !important;
  background-size: 20% !important;
}

@media screen and (min-width: 768px) #home-page-layout #intro a.download-link{
background:#CC342D url(https://archives.bulbagarden.net/media/upload/8/8e/Ani383OD.png) no-repeat 8px center !important;
}

html[window-location*="sapphire"]{
filter:hue-rotate(-120deg);
}

html[window-location*="sapphire"] #header_content>a{
  background:  url(https://archives.bulbagarden.net/media/upload/1/10/Spr_5b_382.png) 
  no-repeat left 8px !important;
  background-size: 20% !important;
  filter:hue-rotate(120deg);
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