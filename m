From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Nov 2018 16:48:44 +0100
Subject: [LTP] [PATCH v3] syscalls/fanotify10: new test for mount ignore
	mask
In-Reply-To: <20180928075117.4789-1-amir73il@gmail.com>
References: <20180928075117.4789-1-amir73il@gmail.com>
Message-ID: <20181102154844.GC30704@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor simplification:

> +static struct tst_test test = {
> +	.test = test_fanotify,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.format_device = 1,

I've changed this to .mount_device = 1 and .mntpoint = MOUNT_POINT and
removed the code that mounted and umounted the filesystem in setup and
cleanup.

> +	.needs_tmpdir = 1,
> +	.needs_root = 1
> +};

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
