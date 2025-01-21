Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1F4C0218D
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 11:22:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA86C3C267C
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 12:22:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E66393C2669
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 12:22:26 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=acarmina@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E1B5E229246
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 12:22:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737458544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yCXzm2p5009LhAHzuu+Men2Bhr+tBzGWS5WcS7nosl0=;
 b=C+rXVUGe6slkICaBxA14EqlQ61IbCg5TwAeNdv+wSEenZhWcVLYvjrPGAcaY6NU+VL1gwe
 NGyOTkfHOtkqiTw0Pj9c0Hdass90+jf4l9JnaFWh6jvGuU8Lbl+M0JWqAIxqVwvJUgezaJ
 vMaX0Ol3d2NFTou81iQjVkGrPxa4cwo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-fTG9NRE2PzWJjac2fANh-g-1; Tue, 21 Jan 2025 06:22:21 -0500
X-MC-Unique: fTG9NRE2PzWJjac2fANh-g-1
X-Mimecast-MFC-AGG-ID: fTG9NRE2PzWJjac2fANh-g
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385e03f54d0so2426198f8f.3
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 03:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737458540; x=1738063340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yCXzm2p5009LhAHzuu+Men2Bhr+tBzGWS5WcS7nosl0=;
 b=ZBKuThKzMprhYHSt1gIekvdT925i9gP/QGhtNVMHK9t8LG4LKJ6YjkHDKNsJjaaPHy
 FmKYRV1+Uvk85+0TM/1nj8yObEyQcve5QPeAe205QTzdEXAZVfLZT7SZEn0dnCabW1IC
 z5EGBlL61lMjUfOEaAsXxfBaimddAVyLpxuHy1xoBxc5fRUoesxYwdMTJ9unLg6yYEwm
 hVV91o3fHxPuaSjJaQ7almqQBSJuoLaYHqkiVWlV/GDRXpIfRx4Xgdfyn8e0JFNjIzs7
 LldQEbmtcIV3yojKMhuL4XsN4V+o4mwkz+X/axI7fco5WweLD/Mfe4YV22lCVjOYivgm
 Ta2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc6lJhGE+HjAlMFjvuHMv5m5YTfCs5en9kU8g8qHZSUTBOnk9zBXLmDkAkCtwdA7X7me8=@lists.linux.it
X-Gm-Message-State: AOJu0YzYpV3X0pb5AjAPEgUa7Yxv0mpJenIhw2TEocIWmQIioo0q8KFT
 BZzydl7E9m9gormppDegDffEPq+AF9mMBRW9JScC5W//2eJPDSa2k0Nc9XGIwe7whQBsguUBtNm
 DgFmjx8+OOuE3nZVUP4xAfzWi7aBnyRN1S7OrXhI4HrnDfPNC
X-Gm-Gg: ASbGncvt6lj9UKYEx20RjF/Tz2aCewAXZod7Xg8XYIMJjQRg/uGM4isLmgUchfLyLcA
 OxKOc5+A4Lk1VPrYN7rcEqqWRHMRijcGew4ySv85tqysuzRDc0JniAtfvr3ct//lk1NjLGFpCNV
 CB5vIY3uUv6HPDYBiX55gTpEPzBjY62ts0D8dpo15rppPr+PX2WxVlinFHLuk4onRVT+/Tu6pjZ
 E5VDuYi3ncP1x9+3a6U2NCyyJpoYyIL97Co12jEsPU8D10YN3aM9/U5MqXz2ZiZeUAUWwhCEok=
X-Received: by 2002:a05:6000:381:b0:38a:615c:8223 with SMTP id
 ffacd0b85a97d-38bf5657297mr12128263f8f.10.1737458540512; 
 Tue, 21 Jan 2025 03:22:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqLGJO+SSRaUtXevBTEswxKB8y3nMv7ahdfOXd5PVFeeLIgUhUIqgv4OPVpbPoZKbcHGDNKg==
X-Received: by 2002:a05:6000:381:b0:38a:615c:8223 with SMTP id
 ffacd0b85a97d-38bf5657297mr12128236f8f.10.1737458540077; 
 Tue, 21 Jan 2025 03:22:20 -0800 (PST)
Received: from lab.hqhome163.com ([81.57.75.210])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38bf3214d62sm12879989f8f.1.2025.01.21.03.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 03:22:19 -0800 (PST)
From: Alessandro Carminati <acarmina@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Jan 2025 11:19:09 +0000
Message-Id: <20250121111909.66487-1-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ij50TGX4-bhvmfJU-g6A7GFaYmMJXzcggbAra4XTnUY_1737458541
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cfs-scheduler/starvation.c: Skip test on realtime
 kernels
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
Cc: Alessandro Carminati <acarmina@redhat.com>,
 Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This commit introduces a check in the starvation test case to detect and
skip execution on realtime kernels. The test is designed for use with the
Completely Fair Scheduler and produces meaningless results when run on
realtime kernels.

By skipping the test on realtime kernels, we avoid confusion caused by
misleading results.

Changes include:
- Added a detection mechanism for realtime kernels.
- Logic to skip the test execution if the kernel is identified as
  realtime.

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---

V1: https://lore.kernel.org/ltp/20250120085017.63442-1-acarmina@redhat.com/

 include/tst_kernel.h                              |  9 +++++++++
 lib/tst_kernel.c                                  | 10 ++++++++++
 testcases/kernel/sched/cfs-scheduler/starvation.c |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index 5f49952b7..63ecb19a4 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -58,4 +58,13 @@ int tst_check_builtin_driver(const char *driver);
  */
 int tst_check_driver(const char *driver);
 
+/**
+ * tst_check_preempt_rt() - Check if the running kernel is RT.
+ *
+ * Check support for the kernel module (both built-in and loadable).
+ *
+ * Return: -1 if the kernel is RT, 0 otherwise.
+ */
+int tst_check_preempt_rt(void);
+
 #endif	/* TST_KERNEL_H__ */
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 8dabfeba2..7084289c3 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -214,3 +214,13 @@ int tst_check_driver(const char *driver)
 
 	return -1;
 }
+
+int tst_check_preempt_rt(void)
+{
+	struct utsname uval;
+
+	uname(&uval);
+	if (strstr(uval.version, "PREEMPT_RT"))
+		return -1;
+	return 0;
+}
diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index 901556a7b..27bf77f39 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -80,6 +80,9 @@ static void setup(void)
 	int cpu = 0;
 	long ncpus = tst_ncpus_conf();
 
+	if (tst_check_preempt_rt())
+		tst_brk(TCONF, "This test is not designed for the RT kernel");
+
 	CPU_ZERO(&mask);
 
 	/* Restrict test to a single cpu */
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
