From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Mar 2020 13:40:41 +0200
Subject: [LTP] [PATCH 4/6] lib/tst_run_cmd_*(): Search for program in
 $PATH
In-Reply-To: <20200327213924.18816-5-pvorel@suse.cz>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <20200327213924.18816-5-pvorel@suse.cz>
Message-ID: <20200330114041.GF9845@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	/* exit with TCONF if program is not in path */
> +	TST_RUN_CMD_CHECK_CMD = 2,

Shouldn't be this rather called TST_CMD_TCONF_ON_MISSING?

>  };
>  
>  /*
> diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
> index 3536ec494..0494c6083 100644
> --- a/lib/tst_run_cmd.c
> +++ b/lib/tst_run_cmd.c
> @@ -56,6 +56,17 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
>  	 */
>  	void *old_handler = signal(SIGCHLD, SIG_DFL);
>  
> +	const char *cmd;
> +	char path[PATH_MAX];
> +
> +	if (tst_get_path(argv[0], path, sizeof(path))) {
> +		if (flags & TST_RUN_CMD_CHECK_CMD)
> +			tst_brkm(TCONF, "Couldn't find '%s' in $PATH at %s:%d", argv[0],
> +				 __FILE__, __LINE__);
> +		else
> +			_exit(255);
> +	}
> +
>  	pid_t pid = vfork();
>  	if (pid == -1) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn, "vfork failed at %s:%d",
> @@ -74,10 +85,7 @@ int tst_run_cmd_fds_(void (cleanup_fn)(void),
>  			dup2(stderr_fd, STDERR_FILENO);
>  		}
>  
> -		if (execvp(argv[0], (char *const *)argv)) {
> -			if (errno == ENOENT)
> -				_exit(255);
> -		}
> +		execvp(argv[0], (char *const *)argv);
>  		_exit(254);
>  	}
>  
> -- 
> 2.25.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
