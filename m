From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 1 Apr 2021 02:24:46 +0000
Subject: [LTP] [PATCH 1/3] tst_safe_sysv_ipc.c: Add SAFE_SEMOP macro
In-Reply-To: <1616497037-19158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1616497037-19158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <60652EFA.4050806@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
Ping.
> From: Yang Xu<xuyang2018.jy@fujitsu.com>
> 
> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> ---
>   include/tst_safe_sysv_ipc.h |  4 ++++
>   lib/tst_safe_sysv_ipc.c     | 18 ++++++++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/include/tst_safe_sysv_ipc.h b/include/tst_safe_sysv_ipc.h
> index bb6532662..7804ce192 100644
> --- a/include/tst_safe_sysv_ipc.h
> +++ b/include/tst_safe_sysv_ipc.h
> @@ -65,4 +65,8 @@ int safe_semctl(const char *file, const int lineno, int semid, int semnum,
>   	(semid) = ((cmd) == IPC_RMID ? -1 : (semid)); \
>   	tst_ret_; })
> 
> +int safe_semop(const char *file, const int lineno, int semid, struct sembuf *sops,
> +		size_t nsops);
> +#define SAFE_SEMOP(semid, sops, nsops) \
> +	safe_semop(__FILE__, __LINE__, (semid), (sops), (nsops))
>   #endif /* TST_SAFE_SYSV_IPC_H__ */
> diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
> index e72985d61..012f5ba38 100644
> --- a/lib/tst_safe_sysv_ipc.c
> +++ b/lib/tst_safe_sysv_ipc.c
> @@ -227,3 +227,21 @@ int safe_semctl(const char *file, const int lineno, int semid, int semnum,
> 
>   	return rval;
>   }
> +
> +int safe_semop(const char *file, const int lineno, int semid, struct sembuf *sops,
> +		size_t nsops)
> +{
> +	int rval;
> +
> +	rval = semop(semid, sops, nsops);
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"semop(%d, %p, %zu) failed", semid, sops, nsops);
> +	} else if (rval<  0) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid semop(%d, %p, %zu) return value %d",
> +			semid, sops, nsops, rval);
> +	}
> +
> +	return rval;
> +}
