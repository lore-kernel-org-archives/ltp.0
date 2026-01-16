Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F04D4A5E4
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 02:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768530340; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=gj/fZ0F7YKl6vKmno7QMYHH64wYSmaJETjCWSOm9kxM=;
 b=DBUw+Hh1T8M+TbD5nvqQ3uP20Q9UAMJx3SfFd6CQMKNnEwFBNYRsAfJVN7dBsdC26XM6S
 6nT0GjUWsdvSie7HZD78+C5Frr9mDl4IgZWCgD77QwGB4PJV84b6jJbEQGi+HPgYaBCp3ph
 LvgxSt8aBiDCcj06mQKQVFWBtwIN+kE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEB703CA528
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 03:25:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECE793CA458
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 03:25:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BE635600BC1
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 03:25:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768530319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/r7fpSf/moF8wGv8uWQH8I+UbeFMKsqYphIfMvcC9U=;
 b=PmfStw2PbJuf9m5HZtLgipRxyaED6zja0nVDeP7PlkrSqPbeAfh2YxmzFAseee2fHPHG0f
 kRy1E0OzjsloZeyLjIM2w8PxU9o9J1K2/IuFzB4WiuVjIO+Ot65c3fCsZGjWiIWdgwts/4
 ldAfoKtS7PZb/7PCm3KYMQOF24+w2aM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-S-cWwGUTPX26Sxc5JiERzQ-1; Thu,
 15 Jan 2026 21:25:15 -0500
X-MC-Unique: S-cWwGUTPX26Sxc5JiERzQ-1
X-Mimecast-MFC-AGG-ID: S-cWwGUTPX26Sxc5JiERzQ_1768530315
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B66031800447
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 02:25:14 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.137])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40D303001DB9
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 02:25:12 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 16 Jan 2026 10:25:07 +0800
Message-ID: <20260116022507.204549-2-liwang@redhat.com>
In-Reply-To: <20260116022507.204549-1-liwang@redhat.com>
References: <20260116022507.204549-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4WTxWE3N3E2KdhctdB8NFbGy5z3n57VNZPsmKKA2kHg_1768530315
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] include/old: rename legacy headers to tso_*
 namespace
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To clearly distinguish legacy header files from the core (tst_*) and
extension (tse_*) LTP APIs, legacy header files have been grouped
into the otst_* namespace.

Some legacy header files do not begin with old_, they still belong
to the legacy header file set. For clarity, all legacy header files
are now uniformly grouped into the tso_* namespace.

 include/old/{old_checkpoint.h => tso_checkpoint.h}
 include/old/{ltp_cpuid.h => tso_cpuid.h}
 include/old/{old_device.h => tso_device.h}
 include/old/{tlibio.h => tso_lio.h}
 include/old/{old_module.h => tso_module.h}
 include/old/{ltp_priv.h => tso_priv.h}
 include/old/{random_range.h => tso_random_range.h}
 include/old/{old_resource.h => tso_resource.h}
 include/old/{old_safe_file_ops.h => tso_safe_file_ops.h}
 include/old/{safe_macros.h => tso_safe_macros.h}
 include/old/{old_safe_net.h => tso_safe_net.h}
 include/old/{old_safe_stdio.h => tso_safe_stdio.h}
 include/old/{ltp_signal.h => tso_signal.h}
 include/old/{old_tmpdir.h => tso_tmpdir.h}
 include/old/{usctest.h => tso_usctest.h}

No functional changes intended.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/lapi/rt_sigaction.h                   |  2 +-
 include/old/ltp_signal.h                      | 56 -------------------
 include/old/old_checkpoint.h                  | 51 -----------------
 include/old/old_resource.h                    | 55 ------------------
 include/old/old_safe_stdio.h                  | 37 ------------
 include/old/random_range.h                    | 45 ---------------
 include/old/test.h                            | 14 ++---
 include/old/tso_checkpoint.h                  | 38 +++++++++++++
 include/old/{ltp_cpuid.h => tso_cpuid.h}      |  0
 include/old/{old_device.h => tso_device.h}    | 21 ++-----
 include/old/{tlibio.h => tso_lio.h}           | 30 +---------
 include/old/{old_module.h => tso_module.h}    | 32 +----------
 include/old/{ltp_priv.h => tso_priv.h}        | 19 +------
 include/old/tso_random_range.h                | 20 +++++++
 include/old/tso_resource.h                    | 34 +++++++++++
 ...ld_safe_file_ops.h => tso_safe_file_ops.h} | 17 +-----
 .../old/{safe_macros.h => tso_safe_macros.h}  | 10 +++-
 .../old/{old_safe_net.h => tso_safe_net.h}    | 21 ++-----
 include/old/tso_safe_stdio.h                  | 26 +++++++++
 include/old/tso_signal.h                      | 38 +++++++++++++
 include/old/{old_tmpdir.h => tso_tmpdir.h}    | 21 ++-----
 include/old/{usctest.h => tso_usctest.h}      | 36 ++----------
 lib/parse_opts.c                              |  4 +-
 lib/random_range.c                            |  2 +-
 lib/safe_macros.c                             |  2 +-
 lib/tests/trerrno.c                           |  2 +-
 lib/tests/tst_dataroot01.c                    |  2 +-
 lib/tests/tst_dataroot02.c                    |  2 +-
 lib/tests/tst_dataroot03.c                    |  2 +-
 lib/tests/tst_safe_macros.c                   |  2 +-
 lib/tlibio.c                                  |  4 +-
 lib/tst_checkpoint.c                          |  2 +-
 lib/tst_cpu.c                                 |  2 +-
 lib/tst_device.c                              |  2 +-
 lib/tst_dir_is_empty.c                        |  2 +-
 lib/tst_fs_link_count.c                       |  4 +-
 lib/tst_kernel.c                              |  2 +-
 lib/tst_mkfs.c                                |  2 +-
 lib/tst_module.c                              |  4 +-
 lib/tst_parse_opts.c                          |  2 +-
 lib/tst_pid.c                                 |  2 +-
 lib/tst_res.c                                 |  6 +-
 lib/tst_resource.c                            |  4 +-
 lib/tst_test.c                                |  6 +-
 lib/tst_tmpdir.c                              |  4 +-
 lib/tst_virt.c                                |  2 +-
 .../controllers/cgroup_xattr/cgroup_xattr.c   |  2 +-
 .../controllers/cpuctl/cpuctl_def_task01.c    |  2 +-
 .../controllers/cpuctl/cpuctl_def_task02.c    |  2 +-
 .../controllers/cpuctl/cpuctl_def_task03.c    |  2 +-
 .../controllers/cpuctl/cpuctl_def_task04.c    |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_test01.c |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_test02.c |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_test03.c |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_test04.c |  2 +-
 .../kernel/device-drivers/acpi/ltp_acpi.c     |  4 +-
 .../device-drivers/cpufreq/cpufreq_boost.c    |  2 +-
 .../device-drivers/pci/tpci_user/tpci.c       |  4 +-
 testcases/kernel/device-drivers/rtc/rtc01.c   |  2 +-
 .../device-drivers/tbio/tbio_user/tbio.c      |  4 +-
 .../kernel/device-drivers/uaccess/uaccess.c   |  4 +-
 .../kernel/firmware/fw_load_user/fw_load.c    |  4 +-
 testcases/kernel/fs/doio/doio.c               |  2 +-
 testcases/kernel/fs/doio/growfiles.c          |  6 +-
 testcases/kernel/fs/doio/iogen.c              |  2 +-
 testcases/kernel/fs/ftest/ftest01.c           |  2 +-
 testcases/kernel/fs/ftest/ftest03.c           |  2 +-
 testcases/kernel/fs/ftest/ftest04.c           |  2 +-
 testcases/kernel/fs/ftest/ftest05.c           |  2 +-
 testcases/kernel/fs/ftest/ftest07.c           |  2 +-
 testcases/kernel/fs/ftest/ftest08.c           |  2 +-
 testcases/kernel/io/direct_io/diotest1.c      |  2 +-
 testcases/kernel/io/direct_io/diotest4.c      |  2 +-
 .../kernel/io/direct_io/dma_thread_diotest.c  |  2 +-
 testcases/kernel/ipc/pipeio/pipeio.c          |  4 +-
 testcases/kernel/lib/numa_helper.c            |  2 +-
 testcases/kernel/mem/vma/vma01.c              |  2 +-
 testcases/kernel/mem/vma/vma02.c              |  2 +-
 testcases/kernel/mem/vma/vma03.c              |  2 +-
 testcases/kernel/mem/vma/vma04.c              |  2 +-
 testcases/kernel/pty/hangup01.c               |  2 +-
 .../hyperthreading/ht_affinity/ht_utils.c     |  2 +-
 .../hyperthreading/ht_enabled/ht_utils.c      |  2 +-
 .../security/filecaps/filecaps_common.h       |  2 +-
 .../security/prot_hsymlinks/prot_hsymlinks.c  |  2 +-
 testcases/kernel/syscalls/clone/clone02.c     |  2 +-
 testcases/kernel/syscalls/connect/connect01.c |  2 +-
 .../kernel/syscalls/fallocate/fallocate01.c   |  2 +-
 .../kernel/syscalls/fallocate/fallocate02.c   |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl07.c     |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl11.c     |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl16.c     |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl19.c     |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl20.c     |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl31.c     |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl32.c     |  2 +-
 .../kernel/syscalls/fdatasync/fdatasync02.c   |  2 +-
 testcases/kernel/syscalls/fork/fork09.c       |  2 +-
 testcases/kernel/syscalls/fstatat/fstatat01.c |  2 +-
 .../kernel/syscalls/futimesat/futimesat01.c   |  2 +-
 .../get_robust_list/get_robust_list01.c       |  2 +-
 .../kernel/syscalls/getrusage/getrusage04.c   |  2 +-
 testcases/kernel/syscalls/linkat/linkat01.c   |  2 +-
 testcases/kernel/syscalls/linkat/linkat02.c   |  2 +-
 testcases/kernel/syscalls/listen/listen01.c   |  2 +-
 .../syscalls/migrate_pages/migrate_pages01.c  |  2 +-
 testcases/kernel/syscalls/mincore/mincore01.c |  2 +-
 testcases/kernel/syscalls/mkdirat/mkdirat01.c |  2 +-
 testcases/kernel/syscalls/mknodat/mknodat01.c |  2 +-
 testcases/kernel/syscalls/mknodat/mknodat02.c |  2 +-
 .../kernel/syscalls/mlockall/mlockall02.c     |  2 +-
 .../kernel/syscalls/mlockall/mlockall03.c     |  2 +-
 .../kernel/syscalls/move_pages/move_pages11.c |  2 +-
 .../kernel/syscalls/mprotect/mprotect01.c     |  2 +-
 .../kernel/syscalls/mprotect/mprotect02.c     |  2 +-
 .../kernel/syscalls/mprotect/mprotect03.c     |  2 +-
 .../kernel/syscalls/mprotect/mprotect04.c     |  2 +-
 testcases/kernel/syscalls/mremap/mremap01.c   |  2 +-
 testcases/kernel/syscalls/mremap/mremap05.c   |  2 +-
 testcases/kernel/syscalls/msync/msync03.c     |  2 +-
 testcases/kernel/syscalls/openat/openat03.c   |  2 +-
 .../perf_event_open/perf_event_open01.c       |  2 +-
 testcases/kernel/syscalls/pipe/pipe04.c       |  2 +-
 testcases/kernel/syscalls/pipe/pipe09.c       |  2 +-
 testcases/kernel/syscalls/ppoll/ppoll01.c     |  2 +-
 testcases/kernel/syscalls/profil/profil01.c   |  2 +-
 testcases/kernel/syscalls/recv/recv01.c       |  2 +-
 .../kernel/syscalls/recvfrom/recvfrom01.c     |  2 +-
 .../syscalls/removexattr/removexattr01.c      |  2 +-
 .../syscalls/removexattr/removexattr02.c      |  2 +-
 testcases/kernel/syscalls/rename/rename11.c   |  2 +-
 .../kernel/syscalls/renameat/renameat01.c     |  2 +-
 .../kernel/syscalls/renameat2/renameat201.c   |  2 +-
 .../kernel/syscalls/renameat2/renameat202.c   |  2 +-
 .../rt_sigprocmask/rt_sigprocmask02.c         |  2 +-
 testcases/kernel/syscalls/send/send01.c       |  2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg01.c |  2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg02.c |  2 +-
 testcases/kernel/syscalls/sendto/sendto01.c   |  2 +-
 .../kernel/syscalls/setfsuid/setfsuid04.c     |  2 +-
 .../kernel/syscalls/setrlimit/setrlimit01.c   |  2 +-
 .../kernel/syscalls/signalfd4/signalfd4_01.c  |  2 +-
 .../kernel/syscalls/signalfd4/signalfd4_02.c  |  2 +-
 .../kernel/syscalls/sigpending/sigpending02.c |  2 +-
 .../kernel/syscalls/sigrelse/sigrelse01.c     |  2 +-
 .../kernel/syscalls/sockioctl/sockioctl01.c   |  2 +-
 testcases/kernel/syscalls/symlink/symlink03.c |  2 +-
 .../kernel/syscalls/symlinkat/symlinkat01.c   |  2 +-
 .../kernel/syscalls/umount2/umount2_01.c      |  2 +-
 testcases/kernel/syscalls/vfork/vfork02.c     |  2 +-
 testcases/lib/tst_device.c                    |  2 +-
 testcases/network/lib6/asapi_01.c             |  2 +-
 testcases/network/lib6/asapi_03.c             |  2 +-
 tools/apicmds/ltpapicmd.c                     |  4 +-
 utils/sctp/testlib/sctputil.h                 |  2 +-
 155 files changed, 351 insertions(+), 576 deletions(-)
 delete mode 100644 include/old/ltp_signal.h
 delete mode 100644 include/old/old_checkpoint.h
 delete mode 100644 include/old/old_resource.h
 delete mode 100644 include/old/old_safe_stdio.h
 delete mode 100644 include/old/random_range.h
 create mode 100644 include/old/tso_checkpoint.h
 rename include/old/{ltp_cpuid.h => tso_cpuid.h} (100%)
 rename include/old/{old_device.h => tso_device.h} (74%)
 rename include/old/{tlibio.h => tso_lio.h} (79%)
 rename include/old/{old_module.h => tso_module.h} (68%)
 rename include/old/{ltp_priv.h => tso_priv.h} (62%)
 create mode 100644 include/old/tso_random_range.h
 create mode 100644 include/old/tso_resource.h
 rename include/old/{old_safe_file_ops.h => tso_safe_file_ops.h} (70%)
 rename include/old/{safe_macros.h => tso_safe_macros.h} (98%)
 rename include/old/{old_safe_net.h => tso_safe_net.h} (58%)
 create mode 100644 include/old/tso_safe_stdio.h
 create mode 100644 include/old/tso_signal.h
 rename include/old/{old_tmpdir.h => tso_tmpdir.h} (62%)
 rename include/old/{usctest.h => tso_usctest.h} (54%)

diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index a42b690d0..1e5911dd9 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -9,7 +9,7 @@
 #ifndef LAPI_RT_SIGACTION_H__
 #define LAPI_RT_SIGACTION_H__
 
-#include "ltp_signal.h"
+#include "tso_signal.h"
 
 #define INVAL_SA_PTR ((void *)-1)
 
diff --git a/include/old/ltp_signal.h b/include/old/ltp_signal.h
deleted file mode 100644
index 02ee8349a..000000000
--- a/include/old/ltp_signal.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * Copyright (c) 2009 Cisco Systems, Inc.  All Rights Reserved.
- * Copyright (c) 2009 FUJITSU LIMITED.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Author: Liu Bo <liubo2009@cn.fujitsu.com>
- * Author: Ngie Cooper <yaneurabeya@gmail.com>
- *
- */
-
-#ifndef __LTP_SIGNAL_H
-#define __LTP_SIGNAL_H
-
-#include <errno.h>
-#include <signal.h>
-#include <stdio.h>
-#include "config.h"
-
-/*
- * For all but __mips__:
- *
- * _COMPAT_NSIG / _COMPAT_NSIG_BPW == 2.
- *
- * For __mips__:
- *
- * _COMPAT_NSIG / _COMPAT_NSIG_BPW == 4.
- *
- * See asm/compat.h under the kernel source for more details.
- *
- * Multiply that by a fudge factor of 4 and you have your SIGSETSIZE.
- */
-#if defined __mips__
-#define SIGSETSIZE 16
-#else
-#define SIGSETSIZE (_NSIG / 8)
-#endif
-
-#endif
diff --git a/include/old/old_checkpoint.h b/include/old/old_checkpoint.h
deleted file mode 100644
index f91fef9f6..000000000
--- a/include/old/old_checkpoint.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/*
- * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
-
- /*
-
-   Checkpoint - easy to use parent-child synchronization.
-
-   Checkpoint is based on futexes (man futex). The library allocates a page of
-   shared memory for futexes and the id is an offset to it which gives the user
-   up to page_size/sizeof(uint32_t) checkpoint pairs. Up to INT_MAX processes
-   can sleep on single id and can be woken up by single wake.
-
-  */
-
-#ifndef OLD_CHECKPOINT__
-#define OLD_CHECKPOINT__
-
-#include "test.h"
-#include "tst_checkpoint_fn.h"
-
-#define TST_SAFE_CHECKPOINT_WAIT(cleanup_fn, id) \
-        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, 0);
-
-#define TST_SAFE_CHECKPOINT_WAIT2(cleanup_fn, id, msec_timeout) \
-        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, msec_timeout);
-
-#define TST_SAFE_CHECKPOINT_WAKE(cleanup_fn, id) \
-        tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1);
-
-#define TST_SAFE_CHECKPOINT_WAKE2(cleanup_fn, id, nr_wake) \
-        tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, nr_wake);
-
-#define TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup_fn, id) \
-        tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1); \
-        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, 0);
-
-#endif /* OLD_CHECKPOINT__ */
diff --git a/include/old/old_resource.h b/include/old/old_resource.h
deleted file mode 100644
index 46767f35c..000000000
--- a/include/old/old_resource.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * Copyright (C) 2012 Cyril Hrubis chrubis@suse.cz
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
- /*
-
-   Small helper for preparing files the test needs to copy before the testing.
-
-   We need to support two scenarios.
-
-   1. Test is executed in local directory and this is also the place
-      we should look for files
-
-
-   2. Test is executed after LTP has been installed, in this case we
-      look for env LTPROOT (usually /opt/ltp/)
-
-  */
-
-#ifndef TST_RESOURCE
-#define TST_RESOURCE
-
-const char *tst_dataroot(void);
-
-/*
- * Copy a file to the CWD. The destination is apended to CWD.
- */
-#define TST_RESOURCE_COPY(cleanup_fn, filename, dest) \
-	tst_resource_copy(__FILE__, __LINE__, (cleanup_fn), \
-	                  (filename), (dest))
-
-void tst_resource_copy(const char *file, const int lineno,
-                       void (*cleanup_fn)(void),
-		       const char *filename, const char *dest);
-
-#endif /* TST_RESOURCE */
diff --git a/include/old/old_safe_stdio.h b/include/old/old_safe_stdio.h
deleted file mode 100644
index 3508b2479..000000000
--- a/include/old/old_safe_stdio.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright (c) 2013-2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef OLD_SAFE_STDIO_H__
-#define OLD_SAFE_STDIO_H__
-
-#include <stdio.h>
-
-#include "safe_stdio_fn.h"
-
-#define SAFE_FOPEN(cleanup_fn, path, mode) \
-	safe_fopen(__FILE__, __LINE__, cleanup_fn, path, mode)
-
-#define SAFE_FCLOSE(cleanup_fn, f) \
-	safe_fclose(__FILE__, __LINE__, cleanup_fn, f)
-
-#define SAFE_ASPRINTF(cleanup_fn, strp, fmt, ...) \
-	safe_asprintf(__FILE__, __LINE__, cleanup_fn, strp, fmt, __VA_ARGS__)
-
-#define SAFE_POPEN(cleanup_fn, command, type) \
-	safe_popen(__FILE__, __LINE__, cleanup_fn, command, type)
-
-#endif /* OLD_SAFE_STDIO_H__ */
diff --git a/include/old/random_range.h b/include/old/random_range.h
deleted file mode 100644
index 22b3f9323..000000000
--- a/include/old/random_range.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
- */
-#ifndef _RANDOM_RANGE_H_
-#define _RANDOM_RANGE_H_
-
-int       parse_ranges     ( char *, int, int, int, int (*)(), char **, char ** );
-int       range_min        ( char *, int );
-int       range_max        ( char *, int );
-int       range_mult       ( char *, int );
-long      random_range     ( int, int, int, char ** );
-long      random_rangel    ( long, long, long, char ** );
-long long random_rangell   ( long long, long long, long long, char ** );
-void      random_range_seed( long );
-long      random_bit       ( long );
-
-#endif
diff --git a/include/old/test.h b/include/old/test.h
index 306868fb5..9b0fa0162 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -18,21 +18,21 @@
 #include <stdlib.h>
 #include <stdint.h>
 
