Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508CEFF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 06:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777444043; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=a6EDP+m1ubLRJN/rlNgXd1u+eoz7TDyI1MwoMWir2WQ=;
 b=hYYOX2Supx2KqnwVNo/KQjTCQvKj++Za/ol2ceuzRmjMp1jHCO+MPGG3aPJup0ciM0zjc
 tt94XQ/4dHTQEMQZSom5OWJFVBELeIMJGSDMJv9KZx1F+FvW0+g7up5V+QXdfuyScj8oVXv
 GcxKLhWukQMHydeQk8Mf/vDGMlO73R4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A88123E22A0
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 08:27:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE4133CA6DC
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 08:26:59 +0200 (CEST)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 429891000952
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 08:26:58 +0200 (CEST)
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-c797efdaa9cso6284607a12.3
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 23:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777444016; x=1778048816; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0EaZ2p93hTcMiCDCweOIyt7SHftoE42c/rXFKiXEj84=;
 b=aedIpJSpVLzER58pzvyksLwWJ7EPQ6ms2UtoAU37nNS/f5oxYiSBBZlFgZQhWyWU/P
 NK26OyqLchvyYhflZTjsHCaHpi3dODimmqx7c1i5222Q3NXupbXmU2/4k3yqoCAcqSl2
 uBBFybCoFAXY++WKPMKxxzFDClE3HUNow+wpGCC5akahpgrMpjd4O0mEptb+foHCLw2E
 5cUAqCCNOgEXhf8DQ3YO/p07Zw3goBYbw/G0GmX6Abiap0ivtZYn55QpMI9VzPRFheh2
 l6WQ4YUOoICWt75mGh8wO0gGg3yjGFcJzXfw5r1R2AaxiOBhf2XA9w7j+Nb86+P2zZwX
 iMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777444016; x=1778048816;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0EaZ2p93hTcMiCDCweOIyt7SHftoE42c/rXFKiXEj84=;
 b=bz2KnYwDHxvjQTm9dfZ1hSQpGh49wGO09ybC3sk/j8k8o04Gek0ClSy0/RUJx7kjY1
 axJz3EuIcTvdaTL3hetAIKy8FVXuNjn+uvaYqHDyhev5o5B9YTZhgdJyCLfJx4fwmn9P
 5udbQlUJe0cnaLbaQBrOmuuhmzMWyF9ancV7xc0KK67gizP0U6HtcHw6NPGc8mQ9KPt8
 a3dB9OtdWdxlsTWqFoZ/FEFGERUvHc3xcpunW8ovqR8oZTNlU4rMJNQVx7quaor7ESkR
 5I+o1ndLUVTJJNwCFElTR9csk5XJ3b96e5t4shhPiZ36mCevUc08iiqA4F8D0aHgpaFZ
 SZEQ==
X-Gm-Message-State: AOJu0Yzaz5g1J0np5hd4IYNsxc58LG5ulVDkb2JQKkyo4CCZpfPtOZya
 y6aEtZ1ZfvfH5blb5o2DSDJWcNAwLx9suY4tTpIJazRIuh6ZeJ1HYfaSmqm9zGff+patwyQVS1/
 i5w==
X-Received: from pghk16.prod.google.com ([2002:a63:f010:0:b0:c73:cc95:c0d7])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:728c:b0:3a0:bc61:62e4
 with SMTP id adf61e73a8af0-3a39c352c76mr7198638637.53.1777444016145; Tue, 28
 Apr 2026 23:26:56 -0700 (PDT)
Date: Wed, 29 Apr 2026 14:26:50 +0800
In-Reply-To: <aeDpBp_TNCJYCDzG@yuki.lan>
Mime-Version: 1.0
References: <aeDpBp_TNCJYCDzG@yuki.lan>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429062650.3191021-1-wakel@google.com>
To: chrubis@suse.cz
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls/file_attr01: Dynamically expect
 EOPNOTSUPP on tmpfs without xattr
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
Cc: wakel@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Wake Liu via ltp <ltp@lists.linux.it>

The syscalls file_getattr and file_setattr return EOPNOTSUPP instead of
EFAULT when the ufattr argument is NULL on tmpfs without xattr support
(CONFIG_TMPFS_XATTR=n). This is because the kernel checks for the
filesystem operation support before dereferencing the user pointer.

This patch adds a runtime check for CONFIG_TMPFS_XATTR when testing
on tmpfs, ensuring the correct errno is expected based on the kernel
configuration. This prevents hiding potential kernel bugs where
EOPNOTSUPP might be returned even when xattr is supported.

Changes in v3:
- Moved tst_kconfig_check() to setup() to avoid parsing the kernel
  config in each iteration of run(), as suggested by Cyril Hrubis.

Changes in v2:
- Replaced the TST_EXP_FAIL_ARR approach with a dynamic check in run().
- Included tst_kconfig.h and used tst_kconfig_check() to verify
  CONFIG_TMPFS_XATTR status.
- Expected EOPNOTSUPP only on tmpfs when xattr support is missing,
  otherwise default to EFAULT.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/file_attr/file_attr01.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/file_attr/file_attr01.c b/testcases/kernel/syscalls/file_attr/file_attr01.c
index c9c9288a1..419d54c36 100644
--- a/testcases/kernel/syscalls/file_attr/file_attr01.c
+++ b/testcases/kernel/syscalls/file_attr/file_attr01.c
@@ -18,6 +18,7 @@
 
 #include <string.h>
 #include "tst_test.h"
+#include "tst_kconfig.h"
 #include "lapi/fs.h"
 #include "lapi/fcntl.h"
 
@@ -35,6 +36,7 @@ static size_t small_usize;
 static size_t valid_usize;
 static size_t big_usize;
 static struct file_attr *valid_file_attr;
+static int missing_tmpfs_xattr;
 
 static struct tcase {
 	int *dfd;
@@ -115,20 +117,24 @@ static struct tcase {
 static void run(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
+	int exp_errno = tc->exp_errno;
+
+	if (tc->ufattr == (struct file_attr **)(&null_ptr) && missing_tmpfs_xattr)
+		exp_errno = EOPNOTSUPP;
 
 	if (tst_variant) {
 		TST_EXP_FAIL(file_getattr(
 			*tc->dfd, *tc->filename,
 			*tc->ufattr, *tc->usize,
 			tc->at_flags),
-			tc->exp_errno,
+			exp_errno,
 			"%s", tc->msg);
 	} else {
 		TST_EXP_FAIL(file_setattr(
 			*tc->dfd, *tc->filename,
 			*tc->ufattr, *tc->usize,
 			tc->at_flags),
-			tc->exp_errno,
+			exp_errno,
 			"%s", tc->msg);
 	}
 }
@@ -144,6 +150,11 @@ static void setup(void)
 	valid_usize = FILE_ATTR_SIZE_LATEST;
 	small_usize = FILE_ATTR_SIZE_VER0 - 1;
 	big_usize = SAFE_SYSCONF(_SC_PAGESIZE) + 100;
+
+	if (!strcmp(tst_device->fs_type, "tmpfs")) {
+		const char *const kconfig[] = {"CONFIG_TMPFS_XATTR=y", NULL};
+		missing_tmpfs_xattr = tst_kconfig_check(kconfig);
+	}
 }
 
 static void cleanup(void)
-- 
2.54.0.545.g6539524ca2-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
