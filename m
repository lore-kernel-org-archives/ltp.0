From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 4 Feb 2020 14:21:52 +0100
Subject: [LTP] [RFC PATCH 1/1] autotools: Move simple definitions out of
 m4/* to configure.ac
In-Reply-To: <20200130110753.20459-1-pvorel@suse.cz>
References: <20200130110753.20459-1-pvorel@suse.cz>
Message-ID: <20200204132152.GC16090@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
> * move pkg-config (e.g. ltp-keyutils.m4, ltp-selinux.m4)
> * simplify and move checks to lapi (e.g. ltp-signalfd.m4)
> * AC_MSG_RESULT: simplify if possible
> 
> Kind regards,
> Petr
> 
>  configure.ac                            | 92 +++++++++++++++++++------
>  m4/ltp-acct.m4                          |  7 --
>  m4/ltp-fanotify.m4                      |  8 ---
>  m4/ltp-fts.m4                           |  7 --
>  m4/ltp-if_link.m4                       |  6 --
>  m4/ltp-ioctl.m4                         |  7 --
>  m4/ltp-iovec.m4                         |  6 --
>  m4/ltp-kcmp_type.m4                     |  7 --
>  m4/ltp-madvise.m4                       | 11 ---
>  m4/ltp-mkdtemp.m4                       |  5 --
>  m4/ltp-mmsghdr.m4                       | 10 ---
>  m4/ltp-modify_ldt.m4                    | 13 ----
>  m4/ltp-perf_event.m4                    |  6 --
>  m4/ltp-prctl.m4                         | 11 ---
>  m4/ltp-quota.m4                         |  8 ---
>  m4/ltp-rlimit64.m4                      |  9 ---
>  m4/ltp-signal.m4                        | 18 -----
>  m4/ltp-statx.m4                         | 14 ----
>  m4/ltp-termio.m4                        |  6 --
>  m4/ltp-timerfd.m4                       |  7 --
>  m4/ltp-tpacket-v3.m4                    | 10 ---
>  m4/ltp-uname.m4                         |  8 ---
>  m4/ltp-x_tables.m4                      | 25 -------
>  testcases/kernel/mem/ksm/ksm05.c        |  2 +-
>  testcases/kernel/mem/lib/mem.c          |  6 +-
>  testcases/kernel/syscalls/mmap/mmap10.c |  4 +-
>  26 files changed, 76 insertions(+), 237 deletions(-)
>  delete mode 100644 m4/ltp-acct.m4
>  delete mode 100644 m4/ltp-fanotify.m4
>  delete mode 100644 m4/ltp-fts.m4
>  delete mode 100644 m4/ltp-if_link.m4
>  delete mode 100644 m4/ltp-ioctl.m4
>  delete mode 100644 m4/ltp-iovec.m4
>  delete mode 100644 m4/ltp-kcmp_type.m4
>  delete mode 100644 m4/ltp-madvise.m4
>  delete mode 100644 m4/ltp-mkdtemp.m4
>  delete mode 100644 m4/ltp-mmsghdr.m4
>  delete mode 100644 m4/ltp-modify_ldt.m4
>  delete mode 100644 m4/ltp-perf_event.m4
>  delete mode 100644 m4/ltp-prctl.m4
>  delete mode 100644 m4/ltp-quota.m4
>  delete mode 100644 m4/ltp-rlimit64.m4
>  delete mode 100644 m4/ltp-signal.m4
>  delete mode 100644 m4/ltp-statx.m4
>  delete mode 100644 m4/ltp-termio.m4
>  delete mode 100644 m4/ltp-timerfd.m4
>  delete mode 100644 m4/ltp-tpacket-v3.m4
>  delete mode 100644 m4/ltp-uname.m4
>  delete mode 100644 m4/ltp-x_tables.m4
> 
> diff --git a/configure.ac b/configure.ac
> index b860bdacc..1c9ef38eb 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -32,13 +32,19 @@ AC_PROG_YACC
>  
>  AC_PREFIX_DEFAULT(/opt/ltp)
>  
> +AC_CHECK_DECLS([IFLA_NET_NS_PID],,,[#include <linux/if_link.h>])
> +AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
> +AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
> +
>  AC_CHECK_HEADERS([ \
> +    asm/ldt.h \
>      ifaddrs.h \
>      keyutils.h \
>      linux/can.h \
>      linux/cgroupstats.h \
>      linux/cryptouser.h \
>      linux/dccp.h \
> +    linux/fs.h \
>      linux/genetlink.h \
>      linux/if_alg.h \
>      linux/if_packet.h \
> @@ -59,11 +65,14 @@ AC_CHECK_HEADERS([ \
>      sys/inotify.h \
>      sys/prctl.h \
>      sys/shm.h \
> +    sys/timerfd.h \
>      sys/ustat.h \
>      sys/utsname.h \
>      sys/xattr.h \
>      xfs/xqm.h \
>  ])
> +AC_CHECK_HEADERS(fts.h, [have_fts=1])
> +AC_SUBST(HAVE_FTS_H, $have_fts)

How is that different from simple AC_CHECK_HEADERS() ?

Can't we just put the hader into the call above?

Other than this the changes looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
