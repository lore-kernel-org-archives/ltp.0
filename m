From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 23 Nov 2015 11:10:50 +0100
Subject: [LTP] mtest01 parent/child process synchronization issue
In-Reply-To: <564CACAF.1080201@redhat.com>
References: <564CACAF.1080201@redhat.com>
Message-ID: <5652E62A.3090403@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/18/2015 05:51 PM, Jiri Vohanka wrote:
> Hello,
> 
> I discovered a problem in mtest01 which causes it to freeze on some occasions.

Hi,

> diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
> index 8c9e81c..06f41d5 100644
> --- a/testcases/kernel/mem/mtest01/mtest01.c
> +++ b/testcases/kernel/mem/mtest01/mtest01.c
> @@ -51,9 +51,12 @@
>  char *TCID = "mtest01";
>  int TST_TOTAL = 1;
>  int pid_count = 0;
> +int oom_count = 0;

both of these should be static

>  
>  void handler(int signo)
>  {
> +	if (signo == SIGCHLD)
> +		oom_count++;
>  	pid_count++;
>  }
>  
> @@ -77,6 +80,7 @@ int main(int argc, char *argv[])
>  	act.sa_flags = 0;
>  	sigemptyset(&act.sa_mask);
>  	sigaction(SIGRTMIN, &act, 0);
> +	sigaction(SIGCHLD, &act, 0);
>  
>  	while ((c = getopt(argc, argv, "c:b:p:wvh")) != -1) {
>  		switch (c) {
> @@ -268,7 +272,7 @@ int main(int argc, char *argv[])
>  
>  			while ((((unsigned long long)pre_mem - post_mem) <
>  				(unsigned long long)original_maxbytes) &&
> -			       pid_count < pid_cntr) {
> +			       pid_count < pid_cntr && !oom_count) {
>  				sleep(1);
>  				sysinfo(&sstats);
>  				post_mem =
> @@ -284,7 +288,9 @@ int main(int argc, char *argv[])
>  			kill(pid_list[i], SIGKILL);
>  			i++;
>  		}
> -		if (dowrite)
> +		if (oom_count)
> +			tst_resm(TFAIL, "the child process was killed");


I wouldn't combine two "if"s into one if else block, the information how
much was allocated could be useful even when we hit OOM.

But mainly, problem here is that ~6 lines above child processes get killed,
so you are racing with SIGCHLD here. I'd suggest to move this TFAIL before
kill() loop.

Regards,
Jan


> +		else if (dowrite)
>  			tst_resm(TPASS, "%llu kbytes allocated and used.",
>  				 original_maxbytes / 1024);
>  		else
> -- 
> 2.4.3


