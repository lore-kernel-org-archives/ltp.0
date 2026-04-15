Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7178F4198E
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 10:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776249541; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=CW7OrP7WiIAbSO2ZrN0BAtBMohc0i7ydsJRF5dh/TSI=;
 b=VMK1pLWmFiebNN72Yv5ihfaC78NAnAQ1fCb8vKo27Z085EgLmjxLxbJRab+NQMSPFbRWr
 Mx3Rd/h6r/UcNKl2LbVYyW68v+X3Sydgi2GVF4F04IDMxYP/44vsWNIiT8sUWoyJm9nUV8F
 Ihjz52Gp2GTaTgTiZDbnGodk9hlly5Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70F2A3E5B68
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 12:39:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B9C43E5B63
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 12:38:18 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4FA001A00143
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 12:38:17 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so88191215e9.2
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776249496; x=1776854296; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXG96hzdr8AsF7J2pEPmsFfr2LG6zdtRgzLGip5/aw0=;
 b=AhGPfzyNgK5F7NFUTUjW/8wwECmupNe4vB5qOmqIekdg3XcMOJnh1pQMWUufeDPx9X
 6EOVPAVgfs4cWR4zkiY1mfXMM/QyTVkwTf545cT5HrjjZ7b842xifwl+CgqX9mu+qELc
 CcVWH5AdKtQ+hcJBQJ8BKu3qRcWKKzw9AHMgWljantObfetHC8YVJheawUZxv4oc91Dr
 xwUlovYUFCgv+Q4dV7GZr6kCB14QmkRmYZ7gdvpj8MqVPHIMv83CZSSxkTmmhiIg7LCF
 CntloyqKRAJwBdUiNl2/IBukheUdvkLx6ZBZYhC4ykixIy5BnP0C0KCp++0WapfMYSCU
 uVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776249496; x=1776854296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IXG96hzdr8AsF7J2pEPmsFfr2LG6zdtRgzLGip5/aw0=;
 b=HtzsV+arF/38NsHr5ADXVU7qWSVsl3Prs+DNYzlpMS6xLddfVP+l9csmRiHigj1KLh
 nhT+JC59SY+As2AtD4Qkz6yG1usUiFgHm6fiEzvOM6EE1lQ4s9/uqSbXxRSzYeG9XxGo
 +5yTViqgNMI8u7n0xlQUMQeQyfLPFeFCRtC2FfHsGqcn94AOBXNZbu1g9tUWFsdpwGix
 ZQxSbin6Tn5T3ddCLWKOtm98Z/5V2whS7f6OCE52oJSKNChSjC0aVR71KKPvHkSvA8uH
 nCYOdRew/nXA8mQ0w+K0dW80ipqgvfqfAlurW2uobCwRT95oxlGCfRwRT+EUy1X27bqJ
 DO/Q==
X-Gm-Message-State: AOJu0YyPEFAViL4elWYrknAwwLEsCtZIhOat2sikl03a5j0Pp3N9tDSs
 M8iDzolzVpBvrCZXszCA3HBg1cRxC1wKzm0DnMumGKtE9fiI66uMh0uWZmXBJNOmeZN4jjULma5
 QVbU=
X-Gm-Gg: AeBDies1XKZgyZ9KDO6SXkh+and/ZadxfGOGg7AEO+sp+C9eZS94XQGhUN79JeYOi79
 udj3gKJFwIgJChKc0/XjnrNawBJ9lrxULrsTIhyGHflHHwnK7iVR3JBBY5s8gLwGhrFm0b5Z6OO
 DuYroV/+6QNiq1snjt71jp+6BSubb8h/bwzuf47URfNA0yB8S2rvadGKr/SiV52ACb+H1HhvxGn
 SdED5P7dRDI93+1wpMJDbFzeYr0c9Q6Gdia1WE+2o1QUSChlNAO8CS2A179+13l7JhxIqNv8piT
 9rl4c0uH4QiaOHwrnThixr6IUTw+/kBuCtVSZQ2YDesoTBQe5LAB2O7V1WUg/3Omrt8iK+Ml322
 1J7wjN9nl0JQuiP1OQR1l9ESQCJlLw6/E5oYKpEMhqeDL4zjDtH6m/P85l4/QApzfMfuM6AmZDC
 V3LQbFGZLIUEP5uavfDRnlEA==
X-Received: by 2002:a05:600c:528f:b0:488:a82f:bbb4 with SMTP id
 5b1f17b1804b1-488d689d0b8mr283477635e9.26.1776249496433; 
 Wed, 15 Apr 2026 03:38:16 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488ede1513csm132925875e9.2.2026.04.15.03.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 03:38:16 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 15 Apr 2026 10:37:54 +0000
Message-ID: <20260415103812.21999-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415103812.21999-1-wegao@suse.com>
References: <20260415060728.21662-1-wegao@suse.com>
 <20260415103812.21999-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 1/2] lib: New library function tst_get_free_uid
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
