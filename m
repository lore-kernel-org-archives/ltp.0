From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 6 Nov 2020 13:57:48 +0100
Subject: [LTP] [PATCH 19/19] Unify error handling in
 include/lapi/safe_rt_signal.h
In-Reply-To: <20201026164756.30556-20-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-20-mdoucha@suse.cz>
Message-ID: <20201106125748.GB30097@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (ret == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"ltp_rt_sigaction(%i, %p, %p, %zu) failed",
> +			signum, act, oact, sigsetsize);
> +	} else if (ret) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid ltp_rt_sigaction(%i, %p, %p, %zu) return "
> +			"value %d", signum, act, oact, sigsetsize, ret);

The LKML coding style prefers not to break strings even if they are over
80 characters.

-- 
Cyril Hrubis
chrubis@suse.cz
