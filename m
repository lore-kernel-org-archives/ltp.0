Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C13C4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 01:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707356001; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=FNuSltNItraQiZOLuVcJ2q7jikeUBP/UUleomjbYyQ4=;
 b=i4kks4/e98tPEYEQarFZ3GSjMwkkWrEnMGOEUQNfRU7VVpIuer7MBs17s/DWn5Wl0zYpD
 6U9zFtJRbeWiclpR1eP0GKga90TfCrRP7TsQ4TO7dzfpB9wirVb0a9aLkk24z48p6vC+Py1
 nlssqAg7+7mNDUK8+IzAWCstqsco58A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05CD83CF5AF
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 02:33:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 568733CE137
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 02:32:44 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 57D5E1182E52
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 02:32:44 +0100 (CET)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d0b750518bso15273961fa.0
 for <ltp@lists.linux.it>; Wed, 07 Feb 2024 17:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707355963; x=1707960763; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0Q79WvzOJ7KKSRAFzoZf70tqskSSXeL6A7KS/u5PVc=;
 b=HZwNjeGpCHAlwiFX78KUnQQMD2vn4314Jn0mGARMRp/YSRX2Y4gvtnVEpeoIpnRWRr
 yPIBB7UmHZ2otRCLE1+Otlo8WmyHbNN0ccFMPV/9AIBAbdp0zOxcx1jv6qFF03hPE0jq
 4xQqNV4EW5IgKnUadmeRK4gXz85uFu4QoHJeTzeKDmnx4CLmuwPyP1AN6swG/5OSBUoa
 QtI3XeyxNzIeZHsoJNWDJsybKFoO88T7LWPc5S9gzL3Z2lNTYOUIBlAa6K5/IVgGGay2
 tiB0K+0VLflrb7J0JmML0dv4VOENmhK5kwEaLBy4ymQbCxlHi8TsECnfj6jHa0Vr9sN9
 qFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707355963; x=1707960763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b0Q79WvzOJ7KKSRAFzoZf70tqskSSXeL6A7KS/u5PVc=;
 b=cMN+F/GP3Hj4ySE2rWwyRsLdaJKTjS6YsuF5nMEi7a2grMbvjrblhUFLQ4jRXXrVem
 0rOFBbzQFru/cmVciKudxkakS/y0rhNLebZ0VcMHw9raJlZ6YJxTZJgwB+d8s79t9YBh
 3dmdHUxkLrgzryzy9UHXv8jU2P1MizlIQhEH4VgiL+L8g/KtZf5iycxw2rrzW4KDsLd9
 R4c34EXaPAQVNm6axAlAHs3YJGzwPWNEhU6zkGf4mbyHwYEHv1sot5tIEjYUJpZhUcap
 I0hY4GfC6RP91OP1hJ9C/26LwauaLzXLGH7t4BaKpuZmbWepdWdRN1j2xD/KhFY74HM6
 WqPg==
X-Gm-Message-State: AOJu0Yzwt+Cf4NzvzdfvLi2WavuQ8xbeGhTPrHTut0xYzgs0Fzs0nJoO
 6ltQeHUq19JkANV1/ESCs+sVFn7bBDGmpTkTpeTVaII6CiybPvyLgX6FzPXPSfY1Obm711k1bqI
 =
X-Google-Smtp-Source: AGHT+IE5OR6GbKSH97hbwCaMOe2GsJQgY/028yJ8ypPYM1TCdgVwNA4M3XrB4YgRxWr7qOoOEMvO8w==
X-Received: by 2002:a05:651c:cf:b0:2d0:a19f:e448 with SMTP id
 15-20020a05651c00cf00b002d0a19fe448mr5044318ljr.13.1707355962980; 
 Wed, 07 Feb 2024 17:32:42 -0800 (PST)
Received: from localhost ([223.72.87.18]) by smtp.gmail.com with ESMTPSA id
 lg6-20020a170902fb8600b001d987771271sm2116925plb.123.2024.02.07.17.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 17:32:42 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  7 Feb 2024 20:32:22 -0500
Message-Id: <20240208013224.859-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240208013224.859-1-wegao@suse.com>
References: <20240117125227.24700-1-wegao@suse.com>
 <20240208013224.859-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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
 include/tst_test_macros.h        | 59 ++++++++++++++++++++++++++++++
 lib/newlib_tests/.gitignore      |  1 +
 lib/newlib_tests/test_macros07.c | 61 ++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 lib/newlib_tests/test_macros07.c

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index d2e50a219..1f5b56d27 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -227,6 +227,31 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
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
 #define TST_EXP_FAIL_ARR_(SCALL, SSCALL, EXP_ERRS, EXP_ERRS_CNT, ...)          \
 	do {                                                                   \
 		TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, SSCALL,              \
@@ -258,6 +283,40 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, EXP_ERRS,                    \
 		                  ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);
 
+#define TST_EXP_FAIL_PTR_NULL(SCALL, EXP_ERR, ...)                             \
+	do {                                                                   \
+		int tst_exp_err__ = EXP_ERR;                                   \
+		TST_EXP_FAIL_SILENT_PTR_(SCALL, #SCALL, NULL,                  \
+			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
+	} while (0)
+
+#define TST_EXP_FAIL_PTR_ARR_NULL(SCALL, EXP_ERRS, ...)                        \
+	do {                                                                   \
+		TST_EXP_FAIL_SILENT_PTR_(SCALL, #SCALL, NULL,                  \
+			EXP_ERRS, ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);        \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
+	} while (0)
+
+#define TST_EXP_FAIL_PTR_VOID(SCALL, EXP_ERR, ...)                             \
+	do {                                                                   \
+		int tst_exp_err__ = EXP_ERR;                                   \
+		TST_EXP_FAIL_SILENT_PTR_(SCALL, #SCALL, (void *)-1,            \
+			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
+	} while (0)
+
+#define TST_EXP_FAIL_PTR_ARR_VOID(SCALL, EXP_ERRS, ...)                        \
+	do {                                                                   \
+		TST_EXP_FAIL_SILENT_PTR_(SCALL, #SCALL, (void *)-1,            \
+			EXP_ERRS, ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);        \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS | TTERRNO, " ", #SCALL, ##__VA_ARGS__); \
+	} while (0)
+
 #define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index a69b29e24..4f43899e5 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -40,6 +40,7 @@ test_macros03
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
