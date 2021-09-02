From: QI Fuli <fukuri.sai@gmail.com>
Date: Thu,  2 Sep 2021 20:58:44 +0900
Subject: [LTP] [PATCH 0/5] Convert syscalls/dup2/dup2{01...05} to the new API
Message-ID: <20210902115849.72382-1-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Convert syscalls syscalls/dup2/dup2{01...05} to the new API

QI Fuli (5):
  syscalls/dup2/dup201: Convert dup201 to the new API
  syscalls/dup2/dup202: Convert dup202 to the new API
  syscalls/dup2/dup203: Convert dup203 to the new API
  syscalls/dup2/dup204: Convert dup204 to the new API
  syscalls/dup2/dup205: Convert dup205 to the new API

 testcases/kernel/syscalls/dup2/dup201.c | 161 +++----------
 testcases/kernel/syscalls/dup2/dup202.c | 175 ++++----------
 testcases/kernel/syscalls/dup2/dup203.c | 291 +++++++++---------------
 testcases/kernel/syscalls/dup2/dup204.c | 135 +++--------
 testcases/kernel/syscalls/dup2/dup205.c | 165 +++++---------
 5 files changed, 291 insertions(+), 636 deletions(-)

-- 
2.31.1

