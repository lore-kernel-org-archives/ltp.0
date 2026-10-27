Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98678606A31B
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=MBDcMSOC;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NGvcvQYn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793069394; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=3FxlO13pRbsOLwF0KgCPGHH7WnJNkf5Um0PhGD4qS8k=;
 b=MBDcMSOC2nsSNOikXpp2YDL2qp2gk1UD7QJ9/Phcm54h8cWr4r22hdu1eP/1A5dBnoDFu
 V97k+VLp2HVlF0ov6qgRXvOE/MFRwyqgWzvZHsfiLbKB072n+BO0B/h+8NZZDQDYL3YVa+z
 TxBqyuVR7bksy0defP2Nq1gHBr0onHk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B45B3E9A7E
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 03:49:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 065FD3E9A59
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 03:49:16 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 72FAC2002B6
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 03:49:16 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso2534744f8f.1
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 19:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1793069356; x=1793674156; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uXHOldHaOZARQw8KqT5sEh+1EsPjoHNB2FwxAZCgXTY=;
 b=NGvcvQYnWE+dlZAhMiisjovZ+P18VXXi8FcW5glwxT37ZbACGMKUSfgvgrqnVZtE8L
 IoLE4CcIXSuw/J+oDdckkB3eLBp0s1301aHBmZqT/QiJQdRN3/9ky652dXLjbm8rnfQW
 5cA/03N54F6M3DzdOrpRH2ol4UGdWHCGcX9QnWDX5+2dRgLs+tPd+TY5jvQU4ZwFAiEw
 5HdKwqQD1v89ny7gMpEVASXCFlRmLpIlI8qYS6+GjBI1GV2qFNE6KYw4ZNXmpJ2YpyQN
 z0/fI2XcwWSTTh1lA0T0ZfAIAf7KYf1aJ/C2KKu5AgjR0jJo7psPmE5o5swAU6CgXQbS
 DQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793069356; x=1793674156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uXHOldHaOZARQw8KqT5sEh+1EsPjoHNB2FwxAZCgXTY=;
 b=d7yrh8kpsWZ4Cr+MWLBrgGsoRMkvkRKGhkHQtnM3nwnGkz8v7KiNdB/4Kv2eGH2b7L
 ixZmed5lu2gecCzrTS3rpHAQlcjpek3zy1Yg8nDGcXXGYcASs6anhHVjZxPsueR04Dxr
 d4dMx+jdL3/h+xON7YEqDrJrjjWmfV3XCpI6j7uY+3Lc41LC0vBZIfedF8mV+Cmv4wDR
 Nt4FYjz/yWLGcP06Rx1pG/VBckbwESozklhhY5H1IxZhJJNBO5H44R6q9IGFq9SbperV
 esR1rF9YkojpgqWxkmOvPD0y+IqgR7TqK39/m/hi+At0adf1b7ajN3XCgY8AyN+D4C8z
 VguQ==
X-Gm-Message-State: AFq9FYI/WB04ontUVUyFFdt/Khe4YF9Gnt6/WmBjQAHc4KSJo+Rhfg4N
 cKT6oVv2CkQ1geO+S8wEo/qust+Hcf86ODeXwSXmsOYdwF3OO5E8KKM6ZznxAbScMg1Gj7OKBEr
 4ulA=
X-Gm-Gg: AYBFou1oyPCWcPMm00ShSIupNK/Bla51InlbbEzkBRM/Uh5IzaUtKQAK3RwqoU2lzSq
 zKDTKcPqpNzPN1qdBomU+6Lagla/wNM7H6pM4KQarMyHrDw6XW9b1LJKIx+W1XRuFJvsuluABXm
 wl2IiBG0cdJJw9zMS22cbXIqoltH5DvRMNsQCBB9TwTH6gKBocDAYr3DiVlH2I0Dj0122ars5LW
 k8MeYDe53NspisbGV9ablGgGPP7+n8VLXNs6x6QjyygD51L5GCk/zYw27P5dUlHR+QegehAKCIK
 NL0Mw1Z+tncoercXgR9R8SnwR31gxw/fMn7mfqD7FGKHvG2VI80fepcy9DGFLTZoBPRUGv8Br3n
 pGRpjndCDce0EkSXR4qAV4JCzAIlM5JCOVC+F/w9VgZ3eHxuA4JPGwQRgnuaAbc3jZqUPWeMYga
 D70pqrbLmxmVIDIqx3VMLW2jSo0dJJkVaoCiyOD9AgSIpDfY59B/FCkfS1mNJah5aKnSD+Z358W
 3vyxrZNxcWV+mQDiWzGqO/H3nEDSFzacA+FLyIiy0WW0L7ZUm3OtazYtRjB/Br3VaKt45+GDc0l
 wdj33PUD/p+LaajNDZ93ZQN0iXH/s7Ntv0ra2NaxjNNK3g==
X-Received: by 2002:a5d:5e07:0:b0:48d:fbf4:8961 with SMTP id
 ffacd0b85a97d-48e3eba0c41mr15591973f8f.23.1793069355832; 
 Mon, 26 Oct 2026 19:49:15 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-48e3ebcb902sm20800630f8f.24.2026.10.26.19.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 19:49:15 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 27 Oct 2026 02:48:59 +0000
Message-ID: <20261027024906.31789-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027024906.31789-1-wegao@suse.com>
References: <20261027024906.31789-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v17 1/3] lib: New library function tst_get_free_uid
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
v16->v17:
- Align with tst_get_free_gid_() pattern: set errno = 0 before the loop
  and combine the check (ret == skip || getpwuid(ret)).
- Add TERRNO flag (TINFO | TERRNO) when reporting unused UID.
- Add Reviewed-by: Petr Vorel <pvorel@suse.cz>.

 include/tst_uid.h | 14 ++++++++++++++
 lib/tst_uid.c     | 26 ++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

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
index af4ef8cf7..09a1450ca 100644
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
