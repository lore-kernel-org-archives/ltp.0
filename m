From: QI Fuli <fukuri.sai@gmail.com>
Date: Fri, 26 Mar 2021 03:19:02 +0900
Subject: [LTP] [PATCH 0/4] Convert swapon/swapon0{1..3} to the new API
Message-ID: <20210325181906.40688-1-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Convert syscalls/swapon/swapon0{1..3} to the new API

QI Fuli (4):
  libs/libltpswap: Rename and Convert libs/libltpswapon to the new API
  syscalls/swapon/swapon01: Convert swapon01 to the new API
  syscalls/swapon/swapon02: Convert swapon02 to the new API
  syscalls/swapon/swapon03: Convert swapon03 to the new API

 include/libswap.h                           |  24 +++
 libs/libltpswap/Makefile                    |  12 ++
 libs/libltpswap/libswap.c                   |  63 ++++++
 testcases/kernel/syscalls/swapon/Makefile   |   4 +-
 testcases/kernel/syscalls/swapon/swapon01.c |  83 ++-----
 testcases/kernel/syscalls/swapon/swapon02.c | 145 +++++--------
 testcases/kernel/syscalls/swapon/swapon03.c | 227 ++++++++------------
 7 files changed, 258 insertions(+), 300 deletions(-)
 create mode 100644 include/libswap.h
 create mode 100644 libs/libltpswap/Makefile
 create mode 100644 libs/libltpswap/libswap.c

--
2.30.2

