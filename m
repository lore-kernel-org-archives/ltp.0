From: Michael Moese <mmoese@suse.de>
Date: Mon, 12 Feb 2018 11:03:38 +0100
Subject: [LTP] [PATCH v4 0/3] Add regression test for CVE-2017-17053
Message-ID: <20180212100341.23841-1-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a regression test for CVE-2017-17053. This testcase is depending
on some new library functions included in this series.

This patch series consists of reworked patches according to previous
review comments, as well as a small new library wrapper function
SAFE_SIGACTION() to install a signal handler.

I made this entire series a v4, as the the library support for 
/proc/sys/kernel/tainted was previously a v3.

Michael Moese (3):
  Add library support for /proc/sys/kernel/tainted
  Add a library wrapper for sigaction()
  Add regression test for CVE-2017-17053

 doc/test-writing-guidelines.txt |  42 +++++++++++++
 include/tst_safe_macros.h       |  20 ++++++
 include/tst_taint.h             | 104 +++++++++++++++++++++++++++++++
 lib/tst_taint.c                 | 106 ++++++++++++++++++++++++++++++++
 runtest/cve                     |   1 +
 testcases/cve/.gitignore        |   1 +
 testcases/cve/Makefile          |   1 +
 testcases/cve/cve-2017-17053.c  | 132 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 407 insertions(+)
 create mode 100644 include/tst_taint.h
 create mode 100644 lib/tst_taint.c
 create mode 100644 testcases/cve/cve-2017-17053.c

-- 
2.13.6

