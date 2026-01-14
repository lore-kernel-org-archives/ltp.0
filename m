Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D12D37E37
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768399513; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=RTDiKq5VPwkLVNCSYA4OMw1B43Q/jjSGpZgtzDrW/iw=;
 b=nLmiQJPTBFT3HCN2A1pivjo3ujN0QdLs++LazWDX1m5cbMTvZv9SpIqclnNfyWcA5FrM9
 uTmmfKzDzYZA3/20jn35St3qPlwa22GdPlDSRD7lvU/Af4yl/PLiPMjWDxdHLpXr97c2YyR
 b38CI96/0OmuQx5ujMURzIf6n5tROsY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77FD43C9B5F
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 15:05:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B882E3C1428
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 15:04:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0CFB8600B2B
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 15:04:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768399477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z07wlCq3eg/h8vZT2RJ5nrFWGSyKxYySjZiI8fzpucs=;
 b=OZUOpcs+04loCd4CCzZem+yeFFiMnuGxbcf47fRbLiKsEx1xxHyB4l23z0pIVjfNsgrGMQ
 WGr6BHpua3zlxmtHSUa4SBV5DbNRVyZqj84ii4pDjz5SQ5Tlx4fLAXMfyxMmnC8spUq3Xc
 l5HKuXMJ8H82NBWu052JvANDNayllMA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-rUjag8l2P2y6aNv0z3hWbw-1; Wed,
 14 Jan 2026 09:04:35 -0500
X-MC-Unique: rUjag8l2P2y6aNv0z3hWbw-1
X-Mimecast-MFC-AGG-ID: rUjag8l2P2y6aNv0z3hWbw_1768399474
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2686C18005B7
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 14:04:34 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.115])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9029218004D8
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 14:04:32 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 14 Jan 2026 22:04:26 +0800
Message-ID: <20260114140426.133180-2-liwang@redhat.com>
In-Reply-To: <20260114140426.133180-1-liwang@redhat.com>
References: <20260114140426.133180-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lrYf2hZVLBJLrXDwoJunPqAoot1-Th8jW8zKaN3c14c_1768399474
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] include/old: rename legacy headers to otst_*
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
extension (etst_*) LTP APIs, legacy header files have been grouped
into the otst_* namespace.

Some legacy header files do not begin with old_, they still belong
to the legacy header file set. For clarity, all legacy header files
are now uniformly grouped into the otst_* namespace.

 include/old/{old_checkpoint.h => otst_checkpoint.h}
 include/old/{ltp_cpuid.h => otst_cpuid.h}
 include/old/{old_device.h => otst_device.h}
 include/old/{tlibio.h => otst_lio.h}
 include/old/{old_module.h => otst_module.h}
 include/old/{ltp_priv.h => otst_priv.h}
 include/old/{random_range.h => otst_random_range.h}
 include/old/{old_resource.h => otst_resource.h}
 include/old/{old_safe_file_ops.h => otst_safe_file_ops.h}
 include/old/{safe_macros.h => otst_safe_macros.h}
 include/old/{old_safe_net.h => otst_safe_net.h}
 include/old/{old_safe_stdio.h => otst_safe_stdio.h}
 include/old/{ltp_signal.h => otst_signal.h}
 include/old/{old_tmpdir.h => otst_tmpdir.h}
 include/old/{usctest.h => otst_usctest.h}

