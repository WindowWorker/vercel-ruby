



def highlight()

 return <<-TEXT


globalThis.highlighter=async function(){
  if(document.querySelector('[class*="language-"]:not(:has(.token))')){
  try{
    if(globalThis.Prism){
      let hs=Array.from(document.querySelectorAll('[class*="language-"]:not(:has(.token))'));
      let hs_length=hs.length;
      for(let i=0 ; i<hs_length ; i++){try{
        await Prism.highlightElement?.(hs[i]);
      }catch(e){await(console.log(e));continue;}}
      await Prism.highlightAll();
      }
      
    }catch(e){await(console.log(e));}
  }
}


declare(async ()=>{
if(!(document.querySelector('link[href="https://cdnjs.cloudflare.com/ajax/libs/prism/9000.0.1/themes/prism.min.css"]'))){
  let prismCss = document.createElement('link');
  prismCss.setAttribute('href','https://cdnjs.cloudflare.com/ajax/libs/prism/9000.0.1/themes/prism.min.css');
  prismCss.setAttribute('rel','stylesheet');
  document.firstElementChild.appendChild(prismCss);
}

await import('https://cdnjs.cloudflare.com/ajax/libs/prism/9000.0.1/prism.min.js');
await import('https://cdnjs.cloudflare.com/ajax/libs/prism/9000.0.1/components/prism-ruby.min.js');

let prs=Array.from(document.querySelectorAll('pre:not([class])'));
const prs_length=prs.length;
for(let i=0;i<prs_length;i++){try{
  prs[i].innerHTML='<code class="language-ruby">'+prs[i].innerHTML+'</code>';
  prs[i].setAttribute('class','language-ruby');
}catch(e){await console.log(e); continue;}}

let notprs=Array.from(document.querySelectorAll(':not(pre)>code'));
const notprs_length=notprs.length;
for(let i=0;i<notprs_length;i++){try{
  notprs[i].setAttribute('class','language-ruby');
  notprs[i].outerHTML='<pre class="language-ruby">'+notprs[i].outerHTML+'</pre>';
}catch(e){await console.log(e); continue;}}

let aprs=Array.from(document.querySelectorAll('pre[class*="language-"]:not(:has(code))'));
const aprs_length=aprs.length;
for(let i=0;i<aprs_length;i++){try{
  aprs[i].innerHTML='<code class="language-ruby">'+aprs[i].innerHTML+'</code>';
}catch(e){await console.log(e); continue;}}

if(document.querySelector('[class*="language-"]')){
highlighter();
}

});


TEXT
end