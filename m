From: Murphy Zhou <xzhou@redhat.com>
Date: Wed, 1 Sep 2021 17:07:38 +0800
Subject: [LTP] [fs] f7e33bdbd6: ltp.ftruncate04_64.fail
In-Reply-To: <20210901030357.GD14661@xsang-OptiPlex-9020>
References: <20210825051710.GA5358@xsang-OptiPlex-9020>
 <cf358b73cbda90fd6c023f3a59a8df94698cf0bc.camel@kernel.org>
 <20210901030357.GD14661@xsang-OptiPlex-9020>
Message-ID: <CALWRkkhxg7pyL7yagJzdBarfkEc70q8te-xy2-LAAqrJu3Lw+w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In my test, CONFIG_MANDATORY_FILE_LOCKING is not set.

# mount(NULL, MNTPOINT, NULL, MS_REMOUNT|MS_MANDLOCK, NULL);

But the mount call in setup() returns 0, with setting errno to EFAULT.

This testcase needs some tweaking to have an accurate verdict about manlock.

The kernel return value for mount looks buggy too.

On Wed, Sep 1, 2021 at 10:46 AM Oliver Sang <oliver.sang@intel.com> wrote:
>
> Hi Jeff,
>
> On Wed, Aug 25, 2021 at 06:32:38AM -0400, Jeff Layton wrote:
> > On Wed, 2021-08-25 at 13:17 +0800, kernel test robot wrote:
> > >
> > > Greeting,
> > >
> > > FYI, we noticed the following commit (built with gcc-9):
> > >
> > > commit: f7e33bdbd6d1bdf9c3df8bba5abcf3399f957ac3 ("fs: remove mandatory file locking support")
> > > https://git.kernel.org/cgit/linux/kernel/git/jlayton/linux.git locks-next
> > >
> > >
> > > in testcase: ltp
> > > version: ltp-x86_64-14c1f76-1_20210821
> > > with following parameters:
> > >
> > >     disk: 1HDD
> > >     fs: ext4
> > >     test: syscalls-07
> > >     ucode: 0xe2
> > >
> > > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> > > test-url: http://linux-test-project.github.io/
> > >
> > >
> > > on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
> > >
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > >
> > >
> > >
> >
> > [...]
> >
> > > <<<test_start>>>
> > > tag=ftruncate04_64 stime=1629792639
> > > cmdline="ftruncate04_64"
> > > contacts=""
> > > analysis=exit
> > > <<<test_output>>>
> > > tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
> > > tst_test.c:916: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> > > mke2fs 1.44.5 (15-Dec-2018)
> > > tst_test.c:1348: TINFO: Timeout per run is 0h 25m 00s
> > > ftruncate04.c:116: TINFO: Child locks file
> > > ftruncate04.c:49: TFAIL: ftruncate() offset before lock succeeded unexpectedly
> > > ftruncate04.c:49: TFAIL: ftruncate() offset in lock succeeded unexpectedly
> > > ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded
> > > ftruncate04.c:127: TINFO: Child unlocks file
> > > ftruncate04.c:84: TPASS: ftruncate() offset in lock succeded
> > > ftruncate04.c:84: TPASS: ftruncate() offset before lock succeded
> > > ftruncate04.c:84: TPASS: ftruncate() offset after lock succeded
> > >
> > > Summary:
> > > passed   4
> > > failed   2
> > > broken   0
> > > skipped  0
> > > warnings 0
> >
> > I think this failed because of the above, which is expected now that we
> > ignore the "mand" mount option (and mandatory locking support is gone).
> >
> > Oliver, you may need to update the expected test output for this test.
>
> Thanks for the information! we will do the corresponding change ASAP
>
> >
> > Thanks,
> > --
> > Jeff Layton <jlayton@kernel.org>
> >
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

