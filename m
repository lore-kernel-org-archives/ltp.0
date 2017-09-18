From: Sandeep Patil <sspatil@google.com>
Date: Mon, 18 Sep 2017 09:56:28 -0700
Subject: [LTP] [PATCH v3 0/2] libltp: add support for .needs_rofs for EROFS
	check
Message-ID: <20170918165630.134076-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Some tests go through losetup, create, format and mount
filesystems only to run tests for 'EROFS' return value from
system calls. The tests end up being flaky depending on the tools
available on the platform. e.g. mkfs.<filesystem> tool is required for 
mounting a device with filesystem.

If the test is only to check for EROFS, this can be achieved by simply doing a
'tmpfs' read-only mount in $tmpdir. So, this series adds a ".needs_rofs" flag
to 'struct tst_test' that can be used to indicate that the test only needs a
read-only filesystem mount ot test for 'EROFS' return value. If the flag is
set, the library will first attempt to mount 'tmpfs' filesystem at
tst_test->mntpoint and fallback to the original create, format and mount a
loopback device if that fails.

Example of tests that can benefit from this are:
  access04, mkdirat02, mknodat02, acct01, fchown04, mknod07 etc.

This also allows for these tests to successfully run on Android.

Sandeep Patil (2):
  libltp: add support to mount tmpfs for EROFS testing
  syscalls/access04: use .needs_rofs flag for EROFS testing

 include/tst_test.h                          |  1 +
 lib/tst_test.c                              | 36 ++++++++++++++++++++++++-----
 testcases/kernel/syscalls/access/access04.c |  3 +--
 3 files changed, 32 insertions(+), 8 deletions(-)

-- 
2.14.1.690.gbb1197296e-goog

