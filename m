From: QI Fuli <fukuri.sai@gmail.com>
Date: Sat, 18 Sep 2021 21:11:09 +0900
Subject: [LTP] [PATCH v5 0/5] Convert syscalls/dup2/dup2{01...05} to new API
Message-ID: <20210918121114.10694-1-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Convert syscalls/dup2/dup2{01...05} to new API

QI Fuli (5):
  syscalls/dup2/dup201: Convert to new API
  syscalls/dup2/dup202: Convert to new API and merge dup204 into dup202
  syscalls/dup2/dup203: Convert to new API
  syscalls/dup2/dup205: Convert to new API
  syscalls/dup2: rename dup205 to dup204

 runtest/syscalls                          |   1 -
 testcases/kernel/syscalls/dup2/.gitignore |   1 -
 testcases/kernel/syscalls/dup2/Makefile   |   2 +-
 testcases/kernel/syscalls/dup2/dup201.c   | 174 +++-----------
 testcases/kernel/syscalls/dup2/dup202.c   | 210 ++++++-----------
 testcases/kernel/syscalls/dup2/dup203.c   | 266 +++++++---------------
 testcases/kernel/syscalls/dup2/dup204.c   | 165 +++++---------
 testcases/kernel/syscalls/dup2/dup205.c   | 134 -----------
 8 files changed, 244 insertions(+), 709 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/dup2/dup205.c

-- 
2.31.1