-#include "usctest.h"
+#include "tso_usctest.h"
 
 #include "tst_common.h"
-#include "old_safe_file_ops.h"
-#include "old_checkpoint.h"
+#include "tso_safe_file_ops.h"
+#include "tso_checkpoint.h"
 #include "tst_process_state.h"
-#include "old_resource.h"
+#include "tso_resource.h"
 #include "tst_res_flags.h"
 #include "tst_kvercmp.h"
 #include "tst_fs.h"
 #include "tst_pid.h"
 #include "tst_cmd.h"
 #include "tst_cpu.h"
-#include "old_device.h"
-#include "old_tmpdir.h"
+#include "tso_device.h"
+#include "tso_tmpdir.h"
 #include "tst_minmax.h"
 #include "tst_get_bad_addr.h"
 #include "tst_path_has_mnt_flags.h"
@@ -116,7 +116,7 @@ void tst_brkm__(const char *file, const int lineno, int ttype,
 	__attribute__ ((format (printf, 5, 6))) LTP_ATTRIBUTE_NORETURN;
 
 #ifdef LTPLIB
-# include "ltp_priv.h"
+# include "tso_priv.h"
 # define tst_brkm(flags, cleanup, fmt, ...) do { \
 	if (tst_test) \
 		tst_brk_(__FILE__, __LINE__, flags, fmt, ##__VA_ARGS__); \
diff --git a/include/old/tso_checkpoint.h b/include/old/tso_checkpoint.h
new file mode 100644
index 000000000..7b44e6afb
--- /dev/null
+++ b/include/old/tso_checkpoint.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2026
+ */
+
+/*
+ * Checkpoint - easy to use parent-child synchronization.
+ *
+ * Checkpoint is based on futexes (man futex). The library allocates a page of
+ * shared memory for futexes and the id is an offset to it which gives the user
+ * up to page_size/sizeof(uint32_t) checkpoint pairs. Up to INT_MAX processes
+ * can sleep on single id and can be woken up by single wake.
+ */
+
+#ifndef TSO_CHECKPOINT__
+#define TSO_CHECKPOINT__
+
+#include "test.h"
+#include "tst_checkpoint_fn.h"
+
+#define TST_SAFE_CHECKPOINT_WAIT(cleanup_fn, id) \
+        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, 0);
+
+#define TST_SAFE_CHECKPOINT_WAIT2(cleanup_fn, id, msec_timeout) \
+        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, msec_timeout);
+
+#define TST_SAFE_CHECKPOINT_WAKE(cleanup_fn, id) \
+        tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1);
+
+#define TST_SAFE_CHECKPOINT_WAKE2(cleanup_fn, id, nr_wake) \
+        tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, nr_wake);
+
+#define TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup_fn, id) \
+        tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1); \
+        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, 0);
+
+#endif /* TSO_CHECKPOINT__ */
diff --git a/include/old/ltp_cpuid.h b/include/old/tso_cpuid.h
similarity index 100%
rename from include/old/ltp_cpuid.h
rename to include/old/tso_cpuid.h
diff --git a/include/old/old_device.h b/include/old/tso_device.h
similarity index 74%
rename from include/old/old_device.h
rename to include/old/tso_device.h
index a6e9fea86..7081c554e 100644
--- a/include/old/old_device.h
+++ b/include/old/tso_device.h
@@ -1,22 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2014-2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) Linux Test Project, 2026
  */
 
-#ifndef OLD_DEVICE_H__
-#define OLD_DEVICE_H__
+#ifndef TSO_DEVICE_H__
+#define TSO_DEVICE_H__
 
 /*
  * Returns filesystem type to be used for the testing. Unless your test is
@@ -81,4 +70,4 @@ int tst_detach_device(const char *dev);
  */
 int tst_umount(const char *path);
 
-#endif	/* OLD_DEVICE_H__ */
+#endif	/* TSO_DEVICE_H__ */
diff --git a/include/old/tlibio.h b/include/old/tso_lio.h
similarity index 79%
rename from include/old/tlibio.h
rename to include/old/tso_lio.h
index 0fe9ce9de..14a01dfde 100644
--- a/include/old/tlibio.h
+++ b/include/old/tso_lio.h
@@ -1,33 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+ * Copyright (c) Linux Test Project, 2026
  */
 
 #define LIO_IO_SYNC             00001   /* read/write */
diff --git a/include/old/old_module.h b/include/old/tso_module.h
similarity index 68%
rename from include/old/old_module.h
rename to include/old/tso_module.h
index f49c9937e..9072acc0a 100644
--- a/include/old/old_module.h
+++ b/include/old/tso_module.h
@@ -1,35 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
- * Copyright (c) Linux Test Project, 2016-2024
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- * Author:
- * Alexey Kodanev <alexey.kodanev@oracle.com>
- *
- * These functions help to load and unload kernel modules in the tests.
- *
- * tst_module_load function already includes tst_module_exists function,
- * which is checking the following possible module's locations:
- *
- * 1. Current working directory
- *
- * 2. LTP installation path (using env LTPROOT, which is usually /opt/ltp)
- *
- * 3. If tmp directory created, it'll look at the test start working directory
- *
+ * Copyright (c) Linux Test Project, 2026
  */
 
 #ifndef TST_MODULE
diff --git a/include/old/ltp_priv.h b/include/old/tso_priv.h
similarity index 62%
rename from include/old/ltp_priv.h
rename to include/old/tso_priv.h
index 0a0ef70f3..ed09fdbc6 100644
--- a/include/old/ltp_priv.h
+++ b/include/old/tso_priv.h
@@ -1,22 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Cyril Hrubis chrubis@suse.cz
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
+ * Copyright (c) Linux Test Project, 2026
  */
 
 #ifndef __LTP_PRIV_H__
diff --git a/include/old/tso_random_range.h b/include/old/tso_random_range.h
new file mode 100644
index 000000000..90064f9ba
--- /dev/null
+++ b/include/old/tso_random_range.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2026
+ */
+
+#ifndef _RANDOM_RANGE_H_
+#define _RANDOM_RANGE_H_
+
+int       parse_ranges     ( char *, int, int, int, int (*)(), char **, char ** );
+int       range_min        ( char *, int );
+int       range_max        ( char *, int );
+int       range_mult       ( char *, int );
+long      random_range     ( int, int, int, char ** );
+long      random_rangel    ( long, long, long, char ** );
+long long random_rangell   ( long long, long long, long long, char ** );
+void      random_range_seed( long );
+long      random_bit       ( long );
+
+#endif
diff --git a/include/old/tso_resource.h b/include/old/tso_resource.h
new file mode 100644
index 000000000..b5291477f
--- /dev/null
+++ b/include/old/tso_resource.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012 Cyril Hrubis chrubis@suse.cz
+ * Copyright (c) Linux Test Project, 2026
+ */
+
+ /*
+  * Small helper for preparing files the test needs to copy before the testing.
+  * We need to support two scenarios.
+  *
+  * 1. Test is executed in local directory and this is also the place
+  *     we should look for files
+  *
+  * 2. Test is executed after LTP has been installed, in this case we
+  *     look for env LTPROOT (usually /opt/ltp/)
+  */
+
+#ifndef TST_RESOURCE
+#define TST_RESOURCE
+
+const char *tst_dataroot(void);
+
+/*
+ * Copy a file to the CWD. The destination is apended to CWD.
+ */
+#define TST_RESOURCE_COPY(cleanup_fn, filename, dest) \
+	tst_resource_copy(__FILE__, __LINE__, (cleanup_fn), \
+	                  (filename), (dest))
+
+void tst_resource_copy(const char *file, const int lineno,
+                       void (*cleanup_fn)(void),
+		       const char *filename, const char *dest);
+
+#endif /* TST_RESOURCE */
diff --git a/include/old/old_safe_file_ops.h b/include/old/tso_safe_file_ops.h
similarity index 70%
rename from include/old/old_safe_file_ops.h
rename to include/old/tso_safe_file_ops.h
index d6e2d29a9..1ddfad966 100644
--- a/include/old/old_safe_file_ops.h
+++ b/include/old/tso_safe_file_ops.h
@@ -1,28 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2012-2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) Linux Test Project, 2026
  */
 
  /*
-
    This code helps with file reading/writing files providing scanf/printf like
    interface that opens and closes the file automatically.
 
    This kind of interface is especially useful for reading/writing values
    from/to pseudo filesystems like procfs or sysfs.
-
   */
 
 #ifndef SAFE_FILE_OPS
