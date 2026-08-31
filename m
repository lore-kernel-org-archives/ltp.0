Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E66C61DE2
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 02:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788141693; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ObJT/riAzrp9fwt/GUR9E11saRv3J/gw1XYqCyWIA0M=;
 b=q7a3n4pt+0XCqDImBAyJCIqZHzoSIUmo/aSYkqF1qZtgfqzwxfkdYrUQtlj9qVzDc60BQ
 7UOsh2930DkCPww5bkvy7aDxOXqiMlozcmxRMwWPK/60m4fp/z5c07W7lUnzVDvHKgdreQx
 ffhqxUJVlxL5AygtFByKFxLU42KOXKM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C9243E1EC7
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 04:01:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06B373E1EC7
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 04:00:36 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2A49C1A0037B
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 04:00:35 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so1254502f8f.1
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 19:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788141635; x=1788746435; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Ti0Cer57K6Bh59Hj1G96o7UEZuvEpkNT7RClu8aCwc=;
 b=NDk0OEnTdavn8qjSomMg4KEI9blU4+gViwBJivC5qiOEqcJuTMZfpvYPvuZSlb5Etl
 ri3Y6eRcfe/KtyGxmFzMGx/AwhFacZ/lVJobTnQRIM8zRRAlE04PogZbRcGAxLPDqLG+
 lR38LDsUKXzE9DdlwN1SbXRIQpre41di7VojemAHgpsi+TT8WEDTaa2sjzh9NYukxFbr
 af8w5mE8gh4FYtWH+eZ3EkNnZ8XQvaW75PrTc3JebWkmJpZ5DO8ViyK6uW9w50VOL2Lw
 AfSxeFG/i3NZ842PQ8DIuFvxeR7YxMlpI1Fm9ZNj4JWoIcggMhzJT7Gvp9CRqKdjW9Su
 +LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788141635; x=1788746435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8Ti0Cer57K6Bh59Hj1G96o7UEZuvEpkNT7RClu8aCwc=;
 b=rTrlq7gaSIg5ieuynWk6f2kT01/RqUja2zsCw0abMVBcgYc0gcL/gbzzQy7wnCgUs9
 cv1axBOrqWOY9craStYghsUDSPGgCRQdkiYXsXuCXT2FOZqqzTdlwKAPVkJoglW+JGYq
 58+56bfY1yCNkcTrxltRaBufz0I93kEqD3OrmC+dT9GscFtLiMP/TSvuD8KaBnlnuLNe
 KSGEODri22az+H3oQK2rXaUPfCfN0YXK7zQ5HGDccDPVGsWgZZFmKutdRBw1oWKREYpD
 6Z+vy3DondetCUeCRoVd7kt11ljlTPe+84xlvx+m6Hg4YZothceurs6267vIZ4GxbSXg
 yabA==
X-Gm-Message-State: AFuF++nMCm8RO/amMHXDGweXvAK2ihV+0AJaVSn1HbBid6lzuQ1zYlFf
 sZglqrLT7xD361/vEHH3V0JbGV+wgVQhRfXDdFn0j+oKqqSk2nKB4DG6ZW8KDNLzEgwoc85lv7B
 8imI=
X-Gm-Gg: AR+sD11ZFHB6IYQEqmHq2L5v0EWVFxUUNcmLDk6QJtMkA9wWXdPpT9q9iHqjCgIj7Ah
 1+Yc7Me1I+Aa3mmnoXkdGYb3xIZUqjEgPJ0N4FGf7qqfD8ZYp63b8aYx2s6kyX+HCAoXlftQzvf
 AhPVR2wMxNvlhW92C3kAm9Igu5qqwV1mvEB48r2X3493aQUdVpppXR4gYpx8MVrgMbvAxzApp/x
 U9g/p3eD8Swh0CsvGnBRVELSH5O6ejTj09CQZMn19hu3ymbmzd8Fz9Ku2RAbPdUIgd5naU474vV
 57xFe2aS5rk5wGUyoHHyZ0Wq54mJzmUBVdcGaIXOltpWRb3JePCr1KFXrtGsyrOa3PDZiGdvsHO
 zXjhnw2q5cT+fUvdXnJXIAapdqPCeuGN080BIVGNSx/ylhxuKKwEVggBw76hvmw3JEULVQbPp0T
 a7CbIl1zmj3WAKf3sj6nZu+tscY5vjr4ykdWO/eTpu+3TQ9zXI/vJAIsFSe8AxoyKnboEYSdQgc
 /hDkQJEdS3ATWZYvFkFyddSJvl7an8/
X-Received: by 2002:a05:600c:a03:b0:499:a8bd:1930 with SMTP id
 5b1f17b1804b1-49b91c20ba0mr322175835e9.5.1788141635419; 
 Sun, 30 Aug 2026 19:00:35 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49c44feb966sm223790375e9.6.2026.08.30.19.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:00:35 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 31 Aug 2026 01:59:46 +0000
Message-ID: <20260831020028.19193-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831020028.19193-1-wegao@suse.com>
References: <20260831020028.19193-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v13 2/3] lib: New library function tst_get_free_uid
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
