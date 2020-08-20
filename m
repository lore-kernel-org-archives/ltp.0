From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Aug 2020 14:25:38 +0200
Subject: [LTP] [PATCH v2 1/1] tst_kvcmp: Strip double quotes when
 parsing /etc/os-release
In-Reply-To: <20200820120051.331-1-pvorel@suse.cz>
References: <20200820120051.331-1-pvorel@suse.cz>
Message-ID: <20200820122538.GC9000@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
> index 185a5c39c..dfd81ac83 100644
> --- a/lib/tst_kvercmp.c
> +++ b/lib/tst_kvercmp.c
> @@ -148,6 +148,12 @@ const char *tst_kvcmp_distname(const char *kver)
>  	if (access(OSRELEASE_PATH, F_OK) != -1) {
>  		SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
>  
> +		if (p[0] == '"')
> +			memmove(p, p + 1, strlen(p));

Why can't we just do distname++ and move the p = distname after this
condition?

> +		if (p[strlen(p) - 1] == '"')
> +			p[strlen(p) - 1] = '\0';

I guess that we can move this to the while loop with:

	while (*p) {
		if (*p == '"') {
			*p = 0;
			break;
		}

		*p = ....
		p++;
	}

>  		while (*p) {
>  			*p = toupper((unsigned char)*p);
>  			p++;
> -- 
> 2.28.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