diff --git a/include/old/safe_macros.h b/include/old/tso_safe_macros.h
similarity index 98%
rename from include/old/safe_macros.h
rename to include/old/tso_safe_macros.h
index 307843ab0..f3965cc68 100644
--- a/include/old/safe_macros.h
+++ b/include/old/tso_safe_macros.h
@@ -1,3 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2026
+ */
+
 /*
  * Safe macros for commonly used syscalls to reduce code duplication in LTP
  * testcases, and to ensure all errors are caught in said testcases as
@@ -6,7 +11,6 @@
  * Also satiates some versions of gcc/glibc when the warn_unused_result
  * attribute is applied to the function call.
  *
- * Licensed under the GPLv2.
  */
 
 #ifndef __TEST_H__
@@ -17,8 +21,8 @@
 #define __SAFE_MACROS_H__
 
 #include "safe_macros_fn.h"
-#include "old_safe_stdio.h"
-#include "old_safe_net.h"
+#include "tso_safe_stdio.h"
+#include "tso_safe_net.h"
 
 #define SAFE_BASENAME(cleanup_fn, path)	\
 	safe_basename(__FILE__, __LINE__, (cleanup_fn), (path))
diff --git a/include/old/old_safe_net.h b/include/old/tso_safe_net.h
similarity index 58%
rename from include/old/old_safe_net.h
rename to include/old/tso_safe_net.h
index 639094a94..2513dc39e 100644
--- a/include/old/old_safe_net.h
+++ b/include/old/tso_safe_net.h
@@ -1,23 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015 Fujitsu Ltd.
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) Linux Test Project, 2026
  */
 
-#ifndef OLD_SAFE_NET_H__
-#define OLD_SAFE_NET_H__
+#ifndef TSO_SAFE_NET_H__
+#define TSO_SAFE_NET_H__
 
 #include <sys/types.h>
 #include <sys/socket.h>
@@ -47,4 +36,4 @@
 #define TST_GET_UNUSED_PORT(cleanup_fn, family, type) \
 	tst_get_unused_port(__FILE__, __LINE__, (cleanup_fn), family, type)
 
-#endif /* OLD_SAFE_NET_H__ */
+#endif /* TSO_SAFE_NET_H__ */
diff --git a/include/old/tso_safe_stdio.h b/include/old/tso_safe_stdio.h
new file mode 100644
index 000000000..efda431ab
--- /dev/null
+++ b/include/old/tso_safe_stdio.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2013-2016 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2026
+ */
+
+#ifndef TSO_SAFE_STDIO_H__
+#define TSO_SAFE_STDIO_H__
+
+#include <stdio.h>
+
+#include "safe_stdio_fn.h"
+
+#define SAFE_FOPEN(cleanup_fn, path, mode) \
+	safe_fopen(__FILE__, __LINE__, cleanup_fn, path, mode)
+
+#define SAFE_FCLOSE(cleanup_fn, f) \
+	safe_fclose(__FILE__, __LINE__, cleanup_fn, f)
+
+#define SAFE_ASPRINTF(cleanup_fn, strp, fmt, ...) \
+	safe_asprintf(__FILE__, __LINE__, cleanup_fn, strp, fmt, __VA_ARGS__)
+
+#define SAFE_POPEN(cleanup_fn, command, type) \
+	safe_popen(__FILE__, __LINE__, cleanup_fn, command, type)
+
+#endif /* TSO_SAFE_STDIO_H__ */
diff --git a/include/old/tso_signal.h b/include/old/tso_signal.h
new file mode 100644
index 000000000..d29cb790a
--- /dev/null
+++ b/include/old/tso_signal.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2009 Cisco Systems, Inc.  All Rights Reserved.
+ * Copyright (c) 2009 FUJITSU LIMITED.  All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2026
+ *
+ * Author: Liu Bo <liubo2009@cn.fujitsu.com>
+ * Author: Ngie Cooper <yaneurabeya@gmail.com>
+ */
+
+#ifndef __LTP_SIGNAL_H
+#define __LTP_SIGNAL_H
+
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include "config.h"
+
+/*
+ * For all but __mips__:
+ *
+ * _COMPAT_NSIG / _COMPAT_NSIG_BPW == 2.
+ *
+ * For __mips__:
+ *
+ * _COMPAT_NSIG / _COMPAT_NSIG_BPW == 4.
+ *
+ * See asm/compat.h under the kernel source for more details.
+ *
+ * Multiply that by a fudge factor of 4 and you have your SIGSETSIZE.
+ */
+#if defined __mips__
+#define SIGSETSIZE 16
+#else
+#define SIGSETSIZE (_NSIG / 8)
+#endif
+
+#endif
diff --git a/include/old/old_tmpdir.h b/include/old/tso_tmpdir.h
similarity index 62%
rename from include/old/old_tmpdir.h
rename to include/old/tso_tmpdir.h
index 3e33bf043..3187d4309 100644
--- a/include/old/old_tmpdir.h
+++ b/include/old/tso_tmpdir.h
@@ -1,22 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ * Copyright (c) Linux Test Project, 2026
  */
 
-#ifndef OLD_TMPDIR_H__
-#define OLD_TMPDIR_H__
+#ifndef TSO_TMPDIR_H__
+#define TSO_TMPDIR_H__
 
 /*
  * Create a unique temporary directory and chdir() to it. It expects the caller
@@ -58,4 +47,4 @@ int tst_tmpdir_created(void);
 /* declared in tst_tmpdir.c */
 const char *tst_get_startwd(void);
 
-#endif	/* OLD_TMPDIR_H__ */
+#endif	/* TSO_TMPDIR_H__ */
diff --git a/include/old/usctest.h b/include/old/tso_usctest.h
similarity index 54%
rename from include/old/usctest.h
rename to include/old/tso_usctest.h
index b984c343f..342c03d5f 100644
--- a/include/old/usctest.h
+++ b/include/old/tso_usctest.h
@@ -1,38 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  *               Author: William Roske
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
- * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
- * Mountain View, CA  94043, or:
- *
- * http://www.sgi.com
- *
- * For further information regarding this notice, see:
- *
- * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+ * Copyright (c) Linux Test Project, 2026
  */
 
-#ifndef __USCTEST_H__
-#define __USCTEST_H__
+#ifndef TSO_USCTEST_H__
+#define TSO_USCTEST_H__
 
 /* For PATH_MAX */
 #include <linux/limits.h>
@@ -80,4 +54,4 @@ int usc_global_setup_hook();
 #define TEST_LOOPING usc_test_looping
 int usc_test_looping(int counter);
 
-#endif /* __USCTEST_H__ */
+#endif /* TSO_USCTEST_H__ */
diff --git a/lib/parse_opts.c b/lib/parse_opts.c
index 03e833312..565af4421 100644
--- a/lib/parse_opts.c
+++ b/lib/parse_opts.c
@@ -43,8 +43,8 @@
 #include <stdint.h>
 
 #include "test.h"
-#include "ltp_priv.h"
-#include "usctest.h"
+#include "tso_priv.h"
+#include "tso_usctest.h"
 #include "tst_clocks.h"
 
 #ifndef UNIT_TEST
diff --git a/lib/random_range.c b/lib/random_range.c
index 4c96fd913..0978c6fa3 100644
--- a/lib/random_range.c
+++ b/lib/random_range.c
@@ -33,7 +33,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <malloc.h>
-#include "random_range.h"
+#include "tso_random_range.h"
 
 /*
  * Internal format of the range array set up by parse_range()
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index a3145b8d6..68b8747b4 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -23,7 +23,7 @@
 #include <math.h>
 #include "lapi/fcntl.h"
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *safe_basename(const char *file, const int lineno,
 		    void (*cleanup_fn) (void), char *path)
diff --git a/lib/tests/trerrno.c b/lib/tests/trerrno.c
index a160874de..c830aed2a 100644
--- a/lib/tests/trerrno.c
+++ b/lib/tests/trerrno.c
@@ -21,7 +21,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define OUTPUT_FNAME "output"
 
diff --git a/lib/tests/tst_dataroot01.c b/lib/tests/tst_dataroot01.c
index fab8bfea2..d0a03ff77 100644
--- a/lib/tests/tst_dataroot01.c
+++ b/lib/tests/tst_dataroot01.c
@@ -21,7 +21,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define OUTPUT_FNAME "output"
 #define LTPROOT "/opt/ltp"
diff --git a/lib/tests/tst_dataroot02.c b/lib/tests/tst_dataroot02.c
index b936b57f4..2be9db2a2 100644
--- a/lib/tests/tst_dataroot02.c
+++ b/lib/tests/tst_dataroot02.c
@@ -21,7 +21,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define OUTPUT_FNAME "output"
 #define LTPROOT "/opt/ltp"
diff --git a/lib/tests/tst_dataroot03.c b/lib/tests/tst_dataroot03.c
index cf5a04ec6..88ea9e076 100644
--- a/lib/tests/tst_dataroot03.c
+++ b/lib/tests/tst_dataroot03.c
@@ -21,7 +21,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define OUTPUT_FNAME "output"
 #define LTPROOT "/opt/ltp"
diff --git a/lib/tests/tst_safe_macros.c b/lib/tests/tst_safe_macros.c
index 5c427ee16..59b9b49bb 100644
--- a/lib/tests/tst_safe_macros.c
+++ b/lib/tests/tst_safe_macros.c
@@ -1,5 +1,5 @@
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "test_safe_macros";
 int TST_TOTAL = 1;
diff --git a/lib/tlibio.c b/lib/tlibio.c
index 70e0c6f7d..cf62bdc61 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -93,8 +93,8 @@
 #endif
 #include <stdlib.h>		/* atoi, abs */
 
