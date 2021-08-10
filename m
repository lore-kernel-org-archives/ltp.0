From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Aug 2021 17:16:31 +0200
Subject: [LTP] [PATCH] lapi: Fix guards
Message-ID: <20210810151631.17420-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes several problems with guards in lapi and unifies them to be
in format LAPI_FOO_H__ as well.

Problems fixed:

- Some guard identifiers started with reserved double underscore
- A few headers had incomplete or missing guards
- Quite a bit did just used SYSCALL_H which probably isn't unique enough

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/abisize.h              | 6 +++---
 include/lapi/acct.h                 | 6 +++---
 include/lapi/bpf.h                  | 6 +++---
 include/lapi/capability.h           | 6 +++---
 include/lapi/common_timers.h        | 6 +++---
 include/lapi/cpuset.h               | 6 +++---
 include/lapi/cryptouser.h           | 6 +++---
 include/lapi/execveat.h             | 6 +++---
 include/lapi/fallocate.h            | 6 +++---
 include/lapi/fcntl.h                | 6 +++---
 include/lapi/fnmatch.h              | 6 +++---
 include/lapi/fs.h                   | 6 +++---
 include/lapi/fsmount.h              | 6 +++---
 include/lapi/getrandom.h            | 6 +++---
 include/lapi/if_alg.h               | 6 +++---
 include/lapi/if_ether.h             | 6 +++---
 include/lapi/if_packet.h            | 6 +++---
 include/lapi/init_module.h          | 6 +++---
 include/lapi/io_pgetevents.h        | 6 +++---
 include/lapi/io_uring.h             | 6 +++---
 include/lapi/ioctl.h                | 6 +++---
 include/lapi/ioctl_ns.h             | 6 +++---
 include/lapi/iovec.h                | 6 +++---
 include/lapi/ip_tables.h            | 2 +-
 include/lapi/ipcbuf.h               | 6 +++---
 include/lapi/keyctl.h               | 6 +++---
 include/lapi/loop.h                 | 6 +++---
 include/lapi/membarrier.h           | 6 +++---
 include/lapi/memfd.h                | 6 +++---
 include/lapi/mkdirat.h              | 6 +++---
 include/lapi/mlock2.h               | 2 +-
 include/lapi/mount.h                | 6 +++---
 include/lapi/msg.h                  | 7 ++++---
 include/lapi/msgbuf.h               | 6 +++---
 include/lapi/name_to_handle_at.h    | 6 +++---
 include/lapi/namespaces_constants.h | 6 +++---
 include/lapi/numaif.h               | 6 +++---
 include/lapi/openat2.h              | 6 +++---
 include/lapi/personality.h          | 6 +++---
 include/lapi/pidfd_open.h           | 6 +++---
 include/lapi/pidfd_send_signal.h    | 6 +++---
 include/lapi/posix_clocks.h         | 6 +++---
 include/lapi/posix_types.h          | 6 +++---
 include/lapi/prctl.h                | 2 +-
 include/lapi/preadv2.h              | 6 +++---
 include/lapi/pwritev2.h             | 6 +++---
 include/lapi/readdir.h              | 6 +++---
 include/lapi/readlinkat.h           | 6 +++---
 include/lapi/renameat.h             | 6 +++---
 include/lapi/rt_sigaction.h         | 6 +++---
 include/lapi/sched.h                | 6 +++---
 include/lapi/seccomp.h              | 6 +++---
 include/lapi/securebits.h           | 6 +++---
 include/lapi/seek.h                 | 6 +++---
 include/lapi/sem.h                  | 6 +++---
 include/lapi/sembuf.h               | 6 +++---
 include/lapi/shmbuf.h               | 6 +++---
 include/lapi/signal.h               | 6 +++---
 include/lapi/socket.h               | 6 +++---
 include/lapi/splice.h               | 6 +++---
 include/lapi/stat.h                 | 7 ++++---
 include/lapi/sync_file_range.h      | 6 +++---
 include/lapi/syncfs.h               | 6 +++---
 include/lapi/syscalls/regen.sh      | 4 ++--
 include/lapi/tee.h                  | 6 +++---
 include/lapi/termbits.h             | 2 +-
 include/lapi/timerfd.h              | 6 +++---
 include/lapi/tty.h                  | 6 +++---
 include/lapi/ustat.h                | 6 +++---
 include/lapi/utime.h                | 5 +++--
 include/lapi/utsname.h              | 5 +++++
 include/lapi/vm_sockets.h           | 6 +++---
 include/lapi/vmsplice.h             | 6 +++---
 include/lapi/xfrm.h                 | 2 +-
 74 files changed, 215 insertions(+), 207 deletions(-)

diff --git a/include/lapi/abisize.h b/include/lapi/abisize.h
index 9e6622ca1..d19d73f0b 100644
--- a/include/lapi/abisize.h
+++ b/include/lapi/abisize.h
@@ -5,8 +5,8 @@
  *  Petr Vorel <petr.vorel@gmail.com>
  */
 
-#ifndef ABISIZE_H__
-#define ABISIZE_H__
+#ifndef LAPI_ABISIZE_H__
+#define LAPI_ABISIZE_H__
 
 /* __WORDSIZE replacement */
 #if defined(__LP64__) || defined(_LP64)
@@ -28,4 +28,4 @@
      (defined(__aarch64__) && defined(__ILP32__)) || \
      defined(TST_ABI64)
 
-#endif /* ABISIZE_H__ */
+#endif /* LAPI_ABISIZE_H__ */
diff --git a/include/lapi/acct.h b/include/lapi/acct.h
index c81b78b44..6c521118e 100644
--- a/include/lapi/acct.h
+++ b/include/lapi/acct.h
@@ -1,7 +1,7 @@
 //SPDX-License-Identifier: GPL-2.0-or-later
 
-#ifndef LAPI_ACCT_H
-#define LAPI_ACCT_H
+#ifndef LAPI_ACCT_H__
+#define LAPI_ACCT_H__
 
 #include <sys/types.h>
 #include "config.h"
@@ -71,4 +71,4 @@ enum {
 # endif
 #endif /* HAVE_STRUCT_ACCT_V3 */
 
-#endif /* LAPI_ACCT_H */
+#endif /* LAPI_ACCT_H__ */
diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
index 5ae25293b..0e4527b8b 100644
--- a/include/lapi/bpf.h
+++ b/include/lapi/bpf.h
@@ -8,8 +8,8 @@
  * some eBPF testing without any external dependencies.
  */
 
-#ifndef BPF_H
-# define BPF_H
+#ifndef LAPI_BPF_H__
+#define LAPI_BPF_H__
 
 #include <stdint.h>
 
@@ -590,4 +590,4 @@ static inline int bpf(enum bpf_cmd cmd, union bpf_attr *attr, unsigned int size)
 }
 /* End copy from tools/lib/bpf */
 
-#endif	/* BPF_H */
+#endif	/* LAPI_BPF_H__ */
diff --git a/include/lapi/capability.h b/include/lapi/capability.h
index 95cb6819b..c6470f389 100644
--- a/include/lapi/capability.h
+++ b/include/lapi/capability.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
  */
 
