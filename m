Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284D7C43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 10:06:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FB5C3CC491
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 11:06:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B64023CC470
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 11:06:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 21961201736
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 11:06:38 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 05E9C1FD68;
 Thu,  1 Dec 2022 10:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669889197;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wnYWmS0g4RfMl6TEXSDsQN86pZQo0klYpLkUSz53yKE=;
 b=1hOSIvEtwANywRpACNaTMFZLjGP4ZGcl2aV8vlea9S2lxqJcObBEkLTz8/0BwDun7d9asO
 yUbgKLoZPe3DwdevCJ4yfouMjF2ZXnU0EfYBqwr22pKX6ribOwSefjuytJf8m3KCEyrQjz
 rP81ULDMivNnavu93PqTZG6XeuBrOrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669889197;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wnYWmS0g4RfMl6TEXSDsQN86pZQo0klYpLkUSz53yKE=;
 b=Ccxqr+pkzECQ+UH2PcUlh9x6jP1yjwMwd3A1Iry5s9AtXEiXDhh9RgpbPvCZI4SA9nnuvW
 3+6r5lUzypRGGCBw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BE38C2C141;
 Thu,  1 Dec 2022 10:06:36 +0000 (UTC)
References: <1669704060-5635-1-git-send-email-xuyang2018.jy@fujitsu.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 01 Dec 2022 10:05:51 +0000
Organization: Linux Private Site
In-reply-to: <1669704060-5635-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <87pmd3igk3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] include/lapi/sched.h: move
 namespaces_constants.h's constant into here
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Yang Xu <xuyang2018.jy@fujitsu.com> writes:

> Kernel header doesn't have this namespaces_constants.h header file and
> it can be moved into lapi/sched. Also, lapi/clone.h have some duplicated
> CLONE_* constants, they should be moved into here too.

Good.

