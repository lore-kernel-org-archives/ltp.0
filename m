Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15D4C2BA4C
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 05:07:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D70413C9601
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 06:07:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E66883C926E
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 06:07:08 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6327E100116D
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 06:07:08 +0100 (CET)
Received: by mail-pg1-x533.google.com with SMTP id t32so20165438pgm.7
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 21:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YBE67rU9iO7//qg3DUUMTtiAXVUCNyyhTXfxiFzjMBA=;
 b=JFFNSmp0XBPMoh759Gw/6NI9POXZWaY3zafUA559pUeBq/3hlZeH4o74dAsCTnUiUD
 KsvghH+jHmdLf7iECS8iKsgZYe0LD45ueIO05ltKuIxpPIzrpGkR2scZe/sDupWldYbi
 B2Ior1gopC8YjbJjYwSmMPr4D8LaNyI51Ny4Wiil8xzFvc3ztAbCoN6yZkMJoamtSlkZ
 0pzIN6kOnnBe483vWi0HxoGvqGwMl785o3VPF+xaviQPgjWg2ZIzggwdLgTnQe48Y6sE
 5eS6tz2Jua7PV1rEr19r4UUHdkFKOMMqOdliqC3qeNoLlQZCxvPkl6hqfWPEV9ROtRGa
 Qtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YBE67rU9iO7//qg3DUUMTtiAXVUCNyyhTXfxiFzjMBA=;
 b=n0Znv6asAwDBgC9HY01eZqZ2J39rviUN4y4MKG7jOaS0f76OD1W7z8aPYx7x9iaeux
 L4ZesHcvxcjaBtjSrgnVxZO/vxR9NqNuefNBqz4s1lSruaPGvysJlb9/izN3r0IHNRut
 97XPyAq4D6giaHrHifeHOHCnCgDoK29H+1M32rvZh9UgUi3D0rQsOZ/6BOwmC7PNhA+n
 1ahAkft2fguoNu+HUQbj00VT9IacTOOkb8ApgU0/Qqo6L9QnUzmR5FIzcAgMfcNUyx0B
 0aeXZBNR6CZKJHRu7qhBmQZhGPNDZ0zy5zNc0RZ9WVN6CcL/gkFi/SruiTchC9t73xe6
 oaDQ==
X-Gm-Message-State: AOAM5301VJdZY+MHTQ40+SJHShnf3udvC9FHIjzQzV3RRUe/E6R5vssL
 v+rkrGzTv0yblVOuizBYJeS4D3PSb1ol5A==
X-Google-Smtp-Source: ABdhPJyKUaqrKH5aL3gBLrjPod/82jFmiRAMd9e69o1LOKNXFddPn198Sasxs8o8Zr8rWikMl/s2Kw==
X-Received: by 2002:a63:b245:: with SMTP id t5mr17505854pgo.388.1643173626545; 
 Tue, 25 Jan 2022 21:07:06 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e030:888c:3599:3452:4db0:dd08])
 by smtp.gmail.com with ESMTPSA id q8sm642819pfl.143.2022.01.25.21.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 21:07:06 -0800 (PST)
From: Kushal Chand <kushalkataria5@gmail.com>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 10:35:55 +0530
Message-Id: <20220126050555.14435-1-kushalkataria5@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] tst_taint: print readable error message instead of
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

I have did the necessary changes as discussed in our communication.
Now we print each taint flag using tst_res(TINFO, ...) and a final
tst_brk(TBROK, ...) which informs the kernel is tainted.

Regards,
Kushal

---
 lib/tst_taint.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/lib/tst_taint.c b/lib/tst_taint.c
index 49146aacb..49929b11c 100644
--- a/lib/tst_taint.c
+++ b/lib/tst_taint.c
@@ -8,6 +8,27 @@

 static unsigned int taint_mask = -1;

+static const char *const taint_strings[] = {
+	"G (Propriety module loaded)",
+	"F (Module force loaded)",
+	"S (Running on out of spec system)",
+	"R (Module force unloaded)",
+	"M (Machine check exception)",
+	"B (Bad page reference)",
+	"U (User request)",
+	"D (OOPS/BUG)",
+	"A (ACPI table overridden)",
+	"W (Warning)",
+	"C (Staging driver loaded)",
+	"I (Workaround BIOS/FW bug)",
+	"O (Out of tree module loaded)",
+	"E (Unsigned module loaded)",
+	"L (Soft lock up occured)",
+	"K (Live patched)",
+	"X (Auxilary)",
+	"T (Built with struct randomization)",
+};
+
 static unsigned int tst_taint_read(void)
 {
 	unsigned int val;
@@ -74,6 +95,7 @@ static int tst_taint_check_kver(unsigned int mask)
 void tst_taint_init(unsigned int mask)
 {
 	unsigned int taint = -1;
+	unsigned long i;

 	if (mask == 0)
 		tst_brk(TBROK, "mask is not allowed to be 0");
@@ -89,8 +111,13 @@ void tst_taint_init(unsigned int mask)
 		taint_mask &= ~TST_TAINT_W;
 	}

-	if ((taint & taint_mask) != 0)
-		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
+	if ((taint & taint_mask) != 0) {
+		for (i = 0; i < ARRAY_SIZE(taint_strings); i++) {
+			if (taint & (1 << i))
+				tst_res(TINFO, "%s", taint_strings[i]);
+		}
+		tst_brk(TBROK, "Kernel is already tainted");
+	}
 }


--
2.25.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
