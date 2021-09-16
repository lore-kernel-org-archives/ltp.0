From: QI Fuli <fukuri.sai@gmail.com>
Date: Thu, 16 Sep 2021 23:46:03 +0900
Subject: [LTP] [PATCH 0/2] Convert syscalls/dup3/dup3_{01,02} to new API
Message-ID: <20210916144605.36204-1-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Convert syscalls/dup3/dup3_{01,02} to new API

QI Fuli (2):
  syscalls/dup3_01: Rewrite and convert to new API
  syscalls/dup3_02: Convert to new API

 testcases/kernel/syscalls/dup3/dup3_01.c | 157 ++++++++---------------
 testcases/kernel/syscalls/dup3/dup3_02.c | 111 ++++------------
 2 files changed, 75 insertions(+), 193 deletions(-)

-- 
2.31.1

