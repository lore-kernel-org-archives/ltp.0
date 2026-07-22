Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340A4C4452D
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 04:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784695720; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=wgtKYeVsA85eut14uRfRlXwuT2GFD9MCqBRqQTC3hAY=;
 b=dY898cgFsitQNhndgTNMtpRy+caieZnoQuUBuyGYEhMgSkVR1yItyHRXRrpqNwb1CU5Z5
 FkTo2BYWPNyKcxQvV9pmyrwuUCL3M153D7l9zGMO1QJ5JNkx4l79gmD283lRI5a04siBsd/
 JDyuwz8L8Bf4exfrLc9zyFeMRGgzC2U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D6D53E1EAF
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 06:48:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB4A23E1F32
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 06:47:41 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1F937140026D
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 06:47:41 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-495437bb891so46971585e9.1
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 21:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784695660; x=1785300460; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I4mJJ4YmfCyBDEs3dCN1tSc9282VjdeEdrkgOzsY43Q=;
 b=D+3bqLLMJSJwywxoXxWSC0QKQxp9iDKlOL0yZ85zTQWe0amo1vfcAMxs7zkB5eU5dq
 XDUtJ15SSksUtoglNZaEPNpY4g4WhhdAmPLx1EqoIhIfoRt7JtFoFIiM4soX2WpM1+ST
 q9A8y1tkpYHUJEHA6CIEcl9hMVGwKKklBX/TgLqHIa1gAw+77RMfSWpn17CpEthRY9Zd
 vQHCDMnOKTxW3up1fiP6oLOKuh5IrW/PMrAatNRn7xyBse+HgpljpEtS0RqOOpIMtZ3i
 rZ+dUAuRuKt64axy7VnF5ZNTyRDykDRcIXGO3v0HsuMkYt1eG5o0V5M8CRSJtZySxYcx
 TW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784695660; x=1785300460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I4mJJ4YmfCyBDEs3dCN1tSc9282VjdeEdrkgOzsY43Q=;
 b=HgvMTNQ4WjUiEMDky/qMOkbphv1x0If13RIOh7wj/E0+zsqXUTfdLOEthSamu+Ug6U
 V2SPfw1UcPMz5mpewZvHmXd3GaJlefg4zSSTxD7JIYdMgN0WOAZioepK6NvOOIUNtm1M
 4R2S1rMptuh9rfpB1Kgqu5cpGXBllCYKyCniviFTZitppBez8WV4y3ugq+QiSG9P+LyT
 Ss6ko/tckuXs1oLblQRMAgLt94HqZ0w5qfPn4jx8LMxEcI3KVXNalaTBKalhd9qKqTtv
 VjAn3Z/Oxa35lGl2TL9ZYJYDn7W5+jDUQxqb64gw+5CzO55IC8dctk/0uycFOR1LiA/d
 MrFg==
X-Gm-Message-State: AOJu0Yz3dsbJHgYF2p8VtQoI5rk/wR761LNHHVCQW5sbM6pMqhA7IVtx
 zqu/f5y+jelF84MV5bqJF0gU4PUFeNOxqkm2t7XtLXaZZiYEqAiG/2XL3oLgdLkCntvoNK3/Tew
 sqwo=
X-Gm-Gg: AR+sD12rUfBv3CMAbXgMnGno0Xxm6aM4+8guUMgNY3aDCZv2plllgh9a3U+qa+cP3Gw
 53JuGpUle/tYAfqPLrlX83e18zvzC01i+v3dn9tD0BiOLj1Xu3bhr0aW5ioMdiyV0CPPwsk/w0h
 RX7Nv0H44PL2o/5vpMXCXOJuE3POCWzM6Xjam4X5XA0I4mkLzFjDrTTMJzq6Azu4Fz+fjDTcoVM
 0b7Ppp9rvVMRP4tMOKuBlYdO4LAbHW31zwcGYlSk+7xwDxJQ2jYQmRSt7ehf5MXtEg43SxTQ++E
 WFu/iH4Z4or/G8YwWY0oxZpSsXyofv5PMYo8sEJ1h0kp7iPFfthedxXGCcbgneKma2mKsNt4Ycc
 yzCbUqjVSy7f3bojB74Tnkx4CFhGuFmANqIq+ExQC34oTSF4Oo4zSM8sQShIgshSh9w==
X-Received: by 2002:a05:600c:4f52:b0:495:3c6f:7c18 with SMTP id
 5b1f17b1804b1-4956a4e5a97mr21961935e9.3.1784695660442; 
 Tue, 21 Jul 2026 21:47:40 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4956a509901sm73965195e9.8.2026.07.21.21.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 21:47:39 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 22 Jul 2026 04:47:28 +0000
Message-ID: <20260722044732.3547-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722044732.3547-1-wegao@suse.com>
References: <20260722044732.3547-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v12 2/3] lib: New library function tst_get_free_uid
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
 include/tst_uid.h | 29 +++++++++++++++++++++++++----
 lib/tst_uid.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/tst_uid.h b/include/tst_uid.h
index 2237ddcbf..c73450956 100644
--- a/include/tst_uid.h
+++ b/include/tst_uid.h
@@ -7,12 +7,33 @@
 
 #include <sys/types.h>
 
-/*
- * Find unassigned gid. The skip argument can be used to ignore e.g. the main
- * group of a specific user in case it's not listed in the group file. If you
- * do not need to skip any specific gid, simply set it to 0.
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
  */
+#define tst_get_free_uid(skip) tst_get_free_uid_(__FILE__, __LINE__, (skip))
+
 gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip);
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
+ */
 #define tst_get_free_gid(skip) tst_get_free_gid_(__FILE__, __LINE__, (skip))
 
 /*
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
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
