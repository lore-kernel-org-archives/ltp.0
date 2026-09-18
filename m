Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E242BC88E75
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 07:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789718018; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Y1v8dJmRIYgstjSiqsd0oAUaaQvrlOANPenlsjuukKk=;
 b=Jnu/3Jm+F4QGL7rq3Z3i4B+5oBcc1XyX8IwOR8tR20VYCzPNRf99Gl+f4iGI+uRuS3iqe
 sa/409VJ381iH9ov1JHoPIL0PX7+qMtEv1A6YmJWcRg3903Hekv24Sznom68AXqA4axAP4g
 ZXXcEVfodgXUum4ApHWQq+vdUb5X9RQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78A423E73E7
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 09:53:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C7AB3E72A1
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 09:52:44 +0200 (CEST)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 891891000357
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 09:52:43 +0200 (CEST)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48434392b02so269516f8f.3
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789717963; x=1790322763; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vg4syZwWs7R7NJBbrV2J3WcnUZuLjMGIF8F5j64K/EE=;
 b=EHfrR0t7pSV6L8VmUfN8kWY1oMsTnl5bFsHoCk6zFDoFt4N+SWdngE+d46cJgYCgcX
 BQF79iokbUy35GYX4P7u0DuXu/RCdywHF1+LA92WmbIeSMYIZ6xPWVLl6ap+KJf7/2Vf
 wHJ1GeZuqnmqyzGJ6ArBU6ky6vQMoyi320ReF4AD9zQvbvPlO+jqLwYeBf2IncXYZjWr
 +ux/L5vWSE0iBeEkRlEE14jxDsBxdKYx5kXgDXp+CAheF8D35ycBhXe9aJFhqfxX1/Ko
 bt6M/Wm5Q1lJCguqAPwe0oFsnQpNjLH7eOZNaG1zGuuZ8wI1oGRLYg+GXBfe01wR7ZZA
 kJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789717963; x=1790322763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vg4syZwWs7R7NJBbrV2J3WcnUZuLjMGIF8F5j64K/EE=;
 b=J9vcTYgXVZsMsqGg72gGLml4lj/jA6I6qiBvX0TBSHy2Sq1bWsYF6dH5WFWRUNxaN0
 B0VXbb1rmY9KAyKgEcImnfhs9upmLeIy2uncokbaZ9i/nPXGTZvVzJAcpUmH0kdAO/Ht
 G8xdE2IciVi1OunIBzBpzfCQjRl9RjWKTwGw46xpbb5etG35hQ9sDHMsUbRo/yg8ZcIE
 mjbLRsX7VmumQ27xas0KhurMlBdTWb9aZBu6jnUBwfi9WctM4l4msAc7kMLta6GlJ1E6
 ctaDxnc6eQHtCKKowHTuORnLGVCN7D1vqAp25U8gazJ+WHm71u1aPJoK0UctOjfNHCRa
 +P9g==
X-Gm-Message-State: AFuF++mb9I640z9fVfn6HgiMDjMR5gpRbZA1/ZLymf4W0QmX7kzM8Gq9
 WVJjlP9avgwm/kYxd4tYTCOjHjS3UrJ4fulxH1O0PMp9dWRw4gMCTbZ5+nzZMEBQnMvDEwMoesJ
 3bjA=
X-Gm-Gg: AYBFou2AWLym4Ebhev46/3FuYm8350KuyHVfAiMVI5TuoABN2FM3EXCk4DhT8E7i7fl
 nu1jpkYpVfG1hc3sZst4yHRyrzd71T3Vjok3D/qH9kdGErnjtloVyYELQrNqvhzUHLwNENeCK/D
 GtCQbJ4iIdENJslwIG92Vddv7M6SIGPse+/T8YZ9yFW9B364eTkNfoq935rfdEM1LO3GR6lZFe1
 n7uQ9Z1bkswEH+tZ2e8/GEAxz/LrSNL8oV8vUbOCdgl2V6Ef7uQQjvcMmvBaQjqujGsmUVyIJDh
 wllqp/cU9/r5/m/oh07n0+1neN9jfRFAXDi0kDUKlRq8/7t9EehdXYrbxf0PAlB06gHzgWxuLP8
 HeGP5gKVSitKEocbCR4DCcJ6VFa0MijGANckjd6tzT7P8Gl/ufWj62tO7pqjJzeARikeqsB9kqe
 ixCru8irImwIsBb2Ilx1o7CRmbC6GHhRBt0ZyiRW4n/2N2l5h/6nJTxlfOu25rN6y+wMKn9qvZT
 1FHkZVtw6k92Y6vQPzXk6Vt0aYAvVUgHAL44T90TeEcy+W8pvdcsw==
X-Received: by 2002:a05:6000:40c8:b0:487:403:f2eb with SMTP id
 ffacd0b85a97d-4871e263f5dmr3865725f8f.17.1789717963008; 
 Fri, 18 Sep 2026 00:52:43 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4871ff3a957sm2040375f8f.7.2026.09.18.00.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:52:42 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 18 Sep 2026 07:52:22 +0000
Message-ID: <20260918075228.21423-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918075228.21423-1-wegao@suse.com>
References: <20260918075228.21423-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v14 2/3] lib: New library function tst_get_free_uid
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
