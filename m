Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A519C982D8
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 01:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789782853; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Y1v8dJmRIYgstjSiqsd0oAUaaQvrlOANPenlsjuukKk=;
 b=nSjCjKGBlCeRnwpNoaHPC9inxhbC4+Xlp75Sy6ZiU3RyVaOTQiK5zLkfpOhKyWwra6Uto
 ayXDyh0DjibzbIYhk9Y1A5geg0ttuuImWZpNvdtgNEP8P50lNQtlXSW9cxgsgPG7/edTnzc
 KWPlkcJoz9ymp2EBtrJy+EvB1JNKIuE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6ACFC3EADAE
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 03:54:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B65613EAE14
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 03:53:37 +0200 (CEST)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DBE2A600D76
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 03:53:35 +0200 (CEST)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso11034325e9.3
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 18:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789782815; x=1790387615; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vg4syZwWs7R7NJBbrV2J3WcnUZuLjMGIF8F5j64K/EE=;
 b=JFBT3IxNnqKOrTS0dm99Cy6eHpWvHlvPPS1E1Fm81DjXczoaHEONHQgasF5sWDuBYA
 q9ZAZq7DJMthsTWUwnQG53YA20HNQ7E1yWTJae9vFR9jGqxPdWU/MtlzACSuM47duHwL
 YVcDGWLbnKF0crA5tDzYtqweHkP2GYMi4cwAMTnFAfX5rAxiwGVMrou69wZSCT/DKArD
 MAUubxf67Cqyfmq4S7RXCmCXG7Kacb5PpUncXGGhJiD9EfdHrSgQgjEIlAlRxG7HYtKF
 omd7yWyRWYBLuSU076g2tb4lqgcINmL4SAiq/A+kNafcHRs4JVC6G4i3A0XeiDWo4rf7
 kdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789782815; x=1790387615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vg4syZwWs7R7NJBbrV2J3WcnUZuLjMGIF8F5j64K/EE=;
 b=PJgW9ObHO/gPf2Kpi7lgf2O2Y9Ib+TQwcfCnfX6P68OIDn5vrvunUt6733gyK8opva
 aPmIA9arsiKREd0/dLeIcbVffL4opFru7GsU1PLDi/L8bT9+UYXTlexOQzzDjxj/7Aze
 plgGgzg0HnkLT2tbpbcRNpwMqbNF5cFDc/vyFstKsTUxnUX3o8nICa5IWCoMpJso1hRs
 nrS2a1G4V9t3bzFxvLtnAU5peQim5SRFpwSEZtVq90V9o0kngZ1BV6xaK4G6kQYONWOL
 2exsUt3G5NqD4MXNd/ATgIduAEfVa0nUo0sM7feRLImLIcgphgLGR2PG47Zl0i77jnkL
 FYbQ==
X-Gm-Message-State: AFuF++mO1T9nigyfIG95d8voH4CFCCr2+NANQMBKixqa7nx5nlzU7faI
 1H4FHViZtQrKPyTQiP5QFE4To3jPOWHTNrYfbTdBsnJANZL3k8UAVoeSOi7QvGJLHPjRq8puzdU
 TZTQ=
X-Gm-Gg: AYBFou3w97HhU+NeyyyO/FL5F5St1tPLWasXeKT/7Vf3F/AAUPMtOZCTnsHP69yniFn
 pz0OtYFa+ylR7032qEO5gX4QH2fCNmYJK/KwwxYTFXCPDKIT4H2kIWOemvHgFD2vQBZEEx3KyX1
 W1w504E6Ajab0AyVNnMVrl7AWqWf0fhgNkVgraFVP1iwNX6PSBAYg1PA+YFdnMhg9ZoUQMr5gfm
 GgJ6WKp4nO1LxDr1zBsxIYJiJ94SJFQZD17+uIvKL1HCCfccym4YI6C7fE4Gef7bccMGEqjOUhE
 Pscj3a7/VTsL5f3B0mPeC9CVNzIzjOo4eKrpr070OZBTXa9k3EhjGH5LHXbAyDMB11g+YCwmABw
 LNzHH46Ld6iN6GfCl0hsfkjXOKKDZjnFL0QGOENQjned9r8LaPCPOpnQ3zthzOJMxFk6QyoDBU5
 J+uprwOTHNzmrDI7AkTYn/BE3iDd+miQxIU53EKU1lNdCl6p/ZjNlnHoBgNy+3K5lRcZf4pmcoE
 2BTMu2ZAHjrS//lAZG3QH0cJDAljdkw8rloK+4bIKw=
X-Received: by 2002:a05:600c:358a:b0:49c:fa20:cc08 with SMTP id
 5b1f17b1804b1-49fc5741844mr67337075e9.31.1789782815339; 
 Fri, 18 Sep 2026 18:53:35 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49fc5755c40sm102141105e9.3.2026.09.18.18.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 18:53:35 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat, 19 Sep 2026 01:53:20 +0000
Message-ID: <20260919015329.22042-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919015329.22042-1-wegao@suse.com>
References: <20260919015329.22042-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v15 2/3] lib: New library function tst_get_free_uid
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
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_uid.h | 14 ++++++++++++++
 lib/tst_uid.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/tst_uid.h b/include/tst_uid.h
index 2237ddcbf..03f9dc073 100644
--- a/include/tst_uid.h
+++ b/include/tst_uid.h
@@ -7,6 +7,20 @@
 
 #include <sys/types.h>
 
+uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip);
+
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
+#define tst_get_free_uid(skip) tst_get_free_uid_(__FILE__, __LINE__, (skip))
+
 /*
  * Find unassigned gid. The skip argument can be used to ignore e.g. the main
  * group of a specific user in case it's not listed in the group file. If you
diff --git a/lib/tst_uid.c b/lib/tst_uid.c
index b0b087362..47c267bc4 100644
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
+			tst_res_(file, lineno, TINFO,
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
