Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C41DC6FD1F
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 03:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712114993; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=bbW8wBReXsxEIX2FZyEkbgG67tz5pWhys5l2CPpgMmY=;
 b=pRPxb6G9PLkK/qFJwnNUkj/32fRymIlDsqaFgr9obz/wRE47jbmk0/Ku6DnAU9e9qA+ei
 gTyvvzNcUdFebCDifDSI4aq5aAMsP4Sofe5K4pUCmJ64rbWOiqNeXCJcPc7t5EYVePbiYLM
 siwvEXrXgGwWLt0B4IqoDtAVusoYDH4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 801EF3CD0D3
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 05:29:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 954D13CD19A
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 05:29:16 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DB981601EF9
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 05:29:15 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4156a29ff70so16268835e9.3
 for <ltp@lists.linux.it>; Tue, 02 Apr 2024 20:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1712114955; x=1712719755; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKqiti9qC/m8Mt/9eb6iAEQgPtb0429bNLNATlCExzw=;
 b=HvJbKMUrj2I8BQczbkwjlZ+sSJczxYUIiOnPEblk/o4zI8W7RLkMY9pRvLyyq3IW6+
 ZikF1MKYIKj+h+rEurC8vtPGJo3x1W3/z4UxlH30XitF/EBFnNahDr9gJ74X1Kw1rYNH
 FsP34WPTr25eCEhHVEnjZD8rBqdOsRHiBm6rXE5+cVcbueT4TTHhSXLLH3SjJRL3w7fq
 PeTpsRGQLk8dUR7AZz4mqLdUw1lvtl1KqG/DbdQVv0BgYRXhyfKxUFxqU2RV5Xox2bnC
 WFVrAz6jhMO+cx8Ho+cXCfqIVsyKcIRqF70V1ssXti/YNWjpWSBo0Ck0NIayCj/TwDmj
 /vQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712114955; x=1712719755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKqiti9qC/m8Mt/9eb6iAEQgPtb0429bNLNATlCExzw=;
 b=vIhx7jQzq85Rq8Y0pUa7KSKm4LL5JGHBelnomYN7dVyRGH5CefE1EYkPFgrkqkWjgA
 fNo/YTX/HZv5y/4IGq0+4jLZwSWMnFkddpRJYKFMDjl8GGAwqDCUwrL/0OMQxgKkAUMV
 HZJMq8CdDsXguCXMyWVFFQ66BFRUbIWhJV9LS05KR3oOjIOCLQ6XypDmJRjUh/Otl7rg
 0YWC7YWNcj0tv83FW+Wv/R+lMGH6lEN+a6bTPcXMipyHhXlBzh3r0tpwZtviqxU/3r/O
 BZT+oK/c8c5AdOrUhp/qReEv99kgZVWraJ8SKrb+JFHGIfvO8FFN3YnrCTKaZMeR3s/9
 xdSA==
X-Gm-Message-State: AOJu0Yy8aARwWdnIOW52NoL2U6dHkTuMOnS1hCF5CSnbHVDl9CcnKy11
 W3S/DEgRWEFASWJw2xIrYYJUKPzTdQ/ICqd5dAu2fhchhYxdpjH6J6e6NkEDDP74DXSOodNsO4Q
 =
X-Google-Smtp-Source: AGHT+IGt81BzfhMRuf0gOVIHWgCMlQConpBv8ZCB1WvB5o1eB5lfMNflt+kLvLtfXNSqp2jluSkwmw==
X-Received: by 2002:a05:600c:434b:b0:414:8ff6:ef33 with SMTP id
 r11-20020a05600c434b00b004148ff6ef33mr922218wme.40.1712114954633; 
 Tue, 02 Apr 2024 20:29:14 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 s21-20020a05600c45d500b0041487f70d9fsm23087555wmo.21.2024.04.02.20.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 20:29:14 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  2 Apr 2024 23:28:57 -0400
Message-Id: <20240403032859.3826-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240403032859.3826-1-wegao@suse.com>
References: <20240327034923.30987-1-wegao@suse.com>
 <20240403032859.3826-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_test_macros.h        | 61 ++++++++++++++++++++++++++++++++
 lib/newlib_tests/.gitignore      |  1 +
 lib/newlib_tests/test_macros07.c | 61 ++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 lib/newlib_tests/test_macros07.c

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 6a7bcdce5..eff3aef69 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -227,6 +227,41 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 		}                                                              \
 	} while (0)
 
