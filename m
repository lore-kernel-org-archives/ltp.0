From: Sandeep Patil <sspatil@android.com>
Date: Sat, 18 May 2019 17:38:03 -0700
Subject: [LTP] [PATCH 0/5] New library conversion for few system call tests
Message-ID: <20190519003808.47425-1-sspatil@android.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Following series is a set of system call tests that are converted to new
library. Also deleted bdflush test at the same time. I have been going
through the system call tests alphabetically and convert them to new
library as applicable, so there will be more to come.

I have tested this on cuttlefish[1] and made sure they don't regress.

1. https://linuxplumbersconf.org/event/2/contributions/269/attachments/56/63/Kernel_Hacking_with_Cuttlefish.pdf

Sandeep Patil (5):
  syscalls/adjtimex01: Convert to new library
  syscalls/adjtimex02: Convert to new library
  syscalls/asyncio02: convert to new library.
  syscalls/bdflush01: delete bdflush test
  syscalls/bind01: convert to new library.

 .../kernel/syscalls/adjtimex/adjtimex01.c     | 122 ++-----
 .../kernel/syscalls/adjtimex/adjtimex02.c     | 307 +++++------------
 testcases/kernel/syscalls/asyncio/asyncio02.c | 323 ++++--------------
 testcases/kernel/syscalls/bdflush/.gitignore  |   1 -
 testcases/kernel/syscalls/bdflush/Makefile    |  23 --
 testcases/kernel/syscalls/bdflush/bdflush01.c | 126 -------
 testcases/kernel/syscalls/bind/bind01.c       | 201 +++--------
 7 files changed, 219 insertions(+), 884 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/bdflush/.gitignore
 delete mode 100644 testcases/kernel/syscalls/bdflush/Makefile
 delete mode 100644 testcases/kernel/syscalls/bdflush/bdflush01.c

-- 
2.21.0.1020.gf2820cf01a-goog

