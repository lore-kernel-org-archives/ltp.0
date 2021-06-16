From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Jun 2021 11:57:38 +0200
Subject: [LTP] [RFC PATCH 2/3] lib: Add $LTPROOT/testcases/bin into PATH
In-Reply-To: <20210615163307.10755-3-pvorel@suse.cz>
References: <20210615163307.10755-1-pvorel@suse.cz>
 <20210615163307.10755-3-pvorel@suse.cz>
Message-ID: <YMnLEjDAVQqwH7Wq@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 36a4809c7..14a739eb5 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1149,15 +1149,31 @@ static unsigned long long get_time_ms(void)
>  static void add_paths(void)
>  {
>  	char *old_path = getenv("PATH");
> +	const char *ltproot = getenv("LTPROOT");
>  	const char *start_dir;
> -	char *new_path;
> +	char *bin_dir, *new_path = NULL;
>  
>  	start_dir = tst_get_startwd();
>  
> +	/* : - current directory */
>  	if (old_path)
> -		SAFE_ASPRINTF(&new_path, "%s::%s", old_path, start_dir);
> +		SAFE_ASPRINTF(&new_path, "%s:", old_path);
>  	else
> -		SAFE_ASPRINTF(&new_path, "::%s", start_dir);
> +		strcat(new_path, ":");

I personally think that strcat() function is broken be desing and that
we should avoid using it.

Also in this place is guaranteed SEGFAULT since you strcat() to NULL.

> +	/* empty for library C API tests */
> +	if (strlen(start_dir) > 0)
> +		SAFE_ASPRINTF(&new_path, "%s:%s", new_path, start_dir);
                                ^
				This is a memory leak.

As far as I can tell the asprintf() does not free th strp if non-NULL.

> +	if (ltproot) {
> +		SAFE_ASPRINTF(&bin_dir, "%s/testcases/bin", ltproot);
> +
> +		if (access(bin_dir, F_OK) == -1)
> +			tst_res(TWARN, "'%s' does not exist, is $LTPROOT set correctly?",
> +				bin_dir);
> +		else
> +			SAFE_ASPRINTF(&new_path, "%s:%s", new_path, bin_dir);
                                          ^
					  And this as well.
> +	}

I guess that we can also fairly simplify the code by expecting that PATH
is never unset from the start, maybe we should just check it and WARN if
it's not. Also we can assume that if LTPROOT is set we do not have to
add the start_dir since the start_dir is only useful when tests are
executed from the git checkout.

Something as:

	const char *old_path = getenv("PATH");
	const char *ltproot = getenv("LTPROOT");
	const char *start_dir = tst_get_startwd();
	char *new_path;

	if (!old_path) {
		tst_res(TWARN, "\$PATH not set!");
		return;
	}

	if (ltproot)
		SAFE_ASPRINTF(&new_path, "%s::%s/testcases/bin/", old_path, ltproot);
	else
		SAFE_ASPRINTF(&new_path, "%s::%s", old_path, start_dir);


>  	SAFE_SETENV("PATH", new_path, 1);
>  	free(new_path);
> -- 
> 2.32.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