-#ifndef LAPI_CAPABILITY_H
-#define LAPI_CAPABILITY_H
+#ifndef LAPI_CAPABILITY_H__
+#define LAPI_CAPABILITY_H__
 
 #include "config.h"
 
@@ -52,4 +52,4 @@
 # define CAP_TO_MASK(x)      (1 << ((x) & 31))
 #endif
 
-#endif
+#endif /* LAPI_CAPABILITY_H__ */
diff --git a/include/lapi/common_timers.h b/include/lapi/common_timers.h
index e50f698d6..74f9ca67f 100644
--- a/include/lapi/common_timers.h
+++ b/include/lapi/common_timers.h
@@ -4,8 +4,8 @@
  * Keep all the common defines/checks for the timer tests here
  */
 
-#ifndef __COMMON_TIMERS_H__
-#define __COMMON_TIMERS_H__
+#ifndef LAPI_COMMON_TIMERS_H__
+#define LAPI_COMMON_TIMERS_H__
 
 #include "config.h"
 #include "lapi/syscalls.h"
@@ -78,4 +78,4 @@ static inline int have_cputime_timers(void)
  */
 typedef int kernel_timer_t;
 
-#endif
+#endif /* LAPI_COMMON_TIMERS__ */
diff --git a/include/lapi/cpuset.h b/include/lapi/cpuset.h
index 8f7136c3b..f4d62e3ee 100644
--- a/include/lapi/cpuset.h
+++ b/include/lapi/cpuset.h
@@ -17,8 +17,8 @@
 #define _GNU_SOURCE
 #include <sched.h>
 
-#ifndef LTP_CPUSET_H
-#define LTP_CPUSET_H
+#ifndef LAPI_CPUSET_H__
+#define LAPI_CPUSET_H__
 
 #ifndef CPU_ALLOC
 #define CPU_ALLOC(ncpus) malloc(sizeof(cpu_set_t)); \
@@ -48,4 +48,4 @@ if (ncpus > CPU_SETSIZE) { \
 #define CPU_ISSET_S(cpu, size, mask) CPU_ISSET(cpu, mask)
 #endif
 
-#endif /* LTP_CPUSET_H */
+#endif /* LAPI_CPUSET_H__ */
diff --git a/include/lapi/cryptouser.h b/include/lapi/cryptouser.h
index e92fe96fb..31d1c3453 100644
--- a/include/lapi/cryptouser.h
+++ b/include/lapi/cryptouser.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2018 Richard Palethorpe <rpalethorpe@suse.com>
  */
 
-#ifndef CRYPTOUSER_H__
-#define CRYPTOUSER_H__
+#ifndef LAPI_CRYPTOUSER_H__
+#define LAPI_CRYPTOUSER_H__
 
 #ifdef HAVE_LINUX_CRYPTOUSER_H
 #  include <linux/cryptouser.h>
@@ -179,4 +179,4 @@ struct crypto_report_acomp {
 #  define CRYPTO_ALG_TYPE_ACOMPRESS_MASK	0x0000000e
 #endif
 
-#endif	/* CRYPTOUSER_H__ */
+#endif	/* LAPI_CRYPTOUSER_H__ */
diff --git a/include/lapi/execveat.h b/include/lapi/execveat.h
index 7a7032288..de4963b3f 100644
--- a/include/lapi/execveat.h
+++ b/include/lapi/execveat.h
@@ -3,8 +3,8 @@
  * Copyright (C) 2018 MediaTek Inc.  All Rights Reserved.
  */
 
-#ifndef EXECVEAT_H
-#define EXECVEAT_H
+#ifndef LAPI_EXECVEAT_H__
+#define LAPI_EXECVEAT_H__
 
 #include <sys/types.h>
 #include "config.h"
@@ -19,4 +19,4 @@ static inline int execveat(int dirfd, const char *pathname,
 }
 #endif
 
-#endif /* EXECVEAT_H */
+#endif /* LAPI_EXECVEAT_H__ */
diff --git a/include/lapi/fallocate.h b/include/lapi/fallocate.h
index 72f52c78f..92b6994a4 100644
--- a/include/lapi/fallocate.h
+++ b/include/lapi/fallocate.h
@@ -4,8 +4,8 @@
  * Copyright (c) 2014 Fujitsu Ltd.
  */
 
-#ifndef FALLOCATE_H
-#define FALLOCATE_H
+#ifndef LAPI_FALLOCATE_H__
+#define LAPI_FALLOCATE_H__
 
 #include <sys/types.h>
 #include <endian.h>
@@ -57,4 +57,4 @@ static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
 }
 #endif
 
-#endif /* FALLOCATE_H */
+#endif /* LAPI_FALLOCATE_H__ */
diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index e08970c4f..8a0a893f9 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
  */
 
-#ifndef __LAPI_FCNTL_H__
-#define __LAPI_FCNTL_H__
+#ifndef LAPI_FCNTL_H__
+#define LAPI_FCNTL_H__
 
 #include "config.h"
 #include <fcntl.h>
@@ -150,4 +150,4 @@ struct file_handle {
 };
 #endif /* HAVE_STRUCT_FILE_HANDLE */
 
-#endif /* __LAPI_FCNTL_H__ */
+#endif /* LAPI_FCNTL_H__ */
diff --git a/include/lapi/fnmatch.h b/include/lapi/fnmatch.h
index 9628ac440..3bfd6e71e 100644
--- a/include/lapi/fnmatch.h
+++ b/include/lapi/fnmatch.h
@@ -4,11 +4,11 @@
  * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
  */
 
-#ifndef FNMATCH_H__
-#define FNMATCH_H__
+#ifndef LAPI_FNMATCH_H__
+#define LAPI_FNMATCH_H__
 
 #ifndef FNM_EXTMATCH
 #define FNM_EXTMATCH 0
 #endif
 
-#endif
+#endif /* LAPI_FNMATCH_H__ */
diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 430d21f27..aafeab445 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -14,8 +14,8 @@
 #include <limits.h>
 #include "lapi/abisize.h"
 
-#ifndef LAPI_FS_H
-#define LAPI_FS_H
+#ifndef LAPI_FS_H__
+#define LAPI_FS_H__
 
 #ifndef FS_IOC_GETFLAGS
 #define	FS_IOC_GETFLAGS	_IOR('f', 1, long)
@@ -63,4 +63,4 @@ static inline loff_t tst_max_lfs_filesize(void)
 #endif
 }
 
-#endif
+#endif /* LAPI_FS_H__ */
diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index dc39c8791..fa2530675 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -4,8 +4,8 @@
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
 
-#ifndef FSMOUNT_H__
-#define FSMOUNT_H__
+#ifndef LAPI_FSMOUNT_H__
+#define LAPI_FSMOUNT_H__
 
 #include <sys/mount.h>
 #include <sys/syscall.h>
@@ -145,4 +145,4 @@ static inline void fsopen_supported_by_kernel(void)
 	}
 }
 
-#endif /* FSMOUNT_H__ */
+#endif /* LAPI_FSMOUNT_H__ */
diff --git a/include/lapi/getrandom.h b/include/lapi/getrandom.h
index 83e0a0e05..c654ca1ac 100644
--- a/include/lapi/getrandom.h
+++ b/include/lapi/getrandom.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2015 Linux Test Project
  */
 
