From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Feb 2021 10:54:52 +0100
Subject: [LTP] [PATCH] lib/tst_supported_fs_types.c: Add tmpfs to
 filesystem whitelist
In-Reply-To: <20210226090615.231970-1-zhaogongyi@huawei.com>
References: <20210226090615.231970-1-zhaogongyi@huawei.com>
Message-ID: <YDjFbG0In5oQjLKN@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index 00ede549d..696b6731e 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -22,6 +22,7 @@ static const char *const fs_type_whitelist[] = {
>  	"vfat",
>  	"exfat",
>  	"ntfs",
> +	"tmpfs",
>  	NULL
>  };
> 
> @@ -34,6 +35,10 @@ static int has_mkfs(const char *fs_type)
> 
>  	sprintf(buf, "mkfs.%s >/dev/null 2>&1", fs_type);
> 
> +	if (strstr(buf, "mkfs.tmpfs")) {
> +		return 1;
> +	}
> +
>  	ret = tst_system(buf);
> 
>  	if (WEXITSTATUS(ret) == 127) {
> @@ -55,8 +60,8 @@ static int has_kernel_support(const char *fs_type, int flags)
>  	if (!tmpdir)
>  		tmpdir = "/tmp";
> 
> -	mount("/dev/zero", tmpdir, fs_type, 0, NULL);
> -	if (errno != ENODEV) {
> +	ret = mount("/dev/zero", tmpdir, fs_type, 0, NULL);

The manual page explicitly says that errno is set to ENODEV if
filesystem is not supported by kernel. So the check for errno should
stay, since the statement above will fail to mount any real filesystem
since we pass "/dev/zero" instead of valid filesystem image there.

I.e. if we pass a real filesystem there it will either fail with EINVAL
(since /dev/zero does not have a valid superblock) or ENODEV if there is
no kernel driver for the filesystem.

> +	if (!ret) {

I guess that tmpfs succeeds to mount there. So I guess that we should
change the condition to:

	if ((ret && errno != ENODEV) || !ret) {
		if (!ret)
			tst_umount(tmpdir);

		tst_res(TINFO, "Kernel supports %s", fs_type);
		return 1;
	}


But there is another problem there, since the code still mounts tmpfs on
tmpdir for a short while, which is temporary directory used by all LTP
tests, which may potentially break tests that runs in parallel.

So we will have to prepare a temporary directory with mkdtemp() under
the tmpdir as well and pass that to the mount() syscall instead.

-- 
Cyril Hrubis
chrubis@suse.cz
