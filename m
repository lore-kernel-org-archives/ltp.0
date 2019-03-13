From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Mar 2019 11:29:22 -0400 (EDT)
Subject: [LTP] LTP: mount02 was expected EINVAL(22) but got ENOENT(2):
 No such file or directory
In-Reply-To: <CA+G9fYudJC07HfrU1fVptCEvgCuBsF9G2N76PiGG5Z258z0Dzg@mail.gmail.com>
References: <CA+G9fYudJC07HfrU1fVptCEvgCuBsF9G2N76PiGG5Z258z0Dzg@mail.gmail.com>
Message-ID: <226607771.7950393.1552490962324.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> LTP syscalls mount02 failed on mainline (Linux version 5.0.0) for all
> devices.
> 
> Results comparison link,
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tests/mount02
> you could see good and bad commit id in the above link.

OK, so it's not "5.0.0" that fails, it's 5.0.0+ (5.0.0 + patches for 5.1.0-rc1)

I'm guessing this part:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/super.c#n1470
called by do_new_mount().

> 
> Error log,
> mount02 5 TFAIL : mount02.c:117: mount() was expected to fail with
> EINVAL(22): TEST_ERRNO=ENOENT(2): No such file or directory
> 
> Failure full log on x15 armv7,
> https://lkft.validation.linaro.org/scheduler/job/638009#L7462
> 
> structure Inputs,
> {&null, &mntpoint, &fs_type, 0, EINVAL, NULL, NULL},
> 
> Snippet  test code:
> --------------------------
> TEST(mount(*tc->device, *tc->mntpoint, *tc->fs_type, tc->flag, NULL));
> 
> if (TEST_RETURN != -1) {
> tst_resm(TFAIL, "mount() succeded unexpectedly (ret=%li)",
>          TEST_RETURN);
> goto cleanup;
> }
> 
> if (TEST_ERRNO != tc->exp_errno) {
> tst_resm(TFAIL | TTERRNO,
>          "mount() was expected to fail with %s(%i)",
>          tst_strerrno(tc->exp_errno), tc->exp_errno);
> goto cleanup;
> }
> 
> do you notice this mount02 failure on mainline kernel ?

5.0.0 looks fine on my x86 VM:

# uname -r
5.0.0

# ./mount02 
mount02     0  TINFO  :  Found free device '/dev/loop0'
mount02     0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.44.3 (10-July-2018)
mount02     1  TPASS  :  mount() failed expectedly: TEST_ERRNO=ENODEV(19): No such device
mount02     2  TPASS  :  mount() failed expectedly: TEST_ERRNO=ENOTBLK(15): Block device required
mount02     3  TPASS  :  mount() failed expectedly: TEST_ERRNO=EBUSY(16): Device or resource busy
mount02     4  TPASS  :  mount() failed expectedly: TEST_ERRNO=EBUSY(16): Device or resource busy
mount02     5  TPASS  :  mount() failed expectedly: TEST_ERRNO=EINVAL(22): Invalid argument
mount02     6  TPASS  :  mount() failed expectedly: TEST_ERRNO=EINVAL(22): Invalid argument
mount02     7  TPASS  :  mount() failed expectedly: TEST_ERRNO=EINVAL(22): Invalid argument
mount02     8  TPASS  :  mount() failed expectedly: TEST_ERRNO=EFAULT(14): Bad address
mount02     9  TPASS  :  mount() failed expectedly: TEST_ERRNO=EFAULT(14): Bad address
mount02    10  TPASS  :  mount() failed expectedly: TEST_ERRNO=ENAMETOOLONG(36): File name too long
mount02    11  TPASS  :  mount() failed expectedly: TEST_ERRNO=ENOENT(2): No such file or directory
mount02    12  TPASS  :  mount() failed expectedly: TEST_ERRNO=ENOTDIR(20): Not a directory
