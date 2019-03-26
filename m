From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Mar 2019 20:20:52 +0100
Subject: [LTP] [PATCH v3] Test ioctl syscall for NS_GET_* requests
In-Reply-To: <20190319180944.3933-1-fedebonfi95@gmail.com>
References: <20190318153056.GC18993@rei>
 <20190319180944.3933-1-fedebonfi95@gmail.com>
Message-ID: <20190326192052.GA15776@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hi Cyril, thanks for your patience. From what I understood, all the
> /proc/self/ns/* files exist if the kernel is compiled with namespaces.
> So only one of them has to be checked for each test, making additional
> checks for other processes namespaces symlinks redundant. If this is
> true, here's the updated patch, otherwise I'll add all the other
> checks for child processes.

This version looks very good, two minor comments below.

> I also changed the TCONF message in ioctl_ns08.c from "namespace not
> available" to "can't access current directory" since "." isn't a
> namespace, and we are trying to open a file that's not a namespace.

I would have just dropped the check for availability of ".", there is no
point of making sure that "." is a correct directory as it's higly
unlikely that the check will fail.

>  include/lapi/ioctl_ns.h                      | 28 ++++++++++
>  include/tst_safe_macros.h                    |  4 ++
>  lib/tst_safe_macros.c                        | 17 ++++++
>  runtest/syscalls                             |  8 +++
>  testcases/kernel/syscalls/ioctl/.gitignore   |  7 +++
>  testcases/kernel/syscalls/ioctl/ioctl_ns01.c | 65 +++++++++++++++++++++++
>  testcases/kernel/syscalls/ioctl/ioctl_ns02.c | 49 +++++++++++++++++
>  testcases/kernel/syscalls/ioctl/ioctl_ns04.c | 50 ++++++++++++++++++
>  testcases/kernel/syscalls/ioctl/ioctl_ns05.c | 48 +++++++++++++++++
>  testcases/kernel/syscalls/ioctl/ioctl_ns06.c | 77 +++++++++++++++++++++++++++
>  testcases/kernel/syscalls/ioctl/ioctl_ns07.c | 78 ++++++++++++++++++++++++++++
>  testcases/kernel/syscalls/ioctl/ioctl_ns08.c | 57 ++++++++++++++++++++
>  12 files changed, 488 insertions(+)
>  create mode 100644 include/lapi/ioctl_ns.h
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns01.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns02.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns04.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns05.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns06.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns07.c
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_ns08.c

Can we please split this patch and add the safe macro in a separate
patch?

-- 
Cyril Hrubis
chrubis@suse.cz
