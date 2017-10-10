From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Oct 2017 17:18:52 +0200
Subject: [LTP] [PATCH 4/6] lib: extend PATH as part of test setup
In-Reply-To: <fe40d9a0263afff913c646a6bc1fad88e0ce9747.1507647255.git.jstancek@redhat.com>
References: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
 <fe40d9a0263afff913c646a6bc1fad88e0ce9747.1507647255.git.jstancek@redhat.com>
Message-ID: <20171010151852.GA12028@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void add_paths(void)
> +{
> +	char *old_path = getenv("PATH");
> +	const char *start_dir;
> +	char *new_path;
> +	int new_path_size;
> +
> +	start_dir = tst_get_startwd();
> +
> +	/* ".:" + "$start_dir" + '\0' */
> +	new_path_size = 2 + strlen(start_dir) + 1;
> +	if (old_path)
> +		/* ":" + "$old_path" */
> +		new_path_size += 1 + strlen(old_path);
> +
> +	new_path = SAFE_MALLOC(new_path_size);
> +	strcpy(new_path, ".:");
> +	strcat(new_path, start_dir);
> +
> +	if (old_path) {
> +		strcat(new_path, ":");
> +		strcat(new_path, old_path);
> +	}

I do not like the strcat() function much, I would have probably handled
these with asprintf();

	if (old_path)
		SAFE_ASPRINTF(&new_path, "%s::%s", old_path, start_dir);
	else
		SAFE_ASPRINTF(&new_path, "::%s", start_dir);


The rest of the patchset looks good.

BTW, we should also drop the note about setting $PATH from the
documentation once this is merged.

> +	SAFE_SETENV("PATH", new_path, 1);
> +	free(new_path);
> +}
> +
>  static void testrun(void)
>  {
>  	unsigned int i = 0;
>  	unsigned long long stop_time = 0;
>  	int cont = 1;
>  
> +	add_paths();
>  	do_test_setup();
>  
>  	if (duration > 0)
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
