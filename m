Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35141CD1288
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 03:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712115039; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=hl8C8c6omU5devMYc3nb571Aj/2FNwhmFEH/aFTSMuQ=;
 b=eJG/0qjYDGPFKhFdQ33HDuBpDWKpcbWTkA4FwaCxLv5ktHDsl8R4ImOytIXDv4gUFVTbv
 adKsCJRfcKXyVSWNQbx3fLRXO3MX+9PLvVYIDARjzDTEMuaVTAH4AGrdRxkrjYXFuzTRhI4
 RWOfbbEWdnnNk5xBFiGVgm4AkE9n3oU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD4AA3CD195
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 05:30:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B3923C74E7
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 05:29:28 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA808601EF9
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 05:29:27 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3437f70078bso528990f8f.3
 for <ltp@lists.linux.it>; Tue, 02 Apr 2024 20:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1712114966; x=1712719766; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DOl/KZOlS8Vrp6FfY+JoMn8xhLc2VVh5vke+ZBaI3eE=;
 b=V/bwO4d60z/8vSVefK//KAGs48ycQZiPI0In0y5BPlNtRIj8c/9Qu90Y1uxe1416oy
 bhsKkwVH6Co7DJrhr3JuA7dmBgtuchBMWCQWb1xOQZPEG7Jdy0lI7zszWcTdxMIg1Ijn
 DmGlm6/7+axwT0G2UqiCLnHvft4h6jJzUH9Umn7CCKsr/HeEhjHKounjo0IfQA4faVyc
 BaVP+l06wWBwsd8iOPxvreSPc4C4ZtfhjAJEjrQwJVpVn1S8etHL5i+RAjKUzhJX8MYY
 0oAMeT7V7/zJXqAhFDiqt5vpusDay0fGMRWTkpHc39qyzAk+LAckQMtNSPQAO+alyaXp
 CJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712114966; x=1712719766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DOl/KZOlS8Vrp6FfY+JoMn8xhLc2VVh5vke+ZBaI3eE=;
 b=eU32QiHR9CT3qGqt7gqZjlbO/tBsHPPSRPpqPNd10laM+lmIhM/XTShtsyatKWy6BN
 tLolY/6kqlOp8tzP4OqdRHD5/aE0oW6shb94C1Di/8mPELyFEDxGe+cmHJKkeM+s56BH
 I4toLisxf4a0ZwTwZw3mG3VtZoWlTlNqpq8i8bAmsPLLoGPCpGY3Tb/1qkLQj/AIfgLx
 i07KMou8XqBMWSmVwEg/cKURPw9CtDcr8EsFOIVqHJoTL1QVsz7yu1o9mgAANI6TQuhQ
 EpHhyPnxQwMTjewpH3UP7CYA63nvq9RPTjBd4B7H8G1E2q2ObMkp7SSMFLoM+cLNOS5t
 KfAw==
X-Gm-Message-State: AOJu0YzWBz9TtwumZVxECRVOQYS0SLhJBSd+RTq4S0Sz3DjFIP4KHVCK
 OFvpAv770mtNBLj1UUiK+Bu2lXNZoYr7OUFbwK1DhSplUwXxNrrvovWhfnpikNtpgIO+BbAE7Z8
 =
X-Google-Smtp-Source: AGHT+IECKSUN7M0+i0KV3GcLHY8oJpz25/O7m/mgCLPv50GSByEw42pAIXaqDaCNn1MsmSZzLdb9Xw==
X-Received: by 2002:a5d:624d:0:b0:341:bd4c:f075 with SMTP id
 m13-20020a5d624d000000b00341bd4cf075mr8809555wrv.16.1712114966667; 
 Tue, 02 Apr 2024 20:29:26 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 v6-20020adfa1c6000000b003439ac164f3sm69122wrv.46.2024.04.02.20.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 20:29:26 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  2 Apr 2024 23:28:59 -0400
Message-Id: <20240403032859.3826-4-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240403032859.3826-1-wegao@suse.com>
References: <20240327034923.30987-1-wegao@suse.com>
 <20240403032859.3826-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/3] realpath01.c: use TST_EXP_FAIL_PTR_NULL
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
 include/tst_test_macros.h                       |  8 ++++----
 lib/newlib_tests/test_macros07.c                |  8 ++++----
 testcases/kernel/syscalls/realpath/realpath01.c | 11 +----------
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index eff3aef69..88c329333 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -300,10 +300,10 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
 	} while (0)
 