-#include "tlibio.h"		/* defines LIO* macros */
-#include "random_range.h"
+#include "tso_lio.h"		/* defines LIO* macros */
+#include "tso_random_range.h"
 
 #ifndef PATH_MAX
 #define PATH_MAX	MAXPATHLEN
diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 9f803e3ef..f2faf6563 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -10,7 +10,7 @@
 #include <sys/syscall.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/futex.h"
 
 #define DEFAULT_MSEC_TIMEOUT 10000
diff --git a/lib/tst_cpu.c b/lib/tst_cpu.c
index b4c7c2f81..faffcba91 100644
--- a/lib/tst_cpu.c
+++ b/lib/tst_cpu.c
@@ -22,7 +22,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 long tst_ncpus(void)
 {
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 85f5f8cac..d3c53a1a1 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -21,7 +21,7 @@
 #include <sys/statfs.h>
 #include "lapi/syscalls.h"
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "tst_device.h"
 
 #ifndef LOOP_CTL_GET_FREE
diff --git a/lib/tst_dir_is_empty.c b/lib/tst_dir_is_empty.c
index 43764eeba..b266630d8 100644
--- a/lib/tst_dir_is_empty.c
+++ b/lib/tst_dir_is_empty.c
@@ -23,7 +23,7 @@
 #include <dirent.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 int tst_dir_is_empty_(void (cleanup_fn)(void), const char *name, int verbose)
 {
diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
index 6a6bb52b2..e0fbb3351 100644
--- a/lib/tst_fs_link_count.c
+++ b/lib/tst_fs_link_count.c
@@ -22,8 +22,8 @@
 #include <unistd.h>
 
 #include "test.h"
-#include "usctest.h"
-#include "safe_macros.h"
+#include "tso_usctest.h"
+#include "tso_safe_macros.h"
 
 #define MAX_SANE_HARD_LINKS	65535
 
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 9ab02e5d3..8bb7e080a 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -24,7 +24,7 @@
 
 #include "test.h"
 #include "tst_kernel.h"
-#include "old_safe_stdio.h"
+#include "tso_safe_stdio.h"
 #include "lapi/abisize.h"
 
 static int get_kernel_bits_from_uname(struct utsname *buf)
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 19d995df2..c619a373d 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -16,7 +16,7 @@
  */
 
 #include "test.h"
-#include "ltp_priv.h"
+#include "tso_priv.h"
 #include "tst_mkfs.h"
 #include "tst_device.h"
 
diff --git a/lib/tst_module.c b/lib/tst_module.c
index 42d63ede6..cbd2415d5 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -28,8 +28,8 @@
 
 #include "test.h"
 #include "tst_kconfig.h"
-#include "ltp_priv.h"
-#include "old_module.h"
+#include "tso_priv.h"
+#include "tso_module.h"
 
 void tst_module_exists_(void (cleanup_fn)(void),
 	const char *mod_name, char **mod_path)
diff --git a/lib/tst_parse_opts.c b/lib/tst_parse_opts.c
index 94970e1a8..148454019 100644
--- a/lib/tst_parse_opts.c
+++ b/lib/tst_parse_opts.c
@@ -22,7 +22,7 @@
  */
 
 #include "test.h"
-#include "ltp_priv.h"
+#include "tso_priv.h"
 
 void tst_parse_opts(int argc, char *argv[], const option_t *user_optarg,
                     void (*user_help)(void))
diff --git a/lib/tst_pid.c b/lib/tst_pid.c
index 4e9dc7a52..4346a826b 100644
--- a/lib/tst_pid.c
+++ b/lib/tst_pid.c
@@ -28,7 +28,7 @@
 #include <unistd.h>
 #include "test.h"
 #include "tst_pid.h"
-#include "old_safe_file_ops.h"
+#include "tso_safe_file_ops.h"
 #include "tst_safe_macros.h"
 #include "lapi/syscalls.h"
 
diff --git a/lib/tst_res.c b/lib/tst_res.c
index f50c07271..9278ad9f1 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -48,9 +48,9 @@
 #include <sys/wait.h>
 
 #include "test.h"
-#include "safe_macros.h"
-#include "usctest.h"
-#include "ltp_priv.h"
+#include "tso_safe_macros.h"
+#include "tso_usctest.h"
+#include "tso_priv.h"
 #include "tst_ansi_color.h"
 
 long TEST_RETURN;
diff --git a/lib/tst_resource.c b/lib/tst_resource.c
index c35d05a25..ea2783dce 100644
--- a/lib/tst_resource.c
+++ b/lib/tst_resource.c
@@ -23,8 +23,8 @@
 
 #include <pthread.h>
 #include "test.h"
-#include "old_resource.h"
-#include "ltp_priv.h"
+#include "tso_resource.h"
+#include "tso_priv.h"
 
 #ifndef PATH_MAX
 #ifdef MAXPATHLEN
diff --git a/lib/tst_test.c b/lib/tst_test.c
index e115ce689..9235fc2fb 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -34,9 +34,9 @@
 #include "tst_sys_conf.h"
 #include "tst_kconfig.h"
 #include "tst_private.h"
-#include "old_resource.h"
-#include "old_device.h"
-#include "old_tmpdir.h"
+#include "tso_resource.h"
+#include "tso_device.h"
+#include "tso_tmpdir.h"
 #include "ltp-version.h"
 #include "tst_hugepage.h"
 
diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 6ed2367b9..b9924d85d 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -72,9 +72,9 @@
 
 #include "test.h"
 #include "tst_buffers.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "tst_tmpdir.h"
-#include "ltp_priv.h"
+#include "tso_priv.h"
 #include "lapi/futex.h"
 
 /*
diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index 0fda20a17..109d7a853 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -24,7 +24,7 @@
 
 #include <unistd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 static int is_kvm(void)
 {
diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
index 2c080933e..242e988be 100644
--- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -36,7 +36,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "cgroup_xattr";
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
index 4856f3372..ad0e4fbd9 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
@@ -57,7 +57,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #ifdef DEBUG
 #define dbg(x...)	printf(x);
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
index 3c19a7719..937ee934a 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
@@ -60,7 +60,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
index 63aec0d2a..6b974ec74 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
@@ -61,7 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
index 9a56d7b49..95515e72a 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
@@ -61,7 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define TIME_INTERVAL	100	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
index 9370f7eb8..b37e77a34 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
@@ -62,7 +62,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
index a9b90d6b6..ea5510bd5 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
@@ -61,7 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
index a81370085..7c5eaf878 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
@@ -61,7 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
index d166aa4d3..1aad41d78 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
@@ -61,7 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define TIME_INTERVAL	100	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi.c b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
index 2c0cc562b..9512270fc 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
@@ -22,8 +22,8 @@
 #include <stdlib.h>
 
 #include "test.h"
-#include "old_module.h"
-#include "safe_macros.h"
+#include "tso_module.h"
+#include "tso_safe_macros.h"
 
 #include "ltp_acpi.h"
 
diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
index 645c4326a..940c56090 100644
--- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
+++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
@@ -34,7 +34,7 @@
 
 #include "test.h"
 #include "lapi/posix_clocks.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "cpufreq_boost";
 
diff --git a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
index 5d241fb42..704fb15a5 100644
--- a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
@@ -27,8 +27,8 @@
 #include <errno.h>
 
 #include "test.h"
-#include "safe_macros.h"
-#include "old_module.h"
+#include "tso_safe_macros.h"
+#include "tso_module.h"
 
 #include "../tpci_kernel/tpci.h"
 
diff --git a/testcases/kernel/device-drivers/rtc/rtc01.c b/testcases/kernel/device-drivers/rtc/rtc01.c
index 8a1f62ead..a02633d5f 100644
--- a/testcases/kernel/device-drivers/rtc/rtc01.c
+++ b/testcases/kernel/device-drivers/rtc/rtc01.c
@@ -33,7 +33,7 @@
 #include <time.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 int rtc_fd = -1;
 char *TCID = "rtc01";
diff --git a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
index e882dc768..f7888b63d 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
+++ b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
@@ -53,8 +53,8 @@
 #include <string.h>
 
 #include "test.h"
-#include "safe_macros.h"
-#include "old_module.h"
+#include "tso_safe_macros.h"
+#include "tso_module.h"
 
 #include "../tbio_kernel/tbio.h"
 
diff --git a/testcases/kernel/device-drivers/uaccess/uaccess.c b/testcases/kernel/device-drivers/uaccess/uaccess.c
index f337aba64..fbd4ff81a 100644
--- a/testcases/kernel/device-drivers/uaccess/uaccess.c
+++ b/testcases/kernel/device-drivers/uaccess/uaccess.c
@@ -27,8 +27,8 @@
 #include <unistd.h>
 
 #include "test.h"
-#include "old_module.h"
-#include "safe_macros.h"
+#include "tso_module.h"
+#include "tso_safe_macros.h"
 #include "tst_security.h"
 
 #include "ltp_uaccess.h"
diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
index f5b918a69..1f68f2ad6 100644
--- a/testcases/kernel/firmware/fw_load_user/fw_load.c
+++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
@@ -30,8 +30,8 @@
 
 #include "test.h"
 #include "tst_security.h"
-#include "safe_macros.h"
-#include "old_module.h"
+#include "tso_safe_macros.h"
+#include "tso_module.h"
 
 /* number of test firmware files */
 #define FW_FILES	5
diff --git a/testcases/kernel/fs/doio/doio.c b/testcases/kernel/fs/doio/doio.c
index b170f6670..1a62ac16a 100644
--- a/testcases/kernel/fs/doio/doio.c
+++ b/testcases/kernel/fs/doio/doio.c
@@ -84,7 +84,7 @@
 
 #include "doio.h"
 #include "write_log.h"
-#include "random_range.h"
+#include "tso_random_range.h"
 #include "string_to_tokens.h"
 #include "pattern.h"
 
diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
index 7bf51fb9c..21960f82a 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -85,7 +85,7 @@
 #include <string.h>
 #include <inttypes.h>
 #include "dataascii.h"
-#include "random_range.h"
+#include "tso_random_range.h"
 #include "databin.h"
 #include "open_flags.h"
 #include "forker.h"
@@ -145,7 +145,7 @@ void myexit(int x)
 			/* Once it is proven tlibio.c functions work properly, */
 			/* only tlibio.c functions will be used */
 #else
-#include "tlibio.h"
+#include "tso_lio.h"
 #endif
 
 #ifndef PATH_MAX
@@ -589,7 +589,7 @@ int main(int argc, char **argv)
 					Progname, TagName);
 				exit(1);
 			}
