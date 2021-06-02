#include <stdio.h>
#include <stdlib.h>
#include <curl/curl.h>

int main(void)
{
  CURL *curl;
  CURLcode res;

  curl = curl_easy_init();

  if(curl) {
    curl_easy_setopt(curl, CURLOPT_URL, "https://github.com");
    /* Allow to redirected */
    curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
#ifndef DEBUG
    curl_easy_setopt(curl, CURLOPT_NOBODY, 1);
#endif

    /* Perform the request, res will get the return code */
    res = curl_easy_perform(curl);

    /* Check for errors */
    if(res == CURLE_OK) {
#ifndef DEBUG
      system("cd /www/xderm/");
      system("./xderm-mini stop");
      system("./xderm-mini start");
#else
      printf("HTTP OK");
#endif
    } else {
#ifdef DEBUG
      fprintf(stderr, "curl_easy_perform() failed: %s\n",
              curl_easy_strerror(res));
#else
      printf("There are something wrong!");
#endif
    }
    /* Always cleanup */
    curl_easy_cleanup(curl);
  }
  return 0;
}
