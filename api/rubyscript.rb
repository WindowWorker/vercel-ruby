
def rubyscript()

return <<-TEXT

void function rubyscript(){

let ruby_html = document.querySelector('html');

ruby_html.setAttribute('location-href' , window.location.href);
ruby_html.setAttribute('navigator-user-agent' , navigator.userAgent);
if (window!=window.top){
ruby_html.setAttribute('framed','');
}

Element.prototype.updateAttribute=function(attr,val){
const el = this;
if(!(el.hasAttribute(attr,val))){
el.setAttribute(attr,val);
}else{
if(el.getAttribute(attr)!=val){
el.setAttribute(attr,val);
}
}
}

function swapSapphireText(el){

  if(!el){return;}
  var n, a=[], walk=document.createTreeWalker(el,NodeFilter.SHOW_TEXT,null,false);
  while(n=walk.nextNode()){
  a.push(n);
    let ntext=n.textContent;

  ntext=ntext.replace(/ruby/gi,'Sapphire');

  if(ntext!=n.textContent){
    n.textContent=ntext;
  }

  };
  if(document.title.toLowerCase().includes('ruby')){
    document.title=document.title
      .replace(/ruby/gi,'Sapphire')
     }
  return a;
  }


if(window.location.href.toLowerCase().includes('sapphire')){
setInterval(function(){

swapSapphireText(document.body);

},100);

}

}();



TEXT

end