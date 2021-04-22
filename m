From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 22 Apr 2021 14:57:30 +0800
Subject: [LTP] [PATCH 0/2] syscalls/tkill: Convert tkill{01,
 02} to the new API
Message-ID: <20210422065732.61222-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Capture signals to verify success in tkill01.c, while the previous code
didn't make it work;
2. Cleanup and convert tkill{01, 02} to the new API.

Xie Ziyao (2):
  syscalls/tkill: Convert tkill01 to the new API
  syscalls/tkill: Convert tkill02 to the new API

 testcases/kernel/syscalls/tkill/tkill01.c | 122 +++++++---------------
 testcases/kernel/syscalls/tkill/tkill02.c | 105 ++++++-------------
 2 files changed, 70 insertions(+), 157 deletions(-)

--
2.17.1

