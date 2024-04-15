Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CC7C4345F
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 02:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713149495; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=yAIwH2wCAEn2t+R2dOyPJEh11QXISl/xHNTRUpJgB3Q=;
 b=VbLtHEmyUOCRKsAOMdCLD77fAxiNiR011SqOQ2CfijNIJN0jguL35MJpq/KXdvwLR/Fit
 ZO4N4T82Nunx5cUHPExaB2RlFNi9ue40P2HspJxpsL5+Nu2DPKDejuFegqwv0OjWUMphGkV
 92No6BCDIrIyv7WWoqaO2+3C9FIGV9o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61CA33CF98D
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 04:51:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFF343CC3F4
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 04:51:13 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7812B1A00812
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 04:51:12 +0200 (CEST)
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2da63269e75so6906501fa.1
 for <ltp@lists.linux.it>; Sun, 14 Apr 2024 19:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713149471; x=1713754271; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6e+JmtKjQhhpSjduuf6FU0x0jm9dmVMgHRsb0qUgLEQ=;
 b=dA7TlyqX89ryg6ItuTQoN5UUuBs0B4LcXWomkHsS4Xty7TCahROD9R5bVDgJc9Z1oq
 FfvTZRTNJk+MWuHXxm7ClCXGuhLxAf3ytIq/R58bKq0LKbmjUSKp8o6IBeKuOPB4Ahur
 vWIBp7xR0DTIcQSRAYDyBWrNMvrv21VomecXiVxcrr/p0zZHCfJSYbDlvp4zqvZ18p/S
 69BFfbpBe49/91hIEUNNZ42jij4kDHdF5EQzn7yCNypFUVHxM5+dxz3+sxEuAou8c5BB
 tLOjWJ5bRdx352n4VS73QxdOn9hryGhrNj3VSFFAseu0tnGZoPD+bgG5be4TYkXoB1+5
 nrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713149471; x=1713754271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6e+JmtKjQhhpSjduuf6FU0x0jm9dmVMgHRsb0qUgLEQ=;
 b=wuUY5nyN3TnWXAKyl3dEk4NBQTCAY3eVU8OUlQbvIAZ4D1MWoO2Nv8POLmochWw7Qo
 IUtcA+9lTfTLaHSEb2PiTe+TotJkbVbt10iLXnaLOC3GB+m9d2E06atA5YPTDd1yEnIZ
 3gkF652M9axzY07V9XqjSRSarQiE6ZwfUMNVLdxtLUAGpIqVi6mx8D2Tc960qtO1zZT9
 /VffAMdFIZfgFe3gS6Y6XiidQdCz9R2eFt87BzH3z3TUbp/uDTZ/VCRCaUVxkXN2pLTm
 LRmep2d7SGJzETWJqBXYhYYe7/7kDOeei1SzRQp4MY7V5bsJD+NkNTz9r5Rj07HjIcin
 hM+A==
X-Gm-Message-State: AOJu0Yy1rNgIpY5DxsHPxh+TSKLOie5F7MFGpVGD0mJX/TOwZWLnYrpA
 TuopmljwS1Pb7jCoBChFDTN8Eu0TzIU3r3NR8LmSj5VAeMOpixNOkGS5tFT0J+DhcNlw3DnkTHg
 =
X-Google-Smtp-Source: AGHT+IHaHnUo5mMhWjD33N3zFxb5rJ8xdkGLRzcuEAc1NtTczS4L2CDl+qiD6KU9XHdEarWVlHtvcA==
X-Received: by 2002:a05:651c:11d4:b0:2d8:eaff:8a38 with SMTP id
 z20-20020a05651c11d400b002d8eaff8a38mr5211543ljo.46.1713149470983; 
 Sun, 14 Apr 2024 19:51:10 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 l35-20020a05600c1d2300b004161af729f4sm14469217wms.31.2024.04.14.19.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 19:51:10 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 14 Apr 2024 22:51:00 -0400
Message-Id: <20240415025100.2103-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] lib: Add TST_EXP_PASS_PTR_{NULL,VOID} macros
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
 include/tst_test_macros.h               | 41 +++++++++++++++++++++++++
 testcases/kernel/syscalls/sbrk/sbrk01.c |  7 +----
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 22b39fb14..2668758fb 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -178,6 +178,28 @@ extern void *TST_RET_PTR;
                                                                                \
 	} while (0)
 
+#define TST_EXP_PASS_SILENT_PTR_(SCALL, SSCALL, FAIL_PTR_VAL, ...)             \
+	do {                                                                   \
+		TESTPTR(SCALL);                                                \
+		                                                               \
+		TST_PASS = 0;                                                  \
+		                                                               \
+		if (TST_RET_PTR == FAIL_PTR_VAL) {                             \
+			TST_MSG_(TFAIL | TTERRNO, " failed",                   \
+			         SSCALL, ##__VA_ARGS__);                       \
+		        break;                                                 \
+		}                                                              \
+		                                                               \
+		if (TST_RET != 0) {                                            \
+			TST_MSGP_(TFAIL | TTERRNO, " invalid retval %ld",      \
+			          TST_RET, SSCALL, ##__VA_ARGS__);             \
+			break;                                                 \
+		}                                                              \
+                                                                               \
+		TST_PASS = 1;                                                  \
+                                                                               \
+	} while (0)
+
 #define TST_EXP_PASS_SILENT(SCALL, ...) TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__)
 
 #define TST_EXP_PASS(SCALL, ...)                                               \
@@ -188,6 +210,25 @@ extern void *TST_RET_PTR;
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
 	} while (0)                                                            \
 
+#define TST_EXP_PASS_PTR_(SCALL, SSCALL, FAIL_PTR_VAL, ...)                    \
+	do {                                                                   \
+		TST_EXP_PASS_SILENT_PTR_(SCALL, SSCALL,                        \
+					FAIL_PTR_VAL, ##__VA_ARGS__);          \
+		                                                               \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
+	} while (0)
+
+#define TST_EXP_PASS_PTR_NULL(SCALL, ...)                                      \
+       do {                                                                    \
+               TST_EXP_PASS_PTR_(SCALL, #SCALL, NULL, ##__VA_ARGS__);          \
+       } while (0)
+
+#define TST_EXP_PASS_PTR_VOID(SCALL, ...)                                      \
+       do {                                                                    \
+               TST_EXP_PASS_PTR_(SCALL, #SCALL, (void *)-1, ##__VA_ARGS__);    \
+       } while (0)
+
 /*
  * Returns true if err is in the exp_err array.
  */
diff --git a/testcases/kernel/syscalls/sbrk/sbrk01.c b/testcases/kernel/syscalls/sbrk/sbrk01.c
index bb78d9a7b..2d2244a35 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk01.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk01.c
@@ -26,12 +26,7 @@ static void run(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
 
-	TESTPTR(sbrk(tc->increment));
-
-	if (TST_RET_PTR == (void *) -1)
-		tst_res(TFAIL | TTERRNO, "sbrk(%ld) failed", tc->increment);
-	else
-		tst_res(TPASS, "sbrk(%ld) returned %p", tc->increment, TST_RET_PTR);
+	TST_EXP_PASS_PTR_VOID(sbrk(tc->increment), "sbrk(%ld) returned %p", tc->increment, TST_RET_PTR);
 }
 
 static struct tst_test test = {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
