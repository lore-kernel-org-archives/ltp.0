From: Caspar Zhang <caspar@casparzhang.com>
Date: Wed, 16 Oct 2019 10:54:05 +0800
Subject: [LTP] [PATCH v4] syscalls/sync_file_range: add partial file
 sync test-cases
In-Reply-To: <CAFA6WYNNyeU-tL4vg5PddwDOmU1gaGZJj3hRLYUCnJCY=MYNMw@mail.gmail.com>
References: <1560161596-30156-1-git-send-email-sumit.garg@linaro.org>
 <20190929132749.GB73158@casparzhang.com>
 <CAFA6WYNNyeU-tL4vg5PddwDOmU1gaGZJj3hRLYUCnJCY=MYNMw@mail.gmail.com>
Message-ID: <20191016025405.GA86846@casparzhang.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sumit,

On Fri, Oct 04, 2019 at 01:03:19PM +0530, Sumit Garg wrote:
> Hi Caspar,
>
> On Sun, 29 Sep 2019 at 18:58, Caspar Zhang <caspar@casparzhang.com> wrote:
> >
> > Hi Sumit,
> >
> > On Mon, Jun 10, 2019 at 03:43:16PM +0530, Sumit Garg wrote:
> >
> > <snip>
> >
> > >
> > > -     if (written >= FILE_SIZE)
> > > +     if ((written >= tc->exp_sync_size) &&
> > > +         (written <= (tc->exp_sync_size + tc->exp_sync_size/10)))
> >
> > May I ask why it is +1/10 of expected sync_size as upper bound here,
> > since it looks like a magic number to me.
>
> It was an outcome of discussion here [1]. The reason being to test
> that only particular portion of file is written to device for whom
> sync has been invoked and +1/10 as upper bound to incorporate for any
> metadata.

I see, thanks for explanation.

>
> [1] https://patchwork.ozlabs.org/patch/1051647/
>
> >
> > We encountered test failure in the second case in a debug kernel,
> > reproducible about once out of 20 times run.
>
> Interesting case. Can you share results after applying below patch?

Tested this patch, no TFAIL occured in debug kernel after 200+ times
run, looks good to me. Thanks! Please add my

Reviewed-by: Caspar Zhang <caspar@linux.alibaba.com>

directly if you're going to make a formal patch later.

Thanks,
Caspar

