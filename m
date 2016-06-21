From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 21 Jun 2016 03:00:29 -0400 (EDT)
Subject: [LTP] [PATCH] mem/lib: Keep KSM off when child_alloc() allocate
 memory in single thread
In-Reply-To: <1466480392-25837-1-git-send-email-liwang@redhat.com>
References: <1466480392-25837-1-git-send-email-liwang@redhat.com>
Message-ID: <1793371138.555301.1466492429338.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: jstancek@redhat.com
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 21 June, 2016 5:39:52 AM
> Subject: [PATCH] mem/lib: Keep KSM off when child_alloc() allocate memory in single thread

The single thread is not important here, it's how much that allocation
contributes to limit_in_bytes. oom01 on 2 CPU system will do all
allocations in single thread and KSM won't be turned off.

> 
> We occasionally catch errors like:
> oom03       0  TINFO  :  start OOM testing for KSM pages.
> oom03       0  TINFO  :  expected victim is 3490.
> oom03       6  TFAIL  :  mem.c:163: victim unexpectedly ended with retcode:
> 0, expected: 12
> oom03       0  TINFO  :  set overcommit_memory to 0
> 
> It cames from the caller testoom(0, 1, ENOMEM, 1). The issue was occurred
> because child_alloc() go into single(lite == 1) thread mode but successfully
> finish the memory allocation and return 0. A probably reason is that KSM
> scan merged same pages and disturbed the OOM test in cgroup.
> 
> In this patch, keep KSM scan off to prevent OOM test in cgroup distrubing.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/mem/lib/mem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 3d853a3..b43b7f8 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -230,7 +230,9 @@ void testoom(int mempolicy, int lite, int retcode, int
> allow_sigkill)
>  	} else {
>  		tst_resm(TINFO, "start OOM testing for KSM pages.");
>  		SAFE_FILE_SCANF(cleanup, PATH_KSM "run", "%d", &ksm_run_orig);
> -		SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
> +		/* Let KSM off if lite == 1, since limit_in_bytes may vary from
> +		 * run to run, which isn't reliable for oom03 cgroup test.*/
> +		if (!lite) SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
>  		oom(KSM, lite, retcode, allow_sigkill);
>  		SAFE_FILE_PRINTF(cleanup,PATH_KSM "run", "%d", ksm_run_orig);
>  	}

What if KSM was enabled before test started?

I'd skip this entire else block if lite == 1. With KSM off, it's nearly
identical to oom(NORMAL).

Regards,
Jan
