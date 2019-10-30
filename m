From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 30 Oct 2019 15:15:47 +0530
Subject: [LTP] [PATCH v4] syscalls/sync_file_range: add partial file
 sync test-cases
In-Reply-To: <CA+G9fYst7ZgkUE0+3YXx0o=ZW+XsxD6AFOpnZHwixBrgr43LJA@mail.gmail.com>
References: <1560161596-30156-1-git-send-email-sumit.garg@linaro.org>
 <20190929132749.GB73158@casparzhang.com>
 <CAFA6WYNNyeU-tL4vg5PddwDOmU1gaGZJj3hRLYUCnJCY=MYNMw@mail.gmail.com>
 <20191016025405.GA86846@casparzhang.com>
 <CAFA6WYNCHNyPb=GX-jLDHc2m=NGxH-Pgi10Dvvbc65stnV5VMA@mail.gmail.com>
 <20191017073653.GA2590@casparzhang.com>
 <CA+G9fYst7ZgkUE0+3YXx0o=ZW+XsxD6AFOpnZHwixBrgr43LJA@mail.gmail.com>
Message-ID: <CAFA6WYO_xaOqYmyx39OpvJDmjoMi_Cqn09t9+orvTbO2Lrzt-A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Naresh,

On Tue, 29 Oct 2019 at 11:39, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Hi Caspar and Sumit,
>
> > > > > > We encountered test failure in the second case in a debug kernel,
> > > > > > reproducible about once out of 20 times run.
> > > > >
> > > > > Interesting case. Can you share results after applying below patch?
> > > >
> > > > Tested this patch, no TFAIL occured in debug kernel after 200+ times
> > > > run, looks good to me. Thanks! Please add my
> > >
> > > From these results, the reason for the failure that you reported
> > > earlier seems to be writes to the device during "tst_fill_fd()"
> > > operation (they were found negligible/zero with normal kernel). But
> > > it's strange to know that you didn't get any TFAIL after the patch as
> > > I expected "Sync equals write" to fail.
> > >
> > > So can you also put following debug print and share logs of your test run?
> >
> > Retested with debug print, during my 1000-times run, pre-sync remains 0
> > in all the other fs types except only ext4. For ext4 cases, pre-sync
> > could be non-zero, e.g.:
> >
> >     Sync equals write: Synced 33554432, expected 33554432, pre-sync 0
> >     Sync inside of write: Synced 17301504, expected 16777216, pre-sync 1308672
> >     Sync overlaps with write: Synced 8650752, expected 8388608, pre-sync 1310720
> >
> > Note that pre-sync could be non-zero in `equals writes` case sometimes
> > too, like another round below:
> >
> >     Sync equals write: Synced 34078720, expected 33554432, pre-sync 260096
> >     Sync inside of write: Synced 17039360, expected 16777216, pre-sync 4980736
> >     Sync overlaps with write: Synced 8912896, expected 8388608, pre-sync 1048576
> >
> > Such non-zero situation in ext4 case is reproducible ~10% of my
> > 1000-times run.
>
> sync_file_range02 test failure reproduced on mainline and stable rc branches
> 5.3, 4.19, 4.14 on arm64 and arm devices while testing on ext4.
>

Can you test again with the fix proposed here [1]?

[1] http://lists.linux.it/pipermail/ltp/2019-October/014157.html

-Sumit

> output log,
> --------------
> tst_test.c:1179: INFO: Testing on ext2
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.43.8 (1-Jan-2018)
> tst_test.c:1118: INFO: Timeout per run is 0h 15m 00s
> sync_file_range02.c:71: PASS: Sync equals write
> sync_file_range02.c:71: PASS: Sync inside of write
> sync_file_range02.c:71: PASS: Sync overlaps with write
> tst_test.c:1179: INFO: Testing on ext3
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> mke2fs 1.43.8 (1-Jan-2018)
> Listened to connection for namespace 'tlxc' done
> [ 1349.061989] EXT4-fs (loop0): mounting ext3 file system using the
> ext4 subsystem
> [ 1349.099564] EXT4-fs (loop0): mounted filesystem with ordered data
> mode. Opts: (null)
> tst_test.c:1118: INFO: Timeout per run is 0h 15m 00s
> sync_file_range02.c:71: PASS: Sync equals write
> Listened to connection for namespace 'tlxc' done
> sync_file_range02.c:71: PASS: Sync inside of write
> sync_file_range02.c:71: PASS: Sync overlaps with write
> tst_test.c:1179: INFO: Testing on ext4
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> mke2fs 1.43.8 (1-Jan-2018)
> [ 1362.579639] EXT4-fs (loop0): mounted filesystem with ordered data
> mode. Opts: (null)
> tst_test.c:1118: INFO: Timeout per run is 0h 15m 00s
> sync_file_range02.c:74: FAIL: Sync equals write: Synced 36960256,
> expected 33554432
> Listened to connection for namespace 'tlxc' done
> sync_file_range02.c:74: FAIL: Sync inside of write: Synced 20185088,
> expected 16777216
> sync_file_range02.c:71: PASS: Sync overlaps with write
> Summary:
> passed   7
> failed   2
>
> Full output log,
> --------------------
> https://lkft.validation.linaro.org/scheduler/job/983166#L15067
>
> - Naresh
