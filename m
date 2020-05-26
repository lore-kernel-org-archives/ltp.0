From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 26 May 2020 21:43:20 +0800
Subject: [LTP] [PATCH v2] lib/tst_test.c: Take account of
 tst_brk(TCONF/TFAIL) in summary output
In-Reply-To: <20200522014007.3108-1-yangx.jy@cn.fujitsu.com>
References: <5EC48FCD.9050600@cn.fujitsu.com>
 <20200522014007.3108-1-yangx.jy@cn.fujitsu.com>
Message-ID: <5ECD1CF8.5010607@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I want to push it tomorrow if nobody has any objection.

Thanks,
Xiao Yang
On 2020/5/22 9:40, Xiao Yang wrote:
> Current summary output doesn't take account of tst_brk(TCONF/TFAIL),
> for example:
> -----------------------------------------------------
> [root@Fedora-30  pidfd_send_signal]# ./pidfd_send_signal01
> tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
> ../../../../include/lapi/pidfd_send_signal.h:16: CONF: syscall(424) __NR_pidfd_send_signal not supported
> 
> Summary:
> passed   0
> failed   0
> skipped  0
> warnings 0
> ----------------------------------------------------
> 
> 1) Add update_result() in tst_vbrk_() to fix the issue.
> 2) Remove redundant update_result() in run_tcases_per_fs() after the fix.
> 
> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> ---
>   lib/tst_test.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 0e58060e0..e93c88ba5 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -316,6 +316,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
>                  const char *fmt, va_list va)
>   {
>   	print_result(file, lineno, ttype, fmt, va);
> +	update_results(TTYPE_RESULT(ttype));
> 
>   	/*
>   	 * The getpid implementation in some C library versions may cause cloned
> @@ -1316,10 +1317,8 @@ static int run_tcases_per_fs(void)
>   			mntpoint_mounted = 0;
>   		}
> 
> -		if (ret == TCONF) {
> -			update_results(ret);
> +		if (ret == TCONF)
>   			continue;
> -		}
> 
>   		if (ret == 0)
>   			continue;



