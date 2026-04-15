Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4481FA0C32
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 06:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776233296; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Y1Fq/VTsrXS1gWjpuCgjJus0EGxtUV8jnySl7AI6ngk=;
 b=pZJMknyRkcN9OHdjnlwM/0xbk3SrYV21FG2aNTjQ3fbj+XoXHwawEritqqDyBP7xXkkV1
 RdZbD+zx9wGSIWqqS2Fb5UK5sP8TxQFExLtPv5EaiRv4A6QXieqN3l3RTPy3H0/3fm4lcs7
 jHoHJ/3cOA2yxomaDKGGNkkbWMq4HIk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37EBB3E2663
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 08:08:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 896C33E2662
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 08:07:34 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B64391A006B2
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 08:07:33 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso59456485e9.3
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 23:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776233253; x=1776838053; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OHXW4iAKcO2NG9vmM7k/KQaTY3qyqN1mz5wOzdg4rS8=;
 b=HE43BhHa5WhRMnXQGbVew6mqJ9Wz8RDxMFpukCvjmW8hgc7r/pA7RpzrRqgHnrwBIq
 LOOyugKX/b0Uftpe/JJLSCVrqkBNpPBsE32KTVyurS4o2XXQ5VsKjv24EeLwyuY1Wuz9
 YSfl0YVmhuraKFaxpYoo93Q9JQ1Zhnm5SiVERV5jjepNSHe1CyPFyYHhK2E5SHxkIxMx
 KAJc0hBLkoBSxDjA+hZNpEQ4BugowYMHgPX/Sw26QBb89KJEiMQ+cyIljTlzInUAQtEm
 gEuzdcq8DdUO1/op2cnhE7dnrk3zswUOpre5gB7jhLtWwnDc9BHhT0bRI7wMaKGl/07a
 csgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776233253; x=1776838053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OHXW4iAKcO2NG9vmM7k/KQaTY3qyqN1mz5wOzdg4rS8=;
 b=JC8YG1hWescYkdQcgIficlQdzelYLvQ/we3f5x1h0gDdgAAEL5/5RmTxW1drJTy2xK
 ZisZqzk06l+V5TuwnIO/vvXYP3v8h5NPeHJ93iGTRi/ek/lL099/COtxRdQvDWuq8LF1
 qJrrFVBnFrQnC7VYxss4kw89539fR/1wlMcfpKgydwc9liAIzGnd+7XnVmBeBjul4E/h
 rTu3UpUJTrKxlMEcajMIjDma+hIxGLbn0p8a4tRVbo1/eShaUmf1xBhoXNu4pVZb2xW+
 J3PbJ9N16lmnntzY5pjPZj8u4Bb+k1rLYklTjtEMe7AwkihCCvc9V0/QqEGffKD1t1Pv
 vmQA==
X-Gm-Message-State: AOJu0YyLL+8vDBNaRgZ0I4S01UuC9th6s0TLSFVS9xKjvctzFZWWPtA3
 oBrZYvqKCSRdSSRlpo/9BF6WsLiZkUp0oeQbsm7oPbaXjrwMc5mOA0AF+ia4jrnysb1m9BtFYrl
 3VMM=
X-Gm-Gg: AeBDiesyqN19SHVZJ/LkiAwN7IHDIaKafOkhMU5CGUJGDJnDJrg4gvt2KhdHjrxA3z3
 ia06qeME7glawUUZB4Sa1ys/sKMTZifM/vOiprYIPY/yqGcMIAljCIO2IYoo4B8OFmewP/Ywn/L
 HOQXVzylRMnDxVen0wIGEuRW4JjzmhnO4wQjSq6syL4SNn6IY36l5EWWjeGBMJQY5d7yCVxJOxU
 6bOau3XvoWAwNDEgagGd5bEo5QGALYoN93K6XAurkqin87dRx5rz069AWUvGtQdw2kAneredIkP
 HuM2ZTOeMqMpc2g4JdwJeqU6VVxFv2+5q+zOZXELI0mpxvkP/SLB2atbGdfMtPevb7aYqyETkOj
 LuqGuQPTVtM7h01LvOAO6NnDNCNo1DIdf+q/TK5V+pMB8j10pG1rUfznD86btObJwNn69GIkMnB
 Ii1a4r6jUOQys=
X-Received: by 2002:a05:600d:1c:b0:487:1108:48bc with SMTP id
 5b1f17b1804b1-488d6836d87mr212468785e9.17.1776233252767; 
 Tue, 14 Apr 2026 23:07:32 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488ede1e050sm175159005e9.5.2026.04.14.23.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 23:07:32 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 15 Apr 2026 06:07:16 +0000
Message-ID: <20260415060728.21662-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415060728.21662-1-wegao@suse.com>
References: <20250723154610.3860563-1-wegao@suse.com>
 <20260415060728.21662-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/2] lib: New library function tst_get_free_uid
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_uid.h |  7 +++++--
 lib/tst_uid.c     | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/tst_uid.h b/include/tst_uid.h
index 2237ddcbf..394cb3edc 100644
--- a/include/tst_uid.h
+++ b/include/tst_uid.h
@@ -8,10 +8,13 @@
 #include <sys/types.h>
 
 /*
- * Find unassigned gid. The skip argument can be used to ignore e.g. the main
+ * Find unassigned uid/gid. The skip argument can be used to ignore e.g. the main
  * group of a specific user in case it's not listed in the group file. If you
- * do not need to skip any specific gid, simply set it to 0.
+ * do not need to skip any specific id, simply set it to 0.
  */
+uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip);
+#define tst_get_free_uid(skip) tst_get_free_uid_(__FILE__, __LINE__, (skip))
+
 gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip);
 #define tst_get_free_gid(skip) tst_get_free_gid_(__FILE__, __LINE__, (skip))
 
diff --git a/lib/tst_uid.c b/lib/tst_uid.c
index af4ef8cf7..deff17085 100644
--- a/lib/tst_uid.c
+++ b/lib/tst_uid.c
@@ -5,6 +5,7 @@
 
 #include <sys/types.h>
 #include <grp.h>
+#include <pwd.h>
 #include <errno.h>
 
 #define TST_NO_DEFAULT_MAIN
@@ -12,6 +13,31 @@
 #include "tst_uid.h"
 
 #define MAX_GID 32767
+#define MAX_UID 32767
+
+uid_t tst_get_free_uid_(const char *file, const int lineno, uid_t skip)
+{
+	uid_t ret;
+
+	errno = 0;
+
+	for (ret = 1; ret < MAX_UID; ret++) {
+		if (ret == skip || getpwuid(ret))
+			continue;
+
+		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
+			tst_res_(file, lineno, TINFO | TERRNO,
+				"Found unused UID %d", (int)ret);
+			return ret;
+		}
+
+		tst_brk_(file, lineno, TBROK|TERRNO, "User ID lookup failed");
+		return (uid_t)-1;
+	}
+
+	tst_brk_(file, lineno, TBROK, "No free user ID found");
+	return (uid_t)-1;
+}
 
 gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
 {
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
