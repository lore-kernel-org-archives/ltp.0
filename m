From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 08 Apr 2020 14:21:33 +0200
Subject: [LTP] [PATCH] syscalls/clone301: Fix the test race this time
 for real
In-Reply-To: <20200408114007.4096-1-chrubis@suse.cz>
References: <20200408114007.4096-1-chrubis@suse.cz>
Message-ID: <877dyqyxq4.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> I have messed up the first fix, sorry, the signal handler has to be
> estabilished before the clone3() call, not just before the if ().
>
> This also makes the test more verbose in case of failure, we print what
> exactly went wrong which saves time on debugging.
>
> Fixes: f17b3862dceb (syscalls/clone301: Fix race between parent and child)
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Richard Palethorpe <rpalethorpe@suse.com>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  testcases/kernel/syscalls/clone3/clone301.c | 65 +++++++++++++++------
>  1 file changed, 48 insertions(+), 17 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
> index 456291b67..bf009e940 100644
> --- a/testcases/kernel/syscalls/clone3/clone301.c
> +++ b/testcases/kernel/syscalls/clone3/clone301.c
> @@ -17,7 +17,7 @@
>  #define DATA	777
>  
>  static int pidfd, child_tid, parent_tid, parent_received_signal;
> -static volatile int child_received_signal;
> +static volatile int child_received_signal, child_data;
>  static struct clone_args *args;
>  
>  static struct tcase {
> @@ -40,8 +40,8 @@ static void child_rx_signal(int sig, siginfo_t *info, void *ucontext)
>  {
>  	(void) ucontext;
>  
> -	if (sig == CHILD_SIGNAL && info && info->si_value.sival_int == DATA)
> -		child_received_signal = 1;
> +	child_received_signal = sig;
> +	child_data = info->si_value.sival_int;
>  }
>  
>  static struct sigaction psig_action = {
> @@ -60,23 +60,43 @@ static siginfo_t uinfo = {
>  };
>  
>  
> -static void do_child(int clone_pidfd, int n)
> +static void do_child(int clone_pidfd)
>  {
>  	int count = 1000;
>  
>  	if (clone_pidfd) {
>  		child_received_signal = 0;
> +		child_data = 0;
> +
>  		SAFE_SIGACTION(CHILD_SIGNAL, &csig_action, NULL);
>  
>  		TST_CHECKPOINT_WAKE(0);
>  
> -		while(!child_received_signal && --count)
> +		while (child_received_signal != CHILD_SIGNAL && --count)
>  			usleep(100);

Maybe to be nice, we should use the exponential backoff function?

Although not too important in this case.

Otherwise LGTM!

-- 
Thank you,
Richard.
