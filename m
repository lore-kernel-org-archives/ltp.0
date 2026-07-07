Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CEEC43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 05:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783403352; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=uFNedyzrz1p1CpQybonyWLHOfrw1QT0DT5Xxwqg/W8c=;
 b=Oi/iRLi/ygUVozDSvUkJF49VmYbtGN4rP6gysdPRzlTxjFN0oxeTbrvlp/a/Pb8RzkfUj
 EsNqNHy2sL4iyiq5GfNFgODfcg9Z55kp9MAQfS9mYh7EAI7kDgd13/UpGl3I/MBGVNecdyb
 oO0vNOu/X705nCxPO1mntTZ4XNtYx5M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50D5C3E2A61
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 07:49:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 556243E2A5C
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 07:48:09 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 22650600863
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 07:48:09 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so34547565e9.2
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 22:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783403288; x=1784008088; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jKLfp6qp91YQux1g3q/A52Fpm82TWMJC9HPMMh7Xm8=;
 b=baS+rOPEdpd1QKr2WpV8HCse7JcVNDFE2El89YRSYSkKP5XzrBz958QZj0h3HxULV4
 swdTYWsmLU6VbvhxlGhxWFW9NFODMYFA3Ys+fdCIZN9XtkourF8ItKsuZ6zBEjvl4wKk
 cn6RkNSo0dxotXz3dGjBK8BR3kWmmmCWI2G2gzl+65Qmx8uY1m23sO2+P58ALlLB7O8D
 rBMQ/URlb7AfrULcWCmEI+/HJpvA1ewDhLLfny2bvZUjneOEPPODXbfJjtrosxqDzqP7
 aNcZHc5MI3mTypUCv91Nop8+z0XI4gNLuaFSms0jnJf2iTUg6QbT5j78Baj8Kqt3jhxk
 PfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783403288; x=1784008088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9jKLfp6qp91YQux1g3q/A52Fpm82TWMJC9HPMMh7Xm8=;
 b=TYdcMwcufmGl/fdppBgbkiKUm34pIoqCpx6Adg0d7vIDg4JcQs37Z1MUfLUMGkUiJw
 5MdGPNMd+76T7dEpmLS0PumtXYvStxuN3aWDFhiuoWKc3IZXOnUyZzXrKOzLWMv7kaF4
 PkyCUCbyV1KffRUCnwbY++y5Q5VFhU9dg1ebtE5z+8gO6f2zb2l7w257qcVe/Mx02AvV
 lvaH/xYz5z5LIWTGXLFv4UqyV2rP+iictsouUxYygV/ojdTgRyvBoLXzRVUZwM05YF+P
 5iDMh8DvWsazdxrhGf++xaXnzbFnJ918oQ3Fa8aWFbOGIQhwtdRzfIXvRaUvWjA8Qa5x
 FQXg==
X-Gm-Message-State: AOJu0YzLlPfPQkPhY168e7EApw99Sc1GAFk+X0+0dhReVqhZuz4pvNXz
 bUToaG4boGFkDGmMRhZ1VjHABBbmtSj3Z10iY87/wubk6AIckBdsJchM+zUR4rzL77aVT3MXp2o
 fYwc=
X-Gm-Gg: AfdE7cno+iAJ90hXzyt7xvhF623kHdoBT8+/nPSMgvCDV8/fXHpquMltl+PJVAbWYzr
 L0cmfs1F+fLm/Auzt3jCwMitDyEfVBkr5Qt5aBbAPS7XGkt3I4LSk8o6HXablDrxKtZYz+YRZNm
 6VS9qFuZgq1TTk2KzTrOZ5DT+yWzuQh2SDlbrmfowMbO1IGaiy8WTKvrzrMXezr01IFZCNQO/R0
 Fvnk4UXj74WEoV6px4bxKuUuO7/cLAdm1r5InBX1cyerfW4WiIB+VV3C6duOgo+wp/KLl0EU41q
 Vae/gf5DsLfUxMklTDDw75y9EQJx3S153eBfaMZVdzUcpPc1XPczF6X02rm+hyRhsfVboFR3Q9V
 YHo943OmYrNzpt9kWm2vFbfWgpU1MXcyAWx3VxnuUIgmEOgwflvXtNx6kLpg4zozhGxQY2aL1Ar
 Zj
