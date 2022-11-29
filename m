Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11532C4332F
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 05:50:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 084F23CC59D
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 06:50:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE0333CC590
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 06:50:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3C07E2000BC
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 06:50:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669701021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Wpq0k+NoN/KPu1cVXV+4YoUz2A9DIeXHtgnj/53kjg=;
 b=JS3VQded/NYC7JMxEz+vA4qALb26qSqvSUzcd6Zabr+tZwsxJz1V07pOZN+c4hC055IYaB
 p0kMeBVYZkn2MmTRb+Ga+ixldInqSDOwrlDUGPzafYMGooRUfGNl5PpqWStzN2VgETE37e
 UGCKy+orbWBWJyip1TQY5nWDElBEoS8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-am8Dlq3oOP-JItrhtMXhmw-1; Tue, 29 Nov 2022 00:50:19 -0500
X-MC-Unique: am8Dlq3oOP-JItrhtMXhmw-1
Received: by mail-wr1-f71.google.com with SMTP id
 w11-20020adfbacb000000b002418a90da01so2508052wrg.16
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 21:50:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Wpq0k+NoN/KPu1cVXV+4YoUz2A9DIeXHtgnj/53kjg=;
 b=njgCLVd+eydAtN03aYTZDdgobVpLuO8s8pYE0YraTSRQ4p+esDCGRrmRJswhqSiPTr
 JWpITh2Hk7al4xcAjsGvGgiYWBuSeafVAgE5GpAjtpctKtHBPeLywAtbCtBDL63oAkSd
 heUP0mXS6fze7Xt26DQZdVDW+XxUOqWDPK+XUzD2Bj8EjZwzf8LIaTXgXDjUF2yewZIg
 MGsAAXS5wRGstlajZ0rTLqPJWp2sEwmybZsibekKhcgRrXrPfcj/wAS3eSn3hrRWEroX
 fGkkExTGYzR8+4bBbr6PgzpGTVzc6xKyIwUuC+pypz/pi6SBMILESRz+eR6aheNdimAu
 r6+g==
X-Gm-Message-State: ANoB5plcDas3+IH5uL62/Upsrc7uv6ek5I9x/W5oMxY/cqt19HBJLRJF
 Rr2tib3yY8xcYE3r7TMCUEx8a11z6udOpYbioebLETtRhDII4cv2ZdmLzaZZgbVS8CcCXVnlgVC
 aX3Th9dGsc3KOmowdQ+uj3Z4lKBU=
X-Received: by 2002:adf:e8c9:0:b0:22e:33dc:3bf1 with SMTP id
 k9-20020adfe8c9000000b0022e33dc3bf1mr34274629wrn.316.1669701018020; 
 Mon, 28 Nov 2022 21:50:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5+RJpH1mqJoXE+Zu+IsAvQBYu0GBGdqt6Q+nLppH7KELyYKC3ksslj+YUfbNqCIY/xlnOtpEqJ9ieMr7JajDU=
X-Received: by 2002:adf:e8c9:0:b0:22e:33dc:3bf1 with SMTP id
 k9-20020adfe8c9000000b0022e33dc3bf1mr34274621wrn.316.1669701017676; Mon, 28
 Nov 2022 21:50:17 -0800 (PST)
MIME-Version: 1.0
References: <1669704060-5635-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1669704060-5635-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 29 Nov 2022 13:50:06 +0800
Message-ID: <CAEemH2fhMYPgq_7-fH55Xv-C-PQEbG4v8s=eUUnSRQMa8FeyOw@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1569293937=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1569293937==
Content-Type: multipart/alternative; boundary="0000000000000a48ed05ee9590e1"

--0000000000000a48ed05ee9590e1
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 29, 2022 at 1:40 PM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:

> Kernel header doesn't have this namespaces_constants.h header file and
> it can be moved into lapi/sched. Also, lapi/clone.h have some duplicated
> CLONE_* constants, they should be moved into here too.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>

