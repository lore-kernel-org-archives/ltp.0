From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 Oct 2019 12:22:29 +0200
Subject: [LTP] [PATCH] Add a regression test for cve-2017-15649
In-Reply-To: <20190924112159.18845-1-mmoese@suse.de>
References: <20190924112159.18845-1-mmoese@suse.de>
Message-ID: <20191014102228.GA31459@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> +void *task1(void *unused)
> +{
> +	int fanout = 0x3;
> +
> +	if (tst_fzsync_run_a(&fzsync_pair)) {
> +		setsockopt(fd, 0x107, 18, &fanout, sizeof(fanout));
> +		tst_fzsync_end_race_a(&fzsync_pair);
> +	}
This is a bit different usage of fuzzy sync than docs and other tests do.
As you don't need to run tst_fzsync_pair_reset(&fzsync_pair, task2) here
a warning is issued. If this is a correct usage, we might want to define
tst_fzsync_pair_reset() as inline to avoid the warning.

..
> +static void run(void)
> +{
...
> +	while (1) {
> +		pthread_t thread1, thread2;
> +
> +
> +		fd = SAFE_SOCKET(AF_PACKET, SOCK_RAW, PF_PACKET);
> +
> +		strcpy((char *) &ifr.ifr_name, "lo");
> +		SAFE_IOCTL(fd, SIOCGIFINDEX, &ifr);
> +		index = ifr.ifr_ifindex;
> +
> +		SAFE_IOCTL(fd, SIOCGIFFLAGS, &ifr);
> +		ifr.ifr_flags &= ~(short) IFF_UP;
> +
> +		SAFE_IOCTL(fd, SIOCSIFFLAGS, &ifr);
> +
> +		addr.sll_family = AF_PACKET;
> +		addr.sll_protocol = 0x0;
> +		addr.sll_ifindex = index;
> +
> +		SAFE_PTHREAD_CREATE(&thread1, NULL, task1, NULL);
> +		SAFE_PTHREAD_CREATE(&thread2, NULL, task2, NULL);
> +		SAFE_PTHREAD_JOIN(thread1, NULL);
> +		SAFE_PTHREAD_JOIN(thread2, NULL);
> +
> +		SAFE_CLOSE(fd);
> +
> +		if (tst_capget(&hdr, after))
> +			tst_brk(TBROK | TTERRNO, "tst_capget()");
> +
> +		if (memcmp(before, after, sizeof(after)) || tst_taint_check())
> +			tst_res(TFAIL, "kernel is vulnerable");
> +
> +		clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &now);
> +		if ((now.tv_sec - start.tv_sec) > TEST_RUNTIME)
> +			tst_res(TPASS, "kernel seems to be not vulnerable");
You miss return/break here or it's an infinite loop :).

> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.caps = (struct tst_cap []) {
> +		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
> +		TST_CAP(TST_CAP_REQ, CAP_NET_RAW),
> +		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
> +		{},
> +	},
> +};

Kind regards,
Petr
