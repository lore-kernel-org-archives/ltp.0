From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 18:28:56 +0100
Subject: [LTP] [PATCH V2 29/32] trace_shed: Fix build with musl
In-Reply-To: <1452302060-103643-29-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-29-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202172856.GS19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
>  testcases/kernel/sched/tool/trace_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/sched/tool/trace_sched.c b/testcases/kernel/sched/tool/trace_sched.c
> index 7815686..30dca5f 100644
> --- a/testcases/kernel/sched/tool/trace_sched.c
> +++ b/testcases/kernel/sched/tool/trace_sched.c
> @@ -422,7 +422,7 @@ int main(int argc,		/* number of input parameters.                        */
>  			if (status == (thread_sched_t *) - 1) {
>  				fprintf(stderr,
>  					"thread [%d] - process exited with errors %d\n",
> -					thrd_ndx, WEXITSTATUS(status));
> +					thrd_ndx, WEXITSTATUS((int)status));

This is just a band aid for broken code. The thread return status is
either -1 or pointer to the table. So there is no point in passing it to
WEXITSTATUS() and priting the value. I suggest to remove it.

-- 
Cyril Hrubis
chrubis@suse.cz
