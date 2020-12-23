From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 23 Dec 2020 16:20:01 +0800
Subject: [LTP] [PATCH 1/3] Add SAFE_SEMCTL() and SAFE_SEMGET() macro
In-Reply-To: <1608626908-8117-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1608626908-8117-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <5FE2FDB1.9090402@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Feiyu
> +int safe_semctl(const char *file, const int lineno, int semid, int semnum,
> +		int cmd, ...)
> +{
> +	int rval;
> +	va_list va;
> +	union semun un;
> +
> +	va_start(va, cmd);
> +
> +	un = va_arg(va, union semun);
> +
> +	va_end(va);
> +
> +	rval = semctl(semid, semnum, cmd, un);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +		"semctl(%i, %i, %i,...) failed", semid, semnum, cmd);
> +	} else if (ret_check(cmd, rval)) {
It looks good to me,
Reviewed-by:Yang Xu <xuyang2018.jy@cn.fujitsucom.com>


BTW, we can add some cmds in ret_check function in separate patch.
 From semctl man-pages, it looks like  SETALL/SETVAL  also return 0 on 
success. Also for shmctl man-pages, SHM_LOCK/SHM_UNLOCK also return 0 on 
success. When we write these new cases in future, these cmds should be 
added into ret_check function.

Best Regards
Yang Xu
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid semctl(%i, %i, %i,...) return value %d", semid,
> +			semnum, cmd, rval);
> +	}
> +
> +	return rval;
> +}
> --



