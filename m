From: Xie Ziyao <xieziyao@huawei.com>
Date: Fri, 23 Apr 2021 17:59:42 +0800
Subject: [LTP] [PATCH 0/2] syscalls/sendfile: Convert sendfile{04,
 05} to the new API
Message-ID: <20210423095944.118255-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Convert sendfile{04,05} to the new API;
2. Remove the socket code of server/client and use SAFE_SOCKETPAIR() instead,
which can simplify the code logic.

Xie Ziyao (2):
  syscalls/sendfile: Convert sendfile04 to the new API
  syscalls/sendfile: Convert sendfile05 to the new API

 .../kernel/syscalls/sendfile/sendfile04.c     | 308 ++++--------------
 .../kernel/syscalls/sendfile/sendfile05.c     | 254 +++------------
 2 files changed, 102 insertions(+), 460 deletions(-)

--
2.17.1

