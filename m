From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Aug 2021 16:43:03 +0200
Subject: [LTP] [PATCH 6/7] syscalls/clone06: Convert to new API
In-Reply-To: <20210813072720.22318-1-zhanglianjie@uniontech.com>
References: <20210813072720.22318-1-zhanglianjie@uniontech.com>
Message-ID: <YSZW978RDyWd2UcY@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (!TST_PASS)
> +		return;
> +
> +	SAFE_CLOSE(pfd[1]);
> +	SAFE_READ(1, pfd[0], buff, sizeof(buff));
> +	SAFE_CLOSE(pfd[0]);
> 
> -	cleanup();
> -	tst_exit();
> +	parent_env = getenv("TERM") ? : "";
> +	TST_EXP_PASS(strcmp(buff, parent_env),
> +				"verify environment variables by child");

This is misuse as well. I guess TST_EXP_VAL() could be useable in this
case as well.

>  }
> 
>  static void setup(void)
>  {
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
> +	SAFE_PIPE(pfd);

Here as well it would be easier to use a shared memory as IPC.

-- 
Cyril Hrubis
chrubis@suse.cz
