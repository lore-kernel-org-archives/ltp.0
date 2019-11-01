From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 1 Nov 2019 20:55:54 +0800
Subject: [LTP] [PATCH v3 0/5] optimize quotactl test code
In-Reply-To: <20191031152646.GA7078@dell5510>
References: <20191031152646.GA7078@dell5510>
Message-ID: <1572612959-20577-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I cleanup the quotactl code and add project quota test for quotactl.
Thanks to Jan Kara with support about quota.


------------
v2->v3:
1.for quotactl02.c, add group quota test
2.add quotactl04.c and add quota05.c to test project quota.
3.add quotactl06.c to test error
4. fix build erro on centos6 
ps:don't test Q_XQUOTARM in quotactl02,04 because cycle running will
report ENOSYS (quota feture has been off). I will introduce a
new test to test it and also a regression test for commit[1].
[1]https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=3dd4d40b420846dd35869ccc8f8627feef2cff32
[2]https://travis-ci.org/xuyang0410/ltp/builds/605963472?utm_medium=notification&utm_source=github_status
------------

Yang Xu (5):
  syscalls/quotactl01.c: Add Q_GETNEXQUOTA test
  syscalls/quotactl02.c: Add Q_XGETQSTATV test
  syscalls/quotactl04: add project quota test for non-xfs filesystem
  syscalls/quotactl05: add project quota test for xfs filesystem
  syscalls/quotactl06: Add new testcase

 configure.ac                                  |   1 +
 include/lapi/quotactl.h                       |  34 +--
 m4/ltp-quota.m4                               |   8 +
 runtest/syscalls                              |   3 +
 testcases/kernel/syscalls/quotactl/.gitignore |   4 +
 .../kernel/syscalls/quotactl/quotactl01.c     |  53 +++--
 .../kernel/syscalls/quotactl/quotactl02.c     | 193 +++++++-----------
 .../kernel/syscalls/quotactl/quotactl02.h     | 152 ++++++++++++++
 .../kernel/syscalls/quotactl/quotactl04.c     | 155 ++++++++++++++
 .../kernel/syscalls/quotactl/quotactl05.c     |  99 +++++++++
 .../kernel/syscalls/quotactl/quotactl06.c     | 183 +++++++++++++++++
 11 files changed, 745 insertions(+), 140 deletions(-)
 create mode 100644 m4/ltp-quota.m4
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl02.h
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl04.c
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl05.c
 create mode 100644 testcases/kernel/syscalls/quotactl/quotactl06.c

-- 
2.18.0



