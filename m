From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  3 Dec 2020 16:28:02 +0100
Subject: [LTP] [PATCH 0/2] Fix timestamp tests in SysV IPC tests
Message-ID: <20201203152804.846-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis (2):
  libnewipc: Add get_ipc_timestamp()
  syscalls/ipc: Make use of get_ipc_timestamp()

 include/libnewipc.h                             |  3 +++
 libs/libltpnewipc/libnewipc.c                   | 13 +++++++++++++
 testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c |  4 ++--
 testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c |  4 ++--
 testcases/kernel/syscalls/ipc/shmctl/Makefile   |  2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c |  4 ++--
 6 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.26.2

