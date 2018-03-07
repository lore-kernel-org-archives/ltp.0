From: Michael Moese <mmoese@suse.de>
Date: Wed,  7 Mar 2018 09:05:16 +0100
Subject: [LTP] [PATCH v5 0/3] Add regression test for CVE-2017-17053
Message-ID: <20180307080519.15066-1-mmoese@suse.de>
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

This v5 series contains changes according to suggestions after review.


Michael Moese (3):
  Add library support for /proc/sys/kernel/tainted
  Add a library wrapper for sigaction()
  Add regression test for CVE-2017-17053

 doc/test-writing-guidelines.txt |  42 ++++++++++
 include/tst_safe_macros.h       |  20 +++++
 include/tst_taint.h             | 104 ++++++++++++++++++++++++
 lib/tst_taint.c                 | 106 +++++++++++++++++++++++++
 runtest/cve                     |   1 +
 testcases/cve/.gitignore        |   1 +
 testcases/cve/Makefile          |   1 +
 testcases/cve/cve-2017-17053.c  | 171 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 446 insertions(+)
 create mode 100644 include/tst_taint.h
 create mode 100644 lib/tst_taint.c
 create mode 100644 testcases/cve/cve-2017-17053.c

-- 
2.13.6

