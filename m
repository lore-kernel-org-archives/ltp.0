From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 21 Oct 2019 19:36:58 +0800
Subject: [LTP] [PATCH 0/4] optimize quotactl code
Message-ID: <1571657822-31421-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello

I cleanup the quotactl code. 
Remove useless ltp-xfs_quota.m4 and rewriting ltp_quota.m4. Also add Q_GETNEXTQUOTA and Q_XGETQSTATV flag
test. 

The build travis-ci log as below:
https://travis-ci.org/xuyang0410/ltp/jobs/600658655

It build failed on some linux distributions because quotactl function return value is different. In sys/quota.h it is int,
in linux/quota.h is long. I use linux/quota.h because I want to use if_nextdqblk struct to test Q_GETNEXQUOTA
flag. I doubt whether I need to fix the build error by custom define the if_nextdqblk struct or it is a old kernel
uncompatible bug I don't need to fix.

ps:
I am writing quotactl testcases about project quota for #529. 
I will send it tomorrow.

Yang Xu (4):
  syscalls/quotactl: Don't use ltp-quota.m4
  m4/ltp-xfs_quota.m4: Remove useless ltp?xfs_quota.m4
  syscalls/quotactl01.c: Add Q_GETNEXQUOTA test
  syscalls/quotactl02.c: Add Q_XGETQSTATV test

 configure.ac                                  |   2 +-
 include/lapi/quotactl.h                       |  27 ++--
 m4/ltp-quota.m4                               |  36 +----
 m4/ltp-xfs_quota.m4                           |  23 ---
 .../kernel/syscalls/quotactl/quotactl01.c     | 133 ++++++++++--------
 .../kernel/syscalls/quotactl/quotactl02.c     |  89 ++++++++++--
 .../kernel/syscalls/quotactl/quotactl03.c     |  22 ++-
 7 files changed, 176 insertions(+), 156 deletions(-)
 delete mode 100644 m4/ltp-xfs_quota.m4

-- 
2.18.0



