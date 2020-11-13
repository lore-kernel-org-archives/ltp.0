From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Nov 2020 16:12:39 +0100
Subject: [LTP] [PATCH v3] syscalls/ptrace11: Add test for tracing init
 process
In-Reply-To: <1605233273-3784-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20201112120505.GA15765@yuki.lan>
 <1605233273-3784-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20201113151239.GB16315@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	/*
> +	 * Running attach/detach more times will trigger a ESRCH error because
> +	 * ptrace_check_attach function in kernel will report it if its process
> +	 * stats is not __TASK_TRACED.
> +	 */
> +	TST_RETRY_FUNC(ptrace(PTRACE_DETACH, 1, NULL, NULL), TST_RETVAL_EQ0);

Why do we have to retry the detach here?

Other than that the rest looks fine now.

-- 
Cyril Hrubis
chrubis@suse.cz
