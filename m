Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6940DEB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 12:02:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B3593CE0F3
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 14:02:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 439B93CACDF
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:02:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 43AFC600858
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:02:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA4921F88C;
 Tue, 20 Jun 2023 12:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687262523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUH9QcONMBimCFf4RaLsOOC9KoV/LFG4lNx33z7Zohk=;
 b=awd6CW88dB+3jb/9v1CE+bmUil0gFwuMF1N1D4OGpzoB0tx4wdkBNoy7I/3qeGPmTOwptC
 cEuLxdwqyS9w3VoiLIydGV9bBGDZvIKe1zaMPTkY2NRfMt3fQRk0Q3RBGBHaDT5F97LhG2
 Lrg2qgXU463r/NuBlzFhNVy3rGMqa3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687262523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUH9QcONMBimCFf4RaLsOOC9KoV/LFG4lNx33z7Zohk=;
 b=yR5l5fqyYQ4xP1WcbPoR/d+PETrTvYHCPVk1M7EWbNCR8YNkivs15XhgiVwb5f+GeQXFow
 co4KVz4cPHW3b7AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7732F139C7;
 Tue, 20 Jun 2023 12:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4NgMHDuVkWSQDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jun 2023 12:02:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 20 Jun 2023 14:01:59 +0200
Message-Id: <20230620120159.320052-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620120159.320052-1-pvorel@suse.cz>
References: <20230620120159.320052-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] utils: Remove unused ioprio.h
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It was added in 0a1e45f09 (in 2009), but even then it was not needed.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/utils/ioprio.h | 46 ------------------------
 1 file changed, 46 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/utils/ioprio.h

diff --git a/testcases/kernel/syscalls/utils/ioprio.h b/testcases/kernel/syscalls/utils/ioprio.h
deleted file mode 100644
index 07220945c..000000000
--- a/testcases/kernel/syscalls/utils/ioprio.h
+++ /dev/null
@@ -1,46 +0,0 @@
-#ifndef __IOPRIO_H__
-#define	__IOPRIO_H__
-
-//----------------------------------------------------------------------------
-// Copy of the 2.6.18 kernel header (linux/ioprio.h)
-//
-
-/*
- * Gives us 8 prio classes with 13-bits of data for each class
- */
-#define IOPRIO_BITS		(16)
-#define IOPRIO_CLASS_SHIFT	(13)
-#define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
-
-#define IOPRIO_PRIO_CLASS(mask)	((mask) >> IOPRIO_CLASS_SHIFT)
-#define IOPRIO_PRIO_DATA(mask)	((mask) & IOPRIO_PRIO_MASK)
-#define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
-
-#define ioprio_valid(mask)	(IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)
-
-/*
- * These are the io priority groups as implemented by CFQ. RT is the realtime
- * class, it always gets premium service. BE is the best-effort scheduling
- * class, the default for any process. IDLE is the idle scheduling class, it
- * is only served when no one else is using the disk.
- */
-enum {
-	IOPRIO_CLASS_NONE,
-	IOPRIO_CLASS_RT,
-	IOPRIO_CLASS_BE,
-	IOPRIO_CLASS_IDLE,
-};
-
-/*
- * 8 best effort priority levels are supported
- */
-#define IOPRIO_BE_NR	(8)
-
-enum {
-	IOPRIO_WHO_PROCESS = 1,
-	IOPRIO_WHO_PGRP,
-	IOPRIO_WHO_USER,
-};
-//-----------------------------------------------------------------------------
-
-#endif /* __IOPRIO_H__ */
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
