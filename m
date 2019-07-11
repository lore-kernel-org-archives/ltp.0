From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Thu, 11 Jul 2019 14:19:22 +0800
Subject: [LTP] [PATCH] getrlimit03: adjust a bit of code to compatiable
 with mips32
In-Reply-To: <1562824657-152321-1-git-send-email-hongzhi.song@windriver.com>
References: <1562824657-152321-1-git-send-email-hongzhi.song@windriver.com>
Message-ID: <feec36ce-028b-50bb-9fde-626eb194dca9@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Commit log is not complete. I will send V2 later.

Please ignore this.

--Hongzhi


On 7/11/19 1:57 PM, Hongzhi.Song wrote:
> Error info:
> getrlimit03.c:104: FAIL: __NR_prlimit64(0) had rlim_cur =
> ffffffffffffffff but __NR_getrlimit(0) had rlim_cur = 7fffffff
>
> According to kernel code: RLIM_INFINITY is set to 0x7fffffffUL
> instead of ULONG_MAX on mips32.
>
> /*
>   * SuS says limits have to be unsigned.
>   * Which makes a ton more sense anyway,
>   * but we keep the old value on MIPS32,
>   * for compatibility:
>   */
>
> Adding mips judgement code to fix this.
>
> Signed-off-by: Hongzhi.Song <hongzhi.song@windriver.com>
> ---
>   testcases/kernel/syscalls/getrlimit/getrlimit03.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
> index e4d56c4..1903558 100644
> --- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
> +++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
> @@ -61,7 +61,13 @@ struct rlimit_ulong {
>   	unsigned long rlim_cur;
>   	unsigned long rlim_max;
>   };
> +#ifdef __mips
> +#ifndef __mips64
> +const unsigned long RLIM_INFINITY_UL = 0x7fffffffUL;
> +#else
>   const unsigned long RLIM_INFINITY_UL = ULONG_MAX;
> +#endif
> +#endif
>   
>   static int getrlimit_ulong(int resource, struct rlimit_ulong *rlim)
>   {
> @@ -101,8 +107,8 @@ static int compare_u64_ulong(int resource, uint64_t val_u64,
>   {
>   	if ((val_u64 > RLIM_INFINITY_UL && val_ul != RLIM_INFINITY_UL) ||
>   	    (val_u64 <= RLIM_INFINITY_UL && val_ul != val_u64)) {
> -		tst_res(TFAIL, "__NR_prlimit64(%d) had %s = %" PRIx64 " but " __NR_getrlimit_ulong_str "(%d) had %s = %lx",
> -			resource, kind, val_u64,
> +		tst_res(TFAIL, "SIGNED_GETRLIMIT = %d __WORDSIZE %d ULONG_MAX = %lu RLIM_INFINITY_UL = %lu __NR_prlimit64(%d) had %s = %" PRIx64 " but " __NR_getrlimit_ulong_str "(%d) had %s = %lx",
> +			SIGNED_GETRLIMIT, __WORDSIZE, ULONG_MAX, RLIM_INFINITY_UL, resource, kind, val_u64,
>   			resource, kind, val_ul);
>   		return -1;
>   	}
