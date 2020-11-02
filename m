From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 2 Nov 2020 19:45:32 +0800
Subject: [LTP] [PATCH 2/2] syscalls/ptrace08: Add exception for RHEL8
 4.18 kernel
In-Reply-To: <1604317338-22774-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1604317338-22774-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1604317338-22774-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5F9FF15C.8080308@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All
Sorry, please ignore this email.:-[

> RHEL 4.18 kernel got this patch
> commit bd14406b78e6d ("perf/hw_breakpoint: Modify breakpoint even if the new attr has disabled set") since 4.18.0-49,
>
> therefore it will return success instead of EINVAL when modifying breakpoint.
>
> Without this fix, the test will fail on RHEL8 4.18 kernel with:
> tst_kernel.c:79: TINFO: uname.machine=x86_64 kernel is 64bit
> ptrace08.c:90: TINFO: Trying address 0xffff800000000000
> ptrace08.c:116: TFAIL: ptrace() breakpoint with kernel addr succeeded
> ptrace08.c:90: TINFO: Trying address 0xffffffffffffffff
> ptrace08.c:116: TFAIL: ptrace() breakpoint with kernel addr succeeded
> ptrace08.c:90: TINFO: Trying address 0xffffbfffffffffff
> ptrace08.c:116: TFAIL: ptrace() breakpoint with kernel addr succeeded
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/ptrace/ptrace08.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace08.c b/testcases/kernel/syscalls/ptrace/ptrace08.c
> index 63086f1fd..741923e36 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace08.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace08.c
> @@ -56,6 +56,11 @@ static pid_t child_pid;
>  
>  static int deffered_check;
>  
> +static struct tst_kern_exv kvers[] = {
> +	{"RHEL8", "4.18.0-49"},
> +	{NULL, NULL},
> +};
> +
>  static void setup(void)
>  {
>  	/*
> @@ -72,7 +77,7 @@ static void setup(void)
>  	 * disabled instead and the EINVAL was returned when dr7 was written to
>  	 * enable it again.
>  	 */
> -	if (tst_kvercmp(4, 19, 0) < 0)
> +	if (tst_kvercmp2(4, 19, 0, kvers) < 0)
>  		deffered_check = 1;
>  }
>  



