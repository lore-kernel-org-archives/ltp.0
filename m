From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Aug 2021 11:21:45 +0200
Subject: [LTP] [PATCH] [v3,
 1/6] syscalls/sysfs: Convert sysfs01 to the new API
In-Reply-To: <20210811024759.17858-1-sujiaxun@uniontech.com>
References: <20210811024759.17858-1-sujiaxun@uniontech.com>
Message-ID: <YROWqa27tFmwjCqk@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	/* option 1, buf holds fs name */
> +	TST_EXP_POSITIVE(tst_syscall(__NR_sysfs, 1, "proc"), "sysfs(1,'proc')");
> 
> +	if (TST_PASS == 1)
> +		tst_res(TPASS, "sysfs(2) Passed for option 1");

Ah, TST_EXP_POSITIVE() does not produce TPASS message, that should be
fixed so that we don't have to add the TPASS message manually here. I
will send a patch.

-- 
Cyril Hrubis
chrubis@suse.cz
