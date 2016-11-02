From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Nov 2016 14:39:46 +0100
Subject: [LTP] [PATCH v2] syscalls/access04: Convert to new API && Rename
In-Reply-To: <1478079766-4457-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1477991882-23372-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1478079766-4457-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161102133946.GA23975@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void cleanup(void)
> +{
> +	if (mount_flag && tst_umount(MNT_POINT) < 0) {
> +		tst_brk(TBROK | TERRNO, "umount device:%s failed",
> +			tst_device->dev);
> +	}
> +}

You must not call tst_brk() from the test cleanup, that would cause
infinite loop and segfault. You should call tst_res(TWARN, "...");
instead.

And the tst_umount() calls tst_res(TWARN, "..."); already so we can just
do:

...
	if (mount_flag)
		tst_umount(MNT_POINT);
...

-- 
Cyril Hrubis
chrubis@suse.cz
