def rubystyle()
  
 return <<-TEXT
 
#header_content>a{
  background:  url(https://archives.bulbagarden.net/media/upload/e/ed/Spr_5b_383.png) 
  no-repeat left 8px !important;
  background-size: 20% !important;
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



html[window-location*="docs.ruby-lang.org"] a{
color: #CC342D !important;
}

.carbonad,[data-attributes*="carbon"]{display:none !important;}

TEXT
end