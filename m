Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A3FC44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 07:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784619751; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=OB4/SCzXIu6J8bN5U2/DeQcAf7JQx7q6l1RsAF/1+xQ=;
 b=fu2LUXahH1gDWJ6lgSc0RGcohXKzQKJax9BbgzJXidyegMUjcb7jtJpQejrZiNS0DGMiB
 m0CW3kxNj+QEacQqPVGiRg3K/RaYZAf+JgxHwfdqgtH29LQj7tiFpNIwylYTX9qEttiUL42
 IsdEQqOH96oddDy/U8v+gXP14tuOg0g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2EF63E55AD
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 09:42:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C03B33E2159
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 09:41:51 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 196BA6007B8
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 09:41:51 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4956869750eso1121865e9.2
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784619710; x=1785224510; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fGAQbDn8jkyVfxms4O14VGNqex3k1HhqXJlv7IFvmKs=;
 b=bjjaHAfiuVXVQlw/pX/eQSRrDbWMIXgATzmKbZJcTeHwBvx4qJGjpNrp4NKGp3NTRn
 QQd/9l2Q9QqZaEFyw3M/AFl8SW2JX8gH3DVKMssxWvkDU+C+pik9dcxCuSFWG7wKHmLI
 mdzXVkDU9XuHt40yfEoED7ljUp2Qrg0VfqUTz6zyYlMcPhWdiKHRbzuBFk5g5ISAF101
 Yu/yTkBOOivOxG0/81eu4Sv0NpZOb7HYuizkQ9aynpbBmq5+k/RMMzZBvhmtZUAb2x6Z
 fulITephHx1EwCKxDAN5SqzkEqx1inXO1+Pd/YN9COyChJYrJi/R8Fty3RCwEQFCahGF
 cmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784619710; x=1785224510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fGAQbDn8jkyVfxms4O14VGNqex3k1HhqXJlv7IFvmKs=;
 b=PmXXxVNrXNfDGpgL7vXbtvVX/jmCyeoAKIqyLu55qOGhhlqzOQypz8oVtXSDUUUQ6x
 QHfbcRwScQRuuyvxsqiX+MXMplER/QIy0LZEPZaq14ZwVG8GwsVVbuEyagW811JisbyE
 UHJFU/7Rjeb1DD0u/UXbG8gwT0wKSXMb59cnzuWMaq8vD8bl2crvGH8cHwZmybLbURQc
 Vy2q1BgiLY+hRTrXo3ODcY27GFG6u/wlKgS+tajz7xWF1ePOolKs/BmY04JiYFIKDiWJ
 1VJcvnWqGS8i7ZJ03BQv81UBZHEIn6EwCMQd5A0RF7j7yp92jyDHNv52ZfWjC/yGmqJA
 gp9w==
X-Gm-Message-State: AOJu0YwCvvBh96XAr6Vhk8D28lzb6XzGgexIxwHWoNI4EDUm6bX0ahIb
 ve/gh7j9NJf7O/mI+dqZrcmv5Ce+0PYID/uZ7ayhC9350HPNU20cQuQ5H/wIhEq8NAHpDwzeoTY
 Am2A=
X-Gm-Gg: AfdE7cnLC7oV/ZfUD1wAzk58VWb/Xs7ySk5tQQI4yrDjnRlH5EmVBLW8/FWJAEJi4jx
 lnRO+I47O+JD2h9qCNdOXMZxJypuunQufLSrbwiWcEs0JE8F9+pwC6cnmFiKCbKP3MFoW1YX5pv
 RW6XK/uDvNQxbDhAQmCdUK63aLWE7G7PDHGRXAvk2HHiuJ9o9fX+rf1xTmNBrf5QCFPImMMKYef
 Pmbeh0hqEgAxkD2UbCorYMi/qCGTFkZU0D7unjvp9gYImtIvuT3JE3fX9mHFowE12OQw4z85mXq
 7hAAhux3uEKnC6/T5kwl4aVdCm5oNJJmhgSuPJ+3v6qge2vh63dWox/Z5p8YjqAcvuZrXudqNa7
 0ad1iy2NEYujLAf5OrDwOY9HcjxxK/BGw2nenZQCEyeuMCpaOLUPxJNtq+m8Hg7voNw==
X-Received: by 2002:a05:600c:3515:b0:493:be13:98b with SMTP id
 5b1f17b1804b1-4954a50c47emr185611515e9.23.1784619710433; 
 Tue, 21 Jul 2026 00:41:50 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-495653bffefsm45478725e9.9.2026.07.21.00.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 00:41:50 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 21 Jul 2026 07:41:28 +0000
Message-ID: <20260721074146.2779-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721074146.2779-1-wegao@suse.com>
References: <20260707054804.24232-2-wegao@suse.com>
 <20260721074146.2779-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 1/2] lib: New library function tst_get_free_uid
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
 lib/tst_uid.c     | 30 +++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 5 deletions(-)

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
index af4ef8cf7..47c267bc4 100644
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
@@ -24,7 +52,7 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
 			continue;
 
 		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
-			tst_res_(file, lineno, TINFO | TERRNO,
+			tst_res_(file, lineno, TINFO,
 				"Found unused GID %d", (int)ret);
 			return ret;
 		}
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
