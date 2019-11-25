From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Nov 2019 14:01:55 +0100
Subject: [LTP] [PATCH v2] tst_fill_fs: enhance the filesystem filling
 routine
In-Reply-To: <20191120072311.32333-1-liwang@redhat.com>
References: <20191120072311.32333-1-liwang@redhat.com>
Message-ID: <20191125130155.GA8703@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
> index 4003dce97..3015c066e 100644
> --- a/lib/tst_fill_fs.c
> +++ b/lib/tst_fill_fs.c
> @@ -6,6 +6,7 @@
>  #include <errno.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <sys/statvfs.h>
>  
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
> @@ -19,6 +20,8 @@ void tst_fill_fs(const char *path, int verbose)
>  	size_t len;
>  	ssize_t ret;
>  	int fd;
> +	struct statvfs fi;
> +	statvfs(path, &fi);
>  
>  	for (;;) {
>  		len = random() % (1024 * 102400);
> @@ -37,17 +40,20 @@ void tst_fill_fs(const char *path, int verbose)
>  			return;
>  		}
>  
> -		while (len) {
> +		while (len >= fi.f_bsize/2) {
>  			ret = write(fd, buf, MIN(len, sizeof(buf)));
>  
>  			if (ret < 0) {
> +				if (errno == ENOSPC) {
> +					SAFE_FSYNC(fd);
> +					len /= 2;
> +					continue;
> +				}
> +
>  				SAFE_CLOSE(fd);
>  
>  				if (errno != ENOSPC)
>  					tst_brk(TBROK | TERRNO, "write()");
> -
> -				tst_res(TINFO | TERRNO, "write()");
> -				return;
>  			}
>  
>  			len -= ret;

Wouldn't this cause second SAFE_CLOSE() here because we no longer do a
return from from the while loop on ENOSPC?

Why not just:

diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
index 4003dce97..2226171d8 100644
--- a/lib/tst_fill_fs.c
+++ b/lib/tst_fill_fs.c
@@ -41,6 +41,13 @@ void tst_fill_fs(const char *path, int verbose)
                        ret = write(fd, buf, MIN(len, sizeof(buf)));
 
                        if (ret < 0) {
+                               /* retry on ENOSPC to make sure filesystem is really full */
+                               if (errno == ENOSPC && len >= fi.f_bsize/2) {
+                                       SAFE_FSYNC(fd);
+                                       len /= 2;
+                                       continue;
+                               }
+
                                SAFE_CLOSE(fd);
 
                                if (errno != ENOSPC)


-- 
Cyril Hrubis
chrubis@suse.cz
