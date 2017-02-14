From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 16:28:56 +0100
Subject: [LTP] [PATCH 1/3] tst_test: Handle device mkfs/mount int the
 library
In-Reply-To: <20170214152639.11603-1-chrubis@suse.cz>
References: <20170214152639.11603-1-chrubis@suse.cz>
Message-ID: <20170214152856.GA18208@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	/* Minimal device size in bytes */
                                  ^
				  This should be megabytes
				  I will fix it in my tree
> +	unsigned int dev_min_size;
> +
> +	/* Device filesystem type override NULL == default */
> +	const char *dev_fs_type;
> +
> +	/* Options passed to SAFE_MKFS() when format_device is set */
> +	struct tst_dev_opts *dev_opts;
> +	const char *const *dev_fs_opts;
> +	const char *dev_extra_opt;
> +
> +	/* Device mount options, used if mount_device is set */
> +	const char *mntpoint;
> +	unsigned int mnt_flags;
> +	void *mnt_data;

-- 
Cyril Hrubis
chrubis@suse.cz
