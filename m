Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9D2606A327
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=WXZHxTsU;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Y3WQb/rB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792636648; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Y1v8dJmRIYgstjSiqsd0oAUaaQvrlOANPenlsjuukKk=;
 b=WXZHxTsU0PAvsXw95UJjv2nWUAnDUR0nXN7qj5p8zC838PYJLcqO6vC2Q4uxTpGG6wHpe
 C6mOhZJ/rwKrV5qfAYn25TMCkJ29gere93vyMm/MO/F6jkCZR9qhHsnYfc8pYlpYbmvpl4/
 g1WwdWXMBpZA39j0wQ1cFp170o0V5bA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4CA93CFE01
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 04:37:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7434E3CFCDE
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 04:36:51 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A71C21A00A27
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 04:36:50 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a1e266fca2so9169685e9.3
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 19:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792636610; x=1793241410; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vg4syZwWs7R7NJBbrV2J3WcnUZuLjMGIF8F5j64K/EE=;
 b=Y3WQb/rBho1PlnIh+OP7HWsV83K19wSXvSeG6da4YW1MWW7Oc9/Z2xuKPlPkHWi13S
 3gdyHb7y27X59RrzqvRuQ4RXjMUVejGHKRgjOJ8BTqWuy3+y3UtG5BQpBQm4xqzGVCRN
 3mBYrPzvdJjw7qMFdgRPKIT2sGXpCuLTg4JdSO3Q1ULcVSADobTeAx/UcXJh1g/1oE0h
 yHVRZkaHRlr1dQO++UFu6NKQ942R55FT7NIuseKgU0ldcEmP7j5OYHYnCOHeazUkNTQS
 6PRLGVOLejk91tSmAmedBJodV4v/atshMsZOoxTMrTmImd+q2Z5RinIZJERj32PldEMD
 gyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792636610; x=1793241410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vg4syZwWs7R7NJBbrV2J3WcnUZuLjMGIF8F5j64K/EE=;
 b=METYZkfqIrqvZxj/46WKL0WoMpDUOojSnfogqksyE2G8Z5dTBRHNaicVldODV4yamP
 9YjclgdQlgYqe0EVkpMLLGzwwveK1h7mOLio4pekJgEyC6qmemG2oDzITjqBit154fdL
 cv4gN0JgIgynkK2uc3zaRb+TZs3pM1lk2Fm4utm47k/pBET3L69lHupl4uHCRAnR6wzA
 jdXDgnEYz5llxwqqEY166Sqfi8MOH22Vzdy23BKnVbQ85x4tCl8fYOegiWDwR7dgeOyS
 b3itudWBSMUwh3GFjLxXy7Msv/s1wyCB1rGPZkTLnVli/qC5crVLWzaxUXXqPcWTDYDd
 EB3Q==
X-Gm-Message-State: AFq9FYJDtKgDk3Wm7wpzP8FR8GcOgencYCTJxJRLJHy9YQscGVPUgy4K
 VhyixgV+6X0y/3YVKWdKNd5u1h9y4eXoR0ngoCbLHSMnlBLGhi+EWF1LPwkqMuxsZSaA8/8MEeY
 Vy/I=
X-Gm-Gg: AYBFou27Tl2amZNFvALxoz66LHGYStNqQPzV2xmpj3EjojNzfRp+Bh9U1H4eJjHwFWN
 zPUSeOYFncnethCjFJY/mltPoUM1b3+E2uGAKTMilg/oK4sfBnBAKw1X2fbH1oknScA/DxefteU
 sr/TelxA2KUb4KNvNnrIjvufrvUDDNlqdmFxUznpSmT86glARAkt9M596ePM0VwtkP62wr9tLQr
 hAosb91CRIMkdr4ftZUvUyWpnT4/Pm+TYnBNig+WKQTpUU0FuV0+hSL6oXdepHfaUsxLcUeoXTj
 VHbBviWXXsjgHjaKVwhZBQfr66mw1e7yrzZ5dxk+t7JbSMO9BzKZGbwi4ofwFiCOamGjUGhvxSY
 Tn0xvFhpaCpj2+B5WYdhDdVC9mzTQp7qTZ+0CA6b0TdOHwmo7scEWztgt69UobVDwUjXZumv19g
 gpEVZiMbbVLMWL7ID9CuDcebyr6/7RqGYo0vS0jiUO2b94PONufU7b1YajEwQM1YJ6HHL9/XsCM
 kzNzky6VSrtqOGHlGsG1jAvFkzQRuHq31da7FHgvUoHp9nHMKfGza0lErzTefFsK8qh5aVZ8p9u
 oLFDZ614JFHY+Q77EHHDSc84
X-Received: by 2002:a05:600c:630e:b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4a1fdd5d9bbmr77780795e9.31.1792636610061; 
 Wed, 21 Oct 2026 19:36:50 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a203a3e9ddsm31431675e9.11.2026.10.21.19.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 19:36:49 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 22 Oct 2026 02:28:20 +0000
Message-ID: <20261022022824.19735-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022022824.19735-1-wegao@suse.com>
References: <20261022022824.19735-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v16 1/2] lib: New library function tst_get_free_uid
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
