Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C63C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 13:28:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E296E3C93BE
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 15:28:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9ECF3C937A
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 15:27:46 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 06544100023C
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 15:27:46 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 m32-20020a05600c3b2000b0039756bb41f2so5691831wms.3
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 06:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OMQ2Cb6oDXEoth7Jvg2oYWhmkyQKrNLmMvoEhtoNIGA=;
 b=VW07vHFfLTtLFRPXmL5NCk41LD5snClDMFVdN6S4JWPcZRaGuTO/9d11SW7btsJ375
 h1ZAsO4iVHI5+aqAc7tEkmGb9WrLFbC2m8FA1pmI1ivp6F7pRBOnSZ6bxka4inPiJdHv
 NgB6bwSAVN3o6E9RLuGzBwgXJZYJRFoe5il7Ab897Sj4LyUzPpCnOwUO75mKuG192Q0v
 BLJMQUg0n+PcHfjKYvbRogaDjMwVxxCEJuh1iqFgHBmJHHzgq/UWVp2YdJR4ru5MCbYq
 zV7oJrA3EajnRv6WfUw4quM2/HUwNaObQ4tdWl52yIH+JiL9+L4nXGCBbhuW70f23zy9
 texg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OMQ2Cb6oDXEoth7Jvg2oYWhmkyQKrNLmMvoEhtoNIGA=;
 b=L6sE5Ewjigoxk0yyemBbzoLjsNrQ80iLRu17cU+cdyKvaJ6FocOFXSAxPcdqMLwstr
 FbXnohiwv7rFXJH9H+mBP7jUIvNk8I56pLYvviAtHAKL8RlA94LKuhm4ALP3sS5h6zaU
 oOVVRiaYeVatHjuPyJwXPPfBeTarubZVTZBCqneNhCRWvNJRSc/R5jweDoAxZEQKR4st
 T6Ixxn81+RrOWpCoPGMa8CFdz08Kzcj7FhuY3ol97A6tx77Ng4Hcf096j10H2M/p7nfx
 YSr+hRcOWVB+Oin1ottcr//K0bPHmn0otH3uITtcAOIHtkw/NijDA4rRrwHpHWUlGx0X
 /UUQ==
X-Gm-Message-State: AOAM5308TbLf/ahRs56EKUpowh6L15+revt8mleYjXpLfx4x3VehWtZ9
 a2UMvYtfSveycj3b227DcbU=
X-Google-Smtp-Source: ABdhPJzsD8Fd2DZ9MKcjevsynM7FyMl2PTrE44Yr1FvFf3N1DN1kRfUzHK+H8F0aim+MCxBbsLsVVg==
X-Received: by 2002:a05:600c:4f15:b0:39c:7eaf:97e7 with SMTP id
 l21-20020a05600c4f1500b0039c7eaf97e7mr35195560wmq.199.1655731665471; 
 Mon, 20 Jun 2022 06:27:45 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a5d4f85000000b0021b862ad439sm9086556wru.9.2022.06.20.06.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 06:27:44 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jun 2022 16:27:35 +0300
Message-Id: <20220620132737.2015073-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620132737.2015073-1-amir73il@gmail.com>
References: <20220620132737.2015073-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] syscalls/fanotify09: Verify if no events are
 expected
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some test cases expect no events for non-first groups and some expect
one event on non-dir child for non-first groups, but it is not verified
that non-first groups get the desired amount of events, so add this
information to the test case definition.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify09.c     | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 60ffcb81b..a8d56c10b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -76,6 +76,7 @@ static struct tcase {
 	unsigned int report_name;
 	const char *close_nowrite;
 	int nevents;
+	unsigned int nonfirst_event;
 } tcases[] = {
 	{
 		"Events on non-dir child with both parent and mount marks",
@@ -83,7 +84,7 @@ static struct tcase {
 		0,
 		0,
 		DIR_NAME,
-		1,
+		1, 0,
 	},
 	{
 		"Events on non-dir child and subdir with both parent and mount marks",
@@ -91,7 +92,7 @@ static struct tcase {
 		FAN_ONDIR,
 		0,
 		DIR_NAME,
-		2,
+		2, 0,
 	},
 	{
 		"Events on non-dir child and parent with both parent and mount marks",
@@ -99,7 +100,7 @@ static struct tcase {
 		FAN_ONDIR,
 		0,
 		".",
-		2,
+		2, 0
 	},
 	{
 		"Events on non-dir child and subdir with both parent and subdir marks",
@@ -107,7 +108,7 @@ static struct tcase {
 		FAN_ONDIR,
 		0,
 		DIR_NAME,
-		2,
+		2, 0,
 	},
 	{
 		"Events on non-dir children with both parent and mount marks",
@@ -115,7 +116,7 @@ static struct tcase {
 		0,
 		0,
 		FILE2_NAME,
-		2,
+		2, FAN_CLOSE_NOWRITE,
 	},
 	{
 		"Events on non-dir child with both parent and mount marks and filename info",
@@ -123,7 +124,7 @@ static struct tcase {
 		0,
 		FAN_REPORT_DFID_NAME,
 		FILE2_NAME,
-		2,
+		2, FAN_CLOSE_NOWRITE,
 	},
 };
 
@@ -315,13 +316,8 @@ static void test_fanotify(unsigned int n)
 	for (i = 1; i < NUM_GROUPS; i++) {
 		ret = read(fd_notify[i], event_buf, EVENT_BUF_LEN);
 		if (ret > 0) {
-			uint32_t expect = 0;
-
-			if (tc->nevents > 1 && !tc->ondir)
-				expect = FAN_CLOSE_NOWRITE;
-
 			event = (struct fanotify_event_metadata *)event_buf;
-			verify_event(i, event, expect, "");
+			verify_event(i, event, tc->nonfirst_event, "");
 			event = FAN_EVENT_NEXT(event, ret);
 
 			close_event_fds(event, ret);
@@ -338,7 +334,10 @@ static void test_fanotify(unsigned int n)
 				"reading fanotify events failed");
 		}
 
-		tst_res(TPASS, "group %d got no event", i);
+		if (tc->nonfirst_event)
+			tst_res(TFAIL, "group %d expected and got no event", i);
+		else
+			tst_res(TPASS, "group %d got no event as expected", i);
 	}
 	cleanup_fanotify_groups();
 }
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
