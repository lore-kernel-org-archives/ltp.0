From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 15 Oct 2019 11:08:36 -0400 (EDT)
Subject: [LTP] [PATCH] open_posix/timer_getoverrun/2-3: Fix test for
 systems with low timer precision
In-Reply-To: <20191011053134.18416-1-lkml@jv-coder.de>
References: <20191011053134.18416-1-lkml@jv-coder.de>
Message-ID: <2097000229.6302768.1571152116580.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> 

Hi,

> On systems with low timer precision the test always fails, because the
> allowed
> maximum number of overruns is calculated from the expected overruns + 10%.

Did you mean 1% here?
  fudge = expectedoverruns / 100;

> If the expected overruns is less than 200, there is no tollerance.
> This happens, if the precision of the timer is less than or equal to 4ms.
> E.g. qemu-arm64 without high resolution timer the accuracy is only 4ms.

Would tweaking tolerance work too? E.g. use float, round up.

> 
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> ---
>  .../conformance/interfaces/timer_getoverrun/2-3.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
> b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
> index 96b7d01e6..3df3a9f01 100644
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/timer_getoverrun/2-3.c
> @@ -55,6 +55,7 @@ int main(void)
>  	int overruns;
>  	int valuensec, intervalnsec, expectedoverruns;
>  	int fudge;
> +	int duration;
>  
>  	if (sigemptyset(&set) != 0) {
>  		perror("sigemptyset() did not return success\n");
> @@ -94,11 +95,15 @@ int main(void)
>  
>  	valuensec = tsres.tv_nsec;
>  	intervalnsec = 2 * valuensec;
> -	//expectedoverruns = (1000000000 - valuensec) / intervalnsec;
> -	expectedoverruns = 1000000000 / intervalnsec - 1;
> +	expectedoverruns = 0;
> +	duration = 0;
> +	while (expectedoverruns < 1000) {
> +		duration++;
> +		expectedoverruns = duration * (1000000000 / intervalnsec - 1);

I was assuming -1 in original code is to cope with final timer expiration of tssleep.tv_sec,
which might not be counted as "overrun". What does the -1 do in your formula?
Why is it inside brackets?

When I try to force different interval values, it fails for me (on x86):
3ms
# ./timer_getoverrun_2-3.run-test 
duration = 7 sec, interval = 6000000 nsec, expected overruns = 1155
1166 overruns occurred
FAIL:  1166 overruns sent; expected 1155

5ms
# ./timer_getoverrun_2-3.run-test 
duration = 11 sec, interval = 10000000 nsec, expected overruns = 1089
1100 overruns occurred
FAIL:  1100 overruns sent; expected 1089

Regards,
Jan
