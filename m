From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Mar 2016 17:13:07 +0100
Subject: [LTP] [PATCH] mmap16: fix ETIMEDOUT error if test device too
 large
In-Reply-To: <1457097900-12012-1-git-send-email-zlang@redhat.com>
References: <1457097900-12012-1-git-send-email-zlang@redhat.com>
Message-ID: <20160307161307.GB6055@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  lib/tst_mkfs.c                          | 11 ++++++++---
>  testcases/kernel/syscalls/mmap/mmap16.c |  2 +-
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> index 5f959a4..2948e25 100644
> --- a/lib/tst_mkfs.c
> +++ b/lib/tst_mkfs.c
> @@ -27,6 +27,7 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
>  	int i, pos = 3;
>  	const char *argv[OPTS_MAX] = {"mkfs", "-t", fs_type};
>  	char fs_opts_str[1024] = "";
> +	int tailed = 0;
>  
>  	if (!fs_type)
>  		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
> @@ -54,7 +55,11 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
>  
>  	if (fs_opts) {
>  		for (i = 0; fs_opts[i]; i++) {
> -			argv[pos++] = fs_opts[i];
> +			if (!strcmp(fs_opts[i], "|")) {
> +				argv[pos++] = dev;
> +				tailed = 1;
> +			} else
> +				argv[pos++] = fs_opts[i];
>  
>  			if (pos + 2 > OPTS_MAX) {
>  				tst_brkm(TBROK, cleanup_fn,
> @@ -66,8 +71,8 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
>  			strcat(fs_opts_str, fs_opts[i]);
>  		}
>  	}
> -
> -	argv[pos++] = dev;
> +	if (tailed == 0)
> +		argv[pos++] = dev;
>  	argv[pos] = NULL;
>  
>  	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",

This is ugly. If you want to pass the filesystem size you should add an
paramter to the mkfs function instead of inventing special syntax for
what has been simple list of parameters. We may add a second tst_mkfs2()
function with extra parameter for the fs size.

Also you should make sure that the device is large enough for the
requested size. For this use we may call the paramter max_size and
simply ignore it if the device is smaller than that.

-- 
Cyril Hrubis
chrubis@suse.cz
