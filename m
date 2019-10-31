From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 31 Oct 2019 18:03:45 +0800
Subject: [LTP] [PATCH] syscalls/statx04: use stx_attributes_mask before
 test
In-Reply-To: <1571975625-6322-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190911124714.GA21670@rei.lan>
 <1571975625-6322-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <17268214-c14f-8c49-ba03-bd1a87055725@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All

Ping.

> stx_attributes_mask shows what's supported in stx_attributes.
> Set supp_{append,compr,immutable,nodump} attributes only on filesystems
> which actually support it.
>
> Also merge duplicate code.
>
> ---------------
> v2->v3:
> 1.add kernel version check for stx_attributes_mask
> 2. use test_flag(int) instead of test_flagged and test_unflagged
> ---------------
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/syscalls/statx/statx04.c | 158 +++++++++++++---------
>   1 file changed, 93 insertions(+), 65 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
> index 71de734f5..c0fa06d46 100644
> --- a/testcases/kernel/syscalls/statx/statx04.c
> +++ b/testcases/kernel/syscalls/statx/statx04.c
> @@ -34,85 +34,70 @@
>   #define TESTDIR_UNFLAGGED MOUNT_POINT"/test_dir2"
>   
>   static int fd, clear_flags;
> +static int supp_compr;
> +static int supp_append;
> +static int supp_immutable;
> +static int supp_nodump;
>   
> -static void test_flagged(void)
> +static void test_flag(int flag)
>   {
>   	struct statx buf;
>   
> -	TEST(statx(AT_FDCWD, TESTDIR_FLAGGED, 0, 0, &buf));
> -	if (TST_RET == 0)
> -		tst_res(TPASS,
> -			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
> -	else
> -		tst_brk(TFAIL | TTERRNO,
> -			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
> -
> -	if (buf.stx_attributes & STATX_ATTR_COMPRESSED)
> -		tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_COMPRESSED flag is not set");
> -
> -	if (buf.stx_attributes & STATX_ATTR_APPEND)
> -		tst_res(TPASS, "STATX_ATTR_APPEND flag is set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_APPEND flag is not set");
> -
> -	if (buf.stx_attributes & STATX_ATTR_IMMUTABLE)
> -		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_IMMUTABLE flag is not set");
> -
> -	if (buf.stx_attributes & STATX_ATTR_NODUMP)
> -		tst_res(TPASS, "STATX_ATTR_NODUMP flag is set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_NODUMP flag is not set");
> -}
> -
> -static void test_unflagged(void)
> -{
> -	struct statx buf;
> -
> -	TEST(statx(AT_FDCWD, TESTDIR_UNFLAGGED, 0, 0, &buf));
> +	TEST(statx(AT_FDCWD, flag ? TESTDIR_FLAGGED : TESTDIR_UNFLAGGED, 0, 0, &buf));
>   	if (TST_RET == 0)
>   		tst_res(TPASS,
>   			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
> -			TESTDIR_UNFLAGGED);
> +			flag ? TESTDIR_FLAGGED : TESTDIR_UNFLAGGED);
>   	else
>   		tst_brk(TFAIL | TTERRNO,
>   			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
> -			TESTDIR_UNFLAGGED);
> -
> -	if ((buf.stx_attributes & STATX_ATTR_COMPRESSED) == 0)
> -		tst_res(TPASS, "STATX_ATTR_COMPRESSED flag is not set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_COMPRESSED flag is set");
> -
> -	if ((buf.stx_attributes & STATX_ATTR_APPEND) == 0)
> -		tst_res(TPASS, "STATX_ATTR_APPEND flag is not set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_APPEND flag is set");
> -
> -	if ((buf.stx_attributes & STATX_ATTR_IMMUTABLE) == 0)
> -		tst_res(TPASS, "STATX_ATTR_IMMUTABLE flag is not set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_IMMUTABLE flag is set");
> -
> -	if ((buf.stx_attributes & STATX_ATTR_NODUMP) == 0)
> -		tst_res(TPASS, "STATX_ATTR_NODUMP flag is not set");
> -	else
> -		tst_res(TFAIL, "STATX_ATTR_NODUMP flag is set");
> +			flag ? TESTDIR_FLAGGED : TESTDIR_UNFLAGGED);
> +
> +	if (supp_compr) {
> +		if (buf.stx_attributes & STATX_ATTR_COMPRESSED)
> +			tst_res(flag ? TPASS : TFAIL,
> +				"STATX_ATTR_COMPRESSED flag is set");
> +		else
> +			tst_res(flag ? TFAIL : TPASS,
> +				"STATX_ATTR_COMPRESSED flag is not set");
> +	}
> +	if (supp_append) {
> +		if (buf.stx_attributes & STATX_ATTR_APPEND)
> +			tst_res(flag ? TPASS : TFAIL,
> +				"STATX_ATTR_APPEND flag is set");
> +		else
> +			tst_res(flag ? TFAIL : TPASS,
> +				"STATX_ATTR_APPEND flag is not set");
> +	}
> +	if (supp_immutable) {
> +		if (buf.stx_attributes & STATX_ATTR_IMMUTABLE)
> +			tst_res(flag ? TPASS : TFAIL,
> +				"STATX_ATTR_IMMUTABLE flag is set");
> +		else
> +			tst_res(flag ? TFAIL : TPASS,
> +				"STATX_ATTR_IMMUTABLE flag is not set");
> +	}
> +	if (supp_nodump) {
> +		if (buf.stx_attributes & STATX_ATTR_NODUMP)
> +			tst_res(flag ? TPASS : TFAIL,
> +				"STATX_ATTR_NODUMP flag is set");
> +		else
> +			tst_res(flag ? TFAIL : TPASS,
> +				"STATX_ATTR_NODUMP flag is not set");
> +	}
>   }
>   
>   struct test_cases {
> -	void (*tfunc)(void);
> +	void (*tfunc)(int);
> +	int set_flag;
>   } tcases[] = {
> -	{&test_flagged},
> -	{&test_unflagged},
> +	{&test_flag, 1},
> +	{&test_flag, 0},
>   };
>   
>   static void run(unsigned int i)
>   {
> -	tcases[i].tfunc();
> +	tcases[i].tfunc(tcases[i].set_flag);
>   }
>   
>   static void caid_flags_setup(void)
> @@ -135,12 +120,17 @@ static void caid_flags_setup(void)
>   		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd);
>   	}
>   
> -	attr |= FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
> +	if (supp_compr)
> +		attr |= FS_COMPR_FL;
> +	if (supp_append)
> +		attr |= FS_APPEND_FL;
> +	if (supp_immutable)
> +		attr |= FS_IMMUTABLE_FL;
> +	if (supp_nodump)
> +		attr |= FS_NODUMP_FL;
>   
>   	ret = ioctl(fd, FS_IOC_SETFLAGS, &attr);
>   	if (ret < 0) {
> -		if (errno == EOPNOTSUPP)
> -			tst_brk(TCONF, "Flags not supported");
>   		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_SETFLAGS, %i)", fd, attr);
>   	}
>   
> @@ -149,11 +139,49 @@ static void caid_flags_setup(void)
>   
>   static void setup(void)
>   {
> +	struct statx buf;
> +
> +	supp_compr = 1;
> +	supp_append = 1;
> +	supp_immutable = 1;
> +	supp_nodump = 1;
>   	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
>   	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
>   
> +	// don't check ext4 because ext4 supports statx since 4.11.
>   	if (!strcmp(tst_device->fs_type, "btrfs") && tst_kvercmp(4, 13, 0) < 0)
> -		tst_brk(TCONF, "Btrfs statx() supported since 4.13");
> +		tst_brk(TCONF, "Btrfs statx() stx_attributes_mask supported since 4.13");
> +
> +	if (!strcmp(tst_device->fs_type, "xfs") && tst_kvercmp(5, 1, 0) < 0)
> +		tst_brk(TCONF, "xfs statx() stx_attributes_mask supported since 5.1");
> +
> +	if (!strcmp(tst_device->fs_type, "ext2") && tst_kvercmp(5, 1, 0) < 0)
> +		tst_brk(TCONF, "ext2 statx() stx_attributes_mask supported since 5.1");
> +
> +	TEST(statx(AT_FDCWD, TESTDIR_FLAGGED, 0, 0, &buf));
> +	if (TST_RET == -1)
> +		tst_brk(TFAIL | TTERRNO,
> +			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTDIR_FLAGGED);
> +
> +	if ((buf.stx_attributes_mask & FS_COMPR_FL) == 0) {
> +		supp_compr = 0;
> +		tst_res(TCONF, "filesystem doesn't support FS_COMPR_FL");
> +	}
> +	if ((buf.stx_attributes_mask & FS_APPEND_FL) == 0) {
> +		supp_append = 0;
> +		tst_res(TCONF, "filesystem doesn't support FS_APPEND_FL");
> +	}
> +	if ((buf.stx_attributes_mask & FS_IMMUTABLE_FL) == 0) {
> +		supp_immutable = 0;
> +		tst_res(TCONF, "filesystem doesn't support FS_IMMUTABLE_FL");
> +	}
> +	if ((buf.stx_attributes_mask & FS_NODUMP_FL) == 0) {
> +		supp_nodump = 0;
> +		tst_res(TCONF, "filesystem doesn't support FS_NODUMP_FL");
> +	}
> +	if (!(supp_compr || supp_append || supp_immutable || supp_nodump))
> +		tst_brk(TCONF,
> +			"filesystem doesn't support the above any attr, skip it");
>   
>   	caid_flags_setup();
>   }


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191031/79aa4b66/attachment-0001.htm>
