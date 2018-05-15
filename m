From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 May 2018 11:56:55 +0200
Subject: [LTP] [PATCH] syscall/open11: use the new ltp test library
In-Reply-To: <20180511231027.64305-1-fengc@google.com>
References: <20180511231027.64305-1-fengc@google.com>
Message-ID: <20180515095648.GA7220@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_root = 1,
> +	.mntpoint = MNT_POINT,
> +	.mount_device = 1,
> +	.setup = setup,
> +	.test = verify_open,

Can we rather than the device use tmpfs or fallback to a device only if
the $TMPDIR is mounted with nodev?

I've recetly spend quite some time with speeding up the syscall testrun
and saved about a minute on the testrun in order to have shorter
development feedback loops...

-- 
Cyril Hrubis
chrubis@suse.cz
