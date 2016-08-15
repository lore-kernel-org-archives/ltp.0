From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Aug 2016 15:55:24 +0200
Subject: [LTP] [PATCH 1/8] waitpid09: use the new API
In-Reply-To: <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1470818466-28109-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160815135523.GE20680@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void case1(void)
>  {
> -	intintr++;
> +	pid_t pid, ret;
> +	int status;
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0)
> +		exit(0);
> +
> +	for (;;) {
> +		ret = waitpid(pid, &status, WNOHANG);
> +
> +		if ((ret == -1) && (errno == EINTR))
> +			continue;
> +		if (ret == 0)
> +			continue;
> +
> +		if (ret == pid)
> +			break;
> +
> +		tst_res(TFAIL, "waitpid(WNOHANG) returned %d, expected %d",
> +			ret, pid);
> +		cleanup_pid(pid);
> +		return;
> +	}
> +
> +	if (!WIFEXITED(status)) {
> +		tst_res(TFAIL, "Child exited abnormally");
> +		return;
> +	}
> +
> +	if (WEXITSTATUS(status) != 0) {
> +		tst_res(TFAIL, "Child exited with %d, expected 0",
> +			WEXITSTATUS(status));
> +		return;
> +	}
> +
> +	tst_res(TPASS, "Case 1 PASSED");
>  }

Isn't this one the same as the second part of case0() ?

I guess that we can just do:

	TST_CHECKPOINT_WAKE(0);
	SAFE_WAITPID(pid, NULL, 0);

In the case0() since the rest of the assertions is covered in case1().


Also we may print something little more informative than "Case 1
PASSED". I would do something as:

tst_res(TPASS | TERRNO, "waitpid(-1, ..., WNOHANG)");

But that is very minor.

> +static void waitpid09_test(unsigned int id)
>  {
> -	setup_sigint();
> -	do_exit();
> +	switch (id) {
> +	case 0:
> +		case0();
> +		break;
> +	case 1:
> +		case1();
> +		break;
> +	case 2:
> +		case2();
> +		break;
> +	case 3:
> +		case3();
> +		break;
> +	default:
> +		tst_brk(TBROK, "Unknown %d", id);
> +	}
>  }

This maybe could be a little shorter with an array of fucnctions.

Something as:

static void (*tests[])(void) = {case0, case1, case2, case3};

static void do_test(unsigned int i)
{
	tests[i]();
}


...

static struct test = {
	...
	.tcnt = ARRAY_SIZE(tests);
};




And we may even add a tests pointer to the struct test structure and
teach the test library to use it if set so that we can pass an array of
functions directly.

-- 
Cyril Hrubis
chrubis@suse.cz
