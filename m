From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Jan 2020 14:39:13 +0100
Subject: [LTP] [PATCH v1 3/4] syscalls/capset03: add new EPERM error
 test without CAP_SETPCAP
In-Reply-To: <1576577571-3668-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1576577571-3668-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200107133913.GE26408@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void setup(void)
> +{
> +	pid_t pid;
> +
> +	pid = getpid();
> +	header.pid = pid;
> +	if (geteuid() == 0) {
> +		TEST(tst_syscall(__NR_capset, &header, data));
> +		if (TST_RET == -1)
> +			tst_brk(TBROK | TTERRNO, "capset data failed");
> +	}

Please don't do that. If tests needs root (even for a subset of the
test) just set the .needs_root flag.

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = verify_capset,
> +	.caps = (struct tst_cap []) {
> +		TST_CAP(TST_CAP_DROP, CAP_SETPCAP),
> +		{}
> +	},
> +};
> -- 
> 2.18.0
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
