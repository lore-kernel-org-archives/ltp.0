From: QI Fuli <fukuri.sai@gmail.com>
Date: Sat, 27 Mar 2021 19:32:20 +0900
Subject: [LTP] [PATCH 0/6] Convert syscalls/swap{on,off}/ to the new API
Message-ID: <20210327103226.99073-1-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Rename libs/libltpswapon libs/libltpswap and Convert it to the new API
Convert syscalls/swap{on,off}/ to the new API

QI Fuli (6):
  libs/libltpswap: Add libs/libltpswap by using the new API
  syscalls/swapon/swapon01: Convert swapon01 to the new API
  syscalls/swapon/swapon02: Convert swapon02 to the new API
  syscalls/swapon/swapon03: Convert swapon03 to the new API
  syscalls/swapoff/swapoff01: Convert swapoff01 to the new API
  syscalls/swapoff/swapoff02: Convert swapoff02 to the new API

 include/libswap.h                             |  24 ++
 include/libswapon.h                           |  39 ---
 libs/{libltpswapon => libltpswap}/Makefile    |   2 +-
 libs/libltpswap/libswap.c                     |  63 +++++
 libs/libltpswapon/libswapon.c                 |  90 -------
 testcases/kernel/syscalls/swapoff/Makefile    |   4 +-
 testcases/kernel/syscalls/swapoff/swapoff01.c |  94 ++------
 testcases/kernel/syscalls/swapoff/swapoff02.c | 142 ++++-------
 testcases/kernel/syscalls/swapon/Makefile     |   4 +-
 testcases/kernel/syscalls/swapon/swapon01.c   |  83 ++-----
 testcases/kernel/syscalls/swapon/swapon02.c   | 145 ++++-------
 testcases/kernel/syscalls/swapon/swapon03.c   | 227 +++++++-----------
 12 files changed, 317 insertions(+), 600 deletions(-)
 create mode 100644 include/libswap.h
 delete mode 100644 include/libswapon.h
 rename libs/{libltpswapon => libltpswap}/Makefile (89%)
 create mode 100644 libs/libltpswap/libswap.c
 delete mode 100644 libs/libltpswapon/libswapon.c

-- 
2.30.2

