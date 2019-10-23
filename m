From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 23 Oct 2019 17:00:25 +0800
Subject: [LTP] [PATCH v2 0/6] optimize quotactl test code
Message-ID: <1571821231-3846-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I cleanup the quotactl code and add project quota test for quotactl.
Thanks to Jan Kara with support about quota.


------------
v1->v2:
for quotactl02.c, add group quota test and add Q_XQUTOARM test

add quotactl04.c and add quota05.c to test project quota.
------------

Yang Xu (6):
  syscalls/quotactl: Don't use ltp-quota.m4
  m4/ltp-xfs_quota.m4: Remove useless ltp?xfs_quota.m4
  syscalls/quotactl01.c: Add Q_GETNEXQUOTA test
  syscalls/quotactl02.c: Add Q_XGETQSTATV and Q_XQUOTARM test
  syscalls/quotactl04: add project quota test for non-xfs filesystem
  syscalls/quotactl05: add project quota test for xfs filesystem

 configure.ac                                  |   2 +-
 include/lapi/quotactl.h                       |  35 ++-
 m4/ltp-quota.m4                               |  36 +--
 m4/ltp-xfs_quota.m4                           |  23 --
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/quotactl/.gitignore |   2 +
 .../kernel/syscalls/quotactl/quotactl01.c     | 133 +++++----
 .../kernel/syscalls/quotactl/quotactl02.c     | 218 +++++++++++---
 .../kernel/syscalls/quotactl/quotactl03.c     |  22 +-
 .../kernel/syscalls/quotactl/quotactl04.c     | 159 ++++++++++
 .../kernel/syscalls/quotactl/quotactl05.c     | 276 ++++++++++++++++++
 11 files changed, 727 insertions(+), 181 deletions(-)
 delete mode 100644 m4/ltp-xfs_quota.m4
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl04.c
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl05.c

-- 
2.18.0



