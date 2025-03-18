Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E984DC282EC
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 11:15:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 641373CABC1
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 12:15:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE76B3CABD0
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:14:07 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AAA641400048
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:14:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C54141F770;
 Tue, 18 Mar 2025 11:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742296444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRAgtxbJBQzAsAl/29G0uvclbmVcuhQ0Og+qz8Y/QW8=;
 b=PXNofQi6PnH6lf/bAgs3rSJhttHYJ0Hxwdm0R3zEKVi7kbs+quvCUjbnZtmrJLx4aSHyBv
 XhwPaez/Plu1MuJJK1v+etNS6l4vjaLt7x8SpWy9S1FHSAk0LwIvsbGEqcuKmDaURn+Ik/
 hpvN2XEAvdkLp5LO940hEFLxx3bJTXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742296444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRAgtxbJBQzAsAl/29G0uvclbmVcuhQ0Og+qz8Y/QW8=;
 b=o47rD+AVr/kVEGZqk80F7/P55sHGaa18A9ixdfpuvCex6vn12PbpCp6Ov5mAE5QSqMyBG4
 GLVsLEngq9WXOhBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742296444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRAgtxbJBQzAsAl/29G0uvclbmVcuhQ0Og+qz8Y/QW8=;
 b=PXNofQi6PnH6lf/bAgs3rSJhttHYJ0Hxwdm0R3zEKVi7kbs+quvCUjbnZtmrJLx4aSHyBv
 XhwPaez/Plu1MuJJK1v+etNS6l4vjaLt7x8SpWy9S1FHSAk0LwIvsbGEqcuKmDaURn+Ik/
 hpvN2XEAvdkLp5LO940hEFLxx3bJTXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742296444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRAgtxbJBQzAsAl/29G0uvclbmVcuhQ0Og+qz8Y/QW8=;
 b=o47rD+AVr/kVEGZqk80F7/P55sHGaa18A9ixdfpuvCex6vn12PbpCp6Ov5mAE5QSqMyBG4
 GLVsLEngq9WXOhBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74229139D2;
 Tue, 18 Mar 2025 11:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UN6YGnxV2WdGRgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 18 Mar 2025 11:14:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 18 Mar 2025 12:13:59 +0100
MIME-Version: 1.0
Message-Id: <20250318-mmap_suite_refactoring-v5-7-1b087988f1c9@suse.com>
References: <20250318-mmap_suite_refactoring-v5-0-1b087988f1c9@suse.com>
In-Reply-To: <20250318-mmap_suite_refactoring-v5-0-1b087988f1c9@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742296439; l=673;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=c2VWtn0+9MdwiaRTk2UGHsP9jvZaSyVL6ka4qYo14kg=;
 b=2oVtBgx8Mzr4GH9VUckMdS9DNwfL+A2Pogwxf2TO0qigRgH4feL+Fdoqj0Pd6Lu++NEdHZMsg
 fNGfBadlW5MC2sxkmYMjjGo6kUX8vMjwnYwUD9Vocyb/9w6rr2xrtZi
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:mid, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 7/8] Cleanup mmap20 test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap20.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap20.c b/testcases/kernel/syscalls/mmap/mmap20.c
index 09dea8c41d2687031cce7ded90cf10d2ab392a5b..f8e5129d1e490b931f0668bd2fe8ea89c64d0404 100644
--- a/testcases/kernel/syscalls/mmap/mmap20.c
+++ b/testcases/kernel/syscalls/mmap/mmap20.c
@@ -10,9 +10,6 @@
  * flag and invalid flag.
  */
 
-#include <errno.h>
-#include <stdio.h>
-#include <sys/types.h>
 #include "tst_test.h"
 #include "lapi/mmap.h"
 

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
