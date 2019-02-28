From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 28 Feb 2019 17:08:59 -0500 (EST)
Subject: [LTP] [RFC PATCH] mm: rewrite mtest01 with new API
In-Reply-To: <20190228074002.14351-1-liwang@redhat.com>
References: <20190228074002.14351-1-liwang@redhat.com>
Message-ID: <646940042.3510845.1551391739985.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

----- Original Message -----
> Test issue:
>    mtest01 start many children to alloc chunck of memory and do write
>    page(with -w option), but occasionally some children were killed by
>    oom-killer and exit with SIGCHLD signal sending. After the parent
>    reciving this SIGCHLD signal it will report FAIL as a test result.
> 
>    It seems not a real kernel bug if something just like that, it's
>    trying to use 80% of memory and swap. Once it uses most of memory,
>    system starts swapping, but the test is likely consuming memory at
>    greater rate than kswapd can provide, which eventually triggers OOM.

This seems to be quite common on ppc systems (64k pages with slow I/O),
so I do welcome fix/rewrite.

> 
>    ---- FAIL LOG ----
>    mtest01     0  TINFO  :  Total memory already used on system = 1027392
>    kbytes
>    mtest01     0  TINFO  :  Total memory used needed to reach maximum =
>    12715520 kbytes
>    mtest01     0  TINFO  :  Filling up 80% of ram which is 11688128 kbytes
>    mtest01     1  TFAIL  :  mtest01.c:314: child process exited unexpectedly
>    -------------------
> 
>  Rewrite changes:
>    To make mtest01 more easier to understand, I just rewrite it into
>    LTP new API and make a little changes in children behavior.
> 
>    * drop the signal SIGCHLD action becasue new API help to
>    check_child_status
>    * make child pause itself after finishing their memory allocating/writing
>    * parent sends SIGCONT to make children continue and exit
>    * decrease the pressure to 50% total ram+swap for testing

Current behaviour varies a lot depending on system. I'm thinking if we should
just set it to 80% of free RAM. We already have number of OOM tests,
so maybe we don't need to worry about memory pressure here too.

> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  runtest/mm                             |   4 +-
>  testcases/kernel/mem/mtest01/mtest01.c | 430 ++++++++++++-------------
>  2 files changed, 204 insertions(+), 230 deletions(-)
> 

<snip>

> +
> +static void mem_test(void)
> +{
> +	int i, pid_cntr;
> +	pid_t pid;
> +	struct sigaction act;
> +
> +	act.sa_handler = handler;
> +	act.sa_flags = 0;
> +	sigemptyset(&act.sa_mask);
> +	sigaction(SIGRTMIN, &act, 0);

I was thinking if we can't "abuse" tst_futexes a bit. It's a piece of
shared memory we already have and could use for an atomic counter.

<snip>

> +	if (pid == 0)
> +		child_loop_alloc();
>  
> -		if (dowrite) {
> -			/* Total Free Post-Test RAM */
> -			post_mem =
> -			    (unsigned long long)sstats.mem_unit *
> -			    sstats.freeram;
> -			post_mem =
> -			    post_mem +
> -			    (unsigned long long)sstats.mem_unit *
> -			    sstats.freeswap;
> -
> -			while ((((unsigned long long)pre_mem - post_mem) <
> -				(unsigned long long)original_maxbytes) &&
> -			       pid_count < pid_cntr && !sigchld_count) {
> -				sleep(1);
> -				sysinfo(&sstats);
> -				post_mem =
> -				    (unsigned long long)sstats.mem_unit *
> -				    sstats.freeram;
> -				post_mem =
> -				    post_mem +
> -				    (unsigned long long)sstats.mem_unit *
> -				    sstats.freeswap;
> -			}
> -		}
> +	/* waits in the loop for all children finish allocating*/
> +	while(pid_count < pid_cntr)
> +		sleep(1);

What happens if one child hits OOM?

>  
> -		if (sigchld_count) {
> -			tst_resm(TFAIL, "child process exited unexpectedly");
> -		} else if (dowrite) {
> -			tst_resm(TPASS, "%llu kbytes allocated and used.",
> -				 original_maxbytes / 1024);
> -		} else {
> -			tst_resm(TPASS, "%llu kbytes allocated only.",
> -				 original_maxbytes / 1024);
> -		}
> +	if (dowrite) {
> +		sysinfo(&sstats);
> +		/* Total Free Post-Test RAM */
> +		post_mem = (unsigned long long)sstats.mem_unit * sstats.freeram;
> +		post_mem = post_mem + (unsigned long long)sstats.mem_unit *
> sstats.freeswap;
>  
> +		if (((pre_mem - post_mem) < original_maxbytes))
> +			tst_res(TFAIL, "kbytes allocated and used less than expected %llu",
> +					original_maxbytes / 1024);
> +		else
> +			tst_res(TPASS, "%llu kbytes allocated and used",
> +					original_maxbytes / 1024);
> +	} else {
> +		tst_res(TPASS, "%llu kbytes allocated only",
> +				original_maxbytes / 1024);
> +	}
> +
> +	i = 0;
> +	while (pid_list[i] > 0) {
> +		kill(pid_list[i], SIGCONT);
> +		i++;
>  	}
> -	cleanup();
> -	tst_exit();
>  }
> +
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.options = mtest_options,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = mem_test,

Is default timeout going to work on large boxes (256GB+ RAM)?


Thinking loud, what if...
- we define at the start of test how much memory we want to allocate (target == 80% of free RAM)
- we allocate a shared memory for counter, that each child increases
  as it allocates memory (progress)
  (or we abuse tst_futexes)
  we could use tst_atomic_add_return() to count allocated chunks globally
- once child finishes allocation it will pause()
- we set timeout to ~3 minutes
- main process runs in loop, sleeps, and periodically checks
  - if progress reached target, PASS, break
  - if progress hasn't increased in last 15 seconds, FAIL, break
  - if we are 15 seconds away from timeout, end test early, PASS, break
    (reason is to avoid running too long on big boxes)
- kill all children, exit

Regards,
Jan