No functional changes intended.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/lapi/rt_sigaction.h                        |  2 +-
 .../old/{old_checkpoint.h => otst_checkpoint.h}    |  6 +++---
 include/old/{ltp_cpuid.h => otst_cpuid.h}          |  0
 include/old/{old_device.h => otst_device.h}        |  6 +++---
 include/old/{tlibio.h => otst_lio.h}               |  0
 include/old/{old_module.h => otst_module.h}        |  0
 include/old/{ltp_priv.h => otst_priv.h}            |  0
 .../old/{random_range.h => otst_random_range.h}    |  0
 include/old/{old_resource.h => otst_resource.h}    |  0
 .../{old_safe_file_ops.h => otst_safe_file_ops.h}  |  0
 include/old/{safe_macros.h => otst_safe_macros.h}  |  4 ++--
 include/old/{old_safe_net.h => otst_safe_net.h}    |  6 +++---
 .../old/{old_safe_stdio.h => otst_safe_stdio.h}    |  6 +++---
 include/old/{ltp_signal.h => otst_signal.h}        |  0
 include/old/{old_tmpdir.h => otst_tmpdir.h}        |  6 +++---
 include/old/{usctest.h => otst_usctest.h}          |  0
 include/old/test.h                                 | 14 +++++++-------
 lib/parse_opts.c                                   |  4 ++--
 lib/random_range.c                                 |  2 +-
 lib/safe_macros.c                                  |  2 +-
 lib/tests/trerrno.c                                |  2 +-
 lib/tests/tst_dataroot01.c                         |  2 +-
 lib/tests/tst_dataroot02.c                         |  2 +-
 lib/tests/tst_dataroot03.c                         |  2 +-
 lib/tests/tst_safe_macros.c                        |  2 +-
 lib/tlibio.c                                       |  4 ++--
 lib/tst_checkpoint.c                               |  2 +-
 lib/tst_cpu.c                                      |  2 +-
 lib/tst_device.c                                   |  2 +-
 lib/tst_dir_is_empty.c                             |  2 +-
 lib/tst_fs_link_count.c                            |  4 ++--
 lib/tst_kernel.c                                   |  2 +-
 lib/tst_mkfs.c                                     |  2 +-
 lib/tst_module.c                                   |  4 ++--
 lib/tst_parse_opts.c                               |  2 +-
 lib/tst_pid.c                                      |  2 +-
 lib/tst_res.c                                      |  6 +++---
 lib/tst_resource.c                                 |  4 ++--
 lib/tst_test.c                                     |  6 +++---
 lib/tst_tmpdir.c                                   |  4 ++--
 lib/tst_virt.c                                     |  2 +-
 .../kernel/controllers/cgroup_xattr/cgroup_xattr.c |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_def_task01.c  |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_def_task02.c  |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_def_task03.c  |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_def_task04.c  |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_test01.c      |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_test02.c      |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_test03.c      |  2 +-
 .../kernel/controllers/cpuctl/cpuctl_test04.c      |  2 +-
 testcases/kernel/device-drivers/acpi/ltp_acpi.c    |  4 ++--
 .../kernel/device-drivers/cpufreq/cpufreq_boost.c  |  2 +-
 .../kernel/device-drivers/pci/tpci_user/tpci.c     |  4 ++--
 testcases/kernel/device-drivers/rtc/rtc01.c        |  2 +-
 .../kernel/device-drivers/tbio/tbio_user/tbio.c    |  4 ++--
 testcases/kernel/device-drivers/uaccess/uaccess.c  |  4 ++--
 testcases/kernel/firmware/fw_load_user/fw_load.c   |  4 ++--
 testcases/kernel/fs/doio/doio.c                    |  2 +-
 testcases/kernel/fs/doio/growfiles.c               |  6 +++---
 testcases/kernel/fs/doio/iogen.c                   |  2 +-
 testcases/kernel/fs/ftest/ftest01.c                |  2 +-
 testcases/kernel/fs/ftest/ftest03.c                |  2 +-
 testcases/kernel/fs/ftest/ftest04.c                |  2 +-
 testcases/kernel/fs/ftest/ftest05.c                |  2 +-
 testcases/kernel/fs/ftest/ftest07.c                |  2 +-
 testcases/kernel/fs/ftest/ftest08.c                |  2 +-
 testcases/kernel/io/direct_io/diotest1.c           |  2 +-
 testcases/kernel/io/direct_io/diotest4.c           |  2 +-
 testcases/kernel/io/direct_io/dma_thread_diotest.c |  2 +-
 testcases/kernel/ipc/pipeio/pipeio.c               |  4 ++--
 testcases/kernel/lib/numa_helper.c                 |  2 +-
 testcases/kernel/mem/vma/vma01.c                   |  2 +-
 testcases/kernel/mem/vma/vma02.c                   |  2 +-
 testcases/kernel/mem/vma/vma03.c                   |  2 +-
 testcases/kernel/mem/vma/vma04.c                   |  2 +-
 testcases/kernel/pty/hangup01.c                    |  2 +-
 .../sched/hyperthreading/ht_affinity/ht_utils.c    |  2 +-
 .../sched/hyperthreading/ht_enabled/ht_utils.c     |  2 +-
 .../kernel/security/filecaps/filecaps_common.h     |  2 +-
 .../security/prot_hsymlinks/prot_hsymlinks.c       |  2 +-
 testcases/kernel/syscalls/clone/clone02.c          |  2 +-
 testcases/kernel/syscalls/connect/connect01.c      |  2 +-
 testcases/kernel/syscalls/fallocate/fallocate01.c  |  2 +-
 testcases/kernel/syscalls/fallocate/fallocate02.c  |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl07.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl11.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl16.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl19.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl20.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl31.c          |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl32.c          |  2 +-
 testcases/kernel/syscalls/fdatasync/fdatasync02.c  |  2 +-
 testcases/kernel/syscalls/fork/fork09.c            |  2 +-
 testcases/kernel/syscalls/fstatat/fstatat01.c      |  2 +-
 testcases/kernel/syscalls/futimesat/futimesat01.c  |  2 +-
 .../syscalls/get_robust_list/get_robust_list01.c   |  2 +-
 testcases/kernel/syscalls/getrusage/getrusage04.c  |  2 +-
 testcases/kernel/syscalls/linkat/linkat01.c        |  2 +-
 testcases/kernel/syscalls/linkat/linkat02.c        |  2 +-
 testcases/kernel/syscalls/listen/listen01.c        |  2 +-
 .../syscalls/migrate_pages/migrate_pages01.c       |  2 +-
 testcases/kernel/syscalls/mincore/mincore01.c      |  2 +-
 testcases/kernel/syscalls/mkdirat/mkdirat01.c      |  2 +-
 testcases/kernel/syscalls/mknodat/mknodat01.c      |  2 +-
 testcases/kernel/syscalls/mknodat/mknodat02.c      |  2 +-
 testcases/kernel/syscalls/mlockall/mlockall02.c    |  2 +-
 testcases/kernel/syscalls/mlockall/mlockall03.c    |  2 +-
 .../kernel/syscalls/move_pages/move_pages11.c      |  2 +-
 testcases/kernel/syscalls/mprotect/mprotect01.c    |  2 +-
 testcases/kernel/syscalls/mprotect/mprotect02.c    |  2 +-
 testcases/kernel/syscalls/mprotect/mprotect03.c    |  2 +-
 testcases/kernel/syscalls/mprotect/mprotect04.c    |  2 +-
 testcases/kernel/syscalls/mremap/mremap01.c        |  2 +-
 testcases/kernel/syscalls/mremap/mremap05.c        |  2 +-
 testcases/kernel/syscalls/msync/msync03.c          |  2 +-
 testcases/kernel/syscalls/openat/openat03.c        |  2 +-
 .../syscalls/perf_event_open/perf_event_open01.c   |  2 +-
 testcases/kernel/syscalls/pipe/pipe04.c            |  2 +-
 testcases/kernel/syscalls/pipe/pipe09.c            |  2 +-
 testcases/kernel/syscalls/ppoll/ppoll01.c          |  2 +-
 testcases/kernel/syscalls/profil/profil01.c        |  2 +-
 testcases/kernel/syscalls/recv/recv01.c            |  2 +-
 testcases/kernel/syscalls/recvfrom/recvfrom01.c    |  2 +-
 .../kernel/syscalls/removexattr/removexattr01.c    |  2 +-
 .../kernel/syscalls/removexattr/removexattr02.c    |  2 +-
 testcases/kernel/syscalls/rename/rename11.c        |  2 +-
 testcases/kernel/syscalls/renameat/renameat01.c    |  2 +-
 testcases/kernel/syscalls/renameat2/renameat201.c  |  2 +-
 testcases/kernel/syscalls/renameat2/renameat202.c  |  2 +-
 .../syscalls/rt_sigprocmask/rt_sigprocmask02.c     |  2 +-
 testcases/kernel/syscalls/send/send01.c            |  2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg01.c      |  2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg02.c      |  2 +-
 testcases/kernel/syscalls/sendto/sendto01.c        |  2 +-
 testcases/kernel/syscalls/setfsuid/setfsuid04.c    |  2 +-
 testcases/kernel/syscalls/setrlimit/setrlimit01.c  |  2 +-
 testcases/kernel/syscalls/signalfd4/signalfd4_01.c |  2 +-
 testcases/kernel/syscalls/signalfd4/signalfd4_02.c |  2 +-
 .../kernel/syscalls/sigpending/sigpending02.c      |  2 +-
 testcases/kernel/syscalls/sigrelse/sigrelse01.c    |  2 +-
 testcases/kernel/syscalls/sockioctl/sockioctl01.c  |  2 +-
 testcases/kernel/syscalls/symlink/symlink03.c      |  2 +-
 testcases/kernel/syscalls/symlinkat/symlinkat01.c  |  2 +-
 testcases/kernel/syscalls/umount2/umount2_01.c     |  2 +-
 testcases/kernel/syscalls/vfork/vfork02.c          |  2 +-
 testcases/lib/tst_device.c                         |  2 +-
 testcases/network/lib6/asapi_01.c                  |  2 +-
 testcases/network/lib6/asapi_03.c                  |  2 +-
 tools/apicmds/ltpapicmd.c                          |  4 ++--
 utils/sctp/testlib/sctputil.h                      |  2 +-
 150 files changed, 177 insertions(+), 177 deletions(-)
 rename include/old/{old_checkpoint.h => otst_checkpoint.h} (95%)
 rename include/old/{ltp_cpuid.h => otst_cpuid.h} (100%)
 rename include/old/{old_device.h => otst_device.h} (97%)
 rename include/old/{tlibio.h => otst_lio.h} (100%)
 rename include/old/{old_module.h => otst_module.h} (100%)
 rename include/old/{ltp_priv.h => otst_priv.h} (100%)
 rename include/old/{random_range.h => otst_random_range.h} (100%)
 rename include/old/{old_resource.h => otst_resource.h} (100%)
 rename include/old/{old_safe_file_ops.h => otst_safe_file_ops.h} (100%)
 rename include/old/{safe_macros.h => otst_safe_macros.h} (99%)
 rename include/old/{old_safe_net.h => otst_safe_net.h} (95%)
 rename include/old/{old_safe_stdio.h => otst_safe_stdio.h} (93%)
 rename include/old/{ltp_signal.h => otst_signal.h} (100%)
 rename include/old/{old_tmpdir.h => otst_tmpdir.h} (96%)
 rename include/old/{usctest.h => otst_usctest.h} (100%)

diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
index a42b690d0..e78b28548 100644
--- a/include/lapi/rt_sigaction.h
+++ b/include/lapi/rt_sigaction.h
@@ -9,7 +9,7 @@
 #ifndef LAPI_RT_SIGACTION_H__
 #define LAPI_RT_SIGACTION_H__
 
-#include "ltp_signal.h"
+#include "otst_signal.h"
 
 #define INVAL_SA_PTR ((void *)-1)
 
diff --git a/include/old/old_checkpoint.h b/include/old/otst_checkpoint.h
similarity index 95%
rename from include/old/old_checkpoint.h
rename to include/old/otst_checkpoint.h
index f91fef9f6..8533bcdba 100644
--- a/include/old/old_checkpoint.h
+++ b/include/old/otst_checkpoint.h
@@ -26,8 +26,8 @@
 
   */
 
-#ifndef OLD_CHECKPOINT__
-#define OLD_CHECKPOINT__
+#ifndef OTST_CHECKPOINT__
+#define OTST_CHECKPOINT__
 
 #include "test.h"
 #include "tst_checkpoint_fn.h"
@@ -48,4 +48,4 @@
         tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1); \
         tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, 0);
 
-#endif /* OLD_CHECKPOINT__ */
+#endif /* OTST_CHECKPOINT__ */
diff --git a/include/old/ltp_cpuid.h b/include/old/otst_cpuid.h
similarity index 100%
rename from include/old/ltp_cpuid.h
rename to include/old/otst_cpuid.h
diff --git a/include/old/old_device.h b/include/old/otst_device.h
similarity index 97%
rename from include/old/old_device.h
rename to include/old/otst_device.h
index a6e9fea86..b666c0fa2 100644
--- a/include/old/old_device.h
+++ b/include/old/otst_device.h
@@ -15,8 +15,8 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef OLD_DEVICE_H__
-#define OLD_DEVICE_H__
+#ifndef OTST_DEVICE_H__
+#define OTST_DEVICE_H__
 
 /*
  * Returns filesystem type to be used for the testing. Unless your test is
@@ -81,4 +81,4 @@ int tst_detach_device(const char *dev);
  */
 int tst_umount(const char *path);
 