-			if (io_type == 99)	/* hold-over until tlibio.h */
+			if (io_type == 99)	/* hold-over until tso_lio.h */
 				using_random++;
 #endif
 			break;
diff --git a/testcases/kernel/fs/doio/iogen.c b/testcases/kernel/fs/doio/iogen.c
index 765cfdae5..76ce2259a 100644
--- a/testcases/kernel/fs/doio/iogen.c
+++ b/testcases/kernel/fs/doio/iogen.c
@@ -64,7 +64,7 @@
 #include "bytes_by_prefix.h"
 #include "string_to_tokens.h"
 #include "open_flags.h"
-#include "random_range.h"
+#include "tso_random_range.h"
 
 #ifndef PATH_MAX
 #define	PATH_MAX 512		/* ??? */
diff --git a/testcases/kernel/fs/ftest/ftest01.c b/testcases/kernel/fs/ftest/ftest01.c
index 31203d689..86f986acc 100644
--- a/testcases/kernel/fs/ftest/ftest01.c
+++ b/testcases/kernel/fs/ftest/ftest01.c
@@ -59,7 +59,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest01";
diff --git a/testcases/kernel/fs/ftest/ftest03.c b/testcases/kernel/fs/ftest/ftest03.c
index ed69e5736..507101d00 100644
--- a/testcases/kernel/fs/ftest/ftest03.c
+++ b/testcases/kernel/fs/ftest/ftest03.c
@@ -64,7 +64,7 @@
 #include <stdio.h>
 #include <inttypes.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest03";
diff --git a/testcases/kernel/fs/ftest/ftest04.c b/testcases/kernel/fs/ftest/ftest04.c
index 8eed84c74..3bc4d2a1e 100644
--- a/testcases/kernel/fs/ftest/ftest04.c
+++ b/testcases/kernel/fs/ftest/ftest04.c
@@ -48,7 +48,7 @@
 #include <errno.h>
 #include <signal.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest04";
diff --git a/testcases/kernel/fs/ftest/ftest05.c b/testcases/kernel/fs/ftest/ftest05.c
index 8d8e6d497..2bbdd3238 100644
--- a/testcases/kernel/fs/ftest/ftest05.c
+++ b/testcases/kernel/fs/ftest/ftest05.c
@@ -63,7 +63,7 @@
 #include <inttypes.h>
 #include <sys/param.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest05";
diff --git a/testcases/kernel/fs/ftest/ftest07.c b/testcases/kernel/fs/ftest/ftest07.c
index 3b5b2a419..1e63159b3 100644
--- a/testcases/kernel/fs/ftest/ftest07.c
+++ b/testcases/kernel/fs/ftest/ftest07.c
@@ -70,7 +70,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest07";
diff --git a/testcases/kernel/fs/ftest/ftest08.c b/testcases/kernel/fs/ftest/ftest08.c
index e7fb56fe4..356a031b8 100644
--- a/testcases/kernel/fs/ftest/ftest08.c
+++ b/testcases/kernel/fs/ftest/ftest08.c
@@ -55,7 +55,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest08";
diff --git a/testcases/kernel/io/direct_io/diotest1.c b/testcases/kernel/io/direct_io/diotest1.c
index 03a054b4c..c6c50ff4e 100644
--- a/testcases/kernel/io/direct_io/diotest1.c
+++ b/testcases/kernel/io/direct_io/diotest1.c
@@ -40,7 +40,7 @@
 #include "diotest_routines.h"
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "diotest01";	/* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test conditions */
diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index ad00fa3e0..3f37a8a4f 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -68,7 +68,7 @@
 #include "diotest_routines.h"
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/mmap.h"
 
 char *TCID = "diotest4";	/* Test program identifier.    */
diff --git a/testcases/kernel/io/direct_io/dma_thread_diotest.c b/testcases/kernel/io/direct_io/dma_thread_diotest.c
index c317eba8e..b757ba0e2 100644
--- a/testcases/kernel/io/direct_io/dma_thread_diotest.c
+++ b/testcases/kernel/io/direct_io/dma_thread_diotest.c
@@ -103,7 +103,7 @@
 #include <sys/mount.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define FILESIZE	(12*1024*1024)
 #define READSIZE	(1024*1024)
diff --git a/testcases/kernel/ipc/pipeio/pipeio.c b/testcases/kernel/ipc/pipeio/pipeio.c
index ab5c2cf06..9a7d3c61f 100644
--- a/testcases/kernel/ipc/pipeio/pipeio.c
+++ b/testcases/kernel/ipc/pipeio/pipeio.c
@@ -48,10 +48,10 @@
 #include <signal.h>
 #include <sys/stat.h>
 
-#include "tlibio.h"
+#include "tso_lio.h"
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/sem.h"
 
 char *TCID = "pipeio";
diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index 2eee8d35d..129e75f40 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -32,7 +32,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "numa_helper.h"
 #include "lapi/syscalls.h"
 
diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
index d220b636c..7d784da62 100644
--- a/testcases/kernel/mem/vma/vma01.c
+++ b/testcases/kernel/mem/vma/vma01.c
@@ -51,7 +51,7 @@
 #include <string.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define MAPS_FILE "/proc/self/maps"
 
diff --git a/testcases/kernel/mem/vma/vma02.c b/testcases/kernel/mem/vma/vma02.c
index 2b99f8dec..c961a1a43 100644
--- a/testcases/kernel/mem/vma/vma02.c
+++ b/testcases/kernel/mem/vma/vma02.c
@@ -43,7 +43,7 @@
 #include <unistd.h>
 #include <limits.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "numa_helper.h"
 
 char *TCID = "vma02";
diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
index 65884d9d9..da1f5be99 100644
--- a/testcases/kernel/mem/vma/vma03.c
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -49,7 +49,7 @@
 #include <unistd.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "tst_kernel.h"
 #include "lapi/abisize.h"
 
diff --git a/testcases/kernel/mem/vma/vma04.c b/testcases/kernel/mem/vma/vma04.c
index 24ccd9d6b..06a316667 100644
--- a/testcases/kernel/mem/vma/vma04.c
+++ b/testcases/kernel/mem/vma/vma04.c
@@ -47,7 +47,7 @@
 #include <unistd.h>
 #include <limits.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "numa_helper.h"
 
 char *TCID = "vma04";
diff --git a/testcases/kernel/pty/hangup01.c b/testcases/kernel/pty/hangup01.c
index a71b4b44b..fca61e8ac 100644
--- a/testcases/kernel/pty/hangup01.c
+++ b/testcases/kernel/pty/hangup01.c
@@ -32,7 +32,7 @@
 
 /** LTP Port **/
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "hangup01";	/* Test program identifier.    */
 int TST_TOTAL = 5;		/* Total number of test cases. */
diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c
index 18f0862cb..38c1ba77e 100644
--- a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c
+++ b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c
@@ -6,7 +6,7 @@
 #include <alloca.h>
 #include <string.h>
 #include <linux/unistd.h>
-#include "ltp_cpuid.h"
+#include "tso_cpuid.h"
 
 #define PROC_PATH	"/proc"
 #define BUFF_SIZE	8192
diff --git a/testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.c b/testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.c
index 7644e352c..772cb3c93 100644
--- a/testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.c
+++ b/testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.c
@@ -6,7 +6,7 @@
 #include <alloca.h>
 #include <string.h>
 #include <linux/unistd.h>
-#include "ltp_cpuid.h"
+#include "tso_cpuid.h"
 
 #define PROC_PATH	"/proc"
 #define BUFF_SIZE	8192
diff --git a/testcases/kernel/security/filecaps/filecaps_common.h b/testcases/kernel/security/filecaps/filecaps_common.h
index 0f011868e..1c19f99cd 100644
--- a/testcases/kernel/security/filecaps/filecaps_common.h
+++ b/testcases/kernel/security/filecaps/filecaps_common.h
@@ -1,6 +1,6 @@
 #include <limits.h>
 #include <stdlib.h>
-#include <old_tmpdir.h>
+#include <tso_tmpdir.h>
 
 static char *fifofile;
 
diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
index 20f33527c..0d3e6a61e 100644
--- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
+++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
@@ -43,7 +43,7 @@
 #include <signal.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "prot_hsymlinks";
 int TST_TOTAL = 396;
diff --git a/testcases/kernel/syscalls/clone/clone02.c b/testcases/kernel/syscalls/clone/clone02.c
index fd3ee1aed..972db5205 100644
--- a/testcases/kernel/syscalls/clone/clone02.c
+++ b/testcases/kernel/syscalls/clone/clone02.c
@@ -58,7 +58,7 @@
 #include <sys/syscall.h>
 #include <sched.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "tst_clone.h"
 
 #define FLAG_ALL (CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|SIGCHLD)
diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 660c4f7a9..6cb8adab3 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -53,7 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "connect01";
 int testno;
diff --git a/testcases/kernel/syscalls/fallocate/fallocate01.c b/testcases/kernel/syscalls/fallocate/fallocate01.c
index 383796c90..d21936eba 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate01.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate01.c
@@ -99,7 +99,7 @@
 #include <sys/utsname.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/fallocate.h"
 #include "lapi/fcntl.h"
 
diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index bb719d78f..4469f02f2 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -39,7 +39,7 @@
 #include <limits.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/fallocate.h"
 #include "lapi/abisize.h"
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl07.c b/testcases/kernel/syscalls/fcntl/fcntl07.c
index 10d1186fc..cc0607e18 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl07.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl07.c
@@ -51,7 +51,7 @@
 #include <limits.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 static void setup(void);
 static void cleanup(void);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl11.c b/testcases/kernel/syscalls/fcntl/fcntl11.c
index 4fd9fcca9..9012d3588 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl11.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl11.c
@@ -45,7 +45,7 @@
 #include <sys/wait.h>
 #include <inttypes.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define STRINGSIZE	27
 #define STRING		"abcdefghijklmnopqrstuvwxyz\n"
diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
index 4ae9e6e7a..cdbb82b8b 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl16.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
@@ -46,7 +46,7 @@
 #include <signal.h>
 #include <errno.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
diff --git a/testcases/kernel/syscalls/fcntl/fcntl19.c b/testcases/kernel/syscalls/fcntl/fcntl19.c
index a58e921c3..4792bf6c1 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl19.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl19.c
@@ -49,7 +49,7 @@
 #include <inttypes.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define STRINGSIZE	27
 #define STRING		"abcdefghijklmnopqrstuvwxyz\n"
diff --git a/testcases/kernel/syscalls/fcntl/fcntl20.c b/testcases/kernel/syscalls/fcntl/fcntl20.c
index f271eeb2d..c7c554b20 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl20.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl20.c
@@ -45,7 +45,7 @@
 #include <sys/wait.h>
 #include <inttypes.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define STRINGSIZE	27
 #define STRING		"abcdefghijklmnopqrstuvwxyz\n"
diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
index f5c4f8398..2aab4a91c 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl31.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
@@ -35,7 +35,7 @@
 #include "test.h"
 #include "config.h"
 #include "lapi/syscalls.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/fcntl.h"
 
 static void setup(void);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl32.c b/testcases/kernel/syscalls/fcntl/fcntl32.c
index f567acc70..912d05662 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl32.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl32.c
@@ -24,7 +24,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 static void setup(void);
 static void verify_fcntl(int);
diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync02.c b/testcases/kernel/syscalls/fdatasync/fdatasync02.c
index 9ce4fc7bb..6181dab8c 100644
--- a/testcases/kernel/syscalls/fdatasync/fdatasync02.c
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync02.c
@@ -76,7 +76,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define EXP_RET_VAL	-1
 #define SPL_FILE	"/dev/null"
diff --git a/testcases/kernel/syscalls/fork/fork09.c b/testcases/kernel/syscalls/fork/fork09.c
index 32bad89b3..c3b9cf45b 100644
--- a/testcases/kernel/syscalls/fork/fork09.c
+++ b/testcases/kernel/syscalls/fork/fork09.c
@@ -47,7 +47,7 @@
 #include <errno.h>
 #include <unistd.h>		/* for _SC_OPEN_MAX */
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "fork09";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/fstatat/fstatat01.c b/testcases/kernel/syscalls/fstatat/fstatat01.c
index c18ffacf2..f3dc5a23d 100644
--- a/testcases/kernel/syscalls/fstatat/fstatat01.c
+++ b/testcases/kernel/syscalls/fstatat/fstatat01.c
@@ -34,7 +34,7 @@
 #include <signal.h>
 #include "config.h"
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/syscalls.h"
 
 #define TEST_CASES 6
diff --git a/testcases/kernel/syscalls/futimesat/futimesat01.c b/testcases/kernel/syscalls/futimesat/futimesat01.c
index 46bd57c48..c53d9079f 100644
--- a/testcases/kernel/syscalls/futimesat/futimesat01.c
+++ b/testcases/kernel/syscalls/futimesat/futimesat01.c
@@ -33,7 +33,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/syscalls.h"
 
 #define TEST_CASES 5
diff --git a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
index 1ff37bc9b..28db417d9 100644
--- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
+++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
@@ -51,7 +51,7 @@
 #include <stdlib.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/syscalls.h"
 
 char *TCID = "get_robust_list01";
diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
index f18343c2c..f939f2a1a 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -50,7 +50,7 @@
 #include <time.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/posix_clocks.h"
 
 char *TCID = "getrusage04";
diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
index 57cfbcfc6..fa2065bbb 100644
--- a/testcases/kernel/syscalls/linkat/linkat01.c
+++ b/testcases/kernel/syscalls/linkat/linkat01.c
@@ -57,7 +57,7 @@
 #include <limits.h>
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #ifndef AT_FDCWD
 #define AT_FDCWD -100
diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
index 47383acec..273587271 100644
--- a/testcases/kernel/syscalls/linkat/linkat02.c
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -31,7 +31,7 @@
 
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/fcntl.h"
 
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
diff --git a/testcases/kernel/syscalls/listen/listen01.c b/testcases/kernel/syscalls/listen/listen01.c
index d33f209c3..109711b17 100644
--- a/testcases/kernel/syscalls/listen/listen01.c
+++ b/testcases/kernel/syscalls/listen/listen01.c
@@ -53,7 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "listen01";
 int testno;
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 198ba3813..428ca9a4c 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -37,7 +37,7 @@
 #include <pwd.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/syscalls.h"
 #include "numa_helper.h"
 #include "migrate_pages_common.h"
diff --git a/testcases/kernel/syscalls/mincore/mincore01.c b/testcases/kernel/syscalls/mincore/mincore01.c
index 03ec3b4e6..ed2f9e3bc 100644
--- a/testcases/kernel/syscalls/mincore/mincore01.c
+++ b/testcases/kernel/syscalls/mincore/mincore01.c
@@ -43,7 +43,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 static int pagesize;
 static rlim_t STACK_LIMIT = 10485760;
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat01.c b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
index ca536bdab..f1ad19bfb 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat01.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
@@ -35,7 +35,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 static void setup(void);
 static void cleanup(void);
diff --git a/testcases/kernel/syscalls/mknodat/mknodat01.c b/testcases/kernel/syscalls/mknodat/mknodat01.c
index 3be0a4f87..d7f4cca1e 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat01.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat01.c
@@ -33,7 +33,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/fcntl.h"
 
 #define PATHNAME "mknodattestdir"
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
index fdac5db15..2f7c56f00 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat02.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -35,7 +35,7 @@
 #include <sys/mount.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/fcntl.h"
 #include "lapi/syscalls.h"
 
diff --git a/testcases/kernel/syscalls/mlockall/mlockall02.c b/testcases/kernel/syscalls/mlockall/mlockall02.c
index 6524cb4a8..2eddf4c08 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall02.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall02.c
@@ -77,7 +77,7 @@
 #include <pwd.h>
 #include <sys/mman.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include <sys/resource.h>
 
 void setup();
diff --git a/testcases/kernel/syscalls/mlockall/mlockall03.c b/testcases/kernel/syscalls/mlockall/mlockall03.c
index a505891fc..0b3957377 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall03.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall03.c
@@ -79,7 +79,7 @@
 #include <ctype.h>
 #include <sys/mman.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include <sys/resource.h>
 #include <sys/utsname.h>
 
diff --git a/testcases/kernel/syscalls/move_pages/move_pages11.c b/testcases/kernel/syscalls/move_pages/move_pages11.c
index dec930b0e..1af38e403 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages11.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages11.c
@@ -59,7 +59,7 @@
 #include <errno.h>
 #include <pwd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "move_pages_support.h"
 
 #define TEST_PAGES 2
diff --git a/testcases/kernel/syscalls/mprotect/mprotect01.c b/testcases/kernel/syscalls/mprotect/mprotect01.c
index aa4685258..0786159aa 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect01.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect01.c
@@ -44,7 +44,7 @@
 #include <unistd.h>
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "mprotect01";
 int TST_TOTAL = 3;
diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
index de894868f..21e05e71e 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect02.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
@@ -41,7 +41,7 @@
 #include <stdlib.h>
 #include "test.h"
 
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 static void sighandler(int sig);
 static void cleanup(void);
diff --git a/testcases/kernel/syscalls/mprotect/mprotect03.c b/testcases/kernel/syscalls/mprotect/mprotect03.c
index 8ef64f212..01e958e65 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect03.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect03.c
@@ -46,7 +46,7 @@
 #include <sys/wait.h>
 #include "test.h"
 
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #ifndef PAGESIZE
 #define PAGESIZE 4096
diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index 6c7f6bd01..b63654daa 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -37,7 +37,7 @@
 #include <stdlib.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 static void sighandler(int sig);
 
diff --git a/testcases/kernel/syscalls/mremap/mremap01.c b/testcases/kernel/syscalls/mremap/mremap01.c
index 4c795fee5..8c241d45c 100644
--- a/testcases/kernel/syscalls/mremap/mremap01.c
+++ b/testcases/kernel/syscalls/mremap/mremap01.c
@@ -82,7 +82,7 @@
 #include <fcntl.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define TEMPFILE	"mremapfile"
 
diff --git a/testcases/kernel/syscalls/mremap/mremap05.c b/testcases/kernel/syscalls/mremap/mremap05.c
index d85ebb068..971cc8e5e 100644
--- a/testcases/kernel/syscalls/mremap/mremap05.c
+++ b/testcases/kernel/syscalls/mremap/mremap05.c
@@ -41,7 +41,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "mremap05";
 
diff --git a/testcases/kernel/syscalls/msync/msync03.c b/testcases/kernel/syscalls/msync/msync03.c
index f79458b9b..faa1457de 100644
--- a/testcases/kernel/syscalls/msync/msync03.c
+++ b/testcases/kernel/syscalls/msync/msync03.c
@@ -44,7 +44,7 @@
 #include <sys/resource.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define INV_SYNC	-1
 #define TEMPFILE	"msync_file"
diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
index 90bcff5d7..712e85745 100644
--- a/testcases/kernel/syscalls/openat/openat03.c
+++ b/testcases/kernel/syscalls/openat/openat03.c
@@ -25,7 +25,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/fcntl.h"
 #include "openat.h"
 
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
index 86a134b51..df54dc08c 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
@@ -43,7 +43,7 @@
 
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "perf_event_open01";
 
