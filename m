Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA0BC43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 02:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783391444; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=puWAnZ+pq/f+ZO8zdVIjW1oBiCUYSY/rdnP2MJH51as=;
 b=VWUbzKWWOXWggcCxphvltnvMQMObeZOq+JBnbtsNj0nJ0DV4DpXiK5pcOWqsYxo13ygAD
 Nh0wJ8HU78bjM+w9XK3SnAsxrmJlNBhU7vCugn0bm050gnY48WhiokzgELpvglxb5Smdzs3
 YX1FtgaSwH5PdeTG9ck7bwh0xKW5tGo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 170FF3E5E01
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 04:30:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B78693C92BA
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 04:30:24 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4533E20074C
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 04:30:24 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493bfe9f886so19815785e9.0
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 19:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783391424; x=1783996224; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBfMo+Ttq/V0HZ99B94CyCVE903HCAJ6oF5O9/U5jHw=;
 b=WLmZMcXsu8Uf4oAcBMff4qQ8khWBQi9frDhNFAIG2uSyng+/LCLnhtaLvcp3MPGM4a
 YC93hkLQxI4eokHq7jSWsk6gim7vfLeO+fAfdu9CnmsTVZ9tSq8/DuRtFFwzM+LUCWSK
 V72S89gsqq67KGq9Az4NNq/wN2iRZPsojSed0sAa4CT19Yla9rdEiAT98seWn/cBnIYG
 pMfacvKaAWp6Zln23fW+rnLwqACjBaw8EAX2bps1vV+BFcyN4EC3WsyC6UGRqgyNnzFb
 yZydKPgBDEZq3nYQ4lgX153mhX47YvcZH05EG5ziJru01X7TvKyCdOKIqPXczKJMxtsA
 ZphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783391424; x=1783996224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yBfMo+Ttq/V0HZ99B94CyCVE903HCAJ6oF5O9/U5jHw=;
 b=Xi9IGqHFTGtFhx+zmwgzwmIa2RG+97KustQkBFK7bmuEvJu6vEdZtCCrC+IRSEn3zg
 zLjtsMlGSxYFb13/bqJFsElW0axfg3knhZcYGP3F9sgxJoirIb24ot3SUc3Rypn5DeTi
 dLbGJ4y9wcQChtd3BUpmtIdR4OovThPdxvA/Fyb/5HZ4B/CCeqqD5QRmydcr9Dcgsf7M
 tMsoBi4ZGBG0/ETbjIKNVynVG0YhqyLvkZhlRqQ77KUsSAZQm2lFM++/HqBnEQotFIyG
 75ctxVTaaMUA4k7SOS0Qx6KWxYYk1epCuNmFyBWxusCpjN+RPKR2cFmM0TigZpVtIxaq
 oZ+w==
X-Gm-Message-State: AOJu0Yy0zgahTiULeIC9uhDBA0sk7UfNfgVjhdbjJDXF7d/Fs6tUgVhF
 Zfqb89U61YfMDLrbtw/DnXleraxOHQq6KT/pbzPtCIQxrJIO5iApiuSkkUYGpmzSILHXLzPvrfF
 3zPs=
X-Gm-Gg: AfdE7clyKytbCMRQnfQ14MGKcPxMoOyhEZsdFKkNNaUDLRgQUAiQr55oolKXDIRpFB2
 pNTKaxsMVhT/rmY/t5tgUW9ForCBrZMOFc9k0dODxX0XoBZaMVWmsnYAspBUyB8i8/JkQqIR/TL
 2/XDVslKF9PtiGBS0W1cLGghg/hqLvSkAETUkBWn39mVlyK9W1y4HUb05sJbHEw/W3XQEOyAzMu
 aR0pAJ/Tti4idgeWUrW1VSjmLtKHk2P76UK4Kw0ah5gesptMiOS+qypd6qv0+2b/WXQDoZr0Pac
 oJJu2E9J5BOHQmLwtKpUXDSLBL14bDHMcfJdJB2YwgSAFHNuLV6ArYw4Fh2CLRFFwcNdX07Pjxw
 g7V2V7RGdlO7aJPGf1CsnvASy2yosg7NLORgMVr3O2Po2WJS8hDbn1HnXNnJkr+YF9kH2YpAEz5
 xahBiJ7LWPvRk=
X-Received: by 2002:a05:600c:1552:b0:492:5551:19c6 with SMTP id
 5b1f17b1804b1-493df0413f1mr29714625e9.7.1783391423538; 
 Mon, 06 Jul 2026 19:30:23 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47a9de1d910sm28732945f8f.6.2026.07.06.19.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 19:30:23 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  7 Jul 2026 02:29:41 +0000
Message-ID: <20260707022959.24088-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707022959.24088-1-wegao@suse.com>
References: <20260416005603.22427-1-wegao@suse.com>
 <20260707022959.24088-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 1/2] lib: New library function tst_get_free_uid
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
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
