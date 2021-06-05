#include <stdio.h>
#include <stdlib.h>
#include <curl/curl.h>

int main(void)
{
      for(;;) {
            check();
      }
      return 0;
}

int check(void)
{
      CURL *curl;
      CURLcode res;

      curl = curl_easy_init();

      if(curl) {
            curl_easy_setopt(curl, CURLOPT_URL, "https://github.com");
            /* Allow to redirected */
            curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
#ifndef DEBUG
            /* Don't print body HTML */
            curl_easy_setopt(curl, CURLOPT_NOBODY, 1);
#endif

            /* Perform the request, res will get the return code */
            res = curl_easy_perform(curl);

            /* Check for connection */
            if(res == CURLE_OK) {
                  /* Connection available */
                  printf("HTTP OK\n");
                  sleep(10);
            } else {
                  /* Connection not available */
#ifdef DEBUG
                  fprintf(stderr, "curl_easy_perform() failed: %s\n",
                        curl_easy_strerror(res));
#else
                  printf("No internet!\n");
                  system("cd /www/xderm/ && ./xderm-mini stop && rm screenlog.0 && ./xderm-mini start");
#endif
                  sleep(10);
            }
      /* Always cleanup */
      curl_easy_cleanup(curl);
      }
}