-#ifndef __GETRANDOM_H__
-#define __GETRANDOM_H__
+#ifndef LAPI_GETRANDOM_H__
+#define LAPI_GETRANDOM_H__
 
 #include "config.h"
 
@@ -27,4 +27,4 @@
 # define GRND_RANDOM	0x0002
 #endif
 
-#endif /* __GETRANDOM_H__ */
+#endif /* LAPI_GETRANDOM_H__ */
diff --git a/include/lapi/if_alg.h b/include/lapi/if_alg.h
index 9c04a444c..466957e9e 100644
--- a/include/lapi/if_alg.h
+++ b/include/lapi/if_alg.h
@@ -3,8 +3,8 @@
  * Copyright 2019 Google LLC
  */
 
-#ifndef IF_ALG_H__
-#define IF_ALG_H__
+#ifndef LAPI_IF_ALG_H__
+#define LAPI_IF_ALG_H__
 
 #ifdef HAVE_LINUX_IF_ALG_H
 #  include <linux/if_alg.h>
@@ -56,4 +56,4 @@ struct af_alg_iv {
 # define ALG_OP_ENCRYPT		1
 #endif
 
-#endif /* IF_ALG_H__ */
+#endif /* LAPI_IF_ALG_H__ */
diff --git a/include/lapi/if_ether.h b/include/lapi/if_ether.h
index 0e9a4fcc1..536d1863a 100644
--- a/include/lapi/if_ether.h
+++ b/include/lapi/if_ether.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
  */
 
-#ifndef __LAPI_IF_ETHER_H__
-#define __LAPI_IF_ETHER_H__
+#ifndef LAPI_IF_ETHER_H__
+#define LAPI_IF_ETHER_H__
 
 #include "config.h"
 
@@ -16,4 +16,4 @@
 # define ETH_P_ALL 0x0003
 #endif
 
-#endif /* __LAPI_IF_ETHER_H__ */
+#endif /* LAPI_IF_ETHER_H__ */
diff --git a/include/lapi/if_packet.h b/include/lapi/if_packet.h
index fdaed293d..8c6c2e0e2 100644
--- a/include/lapi/if_packet.h
+++ b/include/lapi/if_packet.h
@@ -4,8 +4,8 @@
  * Author: Jinhui huang <huangjh.jy@cn.fujitsu.com>
  */
 
-#ifndef __LAPI_IF_PACKET_H__
-#define __LAPI_IF_PACKET_H__
+#ifndef LAPI_IF_PACKET_H__
+#define LAPI_IF_PACKET_H__
 
 #include "config.h"
 
@@ -51,4 +51,4 @@ struct tpacket_req3 {
 };
 #endif
 
-#endif /* __LAPI_IF_PACKET_H__ */
+#endif /* LAPI_IF_PACKET_H__ */
diff --git a/include/lapi/init_module.h b/include/lapi/init_module.h
index 48464a2e4..8c820059a 100644
--- a/include/lapi/init_module.h
+++ b/include/lapi/init_module.h
@@ -4,8 +4,8 @@
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
 
-#ifndef INIT_MODULE_H__
-#define INIT_MODULE_H__
+#ifndef LAPI_INIT_MODULE_H__
+#define LAPI_INIT_MODULE_H__
 
 #include "config.h"
 #include "lapi/syscalls.h"
@@ -34,4 +34,4 @@ static inline void finit_module_supported_by_kernel(void)
        }
 }
 
-#endif /* INIT_MODULE_H__ */
+#endif /* LAPI_INIT_MODULE_H__ */
diff --git a/include/lapi/io_pgetevents.h b/include/lapi/io_pgetevents.h
index 5bb9a60c3..4ab13a6d4 100644
--- a/include/lapi/io_pgetevents.h
+++ b/include/lapi/io_pgetevents.h
@@ -4,8 +4,8 @@
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
 
-#ifndef IO_PGETEVENTS_H
-#define IO_PGETEVENTS_H
+#ifndef LAPI_IO_PGETEVENTS_H__
+#define LAPI_IO_PGETEVENTS_H__
 
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -32,4 +32,4 @@ static inline int sys_io_pgetevents_time64(io_context_t ctx, long min_nr, long m
 
 #endif /* HAVE_LIBAIO */
 
-#endif /* IO_PGETEVENTS_H */
+#endif /* LAPI_IO_PGETEVENTS_H__ */
diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index e5c879951..397324511 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -6,8 +6,8 @@
  * Mostly copied/adapted from <linux/io_uring.h>
  */
 
-#ifndef IO_URING_H__
-#define IO_URING_H__
+#ifndef LAPI_IO_URING_H__
+#define LAPI_IO_URING_H__
 
 #include <unistd.h>
 #include <fcntl.h>
@@ -307,4 +307,4 @@ static inline void io_uring_setup_supported_by_kernel(void)
 	}
 }
 
-#endif /* IO_URING_H__ */
+#endif /* LAPI_IO_URING_H__ */
diff --git a/include/lapi/ioctl.h b/include/lapi/ioctl.h
index ecd250290..f91a9e68c 100644
--- a/include/lapi/ioctl.h
+++ b/include/lapi/ioctl.h
@@ -4,8 +4,8 @@
  * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
  */
 
-#ifndef IOCTL_H__
-#define IOCTL_H__
+#ifndef LAPI_IOCTL_H__
+#define LAPI_IOCTL_H__
 
 #include "config.h"
 #include <sys/ioctl.h>
@@ -37,4 +37,4 @@ struct termio
 };
 #endif /* HAVE_STRUCT_TERMIO */
 
-#endif /* IOCTL_H__ */
+#endif /* LAPI_IOCTL_H__ */
diff --git a/include/lapi/ioctl_ns.h b/include/lapi/ioctl_ns.h
index 2fb4f4cfb..9c81d5ce2 100644
--- a/include/lapi/ioctl_ns.h
+++ b/include/lapi/ioctl_ns.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2019 Federico Bonfiglio fedebonfi95@gmail.com
  */
 
-#ifndef IOCTL_NS_H__
-#define IOCTL_NS_H__
+#ifndef LAPI_IOCTL_NS_H__
+#define LAPI_IOCTL_NS_H__
 
 #include <asm-generic/ioctl.h>
 
@@ -25,4 +25,4 @@
 #endif
 
 
-#endif /* IOCTL_NS_H__ */
+#endif /* LAPI_IOCTL_NS_H__ */
diff --git a/include/lapi/iovec.h b/include/lapi/iovec.h
index d479e9f85..8d9fe1036 100644
--- a/include/lapi/iovec.h
+++ b/include/lapi/iovec.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
  */
 
-#ifndef IOVEC_H
-#define IOVEC_H
+#ifndef LAPI_IOVEC_H__
+#define LAPI_IOVEC_H__
 
 #include "config.h"
 
