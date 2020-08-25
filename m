From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 25 Aug 2020 18:07:31 +0200
Subject: [LTP] [PATCH v2 0/4] Improve reliability of ioctl_sg01
Message-ID: <20200825160735.24602-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ioctl_sg01 needs dirty memory to reliably detect kernel data leaks. Its
description originally recommended running it after mem01 which has been
recently dropped.

Add helper function to LTP library for pre-polluting free memory and loop
the main check in ioctl_sg01 to further decrease the chance of false negative.

Martin Doucha (4):
  Add SAFE_SYSINFO() macro
  Add tst_pollute_memory() helper function
  ioctl_sg01: Pollute free memory in setup
  ioctl_sg01: Loop data leak check 100 times

 include/tst_memutils.h                       | 22 +++++++
 include/tst_safe_macros.h                    |  5 ++
 lib/safe_macros.c                            | 20 +++++++
 lib/tst_memutils.c                           | 62 ++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 32 ++++++----
 5 files changed, 128 insertions(+), 13 deletions(-)
 create mode 100644 include/tst_memutils.h
 create mode 100644 lib/tst_memutils.c

-- 
2.28.0

