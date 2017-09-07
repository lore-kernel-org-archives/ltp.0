From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Sep 2017 04:25:31 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH 02/15] lib: Add interface to list
	supported	filesystems
In-Reply-To: <20170905160918.6477-2-chrubis@suse.cz>
References: <20170905160918.6477-1-chrubis@suse.cz>
 <20170905160918.6477-2-chrubis@suse.cz>
Message-ID: <810821313.10122426.1504772731732.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> A filesystem is supported if kernel can mount it (we do not get ENODEV
> when we attempt to mount it) and if there is mkfs installed so that we
> can format a test device.
> 
> The function starts with a whitelist of filesystems to use and loops
> over them filtering out unsupported ones, then finally returns a list
> of filesystem that could be used for the testing.
> 

...

> +static int has_mkfs(const char *fs_type)
> +{
> +	char buf[128];
> +	int ret;
> +
> +	sprintf(buf, "mkfs.%s >/dev/null 2>&1", fs_type);
> +
> +	ret = tst_system(buf);
> +
> +	if (WEXITSTATUS(ret) == 127) {
> +		tst_res(TINFO, "mkfs.%s does not exits", fs_type);

exits -> exist

> +		return 0;
> +	}
> +
> +	tst_res(TINFO, "mkfs.%s does exits", fs_type);

same here

> +	return 1;
> +}
> +
> +static int has_kernel_support(const char *fs_type)
> +{
> +	static int fuse_supported = -1;
> +	const char *tmpdir = getenv("TMPDIR");
> +	char buf[128];
> +	int ret;
> +
> +	if (!tmpdir)
> +		tmpdir = "/tmp";
> +
> +	mount("/dev/zero", tmpdir, fs_type, 0, NULL);
> +	if (errno != ENODEV) {
> +		tst_res(TINFO, "Kernel supports %s", fs_type);
> +		return 1;
> +	}
> +
> +	/* Is FUSE supported by kernel? */
> +	if (fuse_supported == -1) {
> +		ret = open("/dev/fuse", O_RDWR);
> +		if (ret < 0)
> +			fuse_supported = 0;
> +		else
> +			fuse_supported = 1;
> +
> +		SAFE_CLOSE(ret);

This TBROK if /dev/fuse does not exist.
safe_macros.c:62: BROK: tst_supported_fs_types.c:87: close(-1) failed: EBADF

Regards,
Jan
