From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 29 Mar 2021 20:47:04 +0800
Subject: [LTP] [PATCH 0/3] syscalls/chown: rewrite chown/chown{02, 04,
 05} with the new api
Message-ID: <20210329124707.117102-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

*** BLURB HERE ***

Xie Ziyao (3):
  rewrite chown/chown04.c with the new api
  rewrite chown/chown02.c with the new api
  rewrite chown/chown05.c with the new api

 include/tst_safe_macros.h                 |  12 +
 testcases/kernel/syscalls/chown/chown02.c | 297 ++++++----------------
 testcases/kernel/syscalls/chown/chown04.c | 207 ++++++---------
 testcases/kernel/syscalls/chown/chown05.c | 201 +++++----------
 4 files changed, 220 insertions(+), 497 deletions(-)

--
2.17.1

