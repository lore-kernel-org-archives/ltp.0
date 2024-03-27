Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805B5C54E67
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 03:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711511419; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=atxErmw2vjKEIbMwc9RXd40EuTkTI3iXI7LhjeqWryg=;
 b=mQhGgNN3/ArOOOb6U5O4DNAPq+ZandPO4eMk2vmdKwkz8GGm19+oY/MoPAE7OJ54UZ/Rj
 90DuXwFfr1TIkeP8hvTy8Wfsd9omke0zC3y1lmm6WYx34cK3qT+pZNGCUaA9VTLuiP4oUlG
 0QU0vDVPdpTcQihRO1DFulDlj9vgam0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB32E3D17FD
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 04:50:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AFC13D1800
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 04:49:42 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C51A01A0044C
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 04:49:41 +0100 (CET)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a4715991c32so749152766b.1
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 20:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711511381; x=1712116181; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9k9RD+COWMxH9D1DCKTXGfL1ywT3AQvKA7CGjCAMbc=;
 b=fy97m3MZV5IaAD4EaHb7D0IVpA2k8XBvug/Neq6CmDGrqjCYwpph9RFS5+YyI+QXol
 Yw5BjnHT7XMnZMHe5TcLvx3hRgzx1DndCTDHbUSrzpLetbykwlK+fAZWdejMLSghrOJd
 aGCeixWaHUOnKIUEMQXc8kw6myenMRHkwF5sV50JA/gBI2PWVsuUY+Sx/npnkngtWImx
 LQz8TC1Vs/rbfBIAOrGPVAZReosgdOPf72GwOvJqV4GXd3dswOz6gcMcieu79artbfPQ
 LS8wBdUhfsfmhJ8+h4+KJTbcF5HIXtMtmYgpTicHXVKMCOZa49xpnifkSALb37GM/NuP
 /xyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711511381; x=1712116181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9k9RD+COWMxH9D1DCKTXGfL1ywT3AQvKA7CGjCAMbc=;
 b=H+0miEy/JR7i6PBV1emwkuXfTEZ7T8XOWAsp7WbykfrYVIJZIazp2LgqSm+B/tp1pN
 qwyV3LDqtncms6WhysGtyRBIotV0tWZvU/y0mvgYyj0npo5gOj5p9UCNtPNj8bUtlrDu
 agoLac3OuDq5kj86l3MSbIOYMy5DLeCcVIqnPzDszyOGXdpe0b5a8OL6eWfnQKWAGGYn
 MYcz8V0+o8Klnj516LWhMEDUHjYCrtLXrpXDfHrohL1nkGS9j+DB0gYU/TWluEulF59y
 i4HTtefRZnUnRL69xwV73DlrFMHx5Q0Ryv4Lc4+7+peAGUHu96m9G1QAgJwnUGvRJ7a2
 ltwA==
X-Gm-Message-State: AOJu0YxXXLu9IxI7PS25aItetzL7J65EOcQBOGbdgxjdGIHvxIoaj5L6
 pZtbVMKhF7VQqnpsP9arT9+mbcc4LZPRdC5KxT46MSVgh9iQ12HwP1kXW7UJr1pVKjjVkDLcMyU
 =
X-Google-Smtp-Source: AGHT+IFJEV2SEbAX3JWMynmiF0T/ydp1XK7lasVOHwP3M6QWoUS6NLybRyxGK5SnW8QZh5PUY3I6Ag==
X-Received: by 2002:a17:907:86aa:b0:a4e:29d:c2cf with SMTP id
 qa42-20020a17090786aa00b00a4e029dc2cfmr571096ejc.29.1711511381058; 
 Tue, 26 Mar 2024 20:49:41 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 li2-20020a170906f98200b00a4736ace734sm4910285ejb.115.2024.03.26.20.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 20:49:40 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 Mar 2024 23:49:21 -0400
Message-Id: <20240327034923.30987-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240327034923.30987-1-wegao@suse.com>
References: <20240208013224.859-1-wegao@suse.com>
 <20240327034923.30987-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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
index d2e50a219..c70cad2f4 100644
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
 		                  ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);
 
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
