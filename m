From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 2 Mar 2020 13:51:47 +0530
Subject: [LTP] [PATCH V5 05/10] syscalls/fsconfig: New tests
In-Reply-To: <20200228160149.GA5312@dell5510>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
 <01949a4ba3d2c125a9be8422ec27c8436a53f6a8.1582779464.git.viresh.kumar@linaro.org>
 <20200228160149.GA5312@dell5510>
Message-ID: <20200302082147.zucnweqqdaaaaxyi@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 28-02-20, 17:01, Petr Vorel wrote:
> > +	TEST(fsmfd = fsmount(fd, 0, 0));
> > +	if (fsmfd == -1) {
> > +		tst_res(TBROK | TERRNO, "fsmount() failed");
> > +		goto out;
> BTW This needs to be now tst_res(TFAIL) (this patchset now does not compile).

For a minute I thought I failed with my testing :(

And then I looked at the recent changes and looks like compilation
broke due to the changes you have pushed recently. Right ?

> > +	TEST(fsconfig(fd, FSCONFIG_SET_FD, "sync", NULL, 0));
> > +	if (TST_RET == -1) {
> > +		if (TST_ERR == EOPNOTSUPP) {
> > +			tst_res(TCONF, "fsconfig(): FSCONFIG_SET_FD not supported");
> > +		} else {
> > +			tst_res(TFAIL | TERRNO, "fsconfig() failed");
> > +			goto out;
> > +		}
> > +	}
> 
> I get TCONF for all fsconfig01 results, while I'm using 5.5.5-1-default:

s/all/most/

I know, same here.


> tst_test.c:1290: INFO: Testing on ext2
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.45.5 (07-Jan-2020)
> tst_test.c:1227: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:43: CONF: fsconfig(): FSCONFIG_SET_PATH not supported
> fsconfig01.c:53: CONF: fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported
> fsconfig01.c:63: CONF: fsconfig(): FSCONFIG_SET_FD not supported
> fsconfig01.c:92: PASS: fsconfig() passed
> tst_test.c:1290: INFO: Testing on ext3
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> mke2fs 1.45.5 (07-Jan-2020)
> tst_test.c:1227: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:43: CONF: fsconfig(): FSCONFIG_SET_PATH not supported
> fsconfig01.c:53: CONF: fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported
> fsconfig01.c:63: CONF: fsconfig(): FSCONFIG_SET_FD not supported
> fsconfig01.c:92: PASS: fsconfig() passed
> tst_test.c:1290: INFO: Testing on ext4
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> mke2fs 1.45.5 (07-Jan-2020)
> tst_test.c:1227: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:43: CONF: fsconfig(): FSCONFIG_SET_PATH not supported
> fsconfig01.c:53: CONF: fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported
> fsconfig01.c:63: CONF: fsconfig(): FSCONFIG_SET_FD not supported
> fsconfig01.c:92: PASS: fsconfig() passed
> tst_test.c:1290: INFO: Testing on xfs
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> tst_test.c:1227: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:92: PASS: fsconfig() passed

You didn't get them for xfs :)

> tst_test.c:1290: INFO: Testing on btrfs
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
> tst_test.c:1227: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:43: CONF: fsconfig(): FSCONFIG_SET_PATH not supported
> fsconfig01.c:53: CONF: fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported
> fsconfig01.c:63: CONF: fsconfig(): FSCONFIG_SET_FD not supported
> fsconfig01.c:92: PASS: fsconfig() passed
> tst_test.c:1290: INFO: Testing on vfat
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> tst_test.c:1227: INFO: Timeout per run is 0h 05m 00s
> fsconfig01.c:43: CONF: fsconfig(): FSCONFIG_SET_PATH not supported
> fsconfig01.c:53: CONF: fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported
> fsconfig01.c:63: CONF: fsconfig(): FSCONFIG_SET_FD not supported
> fsconfig01.c:92: PASS: fsconfig() passed
> 
> Not yet merged man page [1] (I reposted David Howells commit) there is
> explanation for EOPNOTSUPP: The command given by cmd was not valid.
> 
> First, I suspected "sync" option is wrong. But looking at kernel sources it's
> really not implemented:
> 
> fs/fsopen.c
> 	if (fc->ops == &legacy_fs_context_ops) {
> 		switch (cmd) {
> 		case FSCONFIG_SET_BINARY:
> 		case FSCONFIG_SET_PATH:
> 		case FSCONFIG_SET_PATH_EMPTY:
> 		case FSCONFIG_SET_FD:
> 			ret = -EOPNOTSUPP;
> 			goto out_f;
> 		}
> 	}
> 
> fs/fs_context.c
> 	/* TODO: Make all filesystems support this unconditionally */
> 	init_fs_context = fc->fs_type->init_fs_context;
> 	if (!init_fs_context)
> 		init_fs_context = legacy_init_fs_context;
> ...
> /*
>  * Initialise a legacy context for a filesystem that doesn't support
>  * fs_context.
>  */
> static int legacy_init_fs_context(struct fs_context *fc)
> {
> 	fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL);
> 	if (!fc->fs_private)
> 		return -ENOMEM;
> 	fc->ops = &legacy_fs_context_ops;
> 	return 0;
> }

Right, I have seen that all earlier and so I knew that the failures
here are just fine.

> Code coming from v5.1-rc1 f3a09c92018a91ad0981146a4ac59414f814d801 introduce
> fs_context methods [2]. Other patchsets here [3] shows there is some support for
> fs_context in VFS. So I wonder how to achieve not end up with legacy context.
> 
> > +++ b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
> > +  {"set-path-key", &fd, FSCONFIG_SET_PATH, NULL, "/dev/sda1", &aux_fdcwd, EINVAL},
> ...
> > +  {"set-path-aux", &fd, FSCONFIG_SET_PATH, "sync", "/dev/sda1", &aux_minus1, EINVAL},
> /dev/sda1 is valid on some hosts, but invalid on others. Shouldn't we use
> /dev/foo instead?

Should be fine I think.

> ...
> > +	temp_fd = open("testfile", O_RDWR | O_CREAT, 01444);
> > +	if (temp_fd == -1)
> > +		tst_res(TBROK, "Can't obtain temp_fd, open() failed");
> Here needs to be now tst_brk(TBROK).
> Again I'll change it before merge.

Thanks.

-- 
viresh