+#define TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, FAIL_PTR_VAL,                  \
+	ERRNOS, ERRNOS_CNT, ...)                                               \
+	do {                                                                   \
+		TESTPTR(SCALL);                                                \
+		                                                               \
+		TST_PASS = 0;                                                  \
+		                                                               \
+		if (TST_RET_PTR != FAIL_PTR_VAL) {                             \
+			TST_MSG_(TFAIL, " succeeded", SSCALL, ##__VA_ARGS__);  \
+		        break;                                                 \
+		}                                                              \
+		                                                               \
+		if (!tst_errno_in_set(TST_ERR, ERRNOS, ERRNOS_CNT)) {          \
+			char tst_str_buf__[ERRNOS_CNT * 20];                   \
+			TST_MSGP_(TFAIL | TTERRNO, " expected %s",             \
+				  tst_errno_names(tst_str_buf__,               \
+						  ERRNOS, ERRNOS_CNT),         \
+				  SSCALL, ##__VA_ARGS__);                      \
+			break;                                                 \
+		}                                                              \
+                                                                               \
+		TST_PASS = 1;                                                  \
+                                                                               \
+	} while (0)
+
+#define TST_EXP_FAIL_PTR_(SCALL, SSCALL, FAIL_PTR_VAL,                         \
+	ERRNOS, ERRNOS_CNT, ...)                                               \
+	do {                                                                   \
+		TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, FAIL_PTR_VAL,          \
+	        ERRNOS, ERRNOS_CNT, ##__VA_ARGS__);                            \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS | TTERRNO, " ", SSCALL, ##__VA_ARGS__); \
+	} while (0)
+
+
 #define TST_EXP_FAIL_ARR_(SCALL, SSCALL, EXP_ERRS, EXP_ERRS_CNT, ...)          \
 	do {                                                                   \
 		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, SSCALL,              \
@@ -258,6 +293,32 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, EXP_ERRS,                    \
 		                  EXP_ERRS_CNT, ##__VA_ARGS__);
 
+#define TST_EXP_FAIL_PTR_NULL(SCALL, EXP_ERR, ...)                             \
+	do {                                                                   \
+		int tst_exp_err__ = EXP_ERR;                                   \
+		TST_EXP_FAIL_PTR_(SCALL, #SCALL, NULL,                         \
+			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
+	} while (0)
+
+#define TST_EXP_FAIL_PTR_ARR_NULL(SCALL, EXP_ERRS, ...)                        \
+	do {                                                                   \
+		TST_EXP_FAIL_PTR_(SCALL, #SCALL, NULL,                         \
+			EXP_ERRS, ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);        \
+	} while (0)
+
+#define TST_EXP_FAIL_PTR_VOID(SCALL, EXP_ERR, ...)                             \
+	do {                                                                   \
+		int tst_exp_err__ = EXP_ERR;                                   \
+		TST_EXP_FAIL_PTR_(SCALL, #SCALL, (void *)-1,                   \
+			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
+	} while (0)
+
+#define TST_EXP_FAIL_PTR_ARR_VOID(SCALL, EXP_ERRS, ...)                        \
+	do {                                                                   \
+		TST_EXP_FAIL_PTR_(SCALL, #SCALL, (void *)-1,                   \
+			EXP_ERRS, ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);        \
+	} while (0)
+
 #define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 6d125f933..ed10d860a 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -41,6 +41,7 @@ test_macros03
 test_macros04
 test_macros05
 test_macros06
+test_macros07
 tst_fuzzy_sync01
 tst_fuzzy_sync02
 tst_fuzzy_sync03
diff --git a/lib/newlib_tests/test_macros07.c b/lib/newlib_tests/test_macros07.c
new file mode 100644
index 000000000..ac361fd8e
--- /dev/null
+++ b/lib/newlib_tests/test_macros07.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Wei Gao <wegao@suse.com>
+ */
+
+/*
+ * Test TST_EXP_FAIL_PTR_{NULL,VOID} and TST_EXP_FAIL_PTR_ARR{NULL,VOID} macro.
+ */
+
+#include "tst_test.h"
+
+static char *fail_fn_null(void)
+{
+	errno = EINVAL;
+	return NULL;
+}
+
+static char *fail_fn_void(void)
+{
+	errno = EINVAL;
+	return (void *)-1;
+}
+
+static char *pass_fn(void)
+{
+	return "pass";
+}
+
+static void do_test(void)
+{
+	const int exp_errs_pass[] = {ENOTTY, EINVAL};
+	const int exp_errs_fail[] = {ENOTTY, EISDIR};
+
+	tst_res(TINFO, "Testing TST_EXP_FAIL_PTR_NULL macro");
+	TST_EXP_FAIL_PTR_NULL(fail_fn_null(), EINVAL, "fail_fn_null()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_PTR_NULL(fail_fn_null(), ENOTTY, "fail_fn_null()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_PTR_NULL(pass_fn(), ENOTTY, "pass_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_PTR_ARR_NULL(fail_fn_null(), exp_errs_pass, "fail_fn_null()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_PTR_ARR_NULL(fail_fn_null(), exp_errs_fail, "fail_fn()_null");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+
+	tst_res(TINFO, "Testing TST_EXP_FAIL_PTR_VOID macro");
+	TST_EXP_FAIL_PTR_VOID(fail_fn_void(), EINVAL, "fail_fn_void()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_PTR_VOID(fail_fn_void(), ENOTTY, "fail_fn_void()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_PTR_VOID(pass_fn(), ENOTTY, "pass_fn()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_PTR_ARR_VOID(fail_fn_void(), exp_errs_pass, "fail_fn_void()");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+	TST_EXP_FAIL_PTR_ARR_VOID(fail_fn_void(), exp_errs_fail, "fail_fn()_void");
+	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