@@ -17,4 +17,4 @@ struct iovec {
 # include <sys/uio.h>
 #endif
 
-#endif /* IOVEC_H */
+#endif /* LAPI_IOVEC_H__ */
diff --git a/include/lapi/ip_tables.h b/include/lapi/ip_tables.h
index 3ac62141c..d0ed33324 100644
--- a/include/lapi/ip_tables.h
+++ b/include/lapi/ip_tables.h
@@ -44,4 +44,4 @@ struct xt_entry_target {
 };
 #endif
 
-#endif
+#endif /* LAPI_IP_TABLES__ */
diff --git a/include/lapi/ipcbuf.h b/include/lapi/ipcbuf.h
index a0b8e3ce3..ee0a9bafb 100644
--- a/include/lapi/ipcbuf.h
+++ b/include/lapi/ipcbuf.h
@@ -4,8 +4,8 @@
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
 
-#ifndef IPCBUF_H
-#define IPCBUF_H
+#ifndef LAPI_IPCBUF_H__
+#define LAPI_IPCBUF_H__
 
 #include "config.h"
 #include "lapi/posix_types.h"
@@ -192,4 +192,4 @@ struct ipc64_perm {
 
 #endif /* HAVE_IPC64_PERM */
 
-#endif /* IPCBUF_H */
+#endif /* LAPI_IPCBUF_H__ */
diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
index c53876e96..d899345c9 100644
--- a/include/lapi/keyctl.h
+++ b/include/lapi/keyctl.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
  */
 
-#ifndef KEYCTL_H__
-#define KEYCTL_H__
+#ifndef LAPI_KEYCTL_H__
+#define LAPI_KEYCTL_H__
 
 #include "config.h"
 
@@ -175,4 +175,4 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
 # define KEY_OTH_ALL     0x0000003f
 #endif /* !KEY_POS_VIEW */
 
-#endif	/* KEYCTL_H__ */
+#endif	/* LAPI_KEYCTL_H__ */
diff --git a/include/lapi/loop.h b/include/lapi/loop.h
index 87a902317..c663eea1a 100644
--- a/include/lapi/loop.h
+++ b/include/lapi/loop.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
  * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
  */
-#ifndef LAPI_LOOP_H
-#define LAPI_LOOP_H
+#ifndef LAPI_LOOP_H__
+#define LAPI_LOOP_H__
 
 #include "config.h"
 #include <linux/types.h>
@@ -52,4 +52,4 @@ struct loop_config {
 };
 #endif
 
-#endif
+#endif /* LAPI_LOOP_H__ */
diff --git a/include/lapi/membarrier.h b/include/lapi/membarrier.h
index 2b6c57fb3..eda63cd8a 100644
--- a/include/lapi/membarrier.h
+++ b/include/lapi/membarrier.h
@@ -4,8 +4,8 @@
  * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
  */
 
-#ifndef LAPI_MEMBARRIER_H
-#define LAPI_MEMBARRIER_H
+#ifndef LAPI_MEMBARRIER_H__
+#define LAPI_MEMBARRIER_H__
 
 /*
  * Having <linux/membarrier.h> is enough to know if the test should run or
@@ -27,4 +27,4 @@ enum membarrier_cmd {
 	MEMBARRIER_CMD_SHARED			= MEMBARRIER_CMD_GLOBAL,
 };
 
-#endif
+#endif /* LAPI_MEMBARRIER_H__ */
diff --git a/include/lapi/memfd.h b/include/lapi/memfd.h
index e38e671bb..57b6cd83d 100644
--- a/include/lapi/memfd.h
+++ b/include/lapi/memfd.h
@@ -3,8 +3,8 @@
  * Copyright (C) 2017  Red Hat, Inc.
  */
 
-#ifndef LAPI_MEMFD_H
-#define LAPI_MEMFD_H
+#ifndef LAPI_MEMFD_H__
+#define LAPI_MEMFD_H__
 
 /* flags for memfd_create(2) (unsigned int) */
 #ifndef MFD_CLOEXEC
@@ -47,4 +47,4 @@
 #define MFD_HUGE_16GB (34 << 26)
 #endif
 
-#endif
+#endif /* LAPI_MEMFD_H__ */
diff --git a/include/lapi/mkdirat.h b/include/lapi/mkdirat.h
index ae2c7284b..4d452d684 100644
--- a/include/lapi/mkdirat.h
+++ b/include/lapi/mkdirat.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
  */
 
-#ifndef __MKDIRAT_H__
-#define __MKDIRAT_H__
+#ifndef LAPI_MKDIRAT_H__
+#define LAPI_MKDIRAT_H__
 
 #include "config.h"
 #include "lapi/syscalls.h"
@@ -17,4 +17,4 @@ static inline int mkdirat(int dirfd, const char *dirname, int mode)
 }
 #endif
 
-#endif /* __MKDIRAT_H__ */
+#endif /* LAPI_MKDIRAT_H__ */
diff --git a/include/lapi/mlock2.h b/include/lapi/mlock2.h
index fa2b2de07..7b180eada 100644
--- a/include/lapi/mlock2.h
+++ b/include/lapi/mlock2.h
@@ -5,7 +5,7 @@
  */
 
 #ifndef LAPI_MLOCK2_H__
-# define LAPI_MLOCK2_H__
+#define LAPI_MLOCK2_H__
 
 #include <linux/mman.h>
 
diff --git a/include/lapi/mount.h b/include/lapi/mount.h
index b8ae1f594..29054eef9 100644
--- a/include/lapi/mount.h
+++ b/include/lapi/mount.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2015 Cui Bixuan <cuibixuan@huawei.com>
  */
 
-#ifndef __MOUNT_H__
-#define __MOUNT_H__
+#ifndef LAPI_MOUNT_H__
+#define LAPI_MOUNT_H__
 
 #ifndef MS_REC
 #define MS_REC 16384
@@ -30,4 +30,4 @@
 #define UMOUNT_NOFOLLOW 8
 #endif
 
-#endif /* __MOUNT_H__ */
+#endif /* LAPI_MOUNT_H__ */
diff --git a/include/lapi/msg.h b/include/lapi/msg.h
index 029511120..ab37cdaac 100644
--- a/include/lapi/msg.h
+++ b/include/lapi/msg.h
@@ -3,8 +3,9 @@
  * Copyright (c) 2020 FUJITSU LIMITED. All rights reserved.
  * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
  */
-#ifndef LAPI_MSG_H
-#define LAPI_MSG_H
+
+#ifndef LAPI_MSG_H__
+#define LAPI_MSG_H__
 
 #include <sys/msg.h>
 
@@ -16,4 +17,4 @@
 # define MSG_STAT_ANY 13
 #endif
 
-#endif
+#endif /* LAPI_MSG_H__ */
diff --git a/include/lapi/msgbuf.h b/include/lapi/msgbuf.h
index 873902e95..9736b99bf 100644
--- a/include/lapi/msgbuf.h
+++ b/include/lapi/msgbuf.h
@@ -4,8 +4,8 @@
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
 
-#ifndef IPC_MSGBUF_H
-#define IPC_MSGBUF_H
+#ifndef LAPI_MSGBUF_H__
+#define LAPI_MSGBUF_H__
 
 #include "lapi/posix_types.h"
 #include <sys/sem.h>
@@ -303,4 +303,4 @@ struct msqid64_ds {
 
 #endif /* HAVE_MSQID64_DS */
 
-#endif /* IPC_MSGBUF_H */
+#endif /* LAPI_MSGBUF_H__ */
diff --git a/include/lapi/name_to_handle_at.h b/include/lapi/name_to_handle_at.h
index 3f081f1c0..bdc59b549 100644
--- a/include/lapi/name_to_handle_at.h
+++ b/include/lapi/name_to_handle_at.h
@@ -4,8 +4,8 @@
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
 
-#ifndef NAME_TO_HANDLE_AT_H__
-#define NAME_TO_HANDLE_AT_H__
+#ifndef LAPI_NAME_TO_HANDLE_AT_H__
+#define LAPI_NAME_TO_HANDLE_AT_H__
 
 #include <sys/syscall.h>
 #include "config.h"
@@ -57,4 +57,4 @@ allocate_file_handle(int dfd, const char *pathname)
 	return fhp;
 }
 
-#endif /* NAME_TO_HANDLE_AT_H__ */
+#endif /* LAPI_NAME_TO_HANDLE_AT_H__ */
diff --git a/include/lapi/namespaces_constants.h b/include/lapi/namespaces_constants.h
index 8f73c4302..447f16c5b 100644
--- a/include/lapi/namespaces_constants.h
+++ b/include/lapi/namespaces_constants.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2015 Red Hat, Inc.
  */
 
-#ifndef __NAMESPACES_CONSTANTS_H__
-#define __NAMESPACES_CONSTANTS_H__
+#ifndef LAPI_NAMESPACES_CONSTANTS_H__
+#define LAPI_NAMESPACES_CONSTANTS_H__
 
 #ifndef CLONE_NEWIPC
 #  define CLONE_NEWIPC	0x08000000
@@ -28,4 +28,4 @@
 #  define CLONE_NEWTIME 0x00000080
 #endif
 
-#endif /* __NAMESPACES_CONSTANTS_H__ */
+#endif /* LAPI_NAMESPACES_CONSTANTS_H__ */
diff --git a/include/lapi/numaif.h b/include/lapi/numaif.h
index 32dfb5652..4362b75c1 100644
--- a/include/lapi/numaif.h
+++ b/include/lapi/numaif.h
@@ -3,11 +3,11 @@
  * Copyright (c) 2021 Linux Test Project
  */
 
-#ifndef NUMAIF_H__
-#define NUMAIF_H__
+#ifndef LAPI_NUMAIF_H__
+#define LAPI_NUMAIF_H__
 
 #ifndef MPOL_LOCAL
 # define MPOL_LOCAL	4
 #endif
 
-#endif /* NUMAIF_H__ */
+#endif /* LAPI_NUMAIF_H__ */
diff --git a/include/lapi/openat2.h b/include/lapi/openat2.h
index 46804a441..03327bdb7 100644
--- a/include/lapi/openat2.h
+++ b/include/lapi/openat2.h
@@ -4,8 +4,8 @@
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
 
-#ifndef OPENAT2_H
-#define OPENAT2_H
+#ifndef LAPI_OPENAT2_H__
+#define LAPI_OPENAT2_H__
 
 #include <sys/syscall.h>
 #include <linux/types.h>
@@ -72,4 +72,4 @@ static inline void openat2_supported_by_kernel(void)
 	}
 }
 
