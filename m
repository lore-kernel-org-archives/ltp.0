From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Jul 2021 11:31:25 +0200
Subject: [LTP] [PATCH v2 1/2] lib: limit the size of tmpfs in LTP
In-Reply-To: <20210705082527.855688-1-liwang@redhat.com>
References: <20210705082527.855688-1-liwang@redhat.com>
Message-ID: <YOV0bemK+1NI0Cz4@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  lib/tst_test.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 55449c80b..93761868e 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -882,8 +882,35 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
>  	}
>  }
>  
> +static char *limit_tmpfs_mount_size(const char *mnt_data,
> +			char *buf, size_t buf_size, const char *fs_type)
> +{
> +	int fd;
> +	uint64_t dev_size;
> +
> +	if (strcmp(fs_type, "tmpfs"))
> +		return mnt_data;
> +
> +	fd = SAFE_OPEN(tdev.dev, O_RDONLY);
> +	SAFE_IOCTL(fd, BLKGETSIZE64, &dev_size);
> +	SAFE_CLOSE(fd);

We can as well add size to the struct tst_device and fill it in when
device is created, that would be a slightly cleaner solution.

Other than this the rest looks good.

> +	dev_size = dev_size/1024/1024;
> +
> +	if (mnt_data)
> +		snprintf(buf, buf_size, "%s,size=%luM", mnt_data, dev_size);
> +	else
> +		snprintf(buf, buf_size, "size=%luM", dev_size);
> +
> +	tst_res(TINFO, "Limiting tmpfs size to %luMB", dev_size);
> +
> +	return buf;
> +}
> +
>  static void prepare_device(void)
>  {
> +	char *mnt_data, buf[1024];
> +
>  	if (tst_test->format_device) {
>  		SAFE_MKFS(tdev.dev, tdev.fs_type, tst_test->dev_fs_opts,
>  			  tst_test->dev_extra_opts);
> @@ -896,8 +923,11 @@ static void prepare_device(void)
>  	}
>  
>  	if (tst_test->mount_device) {
> +		mnt_data = limit_tmpfs_mount_size(tst_test->mnt_data,
> +				buf, sizeof(buf), tdev.fs_type);
> +
>  		SAFE_MOUNT(tdev.dev, tst_test->mntpoint, tdev.fs_type,
> -			   tst_test->mnt_flags, tst_test->mnt_data);
> +			   tst_test->mnt_flags, mnt_data);
>  		mntpoint_mounted = 1;
>  	}
>  }
> -- 
> 2.31.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
