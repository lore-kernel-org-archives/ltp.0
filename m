From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Nov 2015 14:21:59 +0100
Subject: [LTP] [PATCH v5] sched_getattr/sched_getattr02: Add new
 testcase for sched_getattr
In-Reply-To: <56389A8B.6040600@huawei.com>
References: <1445345999-145313-1-git-send-email-cuibixuan@huawei.com>
 <20151026154705.GB6772@rei> <56302781.30701@huawei.com>
 <20151029160913.GE23990@rei> <563463CC.3090703@huawei.com>
 <20151102172809.GD28478@rei> <56389A8B.6040600@huawei.com>
Message-ID: <20151103132159.GC5795@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	for (i = 0; i < TST_TOTAL; i++)
> +		sched_getattr_verify(&test_cases[i]);

I've readded the TEST_LOOPING() here, since I asked you to do this loop
inside of the TEST_LOOPING() loop, not to remove it. Once it's removed
the default test parameters does not work.

> +	tst_exit();
> +}
> +
> +void setup(void)
> +{
> +	unused_pid = tst_get_unused_pid(setup);
> +
> +	tst_require_root();

And I've removed the tst_require_root() since it's not needed as we do
not call setattr anymore.

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
