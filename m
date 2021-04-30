From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 30 Apr 2021 17:45:10 +0800
Subject: [LTP] [PATCH 0/3 v2] syscalls/chown: Rewrite chown/chown{02, 04,
 05} with the new api
Message-ID: <20210430094513.162499-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao (3):
  syscalls/chown: Rewrite chown/chown02.c with the new api
  syscalls/chown: Rewrite chown/chown04.c with the new api
  syscalls/chown: Rewrite chown/chown05.c with the new api

 include/tst_safe_macros.h                 |  12 +
 testcases/kernel/syscalls/chown/chown02.c | 307 ++++------------------
 testcases/kernel/syscalls/chown/chown04.c | 229 +++++-----------
 testcases/kernel/syscalls/chown/chown05.c | 195 +++-----------
 4 files changed, 175 insertions(+), 568 deletions(-)

--
2.17.1

