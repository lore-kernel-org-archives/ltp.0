From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jul 2016 14:41:25 +0200
Subject: [LTP] [PATCH V2 4/8] waitpid09: use the new API
In-Reply-To: <1468924444-924-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <20160718141844.GD18221@rei.suse.cz>
 <1468924444-924-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160719124125.GD6409@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This patch addresses all your comments, except the one about do_exit(),
> because do_exit() is required for case 0.

What I meant was to move the two lines that are in do_exit() to the if
in the case0(). Previously the function was called from two places (one
was the uclinux maybe_run_child and another one was after the fork) but
now it does not make any sense to keep it as a separate function if it's
called only from one place in the code.

Or is there another reason to keep it in a fucntion I don't see?

> +static void case2(void)
>  {
> +	pid_t ret;
> +	int status;
> +
> +	ret = waitpid(-1, &status, 0);
> +
> +	if (ret != -1) {
> +		tst_res(TFAIL, "Expected -1 got %d", ret);
> +		return;
> +	}
> +	if (errno != ECHILD) {
> +		tst_res(TFAIL, "Expected ECHILD got %d",
> +			 errno);
                        ^
			You should print the human-readable string
			returned by tst_strerrno() here as well or
			use TERRNO to have it printed by the library.

> +		return;
> +	}
> +
> +	tst_res(TPASS, "Case 2 PASSED");
>  }
>  
> -static void inthandlr(void)
> +static void case3(void)
>  {
> -	intintr++;
> +	pid_t ret;
> +	int status;
> +
> +	ret = waitpid(-1, &status, WNOHANG);
> +	if (ret != -1) {
> +		tst_res(TFAIL, "WNOHANG: Expected -1 got %d",
> +			 ret);
> +		return;
> +	}
> +	if (errno != ECHILD) {
> +		tst_res(TFAIL, "WNOHANG: Expected ECHILD got "
> +			 "%d", errno);

                        Here as well.

> +		return;
> +	}
> +
> +	tst_res(TPASS, "Case 3 PASSED");
>  }
>  
> -static void wait_for_parent(void)

Otherwise it looks good. Acked with the minor changes fixed.

-- 
Cyril Hrubis
chrubis@suse.cz
