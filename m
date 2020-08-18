From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Tue, 18 Aug 2020 18:04:20 +0800
Subject: [LTP] [PATCHv2 0/2] Fix for syscalls/utimensat01 test on Ubuntu 4.4
 kernel
Message-ID: <20200818100422.27775-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ubuntu 4.4 kernel got the backported kernel patch (b3b4283) for
syscalls/utimensat01 since 4.4.0-48.69, therefore it will return
EPERM instead of EACCES.

Without this fix, the test will fail on Ubuntu 4.4 kernel with:
  FAIL: 18: utimensat() failed with incorrect error, expected EACCES: EPERM (1)
  FAIL: 19: utimensat() failed with incorrect error, expected EACCES: EPERM (1)

Add Ubuntu kernel version comparison to fix this.

Also add support to get the distname for different OS by parsing ID=
from /etc/os-release in tst_kvcmp_distname()

Po-Hsu Lin (2):
  lib/tst_kvercmp: Add support to get distname for different OS in
    tst_kvcmp_distname
  syscalls/utimensat01: add exception for Ubuntu 4.4 kernel

 lib/tst_kvercmp.c                                | 16 ++++++++++++++++
 .../kernel/syscalls/utimensat/utimensat01.c      |  7 ++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.25.1

