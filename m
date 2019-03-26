From: Sandeep Patil <sspatil@android.com>
Date: Tue, 26 Mar 2019 21:47:43 +0900
Subject: [LTP] [RFC PATCH 1/4] syscalls/abort01: convert to new library
In-Reply-To: <20190326115825.GA32549@rei.lan>
References: <20190325232012.67123-1-sspatil@android.com>
 <20190325232012.67123-2-sspatil@android.com>
 <20190326115825.GA32549@rei.lan>
Message-ID: <20190326124743.GC5826@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 26, 2019 at 12:58:25PM +0100, Cyril Hrubis wrote:
> Hi!
> I've further simplified the test and pushed, thanks.
> 
> What I have done:
> 
> * Got rid of tst_brk(TFAIL, ...) calls
>   see: https://github.com/linux-test-project/ltp/issues/462

Thanks for this, it is good to know. What is the recommended replacement?
tst_res()?

> 
> * Used tst_strsig() and tst_strstatus() to print signal and status
> 
> * Used tst_res() API in the child
> 
> * Got rid of unused variables, etc.

I am surprised that didn't throw a warning + build error for me.
other than that, thanks for doing this

> 
> diff --git a/testcases/kernel/syscalls/abort/abort01.c b/testcases/kernel/syscalls/abort/abort01.c
> index ac5ddb140..386a22f26 100644
> --- a/testcases/kernel/syscalls/abort/abort01.c
> +++ b/testcases/kernel/syscalls/abort/abort01.c
> @@ -27,51 +27,45 @@
>  static void do_child(void)
>  {
>  	abort();
> -	fprintf(stderr, "\tchild - abort failed.\n");
> -	exit(1);
> +	tst_res(TFAIL, "Abort returned");
> +	exit(0);
>  }
>  
> -void verify_abort(unsigned int nr)
> +void verify_abort(void)
>  {
> -	int i;
> -	int status, child, kidpid;
> -	int sig, ex;
> -	int core;
> -	core = ex = sig = 0;
> +	int status, kidpid;
> +	int sig, core;
>  
>  	kidpid = SAFE_FORK();
>  	if (kidpid == 0)
>  		do_child();
>  
> -	child = SAFE_WAIT(&status);
> -
> -	if (WIFSIGNALED(status)) {
> -		core = WCOREDUMP(status);
> -		sig = WTERMSIG(status);
> +	SAFE_WAIT(&status);
>  
> +	if (!WIFSIGNALED(status)) {
> +		tst_res(TFAIL, "Child %s, expected SIGIOT",
> +			tst_strstatus(status));
> +		return;
>  	}
>  
> -	if (WIFEXITED(status))
> -		ex = WEXITSTATUS(status);
> +	core = WCOREDUMP(status);
> +	sig = WTERMSIG(status);
>  
>  	if (core == 0)
> -		tst_brk(TFAIL,
> -			"Missing core dump; exit(%d), signal(%d)",
> -			ex, sig);
> -	else if (core != -1)
> +		tst_res(TFAIL, "abort() failed to dump core");
> +	else
>  		tst_res(TPASS, "abort() dumped core");
>  
>  	if (sig == SIGIOT)
>  		tst_res(TPASS, "abort() raised SIGIOT");
>  	else
> -		tst_brk(TFAIL,
> -			"Unexpected signal(%d), expected SIGIOT(%d)",
> -			sig, SIGIOT);
> +		tst_res(TFAIL, "abort() raised %s", tst_strsig(sig));
>  }
>  
> +#define MIN_RLIMIT_CORE (1024 * 1024)
> +
>  static void setup(void)
>  {
> -#define MIN_RLIMIT_CORE (1024 * 1024)
>  	struct rlimit rlim;
>  
>  	/* make sure we get core dumps */
> @@ -83,9 +77,8 @@ static void setup(void)
>  }
>  
>  static struct tst_test test = {
> -	.tcnt = 3,
>  	.needs_tmpdir = 1,
>  	.forks_child = 1,
>  	.setup = setup,
> -	.test = verify_abort,
> +	.test_all = verify_abort,
>  };
> 
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
