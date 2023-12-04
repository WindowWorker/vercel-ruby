

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

if(!(globalThis.declarations)){globalThis.declarations=[];}

globalThis.declare=function(func){
    globalThis.declarations.push(func);
};

globalThis.declareEvaluator=function(){

    const declarations_length = declarations.length;
  for(let i = 0;i < declarations_length;i++){try{

    declarations[i]();

  }catch(e){console.log(e);continue;}}

};

setInterval(function(){globalThis.declareEvaluator();},100);



let page_html = document.querySelector('html');

page_html.setAttribute('window-location' , window.location.href);
declare(()=>page_html.updateAttribute('window-location' , window.location.href));

page_html.setAttribute('user-agent' , navigator.userAgent);
declare(()=>page_html.updateAttribute('user-agent' , navigator.userAgent));

if (window!=window.top){
page_html.setAttribute('framed','true');
}

declare(()=>{

  if(window.innerHeight=window.innerWidth){
    page_html.updateAttribute('orientation','square');
  }
  if(window.innerHeight>window.innerWidth){
    page_html.updateAttribute('orientation','portrait');
  }
  if(window.innerHeight<window.innerWidth){
    page_html.updateAttribute('orientation','landscape');
  }

});