From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Jul 2021 11:27:29 +0200
Subject: [LTP] [PATCH v3] squashfs: Add regression test for sanity check
 bug
In-Reply-To: <4aaba9d9-e013-3c12-500a-647ff2c0b82d@jv-coder.de>
References: <20210715050812.1950884-1-lkml@jv-coder.de>
 <60EFF034.6070800@fujitsu.com>
 <4aaba9d9-e013-3c12-500a-647ff2c0b82d@jv-coder.de>
Message-ID: <YO//gakCvqaDZl9f@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +static struct tst_test test = {
> >> +	.test_all = run,
> >> +	.cleanup = cleanup,
> >> +	.setup = setup,
> >> +	.needs_root = 1,
> >> +	.needs_device = 1,
> >> +	.dev_min_size = 1,
> >> +	.needs_cmds = (const char *const []) {
> >> +		"mksquashfs",
> >> +		NULL
> >> +	},
> >> +	.needs_drivers = (const char *const []) {
> >> +		"squashfs",
> >> +		NULL
> >> +	},
> >> +	.tags = (const struct tst_tag[]) {
> >> +		{"linux-git", "c1b2028315c"},
> >> +		{"linux-git", "8b44ca2b634"},
> >> +		{}
> >> +	},
> >> +	.needs_tmpdir = 1,
> > needs_device has enabled needs_tmpdir in internal, so we don't need to
> > set it here.
> Honestly I hate implicitness like that. I think if the test itself needs 
> the tmpdir, it should state it and not rely on some other "needs_*" 
> stuff to also enable it.
> But if whoever merges this agrees with you, he can change it...

We tend to avoid listing full subtree of dependencies, in this case it's
not that bad, but it tends to get out of hand quickly.

For instance mount_device flag needs implies format_device which implies
needs_device which implies needs_tmpdir.

Also the dev_min_size = 1 does not have any efect here, since it can be
used only to request bigger-than-default size and gets ignored here. I
guess that we can merge this as it is and I will add needs_loopdev to
the tst_test structure later which will just allocate loop device and
pass it down to the test.

-- 
Cyril Hrubis
chrubis@suse.cz
