From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Oct 2015 16:29:11 +0100
Subject: [LTP] [PATCH] sched_getattr/sched_getattr01: Use macro
 definitions to replace numbers
In-Reply-To: <1445343078-145058-1-git-send-email-cuibixuan@huawei.com>
References: <1445343078-145058-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <20151026152911.GA6772@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Use 'RUNTIME_VAL','PERIOD_VAL' and 'DEADLINE_VAL' to set attr
> 
> Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
> ---
>  .../syscalls/sched_getattr/sched_getattr01.c       |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
> index 267b8b1..bf6c5b6 100644
> --- a/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
> +++ b/testcases/kernel/syscalls/sched_getattr/sched_getattr01.c
> @@ -38,9 +38,9 @@ void *run_deadline(void *data LTP_ATTRIBUTE_UNUSED)
>  
>  	/* This creates a 10ms/30ms reservation */
>  	attr.sched_policy = SCHED_DEADLINE;
> -	attr.sched_runtime = 10 * 1000 * 1000;
> -	attr.sched_period = 30 * 1000 * 1000;
> -	attr.sched_deadline = 30 * 1000 * 1000;
> +	attr.sched_runtime = RUNTIME_VAL;
> +	attr.sched_period = PERIOD_VAL;
> +	attr.sched_deadline = DEADLINE_VAL;

Looking at the test it also misses GPL header in a comment. Can you
please send a patch that adds it as well?
(sorry for not catching that earlier)

-- 
Cyril Hrubis
chrubis@suse.cz
