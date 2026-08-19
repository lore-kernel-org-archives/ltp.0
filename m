Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B67C5DF6D
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787128771; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=O6KP2nnTu83Gg4ian4F7/wk9+dpzheTvvJOIWPkN7eQ=;
 b=az9bpDquT2g+BY4GuBUDZgupXRoMonMEpQB4vbwdv8dnz043HNxRoZZHxJzWld0CYNK61
 wSznprZel1+3n8uvuBfpFwzsRD0xE2MCrtXobAzyfl2KI3eceMBdmhYRuWzGb6Rpa3s0NCE
 Ceby+2n8nznHQMce/F4Yq5tAhIQTBYA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD01C3CD600
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 10:39:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50AF43CD2C7
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 10:39:11 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7802B1400078
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 10:39:10 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4956869750eso4450635e9.2
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 01:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787128750; x=1787733550; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ol8x2/GVxVxBdYgS21lil7hPCXFYuNOdfQ+6RJDdHHE=;
 b=TsutL5vMiV3y6HIraireuxD/T6loFQCe3bvK6Z5nZaimlQOFfXfWLhbKbvriVDZium
 2zA6FuoI5YivdgNwSJDE9tEca0Maf6SmaXehDL1iKL5bRx1FS+Nq2ugh/oNoPmN7oz8s
 WpS81gX/sWg9LNw4L0xDGZoSWsTSXCXJyNzzLRvhSbLxVnfF2+tPZ+JpfbVtFWYNFrez
 5gdtn+z7saCgSEXFCfdKW3VqWREDjbVz7Gd2IjFZSMu/GusTyJTnOZST8NsLyu5IpYCe
 e9WeDCz58dc3ip6wNNGAUlr1gKOIhjOjpD7Md3Jx1/1XEw3ixySa62DtIy+rNJQE41K7
 sQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787128750; x=1787733550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ol8x2/GVxVxBdYgS21lil7hPCXFYuNOdfQ+6RJDdHHE=;
 b=f+EBsHhnlwuG3Rq6t+1N9cOYx5JqHj+m8xZQhCtxwE+VlEUHHwSdN3wzGUt+qtxozI
 /bdnO/mnNXYqjOUunZDMQLSqewtom0iarQn9zxwe+04r9cnhaBvKzQ39lYtChVdFkUNw
 ZhbaDEX38xRd6TdKa9xGC+g3BS+JBbsUaapKbyenYqg/KMoWTt775UrmnHnugwDsW53w
 zaZKELg16bUURh7DvOwBOrHId7/a0B7Lgz1Aao4AuKciytQHP7v9tgNHy9mWi9UczcIE
 Ut7rSasC+FPkEDOIlJoWrEjLTdq6001NLRtlhadpXoy5VpOfnjEH/C3ESKaZxFZDpIFH
 8rIw==
X-Gm-Message-State: AOJu0YxbXjXSqtj5L5nZokDGyg21JybWBMxKiphZZr2LBhilqnVpWjLk
 jb6DQj/majKhK56OzwPovvqqO4eHgHa1yDrDxIUVnemj8tJyxeq98Cc8DOgwE2CSIazbOdkLtWx
 /T1I=
X-Gm-Gg: AR+sD12y+vKuGn8fKUUS+ZmcwnFsZDXgcdv3TJYzGI/UxWANiZPnYUo/AcT+amnMDeW
 dCSR8S9iNkFK/bTCXLRzAQlMjT7zmu81YvfpE7X94gPruaZhHmwo0ZdhQPn2BB3GP3cKMS9fq5M
 hVoykiC7zQZauLVlGNj0hDl9jUI/g+WO8GlWq9sNwhTBUPodVMA3E0LcrG5xH8BU7+RDBnf7f6A
 qEjDWITU8ptTJy7bNGX/2bFVq788i3atXXwRjHdLPMwM7kNmRgIYxXM1jRoKNu2PqqeUYutugaJ
 3moqGhPabK4g5z+SFKcyw0UY8Zn9lCJRPl09lz2tUEaAnrt0HgQdpoLU/gFFofTJXiZAEy8J4mR
 hYFR2UcSdOtWfT9HGm4RtzxPhCC0e3OxOf4ZnNst5wbyGVPz+QMTOheHnT/AMrYTWHSotYWDAhR
 HsK5MmRZX22ME0qm9uJrz//0pRIf1Aop1UhHTZZRXYvYYcWgi2VJmJBMCxvaKZX0icOj2LJdC+U
 HTH9WtZ6YqlYTU6dYIG6qZ/wjSaJYN6
X-Received: by 2002:a05:600c:46cb:b0:499:781e:25fc with SMTP id
 5b1f17b1804b1-499aa17d75bmr44663715e9.3.1787128749724; 
 Wed, 19 Aug 2026 01:39:09 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-499a9def415sm36938515e9.2.2026.08.19.01.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 01:39:09 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 08:38:57 +0000
