Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1545CC433EF
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 05:59:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46C193C9628
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 06:59:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F2EC3C95E6
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 06:59:24 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9CBDA10005C0
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 06:59:23 +0100 (CET)
Received: by mail-pg1-x535.google.com with SMTP id c5so12959069pgk.12
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 21:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tJJAPcSrvRMm3ZiWYqTbini0BwltSbKsChB1RfpOv3U=;
 b=q7+GIZbDOsxY2UADGSG0+f3cdQ1OJ7JTQ90YZTk3uDEryyjNVdI5J4vRWtMTf8ITnT
 DTLIhVfmAWk0t+3Pur3FatccVyR4f4Y8+OncAKIr78mMm+P2n24RiRbJTtxp7EnJdhnh
 wmJW5lkiIu6bxmJO6aXgL7qtGJzfVyj9ZxpOpxGn6xWUOI9tyB//eMb6xhCidppiol9y
 mdzghMeEkgWAXUYDoI17LgDaAUIoolkY356R7DGHUrMDfhjV6/sJwslAg2CSuH1IaXdb
 fs2SvW/+jYfiyhF3W6Tr7gPTi8ia0w8k48HyD4UJDuQ7i6LSAZzCxJ69CdHYkBpi8Att
 X3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tJJAPcSrvRMm3ZiWYqTbini0BwltSbKsChB1RfpOv3U=;
 b=UjWD5/zi2ClnKczJmqN5TXv406OI96qe8m20ZudwzT1SC7/jWlB2tdHTZpjB9QEmD/
 rzONAm8bFpE30clnAr+cr5AGEVGsCjAZyt56nMv+ng4VWT5MD7CF+CWbElhaz1gm6Ucx
 1by6cSSbgAbTcpsG3tHcRSeHWrowI+MhInqsbycANwa2iM/TDrV8wHKQIFivfsm+93ux
 k6FxtEUw0OjqrjGWfmQ5ADrTsM7wk1FFWRMLuHjC0M/exkPTaEodcXHq6Ira4Yrq+Lhs
 uplCtCZubd1WbLPQLl6m5tFUNXjwA6qomvggpJAQVJte38s05IzAGj5ujJ6aGJyvfspP
 4tsA==
X-Gm-Message-State: AOAM530Mda9plCGclLyPKIh8NaWj8JVvC1MCDynPTWjdovX86MThxlX0
 ju2iWarMXuAdbXtsGMvUQU3aUL/HO5M=
X-Google-Smtp-Source: ABdhPJxW63CAUD8HpOTKlr2F66P23kx+Wp5wT26Nt11y+IyFlwB1vvsZqzRs/1KREQmyLUdPGJtPHw==
X-Received: by 2002:a05:6a00:10d5:b0:4be:d3f9:c329 with SMTP id
 d21-20020a056a0010d500b004bed3f9c329mr17065511pfu.2.1642485561681; 
 Mon, 17 Jan 2022 21:59:21 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e030:888c:f4a8:8a4:864c:1e73])
 by smtp.gmail.com with ESMTPSA id
 p64sm11129809pfg.41.2022.01.17.21.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jan 2022 21:59:21 -0800 (PST)
From: Kushal Chand <kushalkataria5@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 18 Jan 2022 11:27:45 +0530
Message-Id: <20220118055746.45407-1-kushalkataria5@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_taint: print readable error instead of
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

Fixes: #776

This patch prints human readable messages when kernel is tainted instead of numerical codes.

Git Hub Issue link  - https://github.com/linux-test-project/ltp/issues/776

---
 lib/tst_taint.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/lib/tst_taint.c b/lib/tst_taint.c
index 49146aacb..3289c115c 100644
--- a/lib/tst_taint.c
+++ b/lib/tst_taint.c
@@ -8,6 +8,32 @@
 
 static unsigned int taint_mask = -1;
 
+const char *tst_strtaint(int err)
+{
+	static const struct pair taint_pairs[] = {
+		STRPAIR(TST_TAINT_A, "A (ACPI table overridden)")
+		STRPAIR(TST_TAINT_B, "B (Bad page reference)")
+		STRPAIR(TST_TAINT_C, "C (Staging driver loaded)")
+		STRPAIR(TST_TAINT_D, "D (OOPS/BUG)")
+		STRPAIR(TST_TAINT_E, "E (Unsigned module loaded)")
+		STRPAIR(TST_TAINT_F, "F (Module force loaded)")
+		STRPAIR(TST_TAINT_G, "G (Propriety module loaded)")
+		STRPAIR(TST_TAINT_I, "I (Workaround BIOS/FW bug)")
+		STRPAIR(TST_TAINT_K, "K (Live patched)")
+		STRPAIR(TST_TAINT_L, "L (Soft lock up occured)")
+		STRPAIR(TST_TAINT_M, "M (Machine check exception)")
+		STRPAIR(TST_TAINT_O, "O (Out of tree module loaded)")
+		STRPAIR(TST_TAINT_R, "R (Module force unloaded)")
+		STRPAIR(TST_TAINT_S, "S (Running on out of spec system)")
+		STRPAIR(TST_TAINT_T, "T (Built with struct randomization)")
+		STRPAIR(TST_TAINT_U, "U (User request)")
+		STRPAIR(TST_TAINT_W, "W (Warning)")
+		STRPAIR(TST_TAINT_X, "X (Auxilary)")
+	};
+
+	PAIR_LOOKUP(taint_pairs, err);
+}
+
 static unsigned int tst_taint_read(void)
 {
 	unsigned int val;
@@ -90,7 +116,8 @@ void tst_taint_init(unsigned int mask)
 	}
 
 	if ((taint & taint_mask) != 0)
-		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
+		tst_brk(TBROK, "Kernel is already tainted: %s",
+			tst_strtaint(taint));
 }
 
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
