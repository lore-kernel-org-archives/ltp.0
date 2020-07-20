From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 20 Jul 2020 15:14:04 +0800
Subject: [LTP] [PATCH 0/9] Rewrite shmctl() testcases
In-Reply-To: <20200717163453.9587-1-chrubis@suse.cz>
References: <20200717163453.9587-1-chrubis@suse.cz>
Message-ID: <432e05a0-985a-3fbb-9578-45b7019464c1@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> This patchset mostly rewrites old shmctl testcases from scratch and also
> increases the coverage at least threefold.
> 
> There are still missing pieces though, there are no test that would
> check that shm_atime and shm_dtime are valid as well as shm_lpid as well
> as the coverage of ipc_perm is still lacking and should be added later
> on.
It seems that we miss shm_next_id. Also for msg_next_id, sem_next_id in ltp.
> 
> Cyril Hrubis (9):
>    syscalls/ipc: shmctl02: Convert to the new library
>    syscalls/ipc: shmctl03: Remove.
>    syscalls/ipc: shmctl04: Rewrite from scratch.
>    syscalls/ipc: shmctl05 remove lib dependency
>    lib/tst_assert: Add TST_ASSERT_ULONG()
>    syscalls/ipc: Add shmctl() IPC_INFO test
>    syscalls/ipc: Add shmctl07 test
>    syscalls/ipc: Add shmctl IPC_SET test
>    syscalls/ipc: Rewrite shmctl01
> 
>   include/tst_assert.h                          |   9 +
>   lib/tst_assert.c                              |  14 +
>   runtest/syscalls                              |   2 +
>   runtest/syscalls-ipc                          |   2 +
>   .../kernel/syscalls/ipc/shmctl/.gitignore     |   2 +
>   testcases/kernel/syscalls/ipc/shmctl/Makefile |   3 +-
>   .../kernel/syscalls/ipc/shmctl/shmctl01.c     | 586 ++++++------------
>   .../kernel/syscalls/ipc/shmctl/shmctl02.c     | 263 +++-----
>   .../kernel/syscalls/ipc/shmctl/shmctl03.c     | 214 +------
>   .../kernel/syscalls/ipc/shmctl/shmctl04.c     | 190 +++---
>   .../kernel/syscalls/ipc/shmctl/shmctl07.c     |  66 ++
>   .../kernel/syscalls/ipc/shmctl/shmctl08.c     | 101 +++
>   12 files changed, 593 insertions(+), 859 deletions(-)
>   create mode 100644 testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
>   create mode 100644 testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
> 


