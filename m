Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73839C3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 13:06:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 021D73D1C3A
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 15:06:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B052D3C60BA
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:06:01 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=fstornio@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B4F4B14104E4
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:06:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721826358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bV+Xxz+Z+lsvp+hRe3yjOuMKn58BqIl5HDQAWw+RNy0=;
 b=f1zEI0a3bR0XY+iHDEG/qBQxi9AcXoq24eMvw4K1VDwTMTznaC0RCJcWevUIGi8iGvokA/
 401FMiIwZpvM8HeQF1uaRvN0u4pPcgcl2O7UIEoSA8pD7HRFaWwQNFlprgA5WaHsZafDia
 ZHZ/Mmlmko8omeesNh+0oI28uHEX1sI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-XVE2s9tGObejTZzAXnqDKg-1; Wed, 24 Jul 2024 09:05:57 -0400
X-MC-Unique: XVE2s9tGObejTZzAXnqDKg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7ab50e6735so24837766b.0
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 06:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721826356; x=1722431156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bV+Xxz+Z+lsvp+hRe3yjOuMKn58BqIl5HDQAWw+RNy0=;
 b=iiHRYziMOobeOytOQWK1hC1VqR4YLUMd5vIlVtaF4HWRX63iY13snFszcjzma25Wjv
 N/W3jfYsRedF79uzX9ksnY4HqE1QVL3RBiEUCvY7VUW/S3DDmYCvPtVa4ljE2WzcmMgV
 ORbVn4XB+EqtBJpT+PPOUVZSo6P9KSUBO2LcHfZ8IlEl7cuzvLl0O93xji0TBqB0nSqu
 Mr/UdluOm1/hBctXR9VzmAQjvv8Oa+ymO/jf33MRelZraf9m0HWYoWWUAaDso+Gqt6QG
 sgX0UEBd27nd1bw77G8Tp2G3eQ5yRHIl7rJN0LPqqoQkJ9D2NZqYUzVSaF32DYwr+95+
 Iueg==
X-Gm-Message-State: AOJu0Yz+dKsmiL4aHFjmeMas5hkwcCBYw2Igf4AU5oVyQ6ZVIJxpoQkC
 4d3Yy7jqX/vQ24bvSghmnooHwGHLy9QC/mqW2RwXqVZ2N/bCoJnOls3hB10d36f1fx4X7SCPF+Q
 ZmOkQ15VcDK0JpvItjbdy2UP4nhj2N1AVzSyv9HFlZSN9/Sd0CQOjHOKWErlBDVCTaXd5gGvzii
 WC1z73qf6PqJeYhTpWTpsgGaAHsV68aGDZ
X-Received: by 2002:a17:907:96a0:b0:a7a:b9dd:775f with SMTP id
 a640c23a62f3a-a7ab9dd788amr94043166b.55.1721826355978; 
 Wed, 24 Jul 2024 06:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsPoYYGsh4zVKLQmoHz/KZO8UAzNwHTd4aycoPtkoq1YGWeo8ChZemFESqRoj0p1g5cer4xg==
X-Received: by 2002:a17:907:96a0:b0:a7a:b9dd:775f with SMTP id
 a640c23a62f3a-a7ab9dd788amr94039966b.55.1721826355259; 
 Wed, 24 Jul 2024 06:05:55 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb
 (host-79-26-112-228.retail.telecomitalia.it. [79.26.112.228])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c7bea7esm644450066b.83.2024.07.24.06.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 06:05:54 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
To: ltp@lists.linux.it,
	f.storniolo95@gmail.com
Date: Wed, 24 Jul 2024 15:05:53 +0200
Message-ID: <20240724130553.126252-1-fstornio@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mlock05: add log details about the success/failure
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
Cc: Filippo Storniolo <fstornio@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In some testing environments, such as those related to safety
critical requirements, more detailed logs are needed when
the executed test passes or fails.
This format already exists in other LTP tests, such as
kernel/security/kallsyms/kallsyms.c

Signed-off-by: Filippo Storniolo <fstornio@redhat.com>
---
 testcases/kernel/syscalls/mlock/mlock05.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock05.c b/testcases/kernel/syscalls/mlock/mlock05.c
index 8e805736d..8b217beb5 100644
--- a/testcases/kernel/syscalls/mlock/mlock05.c
+++ b/testcases/kernel/syscalls/mlock/mlock05.c
@@ -102,8 +102,15 @@ static void verify_mlock(void)
 	Rss *= 1024;
 	Locked *= 1024;
 
-	TST_EXP_EQ_LU(Rss, MMAPLEN);
-	TST_EXP_EQ_LU(Locked, MMAPLEN);
+	if (Rss == MMAPLEN)
+		tst_res(TPASS, "Pre-faulted %lu bytes and expected %lu", Rss, MMAPLEN);
+	else
+		tst_res(TFAIL, "Pre-faulted %lu bytes but expected %lu", Rss, MMAPLEN);
+
+	if (Locked == MMAPLEN)
+		tst_res(TPASS, "Locked %lu bytes and expected %lu", Locked, MMAPLEN);
+	else
+		tst_res(TFAIL, "Locked %lu bytes but expected %lu", Locked, MMAPLEN);
 
 	SAFE_MUNLOCK(buf, MMAPLEN);
 	SAFE_MUNMAP(buf, MMAPLEN);
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
