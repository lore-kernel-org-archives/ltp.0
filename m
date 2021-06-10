From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Jun 2021 10:26:29 +0200
Subject: [LTP] [PATCH 4/4 v2] syscalls/io_submit: Add io_submit03 test
 for native AIO
In-Reply-To: <20210608135718.36579-5-xieziyao@huawei.com>
References: <20210608135718.36579-1-xieziyao@huawei.com>
 <20210608135718.36579-5-xieziyao@huawei.com>
Message-ID: <YMHMtS527P2OIHjs@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void cleanup(void)
> +{
> +	if (rdonly_fd > 0)
> +		SAFE_CLOSE(rdonly_fd);
> +	if (wronly_fd > 0)
> +		SAFE_CLOSE(wronly_fd);
> +	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_destroy, ctx));

I've replaced these PASS_SILENT() with plain old tst_brk(TBROK ...) in
the last two tests and pushed, thanks.


The TST_EXP_* macros are intended for the actual test and not for
setup/cleanup where the test is supposed to report TBROK if something
goes wrong.

-- 
Cyril Hrubis
chrubis@suse.cz
