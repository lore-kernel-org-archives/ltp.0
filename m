From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 21 Jan 2020 16:49:42 +0100
Subject: [LTP] [PATCH v2] Add test for misaligned fallocate()
In-Reply-To: <20200116123100.13345-1-mdoucha@suse.cz>
References: <20200116123100.13345-1-mdoucha@suse.cz>
Message-ID: <20200121154941.GC12370@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	SAFE_CLOSE(fd);
> +	tst_system("rm -r " MNTPOINT "/*");

Just FYI, we already have something like this implemented but not
exported outside of the test library. We basically need a public
wrapper around the rmobj() function from the tst_tmpdir.c

> +}
> +
> +static void cleanup(void)
> +{
> +	free(wbuf);
> +	free(rbuf);
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(testcase_list),
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.dev_min_size = 512,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> -- 
> 2.24.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