diff --git a/testcases/kernel/syscalls/pipe/pipe04.c b/testcases/kernel/syscalls/pipe/pipe04.c
index 219daecd8..c73d15298 100644
--- a/testcases/kernel/syscalls/pipe/pipe04.c
+++ b/testcases/kernel/syscalls/pipe/pipe04.c
@@ -49,7 +49,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "pipe04";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/pipe/pipe09.c b/testcases/kernel/syscalls/pipe/pipe09.c
index 86282de49..45742dd5e 100644
--- a/testcases/kernel/syscalls/pipe/pipe09.c
+++ b/testcases/kernel/syscalls/pipe/pipe09.c
@@ -51,7 +51,7 @@
 #include <sys/wait.h>
 #include <errno.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define	PIPEWRTCNT	100	/* must be an even number */
 
diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 606018af4..6578280ee 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -17,7 +17,7 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include "ltp_signal.h"
+#include "tso_signal.h"
 #include "time64_variants.h"
 #include "tst_sig_proc.h"
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
index a8254cb00..d6812fab6 100644
--- a/testcases/kernel/syscalls/profil/profil01.c
+++ b/testcases/kernel/syscalls/profil/profil01.c
@@ -26,7 +26,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/abisize.h"
 #include "config.h"
 
diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
index bb2578355..68904e9f1 100644
--- a/testcases/kernel/syscalls/recv/recv01.c
+++ b/testcases/kernel/syscalls/recv/recv01.c
@@ -53,7 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "recv01";
 int testno;
diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
index 6ce9f1bde..35cc03755 100644
--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -53,7 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "recvfrom01";
 int testno;
diff --git a/testcases/kernel/syscalls/removexattr/removexattr01.c b/testcases/kernel/syscalls/removexattr/removexattr01.c
index ddbcba698..f861b67f6 100644
--- a/testcases/kernel/syscalls/removexattr/removexattr01.c
+++ b/testcases/kernel/syscalls/removexattr/removexattr01.c
@@ -32,7 +32,7 @@
 #endif
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "removexattr01";
 
diff --git a/testcases/kernel/syscalls/removexattr/removexattr02.c b/testcases/kernel/syscalls/removexattr/removexattr02.c
index 399055ca7..d610d5720 100644
--- a/testcases/kernel/syscalls/removexattr/removexattr02.c
+++ b/testcases/kernel/syscalls/removexattr/removexattr02.c
@@ -37,7 +37,7 @@
 #endif
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "removexattr02";
 
diff --git a/testcases/kernel/syscalls/rename/rename11.c b/testcases/kernel/syscalls/rename/rename11.c
index 17cf04c85..8ff9f7d38 100644
--- a/testcases/kernel/syscalls/rename/rename11.c
+++ b/testcases/kernel/syscalls/rename/rename11.c
@@ -37,7 +37,7 @@
 #include <sys/mount.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "rename11";
 
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index c318a7971..72e72b481 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -48,7 +48,7 @@
 #include <sys/mount.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/fcntl.h"
 
 #define MNTPOINT "mntpoint"
diff --git a/testcases/kernel/syscalls/renameat2/renameat201.c b/testcases/kernel/syscalls/renameat2/renameat201.c
index 23ed5758a..01e34d653 100644
--- a/testcases/kernel/syscalls/renameat2/renameat201.c
+++ b/testcases/kernel/syscalls/renameat2/renameat201.c
@@ -35,7 +35,7 @@
 #define _GNU_SOURCE
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/fcntl.h"
 #include "renameat2.h"
 
diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
index 88db04762..a635206f7 100644
--- a/testcases/kernel/syscalls/renameat2/renameat202.c
+++ b/testcases/kernel/syscalls/renameat2/renameat202.c
@@ -24,7 +24,7 @@
 #define _GNU_SOURCE
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/fcntl.h"
 #include "renameat2.h"
 
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
index 8c4724eb4..85f59c4e2 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
@@ -57,7 +57,7 @@
 
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "ltp_signal.h"
+#include "tso_signal.h"
 
 char *TCID = "rt_sigprocmask02";
 int TST_TOTAL = 2;
diff --git a/testcases/kernel/syscalls/send/send01.c b/testcases/kernel/syscalls/send/send01.c
index 41859ff6f..b58b4189c 100644
--- a/testcases/kernel/syscalls/send/send01.c
+++ b/testcases/kernel/syscalls/send/send01.c
@@ -42,7 +42,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "send01";
 int testno;
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index 38cd7182c..25c5dc1b3 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -48,7 +48,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "sendmsg01";
 int testno;
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg02.c b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
index f72e9db22..99ba0d413 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg02.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
@@ -43,7 +43,7 @@
 #include <limits.h>
 #include "config.h"
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/sem.h"
 
 char *TCID = "sendmsg02";
diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
index b3b7b6efd..4a8145bf1 100644
--- a/testcases/kernel/syscalls/sendto/sendto01.c
+++ b/testcases/kernel/syscalls/sendto/sendto01.c
@@ -41,7 +41,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "sendto01";
 int testno;
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
index e1525a731..b88683738 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid04.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
@@ -38,7 +38,7 @@
 #include <unistd.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "compat_16.h"
 
 TCID_DEFINE(setfsuid04);
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index d00153533..97572c2bf 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -37,7 +37,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "setrlimit01";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
index 76f3be27f..56221511e 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
@@ -63,7 +63,7 @@
 #include "test.h"
 #include "lapi/fcntl.h"
 #include "lapi/syscalls.h"
-#include "ltp_signal.h"
+#include "tso_signal.h"
 
 #define SFD_CLOEXEC O_CLOEXEC
 
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
index 18f86b4a7..fd31eff88 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
@@ -59,7 +59,7 @@
 
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "ltp_signal.h"
+#include "tso_signal.h"
 
 #define SFD_NONBLOCK O_NONBLOCK
 
diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index d901540ca..1ab71e8e9 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -15,7 +15,7 @@
 
 #include "config.h"
 #include "tst_test.h"
-#include "ltp_signal.h"
+#include "tso_signal.h"
 #include "lapi/syscalls.h"
 
 static void sigpending_info(void)
diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index 23c675826..dba39cfed 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -108,7 +108,7 @@
 #include <time.h>
 #include <unistd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #ifdef __linux__
 /* glibc2.2 definition needs -D_XOPEN_SOURCE, which breaks other things. */
diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index e81ec20a5..6555e9212 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -40,7 +40,7 @@
 #include <net/if.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "sockioctl01";
 int testno;
diff --git a/testcases/kernel/syscalls/symlink/symlink03.c b/testcases/kernel/syscalls/symlink/symlink03.c
index c89fe5d6d..c73875dc7 100644
--- a/testcases/kernel/syscalls/symlink/symlink03.c
+++ b/testcases/kernel/syscalls/symlink/symlink03.c
@@ -87,7 +87,7 @@
 #include <pwd.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 #define MODE_RWX        S_IRWXU | S_IRWXG | S_IRWXO
 #define FILE_MODE       S_IRUSR | S_IRGRP | S_IROTH
diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
index d510872f0..565e4d923 100644
--- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
+++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
@@ -42,7 +42,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/syscalls.h"
 
 #define MYRETCODE -999
diff --git a/testcases/kernel/syscalls/umount2/umount2_01.c b/testcases/kernel/syscalls/umount2/umount2_01.c
index 5696270d6..274409ef3 100644
--- a/testcases/kernel/syscalls/umount2/umount2_01.c
+++ b/testcases/kernel/syscalls/umount2/umount2_01.c
@@ -25,7 +25,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 #include "lapi/mount.h"
 
 static void setup(void);
diff --git a/testcases/kernel/syscalls/vfork/vfork02.c b/testcases/kernel/syscalls/vfork/vfork02.c
index efa70d0be..f630c9572 100644
--- a/testcases/kernel/syscalls/vfork/vfork02.c
+++ b/testcases/kernel/syscalls/vfork/vfork02.c
@@ -78,7 +78,7 @@
 #include <sys/wait.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "vfork02";
 int TST_TOTAL = 1;
diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index 45f77a38b..c90ecd3fd 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -9,7 +9,7 @@
 #include <stdlib.h>
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
-#include "old/old_device.h"
+#include "old/tso_device.h"
 
 extern struct tst_test *tst_test;
 
diff --git a/testcases/network/lib6/asapi_01.c b/testcases/network/lib6/asapi_01.c
index ac1de5418..05f3ed41d 100644
--- a/testcases/network/lib6/asapi_01.c
+++ b/testcases/network/lib6/asapi_01.c
@@ -31,7 +31,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "asapi_01";
 
diff --git a/testcases/network/lib6/asapi_03.c b/testcases/network/lib6/asapi_03.c
index 87d050add..e0985148d 100644
--- a/testcases/network/lib6/asapi_03.c
+++ b/testcases/network/lib6/asapi_03.c
@@ -41,7 +41,7 @@
 #include <arpa/inet.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "tso_safe_macros.h"
 
 char *TCID = "asapi_03";
 
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index ac58c90cc..40018b3ed 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -63,8 +63,8 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include "test.h"
-#include "usctest.h"
-#include "safe_macros.h"
+#include "tso_usctest.h"
+#include "tso_safe_macros.h"
 
 char *TCID;			/* Name of the testcase */
 int TST_TOTAL;			/* Total number of testcases */
diff --git a/utils/sctp/testlib/sctputil.h b/utils/sctp/testlib/sctputil.h
index 176d623f0..c14d7a86e 100644
--- a/utils/sctp/testlib/sctputil.h
+++ b/utils/sctp/testlib/sctputil.h
@@ -50,7 +50,7 @@
 
 #ifdef LTP
 #include <test.h>
-#include <usctest.h>
+#include <tso_usctest.h>
 #endif
 
 #include <string.h>
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
