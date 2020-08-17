From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Mon, 17 Aug 2020 20:06:42 +0800
Subject: [LTP] [PATCH 0/2] Fix for syscalls/utimensat01 test on Ubuntu 4.4
 kernel
Message-ID: <20200817120644.9401-1-po-hsu.lin@canonical.com>
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

Also add support to get the distname for Ubuntu by using grep for
^ID=ubuntu from /etc/os-release in tst_kvcmp_distname()

There is no need to know the codename of the release, as we just need
distname UBUTNU and the detailed kernel version for tst_kvercmp2() to
compare the kernel version in syscalls/utimensat01.

Po-Hsu Lin (2):
  lib/tst_kvercmp: Add support to get distname for Ubuntu in
    tst_kvcmp_distname
  syscalls/utimensat01: add exception for Ubuntu 4.4 kernel

 lib/tst_kvercmp.c                                 |  5 +++++
 testcases/kernel/syscalls/utimensat/utimensat01.c | 11 +++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.17.1

