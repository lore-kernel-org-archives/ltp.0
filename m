From: QI Fuli <fukuri.sai@gmail.com>
Date: Thu, 16 Sep 2021 00:51:48 +0900
Subject: [LTP] [PATCH v2 0/4] Convert syscalls/dup2/dup2{01...05} to new API
Message-ID: <20210915155152.8515-1-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Convert syscalls/dup2/dup2{01...05} to new API

QI Fuli (4):
  syscalls/dup2/dup201: Convert to new API
  syscalls/dup2/dup202: Convert to new API and merge dup204 into dup202
  syscalls/dup2/dup203: Convert to new API
  syscalls/dup2/dup205: Convert to new API

 testcases/kernel/syscalls/dup2/dup201.c | 174 +++------------
 testcases/kernel/syscalls/dup2/dup202.c | 190 +++++-----------
 testcases/kernel/syscalls/dup2/dup203.c | 282 +++++++++---------------
 testcases/kernel/syscalls/dup2/dup204.c | 128 -----------
 testcases/kernel/syscalls/dup2/dup205.c | 167 +++++---------
 5 files changed, 243 insertions(+), 698 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/dup2/dup204.c

-- 
2.31.1

