From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Mar 2016 18:31:26 +0100
Subject: [LTP] [PATCH v3] tst_mkfs: add new parameter extra_opt to
 tst_mkfs function
In-Reply-To: <1457627932-12674-1-git-send-email-zlang@redhat.com>
References: <1457627932-12674-1-git-send-email-zlang@redhat.com>
Message-ID: <20160314173126.GC3364@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 1f260cb..f270526 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -906,15 +906,20 @@ NOTE: The default filesytem is hardcoded to 'ext2' in the sources and can be
>  #include "test.h"
>  
>  void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> -              const char *fs_type, const char *const fs_opts[]);
> +              const char *fs_type, const char *const fs_opts[]
> +              const char *extra_opt);
>  -------------------------------------------------------------------------------
>  
>  This function takes a path to a device, filesystem type and an array of extra
>  options passed to mkfs.
>  
> -The extra options 'fs_opts' should either be 'NULL' if there are none, or a
> +The fs options 'fs_opts' should either be 'NULL' if there are none, or a
>  'NULL' terminated array of strings such as '{"-b", "1024", NULL}'.
>  
> +The extra options 'extra_opt' should either be 'NULL' if there are none, or
               ^
	     option
> +a string such as "102400". 'extra_opt' will be used behind device name. e.g:
                                                   ^      ^
						  passed  after
> +mkfs -t ext4 -b 1024 /dev/sda1 102400
> +
>  2.2.16 Verifying a filesystem's free space
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> diff --git a/include/test.h b/include/test.h
> index 5c78b1d..edd2069 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -316,10 +316,12 @@ int tst_system(const char *command);
>   *
>   * @dev: path to a device
>   * @fs_type: filesystem type
> - * @fs_opts: NULL or NULL terminated array of extra mkfs options
> + * @fs_opts: NULL or NULL terminated array of mkfs options
> + * @extra_opt: extranal mkfs options which need to behind the device name
                    ^             ^           ^^^^^^^^^^^^^^
	          extra?        option        "is passed after"


>   */
>  void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> -	      const char *fs_type, const char *const fs_opts[]);
> +              const char *fs_type, const char *const fs_opts[],
> +              const char *extra_opt);
>  
>  /*
>   * Returns filesystem type to be used for the testing. Unless your test is
> diff --git a/lib/tests/tst_device.c b/lib/tests/tst_device.c
> index 6a7925e..525bdc0 100644
> --- a/lib/tests/tst_device.c
> +++ b/lib/tests/tst_device.c
> @@ -46,7 +46,7 @@ int main(void)
>  
>  	printf("Test device='%s'\n", dev);
>  
> -	tst_mkfs(cleanup, dev, "ext2", NULL);
> +	tst_mkfs(cleanup, dev, "ext2", NULL, NULL);
>  
>  	cleanup();
>  	tst_exit();
> diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> index 5f959a4..3710b4b 100644
> --- a/lib/tst_mkfs.c
> +++ b/lib/tst_mkfs.c
> @@ -21,8 +21,19 @@
>  
>  #define OPTS_MAX 32
>  
> +/*
> + * tst_mkfs: mkfs.$fs_type on $dev with options $fs_opts and $extra_opt
> + *     cleanup_fn - run it when exit with error.
> + *     dev        - device path name
> + *     fs_opts    - store the options for mkfs (except -t fs_type). Set
> + *                  NULL if don't need options.
> + *     extra_opt - extranal mkfs options for mkfs, these options need
                       ^               ^              ^^^^^^^^^^^^^ ^^^^
                      extra?        option            "this option" "is passed"
> + *                  behind the device name, e.g. [fs_size] for ext4.
                       ^^^^^^
		       after

> + *                  Set NULL, if don't need options behind device name.
                                                 ^       ^
					       option   after
> + */
>  void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> -	      const char *fs_type, const char *const fs_opts[])
> +              const char *fs_type, const char *const fs_opts[],
> +              const char *extra_opt)
>  {
>  	int i, pos = 3;
>  	const char *argv[OPTS_MAX] = {"mkfs", "-t", fs_type};
> @@ -68,10 +79,20 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
>  	}
>  
>  	argv[pos++] = dev;
> +
> +	if (extra_opt) {
> +		argv[pos++] = extra_opt;
> +
> +		if (pos + 1 > OPTS_MAX) {
> +			tst_brkm(TBROK, cleanup_fn,
> +			         "Too much mkfs options");
> +		}
> +	}
> +
>  	argv[pos] = NULL;
>  
> -	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",
> -		 dev, fs_type, fs_opts_str);
> +	tst_resm(TINFO, "Formatting %s with %s opts='%s' extra opts='%s'",
> +	         dev, fs_type, fs_opts_str, extra_opt ? extra_opt : "");
>  	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 0);
>  }

...

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
