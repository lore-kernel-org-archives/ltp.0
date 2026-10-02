Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCFACA5FDD
	for <ltp@archiver.kernel.org>; Fri,  2 Oct 2026 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790946390; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=/DrfAe6nDNVJqvSEp0A28EAt2OmCnbXOk3XcszdqSSs=;
 b=XXTuTuMmlDq9zJPgTor4SufcPMoX5aYzedvLY66vgoPjiRarg1BslNCJAtdbziycYrbYl
 YMiXsWKh2sS+YOg0eeE+d02ZmdBWdrRqu4QHsdXt8Xk8VSrbdXvm9On6Y46T7+/3WRDUhcu
 YgWAB3QW9hHyOXl8p5pPQH8CfMraQUo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DA1E3E6B73
	for <ltp@archiver.kernel.org>; Fri,  2 Oct 2026 15:06:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0193C3E6EA1
 for <ltp@lists.linux.it>; Fri,  2 Oct 2026 15:06:01 +0200 (CEST)
Received: from mail-pg1-x548.google.com (mail-pg1-x548.google.com
 [IPv6:2607:f8b0:4864:20::548])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C0401A0014C
 for <ltp@lists.linux.it>; Fri,  2 Oct 2026 15:06:00 +0200 (CEST)
Received: by mail-pg1-x548.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so4634572a12.0
 for <ltp@lists.linux.it>; Fri, 02 Oct 2026 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790946358; x=1791551158; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l4ID73J+xMO4BrMDg5rwFtNGCCFyjqudjvqrmCJ4Wy0=;
 b=Nt4xhavlLKniKy1CZhPMv6m/wtnx23VdLLRN61J3Gq7nj94SYmVaD2dvyNRkLtY7AP
 KJvcVCThQZaLgToqTUlrTXWfuyFnS8beaZUv8k0i82t2AIYkfAZJ+sDltrPPjM3lqncH
 VakeYBN2iA732G0YAzodE5pkwKzKEtLK9WZxtBHOJNVEzK6A6TlL9cRsqHa8/B7DhjKZ
 9DF6CAhRrcOx9L07JkZ+M7OwY/tgQ0IIAl1GdEfRZfbHiqk2pEgSG4YF9D5I1CCKbEqO
 duetHcE5DfdDN4aUUlpvz81xkv8r0RmMp+DTxB1KUXg/ZvqidVjlRoea07oOS72qZ3NM
 ruUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790946358; x=1791551158;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l4ID73J+xMO4BrMDg5rwFtNGCCFyjqudjvqrmCJ4Wy0=;
 b=Yofei2AjSSvomRXr08CdH98crK1k4qWopV3k2zO/UZuB9CDPNHrfjDhREFnZWGzOEY
 /j/xbm10vsjZ5T2wehKnwrmSzKYinaPKWpyp9SLjSnddnlqzJQqXmRvMzOB6KoJm5MmQ
 oRFpgwFg1FN2AQYTOaK5vHhEeo35JCilFg65PuMEwmUztxTXZ2XU6nDMf09B4ZrOLL76
 kgE8z6+GdtuFl0wqaLZqqhptgm6kAFSSED2tws7OVhWBMDfJg0E5yVT+BlrW5E5OURwU
 yUEW4FXYbmFiCAVcMBsmlgkESJGGC29WXI1FBWcDtVDmjafARJHIUbGvaMT6ritFRpDH
 HnRA==
X-Gm-Message-State: AFq9FYIQWoHxCBL5NnEpYnUarirLdtAZsuZtsAX+chmk1MBQOji1FqaZ
 dvV30X/6Au5yN5nnGe4PXO852f/Uyj9LVNXKASnI/9CrIXfpLbrfvSY8MGdYJNg5a/ukkWGM6PS
 FSfMmh5QfJ4sW8GbzVK6XpjHSsHMIR5mCO29F3M6NmurHrMCOB1sU4I0H92kOs0umQgC95gjpAo
 Szde7qEk/H9m6WMUTvi4wjLZmIBQ==
X-Received: from plmj10.prod.google.com ([2002:a17:903:2fca:b0:2df:a554:8274])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e802:b0:2df:35f1:8771
 with SMTP id d9443c01a7336-2e49b6d0622mr24848385ad.54.1790946357888; Fri, 02
 Oct 2026 06:05:57 -0700 (PDT)
