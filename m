From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jan 2020 13:03:09 +0100
Subject: [LTP] [PATCH 2/3] tst_device.h: Use lapi/syscalls.h instead of
 <sys/syscall.h>
In-Reply-To: <558281761.2778139.1579517819187.JavaMail.zimbra@redhat.com>
References: <20200117113715.22786-1-pvorel@suse.cz>
 <20200117113715.22786-3-pvorel@suse.cz>
 <20200120103108.GA15405@dell5510>
 <558281761.2778139.1579517819187.JavaMail.zimbra@redhat.com>
Message-ID: <20200120120309.GA24136@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> ----- Original Message -----
> > >  #include <unistd.h>
> > > -#include <sys/syscall.h>
> > > +#include "lapi/syscalls.h"
> > Hm, maybe this fix wasn't a good idea.
> > It effectively uses lapi/syscalls.h everywhere instead of <sys/syscall.h>.
> > Not sure if this is what we want.

> We already include lapi/syscalls.h at several places, so I wouldn't expect
> this to be as bad.

Yes, it's in many places, the same as lapi/syscalls.h:
git grep -l sys/syscall.h |wc -l
136

git grep -l lapi/syscalls.h |wc -l
206

But none of lapi/syscalls.h use is in the API headers (only in API C and tests)

> > Example of the error is #634 [1], which is caused by __NR_socketcall being -1
> > instead of not defined (socketcall is not defined on some archs, e.g. x86-64
> > and ARM).
> > We can fix the condition

> Tests using tst_syscall or ltp_syscall should be fine, since those check
> for ENOSYS.
OK, if lapi/syscalls.h include is ok, using tst_syscall() in socketcall01.c is
trivial fix. But I'd worry about these uses:

$ git grep -e '^#if.*\bSYS_' $(git grep -l sys/syscall.h)
testcases/kernel/containers/libclone/libclone.h:#ifndef SYS_unshare
testcases/kernel/containers/libclone/libclone.h:#ifdef __NR_unshare
testcases/kernel/containers/libclone/libclone.h:#ifndef __NR_unshare
testcases/kernel/fs/scsi/ltpscsi/llseek.c:#ifdef __NR_lseek
testcases/kernel/fs/scsi/ltpscsi/llseek.c:#ifndef __NR_llseek
testcases/kernel/hotplug/memory_hotplug/commands.c:#ifndef __NR_migrate_pages
testcases/kernel/mem/vma/vma03.c:#ifdef __NR_mmap2
testcases/kernel/security/tomoyo/include.h:#ifdef __NR_uselib
testcases/kernel/security/tomoyo/include.h:#ifdef __NR_pivot_root
testcases/kernel/syscalls/accept4/accept4_01.c:#if defined(SYS_ACCEPT4) /* the socketcall() number */
testcases/kernel/syscalls/readahead/readahead01.c:#if defined(__NR_readahead)
testcases/kernel/syscalls/set_robust_list/set_robust_list01.c:#ifdef __NR_set_robust_list
testcases/kernel/syscalls/set_robust_list/set_robust_list01.c:#ifdef __NR_set_robust_list
testcases/kernel/syscalls/set_robust_list/set_robust_list01.c:#ifdef __NR_set_robust_list
testcases/kernel/syscalls/set_robust_list/set_robust_list01.c:#ifdef __NR_set_robust_list
testcases/kernel/syscalls/setns/setns01.c:#if defined(__NR_setns)
testcases/kernel/syscalls/setns/setns02.c:#if defined(__NR_setns) && defined(CLONE_NEWIPC) && defined(CLONE_NEWUTS)
testcases/kernel/syscalls/socketcall/socketcall01.c:#ifdef __NR_socketcall
testcases/kernel/syscalls/socketcall/socketcall02.c:#ifdef __NR_socketcall
testcases/kernel/syscalls/socketcall/socketcall03.c:#ifdef __NR_socketcall
testcases/kernel/syscalls/socketcall/socketcall04.c:#ifdef __NR_socketcall
testcases/kernel/syscalls/timerfd/timerfd01.c:#ifdef __NR_timerfd_create
testcases/misc/crash/crash02.c:#if defined(__NR_vfork) && __NR_vfork
testcases/misc/crash/crash02.c:#if defined(__NR_clone) && __NR_clone

which IMHO fail unless transformed into tst_syscall/ltp_syscall().

That's why I'd apply my fix https://patchwork.ozlabs.org/patch/1225869/.

Kind regards,
Petr
