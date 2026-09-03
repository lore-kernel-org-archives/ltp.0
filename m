Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBBCC61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788429218; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Nt+/mPVK411/wqJ3vyoX/JsxTpQyxSU7zUDdvYHl+sw=;
 b=KQcPKx59ZTlyGb9PbV+m29xCdzl7eFhcz74Bd9lGlGT9eKyldlm9hoZLatGDu9yKVWFPW
 18yWiQ4S4rfwL7iMF9K66mTpD2maSN0W8BhsGEaoQQrOA5I0nIiZcOuBz4vyT88tWWblwvI
 zgPWwTwY+SNYB0QPeGrVq6N8zN/n+KY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E3193E982B
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 11:53:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D66A3C3015
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 11:53:00 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 977C1600704
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 11:52:59 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so17249225e9.0
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 02:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788429179; x=1789033979; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MORqbBq1Lfnkz4U4Hgvgsm67t1+I6Qm80lz7eFvO/Nc=;
 b=YRhSB6NyzkyAgw5YAhzXGXAhZu5N4sThjOVNCza7XQQ23dcG+9BBj1HhB7QU063KFn
 6dCbK+6iK/1Sroyx25sQf4uM8tQgYBlcJbtPkWyPPBnn7SSjgBkoLgccyAVPUjwQs4IU
 /B7j8BTH8zXNHNgIXHGLvMfzaL0ZqLgRTEMeHuzIgAbqS9PINBSg3WWFNPOcCbUUfdVb
 sF4x07fwLJwNmJX6sg6QX3+lycwMQ8sOWoJUGtaDrm+IkpEUlvXYk+8Ahxw1vKo+hCf4
 uMs50Mxp1rmQWBoBKhrkeChA+/efIlKRcksyAhRqXt3aFU/ZDLNRd8HYeewGlsiUAQgs
 02Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788429179; x=1789033979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MORqbBq1Lfnkz4U4Hgvgsm67t1+I6Qm80lz7eFvO/Nc=;
 b=VP6K+qXkHpZl5e6Hz65zFGL8loPDpmp+hcP10NGWNoXvNk1iNdfELpV6eiBh77CHWf
 y2jwVUG9getWLwiqHWg0/m2ihjna/vBvsHKdyd4C5TjUje1NGtGFFehb/oY/uHXP9IMQ
 eOvQy3puZxnZPX+D04Bw6jMdCVYGufyxS2+fBhz+eh48XQuxVr2TVrR8XzjyORdpycT/
 alOfB9N0CzZoSPraHqNhHZwG0/nRjEhUZFCewQ05bPlh1SzXwq6iPPmXtzz/RVY9cszv
 mRZJr61p0FoEBiKAlfqMQURpsxIZWORq8cl57Tfp+GTm51MK/XkkeVHHDAmt7Hd1YaTa
 JtpA==
X-Gm-Message-State: AFuF++mPjkasOeku4mdoMrDR5RMnW+abPNc0jR1s1mST5TuiYXsAOGjz
 9/3NFhT78kabX/Gj7iibSREzDsJuXBNeU6/NVls8HlHO/URQefNZ/PE6qEXFLJPTYxgKPSSljWU
 5pks=
X-Gm-Gg: AYBFou2ef1cr6ux7XlxB5hoJn0RXhbXA0oVVRjB6koMSXjPjsTxxHaOTffgk/1iCz05
 TfJ9JQ3mnKDnjOXxlIjrPc4DRFny7G/TkQ9cwBPaY5eNjTf4vNy+PSzTPB3XgNPN9FKMy2+noka
 HFTtb9CtG8S4SK//lwiAkOVwlabbc3W2hpAdCjF6Ath3qHY+adciQLk5Ubxgr/O6OwGxCx8czt+
 bX+hxIBAsG0ld3enOC+qYgN9gS26hJ4nyg60BKpMU7BShaP13zggJz5ZWQ7blVwxNEz23mu9VaL
 F/TpSYN3eQZnq62OEhYWAb4s9VmKZMDgVsuDbHqxlfOAJUvpYZ088iPH+/zJi8zaIdVxpxP2gPQ
 M7fUahWHR8jNHh/XhPkQjmtlJdnQGu4tLtiqGrmGIvOHe0IMlXZJY1dwpHOxXJZ04laxzBXl8Te
 MwLdKTVdnKgjxsIbUWaRLYGe5ZobykOqFwu1EKUaSYE0GA7XOEfiec+oSuxdU077V6KuJj6iDhp
 NE+ygHFrk/1Ev64wCqMNgOIBvWjXynp2JqXyu2MRp4=
