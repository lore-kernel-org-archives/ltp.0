Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DB7C433F5
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 05:59:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AA0B3C9643
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 06:59:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E5863C95E6
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 06:59:42 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7427D600564
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 06:59:42 +0100 (CET)
Received: by mail-pj1-x102e.google.com with SMTP id h12so330571pjq.3
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 21:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ap807Dpa1j9ykugw3TKyhGr3QGKgWDLc4s9+Eer8P7c=;
 b=KL80HCsS23YDsNAngWYDE2hlwWRGbPD+yjoR5kBi/KbX6Vbgg788wcpVdCk0TZTq2e
 7HxTNBI4sqRT9Ynsia7RoJBfEOQftIg+J12XgIbwbyVSNds4WlXzY6P4DGXY1Py22ybI
 yTPxyRTrbMDV9ulePe6R2DT0+BY+p31WDDAtT7gDzQ4UrRhdb7FjBtKHWAA6jyBkohap
 5Hs6tyngKmhffrfkcHiNZku9MH7w0pFkWoZ7zC51HvyV0yjf48c67bwi+dn+qZH2XRLS
 wnQKJVcO4Dvek5eol67WPwfaAa7211En4TJh8AcAOJivmf3hCZsOHBSkCvQlbWWtwleg
 EqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ap807Dpa1j9ykugw3TKyhGr3QGKgWDLc4s9+Eer8P7c=;
 b=whOBaad74ACuRHvPqHqxmw1pN9RfFQ0WWKqCWg17hrkX/M0VwA2cPFx2mpHMACVvPp
 x30h09Pz0+tfTB292UCrWo3q18qW0lcLtgmCV44fR/Wbn3sYc+MMr4Wi2QKqNgCP1V1q
 LdEQhamLVEuO1c1fPV5Znn9CB6izayt/14JTmD2jSqZnesXJONbidt6EFpgM1hUFKGzb
 DHiQW74c9YY6W242a3rgeTGhRP0jQuF8ftrrISwHh4imkmh7mzGZwZX6QnjWKlGJP7EX
 UsARYmDG/yGYKtfDTzwdrgD5vTJDXlZVDviwZLqpUkhzKCMuIFgTskeOABHNmOXUqNw4
 t6dA==
X-Gm-Message-State: AOAM533YzG7ukD+LUkWFNt8YdqkWrpkmMrk6VEVb3Kjuo20722WKzAeS
 30vxRXubmjLBC5kWC7WdwnG+TVKt8sQ=
X-Google-Smtp-Source: ABdhPJx4KfIH9Xc79tQAx3B9rTpj6i/FjupFT6IS+ENy97OlJ7KXk8wTxxu7eWHYQszT2ekV9DBvhA==
X-Received: by 2002:a17:90b:3b48:: with SMTP id
 ot8mr35494509pjb.95.1642485580745; 
 Mon, 17 Jan 2022 21:59:40 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e030:888c:f4a8:8a4:864c:1e73])
 by smtp.gmail.com with ESMTPSA id
 p64sm11129809pfg.41.2022.01.17.21.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jan 2022 21:59:40 -0800 (PST)
From: Kushal Chand <kushalkataria5@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 18 Jan 2022 11:27:46 +0530
Message-Id: <20220118055746.45407-2-kushalkataria5@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220118055746.45407-1-kushalkataria5@gmail.com>
References: <20220118055746.45407-1-kushalkataria5@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] tst_common.h: Move struct pair definition from
 tst_res to include/tst_common.h to avoid duplicate code
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
Cc: Kushal Chand <kushalkataria5@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch moves definition of struct pair from tst_res.c to include/tst_common.h
to avoid code duplication as struct pair is also used by tst_taint.c.

---
 include/tst_common.h | 15 +++++++++++++++
 lib/tst_res.c        | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/tst_common.h b/include/tst_common.h
index fd7a900d4..cd85d6053 100644
--- a/include/tst_common.h
+++ b/include/tst_common.h
@@ -83,4 +83,19 @@
 #define TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN(condition) \
 	TST_BUILD_BUG_ON(condition)
 
+struct pair {
+	const char *name;
+	int val;
+};
+
+#define PAIR(def) [def] = {.name = #def, .val = def},
+#define STRPAIR(key, value) [key] = {.name = value, .val = key},
+
+#define PAIR_LOOKUP(pair_arr, idx) do {                       \
+	if (idx < 0 || (size_t)idx >= ARRAY_SIZE(pair_arr) || \
+	    pair_arr[idx].name == NULL)                       \
+		return "???";                                 \
+	return pair_arr[idx].name;                            \
+} while (0)
+
 #endif /* TST_COMMON_H__ */
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 8d86b48a4..c41f3a2a2 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -124,21 +124,6 @@ extern char *TCID;		/* Test case identifier from the test source */
 extern int TST_TOTAL;		/* Total number of test cases from the test */
 
 
-struct pair {
-	const char *name;
-	int val;
-};
-
-#define PAIR(def) [def] = {.name = #def, .val = def},
-#define STRPAIR(key, value) [key] = {.name = value, .val = key},
-
-#define PAIR_LOOKUP(pair_arr, idx) do {                       \
-	if (idx < 0 || (size_t)idx >= ARRAY_SIZE(pair_arr) || \
-	    pair_arr[idx].name == NULL)                       \
-		return "???";                                 \
-	return pair_arr[idx].name;                            \
-} while (0)
-
 const char *strttype(int ttype)
 {
 	static const struct pair ttype_pairs[] = {
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
