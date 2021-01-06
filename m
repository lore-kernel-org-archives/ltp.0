From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Jan 2021 11:29:35 +0100
Subject: [LTP] [PATCH v2] sched/sched_stress:Fixed param of sched_tc
In-Reply-To: <1602841876-91490-2-git-send-email-luofenglin1@huawei.com>
References: <1602841876-91490-1-git-send-email-luofenglin1@huawei.com>
 <1602841876-91490-2-git-send-email-luofenglin1@huawei.com>
Message-ID: <X/WRDyuFbxDnVLYS@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Rt flag of sched_tc must like "-pfixed" or "-pvariable"
> 
> Signed-off-by: luofenglin <luofenglin1@huawei.com>
> ---
>  .../kernel/sched/sched_stress/sched_driver.c  | 51 ++++++++++---------
>  1 file changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/testcases/kernel/sched/sched_stress/sched_driver.c b/testcases/kernel/sched/sched_stress/sched_driver.c
> index 1bee9d130..475369b46 100644
> --- a/testcases/kernel/sched/sched_stress/sched_driver.c
> +++ b/testcases/kernel/sched/sched_stress/sched_driver.c
> @@ -621,25 +621,28 @@ char *execution_time;		/* runtime hours to pass to each testcase */
>  		printf("long-term slots available:  %d\n",
>  		       long_term_slot_total);
>  
> +	char timeparam[30];
> +	sprintf(timeparam, "-t%s", execution_time);

Why do we need this? It's not explained in the commit message at all.

The other change looks obviously fine.

-- 
Cyril Hrubis
chrubis@suse.cz
