From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Aug 2021 14:00:28 +0200
Subject: [LTP] [PATCH] [2/6] syscalls/sysfs: Convert sysfs02 to the new
 API
In-Reply-To: <20210805104229.10826-1-sujiaxun@uniontech.com>
References: <20210805104229.10826-1-sujiaxun@uniontech.com>
Message-ID: <YQvS3PLdmpmSNJAf@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * [DESCRIPTION]

This has to be [Description]

> -		TEST(ltp_syscall(__NR_sysfs, 2, 0, buf));
> +		TEST(tst_syscall(__NR_sysfs, 2, 0, buf));
> 
>  		/* check return code */
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL, "sysfs(2) Failed for "
> +		if (TST_RET == -1) {
> +			tst_res(TFAIL, "sysfs(2) Failed for "
>  				 "option 2 and returned"
> -				 " %d as error number", TEST_ERRNO);
> +				 " %d as error number", TST_ERR);
>  		} else {
> -			tst_resm(TPASS, "sysfs(2) Passed for option 2");
> +			tst_res(TPASS, "sysfs(2) Passed for option 2");
>  		}
> -	}			/*End of TEST_LOOPING */

And this should be just TST_EXP_PASS(...);


-- 
Cyril Hrubis
chrubis@suse.cz