---
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
> diff --git a/include/lapi/namespaces_constants.h
> b/include/lapi/namespaces_constants.h
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
> -#  define CLONE_NEWIPC 0x08000000
> -#endif
> -#ifndef CLONE_NEWNS
> -#  define CLONE_NEWNS  0x00020000
> -#endif
> -#ifndef CLONE_NEWNET
> -#  define CLONE_NEWNET 0x40000000
> -#endif
> -#ifndef CLONE_NEWPID
> -#  define CLONE_NEWPID 0x20000000
> -#endif
> -#ifndef CLONE_NEWUSER
> -#  define CLONE_NEWUSER        0x10000000
> -#endif
> -#ifndef CLONE_NEWCGROUP
> -#  define CLONE_NEWCGROUP 0x02000000
> -#endif
> -#ifndef CLONE_NEWUTS
> -#  define CLONE_NEWUTS 0x04000000
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
> @@ -47,19 +48,51 @@ static inline int sched_getattr(pid_t pid, struct
> sched_attr *attr,
>  #endif
>
>  #ifndef CLONE_VM
> -# define CLONE_VM   0x00000100
> +# define CLONE_VM      0x00000100
>  #endif
>
>  #ifndef CLONE_FS
> -# define CLONE_FS   0x00000200
> +# define CLONE_FS      0x00000200
> +#endif
> +
> +#ifndef CLONE_NEWNS
> +# define CLONE_NEWNS   0x00020000
>  #endif
>
>  #ifndef CLONE_SYSVSEM
> -# define CLONE_SYSVSEM   0x00040000
> +# define CLONE_SYSVSEM 0x00040000
> +#endif
> +
> +#ifndef CLONE_NEWCGROUP
> +# define CLONE_NEWCGROUP       0x02000000
> +#endif
> +
> +#ifndef CLONE_NEWUTS
> +# define CLONE_NEWUTS          0x04000000
> +#endif
> +
> +#ifndef CLONE_NEWIPC
> +#  define CLONE_NEWIPC         0x08000000
> +#endif
> +
> +#ifndef CLONE_NEWUSER
> +#  define CLONE_NEWUSER                0x10000000
> +#endif
> +
> +#ifndef CLONE_NEWPID
> +#  define CLONE_NEWPID         0x20000000
> +#endif
> +
> +#ifndef CLONE_NEWNET
> +# define CLONE_NEWNET          0x40000000
>  #endif
>
>  #ifndef CLONE_IO
> -# define CLONE_IO        0x80000000
> +# define CLONE_IO              0x80000000
> +#endif
> +
> +#ifndef CLONE_NEWTIME
> +# define CLONE_NEWTIME         0x00000080
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
> diff --git a/testcases/cve/cve-2017-16939.c
> b/testcases/cve/cve-2017-16939.c
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
> diff --git a/testcases/cve/icmp_rate_limit01.c
> b/testcases/cve/icmp_rate_limit01.c
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
> diff --git a/testcases/kernel/containers/libclone/libclone.h
> b/testcases/kernel/containers/libclone/libclone.h
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
> diff --git a/testcases/kernel/containers/mountns/mountns.h
> b/testcases/kernel/containers/mountns/mountns.h
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
> diff --git a/testcases/kernel/containers/netns/netns_netlink.c
> b/testcases/kernel/containers/netns/netns_netlink.c
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
> diff --git a/testcases/kernel/containers/pidns/pidns01.c
> b/testcases/kernel/containers/pidns/pidns01.c
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
> diff --git a/testcases/kernel/containers/pidns/pidns02.c
> b/testcases/kernel/containers/pidns/pidns02.c
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
> diff --git a/testcases/kernel/containers/pidns/pidns03.c
> b/testcases/kernel/containers/pidns/pidns03.c
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
> diff --git a/testcases/kernel/containers/pidns/pidns12.c
> b/testcases/kernel/containers/pidns/pidns12.c
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
> diff --git a/testcases/kernel/containers/pidns/pidns20.c
> b/testcases/kernel/containers/pidns/pidns20.c
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
> diff --git a/testcases/kernel/containers/pidns/pidns32.c
> b/testcases/kernel/containers/pidns/pidns32.c
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
> diff --git a/testcases/kernel/containers/share/ns_common.h
> b/testcases/kernel/containers/share/ns_common.h
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
> diff --git a/testcases/kernel/containers/share/ns_create.c
> b/testcases/kernel/containers/share/ns_create.c
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
> diff --git a/testcases/kernel/containers/share/ns_exec.c
> b/testcases/kernel/containers/share/ns_exec.c
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
> diff --git a/testcases/kernel/containers/sysvipc/common.h
> b/testcases/kernel/containers/sysvipc/common.h
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
>         T_CLONE,
> diff --git a/testcases/kernel/containers/timens/timens01.c
> b/testcases/kernel/containers/timens/timens01.c
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
>         const char *desc;
> diff --git a/testcases/kernel/containers/userns/common.h
> b/testcases/kernel/containers/userns/common.h
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
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c
> b/testcases/kernel/controllers/cgroup/cgroup_core02.c
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
> diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
> b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
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
>         int clk_id;
> diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
> b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
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
> diff --git a/testcases/kernel/syscalls/clone/clone09.c
> b/testcases/kernel/syscalls/clone/clone09.c
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
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c
> b/testcases/kernel/syscalls/fanotify/fanotify17.c
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
> diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c
> b/testcases/kernel/syscalls/getxattr/getxattr05.c
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
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
> b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
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
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
> b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
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
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
> b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
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
> diff --git a/testcases/kernel/syscalls/setns/setns.h
> b/testcases/kernel/syscalls/setns/setns.h
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
> diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo03.c
> b/testcases/kernel/syscalls/sysinfo/sysinfo03.c
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
>         10,
> diff --git a/testcases/kernel/syscalls/timerfd/timerfd04.c
> b/testcases/kernel/syscalls/timerfd/timerfd04.c
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
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--0000000000000a48ed05ee9590e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Nov 29, 2022 at 1:40 PM Yang Xu &lt;<a href=
=3D"mailto:xuyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Kernel heade=
r doesn&#39;t have this namespaces_constants.h header file and<br>
it can be moved into lapi/sched. Also, lapi/clone.h have some duplicated<br=
>
CLONE_* constants, they should be moved into here too.<br>
<br>
Signed-off-by: Yang Xu &lt;<a href=3D"mailto:xuyang2018.jy@fujitsu.com" tar=
get=3D"_blank">xuyang2018.jy@fujitsu.com</a>&gt;<br></blockquote><div><br><=
/div><div class=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li=
 Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</d=
iv><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
---<br>
=C2=A0include/lapi/namespaces_constants.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 34 ---------------<br>
=C2=A0include/lapi/sched.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 41 +++++++++++++++++--<br>
=C2=A0lib/tst_net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0testcases/cve/cve-2017-16939.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0testcases/cve/icmp_rate_limit01.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0.../kernel/containers/libclone/libclone.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
3 +-<br>
=C2=A0testcases/kernel/containers/mountns/mountns.h |=C2=A0 2 +-<br>
=C2=A0.../kernel/containers/netns/netns_netlink.c=C2=A0 =C2=A0|=C2=A0 3 +-<=
br>
=C2=A0testcases/kernel/containers/pidns/pidns01.c=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0testcases/kernel/containers/pidns/pidns02.c=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0testcases/kernel/containers/pidns/pidns03.c=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0testcases/kernel/containers/pidns/pidns12.c=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0testcases/kernel/containers/pidns/pidns20.c=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0testcases/kernel/containers/pidns/pidns32.c=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0testcases/kernel/containers/share/ns_common.h |=C2=A0 2 +-<br>
=C2=A0testcases/kernel/containers/share/ns_create.c |=C2=A0 3 +-<br>
=C2=A0testcases/kernel/containers/share/ns_exec.c=C2=A0 =C2=A0|=C2=A0 3 +-<=
br>
=C2=A0testcases/kernel/containers/sysvipc/common.h=C2=A0 |=C2=A0 2 +-<br>
=C2=A0testcases/kernel/containers/timens/timens01.c |=C2=A0 2 +-<br>
=C2=A0testcases/kernel/containers/userns/common.h=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0.../kernel/controllers/cgroup/cgroup_core02.c |=C2=A0 3 +-<br>
=C2=A0.../syscalls/clock_gettime/clock_gettime03.c=C2=A0 |=C2=A0 2 +-<br>
=C2=A0.../clock_nanosleep/clock_nanosleep03.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
=C2=A0testcases/kernel/syscalls/clone/clone09.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
3 +-<br>
=C2=A0.../kernel/syscalls/fanotify/fanotify17.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
3 +-<br>
=C2=A0.../kernel/syscalls/getxattr/getxattr05.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
3 +-<br>
=C2=A0testcases/kernel/syscalls/ioctl/ioctl_ns01.c=C2=A0 |=C2=A0 3 +-<br>
=C2=A0testcases/kernel/syscalls/ioctl/ioctl_ns05.c=C2=A0 |=C2=A0 3 +-<br>
=C2=A0testcases/kernel/syscalls/ioctl/ioctl_ns06.c=C2=A0 |=C2=A0 3 +-<br>
=C2=A0testcases/kernel/syscalls/setns/setns.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
=C2=A0testcases/kernel/syscalls/sysinfo/sysinfo03.c |=C2=A0 2 +-<br>
=C2=A0testcases/kernel/syscalls/timerfd/timerfd04.c |=C2=A0 2 +-<br>
=C2=A032 files changed, 67 insertions(+), 79 deletions(-)<br>
=C2=A0delete mode 100644 include/lapi/namespaces_constants.h<br>
<br>
diff --git a/include/lapi/namespaces_constants.h b/include/lapi/namespaces_=
constants.h<br>
deleted file mode 100644<br>
index e34b0d6a8..000000000<br>
--- a/include/lapi/namespaces_constants.h<br>
+++ /dev/null<br>
@@ -1,34 +0,0 @@<br>
-// SPDX-License-Identifier: GPL-2.0-or-later<br>
-/*<br>
- * Copyright (c) 2015 Red Hat, Inc.<br>
- */<br>
-<br>
-#ifndef LAPI_NAMESPACES_CONSTANTS_H__<br>
-#define LAPI_NAMESPACES_CONSTANTS_H__<br>
-<br>
-#ifndef CLONE_NEWIPC<br>
-#=C2=A0 define CLONE_NEWIPC 0x08000000<br>
-#endif<br>
-#ifndef CLONE_NEWNS<br>
-#=C2=A0 define CLONE_NEWNS=C2=A0 0x00020000<br>
-#endif<br>
-#ifndef CLONE_NEWNET<br>
-#=C2=A0 define CLONE_NEWNET 0x40000000<br>
-#endif<br>
-#ifndef CLONE_NEWPID<br>
-#=C2=A0 define CLONE_NEWPID 0x20000000<br>
-#endif<br>
-#ifndef CLONE_NEWUSER<br>
-#=C2=A0 define CLONE_NEWUSER=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10000000<br>
-#endif<br>
-#ifndef CLONE_NEWCGROUP<br>
-#=C2=A0 define CLONE_NEWCGROUP 0x02000000<br>
-#endif<br>
-#ifndef CLONE_NEWUTS<br>
-#=C2=A0 define CLONE_NEWUTS 0x04000000<br>
-#endif<br>
-#ifndef CLONE_NEWTIME<br>
-#=C2=A0 define CLONE_NEWTIME 0x00000080<br>
-#endif<br>
-<br>
-#endif /* LAPI_NAMESPACES_CONSTANTS_H__ */<br>
diff --git a/include/lapi/sched.h b/include/lapi/sched.h<br>
index 226d3109a..3b0b4be31 100644<br>
--- a/include/lapi/sched.h<br>
+++ b/include/lapi/sched.h<br>
@@ -8,6 +8,7 @@<br>
=C2=A0#define LAPI_SCHED_H__<br>
<br>
=C2=A0#include &lt;sched.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
=C2=A0#include &lt;stdint.h&gt;<br>
=C2=A0#include &lt;inttypes.h&gt;<br>
=C2=A0#include &quot;lapi/syscalls.h&quot;<br>
@@ -47,19 +48,51 @@ static inline int sched_getattr(pid_t pid, struct sched=
_attr *attr,<br>
=C2=A0#endif<br>
<br>
=C2=A0#ifndef CLONE_VM<br>
-# define CLONE_VM=C2=A0 =C2=A00x00000100<br>
+# define CLONE_VM=C2=A0 =C2=A0 =C2=A0 0x00000100<br>
=C2=A0#endif<br>
<br>
=C2=A0#ifndef CLONE_FS<br>
-# define CLONE_FS=C2=A0 =C2=A00x00000200<br>
+# define CLONE_FS=C2=A0 =C2=A0 =C2=A0 0x00000200<br>
+#endif<br>
+<br>
+#ifndef CLONE_NEWNS<br>
+# define CLONE_NEWNS=C2=A0 =C2=A00x00020000<br>
=C2=A0#endif<br>
<br>
=C2=A0#ifndef CLONE_SYSVSEM<br>
-# define CLONE_SYSVSEM=C2=A0 =C2=A00x00040000<br>
+# define CLONE_SYSVSEM 0x00040000<br>
+#endif<br>
+<br>
+#ifndef CLONE_NEWCGROUP<br>
+# define CLONE_NEWCGROUP=C2=A0 =C2=A0 =C2=A0 =C2=A00x02000000<br>
+#endif<br>
+<br>
+#ifndef CLONE_NEWUTS<br>
+# define CLONE_NEWUTS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04000000<br>
+#endif<br>
+<br>
+#ifndef CLONE_NEWIPC<br>
+#=C2=A0 define CLONE_NEWIPC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x08000000<br=
>
+#endif<br>
+<br>
+#ifndef CLONE_NEWUSER<br>
+#=C2=A0 define CLONE_NEWUSER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x10000000<br>
+#endif<br>
+<br>
+#ifndef CLONE_NEWPID<br>
+#=C2=A0 define CLONE_NEWPID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x20000000<br=
>
+#endif<br>
+<br>
+#ifndef CLONE_NEWNET<br>
+# define CLONE_NEWNET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x40000000<br>
=C2=A0#endif<br>
<br>
=C2=A0#ifndef CLONE_IO<br>
-# define CLONE_IO=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x80000000<br>
+# define CLONE_IO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x800000=
00<br>
+#endif<br>
+<br>
+#ifndef CLONE_NEWTIME<br>
+# define CLONE_NEWTIME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00000080<br>
=C2=A0#endif<br>
<br>
=C2=A0#endif /* LAPI_SCHED_H__ */<br>
diff --git a/lib/tst_net.c b/lib/tst_net.c<br>
index 61fc0ea76..a97e25b11 100644<br>
--- a/lib/tst_net.c<br>
+++ b/lib/tst_net.c<br>
@@ -14,7 +14,7 @@<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;tst_net.h&quot;<br>
=C2=A0#include &quot;tst_private.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0void tst_print_svar(const char *name, const char *val)<br>
=C2=A0{<br>
diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.=
c<br>
index eb5400c0c..e41fb274a 100644<br>
--- a/testcases/cve/cve-2017-16939.c<br>
+++ b/testcases/cve/cve-2017-16939.c<br>
@@ -25,7 +25,7 @@<br>
=C2=A0#include &quot;tst_res_flags.h&quot;<br>
=C2=A0#include &quot;tst_safe_macros.h&quot;<br>
=C2=A0#include &quot;tst_safe_net.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define BUFSIZE 2048<br>
<br>
diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_li=
mit01.c<br>
index 7a51aa0a4..8ee50a276 100644<br>
--- a/testcases/cve/icmp_rate_limit01.c<br>
+++ b/testcases/cve/icmp_rate_limit01.c<br>
@@ -34,7 +34,7 @@<br>
=C2=A0#include &quot;lapi/if_addr.h&quot;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;tst_netdevice.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define DSTNET 0xfa444e00 /* 250.68.78.0 */<br>
=C2=A0#define SRCNET 0xfa444e40 /* 250.68.78.64 */<br>
diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/ke=
rnel/containers/libclone/libclone.h<br>
index b8740f1bc..e92fdca02 100644<br>
--- a/testcases/kernel/containers/libclone/libclone.h<br>
+++ b/testcases/kernel/containers/libclone/libclone.h<br>
@@ -19,7 +19,6 @@<br>
<br>
=C2=A0#include &lt;stdio.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
-#include &lt;sched.h&gt;<br>
=C2=A0#include &lt;unistd.h&gt;<br>
=C2=A0#include &lt;string.h&gt;<br>
=C2=A0#include &lt;errno.h&gt;<br>
@@ -28,7 +27,7 @@<br>
=C2=A0#include &lt;signal.h&gt;<br>
=C2=A0#include &quot;lapi/syscalls.h&quot;<br>
=C2=A0#include &quot;test.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define T_UNSHARE 0<br>
=C2=A0#define T_CLONE 1<br>
diff --git a/testcases/kernel/containers/mountns/mountns.h b/testcases/kern=
el/containers/mountns/mountns.h<br>
index 76b37b477..615f1a058 100644<br>
--- a/testcases/kernel/containers/mountns/mountns.h<br>
+++ b/testcases/kernel/containers/mountns/mountns.h<br>
@@ -8,7 +8,7 @@<br>
=C2=A0#define COMMON_H<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define DIRA &quot;LTP_DIR_A&quot;<br>
=C2=A0#define DIRB &quot;LTP_DIR_B&quot;<br>
diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/=
kernel/containers/netns/netns_netlink.c<br>
index 6f60ff94e..e8df616e2 100644<br>
--- a/testcases/kernel/containers/netns/netns_netlink.c<br>
+++ b/testcases/kernel/containers/netns/netns_netlink.c<br>
@@ -33,11 +33,10 @@<br>
=C2=A0#include &lt;stdio.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &lt;errno.h&gt;<br>
-#include &lt;sched.h&gt;<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;tst_safe_macros.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define MAX_TRIES 1000<br>
<br>
diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel=
/containers/pidns/pidns01.c<br>
index eba4b806b..5080b6fad 100644<br>
--- a/testcases/kernel/containers/pidns/pidns01.c<br>
+++ b/testcases/kernel/containers/pidns/pidns01.c<br>
@@ -15,7 +15,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)<br>
=C2=A0{<br>
diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel=
/containers/pidns/pidns02.c<br>
index 9f3a46526..b8913d3f6 100644<br>
--- a/testcases/kernel/containers/pidns/pidns02.c<br>
+++ b/testcases/kernel/containers/pidns/pidns02.c<br>
@@ -14,7 +14,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)<br>
=C2=A0{<br>
diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel=
/containers/pidns/pidns03.c<br>
index b9b38b5d9..122ba7891 100644<br>
--- a/testcases/kernel/containers/pidns/pidns03.c<br>
+++ b/testcases/kernel/containers/pidns/pidns03.c<br>
@@ -13,7 +13,7 @@<br>
<br>
=C2=A0#include &lt;sys/mount.h&gt;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define PROCDIR &quot;proc&quot;<br>
<br>
diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel=
/containers/pidns/pidns12.c<br>
index 0e6b17142..fb1ec90ca 100644<br>
--- a/testcases/kernel/containers/pidns/pidns12.c<br>
+++ b/testcases/kernel/containers/pidns/pidns12.c<br>
@@ -16,7 +16,7 @@<br>
=C2=A0#define _GNU_SOURCE 1<br>
=C2=A0#include &lt;signal.h&gt;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0static volatile pid_t sig_pid =3D -1;<br>
<br>
diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel=
/containers/pidns/pidns20.c<br>
index f1e239dde..9f369699a 100644<br>
--- a/testcases/kernel/containers/pidns/pidns20.c<br>
+++ b/testcases/kernel/containers/pidns/pidns20.c<br>
@@ -15,7 +15,7 @@<br>
=C2=A0#define _GNU_SOURCE 1<br>
=C2=A0#include &lt;signal.h&gt;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0static volatile int signals;<br>
=C2=A0static volatile int last_signo;<br>
diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel=
/containers/pidns/pidns32.c<br>
index 333e1fcad..3f7df788e 100644<br>
--- a/testcases/kernel/containers/pidns/pidns32.c<br>
+++ b/testcases/kernel/containers/pidns/pidns32.c<br>
@@ -15,7 +15,7 @@<br>
<br>
=C2=A0#include &lt;sys/mman.h&gt;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define MAXNEST 32<br>
<br>
diff --git a/testcases/kernel/containers/share/ns_common.h b/testcases/kern=
el/containers/share/ns_common.h<br>
index 69e51ce71..0f85aceb4 100644<br>
--- a/testcases/kernel/containers/share/ns_common.h<br>
+++ b/testcases/kernel/containers/share/ns_common.h<br>
@@ -17,7 +17,7 @@<br>
=C2=A0#ifndef __NS_COMMON_H__<br>
=C2=A0#define __NS_COMMON_H__<br>
=C2=A0#include &lt;sched.h&gt;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define PROC_PATH &quot;/proc&quot;<br>
=C2=A0#define NS_TOTAL 6<br>
diff --git a/testcases/kernel/containers/share/ns_create.c b/testcases/kern=
el/containers/share/ns_create.c<br>
index d4259f38b..3f09e71e0 100644<br>
--- a/testcases/kernel/containers/share/ns_create.c<br>
+++ b/testcases/kernel/containers/share/ns_create.c<br>
@@ -24,7 +24,6 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#define _GNU_SOURCE<br>
-#include &lt;sched.h&gt;<br>
=C2=A0#include &lt;sys/syscall.h&gt;<br>
=C2=A0#include &lt;sys/types.h&gt;<br>
=C2=A0#include &lt;sys/stat.h&gt;<br>
@@ -32,7 +31,7 @@<br>
=C2=A0#include &lt;string.h&gt;<br>
=C2=A0#include &lt;errno.h&gt;<br>
=C2=A0#include &quot;test.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
=C2=A0#include &quot;ns_common.h&quot;<br>
<br>
=C2=A0char *TCID =3D &quot;ns_create&quot;;<br>
diff --git a/testcases/kernel/containers/share/ns_exec.c b/testcases/kernel=
/containers/share/ns_exec.c<br>
index c492165f0..4abd1063b 100644<br>
--- a/testcases/kernel/containers/share/ns_exec.c<br>
+++ b/testcases/kernel/containers/share/ns_exec.c<br>
@@ -21,7 +21,6 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#define _GNU_SOURCE<br>
-#include &lt;sched.h&gt;<br>
=C2=A0#include &lt;sys/syscall.h&gt;<br>
=C2=A0#include &lt;sys/types.h&gt;<br>
=C2=A0#include &lt;sys/wait.h&gt;<br>
@@ -31,7 +30,7 @@<br>
=C2=A0#include &lt;errno.h&gt;<br>
=C2=A0#include &quot;test.h&quot;<br>
=C2=A0#include &quot;lapi/syscalls.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
=C2=A0#include &quot;ns_common.h&quot;<br>
<br>
=C2=A0char *TCID =3D &quot;ns_exec&quot;;<br>
diff --git a/testcases/kernel/containers/sysvipc/common.h b/testcases/kerne=
l/containers/sysvipc/common.h<br>
index 258d355d7..9b0fc16e9 100644<br>
--- a/testcases/kernel/containers/sysvipc/common.h<br>
+++ b/testcases/kernel/containers/sysvipc/common.h<br>
@@ -11,7 +11,7 @@<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;lapi/syscalls.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0enum {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 T_CLONE,<br>
diff --git a/testcases/kernel/containers/timens/timens01.c b/testcases/kern=
el/containers/timens/timens01.c<br>
index 3f6235ec3..3621b3446 100644<br>
--- a/testcases/kernel/containers/timens/timens01.c<br>
+++ b/testcases/kernel/containers/timens/timens01.c<br>
@@ -15,9 +15,9 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#define _GNU_SOURCE<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
=C2=A0#include &quot;lapi/posix_clocks.h&quot;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0static struct tcase {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *desc;<br>
diff --git a/testcases/kernel/containers/userns/common.h b/testcases/kernel=
/containers/userns/common.h<br>
index d3bdcc53f..635d0f190 100644<br>
--- a/testcases/kernel/containers/userns/common.h<br>
+++ b/testcases/kernel/containers/userns/common.h<br>
@@ -8,7 +8,7 @@<br>
=C2=A0#define COMMON_H<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define UID_MAP 0<br>
=C2=A0#define GID_MAP 1<br>
diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcase=
s/kernel/controllers/cgroup/cgroup_core02.c<br>
index e6d599b36..1872a7dff 100644<br>
--- a/testcases/kernel/controllers/cgroup/cgroup_core02.c<br>
+++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c<br>
@@ -24,14 +24,13 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#define _GNU_SOURCE<br>
-#include &lt;sched.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &lt;stdio.h&gt;<br>
=C2=A0#include &lt;sys/types.h&gt;<br>
=C2=A0#include &lt;pwd.h&gt;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;tst_safe_file_at.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0static struct tst_cg_group *cg_child_a, *cg_child_b;<br>
=C2=A0static uid_t nobody_uid;<br>
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/te=
stcases/kernel/syscalls/clock_gettime/clock_gettime03.c<br>
index f185977d3..b02d22a14 100644<br>
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c<br>
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c<br>
@@ -18,7 +18,7 @@<br>
=C2=A0#include &quot;time64_variants.h&quot;<br>
=C2=A0#include &quot;tst_safe_clocks.h&quot;<br>
=C2=A0#include &quot;tst_timer.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0static struct tcase {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int clk_id;<br>
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c =
b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c<br>
index 5bd91fa61..dfc522278 100644<br>
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c<br>
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c<br>
@@ -18,7 +18,7 @@<br>
=C2=A0#include &quot;time64_variants.h&quot;<br>
=C2=A0#include &quot;tst_safe_clocks.h&quot;<br>
=C2=A0#include &quot;tst_timer.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define OFFSET_S 10<br>
=C2=A0#define SLEEP_US 100000<br>
diff --git a/testcases/kernel/syscalls/clone/clone09.c b/testcases/kernel/s=
yscalls/clone/clone09.c<br>
index e9e584564..e4691f513 100644<br>
--- a/testcases/kernel/syscalls/clone/clone09.c<br>
+++ b/testcases/kernel/syscalls/clone/clone09.c<br>
@@ -4,14 +4,13 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#define _GNU_SOURCE<br>
-#include &lt;sched.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &lt;errno.h&gt;<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;clone_platform.h&quot;<br>
=C2=A0#include &quot;lapi/syscalls.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0static void *child_stack;<br>
=C2=A0static int sysctl_net =3D -1;<br>
diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c b/testcases/ke=
rnel/syscalls/fanotify/fanotify17.c<br>
index 7d74b2540..3ecb31b6e 100644<br>
--- a/testcases/kernel/syscalls/fanotify/fanotify17.c<br>
+++ b/testcases/kernel/syscalls/fanotify/fanotify17.c<br>
@@ -20,11 +20,10 @@<br>
=C2=A0#include &lt;errno.h&gt;<br>
=C2=A0#include &lt;unistd.h&gt;<br>
=C2=A0#include &lt;sys/types.h&gt;<br>
-#include &lt;sched.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#ifdef HAVE_SYS_FANOTIFY_H<br>
=C2=A0#include &quot;fanotify.h&quot;<br>
diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/ke=
rnel/syscalls/getxattr/getxattr05.c<br>
index 3e73cc567..28eb4cbcf 100644<br>
--- a/testcases/kernel/syscalls/getxattr/getxattr05.c<br>
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c<br>
@@ -20,7 +20,6 @@<br>
=C2=A0#include &lt;errno.h&gt;<br>
=C2=A0#include &lt;unistd.h&gt;<br>
=C2=A0#include &lt;sys/types.h&gt;<br>
-#include &lt;sched.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
<br>
=C2=A0#ifdef HAVE_SYS_XATTR_H<br>
@@ -32,7 +31,7 @@<br>
=C2=A0#endif<br>
<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#if defined(HAVE_SYS_XATTR_H) &amp;&amp; defined(HAVE_LIBACL)<br>
<br>
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kerne=
l/syscalls/ioctl/ioctl_ns01.c<br>
index 95be877dc..06c81ba1b 100644<br>
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c<br>
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c<br>
@@ -19,11 +19,10 @@<br>
=C2=A0#define _GNU_SOURCE<br>
<br>
=C2=A0#include &lt;errno.h&gt;<br>
-#include &lt;sched.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;lapi/ioctl_ns.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define STACK_SIZE (1024 * 1024)<br>
<br>
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kerne=
l/syscalls/ioctl/ioctl_ns05.c<br>
index ae2f9da51..36e41c468 100644<br>
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c<br>
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c<br>
@@ -18,11 +18,10 @@<br>
<br>
=C2=A0#include &lt;errno.h&gt;<br>
=C2=A0#include &lt;stdio.h&gt;<br>
-#include &lt;sched.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;lapi/ioctl_ns.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define STACK_SIZE (1024 * 1024)<br>
<br>
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kerne=
l/syscalls/ioctl/ioctl_ns06.c<br>
index 393ba1437..45fc01ce7 100644<br>
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c<br>
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c<br>
@@ -19,11 +19,10 @@<br>
<br>
=C2=A0#include &lt;errno.h&gt;<br>
=C2=A0#include &lt;stdio.h&gt;<br>
-#include &lt;sched.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;lapi/ioctl_ns.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define STACK_SIZE (1024 * 1024)<br>
<br>
diff --git a/testcases/kernel/syscalls/setns/setns.h b/testcases/kernel/sys=
calls/setns/setns.h<br>
index 46beef17f..45c759917 100644<br>
--- a/testcases/kernel/syscalls/setns/setns.h<br>
+++ b/testcases/kernel/syscalls/setns/setns.h<br>
@@ -4,7 +4,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &lt;stdio.h&gt;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define NS_MAX 5<br>
=C2=A0static int ns_types[NS_MAX];<br>
diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo03.c b/testcases/kern=
el/syscalls/sysinfo/sysinfo03.c<br>
index af7cb6421..6b8f0aef7 100644<br>
--- a/testcases/kernel/syscalls/sysinfo/sysinfo03.c<br>
+++ b/testcases/kernel/syscalls/sysinfo/sysinfo03.c<br>
@@ -14,9 +14,9 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &lt;sys/sysinfo.h&gt;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
=C2=A0#include &quot;lapi/posix_clocks.h&quot;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0static int offsets[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 10,<br>
diff --git a/testcases/kernel/syscalls/timerfd/timerfd04.c b/testcases/kern=
el/syscalls/timerfd/timerfd04.c<br>
index eb7f98d5b..b24b4874e 100644<br>
--- a/testcases/kernel/syscalls/timerfd/timerfd04.c<br>
+++ b/testcases/kernel/syscalls/timerfd/timerfd04.c<br>
@@ -19,7 +19,7 @@<br>
=C2=A0#include &quot;tst_safe_clocks.h&quot;<br>
=C2=A0#include &quot;tst_safe_timerfd.h&quot;<br>
=C2=A0#include &quot;tst_timer.h&quot;<br>
-#include &quot;lapi/namespaces_constants.h&quot;<br>
+#include &quot;lapi/sched.h&quot;<br>
<br>
=C2=A0#define SLEEP_US 40000<br>
<br>
-- <br>
2.23.0<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000000a48ed05ee9590e1--


--===============1569293937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1569293937==--

