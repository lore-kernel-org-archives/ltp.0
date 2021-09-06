From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Sep 2021 14:21:52 +0200
Subject: [LTP] [PATCH 3/7] Add user/group ID lookup helper functions
In-Reply-To: <20210903154848.18705-4-mdoucha@suse.cz>
References: <20210903154848.18705-1-mdoucha@suse.cz>
 <20210903154848.18705-4-mdoucha@suse.cz>
Message-ID: <YTYH4DdeUqsYeglK@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/tst_uid.c b/lib/tst_uid.c
> index dd719d312..915a5bc34 100644
> --- a/lib/tst_uid.c
> +++ b/lib/tst_uid.c
> @@ -3,8 +3,10 @@
>   * Copyright (c) 2021 Linux Test Project
>   */
>  
> +#define _XOPEN_SOURCE 500
>  #include <sys/types.h>
>  #include <grp.h>
> +#include <pwd.h>
>  #include <errno.h>
>  
>  #define TST_NO_DEFAULT_MAIN
> @@ -36,3 +38,101 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
>  	tst_brk_(file, lineno, TBROK, "No free group ID found");
>  	return (gid_t)-1;
>  }
> +
> +struct passwd *safe_getpwent(const char *file, const int lineno)
> +{
> +	struct passwd *ret;
> +
> +	errno = 0;
> +	ret = getpwent();
> +
> +	if (!ret) {
> +		if (errno) {
> +			tst_brk_(file, lineno, TBROK | TERRNO,
> +				"getpwent() failed");
> +		} else {
> +			tst_brk_(file, lineno, TBROK,
> +				"getpwent() failed: end of file");
> +		}

I'm not sure if "no more users in the /etc/passwd" should be reported as
an error.

-- 
Cyril Hrubis
chrubis@suse.cz