Message-ID: <20260819083907.26866-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819031716.26527-1-wegao@suse.com>
References: <20260819031716.26527-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] shmctl03: Fix 32-bit compat mode failure by
 adjusting comparisons for compat mode truncation
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 64-bit kernels, the default shmmax and shmall values often exceed
the range of a 32-bit unsigned long or are clipped differently by the
kernel's compat syscall layer than they appear in /proc.

Link: https://lore.kernel.org/ltp/aJm5SBOaRoe1e0PB@yuki.lan/
Signed-off-by: Wei Gao <wegao@suse.com>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v5->v6:
 - Replaced the comma expression (0, ##__VA_ARGS__) in TST_ASSERT_ULONG with TST_2_(dummy, ##__VA_ARGS__, 0).

 include/tst_assert.h                        | 10 +++++---
 lib/tst_assert.c                            | 27 ++++++++++++++++-----
 testcases/kernel/syscalls/shmctl/shmctl03.c | 17 ++++++++++---
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/include/tst_assert.h b/include/tst_assert.h
index dcb62dfea..a21ed5bd6 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -21,14 +21,18 @@ void tst_assert_int(const char *file, const int lineno,
 #define TST_ASSERT_FILE_INT(path, prefix, val) \
 	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)
 
+#define TST_ASSERT_SATURATED_INT   0x01
+#define TST_ASSERT_BITWISE         0x02
+
 /*
  * Same as tst_assert_int() but for unsigned long.
  */
 void tst_assert_ulong(const char *file, const int lineno,
-                      const char *path, unsigned long val);
+                      const char *path, unsigned long val, int flags);
 
-#define TST_ASSERT_ULONG(path, val) \
-	tst_assert_ulong(__FILE__, __LINE__, path, val)
+#define TST_ASSERT_ULONG(path, val, ...) \
+	tst_assert_ulong(__FILE__, __LINE__, path, val, \
+		TST_2_(dummy, ##__VA_ARGS__, 0))
 
 /*
  * Asserts that integer value stored in the prefix field of file pointed by path
diff --git a/lib/tst_assert.c b/lib/tst_assert.c
index b68bd5d39..fd651f53a 100644
--- a/lib/tst_assert.c
+++ b/lib/tst_assert.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
  */
 #include <stdio.h>
+#include <limits.h>
 #define TST_NO_DEFAULT_MAIN
 #include "tst_assert.h"
 #include "tst_test.h"
@@ -23,18 +24,32 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
 	tst_res_(file, lineno, TFAIL, "%s != %d got %d", path, val, sys_val);
 }
 
-void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
+void tst_assert_ulong(const char *file, const int lineno, const char *path,
+		      unsigned long val, int flags)
 {
-	unsigned long sys_val;
-
-	safe_file_scanf(file, lineno, NULL, path, "%lu", &sys_val);
+	unsigned long long sys_val_64;
+	unsigned long expected_val;
+
+	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val_64);
+
+	if (flags & TST_ASSERT_SATURATED_INT) {
+		if (sys_val_64 > (unsigned long long)INT_MAX)
+			expected_val = (unsigned long)INT_MAX;
+		else
+			expected_val = (unsigned long)sys_val_64;
+	} else if (flags & TST_ASSERT_BITWISE) {
+		expected_val = (unsigned long)(sys_val_64 & 0xFFFFFFFFULL);
+	} else {
+		expected_val = (unsigned long)sys_val_64;
+	}
 
-	if (val == sys_val) {
+	if (val == expected_val) {
 		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
 		return;
 	}
 
-	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu", path, val, sys_val);
+	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu (raw: %llu)",
+		path, val, expected_val, sys_val_64);
 }
 
 void tst_assert_file_int(const char *file, const int lineno, const char *path, const char *prefix, int val)
diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
index 9e1c2f099..dfe5f17e3 100644
--- a/testcases/kernel/syscalls/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/shmctl/shmctl03.c
@@ -30,9 +30,20 @@ static void verify_ipcinfo(void)
 	else
 		tst_res(TPASS, "shmmin = 1");
 
-	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
-	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
-	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
+	if (tst_is_compat_mode()) {
+		/*
+		 * On 64-bit kernel, shmmax is clamped to INT_MAX for 32-bit
+		 * compat syscall, while shmmni and shmall are truncated
+		 * to 32-bit.
+		 */
+		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax, TST_ASSERT_SATURATED_INT);
+		TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni, TST_ASSERT_BITWISE);
+		TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall, TST_ASSERT_BITWISE);
+	} else {
+		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
+		TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
+		TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
+	}
 }
 
 static struct tst_test test = {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
