From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Aug 2021 10:09:30 +0200
Subject: [LTP] [PATCH 0/3] New API: Rename LTP_IPC_PATH -> TST_IPC_PATH
Message-ID: <20210825080933.12949-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Petr Vorel (3):
  lib: Move IPC_ENV_VAR definition into header
  C API: Rename LTP_IPC_PATH -> TST_IPC_PATH
  shell API: Rename LTP_IPC_PATH -> TST_IPC_PATH

 doc/c-test-api.txt                          |  2 +-
 include/tst_test.h                          |  4 +++-
 lib/tst_test.c                              |  2 --
 testcases/kernel/syscalls/execle/execle01.c |  2 --
 testcases/kernel/syscalls/execve/execve01.c |  2 --
 testcases/kernel/syscalls/prctl/prctl06.h   |  1 -
 testcases/lib/tst_test.sh                   | 12 ++++++------
 7 files changed, 10 insertions(+), 15 deletions(-)

-- 
2.32.0