-#endif	/* OLD_DEVICE_H__ */
+#endif	/* OTST_DEVICE_H__ */
diff --git a/include/old/tlibio.h b/include/old/otst_lio.h
similarity index 100%
rename from include/old/tlibio.h
rename to include/old/otst_lio.h
diff --git a/include/old/old_module.h b/include/old/otst_module.h
similarity index 100%
rename from include/old/old_module.h
rename to include/old/otst_module.h
diff --git a/include/old/ltp_priv.h b/include/old/otst_priv.h
similarity index 100%
rename from include/old/ltp_priv.h
rename to include/old/otst_priv.h
diff --git a/include/old/random_range.h b/include/old/otst_random_range.h
similarity index 100%
rename from include/old/random_range.h
rename to include/old/otst_random_range.h
diff --git a/include/old/old_resource.h b/include/old/otst_resource.h
similarity index 100%
rename from include/old/old_resource.h
rename to include/old/otst_resource.h
diff --git a/include/old/old_safe_file_ops.h b/include/old/otst_safe_file_ops.h
similarity index 100%
rename from include/old/old_safe_file_ops.h
rename to include/old/otst_safe_file_ops.h
diff --git a/include/old/safe_macros.h b/include/old/otst_safe_macros.h
similarity index 99%
rename from include/old/safe_macros.h
rename to include/old/otst_safe_macros.h
index 307843ab0..afade960b 100644
--- a/include/old/safe_macros.h
+++ b/include/old/otst_safe_macros.h
@@ -17,8 +17,8 @@
 #define __SAFE_MACROS_H__
 
 #include "safe_macros_fn.h"
-#include "old_safe_stdio.h"
-#include "old_safe_net.h"
+#include "otst_safe_stdio.h"
+#include "otst_safe_net.h"
 
 #define SAFE_BASENAME(cleanup_fn, path)	\
 	safe_basename(__FILE__, __LINE__, (cleanup_fn), (path))
diff --git a/include/old/old_safe_net.h b/include/old/otst_safe_net.h
similarity index 95%
rename from include/old/old_safe_net.h
rename to include/old/otst_safe_net.h
index 639094a94..cb18bd763 100644
--- a/include/old/old_safe_net.h
+++ b/include/old/otst_safe_net.h
@@ -16,8 +16,8 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef OLD_SAFE_NET_H__
-#define OLD_SAFE_NET_H__
+#ifndef OTST_SAFE_NET_H__
+#define OTST_SAFE_NET_H__
 
 #include <sys/types.h>
 #include <sys/socket.h>
@@ -47,4 +47,4 @@
 #define TST_GET_UNUSED_PORT(cleanup_fn, family, type) \
 	tst_get_unused_port(__FILE__, __LINE__, (cleanup_fn), family, type)
 
-#endif /* OLD_SAFE_NET_H__ */
+#endif /* OTST_SAFE_NET_H__ */
diff --git a/include/old/old_safe_stdio.h b/include/old/otst_safe_stdio.h
similarity index 93%
rename from include/old/old_safe_stdio.h
rename to include/old/otst_safe_stdio.h
index 3508b2479..a2c5404ef 100644
--- a/include/old/old_safe_stdio.h
+++ b/include/old/otst_safe_stdio.h
@@ -15,8 +15,8 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef OLD_SAFE_STDIO_H__
-#define OLD_SAFE_STDIO_H__
+#ifndef OTST_SAFE_STDIO_H__
+#define OTST_SAFE_STDIO_H__
 
 #include <stdio.h>
 
@@ -34,4 +34,4 @@
 #define SAFE_POPEN(cleanup_fn, command, type) \
 	safe_popen(__FILE__, __LINE__, cleanup_fn, command, type)
 
-#endif /* OLD_SAFE_STDIO_H__ */
+#endif /* OTST_SAFE_STDIO_H__ */
diff --git a/include/old/ltp_signal.h b/include/old/otst_signal.h
similarity index 100%
rename from include/old/ltp_signal.h
rename to include/old/otst_signal.h
diff --git a/include/old/old_tmpdir.h b/include/old/otst_tmpdir.h
similarity index 96%
rename from include/old/old_tmpdir.h
rename to include/old/otst_tmpdir.h
index 3e33bf043..7c42f6242 100644
--- a/include/old/old_tmpdir.h
+++ b/include/old/otst_tmpdir.h
@@ -15,8 +15,8 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef OLD_TMPDIR_H__
-#define OLD_TMPDIR_H__
+#ifndef OTST_TMPDIR_H__
+#define OTST_TMPDIR_H__
 
 /*
  * Create a unique temporary directory and chdir() to it. It expects the caller
@@ -58,4 +58,4 @@ int tst_tmpdir_created(void);
 /* declared in tst_tmpdir.c */
 const char *tst_get_startwd(void);
 
-#endif	/* OLD_TMPDIR_H__ */
+#endif	/* OTST_TMPDIR_H__ */
diff --git a/include/old/usctest.h b/include/old/otst_usctest.h
similarity index 100%
rename from include/old/usctest.h
rename to include/old/otst_usctest.h
diff --git a/include/old/test.h b/include/old/test.h
index 306868fb5..3125d19af 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -18,21 +18,21 @@
 #include <stdlib.h>
 #include <stdint.h>
 
-#include "usctest.h"
+#include "otst_usctest.h"
 
 #include "tst_common.h"
-#include "old_safe_file_ops.h"
-#include "old_checkpoint.h"
+#include "otst_safe_file_ops.h"
+#include "otst_checkpoint.h"
 #include "tst_process_state.h"
-#include "old_resource.h"
+#include "otst_resource.h"
 #include "tst_res_flags.h"
 #include "tst_kvercmp.h"
 #include "tst_fs.h"
 #include "tst_pid.h"
 #include "tst_cmd.h"
 #include "tst_cpu.h"
-#include "old_device.h"
-#include "old_tmpdir.h"
+#include "otst_device.h"
+#include "otst_tmpdir.h"
 #include "tst_minmax.h"
 #include "tst_get_bad_addr.h"
 #include "tst_path_has_mnt_flags.h"
