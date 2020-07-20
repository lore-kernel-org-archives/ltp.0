From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 20 Jul 2020 15:38:55 +0800
Subject: [LTP] [PATCH v1 0/3] increase msgrcv coverage
In-Reply-To: <1595230227-21468-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1595230227-21468-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5e26cf6b-f579-93e2-bb85-f1a2f63b3cc1@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI!

This patchset is based on my previous msgrcv cleanup patch.
https://patchwork.ozlabs.org/project/ltp/patch/1594962618-26004-1-git-send-email-xuyang2018.jy@cn.fujitsu.com/

> 1. The first patch add check for msg_lrpid and msg_rtime.
> 2. The second patch tests different msgtyp.
> 3. The third patch tests MSG_COPY flag(basic error test),not functional
> test because kernel selftest[1] has tested this.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/ipc/msgque.c
> 
> Yang Xu (3):
>    syscalls/msgrcv: Add check for msg_lrpid and msg_rtime
>    syscalls/msgrcv07: Add different msgtyp test
>    syscalls/msgrcv09: Add error test for MSG_COPY flag
> 
>   include/lapi/msg.h                            | 15 +++
>   runtest/syscalls                              |  1 +
>   runtest/syscalls-ipc                          |  1 +
>   .../kernel/syscalls/ipc/msgrcv/.gitignore     |  1 +
>   .../kernel/syscalls/ipc/msgrcv/msgrcv01.c     | 28 +++++-
>   .../kernel/syscalls/ipc/msgrcv/msgrcv07.c     | 81 +++++++++++++++-
>   .../kernel/syscalls/ipc/msgrcv/msgrcv09.c     | 93 +++++++++++++++++++
>   7 files changed, 215 insertions(+), 5 deletions(-)
>   create mode 100644 include/lapi/msg.h
>   create mode 100644 testcases/kernel/syscalls/ipc/msgrcv/msgrcv09.c
> 