X-Received: by 2002:a05:600c:8b05:b0:499:b65d:124f with SMTP id
 5b1f17b1804b1-49ce5823d9dmr234716945e9.11.1788429178907; 
 Thu, 03 Sep 2026 02:52:58 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49cee6024a8sm57097705e9.6.2026.09.03.02.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 02:52:58 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  3 Sep 2026 09:52:52 +0000
Message-ID: <20260903095255.4925-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903095255.4925-1-wegao@suse.com>
References: <20260903095255.4925-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v11 1/2] lib: Extend tst_assert_ulong() with enum flags
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

Introduce enum tst_assert_flags (including TST_ASSERT_SATURATED_INT and
TST_ASSERT_TRUNC_32BIT) to tst_assert_ulong(). This enables type-safe
handling of 32-bit compat-mode truncation and clamping behaviors on
64-bit kernels when verifying sysfs/procfs limits.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_assert.h | 34 +++++++++++++++++++++++++++++-----
 lib/tst_assert.c     | 26 ++++++++++++++++++++------
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/include/tst_assert.h b/include/tst_assert.h
index dcb62dfea..ee4f735e4 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -21,14 +21,38 @@ void tst_assert_int(const char *file, const int lineno,
 #define TST_ASSERT_FILE_INT(path, prefix, val) \
 	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)
 
-/*
- * Same as tst_assert_int() but for unsigned long.
+/**
+ * enum tst_assert_flags - Bitwise flags for tst_assert_ulong().
+ *
+ * @TST_ASSERT_SATURATED_INT: Clamps the value at %INT_MAX if it exceeds it.
+ * @TST_ASSERT_TRUNC_32BIT: Keeps only the low 32 bits of the read value,
+ *                          truncating any higher bits.
+ */
+enum tst_assert_flags {
+	TST_ASSERT_SATURATED_INT = 1,
+	TST_ASSERT_TRUNC_32BIT   = 2,
+};
+
+/**
+ * tst_assert_ulong() - Assert that an unsigned long value in a file matches.
+ * @file: The source file of the assertion (usually __FILE__).
+ * @lineno: The source line number of the assertion (usually __LINE__).
+ * @path: Path to the sysfs or procfs file to read from.
+ * @val: The expected unsigned long value to compare against.
+ * @flags: Bitwise flags controlling how the read value is processed.
+ *         See &enum tst_assert_flags.
+ *
+ * This function reads an integer value from the file specified by @path
+ * and compares it with @val. It allows handling of 32-bit compat mode
+ * truncation/clamping on 64-bit systems via @flags.
  */
 void tst_assert_ulong(const char *file, const int lineno,
-                      const char *path, unsigned long val);
+		      const char *path, unsigned long val,
+		      enum tst_assert_flags flags);
 
-#define TST_ASSERT_ULONG(path, val) \
-	tst_assert_ulong(__FILE__, __LINE__, path, val)
+#define TST_ASSERT_ULONG(path, val, ...) \
+	tst_assert_ulong(__FILE__, __LINE__, path, val, \
+		TST_2_(dummy, ##__VA_ARGS__, 0))
 
 /*
  * Asserts that integer value stored in the prefix field of file pointed by path
diff --git a/lib/tst_assert.c b/lib/tst_assert.c
index b68bd5d39..04241d31b 100644
--- a/lib/tst_assert.c
+++ b/lib/tst_assert.c
@@ -23,18 +23,32 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va
 	tst_res_(file, lineno, TFAIL, "%s != %d got %d", path, val, sys_val);
 }
 
-void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
+void tst_assert_ulong(const char *file, const int lineno, const char *path,
+		      unsigned long val, enum tst_assert_flags flags)
 {
-	unsigned long sys_val;
-
-	safe_file_scanf(file, lineno, NULL, path, "%lu", &sys_val);
+	unsigned long long sys_val_64;
+	unsigned long expected_val;
+
+	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val_64);
+
+	if (flags & TST_ASSERT_SATURATED_INT) {
+		if (sys_val_64 > (unsigned long long)INT_MAX)
+			expected_val = (unsigned long)INT_MAX;
+		else
+			expected_val = (unsigned long)sys_val_64;
+	} else if (flags & TST_ASSERT_TRUNC_32BIT) {
+		expected_val = (unsigned long)(sys_val_64 & 0xFFFFFFFFULL);
+	} else {
+		expected_val = (unsigned long)sys_val_64;
+	}
 
-	if (val == sys_val) {
+	if (val == expected_val) {
 		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
 		return;
 	}
 
-	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu", path, val, sys_val);
+	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu (raw: %llu)",
+		path, val, expected_val, sys_val_64);
 }
 
 void tst_assert_file_int(const char *file, const int lineno, const char *path, const char *prefix, int val)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
