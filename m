From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jan 2021 16:42:15 +0100
Subject: [LTP] [PATCH v1 3/3] syscalls/mallinfo03: Add an overflow test
 when setting 2G size
In-Reply-To: <1611654925-8994-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1611654925-8994-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <YBLbV2EhTWKihyE2@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +void test_mallinfo(void)
> +{
> +	struct mallinfo info;
> +	char *buf;
> +	size_t size = 2UL * 1024UL * 1024UL * 1024UL;
> +
> +	buf = SAFE_MALLOC(size);

If nothing else use of SAFE_MALLOC() here is wrong. The call may
potentionally fail and return NULL since we are passing overly large
value there.

For example it will fail if memory overcommit is disabled and there is
not enough free memory.

So we should, at least, use malloc() instead and skip the test if NULL
was returned.

> +	info = mallinfo();
> +	if (info.hblkhd < 0) {
> +		print_mallinfo("Test malloc 2G", &info);
> +		tst_res(TFAIL, "The member of struct mallinfo overflow, we should use mallinfo2");
> +	} else {
> +		/*We will never get here*/
> +		tst_res(TPASS, "The member of struct mallinfo doesn't overflow");
> +	}
> +	free(buf);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = test_mallinfo,
> +};
> +
> +#else
> +TST_TEST_TCONF("system doesn't implement non-POSIX mallinfo()");
> +#endif
> -- 
> 2.23.0
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
