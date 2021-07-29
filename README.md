This Rails Application is a clone of TinyURL.

Features :

1. It will allow users to submit a URL which will then be shortened and can be shared.
2. When users click on the short URL they are redirected to the long URL. 
3. Track the IP address of each visit to a URL. 

Here are some routes that can be accessed :

/ # home page where user can enter a URL
/:token # redirects to full URL
/:token/info # info about URL and visitor count
