From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 May 2016 14:49:08 +0200
Subject: [LTP] [PATCH 2/2] ltp-aiodio: report posix_memalign errors
 properly
In-Reply-To: <1462268030-21958-2-git-send-email-eguan@redhat.com>
References: <1462268030-21958-1-git-send-email-eguan@redhat.com>
 <1462268030-21958-2-git-send-email-eguan@redhat.com>
Message-ID: <20160503124908.GE6059@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  int dio_sparse(char *filename, int align, int writesize, int filesize)
>  {
> -	int fd;
> +	int fd, ret;
>  	void *bufptr;
>  	int i, w;
>  
> @@ -68,9 +69,10 @@ int dio_sparse(char *filename, int align, int writesize, int filesize)
>  
>  	SAFE_FTRUNCATE(cleanup, fd, filesize);
>  
> -	if (posix_memalign(&bufptr, align, writesize)) {
> +	ret = posix_memalign(&bufptr, align, writesize);
> +	if (ret) {
> +		tst_resm(TBROK, "posix_memalign(): %s", strerror(ret));

We should use tst_strerrno() instead of strerror().

>  		close(fd);
> -		tst_resm(TBROK | TERRNO, "posix_memalign()");
>  		return 1;
>  	}

Otherwise this looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
