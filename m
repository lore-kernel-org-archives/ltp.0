From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 28 Apr 2021 16:20:51 +0200
Subject: [LTP] [PATCH] ttype: Replase TINFO with TPASS or TFAIL
In-Reply-To: <20210428072016.17556-1-zhaogongyi@huawei.com>
References: <20210428072016.17556-1-zhaogongyi@huawei.com>
Message-ID: <YIlvQ7D925aVJMao@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
> index a77a81298..f12474f79 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl16.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
> @@ -673,10 +673,10 @@ int main(int ac, char **av)
>  		 */
>  		tst_resm(TINFO, "Entering block 1");
>  		if (run_test(O_CREAT | O_RDWR | O_TRUNC, 0777, 0, 11)) {
> -			tst_resm(TINFO, "Test case 1: without mandatory "
> +			tst_resm(TFAIL, "Test case 1: without mandatory "
>  				 "locking FAILED");
>  		} else {
> -			tst_resm(TINFO, "Test case 1: without manadatory "
> +			tst_resm(TPASS, "Test case 1: without manadatory "
>  				 "locking PASSED");
>  		}

I would be happier if we fixed the run_test() function to report
TFAIL/TPASS in all cases and just called run_test() from the main().

It shouldn't be even a big change since we report most of the failures
there, what we need is to change one TINFO into TFAIL and report TPASS
at the end of the function.

>  		tst_resm(TINFO, "Exiting block 1");

Also can we please get rid of the useless entering/exitting block
messages?


And the same applies for the rest of the tests changed by this patch.

-- 
Cyril Hrubis
chrubis@suse.cz
