Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C05C02198
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 15:32:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C16903C9B17
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 16:32:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A69013C9A5F
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 16:32:07 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dbassey@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1790720D181
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 16:32:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739547125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=62hFTzIEQH9cO5UyG69gZa76u6HMt/QqoG78qQpPONI=;
 b=O/jHmWV0hVaag+4So+gLMq9hPSi9bqFzjuvPC+Rn+t6a2LJKcKXJ614PIepm+V4pvSGG7I
 ZAuKDg2dRBoj1m0wxu79IPzzgNQuFSbM8Xu6lzYt1pJ847oOCd/PIXK4vo7crRz5K0rhHF
 JEMTVSr/VoDtm/hxPO3y0LXH0dnaeJg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-WJdMECh5MYy5VlMDlMoUPQ-1; Fri, 14 Feb 2025 10:32:03 -0500
X-MC-Unique: WJdMECh5MYy5VlMDlMoUPQ-1
X-Mimecast-MFC-AGG-ID: WJdMECh5MYy5VlMDlMoUPQ_1739547122
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dc88ed7caso1793500f8f.0
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 07:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739547122; x=1740151922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=62hFTzIEQH9cO5UyG69gZa76u6HMt/QqoG78qQpPONI=;
 b=HYTyr87E9Z+IAZbwLPQ9RkII2jQp91u8FIsuZnKBHxpR9dNUEq3f5dvKPfsaWqeeeA
 E8rjwGUVBUt1DTIKSVvA1P1gCNVrTNlzNjsgQtFuahqMJ81jevY0KccXlgoCK8UT2TYG
 Uvx2V4I9WO1dofzEGyEGde1REoP9Jz4yRS9bQ2OXy+iVFGcdb+X7aQnDVs6Go27cgy4Q
 zQrg7KruV1rR8kZ62hpsTmPTi1cjYhHjj7Z47UkPad4hnvk2kJ+72xQabVzDQ1J5/j/9
 g8vskwjhvi8zTmbSnlBmqk1R90+OEvenHuIKgtZ4dPGw8+F4zcAn+i7NHfH7D+IlMiV5
 mPAQ==
X-Gm-Message-State: AOJu0Yx3PaxBkVW9RDFg2e1wMfxZJg5MGAqiIbnKxN0OJ+B63UpSicB0
 xeMR2TJWZ4h5RmLkitQoISVNMSV9m8d4bXpwAm9r9g9L9qdXwwHzmF3z330RjeRgV+UeVVkEXh0
 ipfehIVMdf77Cm4RYT0k5QyL3PFOXiny3HiqKOVTe2r2HbmoOq9diqmerYvVHKD6l/+BO6palgN
 QhGJ629tpsIGXOECwViVAOB3ezQeEZXk+1SQ==
X-Gm-Gg: ASbGncseV/aMtrs9aMpELTV8lHyBflW5H1/JCVe4zSCSckpDwsxxSgmyz3Lbnd1lbVt
 75tuSlaJ2yBFrGahHqGCscCzyLs7UO5a0c7XMvJK35bBdDI/P/c4gAbjWQ5zXxbK69Q/oURKKjX
 gU9u85+a6fW6pJFdP/QT2bvT14+I9SyZddyWZd6eXSoCQ9GX0gQFH1HU6RewUatpSIrkzSceFD1
 JvfqmdEUC2n/lGb0BEz80MpBSXPDeyElzsBxL62+slXnYLNV6S9yjp1NHI6PzZB8Qmrd9HbeZHj
 NmF8q0Cb5p9CI9dXh80IOlLUqjst0Sa2KOwhUbIQ0Ck=
X-Received: by 2002:adf:ed04:0:b0:38f:31b6:4f30 with SMTP id
 ffacd0b85a97d-38f31b6505bmr2106292f8f.35.1739547122332; 
 Fri, 14 Feb 2025 07:32:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkwGTigcD4gmVivGF38zWLH5nj/8r7thyx98Puu+JUti5fUjC6VzAkl9v7N5JF/sHZFLs4Nw==
X-Received: by 2002:adf:ed04:0:b0:38f:31b6:4f30 with SMTP id
 ffacd0b85a97d-38f31b6505bmr2106237f8f.35.1739547121937; 
 Fri, 14 Feb 2025 07:32:01 -0800 (PST)
Received: from 2624797214.wifi.kn.vutbr.com (nat-kn.net.vutbr.cz.
 [147.229.117.40]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7ecsm4839009f8f.49.2025.02.14.07.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 07:32:01 -0800 (PST)
From: Dorinda Bassey <dbassey@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 14 Feb 2025 16:31:58 +0100
Message-ID: <20250214153158.96460-1-dbassey@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HQKRjnZNPyYfhQQIboaagsMyXMwtx7NRaz9OjGzk2Sg_1739547122
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kcmp03: Add check for KCMP_SYSVSEM before running test
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
Cc: sbertram@redhat.com, javierm@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This commit introduces a new function
`is_kcmp_supported()` to check if the kernel supports the
`KCMP_SYSVSEM` operation. In the `verify_kcmp()` function,
we add logic to detect when the kernel does not support
`KCMP_SYSVSEM` and skip the test for that case with a TCONF
result. This ensures that the test does not fail when the
Kconfig that supports `KCMP_SYSVSEM` is unavailable.

Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
 testcases/kernel/syscalls/kcmp/kcmp03.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
index 37d5118d5..255171d98 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp03.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -52,6 +52,12 @@ static void cleanup(void)
 	free(stack);
 }
 
+static int is_kcmp_supported(void)
+{
+	int result = syscall(__NR_kcmp, getpid(), getpid(), KCMP_SYSVSEM, 0, 0);
+	return result == 0 || errno != EOPNOTSUPP;
+}
+
 static int do_child(void *arg)
 {
 	pid2 = getpid();
@@ -64,6 +70,13 @@ static void verify_kcmp(unsigned int n)
 	int res;
 	struct tcase *tc = &tcases[n];
 
+    // Handle the case for KCMP_SYSVSEM specifically
+    if (tc->kcmp_type == KCMP_SYSVSEM) {
+        if (!is_kcmp_supported()) {
+            tst_brk(TCONF, "Kernel does not support KCMP_SYSVSEM, skipping test.");
+	    }
+	}
+
 	pid1 = getpid();
 	tst_res(TINFO, "Testing %s", tc->desc);
 
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
