Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77431CDB474
	for <ltp@archiver.kernel.org>; Wed, 18 Oct 2023 01:50:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94C063CEF53
	for <ltp@archiver.kernel.org>; Wed, 18 Oct 2023 03:50:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 027C13C8885
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 03:50:23 +0200 (CEST)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 73C14600BAC
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 03:50:23 +0200 (CEST)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5a7ac9c1522so96683187b3.0
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 18:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697593822; x=1698198622; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ItNhtT+LqRF8RORNRviC6uiab/EaF0+RR4c7K9BZ36M=;
 b=1GurzfQtxW5KTyyJ/3CEIbDXBz6zWHA9wyTb1bIvs4kX0Spjd8yyCDA2qOyx5p/47V
 BYx65dHEGa782R1/QtIHV97Pk3KEqpoaUMMnkuUXovjBxivzVmXIiNpytPICNhnVWk99
 y4Ywz1AYojIQE7saAmqWz6phElqynsqNO7XLdAGQtwEp8OpYzTOBs2WN0UNeVB/nX8Yj
 6xk+qCQvdqemQDtf5dv6QjDcyTLn+AuZtCuSfDvtYVjsBg2xNff8Mr8MJ1fRjxHrIrqb
 x7hK+l+5DxXv+m4mKMOXLxpR/fO8NKBtKaIeDMxl7+0SXC/Df4DgfOTx5N/rJSmjEf0v
 ZfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697593822; x=1698198622;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ItNhtT+LqRF8RORNRviC6uiab/EaF0+RR4c7K9BZ36M=;
 b=HrxIPmVpGNAYROKaGKxsL5Xk59hnrJYv1QV7q85SGGbt99GWwUIfnASsQshGtLHlE1
 OtbhIC4mMKBWCrBaqEq/3o7q1+1OqNozB/kM0t5LTrckg7hXrFOSJJNPidMljkhQa0tA
 Dg8074Ukr5wVn3Qd6FZFhdkzCBRowDf1O1wCsz0cTQA6xkGyHuZfJWKU4Udka1YkcTwz
 Dc8uPvhdxRbK7T95yoGViWMYJ6C3YkPvujD6iyQcMW1Qg9bY7ntoPFzt+Rm3qX1H2Gnp
 BXWL28F6LrIHU09shnciZxgAM/5Ldr/TxbeoOg4XCMjH1aN6AcTh1IJo5tRUHCjE4mC9
 ehKw==
X-Gm-Message-State: AOJu0YxY8XgyLx1UbwZkd+SLFRZw8qeKFXCxJ9G9nsFGMtCD5gSuZnK9
 Gtr2ODFj0qWXyI5VRlYXw3mvF/xt8L4TMHvvBHAL3e9su/rtifG5DNWmkJih8vsPeBxnGomDXKX
 glQdXrhKvaBUVgGv8y9kkFwXjZQ30IxlSQCV6DlZ/0oPdkeIRgYRB+xVt
X-Google-Smtp-Source: AGHT+IGxOfYIH8HFjxvxjncDUPjH7q6cdvD7wmYSOBnieSETazlYmAMrtYkT3ZGUhCu5m4RqWIUZxEkCMF8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:d4d7:0:b0:5a7:ba3f:3407 with SMTP id
 w206-20020a0dd4d7000000b005a7ba3f3407mr87674ywd.9.1697593821959; Tue, 17 Oct
 2023 18:50:21 -0700 (PDT)
Date: Wed, 18 Oct 2023 01:50:16 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231018015016.1897021-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_kvercmp: Handle larger kernel version numbers
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Current implementation can only handle revision numbers up to 256.  Bump
this up to 1024 as some revision numbers are in the 300s.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 lib/tst_kvercmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index 552920fac..9e1a511af 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -92,8 +92,8 @@ int tst_kvcmp(const char *cur_kver, int r1, int r2, int r3)
 		         cur_kver);
 	}
 
-	testver = (r1 << 16) + (r2 << 8) + r3;
-	currver = (a1 << 16) + (a2 << 8) + a3;
+	testver = (r1 << 20) + (r2 << 10) + r3;
+	currver = (a1 << 20) + (a2 << 10) + a3;
 
 	return currver - testver;
 }
-- 
2.42.0.655.g421f12c284-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
