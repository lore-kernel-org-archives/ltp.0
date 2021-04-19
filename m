From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 19 Apr 2021 20:22:44 +0800
Subject: [LTP] [PATCH 0/2] syscalls/unshare: convert unshare to the new API
Message-ID: <20210419122246.7706-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Xie Ziyao (2):
  convert unshare01 to the new API
  convert unshare02 to the new API

 testcases/kernel/syscalls/unshare/unshare01.c | 304 ++----------------
 testcases/kernel/syscalls/unshare/unshare02.c | 231 ++-----------
 2 files changed, 68 insertions(+), 467 deletions(-)

--
2.17.1