@@ -116,7 +116,7 @@ void tst_brkm__(const char *file, const int lineno, int ttype,
 	__attribute__ ((format (printf, 5, 6))) LTP_ATTRIBUTE_NORETURN;
 
 #ifdef LTPLIB
-# include "ltp_priv.h"
+# include "otst_priv.h"
 # define tst_brkm(flags, cleanup, fmt, ...) do { \
 	if (tst_test) \
 		tst_brk_(__FILE__, __LINE__, flags, fmt, ##__VA_ARGS__); \
diff --git a/lib/parse_opts.c b/lib/parse_opts.c
index 03e833312..90e64df3e 100644
--- a/lib/parse_opts.c
+++ b/lib/parse_opts.c
@@ -43,8 +43,8 @@
 #include <stdint.h>
 
 #include "test.h"
-#include "ltp_priv.h"
-#include "usctest.h"
+#include "otst_priv.h"
+#include "otst_usctest.h"
 #include "tst_clocks.h"
 
 #ifndef UNIT_TEST
diff --git a/lib/random_range.c b/lib/random_range.c
index 4c96fd913..2cb6d0a77 100644
--- a/lib/random_range.c
+++ b/lib/random_range.c
@@ -33,7 +33,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <malloc.h>
-#include "random_range.h"
+#include "otst_random_range.h"
 
 /*
  * Internal format of the range array set up by parse_range()
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index a3145b8d6..6bef3a5e3 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -23,7 +23,7 @@
 #include <math.h>
 #include "lapi/fcntl.h"
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *safe_basename(const char *file, const int lineno,
 		    void (*cleanup_fn) (void), char *path)
diff --git a/lib/tests/trerrno.c b/lib/tests/trerrno.c
index a160874de..03b22708d 100644
--- a/lib/tests/trerrno.c
+++ b/lib/tests/trerrno.c
@@ -21,7 +21,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define OUTPUT_FNAME "output"
 
diff --git a/lib/tests/tst_dataroot01.c b/lib/tests/tst_dataroot01.c
index fab8bfea2..b57be76d1 100644
--- a/lib/tests/tst_dataroot01.c
+++ b/lib/tests/tst_dataroot01.c
@@ -21,7 +21,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define OUTPUT_FNAME "output"
 #define LTPROOT "/opt/ltp"
diff --git a/lib/tests/tst_dataroot02.c b/lib/tests/tst_dataroot02.c
index b936b57f4..ac369e646 100644
--- a/lib/tests/tst_dataroot02.c
+++ b/lib/tests/tst_dataroot02.c
@@ -21,7 +21,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define OUTPUT_FNAME "output"
 #define LTPROOT "/opt/ltp"
diff --git a/lib/tests/tst_dataroot03.c b/lib/tests/tst_dataroot03.c
index cf5a04ec6..020564d07 100644
--- a/lib/tests/tst_dataroot03.c
+++ b/lib/tests/tst_dataroot03.c
@@ -21,7 +21,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define OUTPUT_FNAME "output"
 #define LTPROOT "/opt/ltp"
diff --git a/lib/tests/tst_safe_macros.c b/lib/tests/tst_safe_macros.c
index 5c427ee16..9e04fc658 100644
--- a/lib/tests/tst_safe_macros.c
+++ b/lib/tests/tst_safe_macros.c
@@ -1,5 +1,5 @@
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "test_safe_macros";
 int TST_TOTAL = 1;
diff --git a/lib/tlibio.c b/lib/tlibio.c
index 70e0c6f7d..df7f8c23b 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -93,8 +93,8 @@
 #endif
 #include <stdlib.h>		/* atoi, abs */
 
-#include "tlibio.h"		/* defines LIO* macros */
-#include "random_range.h"
+#include "otst_lio.h"		/* defines LIO* macros */
+#include "otst_random_range.h"
 
 #ifndef PATH_MAX
 #define PATH_MAX	MAXPATHLEN
diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 9f803e3ef..eecb768db 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -10,7 +10,7 @@
 #include <sys/syscall.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/futex.h"
 
 #define DEFAULT_MSEC_TIMEOUT 10000
diff --git a/lib/tst_cpu.c b/lib/tst_cpu.c
index b4c7c2f81..22c9de257 100644
--- a/lib/tst_cpu.c
+++ b/lib/tst_cpu.c
@@ -22,7 +22,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 long tst_ncpus(void)
 {
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 85f5f8cac..9c84131ff 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -21,7 +21,7 @@
 #include <sys/statfs.h>
 #include "lapi/syscalls.h"
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "tst_device.h"
 
 #ifndef LOOP_CTL_GET_FREE
diff --git a/lib/tst_dir_is_empty.c b/lib/tst_dir_is_empty.c
index 43764eeba..4def7c54d 100644
--- a/lib/tst_dir_is_empty.c
+++ b/lib/tst_dir_is_empty.c
@@ -23,7 +23,7 @@
 #include <dirent.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 int tst_dir_is_empty_(void (cleanup_fn)(void), const char *name, int verbose)
 {
diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
index 6a6bb52b2..950e9a401 100644
--- a/lib/tst_fs_link_count.c
+++ b/lib/tst_fs_link_count.c
@@ -22,8 +22,8 @@
 #include <unistd.h>
 
 #include "test.h"
-#include "usctest.h"
-#include "safe_macros.h"
+#include "otst_usctest.h"
+#include "otst_safe_macros.h"
 
 #define MAX_SANE_HARD_LINKS	65535
 
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 9ab02e5d3..4d7f11f89 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -24,7 +24,7 @@
 
 #include "test.h"
 #include "tst_kernel.h"
-#include "old_safe_stdio.h"
+#include "otst_safe_stdio.h"
 #include "lapi/abisize.h"
 
 static int get_kernel_bits_from_uname(struct utsname *buf)
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 19d995df2..6eb892d11 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -16,7 +16,7 @@
  */
 
 #include "test.h"
-#include "ltp_priv.h"
+#include "otst_priv.h"
 #include "tst_mkfs.h"
 #include "tst_device.h"
 
diff --git a/lib/tst_module.c b/lib/tst_module.c
index 42d63ede6..b0db79cff 100644
--- a/lib/tst_module.c
+++ b/lib/tst_module.c
@@ -28,8 +28,8 @@
 
 #include "test.h"
 #include "tst_kconfig.h"
-#include "ltp_priv.h"
-#include "old_module.h"
+#include "otst_priv.h"
+#include "otst_module.h"
 
 void tst_module_exists_(void (cleanup_fn)(void),
 	const char *mod_name, char **mod_path)
diff --git a/lib/tst_parse_opts.c b/lib/tst_parse_opts.c
index 94970e1a8..ae2d2c1eb 100644
--- a/lib/tst_parse_opts.c
+++ b/lib/tst_parse_opts.c
@@ -22,7 +22,7 @@
  */
 
 #include "test.h"
-#include "ltp_priv.h"
+#include "otst_priv.h"
 
 void tst_parse_opts(int argc, char *argv[], const option_t *user_optarg,
                     void (*user_help)(void))
diff --git a/lib/tst_pid.c b/lib/tst_pid.c
index 4e9dc7a52..e4ed4b680 100644
--- a/lib/tst_pid.c
+++ b/lib/tst_pid.c
@@ -28,7 +28,7 @@
 #include <unistd.h>
 #include "test.h"
 #include "tst_pid.h"
-#include "old_safe_file_ops.h"
+#include "otst_safe_file_ops.h"
 #include "tst_safe_macros.h"
 #include "lapi/syscalls.h"
 
diff --git a/lib/tst_res.c b/lib/tst_res.c
index f50c07271..5ec4ebfae 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -48,9 +48,9 @@
 #include <sys/wait.h>
 
 #include "test.h"
-#include "safe_macros.h"
-#include "usctest.h"
-#include "ltp_priv.h"
+#include "otst_safe_macros.h"
+#include "otst_usctest.h"
+#include "otst_priv.h"
 #include "tst_ansi_color.h"
 
 long TEST_RETURN;
diff --git a/lib/tst_resource.c b/lib/tst_resource.c
index c35d05a25..4df6d3f49 100644
--- a/lib/tst_resource.c
+++ b/lib/tst_resource.c
@@ -23,8 +23,8 @@
 
 #include <pthread.h>
 #include "test.h"
-#include "old_resource.h"
-#include "ltp_priv.h"
+#include "otst_resource.h"
+#include "otst_priv.h"
 
 #ifndef PATH_MAX
 #ifdef MAXPATHLEN
diff --git a/lib/tst_test.c b/lib/tst_test.c
index e115ce689..d2bf3ac70 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -34,9 +34,9 @@
 #include "tst_sys_conf.h"
 #include "tst_kconfig.h"
 #include "tst_private.h"
-#include "old_resource.h"
-#include "old_device.h"
-#include "old_tmpdir.h"
+#include "otst_resource.h"
+#include "otst_device.h"
+#include "otst_tmpdir.h"
 #include "ltp-version.h"
 #include "tst_hugepage.h"
 
diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 6ed2367b9..768297f1c 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -72,9 +72,9 @@
 
 #include "test.h"
 #include "tst_buffers.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "tst_tmpdir.h"
-#include "ltp_priv.h"
+#include "otst_priv.h"
 #include "lapi/futex.h"
 
 /*
diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index 0fda20a17..a37db9d84 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -24,7 +24,7 @@
 
 #include <unistd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 static int is_kvm(void)
 {
diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
index 2c080933e..911843037 100644
--- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -36,7 +36,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "cgroup_xattr";
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
index 4856f3372..f961d6eb9 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
@@ -57,7 +57,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #ifdef DEBUG
 #define dbg(x...)	printf(x);
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
index 3c19a7719..4790ee20d 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
@@ -60,7 +60,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
index 63aec0d2a..51e796450 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
@@ -61,7 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
index 9a56d7b49..bf161cc72 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
@@ -61,7 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define TIME_INTERVAL	100	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
index 9370f7eb8..62ec59504 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
@@ -62,7 +62,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
index a9b90d6b6..2332ca6a5 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
@@ -61,7 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
index a81370085..38290d805 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
@@ -61,7 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
index d166aa4d3..719413300 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
@@ -61,7 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define TIME_INTERVAL	100	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi.c b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
index 2c0cc562b..fa7b2c9f3 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi.c
@@ -22,8 +22,8 @@
 #include <stdlib.h>
 
 #include "test.h"
-#include "old_module.h"
-#include "safe_macros.h"
+#include "otst_module.h"
+#include "otst_safe_macros.h"
 
 #include "ltp_acpi.h"
 
diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
index 645c4326a..50ce18721 100644
--- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
+++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
@@ -34,7 +34,7 @@
 
 #include "test.h"
 #include "lapi/posix_clocks.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "cpufreq_boost";
 
diff --git a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
index 5d241fb42..e82ee4c8d 100644
--- a/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
+++ b/testcases/kernel/device-drivers/pci/tpci_user/tpci.c
@@ -27,8 +27,8 @@
 #include <errno.h>
 
 #include "test.h"
-#include "safe_macros.h"
-#include "old_module.h"
+#include "otst_safe_macros.h"
+#include "otst_module.h"
 
 #include "../tpci_kernel/tpci.h"
 
diff --git a/testcases/kernel/device-drivers/rtc/rtc01.c b/testcases/kernel/device-drivers/rtc/rtc01.c
index 8a1f62ead..ba675493f 100644
--- a/testcases/kernel/device-drivers/rtc/rtc01.c
+++ b/testcases/kernel/device-drivers/rtc/rtc01.c
@@ -33,7 +33,7 @@
 #include <time.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 int rtc_fd = -1;
 char *TCID = "rtc01";
diff --git a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
index e882dc768..8488417ed 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
+++ b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
@@ -53,8 +53,8 @@
 #include <string.h>
 
 #include "test.h"
-#include "safe_macros.h"
-#include "old_module.h"
+#include "otst_safe_macros.h"
+#include "otst_module.h"
 
 #include "../tbio_kernel/tbio.h"
 
diff --git a/testcases/kernel/device-drivers/uaccess/uaccess.c b/testcases/kernel/device-drivers/uaccess/uaccess.c
index f337aba64..2f0afe903 100644
--- a/testcases/kernel/device-drivers/uaccess/uaccess.c
+++ b/testcases/kernel/device-drivers/uaccess/uaccess.c
@@ -27,8 +27,8 @@
 #include <unistd.h>
 
 #include "test.h"
-#include "old_module.h"
-#include "safe_macros.h"
+#include "otst_module.h"
+#include "otst_safe_macros.h"
 #include "tst_security.h"
 
 #include "ltp_uaccess.h"
diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
index f5b918a69..67683e388 100644
--- a/testcases/kernel/firmware/fw_load_user/fw_load.c
+++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
@@ -30,8 +30,8 @@
 
 #include "test.h"
 #include "tst_security.h"
-#include "safe_macros.h"
-#include "old_module.h"
+#include "otst_safe_macros.h"
+#include "otst_module.h"
 
 /* number of test firmware files */
 #define FW_FILES	5
diff --git a/testcases/kernel/fs/doio/doio.c b/testcases/kernel/fs/doio/doio.c
index b170f6670..26ae1340f 100644
--- a/testcases/kernel/fs/doio/doio.c
+++ b/testcases/kernel/fs/doio/doio.c
@@ -84,7 +84,7 @@
 
 #include "doio.h"
 #include "write_log.h"
-#include "random_range.h"
+#include "otst_random_range.h"
 #include "string_to_tokens.h"
 #include "pattern.h"
 
diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
index 7bf51fb9c..2e0e7ba0b 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -85,7 +85,7 @@
 #include <string.h>
 #include <inttypes.h>
 #include "dataascii.h"
-#include "random_range.h"
+#include "otst_random_range.h"
 #include "databin.h"
 #include "open_flags.h"
 #include "forker.h"
@@ -145,7 +145,7 @@ void myexit(int x)
 			/* Once it is proven tlibio.c functions work properly, */
 			/* only tlibio.c functions will be used */
 #else
-#include "tlibio.h"
+#include "otst_lio.h"
 #endif
 
 #ifndef PATH_MAX
@@ -589,7 +589,7 @@ int main(int argc, char **argv)
 					Progname, TagName);
 				exit(1);
 			}
-			if (io_type == 99)	/* hold-over until tlibio.h */
+			if (io_type == 99)	/* hold-over until otst_lio.h */
 				using_random++;
 #endif
 			break;
diff --git a/testcases/kernel/fs/doio/iogen.c b/testcases/kernel/fs/doio/iogen.c
index 765cfdae5..763703498 100644
--- a/testcases/kernel/fs/doio/iogen.c
+++ b/testcases/kernel/fs/doio/iogen.c
@@ -64,7 +64,7 @@
 #include "bytes_by_prefix.h"
 #include "string_to_tokens.h"
 #include "open_flags.h"
-#include "random_range.h"
+#include "otst_random_range.h"
 
 #ifndef PATH_MAX
 #define	PATH_MAX 512		/* ??? */
diff --git a/testcases/kernel/fs/ftest/ftest01.c b/testcases/kernel/fs/ftest/ftest01.c
index 31203d689..c5a24f767 100644
--- a/testcases/kernel/fs/ftest/ftest01.c
+++ b/testcases/kernel/fs/ftest/ftest01.c
@@ -59,7 +59,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest01";
diff --git a/testcases/kernel/fs/ftest/ftest03.c b/testcases/kernel/fs/ftest/ftest03.c
index ed69e5736..f9f225755 100644
--- a/testcases/kernel/fs/ftest/ftest03.c
+++ b/testcases/kernel/fs/ftest/ftest03.c
@@ -64,7 +64,7 @@
 #include <stdio.h>
 #include <inttypes.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest03";
diff --git a/testcases/kernel/fs/ftest/ftest04.c b/testcases/kernel/fs/ftest/ftest04.c
index 8eed84c74..fb3d9f210 100644
--- a/testcases/kernel/fs/ftest/ftest04.c
+++ b/testcases/kernel/fs/ftest/ftest04.c
@@ -48,7 +48,7 @@
 #include <errno.h>
 #include <signal.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest04";
diff --git a/testcases/kernel/fs/ftest/ftest05.c b/testcases/kernel/fs/ftest/ftest05.c
index 8d8e6d497..93b256562 100644
--- a/testcases/kernel/fs/ftest/ftest05.c
+++ b/testcases/kernel/fs/ftest/ftest05.c
@@ -63,7 +63,7 @@
 #include <inttypes.h>
 #include <sys/param.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest05";
diff --git a/testcases/kernel/fs/ftest/ftest07.c b/testcases/kernel/fs/ftest/ftest07.c
index 3b5b2a419..851670a7a 100644
--- a/testcases/kernel/fs/ftest/ftest07.c
+++ b/testcases/kernel/fs/ftest/ftest07.c
@@ -70,7 +70,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest07";
diff --git a/testcases/kernel/fs/ftest/ftest08.c b/testcases/kernel/fs/ftest/ftest08.c
index e7fb56fe4..b5602cdab 100644
--- a/testcases/kernel/fs/ftest/ftest08.c
+++ b/testcases/kernel/fs/ftest/ftest08.c
@@ -55,7 +55,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest08";
diff --git a/testcases/kernel/io/direct_io/diotest1.c b/testcases/kernel/io/direct_io/diotest1.c
index 03a054b4c..8f0f889a5 100644
--- a/testcases/kernel/io/direct_io/diotest1.c
+++ b/testcases/kernel/io/direct_io/diotest1.c
@@ -40,7 +40,7 @@
 #include "diotest_routines.h"
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "diotest01";	/* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test conditions */
diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index ad00fa3e0..077a321f9 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -68,7 +68,7 @@
 #include "diotest_routines.h"
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/mmap.h"
 
 char *TCID = "diotest4";	/* Test program identifier.    */
diff --git a/testcases/kernel/io/direct_io/dma_thread_diotest.c b/testcases/kernel/io/direct_io/dma_thread_diotest.c
index c317eba8e..5568c0657 100644
--- a/testcases/kernel/io/direct_io/dma_thread_diotest.c
+++ b/testcases/kernel/io/direct_io/dma_thread_diotest.c
@@ -103,7 +103,7 @@
 #include <sys/mount.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define FILESIZE	(12*1024*1024)
 #define READSIZE	(1024*1024)
diff --git a/testcases/kernel/ipc/pipeio/pipeio.c b/testcases/kernel/ipc/pipeio/pipeio.c
index ab5c2cf06..8a08c3599 100644
--- a/testcases/kernel/ipc/pipeio/pipeio.c
+++ b/testcases/kernel/ipc/pipeio/pipeio.c
@@ -48,10 +48,10 @@
 #include <signal.h>
 #include <sys/stat.h>
 
-#include "tlibio.h"
+#include "otst_lio.h"
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/sem.h"
 
 char *TCID = "pipeio";
diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index 2eee8d35d..26b6e166f 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -32,7 +32,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "numa_helper.h"
 #include "lapi/syscalls.h"
 
diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
index d220b636c..624778d4e 100644
--- a/testcases/kernel/mem/vma/vma01.c
+++ b/testcases/kernel/mem/vma/vma01.c
@@ -51,7 +51,7 @@
 #include <string.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define MAPS_FILE "/proc/self/maps"
 
diff --git a/testcases/kernel/mem/vma/vma02.c b/testcases/kernel/mem/vma/vma02.c
index 2b99f8dec..d770cba91 100644
--- a/testcases/kernel/mem/vma/vma02.c
+++ b/testcases/kernel/mem/vma/vma02.c
@@ -43,7 +43,7 @@
 #include <unistd.h>
 #include <limits.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "numa_helper.h"
 
 char *TCID = "vma02";
diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
index 65884d9d9..af36edb2f 100644
--- a/testcases/kernel/mem/vma/vma03.c
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -49,7 +49,7 @@
 #include <unistd.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "tst_kernel.h"
 #include "lapi/abisize.h"
 
diff --git a/testcases/kernel/mem/vma/vma04.c b/testcases/kernel/mem/vma/vma04.c
index 24ccd9d6b..952a3f8a7 100644
--- a/testcases/kernel/mem/vma/vma04.c
+++ b/testcases/kernel/mem/vma/vma04.c
@@ -47,7 +47,7 @@
 #include <unistd.h>
 #include <limits.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "numa_helper.h"
 
 char *TCID = "vma04";
diff --git a/testcases/kernel/pty/hangup01.c b/testcases/kernel/pty/hangup01.c
index a71b4b44b..754120164 100644
--- a/testcases/kernel/pty/hangup01.c
+++ b/testcases/kernel/pty/hangup01.c
@@ -32,7 +32,7 @@
 
 /** LTP Port **/
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "hangup01";	/* Test program identifier.    */
 int TST_TOTAL = 5;		/* Total number of test cases. */
diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c
index 18f0862cb..0e6279e34 100644
--- a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c
+++ b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.c
@@ -6,7 +6,7 @@
 #include <alloca.h>
 #include <string.h>
 #include <linux/unistd.h>
-#include "ltp_cpuid.h"
+#include "otst_cpuid.h"
 
 #define PROC_PATH	"/proc"
 #define BUFF_SIZE	8192
diff --git a/testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.c b/testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.c
index 7644e352c..824c4c5f5 100644
--- a/testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.c
+++ b/testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.c
@@ -6,7 +6,7 @@
 #include <alloca.h>
 #include <string.h>
 #include <linux/unistd.h>
-#include "ltp_cpuid.h"
+#include "otst_cpuid.h"
 
 #define PROC_PATH	"/proc"
 #define BUFF_SIZE	8192
diff --git a/testcases/kernel/security/filecaps/filecaps_common.h b/testcases/kernel/security/filecaps/filecaps_common.h
index 0f011868e..94a279c38 100644
--- a/testcases/kernel/security/filecaps/filecaps_common.h
+++ b/testcases/kernel/security/filecaps/filecaps_common.h
@@ -1,6 +1,6 @@
 #include <limits.h>
 #include <stdlib.h>
-#include <old_tmpdir.h>
+#include <otst_tmpdir.h>
 
 static char *fifofile;
 
diff --git a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
index 20f33527c..3f18aed5a 100644
--- a/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
+++ b/testcases/kernel/security/prot_hsymlinks/prot_hsymlinks.c
@@ -43,7 +43,7 @@
 #include <signal.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "prot_hsymlinks";
 int TST_TOTAL = 396;
diff --git a/testcases/kernel/syscalls/clone/clone02.c b/testcases/kernel/syscalls/clone/clone02.c
index fd3ee1aed..883951a68 100644
--- a/testcases/kernel/syscalls/clone/clone02.c
+++ b/testcases/kernel/syscalls/clone/clone02.c
@@ -58,7 +58,7 @@
 #include <sys/syscall.h>
 #include <sched.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "tst_clone.h"
 
 #define FLAG_ALL (CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|SIGCHLD)
diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 660c4f7a9..e8b4a34c7 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -53,7 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "connect01";
 int testno;
diff --git a/testcases/kernel/syscalls/fallocate/fallocate01.c b/testcases/kernel/syscalls/fallocate/fallocate01.c
index 383796c90..8e9207e2d 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate01.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate01.c
@@ -99,7 +99,7 @@
 #include <sys/utsname.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/fallocate.h"
 #include "lapi/fcntl.h"
 
diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
index bb719d78f..d62a39f4b 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate02.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
@@ -39,7 +39,7 @@
 #include <limits.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/fallocate.h"
 #include "lapi/abisize.h"
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl07.c b/testcases/kernel/syscalls/fcntl/fcntl07.c
index 10d1186fc..bc9eee901 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl07.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl07.c
@@ -51,7 +51,7 @@
 #include <limits.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 static void setup(void);
 static void cleanup(void);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl11.c b/testcases/kernel/syscalls/fcntl/fcntl11.c
index 4fd9fcca9..f0a00d27e 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl11.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl11.c
@@ -45,7 +45,7 @@
 #include <sys/wait.h>
 #include <inttypes.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define STRINGSIZE	27
 #define STRING		"abcdefghijklmnopqrstuvwxyz\n"
diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
index 4ae9e6e7a..3c9602c41 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl16.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
@@ -46,7 +46,7 @@
 #include <signal.h>
 #include <errno.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
diff --git a/testcases/kernel/syscalls/fcntl/fcntl19.c b/testcases/kernel/syscalls/fcntl/fcntl19.c
index a58e921c3..4a4df507c 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl19.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl19.c
@@ -49,7 +49,7 @@
 #include <inttypes.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define STRINGSIZE	27
 #define STRING		"abcdefghijklmnopqrstuvwxyz\n"
diff --git a/testcases/kernel/syscalls/fcntl/fcntl20.c b/testcases/kernel/syscalls/fcntl/fcntl20.c
index f271eeb2d..241e9843f 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl20.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl20.c
@@ -45,7 +45,7 @@
 #include <sys/wait.h>
 #include <inttypes.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define STRINGSIZE	27
 #define STRING		"abcdefghijklmnopqrstuvwxyz\n"
diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
index f5c4f8398..3a1e45795 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl31.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
@@ -35,7 +35,7 @@
 #include "test.h"
 #include "config.h"
 #include "lapi/syscalls.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/fcntl.h"
 
 static void setup(void);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl32.c b/testcases/kernel/syscalls/fcntl/fcntl32.c
index f567acc70..cc6c2a9a6 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl32.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl32.c
@@ -24,7 +24,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 static void setup(void);
 static void verify_fcntl(int);
diff --git a/testcases/kernel/syscalls/fdatasync/fdatasync02.c b/testcases/kernel/syscalls/fdatasync/fdatasync02.c
index 9ce4fc7bb..996e72dbc 100644
--- a/testcases/kernel/syscalls/fdatasync/fdatasync02.c
+++ b/testcases/kernel/syscalls/fdatasync/fdatasync02.c
@@ -76,7 +76,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define EXP_RET_VAL	-1
 #define SPL_FILE	"/dev/null"
diff --git a/testcases/kernel/syscalls/fork/fork09.c b/testcases/kernel/syscalls/fork/fork09.c
index 32bad89b3..4a36a7713 100644
--- a/testcases/kernel/syscalls/fork/fork09.c
+++ b/testcases/kernel/syscalls/fork/fork09.c
@@ -47,7 +47,7 @@
 #include <errno.h>
 #include <unistd.h>		/* for _SC_OPEN_MAX */
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "fork09";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/fstatat/fstatat01.c b/testcases/kernel/syscalls/fstatat/fstatat01.c
index c18ffacf2..c7556d248 100644
--- a/testcases/kernel/syscalls/fstatat/fstatat01.c
+++ b/testcases/kernel/syscalls/fstatat/fstatat01.c
@@ -34,7 +34,7 @@
 #include <signal.h>
 #include "config.h"
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/syscalls.h"
 
 #define TEST_CASES 6
diff --git a/testcases/kernel/syscalls/futimesat/futimesat01.c b/testcases/kernel/syscalls/futimesat/futimesat01.c
index 46bd57c48..d2c9272bb 100644
--- a/testcases/kernel/syscalls/futimesat/futimesat01.c
+++ b/testcases/kernel/syscalls/futimesat/futimesat01.c
@@ -33,7 +33,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/syscalls.h"
 
 #define TEST_CASES 5
diff --git a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
index 1ff37bc9b..c59ea556c 100644
--- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
+++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
@@ -51,7 +51,7 @@
 #include <stdlib.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/syscalls.h"
 
 char *TCID = "get_robust_list01";
diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
index f18343c2c..24c704e66 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -50,7 +50,7 @@
 #include <time.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/posix_clocks.h"
 
 char *TCID = "getrusage04";
diff --git a/testcases/kernel/syscalls/linkat/linkat01.c b/testcases/kernel/syscalls/linkat/linkat01.c
index 57cfbcfc6..8b1ef2532 100644
--- a/testcases/kernel/syscalls/linkat/linkat01.c
+++ b/testcases/kernel/syscalls/linkat/linkat01.c
@@ -57,7 +57,7 @@
 #include <limits.h>
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #ifndef AT_FDCWD
 #define AT_FDCWD -100
diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
index 47383acec..8a7486d02 100644
--- a/testcases/kernel/syscalls/linkat/linkat02.c
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -31,7 +31,7 @@
 
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/fcntl.h"
 
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
diff --git a/testcases/kernel/syscalls/listen/listen01.c b/testcases/kernel/syscalls/listen/listen01.c
index d33f209c3..3f5986b2e 100644
--- a/testcases/kernel/syscalls/listen/listen01.c
+++ b/testcases/kernel/syscalls/listen/listen01.c
@@ -53,7 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "listen01";
 int testno;
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 198ba3813..fc0723400 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -37,7 +37,7 @@
 #include <pwd.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/syscalls.h"
 #include "numa_helper.h"
 #include "migrate_pages_common.h"
diff --git a/testcases/kernel/syscalls/mincore/mincore01.c b/testcases/kernel/syscalls/mincore/mincore01.c
index 03ec3b4e6..f0ece8776 100644
--- a/testcases/kernel/syscalls/mincore/mincore01.c
+++ b/testcases/kernel/syscalls/mincore/mincore01.c
@@ -43,7 +43,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 static int pagesize;
 static rlim_t STACK_LIMIT = 10485760;
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat01.c b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
index ca536bdab..3158b9cb1 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat01.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat01.c
@@ -35,7 +35,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 static void setup(void);
 static void cleanup(void);
diff --git a/testcases/kernel/syscalls/mknodat/mknodat01.c b/testcases/kernel/syscalls/mknodat/mknodat01.c
index 3be0a4f87..0b0b3a5d9 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat01.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat01.c
@@ -33,7 +33,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/fcntl.h"
 
 #define PATHNAME "mknodattestdir"
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
index fdac5db15..f0e200b3c 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat02.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -35,7 +35,7 @@
 #include <sys/mount.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/fcntl.h"
 #include "lapi/syscalls.h"
 
diff --git a/testcases/kernel/syscalls/mlockall/mlockall02.c b/testcases/kernel/syscalls/mlockall/mlockall02.c
index 6524cb4a8..01807af17 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall02.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall02.c
@@ -77,7 +77,7 @@
 #include <pwd.h>
 #include <sys/mman.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include <sys/resource.h>
 
 void setup();
diff --git a/testcases/kernel/syscalls/mlockall/mlockall03.c b/testcases/kernel/syscalls/mlockall/mlockall03.c
index a505891fc..bebfcf313 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall03.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall03.c
@@ -79,7 +79,7 @@
 #include <ctype.h>
 #include <sys/mman.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include <sys/resource.h>
 #include <sys/utsname.h>
 
diff --git a/testcases/kernel/syscalls/move_pages/move_pages11.c b/testcases/kernel/syscalls/move_pages/move_pages11.c
index dec930b0e..edfc43e0d 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages11.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages11.c
@@ -59,7 +59,7 @@
 #include <errno.h>
 #include <pwd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "move_pages_support.h"
 
 #define TEST_PAGES 2
diff --git a/testcases/kernel/syscalls/mprotect/mprotect01.c b/testcases/kernel/syscalls/mprotect/mprotect01.c
index aa4685258..82c6880ea 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect01.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect01.c
@@ -44,7 +44,7 @@
 #include <unistd.h>
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "mprotect01";
 int TST_TOTAL = 3;
diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
index de894868f..34a12a795 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect02.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
@@ -41,7 +41,7 @@
 #include <stdlib.h>
 #include "test.h"
 
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 static void sighandler(int sig);
 static void cleanup(void);
diff --git a/testcases/kernel/syscalls/mprotect/mprotect03.c b/testcases/kernel/syscalls/mprotect/mprotect03.c
index 8ef64f212..f17f38786 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect03.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect03.c
@@ -46,7 +46,7 @@
 #include <sys/wait.h>
 #include "test.h"
 
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #ifndef PAGESIZE
 #define PAGESIZE 4096
diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
index 6c7f6bd01..af13f1aa4 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect04.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
@@ -37,7 +37,7 @@
 #include <stdlib.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 static void sighandler(int sig);
 
diff --git a/testcases/kernel/syscalls/mremap/mremap01.c b/testcases/kernel/syscalls/mremap/mremap01.c
index 4c795fee5..1d40fa76f 100644
--- a/testcases/kernel/syscalls/mremap/mremap01.c
+++ b/testcases/kernel/syscalls/mremap/mremap01.c
@@ -82,7 +82,7 @@
 #include <fcntl.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define TEMPFILE	"mremapfile"
 
diff --git a/testcases/kernel/syscalls/mremap/mremap05.c b/testcases/kernel/syscalls/mremap/mremap05.c
index d85ebb068..6b1164346 100644
--- a/testcases/kernel/syscalls/mremap/mremap05.c
+++ b/testcases/kernel/syscalls/mremap/mremap05.c
@@ -41,7 +41,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "mremap05";
 
diff --git a/testcases/kernel/syscalls/msync/msync03.c b/testcases/kernel/syscalls/msync/msync03.c
index f79458b9b..fd0786e11 100644
--- a/testcases/kernel/syscalls/msync/msync03.c
+++ b/testcases/kernel/syscalls/msync/msync03.c
@@ -44,7 +44,7 @@
 #include <sys/resource.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define INV_SYNC	-1
 #define TEMPFILE	"msync_file"
diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
index 90bcff5d7..29baaabf6 100644
--- a/testcases/kernel/syscalls/openat/openat03.c
+++ b/testcases/kernel/syscalls/openat/openat03.c
@@ -25,7 +25,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/fcntl.h"
 #include "openat.h"
 
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
index 86a134b51..39b63d2f9 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
@@ -43,7 +43,7 @@
 
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "perf_event_open01";
 
diff --git a/testcases/kernel/syscalls/pipe/pipe04.c b/testcases/kernel/syscalls/pipe/pipe04.c
index 219daecd8..624a45930 100644
--- a/testcases/kernel/syscalls/pipe/pipe04.c
+++ b/testcases/kernel/syscalls/pipe/pipe04.c
@@ -49,7 +49,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "pipe04";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/pipe/pipe09.c b/testcases/kernel/syscalls/pipe/pipe09.c
index 86282de49..ff3e077e8 100644
--- a/testcases/kernel/syscalls/pipe/pipe09.c
+++ b/testcases/kernel/syscalls/pipe/pipe09.c
@@ -51,7 +51,7 @@
 #include <sys/wait.h>
 #include <errno.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define	PIPEWRTCNT	100	/* must be an even number */
 
diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
index 606018af4..024ad6d66 100644
--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -17,7 +17,7 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include "ltp_signal.h"
+#include "otst_signal.h"
 #include "time64_variants.h"
 #include "tst_sig_proc.h"
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
index a8254cb00..f60687e9a 100644
--- a/testcases/kernel/syscalls/profil/profil01.c
+++ b/testcases/kernel/syscalls/profil/profil01.c
@@ -26,7 +26,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/abisize.h"
 #include "config.h"
 
diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
index bb2578355..d807b61d4 100644
--- a/testcases/kernel/syscalls/recv/recv01.c
+++ b/testcases/kernel/syscalls/recv/recv01.c
@@ -53,7 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "recv01";
 int testno;
diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
index 6ce9f1bde..1ff2435c9 100644
--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -53,7 +53,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "recvfrom01";
 int testno;
diff --git a/testcases/kernel/syscalls/removexattr/removexattr01.c b/testcases/kernel/syscalls/removexattr/removexattr01.c
index ddbcba698..097340306 100644
--- a/testcases/kernel/syscalls/removexattr/removexattr01.c
+++ b/testcases/kernel/syscalls/removexattr/removexattr01.c
@@ -32,7 +32,7 @@
 #endif
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "removexattr01";
 
diff --git a/testcases/kernel/syscalls/removexattr/removexattr02.c b/testcases/kernel/syscalls/removexattr/removexattr02.c
index 399055ca7..90675f99b 100644
--- a/testcases/kernel/syscalls/removexattr/removexattr02.c
+++ b/testcases/kernel/syscalls/removexattr/removexattr02.c
@@ -37,7 +37,7 @@
 #endif
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "removexattr02";
 
diff --git a/testcases/kernel/syscalls/rename/rename11.c b/testcases/kernel/syscalls/rename/rename11.c
index 17cf04c85..5cec568b8 100644
--- a/testcases/kernel/syscalls/rename/rename11.c
+++ b/testcases/kernel/syscalls/rename/rename11.c
@@ -37,7 +37,7 @@
 #include <sys/mount.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "rename11";
 
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index c318a7971..056f82576 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -48,7 +48,7 @@
 #include <sys/mount.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/fcntl.h"
 
 #define MNTPOINT "mntpoint"
diff --git a/testcases/kernel/syscalls/renameat2/renameat201.c b/testcases/kernel/syscalls/renameat2/renameat201.c
index 23ed5758a..2091608b4 100644
--- a/testcases/kernel/syscalls/renameat2/renameat201.c
+++ b/testcases/kernel/syscalls/renameat2/renameat201.c
@@ -35,7 +35,7 @@
 #define _GNU_SOURCE
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/fcntl.h"
 #include "renameat2.h"
 
diff --git a/testcases/kernel/syscalls/renameat2/renameat202.c b/testcases/kernel/syscalls/renameat2/renameat202.c
index 88db04762..67493012d 100644
--- a/testcases/kernel/syscalls/renameat2/renameat202.c
+++ b/testcases/kernel/syscalls/renameat2/renameat202.c
@@ -24,7 +24,7 @@
 #define _GNU_SOURCE
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/fcntl.h"
 #include "renameat2.h"
 
diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
index 8c4724eb4..e24ed0cc5 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
@@ -57,7 +57,7 @@
 
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "ltp_signal.h"
+#include "otst_signal.h"
 
 char *TCID = "rt_sigprocmask02";
 int TST_TOTAL = 2;
diff --git a/testcases/kernel/syscalls/send/send01.c b/testcases/kernel/syscalls/send/send01.c
index 41859ff6f..52dc07e85 100644
--- a/testcases/kernel/syscalls/send/send01.c
+++ b/testcases/kernel/syscalls/send/send01.c
@@ -42,7 +42,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "send01";
 int testno;
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index 38cd7182c..93e36173a 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -48,7 +48,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "sendmsg01";
 int testno;
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg02.c b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
index f72e9db22..a54b87f45 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg02.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
@@ -43,7 +43,7 @@
 #include <limits.h>
 #include "config.h"
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/sem.h"
 
 char *TCID = "sendmsg02";
diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
index b3b7b6efd..92c1bc3c7 100644
--- a/testcases/kernel/syscalls/sendto/sendto01.c
+++ b/testcases/kernel/syscalls/sendto/sendto01.c
@@ -41,7 +41,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "sendto01";
 int testno;
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
index e1525a731..db146a512 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid04.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
@@ -38,7 +38,7 @@
 #include <unistd.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "compat_16.h"
 
 TCID_DEFINE(setfsuid04);
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index d00153533..6a55bf27f 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -37,7 +37,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "setrlimit01";
 int TST_TOTAL = 1;
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
index 76f3be27f..8e283a849 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
@@ -63,7 +63,7 @@
 #include "test.h"
 #include "lapi/fcntl.h"
 #include "lapi/syscalls.h"
-#include "ltp_signal.h"
+#include "otst_signal.h"
 
 #define SFD_CLOEXEC O_CLOEXEC
 
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
index 18f86b4a7..ecde48d73 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_02.c
@@ -59,7 +59,7 @@
 
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "ltp_signal.h"
+#include "otst_signal.h"
 
 #define SFD_NONBLOCK O_NONBLOCK
 
diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index d901540ca..0a59c422e 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -15,7 +15,7 @@
 
 #include "config.h"
 #include "tst_test.h"
-#include "ltp_signal.h"
+#include "otst_signal.h"
 #include "lapi/syscalls.h"
 
 static void sigpending_info(void)
diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index 23c675826..8ef890044 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -108,7 +108,7 @@
 #include <time.h>
 #include <unistd.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #ifdef __linux__
 /* glibc2.2 definition needs -D_XOPEN_SOURCE, which breaks other things. */
diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index e81ec20a5..4f3a230cf 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -40,7 +40,7 @@
 #include <net/if.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "sockioctl01";
 int testno;
diff --git a/testcases/kernel/syscalls/symlink/symlink03.c b/testcases/kernel/syscalls/symlink/symlink03.c
index c89fe5d6d..381a6be2f 100644
--- a/testcases/kernel/syscalls/symlink/symlink03.c
+++ b/testcases/kernel/syscalls/symlink/symlink03.c
@@ -87,7 +87,7 @@
 #include <pwd.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 #define MODE_RWX        S_IRWXU | S_IRWXG | S_IRWXO
 #define FILE_MODE       S_IRUSR | S_IRGRP | S_IROTH
diff --git a/testcases/kernel/syscalls/symlinkat/symlinkat01.c b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
index d510872f0..068dc256f 100644
--- a/testcases/kernel/syscalls/symlinkat/symlinkat01.c
+++ b/testcases/kernel/syscalls/symlinkat/symlinkat01.c
@@ -42,7 +42,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/syscalls.h"
 
 #define MYRETCODE -999
diff --git a/testcases/kernel/syscalls/umount2/umount2_01.c b/testcases/kernel/syscalls/umount2/umount2_01.c
index 5696270d6..75e56c746 100644
--- a/testcases/kernel/syscalls/umount2/umount2_01.c
+++ b/testcases/kernel/syscalls/umount2/umount2_01.c
@@ -25,7 +25,7 @@
 #include <errno.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 #include "lapi/mount.h"
 
 static void setup(void);
diff --git a/testcases/kernel/syscalls/vfork/vfork02.c b/testcases/kernel/syscalls/vfork/vfork02.c
index efa70d0be..a8201410e 100644
--- a/testcases/kernel/syscalls/vfork/vfork02.c
+++ b/testcases/kernel/syscalls/vfork/vfork02.c
@@ -78,7 +78,7 @@
 #include <sys/wait.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "vfork02";
 int TST_TOTAL = 1;
diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
index 45f77a38b..c44fc6082 100644
--- a/testcases/lib/tst_device.c
+++ b/testcases/lib/tst_device.c
@@ -9,7 +9,7 @@
 #include <stdlib.h>
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
-#include "old/old_device.h"
+#include "old/otst_device.h"
 
 extern struct tst_test *tst_test;
 
diff --git a/testcases/network/lib6/asapi_01.c b/testcases/network/lib6/asapi_01.c
index ac1de5418..1976be825 100644
--- a/testcases/network/lib6/asapi_01.c
+++ b/testcases/network/lib6/asapi_01.c
@@ -31,7 +31,7 @@
 #include <netinet/in.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "asapi_01";
 
diff --git a/testcases/network/lib6/asapi_03.c b/testcases/network/lib6/asapi_03.c
index 87d050add..e46b1d44d 100644
--- a/testcases/network/lib6/asapi_03.c
+++ b/testcases/network/lib6/asapi_03.c
@@ -41,7 +41,7 @@
 #include <arpa/inet.h>
 
 #include "test.h"
-#include "safe_macros.h"
+#include "otst_safe_macros.h"
 
 char *TCID = "asapi_03";
 
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index ac58c90cc..2c92ecf10 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -63,8 +63,8 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include "test.h"
-#include "usctest.h"
-#include "safe_macros.h"
+#include "otst_usctest.h"
+#include "otst_safe_macros.h"
 
 char *TCID;			/* Name of the testcase */
 int TST_TOTAL;			/* Total number of testcases */
diff --git a/utils/sctp/testlib/sctputil.h b/utils/sctp/testlib/sctputil.h
index 176d623f0..91485c133 100644
--- a/utils/sctp/testlib/sctputil.h
+++ b/utils/sctp/testlib/sctputil.h
@@ -50,7 +50,7 @@
 
 #ifdef LTP
 #include <test.h>
-#include <usctest.h>
+#include <otst_usctest.h>
 #endif
 
 #include <string.h>
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