>
> diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> index eb08143..1bc1a44 100644
> --- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> +++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> @@ -42,7 +42,7 @@ struct testcase {
>  static void verify_sync_file_range(struct testcase *tc)
>  {
>         int fd;
> -       unsigned long written;
> +       unsigned long written, written_pre;
>
>         fd = SAFE_OPEN(tc->fname, O_RDWR|O_CREAT, MODE);
>
> @@ -52,6 +52,8 @@ static void verify_sync_file_range(struct testcase *tc)
>
>         tst_fill_fd(fd, 0, TST_MB, tc->write_size_mb);
>
> +       written_pre = tst_dev_bytes_written(tst_device->dev);
> +
>         TEST(sync_file_range(fd, tc->sync_off, tc->sync_size,
>                              SYNC_FILE_RANGE_WAIT_BEFORE |
>                              SYNC_FILE_RANGE_WRITE |
> @@ -70,8 +72,8 @@ static void verify_sync_file_range(struct testcase *tc)
>             (written <= (tc->exp_sync_size + tc->exp_sync_size/10)))
>                 tst_res(TPASS, "%s", tc->desc);
>         else
> -               tst_res(TFAIL, "%s: Synced %li, expected %li", tc->desc,
> -                       written, tc->exp_sync_size);
> +               tst_res(TFAIL, "%s: Synced %li, expected %li, pre-sync %li",
> +                       tc->desc, written, tc->exp_sync_size, written_pre);
>  }
>
>  static struct testcase testcases[] = {
>
> -Sumit
>
> >
> > The reason is unclear yet, however my guess is that more pages could be
> > written to disk in a debug kernel than a release kernel.
> >
> > My codes and config as below:
> >
> > tree: https://github.com/alibaba/cloud-kernel :: ck-4.19.67 branch;
> > config: https://github.com/alibaba/cloud-kernel/blob/master/config-4.19.y-x86_64-debug
> >
> > If you like you can build a test kernel on a KVM guest and try to
> > reproduce, or just run a RHEL8 kernel I guess (@Li Wang, you can have a
> > try on RHEL8 debug kernel if possible).
> >
> > a sample output:
> >
> > tst_device.c:87: INFO: Found free device 0 '/dev/loop0'
> > tst_supported_fs_types.c:60: INFO: Kernel supports ext2
> > tst_supported_fs_types.c:44: INFO: mkfs.ext2 does exist
> > tst_supported_fs_types.c:60: INFO: Kernel supports ext3
> > tst_supported_fs_types.c:44: INFO: mkfs.ext3 does exist
> > tst_supported_fs_types.c:60: INFO: Kernel supports ext4
> > tst_supported_fs_types.c:44: INFO: mkfs.ext4 does exist
> > tst_supported_fs_types.c:60: INFO: Kernel supports xfs
> > tst_supported_fs_types.c:44: INFO: mkfs.xfs does exist
> > tst_supported_fs_types.c:60: INFO: Kernel supports btrfs
> > tst_supported_fs_types.c:44: INFO: mkfs.btrfs does exist
> > tst_supported_fs_types.c:60: INFO: Kernel supports vfat
> > tst_supported_fs_types.c:44: INFO: mkfs.vfat does exist
> > tst_supported_fs_types.c:83: INFO: Filesystem exfat is not supported
> > tst_supported_fs_types.c:83: INFO: Filesystem ntfs is not supported
> > tst_test.c:1179: INFO: Testing on ext2
> > tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> > mke2fs 1.43.5 (04-Aug-2017)
> > tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> > sync_file_range02.c:71: PASS: Sync equals write
> > sync_file_range02.c:71: PASS: Sync inside of write
> > sync_file_range02.c:71: PASS: Sync overlaps with write
> > tst_test.c:1179: INFO: Testing on ext3
> > tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> > mke2fs 1.43.5 (04-Aug-2017)
> > tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> > sync_file_range02.c:71: PASS: Sync equals write
> > sync_file_range02.c:71: PASS: Sync inside of write
> > sync_file_range02.c:71: PASS: Sync overlaps with write
> > tst_test.c:1179: INFO: Testing on ext4
> > tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> > mke2fs 1.43.5 (04-Aug-2017)
> > tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> > sync_file_range02.c:71: PASS: Sync equals write
> > sync_file_range02.c:74: FAIL: Sync inside of write: Synced 19658752, expected 16777216
> >                         ^^^^
> > sync_file_range02.c:71: PASS: Sync overlaps with write
> > tst_test.c:1179: INFO: Testing on xfs
> > tst_mkfs.c:90: INFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> > tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> > sync_file_range02.c:71: PASS: Sync equals write
> > sync_file_range02.c:71: PASS: Sync inside of write
> > sync_file_range02.c:71: PASS: Sync overlaps with write
> > tst_test.c:1179: INFO: Testing on btrfs
> > tst_mkfs.c:90: INFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
> > tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> > sync_file_range02.c:71: PASS: Sync equals write
> > sync_file_range02.c:71: PASS: Sync inside of write
> > sync_file_range02.c:71: PASS: Sync overlaps with write
> > tst_test.c:1179: INFO: Testing on vfat
> > tst_mkfs.c:90: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> > tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> > sync_file_range02.c:111: INFO: Pre-filling file
> > sync_file_range02.c:71: PASS: Sync equals write
> > sync_file_range02.c:71: PASS: Sync inside of write
> > sync_file_range02.c:71: PASS: Sync overlaps with write
> >
> > Summary:
> > passed   17
> > failed   1
> > skipped  0
> > warnings 0
> >
> > Any thoughts would be appreicated.
> >
> > Thanks,
> > Caspar
> >
> >
> > >               tst_res(TPASS, "Test file range synced to device");
> > >       else
> > > -             tst_res(TFAIL, "Synced %li, expected %i", written, FILE_SIZE);
> > > +             tst_res(TFAIL, "Synced %li, expected %li", written,
> > > +                     tc->exp_sync_size);
> > > +}
> > > +
> > > +static struct testcase testcases[] = {
> > > +     { FNAME1, 0, FILE_SZ, FILE_SZ, 0, FILE_SZ_MB },
> > > +     { FNAME2, FILE_SZ/4, FILE_SZ/2, FILE_SZ/2, 0, FILE_SZ_MB },
> > > +     { FNAME3, FILE_SZ/4, FILE_SZ/2, FILE_SZ/4, FILE_SZ/2, FILE_SZ_MB/4 },
> > > +};
> > > +
> > > +static void run(unsigned int i)
> > > +{
> > > +     verify_sync_file_range(&testcases[i]);
> > >  }
> > >
> > >  static void setup(void)
> > >  {
> > >       if (!check_sync_file_range())
> > >               tst_brk(TCONF, "sync_file_range() not supported");
> > > +
> > > +     if (!strcmp(tst_device->fs_type, "vfat")) {
> > > +             tst_res(TINFO, "Pre-filling file");
> > > +             tst_fill_file(FNAME3, 0, TST_MB, FILE_SZ_MB);
> > > +             sync();
> > > +     }
> > >  }
> > >
> > >  static struct tst_test test = {
> > > +     .tcnt = ARRAY_SIZE(testcases),
> > >       .needs_root = 1,
> > >       .mount_device = 1,
> > >       .all_filesystems = 1,
> > >       .mntpoint = MNTPOINT,
> > >       .setup = setup,
> > > -     .test_all = verify_sync_file_range,
> > > +     .test = run,
> > >  };
> > > --
> > > 2.7.4
> > >
> > >
> > > --
> > > Mailing list info: https://lists.linux.it/listinfo/ltp
> >
> > --
> >         Thanks,
> >         Caspar

--
        Thanks,
        Caspar
