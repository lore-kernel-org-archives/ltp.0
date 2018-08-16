From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Aug 2018 12:59:35 +0200
Subject: [LTP] [PATCH RFC 1/4] lib/tst_test.c: add 'needs_drivers'
 option with tst_check_drivers cmd
In-Reply-To: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
References: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180816105934.GA4829@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 98dacf3..221796d 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -170,6 +170,9 @@ struct tst_test {
>  
>  	/* NULL terminated array of resource file names */
>  	const char *const *resource_files;
> +
> +	/* NULL terminated array of needed kernel drivers */
> +	const char * const *needs_drivers;
>  };
>  
>  /*
> @@ -219,6 +222,8 @@ const char *tst_strstatus(int status);
>  
>  void tst_set_timeout(int timeout);
>  
> +int tst_check_drivers(void);
> +
>  #ifndef TST_NO_DEFAULT_MAIN
>  
>  static struct tst_test test;
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 2f3d357..6cb74cf 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -645,6 +645,29 @@ static int needs_tmpdir(void)
>  	       tst_test->needs_checkpoints;
>  }
>  
> +int tst_check_drivers(void)
> +{
> +	const char *name;
> +	int i, res;
> +
> +	for (i = 0; (name = tst_test->needs_drivers[i]); ++i) {
> +		const char * const argv[] = { "modprobe", name, NULL };
> +
> +		res = tst_run_cmd_(NULL, argv, "/dev/null", "/dev/null", 1);
> +		if (res == 255)
> +			return res; /* it looks like modprobe not available */
> +		if (res) {
> +			if (tst_test->test || tst_test->test_all) {
> +				tst_brk(TCONF, "%s driver not available", name);
> +			} else {
> +				fprintf(stderr, "%s", name);
> +				return res;
> +			}
> +		}
> +	}
> +	return 0;
> +}

I do not like much that we change the behavir based on tst_test content.
Maybe it would be cleaner to define a tst_check_driver(const char *name),
then we can do the loop over tst_test->needs_drivers in the tst_test.c
library and loop over argv in the shell helper.

-- 
Cyril Hrubis
chrubis@suse.cz
