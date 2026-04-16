Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BF8F433D2
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 00:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776301015; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=CW7OrP7WiIAbSO2ZrN0BAtBMohc0i7ydsJRF5dh/TSI=;
 b=mwiKXsiwmt72sKAMq6NA0fCH2OiFDzrLDlZoiqqqkRZ6/CqQ3tK5X9WW7JGbeUvQGgaYP
 GS/hHsRi6PosLFBpxHaZyhExkJCGuKfxOdzb4M7XfyZZ+4D/6emnvpdXDBUxzZQh4Anc5ja
 Tkc44ZgzrYgyqHCbPFrfXEefcJuZp5o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11A573E5E02
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 02:56:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C01633E5DBA
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 02:56:09 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 036641A0025F
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 02:56:08 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so3646670f8f.1
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 17:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776300968; x=1776905768; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXG96hzdr8AsF7J2pEPmsFfr2LG6zdtRgzLGip5/aw0=;
 b=ZfFfIfTqlNwJemYAtKTOMx6q6RvCJDSy2imPCHwhz3giPaZ+oQEwiQuoKHSVx1nys+
 oempRfr2rVvs8iGbPy2V974XYawPC5XOhz/pt2pp3/0hMjJmUW8FBwzJh7ql79Ze4ds2
 2RnyOxLAr6VQpdtZLk7dkbaD/SW1Ewntcw/hteRJa5PvR41XfwGtYBvz5Fiy4MlNLUFy
 5Y2JCx/OStX9iJHXbdEyjLkB7YgLAVcTFNkCZOllzGHag7r6XQmeXsb6f+WWlsOmjLkS
 jGsspkUVBwzAUvB5nbcjxuC0eH2r0V85QlgHDIa/CvfPYKk7+12llvbRoG3UJiSrA0Hd
 J/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776300968; x=1776905768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IXG96hzdr8AsF7J2pEPmsFfr2LG6zdtRgzLGip5/aw0=;
 b=RAY3khiUKCslGc5joKHo+63Y7qyyQc2usAFdoPulJNmx2sHp3AjrlehnlxB0MdRwUA
 PsVTbGM6YBX8/XFuP67c1okxU7SPNKMGlyILL/Uw6hRp9R9Qz8FF3IErcMshn5lRaOLS
 ADH3m4xS62PNGKl2PVchxqHWdQAffTwsN0c74oQAznRvGUXtORI5pdYPfB6RwXvLTAj2
 dERpp9ZPfw5dAOTgs8R0/YUyVSIeAzz6FiwQoAyL6L0Eo0ukdqDjSFvVfWwc6bMjJ3mS
 QPqt9ZgDHUnsgXN9qvAMvFmRzpUU7gq5haiPcZ/+/L2lLHmqqH2rCQwLfRjs2iez/I+C
 vB+g==
X-Gm-Message-State: AOJu0YyqWfau6lGUNaxkyzptfyf2PPo2Uvjv4mEFG+c4P1WRddzsoIWz
 r6ta7QBtS/85H9FHDvSehwhKo80MSMz47x8ieGRIizZHAMF8cE65F35+way84OGrp3EKcgtFk1f
 8aQ0=
X-Gm-Gg: AeBDieuqnzgnpRGfCMQdgRD3WZ4VSfkTgYUbRBCD7rIYWRfkVJzrEfdbhvbgNO8UlZe
 0mEioP3tAn6r7phww0q2MmoH1V6uIx/V7yaWtu/otPaxhGKHZLHo/Bs1idwNFJg7OJ59leptD+L
 pQRuN/W/Em9OoHrifzVEvbPbuUxykXdFX53w6/Sw/AWiSlskt2/739/GB9PAZ2+i/BkuHkV4Prh
 Z+8HswCC3wQDsKSkSL3WS5bJ3SjEOO5RsgKqEy3LlmWJyzRKZrpOGuMDP5p0t1EDVC4mENX3teX
 RVpyvRXDy9Svk4KO4Bdfz5LRBrN8QbCdPRTOW3+TCLGgKZIx21YqCVlFtiuV7PDB89bDtjCok8P
 6dk+7OrLDS4VRvxbtzM03oVWWFqTtNwTenOmGABmLD1V3n0MEwFTNCBkw/WKWg2VjxBLx9Y8H75
 a4SE3q2BGCBA5wxlJt/VUCTw==
X-Received: by 2002:a05:6000:250c:b0:43e:a8ad:975a with SMTP id
 ffacd0b85a97d-43ea8ad9a92mr10985651f8f.4.1776300968014; 
 Wed, 15 Apr 2026 17:56:08 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43ead3e89ddsm8742710f8f.30.2026.04.15.17.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 17:56:07 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 16 Apr 2026 00:55:22 +0000
Message-ID: <20260416005603.22427-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416005603.22427-1-wegao@suse.com>
References: <20260415103812.21999-2-wegao@suse.com>
 <20260416005603.22427-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 1/2] lib: New library function tst_get_free_uid
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
