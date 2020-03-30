From: Zou Wei <zou_wei@huawei.com>
Date: Mon, 30 Mar 2020 15:27:46 +0800
Subject: [LTP] [PATCH v3 0/3] Fix bug caused by default umask
Message-ID: <1585553269-119544-1-git-send-email-zou_wei@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

v3:
The case is only successful when system default umask is 0022.
When default umask is 0077 or other values, should clear umask by umask(0) in setup().

Zou Wei (3):
  security/dirtyc0w: Fix bug caused by default umask
  syscalls/fstat: Fix bug caused by default umask
  syscalls/statx01: Fix bug caused by default umask

 testcases/kernel/security/dirtyc0w/dirtyc0w.c | 2 ++
 testcases/kernel/syscalls/fstat/fstat02.c     | 2 ++
 testcases/kernel/syscalls/statx/statx01.c     | 2 ++
 3 files changed, 6 insertions(+)

--
2.6.2

