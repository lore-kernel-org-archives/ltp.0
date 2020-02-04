From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 4 Feb 2020 22:23:11 +0800
Subject: [LTP] [RFC PATCH 1/1] autotools: Move simple definitions out of
 m4/* to configure.ac
In-Reply-To: <20200130110753.20459-1-pvorel@suse.cz>
References: <20200130110753.20459-1-pvorel@suse.cz>
Message-ID: <e6f7f611-7c2e-04cb-afd9-e11c4423dc3f@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
> Now configure has 8465 lines, before it had 8578.
> Although it doesn't bring any significant speedup,
> this way it's more readable and we avoid duplicate checks.
> 
> Cleanup some checks which also required to use default declaration
> HAVE_DECL_MADV_MERGEABLE instead of HAVE_MADV_MERGEABLE.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Tested
> https://travis-ci.org/pevik/ltp/builds/643803931
> NOTE: failure on Debian stable on s390x is due lack of space, reported,
> but nobody cares. We might disable s390x until fixed.
> https://travis-ci.community/t/no-space-left-on-device-for-system-z/5954/10
> + tested on old SLE11 (kernel 3.0, glibc 2.11).
> 
> TODO
> on m4 files (in order to use simple declarations which allows to move them to configure.ac):
> * verify and delete if they're old enough (e.g. ltp-ptrace.m4 and ltp-taskstats.m4 reference 2008, kernel commit 016ae219 from v2.6.27; ltp-signalfd.m4)
ltp-prctl.m4 for PR_CAPBSET_DROP and PR_CAPBSET_READ also can be removed 
because it introduced since 2.6.25(it is old enough).

IMO, move all simple definitions to configure.ac will make this file 
mess likce old .gitnore file. I perfer to add function or header or 
macro but not include struct in configure.ac.

Best Regards
Yang Xu
> * move pkg-config (e.g. ltp-keyutils.m4, ltp-selinux.m4)
> * simplify and move checks to lapi (e.g. ltp-signalfd.m4)
> * AC_MSG_RESULT: simplify if possible
> 
> Kind regards,
> Petr
> 
>   configure.ac                            | 92 +++++++++++++++++++------
>   m4/ltp-acct.m4                          |  7 --
>   m4/ltp-fanotify.m4                      |  8 ---
>   m4/ltp-fts.m4                           |  7 --
>   m4/ltp-if_link.m4                       |  6 --
>   m4/ltp-ioctl.m4                         |  7 --
>   m4/ltp-iovec.m4                         |  6 --
>   m4/ltp-kcmp_type.m4                     |  7 --
>   m4/ltp-madvise.m4                       | 11 ---
>   m4/ltp-mkdtemp.m4                       |  5 --
>   m4/ltp-mmsghdr.m4                       | 10 ---
>   m4/ltp-modify_ldt.m4                    | 13 ----
>   m4/ltp-perf_event.m4                    |  6 --
>   m4/ltp-prctl.m4                         | 11 ---
>   m4/ltp-quota.m4                         |  8 ---
>   m4/ltp-rlimit64.m4                      |  9 ---
>   m4/ltp-signal.m4                        | 18 -----
>   m4/ltp-statx.m4                         | 14 ----
>   m4/ltp-termio.m4                        |  6 --
>   m4/ltp-timerfd.m4                       |  7 --
>   m4/ltp-tpacket-v3.m4                    | 10 ---
>   m4/ltp-uname.m4                         |  8 ---
>   m4/ltp-x_tables.m4                      | 25 -------
>   testcases/kernel/mem/ksm/ksm05.c        |  2 +-
>   testcases/kernel/mem/lib/mem.c          |  6 +-
>   testcases/kernel/syscalls/mmap/mmap10.c |  4 +-
>   26 files changed, 76 insertions(+), 237 deletions(-)
>   delete mode 100644 m4/ltp-acct.m4
>   delete mode 100644 m4/ltp-fanotify.m4
>   delete mode 100644 m4/ltp-fts.m4
>   delete mode 100644 m4/ltp-if_link.m4
>   delete mode 100644 m4/ltp-ioctl.m4
>   delete mode 100644 m4/ltp-iovec.m4
>   delete mode 100644 m4/ltp-kcmp_type.m4
>   delete mode 100644 m4/ltp-madvise.m4
>   delete mode 100644 m4/ltp-mkdtemp.m4
>   delete mode 100644 m4/ltp-mmsghdr.m4
>   delete mode 100644 m4/ltp-modify_ldt.m4
>   delete mode 100644 m4/ltp-perf_event.m4
>   delete mode 100644 m4/ltp-prctl.m4
>   delete mode 100644 m4/ltp-quota.m4
>   delete mode 100644 m4/ltp-rlimit64.m4
>   delete mode 100644 m4/ltp-signal.m4
>   delete mode 100644 m4/ltp-statx.m4
>   delete mode 100644 m4/ltp-termio.m4
>   delete mode 100644 m4/ltp-timerfd.m4
>   delete mode 100644 m4/ltp-tpacket-v3.m4
>   delete mode 100644 m4/ltp-uname.m4
>   delete mode 100644 m4/ltp-x_tables.m4
> 
> diff --git a/configure.ac b/configure.ac
> index b860bdacc..1c9ef38eb 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -32,13 +32,19 @@ AC_PROG_YACC
>   
>   AC_PREFIX_DEFAULT(/opt/ltp)
>   
> +AC_CHECK_DECLS([IFLA_NET_NS_PID],,,[#include <linux/if_link.h>])
> +AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
> +AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
> +
>   AC_CHECK_HEADERS([ \
> +    asm/ldt.h \
>       ifaddrs.h \
>       keyutils.h \
>       linux/can.h \
>       linux/cgroupstats.h \
>       linux/cryptouser.h \
>       linux/dccp.h \
> +    linux/fs.h \
>       linux/genetlink.h \
>       linux/if_alg.h \
>       linux/if_packet.h \
> @@ -59,11 +65,14 @@ AC_CHECK_HEADERS([ \
>       sys/inotify.h \
>       sys/prctl.h \
>       sys/shm.h \
> +    sys/timerfd.h \
>       sys/ustat.h \
>       sys/utsname.h \
>       sys/xattr.h \
>       xfs/xqm.h \
>   ])
> +AC_CHECK_HEADERS(fts.h, [have_fts=1])
> +AC_SUBST(HAVE_FTS_H, $have_fts)
>   
>   AC_CHECK_FUNCS([ \
>       copy_file_range \
> @@ -78,6 +87,7 @@ AC_CHECK_FUNCS([ \
>       io_pgetevents \
>       mkdirat \
>       mknodat \
> +    modify_ldt \
>       name_to_handle_at \
>       openat \
>       pidfd_open \
> @@ -96,14 +106,73 @@ AC_CHECK_FUNCS([ \
>       sendmmsg \
>       sigpending \
>       splice \
> +    statx \
>       stime \
>       syncfs \
>       sync_file_range \
>       tee \
> +    timerfd_create \
> +    timerfd_gettime \
> +    timerfd_settime \
>       unshare \
>       ustat \
>       vmsplice \
>   ])
> +AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))
> +
> +AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
> +AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
> +AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
> +
> +AC_CHECK_MEMBERS([struct utsname.domainname],,,[
> +#define _GNU_SOURCE
> +#include <sys/utsname.h>
> +])
> +
> +AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
> +AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
> +AC_CHECK_TYPES([struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
> +AC_CHECK_TYPES([struct fanotify_event_info_fid],,,[#include <sys/fanotify.h>])
> +AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
> +AC_CHECK_TYPES([struct fs_quota_statv],,,[#include <xfs/xqm.h>])
> +AC_CHECK_TYPES([struct if_nextdqblk],,,[#include <linux/quota.h>])
> +AC_CHECK_TYPES([struct iovec],,,[#include <sys/uio.h>])
> +
> +AC_CHECK_TYPES([struct mmsghdr],,,[
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +])
> +
> +AC_CHECK_TYPES([struct rlimit64],,,[
> +#define _LARGEFILE64_SOURCE
> +#include <sys/resource.h>
> +])
> +
> +AC_CHECK_TYPES([struct statx, struct statx_timestamp],,,[
> +	#define _GNU_SOURCE
> +	#include <sys/stat.h>
> +])
> +
> +AC_CHECK_TYPES([struct termio],,,[#include <sys/ioctl.h>])
> +
> +AC_CHECK_TYPES([struct tpacket_req3],,,[
> +#ifdef HAVE_LINUX_IF_PACKET_H
> +# include <linux/if_packet.h>
> +#endif
> +])
> +
> +AC_CHECK_TYPES([struct user_desc, struct modify_ldt_ldt_s],[],[],[
> +#include <asm/ldt.h>
> +])
> +
> +AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
> +#include <sys/types.h>
> +#include <netinet/in.h>
> +#include <net/if.h>
> +#include <limits.h>
> +#include <linux/netfilter_ipv4/ip_tables.h>
> +])
>   
>   # Tools knobs
>   
> @@ -208,7 +277,7 @@ fi
>   AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh])
>   
>   # custom functions
> -LTP_CHECK_ACCT
> +# NOTE: don't create custom functions for simple checks, put them into this file
>   LTP_CHECK_ACL_SUPPORT
>   LTP_CHECK_ATOMIC_MEMORY_MODEL
>   LTP_CHECK_BUILTIN_CLEAR_CACHE
> @@ -216,32 +285,17 @@ LTP_CHECK_CAPABILITY_SUPPORT
>   LTP_CHECK_CC_WARN_OLDSTYLE
>   LTP_CHECK_CLONE_SUPPORTS_7_ARGS
>   LTP_CHECK_CRYPTO
> -LTP_CHECK_FANOTIFY
> -LTP_CHECK_FIDEDUPE
>   LTP_CHECK_FORTIFY_SOURCE
> -LTP_CHECK_FTS_H
> -LTP_CHECK_IF_LINK
> -LTP_CHECK_IOVEC
> -LTP_CHECK_KCMP_TYPE
>   LTP_CHECK_KERNEL_DEVEL
>   LTP_CHECK_KEYUTILS_SUPPORT
>   LTP_CHECK_LINUX_PTRACE
>   LTP_CHECK_LINUXRANDOM
> -LTP_CHECK_MADVISE
> -LTP_CHECK_MKDTEMP
> -LTP_CHECK_MMSGHDR
>   LTP_CHECK_MREMAP_FIXED
>   LTP_CHECK_NOMMU_LINUX
> -LTP_CHECK_PERF_EVENT
> -LTP_CHECK_PRCTL_SUPPORT
> -LTP_CHECK_RLIMIT64
>   LTP_CHECK_SELINUX
> -LTP_CHECK_SIGNAL
> -LTP_CHECK_STATX
>   LTP_CHECK_SYNC_ADD_AND_FETCH
>   LTP_CHECK_SYSCALL_EVENTFD
>   LTP_CHECK_SYSCALL_FCNTL
> -LTP_CHECK_SYSCALL_MODIFY_LDT
>   
>   if test "x$with_numa" = xyes; then
>   	LTP_CHECK_SYSCALL_NUMA
> @@ -253,16 +307,10 @@ AC_DEFINE_UNQUOTED(NUMA_ERROR_MSG, ["$numa_error_msg"], [Error message when no N
>   
>   
>   LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
> -LTP_CHECK_SYSCALL_QUOTACTL
>   LTP_CHECK_SYSCALL_SIGNALFD
>   LTP_CHECK_SYSCALL_UTIMENSAT
>   LTP_CHECK_TASKSTATS
> -LTP_CHECK_TERMIO
> -LTP_CHECK_TIMERFD
>   test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
> -LTP_CHECK_TPACKET_V3
> -LTP_CHECK_UNAME_DOMAINNAME
> -LTP_CHECK_X_TABLES
>   LTP_DETECT_HOST_CPU
>   
>   AC_OUTPUT
> diff --git a/m4/ltp-acct.m4 b/m4/ltp-acct.m4
> deleted file mode 100644
> index 61bc01947..000000000
> --- a/m4/ltp-acct.m4
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2019 SUSE LLC
> -dnl Author: Christian Amann <camann@suse.com>
> -
> -AC_DEFUN([LTP_CHECK_ACCT],[
> -AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
> -])
> diff --git a/m4/ltp-fanotify.m4 b/m4/ltp-fanotify.m4
> deleted file mode 100644
> index f2e31eb68..000000000
> --- a/m4/ltp-fanotify.m4
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
> -
> -AC_DEFUN([LTP_CHECK_FANOTIFY],[
> -AC_CHECK_TYPES([struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
> -AC_CHECK_TYPES([struct fanotify_event_info_fid],,,[#include <sys/fanotify.h>])
> -AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
> -])
> diff --git a/m4/ltp-fts.m4 b/m4/ltp-fts.m4
> deleted file mode 100644
> index 0da692f23..000000000
> --- a/m4/ltp-fts.m4
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
> -
> -AC_DEFUN([LTP_CHECK_FTS_H],[
> -	AC_CHECK_HEADERS(fts.h, [have_fts=1])
> -	AC_SUBST(HAVE_FTS_H, $have_fts)
> -])
> diff --git a/m4/ltp-if_link.m4 b/m4/ltp-if_link.m4
> deleted file mode 100644
> index b7228bf3e..000000000
> --- a/m4/ltp-if_link.m4
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) Linux Test Project, 2015
> -
> -AC_DEFUN([LTP_CHECK_IF_LINK],[
> -AC_CHECK_DECLS([IFLA_NET_NS_PID],,,[#include <linux/if_link.h>])
> -])
> diff --git a/m4/ltp-ioctl.m4 b/m4/ltp-ioctl.m4
> deleted file mode 100644
> index 81187867c..000000000
> --- a/m4/ltp-ioctl.m4
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2019 SUSE LLC
> -dnl Author: Christian Amann <camann@suse.com>
> -
> -AC_DEFUN([LTP_CHECK_FIDEDUPE],[
> -AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
> -])
> diff --git a/m4/ltp-iovec.m4 b/m4/ltp-iovec.m4
> deleted file mode 100644
> index 27cef7098..000000000
> --- a/m4/ltp-iovec.m4
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2014 Linux Test Project
> -
> -AC_DEFUN([LTP_CHECK_IOVEC],[
> -AC_CHECK_TYPES([struct iovec],,,[#include <sys/uio.h>])
> -])
> diff --git a/m4/ltp-kcmp_type.m4 b/m4/ltp-kcmp_type.m4
> deleted file mode 100644
> index a75212813..000000000
> --- a/m4/ltp-kcmp_type.m4
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) Linux Test Project, 2015
> -dnl Author: Cedric Hnyda <chnyda@suse.com>
> -
> -AC_DEFUN([LTP_CHECK_KCMP_TYPE],[
> -AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
> -])
> diff --git a/m4/ltp-madvise.m4 b/m4/ltp-madvise.m4
> deleted file mode 100644
> index 3ab203ca9..000000000
> --- a/m4/ltp-madvise.m4
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) Linux Test Project, 2011
> -dnl Author: Cyril Hrubis <chrubis@suse.cz>
> -
> -AC_DEFUN([LTP_CHECK_MADVISE],
> -[
> -AC_CHECK_DECLS([MADV_MERGEABLE],[have_madv_mergeable="yes"],,[#include <sys/mman.h>])
> -if test "x$have_madv_mergeable" = "xyes"; then
> -	AC_DEFINE(HAVE_MADV_MERGEABLE,1,[Define to 1 if you have MADV_MERGEABLE])
> -fi
> -])
> diff --git a/m4/ltp-mkdtemp.m4 b/m4/ltp-mkdtemp.m4
> deleted file mode 100644
> index 8fe99d99d..000000000
> --- a/m4/ltp-mkdtemp.m4
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -dnl Copyright (c) Linux Test Project, 2011-2012
> -dnl Author: Cyril Hrubis <chrubis@suse.cz>
> -
> -AC_DEFUN([LTP_CHECK_MKDTEMP],[
> -AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))])
> diff --git a/m4/ltp-mmsghdr.m4 b/m4/ltp-mmsghdr.m4
> deleted file mode 100644
> index c509c6a9c..000000000
> --- a/m4/ltp-mmsghdr.m4
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
> -
> -AC_DEFUN([LTP_CHECK_MMSGHDR],[
> -AC_CHECK_TYPES([struct mmsghdr],,,[
> -#define _GNU_SOURCE
> -#include <sys/types.h>
> -#include <sys/socket.h>
> -])
> -])
> diff --git a/m4/ltp-modify_ldt.m4 b/m4/ltp-modify_ldt.m4
> deleted file mode 100644
> index e473ddca2..000000000
> --- a/m4/ltp-modify_ldt.m4
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) Red Hat Inc., 2008
> -dnl Author: Masatake YAMATO <yamato@redhat.com>
> -
> -AC_DEFUN([LTP_CHECK_SYSCALL_MODIFY_LDT],
> -[
> -AC_CHECK_FUNCS(modify_ldt)
> -AC_CHECK_HEADERS(asm/ldt.h,[LTP_SYSCALL_MODIFY_LDT_HEADER=yes])
> -if test x"$LTP_SYSCALL_MODIFY_LDT_HEADER" = xyes; then
> -   AC_CHECK_TYPES([struct user_desc, struct modify_ldt_ldt_s],[],[],[
> -#include <asm/ldt.h>
> -])
> -fi])
> diff --git a/m4/ltp-perf_event.m4 b/m4/ltp-perf_event.m4
> deleted file mode 100644
> index 9415c0718..000000000
> --- a/m4/ltp-perf_event.m4
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
> -
> -AC_DEFUN([LTP_CHECK_PERF_EVENT],[
> -AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
> -])
> diff --git a/m4/ltp-prctl.m4 b/m4/ltp-prctl.m4
> deleted file mode 100644
> index e429db8fe..000000000
> --- a/m4/ltp-prctl.m4
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) Cisco Systems Inc., 2009
> -dnl Author: Ngie Cooper <yaneurabeya@gmail.com>
> -
> -AC_DEFUN([LTP_CHECK_PRCTL_SUPPORT],[
> -AC_CHECK_HEADERS(sys/prctl.h,[
> -	AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ], [],[],[
> -#include <sys/prctl.h>
> -]) dnl AC_CHECK_DECLS
> -])]
> -)
> diff --git a/m4/ltp-quota.m4 b/m4/ltp-quota.m4
> deleted file mode 100644
> index bcdff7041..000000000
> --- a/m4/ltp-quota.m4
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2019 Fujitsu Ltd.
> -dnl Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> -
> -AC_DEFUN([LTP_CHECK_SYSCALL_QUOTACTL],[
> -AC_CHECK_TYPES([struct if_nextdqblk],,,[#include <linux/quota.h>])
> -AC_CHECK_TYPES([struct fs_quota_statv],,,[#include <xfs/xqm.h>])
> -])
> diff --git a/m4/ltp-rlimit64.m4 b/m4/ltp-rlimit64.m4
> deleted file mode 100644
> index dccb40188..000000000
> --- a/m4/ltp-rlimit64.m4
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2018 Google, Inc.
> -
> -AC_DEFUN([LTP_CHECK_RLIMIT64],[
> -AC_CHECK_TYPES([struct rlimit64],,,[
> -#define _LARGEFILE64_SOURCE
> -#include <sys/resource.h>
> -])
> -])
> diff --git a/m4/ltp-signal.m4 b/m4/ltp-signal.m4
> deleted file mode 100644
> index 6f5ce8365..000000000
> --- a/m4/ltp-signal.m4
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) Cisco Systems, Inc. 2009
> -dnl Author: Ngie Cooper <yaneurabeya@gmail.com>
> -
> -dnl LTP_CHECK_SIGNAL
> -dnl --------------------------
> -dnl * Check for sa_handler in struct_sigaction. The very fact that this
> -dnl   definition is present or missing signifies whether or not the rt_sig*
> -dnl   syscalls exist and are implemented on the target architecture, as the
> -dnl   sigaction(2) call obscures this point in glibc. This doesn't signify
> -dnl   whether or not the RT signals function though -- those must be proved
> -dnl   through functionality tests.
> -AC_DEFUN([LTP_CHECK_SIGNAL],
> -[
> -AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[
> -#include <signal.h>
> -])
> -])
> diff --git a/m4/ltp-statx.m4 b/m4/ltp-statx.m4
> deleted file mode 100644
> index 3dc06f63e..000000000
> --- a/m4/ltp-statx.m4
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> -
> -AC_DEFUN([LTP_CHECK_STATX],[
> -AC_CHECK_FUNCS(statx,,)
> -AC_CHECK_HEADER(linux/fs.h,,,)
> -AC_CHECK_TYPES([struct statx],,,[[
> -	#define _GNU_SOURCE
> -	#include <sys/stat.h>
> -]])
> -AC_CHECK_TYPES([struct statx_timestamp],,,[[
> -	#define _GNU_SOURCE
> -	#include <sys/stat.h>]])
> -])
> diff --git a/m4/ltp-termio.m4 b/m4/ltp-termio.m4
> deleted file mode 100644
> index e745df1d9..000000000
> --- a/m4/ltp-termio.m4
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2020 Petr Vorel <petr.vorel@gmail.com>
> -
> -AC_DEFUN([LTP_CHECK_TERMIO],[
> -AC_CHECK_TYPES([struct termio],,,[#include <sys/ioctl.h>])
> -])
> diff --git a/m4/ltp-timerfd.m4 b/m4/ltp-timerfd.m4
> deleted file mode 100644
> index 02d1969fb..000000000
> --- a/m4/ltp-timerfd.m4
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) Linux Test Project, 2014
> -
> -AC_DEFUN([LTP_CHECK_TIMERFD],[
> -AC_CHECK_FUNCS([timerfd_create timerfd_settime timerfd_gettime])
> -AC_CHECK_HEADERS([sys/timerfd.h])
> -])
> diff --git a/m4/ltp-tpacket-v3.m4 b/m4/ltp-tpacket-v3.m4
> deleted file mode 100644
> index 7b730a23c..000000000
> --- a/m4/ltp-tpacket-v3.m4
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
> -
> -AC_DEFUN([LTP_CHECK_TPACKET_V3],[
> -AC_CHECK_TYPES([struct tpacket_req3],,,[
> -#ifdef HAVE_LINUX_IF_PACKET_H
> -# include <linux/if_packet.h>
> -#endif
> -])
> -])
> diff --git a/m4/ltp-uname.m4 b/m4/ltp-uname.m4
> deleted file mode 100644
> index 9e9f1d5f8..000000000
> --- a/m4/ltp-uname.m4
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
> -
> -AC_DEFUN([LTP_CHECK_UNAME_DOMAINNAME],[
> -AC_CHECK_MEMBERS([struct utsname.domainname],,,[
> -#define _GNU_SOURCE
> -#include <sys/utsname.h>
> -])])
> diff --git a/m4/ltp-x_tables.m4 b/m4/ltp-x_tables.m4
> deleted file mode 100644
> index 736aa8b07..000000000
> --- a/m4/ltp-x_tables.m4
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
> -dnl
> -dnl This program is free software;  you can redistribute it and/or modify
> -dnl it under the terms of the GNU General Public License as published by
> -dnl the Free Software Foundation; either version 2 of the License, or
> -dnl (at your option) any later version.
> -dnl
> -dnl This program is distributed in the hope that it will be useful,
> -dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> -dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> -dnl the GNU General Public License for more details.
> -dnl
> -dnl You should have received a copy of the GNU General Public License
> -dnl along with this program. If not, see <http://www.gnu.org/licenses/>.
> -
> -AC_DEFUN([LTP_CHECK_X_TABLES],[
> -AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
> -#include <sys/types.h>
> -#include <netinet/in.h>
> -#include <net/if.h>
> -#include <limits.h>
> -#include <linux/netfilter_ipv4/ip_tables.h>
> -])
> -])
> diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
> index ca08f50ae..380bb0202 100644
> --- a/testcases/kernel/mem/ksm/ksm05.c
> +++ b/testcases/kernel/mem/ksm/ksm05.c
> @@ -41,7 +41,7 @@
>   #include "tst_test.h"
>   #include "mem.h"
>   
> -#ifdef HAVE_MADV_MERGEABLE
> +#ifdef HAVE_DECL_MADV_MERGEABLE
>   
>   static int ksm_run_orig = -1;
>   static void sighandler(int sig);
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 456259792..eca4c61c8 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -52,7 +52,7 @@ static int alloc_mem(long int length, int testcase)
>   		}
>   	}
>   
> -#ifdef HAVE_MADV_MERGEABLE
> +#ifdef HAVE_DECL_MADV_MERGEABLE
>   	if (testcase == KSM && madvise(s, length, MADV_MERGEABLE) == -1)
>   		return errno;
>   #endif
> @@ -368,7 +368,7 @@ static void create_ksm_child(int child_num, int size, int unit,
>   	for (j = 0; j < total_unit; j++) {
>   		memory[j] = SAFE_MMAP(NULL, unit * MB, PROT_READ|PROT_WRITE,
>   			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> -#ifdef HAVE_MADV_MERGEABLE
> +#ifdef HAVE_DECL_MADV_MERGEABLE
>   		if (madvise(memory[j], unit * MB, MADV_MERGEABLE) == -1)
>   			tst_brk(TBROK|TERRNO, "madvise");
>   #endif
> @@ -551,7 +551,7 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
>   	for (i = 0; i < num_nodes; i++) {
>   		memory[i] = SAFE_MMAP(NULL, length, PROT_READ|PROT_WRITE,
>   			    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> -#ifdef HAVE_MADV_MERGEABLE
> +#ifdef HAVE_DECL_MADV_MERGEABLE
>   		if (madvise(memory[i], length, MADV_MERGEABLE) == -1)
>   			tst_brk(TBROK|TERRNO, "madvise");
>   #endif
> diff --git a/testcases/kernel/syscalls/mmap/mmap10.c b/testcases/kernel/syscalls/mmap/mmap10.c
> index 34149186d..b844af07f 100644
> --- a/testcases/kernel/syscalls/mmap/mmap10.c
> +++ b/testcases/kernel/syscalls/mmap/mmap10.c
> @@ -95,7 +95,7 @@ int main(int argc, char *argv[])
>   		if (access(PATH_KSM, F_OK) == -1)
>   			tst_brkm(TCONF, NULL,
>   				 "KSM configuration is not enabled");
> -#ifdef HAVE_MADV_MERGEABLE
> +#ifdef HAVE_DECL_MADV_MERGEABLE
>   		tst_resm(TINFO, "add to KSM regions.");
>   #else
>   		tst_brkm(TCONF, NULL, "MADV_MERGEABLE missing in sys/mman.h");
> @@ -133,7 +133,7 @@ void mmapzero(void)
>   	}
>   	if (x == MAP_FAILED)
>   		tst_brkm(TFAIL | TERRNO, cleanup, "mmap");
> -#ifdef HAVE_MADV_MERGEABLE
> +#ifdef HAVE_DECL_MADV_MERGEABLE
>   	if (opt_ksm) {
>   		if (madvise(x, SIZE + SIZE - ps, MADV_MERGEABLE) == -1)
>   			tst_brkm(TBROK | TERRNO, cleanup, "madvise");
> 