-#endif /* OPENAT2_H */
+#endif /* LAPI_OPENAT2_H__ */
diff --git a/include/lapi/personality.h b/include/lapi/personality.h
index 6b4b7ebf3..2cbb5dceb 100644
--- a/include/lapi/personality.h
+++ b/include/lapi/personality.h
@@ -7,8 +7,8 @@
  * but in musl macros are used.
  */
 
-#ifndef PERSONALITY_H
-#define PERSONALITY_H
+#ifndef LAPI_PERSONALITY_H__
+#define LAPI_PERSONALITY_H__
 
 #include <sys/personality.h>
 
@@ -20,4 +20,4 @@
 # define READ_IMPLIES_EXEC 0x0400000
 #endif
 
-#endif	/* PERSONALITY_H */
+#endif	/* LAPI_PERSONALITY_H__ */
diff --git a/include/lapi/pidfd_open.h b/include/lapi/pidfd_open.h
index 2b0c5b073..9806c73d4 100644
--- a/include/lapi/pidfd_open.h
+++ b/include/lapi/pidfd_open.h
@@ -4,8 +4,8 @@
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
 
-#ifndef PIDFD_OPEN_H
-#define PIDFD_OPEN_H
+#ifndef LAPI_PIDFD_OPEN_H__
+#define LAPI_PIDFD_OPEN_H__
 
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -21,4 +21,4 @@ static inline int pidfd_open(pid_t pid, unsigned int flags)
 }
 #endif
 
-#endif /* PIDFD_OPEN_H */
+#endif /* LAPI_PIDFD_OPEN_H__ */
diff --git a/include/lapi/pidfd_send_signal.h b/include/lapi/pidfd_send_signal.h
index 512174def..7426a91da 100644
--- a/include/lapi/pidfd_send_signal.h
+++ b/include/lapi/pidfd_send_signal.h
@@ -4,8 +4,8 @@
  * Author: Christian Amann <camann@suse.com>
  */
 
-#ifndef PIDFD_SEND_SIGNAL_H
-#define PIDFD_SEND_SIGNAL_H
+#ifndef LAPI_PIDFD_SEND_SIGNAL_H__
+#define LAPI_PIDFD_SEND_SIGNAL_H__
 
 #include "tst_test.h"
 #include "lapi/syscalls.h"
@@ -24,4 +24,4 @@ static inline int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
 }
 #endif /* HAVE_PIDFD_SEND_SIGNAL */
 
-#endif /* PIDFD_SEND_SIGNAL_H */
+#endif /* LAPI_PIDFD_SEND_SIGNAL_H__ */
diff --git a/include/lapi/posix_clocks.h b/include/lapi/posix_clocks.h
index ae2139fe3..d16f182eb 100644
--- a/include/lapi/posix_clocks.h
+++ b/include/lapi/posix_clocks.h
@@ -6,8 +6,8 @@
 
 #include <time.h>
 
-#ifndef POSIX_CLOCKS_H__
-#define POSIX_CLOCKS_H__
+#ifndef LAPI_POSIX_CLOCKS_H__
+#define LAPI_POSIX_CLOCKS_H__
 
 #define MAX_CLOCKS 16
 
@@ -39,4 +39,4 @@
 #define CLOCK_TAI 11
 #endif
 
-#endif /* POSIX_CLOCKS_H__ */
+#endif /* LAPI_POSIX_CLOCKS_H__ */
diff --git a/include/lapi/posix_types.h b/include/lapi/posix_types.h
index 9c0947cca..44f6697a9 100644
--- a/include/lapi/posix_types.h
+++ b/include/lapi/posix_types.h
@@ -3,8 +3,8 @@
  * Copyright (c) Linux Test Project, 2014-2019
  */
 
-#ifndef POSIX_TYPES_H__
-#define POSIX_TYPES_H__
+#ifndef LAPI_POSIX_TYPES_H__
+#define LAPI_POSIX_TYPES_H__
 
 #include <linux/posix_types.h>
 
@@ -18,4 +18,4 @@ typedef unsigned long		__kernel_ulong_t;
 # endif
 #endif
 
