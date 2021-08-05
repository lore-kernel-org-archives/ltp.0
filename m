From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Aug 2021 13:54:43 +0200
Subject: [LTP] [PATCH] [1/6] syscalls/sysfs: Convert sysfs01 to the new
 API
In-Reply-To: <20210804060736.10234-1-sujiaxun@uniontech.com>
References: <20210804060736.10234-1-sujiaxun@uniontech.com>
Message-ID: <YQvRg1O7kakkm30M@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		TEST(tst_syscall(__NR_sysfs, 1, "proc"));
> 
>  		/* check return code */
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL, "sysfs(2) Failed for "
> -				 "option 1 and set errno to %d", TEST_ERRNO);
> +		if (TST_RET == -1) {
> +			tst_res(TFAIL, "sysfs(2) Failed for "
> +				 "option 1 and set errno to %d", TST_ERR);
>  		} else {
> -			tst_resm(TPASS, "sysfs(2) Passed for " "option 1");
> +			tst_res(TPASS, "sysfs(2) Passed for " "option 1");
>  		}

This could be just:

	TST_EXP_POSSITIVE(tst_syscall(__NR_sysfs, 1, "proc"),
	                  "sysfs(1, "proc")");

-- 
Cyril Hrubis
chrubis@suse.cz
