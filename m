From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 20 Nov 2019 17:13:31 +0800
Subject: [LTP] [PATCH v4 0/5]  optimize quotactl test code
Message-ID: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I cleanup the quotactl code and add project quota test for quotactl.
Thanks to Jan Kara with support about quota.


------------
v3->v4
check some new features(such as Q_GETNETXSTAT,Q_XGETNEXTSTAT,Q_XGETQSTATV)
whether supported in setup by using ltp customized struct
------------
Yang Xu (5):
  syscalls/quotactl01: Add Q_GETNEXTQUOTA test
  syscalls/quotactl02: Add Q_XGETQSTATV test and group quota tests
  syscalls/quotactl04: add project quota test for non-xfs filesystem
  syscalls/quotactl05: add project quota test on xfs filesystem
  syscalls/quotactl06: Add new error testcase

 configure.ac                                  |   1 +
 include/lapi/quotactl.h                       |  80 +++++--
 m4/ltp-quota.m4                               |   8 +
 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/quotactl/.gitignore |   3 +
 .../kernel/syscalls/quotactl/quotactl01.c     | 107 ++++++---
 .../kernel/syscalls/quotactl/quotactl02.c     | 222 ++++++++----------
 .../kernel/syscalls/quotactl/quotactl02.h     | 167 +++++++++++++
 .../kernel/syscalls/quotactl/quotactl04.c     | 162 +++++++++++++
 .../kernel/syscalls/quotactl/quotactl05.c     | 118 ++++++++++
 .../kernel/syscalls/quotactl/quotactl06.c     | 196 ++++++++++++++++
 11 files changed, 906 insertions(+), 161 deletions(-)
 create mode 100644 m4/ltp-quota.m4
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl02.h
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl04.c
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl05.c
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl06.c

-- 
2.18.0



