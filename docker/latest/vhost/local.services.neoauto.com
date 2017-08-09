server {
    listen        80;
    server_name   local.services.neoauto.com;

    location /v1/concessionaire {
        proxy_pass http://local.neoauto.concessionaire.com:80;
        
        location /v1/concessionaire/static {
           alias /apps/neoauto.concessionaire.com/app/public/static;
        }
    }

    location /v1/oauth {
       proxy_pass http://local.neoauto.oauth.com:80;

       location /v1/oauth/static {
           alias /apps/neoauto.oauth.com/app/public/static;
       }
    }

    location /v1/identity {
        proxy_pass http://local.neoauto.identity.com:80;

        location /v1/identity/static {
           alias /apps/neoauto.identity.com/app/public/static;
        }
    }

    location /v1/search {
      proxy_pass http://local.neoauto.search.com:80;
    
      location /v1/search/static {
        alias /apps/neoauto-micro-service-search/app/public/static;
      }
      
    }

    location ~ .php$ {
        try_files     $uri =404;
        fastcgi_pass  127.0.0.1:9000;
        include       fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }

    error_page 404 /404.html;
        location = /40x.html {
    }

    error_page 500 502 503 504 /50x.html;
        location = /50x.html {
    }

    error_log /var/log/nginx/local.services.neoauto.com.error.log;
}