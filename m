From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 7 Apr 2021 20:27:16 +0300
Subject: [LTP] [PATCH 1/3] tst_safe_sysv_ipc.c: Add SAFE_SEMOP macro
In-Reply-To: <1616497037-19158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1616497037-19158-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <cf081e19-300c-1dc7-69ee-894881613858@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 23.03.2021 13:57, Yang Xu wrote:
> From: Yang Xu <xuyang2018.jy@fujitsu.com>
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  include/tst_safe_sysv_ipc.h |  4 ++++
>  lib/tst_safe_sysv_ipc.c     | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/tst_safe_sysv_ipc.h b/include/tst_safe_sysv_ipc.h
> index bb6532662..7804ce192 100644
> --- a/include/tst_safe_sysv_ipc.h
> +++ b/include/tst_safe_sysv_ipc.h
> @@ -65,4 +65,8 @@ int safe_semctl(const char *file, const int lineno, int semid, int semnum,
>  	(semid) = ((cmd) == IPC_RMID ? -1 : (semid)); \
>  	tst_ret_; })
>  
> +int safe_semop(const char *file, const int lineno, int semid, struct sembuf *sops,
> +		size_t nsops);
> +#define SAFE_SEMOP(semid, sops, nsops) \
> +	safe_semop(__FILE__, __LINE__, (semid), (sops), (nsops))
>  #endif /* TST_SAFE_SYSV_IPC_H__ */
> diff --git a/lib/tst_safe_sysv_ipc.c b/lib/tst_safe_sysv_ipc.c
> index e72985d61..012f5ba38 100644
> --- a/lib/tst_safe_sysv_ipc.c
> +++ b/lib/tst_safe_sysv_ipc.c
> @@ -227,3 +227,21 @@ int safe_semctl(const char *file, const int lineno, int semid, int semnum,
>  
>  	return rval;
>  }
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
> +	} else if (rval < 0) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid semop(%d, %p, %zu) return value %d",
> +			semid, sops, nsops, rval);
> +	}
> +
> +	return rval;
> +}
> 

Reviewed-by: Alexey Kodanev <alexey.kodanev@oracle.com>
