From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Aug 2021 16:52:44 +0200
Subject: [LTP] [PATCH 1/2] Add test for CVE 2020-25704
In-Reply-To: <20210802160918.30861-1-mdoucha@suse.cz>
References: <20210802160918.30861-1-mdoucha@suse.cz>
Message-ID: <YQlYPM1XuRsHVyV0@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void run(void)
> +{
> +	struct sysinfo info1, info2;
> +	unsigned long diff, memunit;
> +	int i;
> +
> +	SAFE_SYSINFO(&info1);
> +
> +	/* leak about 100MB of RAM */
> +	for (i = 0; i < 12000000; i++)
> +		ioctl(fd, PERF_EVENT_IOC_SET_FILTER, "filter,0/0@abcd");
> +
> +	SAFE_SYSINFO(&info2);
> +	memunit = info1.mem_unit;
> +
> +	/* sysinfo(2) man page does not guarantee consistent mem_unit... */
> +	if (info1.mem_unit > info2.mem_unit) {
> +		diff = info1.mem_unit / info2.mem_unit;
> +		info2.freeram /= diff;
> +	} else if (info1.mem_unit < info2.mem_unit) {
> +		diff = info2.mem_unit / info1.mem_unit;
> +		info1.freeram /= diff;
> +		memunit = info2.mem_unit;
> +	}

I guess that SAFE_READ_MEMINFO() would be much easier to use with:

	memfree_before = SAFE_READ_MEMINFO("MemFree:");

	// do the test

	memfree_after = SAFE_READ_MEMINFO("MemFree:");

And the result is conviniently in kilobytes.

> +	if (info1.freeram > info2.freeram + 50 * 1024 * 1024 / memunit)
> +		tst_res(TFAIL, "Likely kernel memory leak detected");
> +	else
> +		tst_res(TPASS, "No memory leak found");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "7bdb157cdebb"},
> +		{"CVE", "2020-25704"},
> +		{}
> +	}
> +};
> +
> +#else /* HAVE_PERF_EVENT_ATTR */
> +TST_TEST_TCONF("This system doesn't have <linux/perf_event.h> or "
> +	"struct perf_event_attr is not defined.");
> +#endif
> -- 
> 2.32.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
