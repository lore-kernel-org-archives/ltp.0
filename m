From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 3 Jun 2021 11:36:08 +0800
Subject: [LTP] [PATCH 0/3] Fix and convert sendfile{02, 06} to the new API
Message-ID: <20210603033611.15619-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. Convert sendfile{02, 06} to the new API with file descriptors instead
of socket descriptors.
2. Remove the support for UCLINUX.
3. Remove redundant testcases {4, 22, 26} and {6, 20, 26} for
sendfile02.
4. Remove unnecessary header files for sendfile{03, 04, 05, 07}.

Xie Ziyao (3):
  syscalls/sendfile: Convert sendfile02 to the new API
  syscalls/sendfile: Convert sendfile06 to the new API
  syscalls/sendfile: Remove unnecessary header files

 .../kernel/syscalls/sendfile/sendfile02.c     | 323 ++++--------------
 .../kernel/syscalls/sendfile/sendfile03.c     |   3 -
 .../kernel/syscalls/sendfile/sendfile04.c     |   9 -
 .../kernel/syscalls/sendfile/sendfile05.c     |   9 -
 .../kernel/syscalls/sendfile/sendfile06.c     | 247 +++-----------
 .../kernel/syscalls/sendfile/sendfile07.c     |   9 -
 6 files changed, 108 insertions(+), 492 deletions(-)

--
2.17.1

