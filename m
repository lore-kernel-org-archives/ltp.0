From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 18 Mar 2020 18:00:50 +0800
Subject: [LTP] [PATCH] openposix/twoptimers.c: Use other signal instead
 of SIGALRM
In-Reply-To: <1584523008-27044-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1584523008-27044-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5E71F152.5010909@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/3/18 17:16, Yang Xu wrote:
> Currently, run this case failed as below:
>
> Got it!  Child
> Alarm clock
>
> Parent process doesn't get SIGALRM siganl by using sigwait. It
> seems SIGALRM siganl is handled by system but not user.
>
>> From timer_create man-page, it said "
> Specifying  sevp as NULL is equivalent to specifying a pointer to
> a sigevent structure in which sigev_notify is SIGEV_SIGNAL, sigev_signo
> is SIGALRM, and sigev_value.sival_int is the timer ID".
>
> I think this is the reason. So use SIGILL signal to avoid system caught.
Hi Xu,

I don't like the fix.  You don't figure out the root cause of issue and 
just bypass it.(User can catch SIGALRM by default usually).

Perhaps, you need to reset the behavior of SIGALRM to default if it is 
not default.

Thanks,
Xiao Yang
> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> ---
>   .../functional/timers/timers/twoptimers.c                     | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c b/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c
> index 84bea3f0a..7e1648d5b 100644
> --- a/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c
> +++ b/testcases/open_posix_testsuite/functional/timers/timers/twoptimers.c
> @@ -92,13 +92,13 @@ int main(int argc, char *argv[])
>   			return PTS_UNRESOLVED;
>   		}
>
> -		if (sigaddset(&set, SIGALRM) == -1) {
> +		if (sigaddset(&set, SIGILL) == -1) {
>   			perror("sigaddset() failed\n");
>   			return PTS_UNRESOLVED;
>   		}
>
>   		ev.sigev_notify = SIGEV_SIGNAL;
> -		ev.sigev_signo = SIGALRM;
> +		ev.sigev_signo = SIGILL;
>   		if (timer_create(CLOCK_REALTIME,&ev,&tid) != 0) {
>   			perror("timer_create() did not return success\n");
>   			return PTS_UNRESOLVED;



