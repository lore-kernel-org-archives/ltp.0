From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 1 Jul 2021 11:29:29 +0800
Subject: [LTP] [PATCH 0/2] syscalls/fork: Rewrite fork{07,
 08} to a proper synchronization
Message-ID: <20210701032931.132468-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: #774

Xie Ziyao (2):
  fork07: Rewrite the test to a proper synchronization
  fork08: Rewrite the test to a proper synchronization

 testcases/kernel/syscalls/fork/fork07.c | 253 +++++++-----------------
 testcases/kernel/syscalls/fork/fork08.c | 198 +++++--------------
 2 files changed, 118 insertions(+), 333 deletions(-)

--
2.17.1

