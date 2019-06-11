From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Jun 2019 11:14:09 +0200
Subject: [LTP] [PATCH v3 3/9] Test for CVE-2016-4997 on setsockopt
In-Reply-To: <20170623122211.29575-4-rpalethorpe@suse.com>
References: <20170623122211.29575-1-rpalethorpe@suse.com>
 <20170623122211.29575-4-rpalethorpe@suse.com>
Message-ID: <20190611091409.GA5644@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard, Cyril,

looking at this LTP test (3be0d391f renamed it into
testcases/kernel/syscalls/setsockopt/setsockopt03.c).


> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  testcases/cve/cve-2016-4997.c | 92 +++++++++++++++++++++++++++++++++++++++++++

...
> +static void setup(void)
> +{
> +	if (tst_kernel_bits() == 32 || sizeof(long) > 4)
> +		tst_res(TCONF,
> +			"The vulnerability was only present in 32-bit compat mode");
Was it intentional to run it on normal 64bit?
Shouldn't it be tst_brk(TCONF, ...) used?

Kind regards,
Petr

> +}
> +
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
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "2.6.32",
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +};
