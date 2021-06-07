From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Jun 2021 15:22:00 +0200
Subject: [LTP] [PATCH 3/3] syscalls/io_submit: Add io_submit02 test for
 native AIO
In-Reply-To: <20210507083321.167998-4-xieziyao@huawei.com>
References: <20210507083321.167998-1-xieziyao@huawei.com>
 <20210507083321.167998-4-xieziyao@huawei.com>
Message-ID: <YL4deOp77fYs40Jw@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	TEST(tst_syscall(__NR_io_submit, *tc[i].ctx, tc[i].nr, tc[i].iocbs));
> +	tst_res(TST_ERR == tc[i].exp_errno ? TPASS : TFAIL,
> +		"io_submit(2) with %s returns %s, expected %s",
> +		tc[i].desc, tst_strerrno(TST_ERR), tst_strerrno(tc[i].exp_errno));

I do not like this tst_res() that much. Can we rather do:

	if (tc[i].exp_errno)
		TST_EXP_FAIL(...);
	else
		TST_EXP_PASS(...);

Another possibility would be splitting the test into two one for
negative and one for positive cases.


And we need the .needs_kconfig in this test as well.

-- 
Cyril Hrubis
chrubis@suse.cz
