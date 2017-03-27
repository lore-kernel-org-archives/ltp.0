From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 Mar 2017 17:34:40 +0200
Subject: [LTP] [PATCH 2/4] Test for CVE-2016-4997 on setsockopt
In-Reply-To: <20170323162633.7e49c7ae@linux-v3j5>
References: <20170323162633.7e49c7ae@linux-v3j5>
Message-ID: <20170327153439.GD21272@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void run(void)
> +{
> +	int ret, sock_fd;
> +	struct payload p = { 0 };
> +
> +	sock_fd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
> +
> +	strncpy(p.match.u.user.name, "icmp", sizeof(p.match.u.user.name));
> +	p.match.u.match_size = OFFSET_OVERWRITE;
> +
> +	p.ent.next_offset = NEXT_OFFSET;
> +	p.ent.target_offset = TOO_SMALL_OFFSET;
> +
> +	p.repl.num_entries = 2;
> +	p.repl.num_counters = 1;
> +	p.repl.size = sizeof(struct payload);
> +	p.repl.valid_hooks = 0;
> +
> +	ret = setsockopt(sock_fd, SOL_IP, IPT_SO_SET_REPLACE,
> +			 &p, sizeof(struct payload));
> +	tst_res(TPASS | TERRNO, "We didn't cause a crash, setsockopt returned %d", ret);
> +	if (sizeof(long) > 4)
> +		tst_res(TCONF,
> +			"The original vulnerability was only present in 32-bit compat mode");

Why do we issue the TCONF at the end of the test? Shouldn't this be
something do in the test setup?

Also we have tst_kernel_bits() in the test library, so we can do
something as:

if (tst_kernel_bits() == 32 || sizeof(long) > 4)
	tst_res(TCONF, "...");

> +}
> +
> +static struct tst_test test = {
> +	.tid = "cve-2016-4997",
> +	.min_kver = "2.6.32",
> +	.test_all = run,
> +	.needs_root = 1,
> +};

I also wonder if we should compile the test with -m32 by default, we
whould have to add a configure test if compilation with -m32 works
though.

-- 
Cyril Hrubis
chrubis@suse.cz