X-Received: by 2002:a05:600c:8b17:b0:492:43d2:9e6e with SMTP id
 5b1f17b1804b1-493df04a73bmr40296095e9.9.1783403288512; 
 Mon, 06 Jul 2026 22:48:08 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm28821793f8f.10.2026.07.06.22.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 22:48:08 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  7 Jul 2026 05:47:53 +0000
Message-ID: <20260707054804.24232-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707054804.24232-1-wegao@suse.com>
References: <https://patchwork.ozlabs.org/project/ltp/patch/20260707022959.24088-2-wegao@suse.com/>
 <20260707054804.24232-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 1/2] lib: New library function tst_get_free_uid
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add tst_get_free_uid() to dynamically find unused UIDs for tests.

Some tests need a completely unassigned, unused UID. This is used by
open16 to verify restricted O_CREAT in sticky directories by running
as a sandboxed user with no file ownership or privileges.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_uid.h | 27 +++++++++++++++++++++++----
 lib/tst_uid.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/include/tst_uid.h b/include/tst_uid.h
index 2237ddcbf..2ffe84613 100644
--- a/include/tst_uid.h
+++ b/include/tst_uid.h
@@ -7,10 +7,29 @@
 
 #include <sys/types.h>
 
-/*
- * Find unassigned gid. The skip argument can be used to ignore e.g. the main
- * group of a specific user in case it's not listed in the group file. If you
- * do not need to skip any specific gid, simply set it to 0.
+/**
+ * tst_get_free_uid() - Find a UID not assigned to any user.
+ * @skip: UID value to skip (pass 0 to skip none).
+ *
+ * Scans the password database for the first unused UID starting
+ * from 1, skipping @skip. Calls tst_brk(TBROK) if no free UID
+ * is found or a lookup error occurs.
+ *
+ * Return: An unused uid_t value.
+ */
+uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip);
+#define tst_get_free_uid(skip) tst_get_free_uid_(__FILE__, __LINE__, (skip))
+
+/**
+ * tst_get_free_gid() - Find a GID not assigned to any group.
+ * @skip: GID value to skip (pass 0 to skip none).
+ *
+ * Scans the group database for the first unused GID starting from 1,
+ * skipping @skip. The @skip argument can be used to ignore e.g. the main
+ * group of a specific user in case it's not listed in the group file.
+ * Calls tst_brk(TBROK) if no free GID is found or a lookup error occurs.
+ *
+ * Return: An unused gid_t value.
  */
 gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip);
 #define tst_get_free_gid(skip) tst_get_free_gid_(__FILE__, __LINE__, (skip))
diff --git a/lib/tst_uid.c b/lib/tst_uid.c
index af4ef8cf7..93c9b83d2 100644
--- a/lib/tst_uid.c
+++ b/lib/tst_uid.c
@@ -5,6 +5,7 @@
 
 #include <sys/types.h>
 #include <grp.h>
+#include <pwd.h>
 #include <errno.h>
 
 #define TST_NO_DEFAULT_MAIN
@@ -12,6 +13,33 @@
 #include "tst_uid.h"
 
 #define MAX_GID 32767
+#define MAX_UID 32767
+
+uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip)
+{
+	uid_t ret;
+
+	for (ret = 1; ret < MAX_UID; ret++) {
+		if (ret == skip)
+			continue;
+
+		errno = 0;
+		if (getpwuid(ret))
+			continue;
+
+		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
+			tst_res_(file, lineno, TINFO | TERRNO,
+				"Found unused UID %d", (int)ret);
+			return ret;
+		}
+
+		tst_brk_(file, lineno, TBROK | TERRNO, "User ID lookup failed");
+		return (uid_t)-1;
+	}
+
+	tst_brk_(file, lineno, TBROK, "No free user ID found");
+	return (uid_t)-1;
+}
 
 gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
 {
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
