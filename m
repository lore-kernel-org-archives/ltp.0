From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 26 Apr 2021 16:42:13 +0800
Subject: [LTP] [PATCH 0/2] Convert sendfile{03, 07} to the new API
Message-ID: <20210426084215.259071-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Cleanup and convert sendfile{03, 07} to the new API;
2. For sendfile03, remove the useless testcase in which out_fd = -1 and in_fd = -1.

Xie Ziyao (2):
  syscalls/sendfile: Convert sendfile03 to the new API
  syscalls/sendfile: Convert sendfile07 to the new API

 .../kernel/syscalls/sendfile/sendfile03.c     | 190 +++------------
 .../kernel/syscalls/sendfile/sendfile07.c     | 221 +++++-------------
 2 files changed, 93 insertions(+), 318 deletions(-)

--
2.17.1

