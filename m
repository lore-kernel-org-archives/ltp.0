From: Xie Ziyao <xieziyao@huawei.com>
Date: Mon, 28 Jun 2021 16:12:52 +0800
Subject: [LTP] [PATCH 0/3] epoll_pwait2: Add test for epoll_pwait2
In-Reply-To: <20210628080424.245911-1-xieziyao@huawei.com>
References: <20210628080424.245911-1-xieziyao@huawei.com>
Message-ID: <6ae18b1d-6363-3dbc-0696-f0c7115aeb67@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Xie Ziyao (3):
>    lapi/syscalls: Add syscall number for epoll_pwait2
>    epoll_pwait2: Add test for epoll_pwait201
>    epoll_pwait2: Add test for epoll_pwait202
Sorry for testing only under several archs (like arm, x86) on QEMU due 
to environmental limitations.

If possible, I would recommend testing it on other platforms as well.

Kind Regards,
Ziyao
> 
>   include/lapi/syscalls/aarch64.in              |  1 +
>   include/lapi/syscalls/arc.in                  |  1 +
>   include/lapi/syscalls/arm.in                  |  1 +
>   include/lapi/syscalls/hppa.in                 |  3 +-
>   include/lapi/syscalls/i386.in                 |  1 +
>   include/lapi/syscalls/ia64.in                 |  1 +
>   include/lapi/syscalls/powerpc.in              |  1 +
>   include/lapi/syscalls/powerpc64.in            |  1 +
>   include/lapi/syscalls/s390.in                 |  1 +
>   include/lapi/syscalls/s390x.in                |  1 +
>   include/lapi/syscalls/sh.in                   |  1 +
>   include/lapi/syscalls/sparc.in                |  1 +
>   include/lapi/syscalls/sparc64.in              |  1 +
>   include/lapi/syscalls/x86_64.in               |  1 +
>   runtest/syscalls                              |  2 +
>   .../kernel/syscalls/epoll_pwait2/.gitignore   |  2 +
>   .../kernel/syscalls/epoll_pwait2/Makefile     |  9 +++
>   .../syscalls/epoll_pwait2/epoll_pwait201.c    | 62 +++++++++++++++
>   .../syscalls/epoll_pwait2/epoll_pwait202.c    | 76 +++++++++++++++++++
>   19 files changed, 166 insertions(+), 1 deletion(-)
>   create mode 100644 testcases/kernel/syscalls/epoll_pwait2/.gitignore
>   create mode 100644 testcases/kernel/syscalls/epoll_pwait2/Makefile
>   create mode 100644 testcases/kernel/syscalls/epoll_pwait2/epoll_pwait201.c
>   create mode 100644 testcases/kernel/syscalls/epoll_pwait2/epoll_pwait202.c
> 
> --
> 2.17.1
> 
> .
> 
