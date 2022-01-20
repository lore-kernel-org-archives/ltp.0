Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4399C433EF
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 16:35:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 607FC3C96BB
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 17:35:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1CF83C8E30
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 17:35:39 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 14464601239
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 17:35:39 +0100 (CET)
Received: by mail-pf1-x435.google.com with SMTP id y27so1939272pfa.0
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 08:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wqYEvVl/+AOg0K/2uipzNaxXBIgCLM0zjWFX99IMsOw=;
 b=ZhnQ/9CJmF7E9RNWSXr+BAUsyi+JkWaXXU0p9GlgzdjMzpJE0pM/by+3uVbvCfeq2Q
 709KTPS7Q4Z7bbn7Qam4/Uce4Kxspbx3nj7f8gX5ZckWzmmIhqklP69VPDwMCT7zEXJb
 1tnySkJN3NdTDrDdF3OCh7ExGQHMJGKKySCxFTwiuhQsEwpK6b6n3PGjwdLfX9lbDSPg
 oOGxOs1xdP+RCSOXkVKH7ACX0Y7m85sIiy0YQiHEgqw3tGeYZ3N7BTYgxqm0Ys375Mff
 dJ/nvLoMkI8IWByHDo8f4yUPIak2DuveyzeZfcc/kqwUeL6CWIq3nBZ4PjwznGq7HQDD
 SEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wqYEvVl/+AOg0K/2uipzNaxXBIgCLM0zjWFX99IMsOw=;
 b=gBP2lkKYzhw+9FlGVPnQYkfvMRe5h1Ot4ZnjJa0vyqY+/jHrnje0d6XBCcD/ePOLXC
 /TGorLgXWEZJ1MaWktFnffS1cc5RIA/yR0ZKDNKjpQFA1I9G7m4qlslFiLIvXsCTRyGB
 Nw+kAzJJhVrzoL8RVv1qjqigTb0SAf281CCs/7lx49cRnQQ0mwAsTHpGRXJ6IV0fbZnW
 2WaSpgFfuZn+EsGD2jIue47M09yiADp3Zy2StlKZpxnXhijjtbA1XAsiKkkkvkijFLqD
 MLAezrOpuklvCVgfYnV+mZdAWKnHp0n5uyHhij5/mAwN0IfLuidxRBQ+KKRmDp4oJWa7
 +4Ig==
X-Gm-Message-State: AOAM532LYwoE8teEIa86yQRMng5E4J6Nyw2rCV5gyY93YqyLrCNo8eq8
 IACsj5m3r5qFKCWRNzedxKqWr8tcZi190w==
X-Google-Smtp-Source: ABdhPJzEkPAqXNNI8y64b5ym0LwDpd/7zeCgxgaJQ3S9jfOPla62f/PsmX9v4qw41Q+t9hhYMo+vRw==
X-Received: by 2002:a63:f610:: with SMTP id m16mr24494277pgh.69.1642696537178; 
 Thu, 20 Jan 2022 08:35:37 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e030:888c:5511:339b:e045:751d])
 by smtp.gmail.com with ESMTPSA id e15sm158029pjd.52.2022.01.20.08.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jan 2022 08:35:36 -0800 (PST)
From: Kushal Chand <kushalkataria5@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 20 Jan 2022 22:04:07 +0530
Message-Id: <20220120163407.30744-1-kushalkataria5@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] tst_taint: print readable error message instead of
 numerical codes
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

This patch stores the possible kernel tainted messages in taint_strings
and corresponding error is printed.

Fixes: #776
---
 lib/tst_taint.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/tst_taint.c b/lib/tst_taint.c
index 49146aacb..e224984f5 100644
--- a/lib/tst_taint.c
+++ b/lib/tst_taint.c
@@ -8,6 +8,27 @@
 
 static unsigned int taint_mask = -1;
 
+static const char * const taint_strings[] = {
+				       "G (Propriety module loaded)",
+				       "F (Module force loaded)",
+				       "S (Running on out of spec system)",
+				       "R (Module force unloaded)",
+				       "M (Machine check exception)",
+				       "B (Bad page reference)",
+				       "U (User request)",
+				       "D (OOPS/BUG)",
+				       "A (ACPI table overridden)",
+				       "W (Warning)",
+				       "C (Staging driver loaded)",
+				       "I (Workaround BIOS/FW bug)",
+				       "O (Out of tree module loaded)",
+				       "E (Unsigned module loaded)",
+				       "L (Soft lock up occured)",
+				       "K (Live patched)",
+				       "X (Auxilary)",
+				       "T (Built with struct randomization)",
+};
+
 static unsigned int tst_taint_read(void)
 {
 	unsigned int val;
@@ -74,6 +95,7 @@ static int tst_taint_check_kver(unsigned int mask)
 void tst_taint_init(unsigned int mask)
 {
 	unsigned int taint = -1;
+	long unsigned int i;
 
 	if (mask == 0)
 		tst_brk(TBROK, "mask is not allowed to be 0");
@@ -90,7 +112,10 @@ void tst_taint_init(unsigned int mask)
 	}
 
 	if ((taint & taint_mask) != 0)
-		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
+		for (i = 0; i < ARRAY_SIZE(taint_strings); i++)
+			if (taint & (1 << i))
+				tst_brk(TBROK, "Kernel is already tainted: %s",
+					taint_strings[i]);
 }
 
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
