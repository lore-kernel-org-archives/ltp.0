Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YFjSX-0000aI-TE
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 13:12:05 +0000
Date: Mon, 26 Jan 2015 14:11:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150126131103.GB25601@rei.suse.de>
References: <20150120114329.GA11013@rei>
	<1422267333-22808-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1422267333-22808-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] tst_module: introduce a timeout to unload
 modules
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
>  /*
> + * Check if the module is loaded.
> + *
> + * @mod_name: the module's name or file name
> + *
> + * Returns 1 if the module is loaded, 0 - if it's not.
> + *
> + * In case of failure calls cleanup_fn and exits with TBROK.
> + */
> +int tst_module_is_loaded(void (cleanup_fn)(void), const char *mod_name);
> +
> +/*
>   * Load a module using insmod program.
>   *
>   * @mod_name: module's file name.
> diff --git a/lib/tst_module.c b/lib/tst_module.c
> index 8104582..49c9bd0 100644
> --- a/lib/tst_module.c
> +++ b/lib/tst_module.c
> @@ -74,6 +74,59 @@ void tst_module_exists(void (cleanup_fn)(void),
>  		free(buf);
>  }
>  
> +int tst_module_is_loaded(void (cleanup_fn)(void),
> +			 const char *mod_name)
> +{
> +	FILE *f;
> +	char *pos;
> +	char mod_name_can[64];
> +	char mod_name_read[64];
> +	char buf[128];
> +	int ret = 0;
> +
> +	if (strlen(mod_name) + 1 > sizeof(mod_name_can))
> +		tst_brkm(TBROK, cleanup_fn, "Too long module name: '%s'",
> +			mod_name);
> +
> +	/*
> +	 * modify the module name to compare with names in /proc/modules
> +	 */
> +	strcpy(mod_name_can, mod_name);
> +
> +	pos = strstr(mod_name_can, ".ko");
> +	if (pos != NULL)
> +		*pos = '\0';
> +
> +	pos = mod_name_can;
> +	while (*pos) {
> +		if (*pos == '-')
> +			*pos = '_';
> +		pos++;
> +	}
> +
> +	f = fopen("/proc/modules", "r");
> +	if (f == NULL)
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			 "Failed to open /proc/modules at %s:%d",
> +			 __FILE__, __LINE__);
> +
> +	while (fgets(buf, sizeof(buf), f) != NULL) {
> +		if (sscanf(buf, "%63s", mod_name_read) != 1) {
> +			fclose(f);
> +			tst_brkm(TBROK | TERRNO, cleanup_fn,
> +				 "Failed to parse /proc/modules at %s:%d",
> +				 __FILE__, __LINE__);
> +		}
> +
> +		if (!strcmp(mod_name_can, mod_name_read)) {
> +			ret = 1;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  void tst_module_load(void (cleanup_fn)(void),
>  	const char *mod_name, char *const argv[])
>  {
> @@ -100,6 +153,21 @@ void tst_module_load(void (cleanup_fn)(void),
>  
>  void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
>  {
> +	int i;
> +	int loaded;
> +
>  	const char *const argv[] = { "rmmod", mod_name, NULL };
> -	tst_run_cmd(cleanup_fn, argv, NULL, NULL, 0);
> +
> +	loaded = 1;
> +	for (i = 0; i < 50; i++) {
> +		tst_run_cmd(NULL, argv, "/dev/null", "/dev/null", 1);

Can we trust the return value from the rrmod? Because if it's correctly
propagated we can simplify this loop to just checking the return value
here.

> +		loaded = tst_module_is_loaded(cleanup_fn, mod_name);
> +		if (!loaded)
> +			break;

What about adding usleep(20000) here? Because otherwise this is bussy
loop that does not give much chances to other processes to run (on a
single CPU machine).

> +	}
> +
> +	if (loaded)
> +		tst_brkm(TBROK, cleanup_fn,
> +			 "could not unload %s module", mod_name);
>  }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
