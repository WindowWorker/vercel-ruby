globalThis.await=(promise)=>{console.log("Attempting to await promise in synchronous context ",promise);return promise;};

globalThis.yield=(next)=>{console.log("Attempting to yield next outside of a generator ",next);return next;};


globalThis.queryApplyAll=async function(query,func){

let elems=Array.from(document.querySelectorAll(query));
const elems_length=elems.length;
for(let i=0;i<elems_length;i++){try{
  func(elems[i]);
}catch(e){await("queryApplyAll");console.log(e); continue;}}

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

if(!(globalThis.declarations)){globalThis.declarations=[];}

globalThis.declare=function(func){
    globalThis.declarations.push(func);
};

globalThis.declareEvaluator=async function(){

  const declarations_length = declarations.length;
  for(let i = 0;i < declarations_length;i++){try{

    declarations[i]();

  }catch(e){await("declareEvaluator");console.log(e);continue;}}

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