-#endif /* POSIX_TYPES_H__ */
+#endif /* LAPI_POSIX_TYPES_H__ */
diff --git a/include/lapi/prctl.h b/include/lapi/prctl.h
index 4499df030..fa5922231 100644
--- a/include/lapi/prctl.h
+++ b/include/lapi/prctl.h
@@ -5,7 +5,7 @@
  */
 
 #ifndef LAPI_PRCTL_H__
-# define LAPI_PRCTL_H__
+#define LAPI_PRCTL_H__
 
 #include <sys/prctl.h>
 
diff --git a/include/lapi/preadv2.h b/include/lapi/preadv2.h
index 19ac589f3..db89547e2 100644
--- a/include/lapi/preadv2.h
+++ b/include/lapi/preadv2.h
@@ -4,8 +4,8 @@
  * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
  */
 
-#ifndef PREADV2_H
-#define PREADV2_H
+#ifndef LAPI_PREADV2_H__
+#define LAPI_PREADV2_H__
 
 #include "config.h"
 #include "lapi/syscalls.h"
@@ -27,4 +27,4 @@ static inline ssize_t preadv2(int fd, const struct iovec *iov, int iovcnt,
 }
 #endif
 
-#endif /* PREADV2_H */
+#endif /* LAPI_PREADV2_H__ */
diff --git a/include/lapi/pwritev2.h b/include/lapi/pwritev2.h
index a93f017c6..48b53f463 100644
--- a/include/lapi/pwritev2.h
+++ b/include/lapi/pwritev2.h
@@ -4,8 +4,8 @@
  * Author: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
  */
 
-#ifndef PWRITEV2_H
-#define PWRITEV2_H
+#ifndef LAPI_PWRITEV2_H__
+#define LAPI_PWRITEV2_H__
 
 #include "config.h"
 #include "lapi/syscalls.h"
@@ -23,4 +23,4 @@ static inline ssize_t pwritev2(int fd, const struct iovec *iov, int iovcnt,
 }
 #endif
 
-#endif /* PWRITEV2_H */
+#endif /* LAPI_PWRITEV2_H__ */
diff --git a/include/lapi/readdir.h b/include/lapi/readdir.h
index 84e77ae0a..ec82604a1 100644
--- a/include/lapi/readdir.h
+++ b/include/lapi/readdir.h
@@ -4,8 +4,8 @@
  * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
  */
 
-#ifndef READDIR_H
-#define READDIR_H
+#ifndef LAPI_READDIR_H__
+#define LAPI_READDIR_H__
 
 #include <limits.h>
 
@@ -16,4 +16,4 @@ struct old_linux_dirent {
 	char  d_name[NAME_MAX+1];	/* filename (null-terminated) */
 };
 
-#endif /* READDIR_H */
+#endif /* LAPI_READDIR_H__ */
diff --git a/include/lapi/readlinkat.h b/include/lapi/readlinkat.h
index 4205d0070..bf1564823 100644
--- a/include/lapi/readlinkat.h
+++ b/include/lapi/readlinkat.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
  */
 
-#ifndef __READLINKAT_H__
-#define __READLINKAT_H__
+#ifndef LAPI_READLINKAT_H__
+#define LAPI_READLINKAT_H__
 
 #include "config.h"
 #include "lapi/syscalls.h"
@@ -18,4 +18,4 @@ static inline int readlinkat(int dirfd, const char *pathname,
 }
 #endif
 
-#endif /* __READLINKAT_H__ */
+#endif /* LAPI_READLINKAT_H__ */
diff --git a/include/lapi/renameat.h b/include/lapi/renameat.h
index c92b30a9a..0a9e8e595 100644
--- a/include/lapi/renameat.h
+++ b/include/lapi/renameat.h
@@ -4,8 +4,8 @@
  * Copyright (c) 2014 Fujitsu Ltd.
  */
 
-#ifndef RENAMEAT_H
-#define RENAMEAT_H
+#ifndef LAPI_RENAMEAT_H__
+#define LAPI_RENAMEAT_H__
 
 #include <sys/types.h>
 #include "config.h"
@@ -20,4 +20,4 @@ static inline int renameat(int olddirfd, const char *oldpath, int newdirfd,
 }
 #endif
 
-#endif /* RENAMEAT_H */
+#endif /* LAPI_RENAMEAT_H__ */
diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index 3af91362f..f368c07d8 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -6,8 +6,8 @@
  * Author: Ngie Cooper <yaneurabeya@gmail.com>
  */
 
-#ifndef LTP_RT_SIGACTION_H
-#define LTP_RT_SIGACTION_H
+#ifndef LAPI_RT_SIGACTION_H__
+#define LAPI_RT_SIGACTION_H__
 
 #include "ltp_signal.h"
 
@@ -242,4 +242,4 @@ static int ltp_rt_sigaction(int signum, const struct sigaction *act,
 	return ret;
 }
 
-#endif /* LTP_RT_SIGACTION_H */
+#endif /* LAPI_RT_SIGACTION_H__ */
diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index ee38c3a1c..036edd51d 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2015 Cui Bixuan <cuibixuan@huawei.com>
  */
 
-#ifndef __SCHED_H__
-#define __SCHED_H__
+#ifndef LAPI_SCHED_H__
+#define LAPI_SCHED_H__
 
 #include "lapi/syscalls.h"
 #include <stdint.h>
@@ -56,4 +56,4 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
 #define CLONE_IO        0x80000000
 #endif
 
-#endif /* __SCHED_H__ */
+#endif /* LAPI_SCHED_H__ */
diff --git a/include/lapi/seccomp.h b/include/lapi/seccomp.h
index fe95cab1b..29819ba6f 100644
--- a/include/lapi/seccomp.h
+++ b/include/lapi/seccomp.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
  * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
  */
-#ifndef LAPI_SECCOMP_H
-#define LAPI_SECCOMP_H
+#ifndef LAPI_SECCOMP_H__
+#define LAPI_SECCOMP_H__
 
 #include <stdint.h>
 
@@ -37,4 +37,4 @@ struct seccomp_data {
 };
 
 #endif /* HAVE_LINUX_SECCOMP_H*/
-#endif /* LAPI_SECCOMP_H */
+#endif /* LAPI_SECCOMP_H__ */
diff --git a/include/lapi/securebits.h b/include/lapi/securebits.h
index 2da137c3a..1b4d003c2 100644
--- a/include/lapi/securebits.h
+++ b/include/lapi/securebits.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
  * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
  */
-#ifndef LAPI_SECUREBITS_H
-#define LAPI_SECUREBITS_H
+#ifndef LAPI_SECUREBITS_H__
+#define LAPI_SECUREBITS_H__
 
 # ifdef HAVE_LINUX_SECUREBITS_H
 #  include <linux/securebits.h>
@@ -14,4 +14,4 @@
 #  define SECBIT_NO_CAP_AMBIENT_RAISE  6
 # endif
 
-#endif /* LAPI_SECUREBITS_H */
+#endif /* LAPI_SECUREBITS_H__ */
diff --git a/include/lapi/seek.h b/include/lapi/seek.h
index 1a29ba45d..7062ee8d4 100644
--- a/include/lapi/seek.h
+++ b/include/lapi/seek.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
  */
 
