



def highlight()

 return <<-TEXT


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
if(document.querySelector('[class*="language-"]')){
Prism.highlightAll();
}

});


TEXT
end