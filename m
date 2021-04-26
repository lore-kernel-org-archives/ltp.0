From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 26 Apr 2021 20:52:21 +0800
Subject: [LTP] [PATCH 0/3 v2] syscalls/close: Convert close{01, 02,
 08} to the new API
Message-ID: <20210426125224.150268-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao (3):
  syscalls/close: Convert close01 to the new API
  syscalls/close: Convert close02 to the new API
  syscalls/close: Convert close08 to the new API

 testcases/kernel/syscalls/close/close01.c | 134 +++++-----------
 testcases/kernel/syscalls/close/close02.c | 122 ++------------
 testcases/kernel/syscalls/close/close08.c | 186 +++-------------------
 3 files changed, 76 insertions(+), 366 deletions(-)

--
2.17.1

