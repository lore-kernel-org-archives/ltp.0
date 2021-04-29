From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 29 Apr 2021 20:53:38 +0800
Subject: [LTP] [PATCH 0/4] Replace TINFO with TPASS or TFAIL
Message-ID: <20210429125338.31609-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1)remove redundant Variables
2)remove redundant log
3)replace TINFO with TPASS or TFAIL

Zhao Gongyi (4):
  syscalls/writev: Replace TINFO with TPASS or TFAIL
  syscalls/modify_ldt: Replace TINFO with TPASS or TFAIL
  syscalls/getpgid01: Replace TINFO with TPASS or TFAIL
  syscalls/fcntl: Replace TINFO with TPASS or TFAIL

 testcases/kernel/syscalls/fcntl/fcntl16.c     | 70 ++++++------------
 testcases/kernel/syscalls/fcntl/fcntl18.c     | 40 ++--------
 testcases/kernel/syscalls/getpgid/getpgid01.c | 74 ++++---------------
 .../kernel/syscalls/modify_ldt/modify_ldt01.c | 44 +++--------
 .../kernel/syscalls/modify_ldt/modify_ldt02.c | 35 ++-------
 testcases/kernel/syscalls/writev/writev02.c   |  1 -
 testcases/kernel/syscalls/writev/writev05.c   | 16 +---
 testcases/kernel/syscalls/writev/writev06.c   | 15 +---
 8 files changed, 60 insertions(+), 235 deletions(-)

--
2.17.1

