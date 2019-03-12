From: Michael Holzheu <holzheu@linux.ibm.com>
Date: Tue, 12 Mar 2019 13:54:23 +0100
Subject: [LTP] [PATCH RFC] perf_event_open02: check if
 PERF_COUNT_HW_INSTRUCTIONS is supported
In-Reply-To: <20190312053236.10172-1-liwang@redhat.com>
References: <20190312053236.10172-1-liwang@redhat.com>
Message-ID: <20190312135423.55451d38@TP-holzheu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Looks good to me.

Reviewed-by: Michael Holzheu <holzheu@linux.ibm.com>

Am Tue, 12 Mar 2019 13:32:36 +0800
schrieb Li Wang <liwang@redhat.com>:

> The testcase is broken on system with PERF_COUNT_HW_INSTRUCTIONS not supported.
> Previously, it does the event check in count_hardware_counters, but that has
> been filtered out on s390 platform via commit 6730475ba5. So now test break
> as follow:
>   perf_event_open02    1  TBROK  :  perf_event_open02.c:275: perf_event_open failed: errno=ENOENT(2): No such file or directory
>   perf_event_open02    2  TBROK  :  perf_event_open02.c:275: Remaining cases broken
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  .../perf_event_open/perf_event_open02.c         | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
> index cdaa5c80c..95e30519f 100644
> --- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
> +++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
> @@ -268,9 +268,20 @@ static void setup(void)
>  		tsk_event.disabled = 0;
>  		for (i = 0; i < n; ++i) {
>  			hwfd[i] = perf_event_open(&hw_event, 0, -1, -1, 0);
> -			tskfd[i] = perf_event_open(&tsk_event, 0, -1,
> -						   hwfd[i], 0);
> -			if (tskfd[i] == -1 || hwfd[i] == -1) {
> +			if (hwfd[i] == -1) {
> +				if (errno == ENOENT || errno == ENODEV) {
> +					tst_brkm(TCONF | TERRNO, cleanup,
> +						"PERF_COUNT_HW_INSTRUCTIONS not supported");
> +				}
> +				tst_brkm(TBROK | TERRNO, cleanup,
> +					 "perf_event_open failed");
> +			}
> +			tskfd[i] = perf_event_open(&tsk_event, 0, -1, hwfd[i], 0);
> +			if (tskfd[i] == -1) {
> +				if (errno == ENOENT || errno == ENODEV) {
> +					tst_brkm(TCONF | TERRNO, cleanup,
> +						"PERF_COUNT_SW_TASK_CLOCK not supported");
> +				}
>  				tst_brkm(TBROK | TERRNO, cleanup,
>  					 "perf_event_open failed");
>  			}

