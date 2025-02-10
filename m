Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CBEC02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 09:09:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 269253C9875
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 10:09:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EBCB3C987D
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:13 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D1E3609195
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6DDD621108;
 Mon, 10 Feb 2025 09:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739178431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXkl0GO7Pmm3fR+seRR2ICDdr41pXWhL7Tzf3UqlbBY=;
 b=p9cpAKJgTrIvqTGR5e3YThO41cGzO0tPdta1G2ylAhLlKdE6RVhkNWCHPAGX2p/7RUJEEN
 RRZj1lPB7BaJSQ8DLwEUAd4xdIfdb4GKUDJbBYrNFmZ/8YF/57MFJPvIzkLNAdX1jIlpW8
 8VW8xEZKSlhWCjMJkQ4HHdF+nvwd1rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739178431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXkl0GO7Pmm3fR+seRR2ICDdr41pXWhL7Tzf3UqlbBY=;
 b=otr0pi+xuo4GZZh1lOLdV5lq6s674VYHz6da3NArPQuepPM1OgZYSphJOi/O68QYm4f/Sk
 PlBYh8TzS35oYNCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739178431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXkl0GO7Pmm3fR+seRR2ICDdr41pXWhL7Tzf3UqlbBY=;
 b=p9cpAKJgTrIvqTGR5e3YThO41cGzO0tPdta1G2ylAhLlKdE6RVhkNWCHPAGX2p/7RUJEEN
 RRZj1lPB7BaJSQ8DLwEUAd4xdIfdb4GKUDJbBYrNFmZ/8YF/57MFJPvIzkLNAdX1jIlpW8
 8VW8xEZKSlhWCjMJkQ4HHdF+nvwd1rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739178431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXkl0GO7Pmm3fR+seRR2ICDdr41pXWhL7Tzf3UqlbBY=;
 b=otr0pi+xuo4GZZh1lOLdV5lq6s674VYHz6da3NArPQuepPM1OgZYSphJOi/O68QYm4f/Sk
 PlBYh8TzS35oYNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 036BE13707;
 Mon, 10 Feb 2025 09:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WHx/OL7BqWdQLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Feb 2025 09:07:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Feb 2025 10:07:09 +0100
MIME-Version: 1.0
Message-Id: <20250210-mmap_suite_refactoring-v2-4-6edea3a4363a@suse.com>
References: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
In-Reply-To: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739178429; l=1613;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=3zyyacJZPeQJmFUYVbt6nJEcUohHFBgiI4br87SbMlQ=;
 b=jay+FIRdwVHkKhTlGiaLQ1mNE909z4sY7t+pOWufA4FDgfjxz9SVY9ralncM3KYs3iCu09//x
 /8U0a3qtq5/DxrDVTfeXne/VB1YvX3ed4VhkEpBlLELX3X5cQnVsxl3
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/8] Cleanup mmap17 test
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
Cc: rbm@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap17.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap17.c b/testcases/kernel/syscalls/mmap/mmap17.c
index 39703fbd397d33fe549b1c9a52db62f763e146dd..0d2ed9ccf7928f960f8bfa5e31604e840c6939a8 100644
--- a/testcases/kernel/syscalls/mmap/mmap17.c
+++ b/testcases/kernel/syscalls/mmap/mmap17.c
@@ -1,28 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) Zilogic Systems Pvt. Ltd., 2020
- * Email: code@zilogic.com
+ *	Email: code@zilogic.com
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Test mmap with MAP_FIXED_NOREPLACE flag
+/*\
+ * [Description]
  *
- * We are testing the MAP_FIXED_NOREPLACE flag of mmap() syscall. To check
+ * Verify MAP_FIXED_NOREPLACE flag for the mmap() syscall and check
  * if an attempt to mmap at an exisiting mapping fails with EEXIST.
+ *
+ * [Algorithm]
+ *
  * The code allocates a free address by passing NULL to first mmap call
- * Then tries to mmap with the same address using MAP_FIXED_NOREPLACE flag
+ * then tries to mmap with the same address using MAP_FIXED_NOREPLACE flag
  * and the mapping fails as expected.
  */
 
-#include <stdio.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <stdlib.h>
-#include "lapi/mmap.h"
 #include "tst_test.h"
 
 static int fd_file1;

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
