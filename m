Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <guijianfeng@cn.fujitsu.com>) id 1PFJ2a-0004cl-N4
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 04:09:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFJ2Y-0008JQ-GS
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 04:09:08 +0000
Message-ID: <4CD777DE.7040302@cn.fujitsu.com>
Date: Mon, 08 Nov 2010 12:09:02 +0800
From: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
MIME-Version: 1.0
References: <4CCA33F8.6020104@cn.fujitsu.com>
In-Reply-To: <4CCA33F8.6020104@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] open_posix_testsuite: Don't use clock_settime()
 to reset a CPU-time Clock
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Gui Jianfeng wrote:
> This case is trying to set CPU-time clock(ID is returned by clock_getcpuclockid()) of
> a specific process by calling clock_settime(). But Linux kernel doesn't allow to reset
> a CPU-time clock of a specific process. Kernel returns -EPERM. So test fails.
> 
> In "IEEE Std 1003.1, 2004 Edition", It's said as following:
> If _POSIX_CPUTIME is defined, implementations shall support clock ID values obtained by
> invoking clock_getcpuclockid(), which represent the CPU-time clock of a given process.
> Implementations shall also support the special clockid_t value CLOCK_PROCESS_CPUTIME_ID,
> which represents the CPU-time clock of the calling process when invoking one of the 
> clock_*() or timer_*() functions. For these clock IDs, the values returned by 
> clock_gettime() and specified by clock_settime() represent the amount of execution time
> of the process associated with the clock. Changing the value of a CPU-time clock via
> clock_settime() shall have no effect on the behavior of the sporadic server scheduling
> policy. 
> 
> So the behaviour when changing the value of a CPU-time clock via clock_settime() is
> operating system specific. 
> 
> We may change the test progress to stop using clock_settime(). Now, We just make use
> of clock_gettime() instead to achieve the same test purpose.
> 
> Signed-off-by: Gui Jianfeng <guijianfeng@cn.fujitsu.com>

Hi Garrett,

How do you think this fix?

Gui

> ---
>  .../interfaces/clock_getcpuclockid/2-1.c           |   67 ++++++++++----------
>  1 files changed, 33 insertions(+), 34 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/2-1.c
> index edeb397..52240df 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/2-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_getcpuclockid/2-1.c
> @@ -23,48 +23,47 @@ int main(int argc, char *argv[])
>          printf("_POSIX_CPUTIME unsupported\n");
>          return PTS_UNSUPPORTED;
>  #else
> -	unsigned long time_to_set;	
>  	clockid_t clockid_1, clockid_2;
>  	struct timespec tp1, tp2;
> +	int i;
>  
>  	if (sysconf(_SC_CPUTIME) == -1) {
>  		printf("_POSIX_CPUTIME unsupported\n");
>  		return PTS_UNSUPPORTED;
>  	}
>  
> -	if (clock_getcpuclockid(getpid(), &clockid_1) != 0) {
> -		printf("clock_getcpuclockid(getpid(), ) failed\n");
> -		return PTS_FAIL;
> -	}
> -	
> -	if (clock_getcpuclockid(0, &clockid_2) != 0) {
> -		printf("clock_getcpuclockid(0, ) failed\n");
> -		return PTS_FAIL;
> -	}
> +        for (i = 0; i < 10; i++) {
> +                if (clock_getcpuclockid(getpid(), &clockid_1) != 0) {
> +                        printf("clock_getcpuclockid(getpid(), ) failed\n");
> +                        return PTS_FAIL;
> +                }
>  
> -	/* Set clockid_1 as a random value from 1 sec to 10 sec */
> -	srand((unsigned long)time(NULL));
> -	time_to_set = rand() * 10.0 / RAND_MAX + 1;
> -	tp1.tv_sec = time_to_set;
> -	tp1.tv_nsec = 0;	 
> -	if (clock_settime(clockid_1, &tp1) != 0) {
> -		printf("clock_getcpuclockid() returned an invalid clockid_t: "
> -			"%d\n", clockid_1);
> -		return PTS_FAIL;
> -	}
> -	/* Get the time of clockid_2, should almost the same as clockid_1 */
> -	if (clock_gettime(clockid_2, &tp2) != 0) {
> -		printf("clock_getcpuclockid() returned an invalid clockid_t: "
> -			"%d\n", clockid_2);
> -		return PTS_FAIL;
> -	}
> -	if (tp1.tv_sec == tp2.tv_sec)	
> -	{
> -		printf("Test PASSED\n");
> -		return PTS_PASS;
> -	}
> -	printf("Test FAILED\n");
> -	return PTS_FAIL;
> -	
> +                if (clock_getcpuclockid(0, &clockid_2) != 0) {
> +                        printf("clock_getcpuclockid(0, ) failed\n");
> +                        return PTS_FAIL;
> +                }
> +
> +                /* Get the time of clockid_1 */
> +                if (clock_gettime(clockid_1, &tp1) != 0) {
> +                        printf("clock_getcpuclockid() returned an invalid clockid_t: "
> +                               "%d\n", clockid_1);
> +                        return PTS_FAIL;
> +                }
> +
> +                /* Get the time of clockid_2, should almost the same as clockid_1 */
> +                if (clock_gettime(clockid_2, &tp2) != 0) {
> +                        printf("clock_getcpuclockid() returned an invalid clockid_t: "
> +                               "%d\n", clockid_2);
> +                        return PTS_FAIL;
> +                }
> +
> +                if (tp1.tv_sec != tp2.tv_sec) {
> +                        printf("Test FAILED\n");
> +                        return PTS_FAIL;
> +                }
> +        }
> +
> +        printf("Test PASSED\n");
> +        return PTS_PASS;
>  #endif
>  }

------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
