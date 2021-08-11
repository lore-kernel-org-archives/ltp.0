From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 11 Aug 2021 17:06:59 +0200
Subject: [LTP] [PATCH] lapi: Fix guards
In-Reply-To: <20210810151631.17420-1-chrubis@suse.cz>
References: <20210810151631.17420-1-chrubis@suse.cz>
Message-ID: <5eff1cf9-239a-ad37-7931-99a632e6dad1@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
one small nit below but otherwise looks good.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 10. 08. 21 17:16, Cyril Hrubis wrote:
> This fixes several problems with guards in lapi and unifies them to be
> in format LAPI_FOO_H__ as well.
> 
> Problems fixed:
> 
> - Some guard identifiers started with reserved double underscore
> - A few headers had incomplete or missing guards
> - Quite a bit did just used SYSCALL_H which probably isn't unique enough
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/lapi/abisize.h              | 6 +++---
>  include/lapi/acct.h                 | 6 +++---
>  include/lapi/bpf.h                  | 6 +++---
>  include/lapi/capability.h           | 6 +++---
>  include/lapi/common_timers.h        | 6 +++---
>  include/lapi/cpuset.h               | 6 +++---
>  include/lapi/cryptouser.h           | 6 +++---
>  include/lapi/execveat.h             | 6 +++---
>  include/lapi/fallocate.h            | 6 +++---
>  include/lapi/fcntl.h                | 6 +++---
>  include/lapi/fnmatch.h              | 6 +++---
>  include/lapi/fs.h                   | 6 +++---
>  include/lapi/fsmount.h              | 6 +++---
>  include/lapi/getrandom.h            | 6 +++---
>  include/lapi/if_alg.h               | 6 +++---
>  include/lapi/if_ether.h             | 6 +++---
>  include/lapi/if_packet.h            | 6 +++---
>  include/lapi/init_module.h          | 6 +++---
>  include/lapi/io_pgetevents.h        | 6 +++---
>  include/lapi/io_uring.h             | 6 +++---
>  include/lapi/ioctl.h                | 6 +++---
>  include/lapi/ioctl_ns.h             | 6 +++---
>  include/lapi/iovec.h                | 6 +++---
>  include/lapi/ip_tables.h            | 2 +-
>  include/lapi/ipcbuf.h               | 6 +++---
>  include/lapi/keyctl.h               | 6 +++---
>  include/lapi/loop.h                 | 6 +++---
>  include/lapi/membarrier.h           | 6 +++---
>  include/lapi/memfd.h                | 6 +++---
>  include/lapi/mkdirat.h              | 6 +++---
>  include/lapi/mlock2.h               | 2 +-
>  include/lapi/mount.h                | 6 +++---
>  include/lapi/msg.h                  | 7 ++++---
>  include/lapi/msgbuf.h               | 6 +++---
>  include/lapi/name_to_handle_at.h    | 6 +++---
>  include/lapi/namespaces_constants.h | 6 +++---
>  include/lapi/numaif.h               | 6 +++---
>  include/lapi/openat2.h              | 6 +++---
>  include/lapi/personality.h          | 6 +++---
>  include/lapi/pidfd_open.h           | 6 +++---
>  include/lapi/pidfd_send_signal.h    | 6 +++---
>  include/lapi/posix_clocks.h         | 6 +++---
>  include/lapi/posix_types.h          | 6 +++---
>  include/lapi/prctl.h                | 2 +-
>  include/lapi/preadv2.h              | 6 +++---
>  include/lapi/pwritev2.h             | 6 +++---
>  include/lapi/readdir.h              | 6 +++---
>  include/lapi/readlinkat.h           | 6 +++---
>  include/lapi/renameat.h             | 6 +++---
>  include/lapi/rt_sigaction.h         | 6 +++---
>  include/lapi/sched.h                | 6 +++---
>  include/lapi/seccomp.h              | 6 +++---
>  include/lapi/securebits.h           | 6 +++---
>  include/lapi/seek.h                 | 6 +++---
>  include/lapi/sem.h                  | 6 +++---
>  include/lapi/sembuf.h               | 6 +++---
>  include/lapi/shmbuf.h               | 6 +++---
>  include/lapi/signal.h               | 6 +++---
>  include/lapi/socket.h               | 6 +++---
>  include/lapi/splice.h               | 6 +++---
>  include/lapi/stat.h                 | 7 ++++---
>  include/lapi/sync_file_range.h      | 6 +++---
>  include/lapi/syncfs.h               | 6 +++---
>  include/lapi/syscalls/regen.sh      | 4 ++--
>  include/lapi/tee.h                  | 6 +++---
>  include/lapi/termbits.h             | 2 +-
>  include/lapi/timerfd.h              | 6 +++---
>  include/lapi/tty.h                  | 6 +++---
>  include/lapi/ustat.h                | 6 +++---
>  include/lapi/utime.h                | 5 +++--
>  include/lapi/utsname.h              | 5 +++++
>  include/lapi/vm_sockets.h           | 6 +++---
>  include/lapi/vmsplice.h             | 6 +++---
>  include/lapi/xfrm.h                 | 2 +-
>  74 files changed, 215 insertions(+), 207 deletions(-)
> 
> diff --git a/include/lapi/abisize.h b/include/lapi/abisize.h
> index 9e6622ca1..d19d73f0b 100644
> --- a/include/lapi/abisize.h
> +++ b/include/lapi/abisize.h
> @@ -5,8 +5,8 @@
>   *  Petr Vorel <petr.vorel@gmail.com>
>   */
>  
> -#ifndef ABISIZE_H__
> -#define ABISIZE_H__
> +#ifndef LAPI_ABISIZE_H__
> +#define LAPI_ABISIZE_H__
>  
>  /* __WORDSIZE replacement */
>  #if defined(__LP64__) || defined(_LP64)
> @@ -28,4 +28,4 @@
>       (defined(__aarch64__) && defined(__ILP32__)) || \
>       defined(TST_ABI64)
>  
> -#endif /* ABISIZE_H__ */
> +#endif /* LAPI_ABISIZE_H__ */
> diff --git a/include/lapi/acct.h b/include/lapi/acct.h
> index c81b78b44..6c521118e 100644
> --- a/include/lapi/acct.h
> +++ b/include/lapi/acct.h
> @@ -1,7 +1,7 @@
>  //SPDX-License-Identifier: GPL-2.0-or-later
>  
> -#ifndef LAPI_ACCT_H
> -#define LAPI_ACCT_H
> +#ifndef LAPI_ACCT_H__
> +#define LAPI_ACCT_H__
>  
>  #include <sys/types.h>
>  #include "config.h"
> @@ -71,4 +71,4 @@ enum {
>  # endif
>  #endif /* HAVE_STRUCT_ACCT_V3 */
>  
> -#endif /* LAPI_ACCT_H */
> +#endif /* LAPI_ACCT_H__ */
> diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
> index 5ae25293b..0e4527b8b 100644
> --- a/include/lapi/bpf.h
> +++ b/include/lapi/bpf.h
> @@ -8,8 +8,8 @@
>   * some eBPF testing without any external dependencies.
>   */
>  
> -#ifndef BPF_H
> -# define BPF_H
> +#ifndef LAPI_BPF_H__
> +#define LAPI_BPF_H__
>  
>  #include <stdint.h>
>  
> @@ -590,4 +590,4 @@ static inline int bpf(enum bpf_cmd cmd, union bpf_attr *attr, unsigned int size)
>  }
>  /* End copy from tools/lib/bpf */
>  
> -#endif	/* BPF_H */
> +#endif	/* LAPI_BPF_H__ */
> diff --git a/include/lapi/capability.h b/include/lapi/capability.h
> index 95cb6819b..c6470f389 100644
> --- a/include/lapi/capability.h
> +++ b/include/lapi/capability.h
> @@ -3,8 +3,8 @@
>   * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
>   */
>  
> -#ifndef LAPI_CAPABILITY_H
> -#define LAPI_CAPABILITY_H
> +#ifndef LAPI_CAPABILITY_H__
> +#define LAPI_CAPABILITY_H__
>  
>  #include "config.h"
>  
> @@ -52,4 +52,4 @@
>  # define CAP_TO_MASK(x)      (1 << ((x) & 31))
>  #endif
>  
> -#endif
> +#endif /* LAPI_CAPABILITY_H__ */
> diff --git a/include/lapi/common_timers.h b/include/lapi/common_timers.h
> index e50f698d6..74f9ca67f 100644
> --- a/include/lapi/common_timers.h
> +++ b/include/lapi/common_timers.h
> @@ -4,8 +4,8 @@
>   * Keep all the common defines/checks for the timer tests here
>   */
>  
> -#ifndef __COMMON_TIMERS_H__
> -#define __COMMON_TIMERS_H__
> +#ifndef LAPI_COMMON_TIMERS_H__
> +#define LAPI_COMMON_TIMERS_H__
>  
>  #include "config.h"
>  #include "lapi/syscalls.h"
> @@ -78,4 +78,4 @@ static inline int have_cputime_timers(void)
>   */
>  typedef int kernel_timer_t;
>  
> -#endif
> +#endif /* LAPI_COMMON_TIMERS__ */

This should be:
#endif /* LAPI_COMMON_TIMERS_H__ */

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
