From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 20 May 2021 17:24:47 +0800
Subject: [LTP] [PATCH 0/2 v2] syscalls/sendfile: Convert sendfile{08,
 09} to the new API
Message-ID: <20210520092449.162043-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v1->v2:
1. Add kernel commit to the tst_test structure as a tags;
2. Move [Restrictions] to [Description] for sendfile09;
3. Fix the bug in the previous version for sendfile09 on 32-bit:
   + #include "lapi/abisize.h"
   +
   + #ifndef TST_ABI32
   ...
   + #else
   + TST_TEST_TCONF("This test is only for 64bit");
   + #endif

Xie Ziyao (2):
  syscalls/sendfile: Convert sendfile08 to the new API
  syscalls/sendfile: Convert sendfile09 to the new API

 .../kernel/syscalls/sendfile/sendfile08.c     | 142 ++++-------
 .../kernel/syscalls/sendfile/sendfile09.c     | 236 ++++++------------
 2 files changed, 126 insertions(+), 252 deletions(-)

--
2.17.1

