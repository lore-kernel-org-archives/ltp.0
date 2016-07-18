From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Jul 2016 16:18:44 +0200
Subject: [LTP] [PATCH 4/8] waitpid09: use the new API
In-Reply-To: <1468593589-30545-5-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1468593589-30545-5-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160718141844.GD18221@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void case0(void)
> +{
> +	pid_t ret;
> +	int status;
> +	int fail = 0;
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0)
> +		do_exit();
> +
> +	/*
> +	 *Check that waitpid with WNOHANG returns zero
> +	 */
> +	while (((ret = waitpid(pid, &status, WNOHANG))
> +		!= 0) || (errno == EINTR)) {
> +		if (ret == -1)
> +			continue;
> +
> +		tst_res(TFAIL, "return value for "
> +			 "WNOHANG expected 0 got %d",
> +			 ret);
> +		fail = 1;
> +	}
>  
> -				while (((ret = waitpid(pid, &status, WNOHANG))
> -					!= -1) || (errno == EINTR)) {
> -					if (ret == -1)
> -						continue;
> +	TST_CHECKPOINT_WAKE(0);
>  
> -					if (ret != pid) {
> -						tst_resm(TFAIL, "proc id %d "
> -							 "and retval %d do not "
> -							 "match", pid, ret);
> -						fail = 1;
> -					}
> +	while (((ret = waitpid(pid, &status, 0)) != -1)
> +	       || (errno == EINTR)) {
> +		if (ret == -1)
> +			continue;
>  
> -					if (status != 0) {
> -						tst_resm(TFAIL, "non zero "
> -							 "status received %d",
> -							 status);
> -						fail = 1;
> -					}
> -				}
> -			}
> +		if (ret != pid) {
> +			tst_res(TFAIL, "Expected %d "
> +				 "got %d as proc id of "
> +				 "child", pid, ret);
> +			fail = 1;
> +		}
>  
> -			if (fail)
> -				tst_resm(TFAIL, "case 1 FAILED");
> -			else
> -				tst_resm(TPASS, "case 1 PASSED");
> +		if (status != 0) {
> +			tst_res(TFAIL, "status value "
> +				 "got %d expected 0",
> +				 status);
> +			fail = 1;
> +		}
> +	}
>  
> -			fail = 0;
> -			ret = waitpid(pid, &status, 0);
> +	pid = 0;
>  
> -			if (ret != -1) {
> -				tst_resm(TFAIL, "Expected -1 got %d", ret);
> -				fail = 1;
> -			}
> -			if (errno != ECHILD) {
> -				tst_resm(TFAIL, "Expected ECHILD got %d",
> -					 errno);
> -				fail = 1;
> -			}
> +	pid = SAFE_FORK();
> +	if (pid == 0)
> +		exit(0);
>  
> -			ret = waitpid(pid, &status, WNOHANG);
> -			if (ret != -1) {
> -				tst_resm(TFAIL, "WNOHANG: Expected -1 got %d",
> -					 ret);
> -				fail = 1;
> -			}
> -			if (errno != ECHILD) {
> -				tst_resm(TFAIL, "WNOHANG: Expected ECHILD got "
> -					 "%d", errno);
> -				fail = 1;
> -			}
> +	while (((ret = waitpid(pid, &status, WNOHANG))
> +		!= -1) || (errno == EINTR)) {
> +		if (ret == -1)
> +			continue;
> +		if (ret == 0)
> +			continue;
>  
> -			if (fail)
> -				tst_resm(TFAIL, "case 2 FAILED");
> -			else
> -				tst_resm(TPASS, "case 2 PASSED");
> +		if (ret != pid) {
> +			tst_res(TFAIL, "proc id %d "
> +				 "and retval %d do not "
> +				 "match", pid, ret);
> +			fail = 1;
>  		}
>  
> -		cleanup();
> -	} else {
> -		/* wait for the child to return */
> -		waitpid(pid, &status, 0);
> -		if (WEXITSTATUS(status) != 0) {
> -			tst_brkm(TBROK, cleanup, "child returned bad "
> -				 "status");
> +		if (status != 0) {
> +			tst_res(TFAIL, "non zero "
> +				 "status received %d",
> +				 status);
> +			fail = 1;
>  		}
>  	}
>  
> -	tst_exit();
> +	pid = 0;
> +
> +	if (fail)
> +		tst_res(TFAIL, "case 0 FAILED");
> +	else
> +		tst_res(TPASS, "case 0 PASSED");
>  }

Both of the case0 and case1 can be easily further split into two
testcases, then we can get rid of the fail flag as well (do a return in
case of a failure and do TPASS on the last line of the test function).

> -/*
> - * setup_sigint()
> - *	sets up a SIGINT handler
> - */
> -static void setup_sigint(void)
> +static void case1(void)
>  {
> -	if ((sig_t) signal(SIGINT, inthandlr) == SIG_ERR) {
> -		tst_brkm(TFAIL, cleanup, "signal SIGINT failed, errno = %d",
> +	pid_t ret;
> +	int status;
> +	int fail = 0;
> +
> +	ret = waitpid(-1, &status, 0);
> +
> +	if (ret != -1) {
> +		tst_res(TFAIL, "Expected -1 got %d", ret);
> +		fail = 1;
> +	}
> +	if (errno != ECHILD) {
> +		tst_res(TFAIL, "Expected ECHILD got %d",
>  			 errno);
> +		fail = 1;
>  	}
> -}
> -
> -static void setup(void)
> -{
> -	TEST_PAUSE;
> -}
>  
> -static void cleanup(void)
> -{
> -}
> +	ret = waitpid(-1, &status, WNOHANG);
> +	if (ret != -1) {
> +		tst_res(TFAIL, "WNOHANG: Expected -1 got %d",
> +			 ret);
> +		fail = 1;
> +	}
> +	if (errno != ECHILD) {
> +		tst_res(TFAIL, "WNOHANG: Expected ECHILD got "
> +			 "%d", errno);
> +		fail = 1;
> +	}
>  
> -static void inthandlr(void)
> -{
> -	intintr++;
> +	if (fail)
> +		tst_res(TFAIL, "case 1 FAILED");
> +	else
> +		tst_res(TPASS, "case 1 PASSED");
>  }
>  
> -static void wait_for_parent(void)
> +static void waitpid09_test(unsigned int id)
>  {
> -	int testvar;
> -	while (!intintr)
> -		testvar = 0;
> +	switch (id) {
> +	case 0:
> +		case0();
> +		break;
> +	case 1:
> +		case1();
> +		break;
> +	default:
> +		tst_brk(TBROK, "Unknown %d", id);
> +	}
>  }
>  
>  static void do_exit(void)
>  {
> -	wait_for_parent();
> +	TST_CHECKPOINT_WAIT(0);
> +
>  	exit(0);
>  }

Since UCLINUX support was removed it does not make any sense to keep
this code in a function anymore...

> -#ifdef UCLINUX
> -/*
> - * do_exit_uclinux()
> - *	Sets up SIGINT handler again, then calls do_exit
> - */
> -static void do_exit_uclinux(void)
> -{
> -	setup_sigint();
> -	do_exit();
> -}
> -#endif
> +static struct tst_test test = {
> +	.tid = "waitpid09",
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.cleanup = cleanup,
> +	.test = waitpid09_test,
> +	.tcnt = 2,
> +};

-- 
Cyril Hrubis
chrubis@suse.cz
