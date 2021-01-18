From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Jan 2021 18:50:31 +0800
Subject: [LTP] [PATCH 1/1] swapping01: make test more robust
In-Reply-To: <20210115143246.369676-1-egorenar@linux.ibm.com>
References: <20210115143246.369676-1-egorenar@linux.ibm.com>
Message-ID: <CAEemH2dbTz0Q7KXw9saO8O12RAEA8kQQjt9AWKf4QwP2Z1x5DQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jan 15, 2021 at 10:33 PM Alexander Egorenkov <egorenar@linux.ibm.com>
wrote:

> Increase time waiting for swap memory to settle before
> performing checks with occupied swap memory. This decreases the chance
> of the test to fail in the case of the swap memory taking longer
> than expected to settle.
>
> This fixes sporadic failures observed on IBM s390x systems such as this:
>
> swapping01.c:149: TPASS: no heavy swapping detected, 4534 MB swapped.
> swapping01.c:106: TINFO: available physical memory: 7348 MB
> swapping01.c:109: TINFO: try to allocate: 9552 MB
> swapping01.c:112: TINFO: memory allocated: 9552 MB
> swapping01.c:140: TINFO: swap free init: 25019 MB
> swapping01.c:141: TINFO: swap free now: 20484 MB
> swapping01.c:149: TPASS: no heavy swapping detected, 4534 MB swapped.
> swapping01.c:106: TINFO: available physical memory: 7348 MB
> swapping01.c:109: TINFO: try to allocate: 9553 MB
> swapping01.c:112: TINFO: memory allocated: 9553 MB
> swapping01.c:140: TINFO: swap free init: 25018 MB
> swapping01.c:141: TINFO: swap free now: 17694 MB
> swapping01.c:149: TPASS: no heavy swapping detected, 7323 MB swapped.
> swapping01.c:106: TINFO: available physical memory: 7318 MB
> swapping01.c:109: TINFO: try to allocate: 9514 MB
> swapping01.c:112: TINFO: memory allocated: 9514 MB
> swapping01.c:140: TINFO: swap free init: 25019 MB
> swapping01.c:141: TINFO: swap free now: 17697 MB
> swapping01.c:145: TFAIL: heavy swapping detected: 7322 MB swapped.
>
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>  testcases/kernel/mem/swapping/swapping01.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/mem/swapping/swapping01.c
> b/testcases/kernel/mem/swapping/swapping01.c
> index 24b8313f3..befb52e91 100644
> --- a/testcases/kernel/mem/swapping/swapping01.c
> +++ b/testcases/kernel/mem/swapping/swapping01.c
> @@ -127,10 +127,10 @@ static void check_swapping(void)
>
>         /* Still occupying memory, loop for a while */
>         i = 0;
> -       while (i < 10) {
> +       while (i < 30) {
>                 swap_free_now = SAFE_READ_MEMINFO("SwapFree:");
>                 sleep(1);
> -               if (labs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:")) <
> 512)
> +               if (labs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:")) <
> 10)
>

From test error above, if the system's swap-memory taking longer
than expected to settle, shouldn't we more even get a swapped
consumption (=swap_free_init - swap_free_now) less than mem_over_max?
I say this because am imagining the system's SwapFree keeps
decreasing during the while loop, as you extend the waiting time
then we might get a larger swapped value at the final, which makes
the test more easily to FAIL.

And the purpose is to detect heavy swapping on s390x but not
guarantee running with a purified system, there also possible
other daemons have a side effect on system swaping, so I slightly
suppose dropping caches before testing may be helpful.

Another thing I wondering, do we really need to loop 5 times for this
kind of stress testing? Guess one time is enough for testing.

mm:swapping01 swapping01 -i 5



>                         break;
>
>                 i++;
> --
> 2.26.2
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210118/2ec7fa62/attachment.htm>