-#ifndef SEEK_H__
-#define SEEK_H__
+#ifndef LAPI_SEEK_H__
+#define LAPI_SEEK_H__
 
 #include <unistd.h>
 
@@ -16,4 +16,4 @@
 # define SEEK_HOLE 4
 #endif
 
-#endif /* SEEK_H__ */
+#endif /* LAPI_SEEK_H__ */
diff --git a/include/lapi/sem.h b/include/lapi/sem.h
index 8ba92de36..495afe937 100644
--- a/include/lapi/sem.h
+++ b/include/lapi/sem.h
@@ -2,8 +2,8 @@
 /*
  * Copyright (c) 2015 Linux Test Project
  */
-#ifndef LAPI_SEM_H
-#define LAPI_SEM_H
+#ifndef LAPI_SEM_H__
+#define LAPI_SEM_H__
 
 #include <sys/sem.h>
 
@@ -24,4 +24,4 @@ union semun {
 # define SEM_STAT_ANY 20
 #endif
 
-#endif /* LAPI_SEM_H */
+#endif /* LAPI_SEM_H__ */
diff --git a/include/lapi/sembuf.h b/include/lapi/sembuf.h
index 66579d294..94a43a291 100644
--- a/include/lapi/sembuf.h
+++ b/include/lapi/sembuf.h
@@ -4,8 +4,8 @@
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
 
-#ifndef IPC_SEMBUF_H
-#define IPC_SEMBUF_H
+#ifndef LAPI_SEMBUF_H__
+#define LAPI_SEMBUF_H__
 
 #include "lapi/posix_types.h"
 #include <sys/sem.h>
@@ -231,4 +231,4 @@ struct semid64_ds {
 
 #endif /* HAVE_SEMID64_DS */
 
-#endif /* IPC_SEMBUF_H */
+#endif /* LAPI_SEMBUF_H__ */
diff --git a/include/lapi/shmbuf.h b/include/lapi/shmbuf.h
index ad71d9431..b0a0fa3d9 100644
--- a/include/lapi/shmbuf.h
+++ b/include/lapi/shmbuf.h
@@ -4,8 +4,8 @@
  * Author: Viresh Kumar <viresh.kumar@linaro.org>
  */
 
-#ifndef IPC_SHMBUF_H
-#define IPC_SHMBUF_H
+#ifndef LAPI_SHMBUF_H__
+#define LAPI_SHMBUF_H__
 
 #include "lapi/posix_types.h"
 #include <sys/sem.h>
@@ -270,4 +270,4 @@ struct shmid64_ds {
 
 #endif /* HAVE_SHMID64_DS */
 
-#endif /* IPC_SHMBUF_H */
+#endif /* LAPI_SHMBUF_H__ */
diff --git a/include/lapi/signal.h b/include/lapi/signal.h
index d22965a94..6f4a76881 100644
--- a/include/lapi/signal.h
+++ b/include/lapi/signal.h
@@ -4,8 +4,8 @@
  * Author: Daniel D?az <daniel.diaz@linaro.org>
  */
 
-#ifndef LAPI_SIGNAL_H
-#define LAPI_SIGNAL_H
+#ifndef LAPI_SIGNAL_H__
+#define LAPI_SIGNAL_H__
 
 #include <signal.h>
 
@@ -21,4 +21,4 @@
 # define __SIGRTMAX (_NSIG - 1)
 #endif
 
-#endif
+#endif /* LAPI_SIGNAL_H__ */
diff --git a/include/lapi/socket.h b/include/lapi/socket.h
index d6389e504..794dee49f 100644
--- a/include/lapi/socket.h
+++ b/include/lapi/socket.h
@@ -4,8 +4,8 @@
 * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
 */
 
-#ifndef __LAPI_SOCKET_H__
-#define __LAPI_SOCKET_H__
+#ifndef LAPI_SOCKET_H__
+#define LAPI_SOCKET_H__
 
 #include "config.h"
 #include <sys/socket.h>
@@ -69,4 +69,4 @@ struct mmsghdr {
 };
 #endif
 
-#endif /* __LAPI_SOCKET_H__ */
+#endif /* LAPI_SOCKET_H__ */
diff --git a/include/lapi/splice.h b/include/lapi/splice.h
index 76ac7084a..191b22d2d 100644
--- a/include/lapi/splice.h
+++ b/include/lapi/splice.h
@@ -4,8 +4,8 @@
  * Copyright (c) 2014 Fujitsu Ltd.
  */
 
-#ifndef SPLICE_H
-#define SPLICE_H
+#ifndef LAPI_SPLICE_H__
+#define LAPI_SPLICE_H__
 
 #include "config.h"
 #include "lapi/syscalls.h"
@@ -19,4 +19,4 @@ static inline ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
 }
 #endif
 
-#endif /* SPLICE_H */
+#endif /* LAPI_SPLICE_H__ */
diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 979e42d37..69162a72b 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -4,8 +4,9 @@
  * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
  * Email: code@zilogic.com
  */
-#ifndef LAPI_STAT_H
-#define LAPI_STAT_H
+
+#ifndef LAPI_STAT_H__
+#define LAPI_STAT_H__
 
 #include <stdint.h>
 #include <unistd.h>
@@ -254,4 +255,4 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define AT_STATX_DONT_SYNC	0x4000
 #endif
 
-#endif
+#endif /* LAPI_STAT_H__ */
diff --git a/include/lapi/sync_file_range.h b/include/lapi/sync_file_range.h
index 86bfe5d6e..2f81e446c 100644
--- a/include/lapi/sync_file_range.h
+++ b/include/lapi/sync_file_range.h
@@ -3,8 +3,8 @@
  * Copyright (c) International Business Machines  Corp., 2008
  */
 
-#ifndef SYNC_FILE_RANGE_H
-#define SYNC_FILE_RANGE_H
+#ifndef LAPI_SYNC_FILE_RANGE_H__
+#define LAPI_SYNC_FILE_RANGE_H__
 
 #include <sys/types.h>
 #include "config.h"
@@ -55,4 +55,4 @@ static inline long sync_file_range(int fd, off64_t offset, off64_t nbytes,
 }
 #endif
 
-#endif /* SYNC_FILE_RANGE_H */
+#endif /* LAPI_SYNC_FILE_RANGE_H__ */
diff --git a/include/lapi/syncfs.h b/include/lapi/syncfs.h
index d3c0c8a2a..5624832c1 100644
--- a/include/lapi/syncfs.h
+++ b/include/lapi/syncfs.h
@@ -4,8 +4,8 @@
  * Author: Sumit Garg <sumit.garg@linaro.org>
  */
 
-#ifndef SYNCFS_H
-#define SYNCFS_H
+#ifndef LAPI_SYNCFS_H__
+#define LAPI_SYNCFS_H__
 
 #include "config.h"
 #include <sys/types.h>
@@ -18,4 +18,4 @@ static inline int syncfs(int fd)
 }
 #endif
 
-#endif /* SYNCFS_H */
+#endif /* LAPI_SYNCFS_H__ */
diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
index 8ac80440c..d7daf8ad0 100755
--- a/include/lapi/syscalls/regen.sh
+++ b/include/lapi/syscalls/regen.sh
@@ -27,8 +27,8 @@ cat << EOF > "${output_pid}"
  * Licensed under the GPLv2 or later, see the COPYING file.
  */
 
-#ifndef __LAPI_SYSCALLS_H__
-#define __LAPI_SYSCALLS_H__
+#ifndef LAPI_SYSCALLS_H__
+#define LAPI_SYSCALLS_H__
 
 #include <errno.h>
 #include <sys/syscall.h>
diff --git a/include/lapi/tee.h b/include/lapi/tee.h
index 237f4e1e0..8ba3c9be3 100644
--- a/include/lapi/tee.h
+++ b/include/lapi/tee.h
@@ -4,8 +4,8 @@
  * Copyright (c) 2014 Fujitsu Ltd.
  */
 
-#ifndef TEE_H
-#define TEE_H
+#ifndef LAPI_TEE_H__
+#define LAPI_TEE_H__
 
 #include "config.h"
 #include "lapi/syscalls.h"
@@ -18,4 +18,4 @@ static inline ssize_t tee(int fd_in, int fd_out,
 }
 #endif
 
-#endif /* TEE_H */
+#endif /* LAPI_TEE_H__ */
diff --git a/include/lapi/termbits.h b/include/lapi/termbits.h
index d79da085b..04f514818 100644
--- a/include/lapi/termbits.h
+++ b/include/lapi/termbits.h
@@ -10,4 +10,4 @@
 # define EXTPROC     0200000
 #endif
 
-#endif
+#endif /* LAPI_TERMBITS_H__ */
diff --git a/include/lapi/timerfd.h b/include/lapi/timerfd.h
index 91773ff72..14f8405ab 100644
--- a/include/lapi/timerfd.h
+++ b/include/lapi/timerfd.h
@@ -4,8 +4,8 @@
  * Copyright (c) 2014 Fujitsu Ltd.
  */
 
-#ifndef TIMERFD_H
-#define TIMERFD_H
+#ifndef LAPI_TIMERFD_H__
+#define LAPI_TIMERFD_H__
 
 #include <time.h>
 #include "config.h"
@@ -39,4 +39,4 @@ static inline int timerfd_gettime(int fd, struct itimerspec *curr_value)
 }
 #endif
 
