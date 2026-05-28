Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21B3CD5BD5
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 16:29:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EC823D01D0
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 18:29:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F35743CBA47
 for <ltp@lists.linux.it>; Thu, 28 May 2026 18:29:22 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 971211A007AB
 for <ltp@lists.linux.it>; Thu, 28 May 2026 18:29:22 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bcd0111ea98so1806263266b.1
 for <ltp@lists.linux.it>; Thu, 28 May 2026 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779985762; x=1780590562; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u1j9gs+T1Y2cuH+LdhMzekqSJPfvpxLoyYSDn7ed2LY=;
 b=d2IXQbEpyKbi4g99ELv7e4YR1mJREcVxp8fSK+04XLCHWK0XEC40vBTJeiKRla8FSX
 9rRvMJ3x039E0KqWSP1B54D253hFF/QaSVtd7B70B5XE70LFyhCkcWvH31bByZcTwcvV
 C8PgKHCpimXBVUM3icWM9a1M9+cB2tQNudpKiT2YsKSFyFbALOYjVWVOmSVTKIWDmX1V
 4ADPGsKz5QBx51PgVCzUj/Z08UnfeX+xjCD2R+41ZY3OQtLGmdudm/Z1ggIJx9CzrTuf
 dCjxu75dBVOyc1t1t6AaEZmT1+AeGWiErKvpqwP04ERDd5SM2d/nD41ZNiHZ+565X1R6
 o4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779985762; x=1780590562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1j9gs+T1Y2cuH+LdhMzekqSJPfvpxLoyYSDn7ed2LY=;
 b=sFR0KAnlpHaYwWT/hGKGF7ryJWgVP+8REKt1weqwxScbAg+hyO+KHmjYb2XNrqU5lV
 zs9Lk2YO2+3sgWg4cFZNwcNpPG7xLfaMzKcI0NG9CCQImpHQBlZY6FSlwnS2Ah9agXLu
 d1/PCFZSSPcIJ/f+GjF7F8v7egUl2w2fdhCXXpN+FENz3QRorEPZbmG9ZwtuXGI7S7K3
 gyQ36ID4kghZnRA2YALQ74GUfIdZueBqTnJofg5Cc42WA248V67YdCyjdkBIdhj3UaMk
 RB8ZzAnU3hKq73oV7SAfWEY3XDlPG9lf7BjQGUxrYPwyH27hD6+rN0c2E9+Ryk6YWhgJ
 53WA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cfPqzpSwIA70eK9g/uvIF+hTRAguQllyYdypFEtbOXCPbBL2y+NBE0ED65H26XDuV8zM=@lists.linux.it
X-Gm-Message-State: AOJu0YzZ0uMuVeHfaYdSJhZ1yvEyYcvy2jUlSLbXwwMKKtSsCdsUEPit
 YWf6fn632LMPJ3ejeFcItfxyK0jX7YKpprCjtd8jLPL3gec2Q95H15mrehtLJ8M8
X-Gm-Gg: Acq92OGJcycC8zrxv3XOs2Zl1nPTjo071usn54UWatPQlWs333wsy5WFxIJG+x/fMyU
 Dj8Q1IGM73CMK1/Bb3oREWrLfMqD74beDryPsvOnw1/15pVY5i2znwTv9wtvDY9gDluIcGnoVk/
 oNthZJbYaahmmVlaSvsnvfxTJS1vYAuliCrJIJC8Z/HeQiaoB+UPeA1YzNP0xHaOxcnmr/NJmzK
 Sp/ymuK5+7QEDHc8m9tvROKJcW2MU1A8s0zjRpc/q6Dz4PdyYnXmq3zClCEC8enIdlrhm+OiQSb
 oc+x9s4rpEQ5du7rzCWYRRqoC98vVWhUwam7tabyljdE5LBOUDjcmUydad5kE+FD9U2hR9nftQl
 WXbzKSb3lQGZlKl4qPW7LFLvEVrCZJVWm2qkctU+LKGMycTWLHTfeTQDzwkqC68aa6qn412MQuK
 sDDa3y61gvBaaNuy2+bAUSC88tI699iJ022fcL4vLU5463hl+eWURO4WAztFXna3mClcIDdTibe
 XDVqJhIUEMV0LiSf5QTqWpg/H5FAU693gBsxKI=
X-Received: by 2002:a17:907:7613:b0:bd5:5834:1d3f with SMTP id
 a640c23a62f3a-bdd29068588mr1231446266b.22.1779985761600; 
 Thu, 28 May 2026 09:29:21 -0700 (PDT)
Received: from localhost
 (2001-1c00-570d-ee00-4e63-8cf6-4447-e472.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:570d:ee00:4e63:8cf6:4447:e472])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc2c4e3d5sm759056866b.15.2026.05.28.09.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:29:21 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 May 2026 18:29:19 +0200
Message-ID: <20260528162920.914321-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] fanotify21: fix test failure when running
 iterations
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Peter reported that fanotify21 -i2 fails.
Fix this by always remounting ro/rw before every test.
Use a bind mount, where remount works regardless of base fs.

Reported-by: Petr Vorel <pvorel@suse.cz>
Link: https://lore.kernel.org/linux-fsdevel/20260527072312.GA231966@pevik/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

changes since v1:
- Address LTP AI Reviewer comments

 .../kernel/syscalls/fanotify/fanotify21.c      | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 340fb0018..4d2115469 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -123,6 +123,9 @@ static void do_setup(void)
 	int pidfd;
 	int init_flags = FAN_REPORT_PIDFD;
 
+	/* Bind mount so remount ro/rw always work */
+	SAFE_MOUNT(MOUNT_PATH, MOUNT_PATH, "none", MS_BIND, NULL);
+
 	if (tst_variant) {
 		fanotify_fd = -1;
 		fd_error_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FD_ERROR, ".");
@@ -171,15 +174,9 @@ static void do_test(unsigned int num)
 		return;
 	}
 
-	if (tc->remount_ro) {
-		/* SAFE_MOUNT fails to remount FUSE */
-		if (mount(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
-			  MS_REMOUNT|MS_RDONLY, NULL) != 0) {
-			tst_brk(TFAIL,
-				"filesystem %s failed to remount readonly",
-				tst_device->fs_type);
-		}
-	}
+	/* remount ro/rw the bind mount */
+	SAFE_MOUNT("none", MOUNT_PATH, "none", MS_BIND | MS_REMOUNT |
+		   (tc->remount_ro ? MS_RDONLY : 0), NULL);
 
 	/*
 	 * Generate the event in either self or a child process. Event
@@ -355,6 +352,9 @@ static void do_cleanup(void)
 
 	if (self_pidfd_fdinfo)
 		free(self_pidfd_fdinfo);
+
+	/* Unmount the bind mount */
+	SAFE_UMOUNT(MOUNT_PATH);
 }
 
 static struct tst_test test = {
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
