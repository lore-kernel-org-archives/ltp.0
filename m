From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 8 Mar 2021 17:11:51 +0100
Subject: [LTP] [PATCH] lib/tst_supported_fs_types.c: Add tmpfs to
 filesystem whitelist
In-Reply-To: <20210304020838.259422-1-zhaogongyi@huawei.com>
References: <20210304020838.259422-1-zhaogongyi@huawei.com>
Message-ID: <YEZMx0TF2FlipBiG@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -34,6 +35,10 @@ static int has_mkfs(const char *fs_type)
> 
>  	sprintf(buf, "mkfs.%s >/dev/null 2>&1", fs_type);
> 
> +	if (strstr(buf, "mkfs.tmpfs")) {
> +		return 1;
> +	}

The curly braces around single line statement are useless here.

Also it would be cleaner if we checked before the sprintf and against
the fs_type instead with if (!strcmp(fs_type, "tmpfs")).

We may also print a TINFO message something along the lines:

	tst_res(TINFO, "mkfs is not needed for tmpfs");

>  	ret = tst_system(buf);
> 
>  	if (WEXITSTATUS(ret) == 127) {
> @@ -50,17 +55,30 @@ static int has_kernel_support(const char *fs_type, int flags)
>  	static int fuse_supported = -1;
>  	const char *tmpdir = getenv("TMPDIR");
>  	char buf[128];
> +	char template[PATH_MAX];
>  	int ret;
> 
>  	if (!tmpdir)
>  		tmpdir = "/tmp";
> 
> -	mount("/dev/zero", tmpdir, fs_type, 0, NULL);
> -	if (errno != ENODEV) {
> +	sprintf(template, "%s/mountXXXXXX", tmpdir);

We should at least use snprintf() with sizeof(template) in order not to
overrun the buffer. Or we can use asprintf() instead and free the buffer
later on.

> +	if (mkdtemp(template) == NULL) {
> +		tst_res(TWARN | TERRNO , "%s: mkdtemp(%s) failed", __func__, template);
> +	}

I guess that we can tst_brk(TBROK, ""); here if mkdtemp() failed,
continuing here we would pass non-existing directory thte mount()
syscall below.

Also please do not include the __func__ in the message here.

> +	ret = mount("/dev/zero", template, fs_type, 0, NULL);
> +	if ((ret && errno != ENODEV) || !ret) {
> +		if (!ret)
> +			tst_umount(template);
>  		tst_res(TINFO, "Kernel supports %s", fs_type);
> +		if (rmdir(template) == -1)
> +			tst_res(TWARN | TERRNO, "rmdir %s failed", template);

We do have SAFE_RMDIR() please use that.

>  		return 1;
>  	}
> 
> +	if (rmdir(template) == -1)
> +		tst_res(TWARN | TERRNO, "rmdir %s failed", template);

Here as well.

>  	/* Is FUSE supported by kernel? */
>  	if (fuse_supported == -1) {
>  		ret = open("/dev/fuse", O_RDWR);
> --
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
