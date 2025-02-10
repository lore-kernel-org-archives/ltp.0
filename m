Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE50C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 09:08:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42AD03C9892
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 10:08:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F3E13C9878
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:12 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 98FBA142FCE7
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E3E2521137;
 Mon, 10 Feb 2025 09:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739178431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEIG0PYcT8whlyMAISm0+9V3adTesBXo4Hmh0ft1TBE=;
 b=soC9jgwr2MXRfur3iUq+UkLDK7AQsQ20eW0mFdNsb2fYeDSDVRFq46JHeAJiSUV6ooV36I
 JwjrGgrots6lNbOVG4/HOShesSSMw7rX3cv66MrIYsCztPM5CYqX4MgBjRBcqsy6/Fv/Qn
 HL67Jpn3/eytI8NLlG7fMwk/ExZgRPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739178431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEIG0PYcT8whlyMAISm0+9V3adTesBXo4Hmh0ft1TBE=;
 b=2gbtfSHKIq2aX7byFvhftJ9amCzYK1FSG7I6DYA0MlbHUVk7MaGKx+A8OwueEj5F3r8LQW
 XyMVa+7AXXA9RPDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739178430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEIG0PYcT8whlyMAISm0+9V3adTesBXo4Hmh0ft1TBE=;
 b=BHYDk5ongGPzhShTrFEvRo6KxvoUMh6NDJ5KXrkssbcMTeHcowVXxLUbMgNWjd7C4L81fB
 jwRuvnTUFiRjeRDLO7aGEIBTPzoBnLNjf0frLKxK5YEhP1r+4Hrqd7r4SA5GameGhB7B7P
 JA1QCKSa5tZnHwwN/MLtyiZAGO0KVaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739178430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEIG0PYcT8whlyMAISm0+9V3adTesBXo4Hmh0ft1TBE=;
 b=Bst4lJQCicwK84DUbc89jRd36yD9/gWsLuZnFx5nBVOMewBc/pkxsIh9U13Ib+hL6Vn3+0
 0jXY7IBap+h3vpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9400413AF6;
 Mon, 10 Feb 2025 09:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +ISoIL7BqWdQLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Feb 2025 09:07:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Feb 2025 10:07:08 +0100
MIME-Version: 1.0
Message-Id: <20250210-mmap_suite_refactoring-v2-3-6edea3a4363a@suse.com>
References: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
In-Reply-To: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739178429; l=1934;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=REFeB7ZOazFlYsySQb27h5bkZpfH+IbuMkhb3XsryhI=;
 b=RlQVJaSf8HJ4tRg1NRbOClcaImVRHjBEyBcp6q91QSmTWvakpHr7PLC+eWNkoas7sNgCw23Zc
 CTsYGz19iHMCWMdI2P+sYamkTE7B2qLQyC0gDwXCjHLjSH/nagS90ov
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/8] Cleanup mmap12 test
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
 testcases/kernel/syscalls/mmap/mmap12.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap12.c b/testcases/kernel/syscalls/mmap/mmap12.c
index 995a2bab091a745dd7332fe919c1ea38b25641e3..7a3dd2e1731efcfde499b7ae72d6805475889b27 100644
--- a/testcases/kernel/syscalls/mmap/mmap12.c
+++ b/testcases/kernel/syscalls/mmap/mmap12.c
@@ -1,31 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */
 
-/*
- * Test Description:
- *  Verify MAP_POPULATE works fine.
- *  "For a file mapping, this causes read-ahead on the file.
- *   Later accesses to the mapping will not be blocked by page faults"
+/*\
+ * [Description]
  *
- * Expected Result:
- *  mmap() with MAP_POPULATE should succeed returning the address of the
- *  mapped region and this file has been read into RAM, so pages should
- *  be present.
+ * Verify that mmap() with MAP_POPULATE succeed returning the address of the
+ * mapped region. The file should be read into RAM, and pages should be present.
  */
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <stdint.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <sys/shm.h>
 
 #include "tst_test.h"
 
@@ -60,9 +44,9 @@ static void page_check(void)
 			tst_res(TCONF | TERRNO,
 				"don't have permission to open dev pagemap");
 			return;
-		} else {
-			tst_brk(TFAIL | TERRNO, "pen dev pagemap failed");
 		}
+
+		tst_brk(TFAIL | TERRNO, "pen dev pagemap failed");
 	}
 
 	offset = SAFE_LSEEK(pm, index, SEEK_SET);

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
