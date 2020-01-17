From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 17 Jan 2020 12:24:47 -0500 (EST)
Subject: [LTP] LTP: statx06: FAIL: Birth time < before time
In-Reply-To: <CA+G9fYuBdcZvE6VPm9i2=F0mK5u3j6Z+RHbFBQ1zh9qbN_4kaw@mail.gmail.com>
References: <CA+G9fYuBdcZvE6VPm9i2=F0mK5u3j6Z+RHbFBQ1zh9qbN_4kaw@mail.gmail.com>
Message-ID: <1555311261.2497849.1579281887353.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> LTP syscalls statx06 test case getting failed from linux next 20200115
> tag onwards on all x86_64, i386, arm and arm64 devices
> 
> Test output:
> statx06.c:152: FAIL: Birth time < before time

[CC Theo & linux-ext4]

It's returning '0' in stx_btime for STATX_ALL or STATX_BTIME.

Looking@changes, I suspect:
  commit 927353987d503b24e1813245563cde0c6167af6e
  Author: Theodore Ts'o <tytso@mit.edu>
  Date:   Thu Nov 28 22:26:51 2019 -0500
    ext4: avoid fetching btime in ext4_getattr() unless requested

and that perhaps it should be instead...

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c8355f022e6e..6d76eb6d2e7f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5398,7 +5398,7 @@ int ext4_getattr(const struct path *path, struct kstat *stat,
        struct ext4_inode_info *ei = EXT4_I(inode);
        unsigned int flags;

-       if ((query_flags & STATX_BTIME) &&
+       if ((request_mask & STATX_BTIME) &&
            EXT4_FITS_IN_INODE(raw_inode, ei, i_crtime)) {
                stat->result_mask |= STATX_BTIME;
                stat->btime.tv_sec = ei->i_crtime.tv_sec;

That allows test to pass again.

> statx06.c:156: PASS: Modified time Passed
> statx06.c:156: PASS: Access time Passed
> statx06.c:156: PASS: Change time Passed
> 
> strace output snippet:
> [pid   498] clock_getres(CLOCK_REALTIME_COARSE, {tv_sec=0, tv_nsec=1000000})
> = 0
> [pid   498] nanosleep({tv_sec=0, tv_nsec=1000000}, NULL) = 0
> [pid   498] openat(AT_FDCWD, \"mount_ext/test_file.txt\",
> O_RDWR|O_CREAT, 0666) = 3
> [pid   498] clock_getres(CLOCK_REALTIME_COARSE, {tv_sec=0, tv_nsec=1000000})
> = 0
> [pid   498] nanosleep({tv_sec=0, tv_nsec=1000000}, NULL) = 0
> [pid   498] statx(AT_FDCWD, \"mount_ext/test_file.txt\",
> AT_STATX_SYNC_AS_STAT, STATX_ALL, {stx_mask=STATX_BASIC_STATS,
> stx_attributes=0, stx_mode=S_IFREG|0644, stx_size=0, ...}) = 0
> [pid   498] write(2, \"statx06.c:152: \33[1;31mFAIL: \33[0m\"...,
> 57statx06.c:152: [1;31mFAIL: [0mBirth time < before time
> ) = 57
> 
> Full test log link,
> https://lkft.validation.linaro.org/scheduler/job/1107634#L2276
> 
> Test results comparison link,
> https://qa-reports.linaro.org/lkft/linux-next-oe/tests/ltp-syscalls-tests/statx06
> 
> Test case link,
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/statx/statx06.c
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 
> 