-#endif /* TIMERFD_H */
+#endif /* LAPI_TIMERFD_H__ */
diff --git a/include/lapi/tty.h b/include/lapi/tty.h
index 6122145f3..93a625434 100644
--- a/include/lapi/tty.h
+++ b/include/lapi/tty.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
  */
 
-#ifndef LAPI_TTY_H
-#define LAPI_TTY_H
+#ifndef LAPI_TTY_H__
+#define LAPI_TTY_H__
 
 #ifdef HAVE_LINUX_TTY_H
 # include <linux/tty.h>
@@ -18,4 +18,4 @@
 # define N_SLCAN		17	/* Serial / USB serial CAN Adaptors */
 #endif
 
-#endif /* LAPI_TTY_H */
+#endif /* LAPI_TTY_H__ */
diff --git a/include/lapi/ustat.h b/include/lapi/ustat.h
index 98633e749..218a53b14 100644
--- a/include/lapi/ustat.h
+++ b/include/lapi/ustat.h
@@ -1,7 +1,7 @@
 //SPDX-License-Identifier: GPL-2.0-or-later
 
-#ifndef LAPI_USTAT_H
-#define LAPI_USTAT_H
+#ifndef LAPI_USTAT_H__
+#define LAPI_USTAT_H__
 
 #include "config.h"
 
@@ -19,4 +19,4 @@ struct ustat {
 };
 #endif
 
-#endif /* LAPI_USTAT_H */
+#endif /* LAPI_USTAT_H__ */
diff --git a/include/lapi/utime.h b/include/lapi/utime.h
index dbfaa55be..a8085ae0a 100644
--- a/include/lapi/utime.h
+++ b/include/lapi/utime.h
@@ -3,7 +3,8 @@
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
  */
 
-#ifndef __UTIME_H__
+#ifndef LAPI_UTIME_H__
+#define LAPI_UTIME_H__
 
 #ifndef UTIME_NOW
 # define UTIME_NOW ((1l << 30) - 1l)
@@ -13,4 +14,4 @@
 # define UTIME_OMIT ((1l << 30) - 2l)
 #endif
 
-#endif /* __UTIME_H__ */
+#endif /* LAPI_UTIME_H__ */
diff --git a/include/lapi/utsname.h b/include/lapi/utsname.h
index 6209eac47..f94d3e1e3 100644
--- a/include/lapi/utsname.h
+++ b/include/lapi/utsname.h
@@ -3,6 +3,9 @@
  * Copyright (c) 2019 Petr Vorel <petr.vorel@gmail.com>
  */
 
+#ifndef LAPI_UTSNAME_H__
+#define LAPI_UTSNAME_H__
+
 #ifdef HAVE_SYS_UTSNAME_H
 # include <sys/utsname.h>
 #endif
@@ -14,3 +17,5 @@
 #ifndef _UTSNAME_DOMAIN_LENGTH
 # define _UTSNAME_DOMAIN_LENGTH _UTSNAME_LENGTH
 #endif
+
+#endif /* LAPI_UTSNAME_H__ */
diff --git a/include/lapi/vm_sockets.h b/include/lapi/vm_sockets.h
index be34d2f13..07884e538 100644
--- a/include/lapi/vm_sockets.h
+++ b/include/lapi/vm_sockets.h
@@ -3,8 +3,8 @@
  * Copyright (C) 2021 SUSE LLC <rpalethorpe@suse.com>
  */
 
-#ifndef LAPI_VM_SOCKETS_H
-#define LAPI_VM_SOCKETS_H
+#ifndef LAPI_VM_SOCKETS_H__
+#define LAPI_VM_SOCKETS_H__
 
 #include <sys/socket.h>
 
@@ -16,4 +16,4 @@
 #  define VMADDR_CID_LOCAL 1
 #endif
 
-#endif /* LAPI_VM_SOCKETS_H */
+#endif /* LAPI_VM_SOCKETS_H__ */
diff --git a/include/lapi/vmsplice.h b/include/lapi/vmsplice.h
index 96b32f3fa..b6db77cb9 100644
--- a/include/lapi/vmsplice.h
+++ b/include/lapi/vmsplice.h
@@ -4,8 +4,8 @@
  * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
  */
 
-#ifndef VMSPLICE_H
-#define VMSPLICE_H
+#ifndef LAPI_VMSPLICE_H__
+#define LAPI_VMSPLICE_H__
 
 #include "config.h"
 #include "lapi/syscalls.h"
@@ -20,4 +20,4 @@ static inline ssize_t vmsplice(int fd, const struct iovec *iov,
 }
 #endif
 
-#endif /* VMSPLICE_H */
+#endif /* LAPI_VMSPLICE_H__ */
diff --git a/include/lapi/xfrm.h b/include/lapi/xfrm.h
index d9051202c..48503b7ef 100644
--- a/include/lapi/xfrm.h
+++ b/include/lapi/xfrm.h
@@ -14,4 +14,4 @@
 # define XFRM_MSG_GETPOLICY 21
 #endif
 
-#endif
+#endif /* LAPI_XFRM_H__ */
-- 
2.31.1