Date: Fri,  2 Oct 2026 13:05:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002130556.1236937-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi/procfs.h: Add elf_prstatus and elf_prpsinfo
 fallbacks
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Bionic's <sys/procfs.h> provides elf_gregset_t and struct elf_siginfo,
but not struct elf_prstatus or struct elf_prpsinfo, so coredump02
fails to build on Android:

    error: incomplete definition of type 'const struct elf_prstatus'

Add configure checks and fallback definitions which follow
include/linux/elfcore.h. The timevals and pr_uid/pr_gid use the kernel
types, so the layout matches the native core dump format, e.g. 16-bit
pr_uid on 32-bit x86 and arm. Use the new header in coredump02.

Fixes: 72a170823fb0 ("coredump02: Verify ELF structure and notes")
Signed-off-by: Wake Liu <wakel@google.com>
---
 configure.ac                           |  1 +
 include/lapi/procfs.h                  | 56 ++++++++++++++++++++++++++
 testcases/kernel/coredump/coredump02.c |  2 +-
 3 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 include/lapi/procfs.h

diff --git a/configure.ac b/configure.ac
index e979de0e7..370c2e74f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -201,6 +201,7 @@ AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
 AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
 AC_CHECK_TYPES([struct clone_args],,,[#include <sched.h>])
 AC_CHECK_TYPES([struct sched_attr],,,[#include <sched.h>])
+AC_CHECK_TYPES([struct elf_prpsinfo, struct elf_prstatus],,,[#include <sys/procfs.h>])
 AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
 		struct fanotify_event_info_header, struct fanotify_event_info_pidfd,
 		struct fanotify_event_info_range],,,[#include <sys/fanotify.h>])
diff --git a/include/lapi/procfs.h b/include/lapi/procfs.h
new file mode 100644
index 000000000..598d91bf1
--- /dev/null
+++ b/include/lapi/procfs.h
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Google LLC
+ */
+
+#ifndef LAPI_PROCFS_H__
+#define LAPI_PROCFS_H__
+
+#include "config.h"
+#include <sys/types.h>
+#include <sys/procfs.h>
+#include "lapi/posix_types.h"
+
+/*
+ * Bionic does not provide the core dump note descriptors. The fallbacks
+ * follow include/linux/elfcore.h, using the kernel types so that the layout
+ * matches the native ABI on every architecture.
+ */
+#ifndef HAVE_STRUCT_ELF_PRSTATUS
+struct elf_prstatus {
+	struct elf_siginfo pr_info;
+	short pr_cursig;
+	unsigned long pr_sigpend;
+	unsigned long pr_sighold;
+	pid_t pr_pid;
+	pid_t pr_ppid;
+	pid_t pr_pgrp;
+	pid_t pr_sid;
+	struct {
+		__kernel_long_t tv_sec;
+		__kernel_long_t tv_usec;
+	} pr_utime, pr_stime, pr_cutime, pr_cstime;
+	elf_gregset_t pr_reg;
+	int pr_fpvalid;
+};
+#endif
+
+#ifndef HAVE_STRUCT_ELF_PRPSINFO
+struct elf_prpsinfo {
+	char pr_state;
+	char pr_sname;
+	char pr_zomb;
+	char pr_nice;
+	unsigned long pr_flag;
+	__kernel_uid_t pr_uid;
+	__kernel_gid_t pr_gid;
+	pid_t pr_pid;
+	pid_t pr_ppid;
+	pid_t pr_pgrp;
+	pid_t pr_sid;
+	char pr_fname[16];
+	char pr_psargs[ELF_PRARGSZ];
+};
+#endif
+
+#endif /* LAPI_PROCFS_H__ */
diff --git a/testcases/kernel/coredump/coredump02.c b/testcases/kernel/coredump/coredump02.c
index 7b0b4c43e..6657a3d71 100644
--- a/testcases/kernel/coredump/coredump02.c
+++ b/testcases/kernel/coredump/coredump02.c
@@ -40,9 +40,9 @@
  */
 
 #include <link.h>
-#include <sys/procfs.h>
 
 #include "coredump_common.h"
+#include "lapi/procfs.h"
 
 #define NOTE_ALIGN(x) (((x) + 3) & ~3U)
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
