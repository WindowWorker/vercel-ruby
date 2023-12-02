
def rubyscript()

return <<-TEXT

let ruby_html = document.querySelector('html');

ruby_html.setAttribute('window-location' , window.location.href);
ruby_html.setAttribute('user-agent' , navigator.userAgent);

TEXT

end