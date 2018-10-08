From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 8 Oct 2018 13:54:11 +0200
Subject: [LTP] [PATCH 1/1] syscalls/statx04: TCONF on BTRFS for kernel <
	4.13
In-Reply-To: <20181008093322.8624-1-pvorel@suse.cz>
References: <20181008093322.8624-1-pvorel@suse.cz>
Message-ID: <20181008115411.GA13162@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
> index 8caf092db..2e1dc8569 100644
> --- a/testcases/kernel/syscalls/statx/statx04.c
> +++ b/testcases/kernel/syscalls/statx/statx04.c
> @@ -32,6 +32,7 @@
>  #define MOUNT_POINT "mntpoint"
>  #define TESTDIR_FLAGGED MOUNT_POINT"/test_dir1"
>  #define TESTDIR_UNFLAGGED MOUNT_POINT"/test_dir2"
> +#define BTRFS_STATX_SUPPORT "4.13.0"
>  
>  static int fd, clear_flags;
>  
> @@ -152,6 +153,17 @@ static void setup(void)
>  	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
>  	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
>  
> +	if (!strcmp(tst_device->fs_type, "btrfs")) {
> +		int v1, v2, v3;
> +		if (tst_parse_kver(BTRFS_STATX_SUPPORT, &v1, &v2, &v3))
> +			tst_res(TWARN,
> +					"Invalid kernel version %s, expected %%d.%%d.%%d",
> +					BTRFS_STATX_SUPPORT);
> +		if (tst_kvercmp(v1, v2, v3) < 0)
> +			tst_brk(TCONF, "BTRFS supports statx from kernel %s ",
> +					BTRFS_STATX_SUPPORT);

Why not just:

	if (!strcmp(tst_device->fs_type, "btrfs") && tst_kvercmp(4, 13, 0) < 0)
		tst_brk(TCONF, "Btrfs statx() supported since 4.13");


There is no point in parsing a statically defined string that will never
change with tst_parse_kver().

> +	}
> +
>  	caid_flags_setup();
>  }
>  
> -- 
> 2.19.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
