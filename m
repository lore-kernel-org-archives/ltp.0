From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Aug 2021 17:58:33 +0200
Subject: [LTP] [PATCH v4 3/4] syscalls/msgstress03: fix fork failure on
 small memory systems
In-Reply-To: <20210629121047.100391-4-krzysztof.kozlowski@canonical.com>
References: <20210629121047.100391-1-krzysztof.kozlowski@canonical.com>
 <20210629121047.100391-4-krzysztof.kozlowski@canonical.com>
Message-ID: <YR5/qcQyAiFjmVR0@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	free_pids = tst_get_free_pids(cleanup);
> +	if (free_pids < 0) {
> +		tst_brkm(TBROK, cleanup, "Can't obtain free_pid count");
> +	} else if (!free_pids) {
> +		tst_brkm(TBROK, cleanup, "No free pids");
> +	}

This looks like copy&paste from msgstress04.c, can we please move this
snippet to the library function instead?

> +	if (nprocs >= free_pids) {
> +		tst_resm(TINFO,
> +			 "Requested number of processes higher than limit (%d > %d), "
> +			 "setting to %d", nprocs, free_pids, free_pids);
> +		nprocs = free_pids;
> +	}
> +
>  	srand(getpid());
>  	tid = -1;
>  
> -- 
> 2.27.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