>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  include/lapi/namespaces_constants.h           | 34 ---------------
>  include/lapi/sched.h                          | 41 +++++++++++++++++--
>  lib/tst_net.c                                 |  2 +-
>  testcases/cve/cve-2017-16939.c                |  2 +-
>  testcases/cve/icmp_rate_limit01.c             |  2 +-
>  .../kernel/containers/libclone/libclone.h     |  3 +-
>  testcases/kernel/containers/mountns/mountns.h |  2 +-
>  .../kernel/containers/netns/netns_netlink.c   |  3 +-
>  testcases/kernel/containers/pidns/pidns01.c   |  2 +-
>  testcases/kernel/containers/pidns/pidns02.c   |  2 +-
>  testcases/kernel/containers/pidns/pidns03.c   |  2 +-
>  testcases/kernel/containers/pidns/pidns12.c   |  2 +-
>  testcases/kernel/containers/pidns/pidns20.c   |  2 +-
>  testcases/kernel/containers/pidns/pidns32.c   |  2 +-
>  testcases/kernel/containers/share/ns_common.h |  2 +-
>  testcases/kernel/containers/share/ns_create.c |  3 +-
>  testcases/kernel/containers/share/ns_exec.c   |  3 +-
>  testcases/kernel/containers/sysvipc/common.h  |  2 +-
>  testcases/kernel/containers/timens/timens01.c |  2 +-
>  testcases/kernel/containers/userns/common.h   |  2 +-
>  .../kernel/controllers/cgroup/cgroup_core02.c |  3 +-
>  .../syscalls/clock_gettime/clock_gettime03.c  |  2 +-
>  .../clock_nanosleep/clock_nanosleep03.c       |  2 +-
>  testcases/kernel/syscalls/clone/clone09.c     |  3 +-
>  .../kernel/syscalls/fanotify/fanotify17.c     |  3 +-
>  .../kernel/syscalls/getxattr/getxattr05.c     |  3 +-
>  testcases/kernel/syscalls/ioctl/ioctl_ns01.c  |  3 +-
>  testcases/kernel/syscalls/ioctl/ioctl_ns05.c  |  3 +-
>  testcases/kernel/syscalls/ioctl/ioctl_ns06.c  |  3 +-
>  testcases/kernel/syscalls/setns/setns.h       |  2 +-
>  testcases/kernel/syscalls/sysinfo/sysinfo03.c |  2 +-
>  testcases/kernel/syscalls/timerfd/timerfd04.c |  2 +-
>  32 files changed, 67 insertions(+), 79 deletions(-)
>  delete mode 100644 include/lapi/namespaces_constants.h
>
> diff --git a/include/lapi/namespaces_constants.h b/include/lapi/namespaces_constants.h
> deleted file mode 100644
> index e34b0d6a8..000000000
> --- a/include/lapi/namespaces_constants.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright (c) 2015 Red Hat, Inc.
> - */
> -
> -#ifndef LAPI_NAMESPACES_CONSTANTS_H__
> -#define LAPI_NAMESPACES_CONSTANTS_H__
> -
> -#ifndef CLONE_NEWIPC
> -#  define CLONE_NEWIPC	0x08000000
> -#endif
> -#ifndef CLONE_NEWNS
> -#  define CLONE_NEWNS	0x00020000
> -#endif
> -#ifndef CLONE_NEWNET
> -#  define CLONE_NEWNET	0x40000000
> -#endif
> -#ifndef CLONE_NEWPID
> -#  define CLONE_NEWPID	0x20000000
> -#endif
> -#ifndef CLONE_NEWUSER
> -#  define CLONE_NEWUSER	0x10000000
> -#endif
> -#ifndef CLONE_NEWCGROUP
> -#  define CLONE_NEWCGROUP 0x02000000
> -#endif
> -#ifndef CLONE_NEWUTS
> -#  define CLONE_NEWUTS	0x04000000
> -#endif
> -#ifndef CLONE_NEWTIME
> -#  define CLONE_NEWTIME 0x00000080
> -#endif
> -
> -#endif /* LAPI_NAMESPACES_CONSTANTS_H__ */
> diff --git a/include/lapi/sched.h b/include/lapi/sched.h
> index 226d3109a..3b0b4be31 100644
> --- a/include/lapi/sched.h
> +++ b/include/lapi/sched.h
> @@ -8,6 +8,7 @@
>  #define LAPI_SCHED_H__
>  
>  #include <sched.h>
> +#include <unistd.h>
>  #include <stdint.h>
>  #include <inttypes.h>
>  #include "lapi/syscalls.h"
> @@ -47,19 +48,51 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
>  #endif
>  
>  #ifndef CLONE_VM
> -# define CLONE_VM   0x00000100
> +# define CLONE_VM	0x00000100
>  #endif
>  
>  #ifndef CLONE_FS
> -# define CLONE_FS   0x00000200
> +# define CLONE_FS	0x00000200
> +#endif
> +
> +#ifndef CLONE_NEWNS
> +# define CLONE_NEWNS	0x00020000
>  #endif
>  
>  #ifndef CLONE_SYSVSEM
> -# define CLONE_SYSVSEM   0x00040000
> +# define CLONE_SYSVSEM	0x00040000
> +#endif
> +
> +#ifndef CLONE_NEWCGROUP
> +# define CLONE_NEWCGROUP	0x02000000
> +#endif
> +
> +#ifndef CLONE_NEWUTS
> +# define CLONE_NEWUTS		0x04000000
> +#endif
> +
> +#ifndef CLONE_NEWIPC
> +#  define CLONE_NEWIPC		0x08000000
> +#endif
> +
> +#ifndef CLONE_NEWUSER
> +#  define CLONE_NEWUSER		0x10000000
> +#endif
> +
> +#ifndef CLONE_NEWPID
> +#  define CLONE_NEWPID		0x20000000
> +#endif
> +
> +#ifndef CLONE_NEWNET
> +# define CLONE_NEWNET		0x40000000
>  #endif
>  
>  #ifndef CLONE_IO
> -# define CLONE_IO        0x80000000
> +# define CLONE_IO		0x80000000
> +#endif
> +
> +#ifndef CLONE_NEWTIME
> +# define CLONE_NEWTIME		0x00000080
>  #endif
>  
>  #endif /* LAPI_SCHED_H__ */
> diff --git a/lib/tst_net.c b/lib/tst_net.c
> index 61fc0ea76..a97e25b11 100644
> --- a/lib/tst_net.c
> +++ b/lib/tst_net.c
> @@ -14,7 +14,7 @@
>  #include "tst_test.h"
>  #include "tst_net.h"
>  #include "tst_private.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  void tst_print_svar(const char *name, const char *val)
>  {
> diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
> index eb5400c0c..e41fb274a 100644
> --- a/testcases/cve/cve-2017-16939.c
> +++ b/testcases/cve/cve-2017-16939.c
> @@ -25,7 +25,7 @@
>  #include "tst_res_flags.h"
>  #include "tst_safe_macros.h"
>  #include "tst_safe_net.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define BUFSIZE 2048
>  
> diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
> index 7a51aa0a4..8ee50a276 100644
> --- a/testcases/cve/icmp_rate_limit01.c
> +++ b/testcases/cve/icmp_rate_limit01.c
> @@ -34,7 +34,7 @@
>  #include "lapi/if_addr.h"
>  #include "tst_test.h"
>  #include "tst_netdevice.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define DSTNET 0xfa444e00 /* 250.68.78.0 */
>  #define SRCNET 0xfa444e40 /* 250.68.78.64 */
> diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
> index b8740f1bc..e92fdca02 100644
> --- a/testcases/kernel/containers/libclone/libclone.h
> +++ b/testcases/kernel/containers/libclone/libclone.h
> @@ -19,7 +19,6 @@
>  
>  #include <stdio.h>
>  #include <stdlib.h>
> -#include <sched.h>
>  #include <unistd.h>
>  #include <string.h>
>  #include <errno.h>
> @@ -28,7 +27,7 @@
>  #include <signal.h>
>  #include "lapi/syscalls.h"
>  #include "test.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define T_UNSHARE 0
>  #define T_CLONE 1
> diff --git a/testcases/kernel/containers/mountns/mountns.h b/testcases/kernel/containers/mountns/mountns.h
> index 76b37b477..615f1a058 100644
> --- a/testcases/kernel/containers/mountns/mountns.h
> +++ b/testcases/kernel/containers/mountns/mountns.h
> @@ -8,7 +8,7 @@
>  #define COMMON_H
>  
>  #include "tst_test.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define DIRA "LTP_DIR_A"
>  #define DIRB "LTP_DIR_B"
> diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
> index 6f60ff94e..e8df616e2 100644
> --- a/testcases/kernel/containers/netns/netns_netlink.c
> +++ b/testcases/kernel/containers/netns/netns_netlink.c
> @@ -33,11 +33,10 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <errno.h>
> -#include <sched.h>
>  
>  #include "tst_test.h"
>  #include "tst_safe_macros.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define MAX_TRIES 1000
>  
> diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel/containers/pidns/pidns01.c
> index eba4b806b..5080b6fad 100644
> --- a/testcases/kernel/containers/pidns/pidns01.c
> +++ b/testcases/kernel/containers/pidns/pidns01.c
> @@ -15,7 +15,7 @@
>   */
>  
>  #include "tst_test.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  {
> diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel/containers/pidns/pidns02.c
> index 9f3a46526..b8913d3f6 100644
> --- a/testcases/kernel/containers/pidns/pidns02.c
> +++ b/testcases/kernel/containers/pidns/pidns02.c
> @@ -14,7 +14,7 @@
>   */
>  
>  #include "tst_test.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  {
> diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
> index b9b38b5d9..122ba7891 100644
> --- a/testcases/kernel/containers/pidns/pidns03.c
> +++ b/testcases/kernel/containers/pidns/pidns03.c
> @@ -13,7 +13,7 @@
>  
>  #include <sys/mount.h>
>  #include "tst_test.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define PROCDIR "proc"
>  
> diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
> index 0e6b17142..fb1ec90ca 100644
> --- a/testcases/kernel/containers/pidns/pidns12.c
> +++ b/testcases/kernel/containers/pidns/pidns12.c
> @@ -16,7 +16,7 @@
>  #define _GNU_SOURCE 1
>  #include <signal.h>
>  #include "tst_test.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  static volatile pid_t sig_pid = -1;
>  
> diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
> index f1e239dde..9f369699a 100644
> --- a/testcases/kernel/containers/pidns/pidns20.c
> +++ b/testcases/kernel/containers/pidns/pidns20.c
> @@ -15,7 +15,7 @@
>  #define _GNU_SOURCE 1
>  #include <signal.h>
>  #include "tst_test.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  static volatile int signals;
>  static volatile int last_signo;
> diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
> index 333e1fcad..3f7df788e 100644
> --- a/testcases/kernel/containers/pidns/pidns32.c
> +++ b/testcases/kernel/containers/pidns/pidns32.c
> @@ -15,7 +15,7 @@
>  
>  #include <sys/mman.h>
>  #include "tst_test.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define MAXNEST 32
>  
> diff --git a/testcases/kernel/containers/share/ns_common.h b/testcases/kernel/containers/share/ns_common.h
> index 69e51ce71..0f85aceb4 100644
> --- a/testcases/kernel/containers/share/ns_common.h
> +++ b/testcases/kernel/containers/share/ns_common.h
> @@ -17,7 +17,7 @@
>  #ifndef __NS_COMMON_H__
>  #define __NS_COMMON_H__
>  #include <sched.h>
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define PROC_PATH "/proc"
>  #define NS_TOTAL 6
> diff --git a/testcases/kernel/containers/share/ns_create.c b/testcases/kernel/containers/share/ns_create.c
> index d4259f38b..3f09e71e0 100644
> --- a/testcases/kernel/containers/share/ns_create.c
> +++ b/testcases/kernel/containers/share/ns_create.c
> @@ -24,7 +24,6 @@
>   */
>  
>  #define _GNU_SOURCE
> -#include <sched.h>
>  #include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> @@ -32,7 +31,7 @@
>  #include <string.h>
>  #include <errno.h>
>  #include "test.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  #include "ns_common.h"
>  
>  char *TCID = "ns_create";
> diff --git a/testcases/kernel/containers/share/ns_exec.c b/testcases/kernel/containers/share/ns_exec.c
> index c492165f0..4abd1063b 100644
> --- a/testcases/kernel/containers/share/ns_exec.c
> +++ b/testcases/kernel/containers/share/ns_exec.c
> @@ -21,7 +21,6 @@
>   */
>  
>  #define _GNU_SOURCE
> -#include <sched.h>
>  #include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> @@ -31,7 +30,7 @@
>  #include <errno.h>
>  #include "test.h"
>  #include "lapi/syscalls.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  #include "ns_common.h"
>  
>  char *TCID = "ns_exec";
> diff --git a/testcases/kernel/containers/sysvipc/common.h b/testcases/kernel/containers/sysvipc/common.h
> index 258d355d7..9b0fc16e9 100644
> --- a/testcases/kernel/containers/sysvipc/common.h
> +++ b/testcases/kernel/containers/sysvipc/common.h
> @@ -11,7 +11,7 @@
>  #include <stdlib.h>
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  enum {
>  	T_CLONE,
> diff --git a/testcases/kernel/containers/timens/timens01.c b/testcases/kernel/containers/timens/timens01.c
> index 3f6235ec3..3621b3446 100644
> --- a/testcases/kernel/containers/timens/timens01.c
> +++ b/testcases/kernel/containers/timens/timens01.c
> @@ -15,9 +15,9 @@
>   */
>  
>  #define _GNU_SOURCE
> -#include "lapi/namespaces_constants.h"
>  #include "lapi/posix_clocks.h"
>  #include "tst_test.h"
> +#include "lapi/sched.h"
>  
>  static struct tcase {
>  	const char *desc;
> diff --git a/testcases/kernel/containers/userns/common.h b/testcases/kernel/containers/userns/common.h
> index d3bdcc53f..635d0f190 100644
> --- a/testcases/kernel/containers/userns/common.h
> +++ b/testcases/kernel/containers/userns/common.h
> @@ -8,7 +8,7 @@
>  #define COMMON_H
>  
>  #include "tst_test.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define UID_MAP 0
>  #define GID_MAP 1
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
> index e6d599b36..1872a7dff 100644
> --- a/testcases/kernel/controllers/cgroup/cgroup_core02.c
> +++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
> @@ -24,14 +24,13 @@
>   */
>  
>  #define _GNU_SOURCE
> -#include <sched.h>
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <sys/types.h>
>  #include <pwd.h>
>  #include "tst_test.h"
>  #include "tst_safe_file_at.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  static struct tst_cg_group *cg_child_a, *cg_child_b;
>  static uid_t nobody_uid;
> diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
> index f185977d3..b02d22a14 100644
> --- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
> +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
> @@ -18,7 +18,7 @@
>  #include "time64_variants.h"
>  #include "tst_safe_clocks.h"
>  #include "tst_timer.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  static struct tcase {
>  	int clk_id;
> diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
> index 5bd91fa61..dfc522278 100644
> --- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
> +++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
> @@ -18,7 +18,7 @@
>  #include "time64_variants.h"
>  #include "tst_safe_clocks.h"
>  #include "tst_timer.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define OFFSET_S 10
>  #define SLEEP_US 100000
> diff --git a/testcases/kernel/syscalls/clone/clone09.c b/testcases/kernel/syscalls/clone/clone09.c
> index e9e584564..e4691f513 100644
> --- a/testcases/kernel/syscalls/clone/clone09.c
> +++ b/testcases/kernel/syscalls/clone/clone09.c
> @@ -4,14 +4,13 @@
>   */
>  
>  #define _GNU_SOURCE
> -#include <sched.h>
>  #include <stdlib.h>
>  #include <errno.h>
>  
>  #include "tst_test.h"
>  #include "clone_platform.h"
>  #include "lapi/syscalls.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  static void *child_stack;
>  static int sysctl_net = -1;
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c b/testcases/kernel/syscalls/fanotify/fanotify17.c
> index 7d74b2540..3ecb31b6e 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify17.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify17.c
> @@ -20,11 +20,10 @@
>  #include <errno.h>
>  #include <unistd.h>
>  #include <sys/types.h>
> -#include <sched.h>
>  #include <stdlib.h>
>  
>  #include "tst_test.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #ifdef HAVE_SYS_FANOTIFY_H
>  #include "fanotify.h"
> diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
> index 3e73cc567..28eb4cbcf 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr05.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
> @@ -20,7 +20,6 @@
>  #include <errno.h>
>  #include <unistd.h>
>  #include <sys/types.h>
> -#include <sched.h>
>  #include <stdlib.h>
>  
>  #ifdef HAVE_SYS_XATTR_H
> @@ -32,7 +31,7 @@
>  #endif
>  
>  #include "tst_test.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #if defined(HAVE_SYS_XATTR_H) && defined(HAVE_LIBACL)
>  
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> index 95be877dc..06c81ba1b 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> @@ -19,11 +19,10 @@
>  #define _GNU_SOURCE
>  
>  #include <errno.h>
> -#include <sched.h>
>  #include <stdlib.h>
>  #include "tst_test.h"
>  #include "lapi/ioctl_ns.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define STACK_SIZE (1024 * 1024)
>  
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
> index ae2f9da51..36e41c468 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
> @@ -18,11 +18,10 @@
>  
>  #include <errno.h>
>  #include <stdio.h>
> -#include <sched.h>
>  #include <stdlib.h>
>  #include "tst_test.h"
>  #include "lapi/ioctl_ns.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define STACK_SIZE (1024 * 1024)
>  
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
> index 393ba1437..45fc01ce7 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
> @@ -19,11 +19,10 @@
>  
>  #include <errno.h>
>  #include <stdio.h>
> -#include <sched.h>
>  #include <stdlib.h>
>  #include "tst_test.h"
>  #include "lapi/ioctl_ns.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define STACK_SIZE (1024 * 1024)
>  
> diff --git a/testcases/kernel/syscalls/setns/setns.h b/testcases/kernel/syscalls/setns/setns.h
> index 46beef17f..45c759917 100644
> --- a/testcases/kernel/syscalls/setns/setns.h
> +++ b/testcases/kernel/syscalls/setns/setns.h
> @@ -4,7 +4,7 @@
>   */
>  
>  #include <stdio.h>
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define NS_MAX 5
>  static int ns_types[NS_MAX];
> diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo03.c b/testcases/kernel/syscalls/sysinfo/sysinfo03.c
> index af7cb6421..6b8f0aef7 100644
> --- a/testcases/kernel/syscalls/sysinfo/sysinfo03.c
> +++ b/testcases/kernel/syscalls/sysinfo/sysinfo03.c
> @@ -14,9 +14,9 @@
>   */
>  
>  #include <sys/sysinfo.h>
> -#include "lapi/namespaces_constants.h"
>  #include "lapi/posix_clocks.h"
>  #include "tst_test.h"
> +#include "lapi/sched.h"
>  
>  static int offsets[] = {
>  	10,
> diff --git a/testcases/kernel/syscalls/timerfd/timerfd04.c b/testcases/kernel/syscalls/timerfd/timerfd04.c
> index eb7f98d5b..b24b4874e 100644
> --- a/testcases/kernel/syscalls/timerfd/timerfd04.c
> +++ b/testcases/kernel/syscalls/timerfd/timerfd04.c
> @@ -19,7 +19,7 @@
>  #include "tst_safe_clocks.h"
>  #include "tst_safe_timerfd.h"
>  #include "tst_timer.h"
> -#include "lapi/namespaces_constants.h"
> +#include "lapi/sched.h"
>  
>  #define SLEEP_US 40000
>  
> -- 
> 2.23.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