-#define TST_EXP_FAIL_PTR_ARR_NULL(SCALL, EXP_ERRS, ...)                        \
+#define TST_EXP_FAIL_PTR_ARR_NULL(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)          \
 	do {                                                                   \
 		TST_EXP_FAIL_PTR_(SCALL, #SCALL, NULL,                         \
-			EXP_ERRS, ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);        \
+			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);                \
 	} while (0)
 
 #define TST_EXP_FAIL_PTR_VOID(SCALL, EXP_ERR, ...)                             \
@@ -313,10 +313,10 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
 	} while (0)
 
-#define TST_EXP_FAIL_PTR_ARR_VOID(SCALL, EXP_ERRS, ...)                        \
+#define TST_EXP_FAIL_PTR_ARR_VOID(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)          \
 	do {                                                                   \
 		TST_EXP_FAIL_PTR_(SCALL, #SCALL, (void *)-1,                   \
-			EXP_ERRS, ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);        \
+			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);                \
 	} while (0)
 
 #define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
diff --git a/lib/newlib_tests/test_macros07.c b/lib/newlib_tests/test_macros07.c
index ac361fd8e..6015988cf 100644
--- a/lib/newlib_tests/test_macros07.c
+++ b/lib/newlib_tests/test_macros07.c
@@ -38,9 +38,9 @@ static void do_test(void)
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 	TST_EXP_FAIL_PTR_NULL(pass_fn(), ENOTTY, "pass_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL_PTR_ARR_NULL(fail_fn_null(), exp_errs_pass, "fail_fn_null()");
+	TST_EXP_FAIL_PTR_ARR_NULL(fail_fn_null(), exp_errs_pass, ARRAY_SIZE(exp_errs_pass), "fail_fn_null()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL_PTR_ARR_NULL(fail_fn_null(), exp_errs_fail, "fail_fn()_null");
+	TST_EXP_FAIL_PTR_ARR_NULL(fail_fn_null(), exp_errs_fail, ARRAY_SIZE(exp_errs_fail), "fail_fn()_null");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 
 	tst_res(TINFO, "Testing TST_EXP_FAIL_PTR_VOID macro");
@@ -50,9 +50,9 @@ static void do_test(void)
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 	TST_EXP_FAIL_PTR_VOID(pass_fn(), ENOTTY, "pass_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL_PTR_ARR_VOID(fail_fn_void(), exp_errs_pass, "fail_fn_void()");
+	TST_EXP_FAIL_PTR_ARR_VOID(fail_fn_void(), exp_errs_pass, ARRAY_SIZE(exp_errs_pass), "fail_fn_void()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
-	TST_EXP_FAIL_PTR_ARR_VOID(fail_fn_void(), exp_errs_fail, "fail_fn()_void");
+	TST_EXP_FAIL_PTR_ARR_VOID(fail_fn_void(), exp_errs_fail, ARRAY_SIZE(exp_errs_fail), "fail_fn()_void");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
 }
 
diff --git a/testcases/kernel/syscalls/realpath/realpath01.c b/testcases/kernel/syscalls/realpath/realpath01.c
index c0381e9cb..c4c603609 100644
--- a/testcases/kernel/syscalls/realpath/realpath01.c
+++ b/testcases/kernel/syscalls/realpath/realpath01.c
@@ -24,16 +24,7 @@ static void setup(void)
 
 static void run(void)
 {
-	TESTPTR(realpath(".", NULL));
-
-	if (TST_ERR != ENOENT) {
-		tst_res(TFAIL | TTERRNO, "returned unexpected errno");
-	} else	if (TST_RET_PTR != NULL) {
-		tst_res(TFAIL, "syscall didn't return NULL: '%s'",
-				(char *)TST_RET_PTR);
-	} else {
-		tst_res(TPASS, "bug not reproduced");
-	}
+	TST_EXP_FAIL_PTR_NULL(realpath(".", NULL), ENOENT);
 }
 
 static struct tst_test test = {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
