From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 27 Oct 2020 17:10:38 +0800
Subject: [LTP] [PATCH 02/19] Unify error handling in
 lib/tst_safe_sysv_ipc.c
In-Reply-To: <20201026164756.30556-3-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-3-mdoucha@suse.cz>
Message-ID: <5F97E40E.2060201@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin

> @@ -135,10 +163,15 @@ int safe_shmctl(const char *file, const int lineno, int shmid, int cmd,
>   	int rval;
>
>   	rval = shmctl(shmid, cmd, buf);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"shmctl(%i, %i, %p) failed", shmid, cmd, buf);
> +	}
>   	if (ret_check(cmd, rval)) {
Here should use else,  otherwise it will print two lines error because 
tst_brk_ will not exit in cleanup.

Best Regards
Yang Xu
> -		tst_brk(TBROK | TERRNO,
> -			"%s:%d: shmctl(%i, %i, %p) = %i failed",
> -			file, lineno, shmid, cmd, buf, rval);
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid shmctl(%i, %i, %p) return value %d", shmid,
> +			cmd, buf, rval);
>   	}
>
>   	return rval;



