Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660E9CC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 08:21:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE23C3E4DB8
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 10:21:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9130A3CD546
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 10:21:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DF5F3200CEE
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 10:21:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 949D622167;
 Wed, 14 Oct 2026 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791966081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xfv8/spRTkryYFWiovX2zAL+AOfyvIQT1R3JyUVHS3c=;
 b=f+NANs+54Ne2PQeZH/lvj55UM1JnLs+71j2T75BKeMicuhxLyENfiNXLm4yf27LclsfKyG
 mfIMx1jo5U6NO0NN1NFORvfk8xkixToZ46gra1jq6/C9IIVNUvgsHg3FkAajyN+2LZS5jg
 Eo0kZZH4cixruFgpIcLHi4ViALFK6Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791966081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xfv8/spRTkryYFWiovX2zAL+AOfyvIQT1R3JyUVHS3c=;
 b=oa6chNeAmrZRZK/8++bHoWW8ykKauhtPAH8JIXZhhJlqHpbpVy5ftJHOYrkt5tfhlDTZQI
 W9+Mk5LBVLYIcfAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791966081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xfv8/spRTkryYFWiovX2zAL+AOfyvIQT1R3JyUVHS3c=;
 b=f+NANs+54Ne2PQeZH/lvj55UM1JnLs+71j2T75BKeMicuhxLyENfiNXLm4yf27LclsfKyG
 mfIMx1jo5U6NO0NN1NFORvfk8xkixToZ46gra1jq6/C9IIVNUvgsHg3FkAajyN+2LZS5jg
 Eo0kZZH4cixruFgpIcLHi4ViALFK6Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791966081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xfv8/spRTkryYFWiovX2zAL+AOfyvIQT1R3JyUVHS3c=;
 b=oa6chNeAmrZRZK/8++bHoWW8ykKauhtPAH8JIXZhhJlqHpbpVy5ftJHOYrkt5tfhlDTZQI
 W9+Mk5LBVLYIcfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34A231368E;
 Wed, 14 Oct 2026 08:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L38nM4A7z2rQYAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 14 Oct 2026 08:21:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 14 Oct 2026 10:21:20 +0200
MIME-Version: 1.0
Message-Id: <20261014-fix_process_vm_writev_permissions-v1-1-6affee2da859@suse.com>
X-B4-Tracking: v=1; b=H4sIAH87z2oC/yWNwQ6CMBAFf4Xs2SaUaCP+ijENlFddE6DZxWpC+
 HeLHucwMysphKF0qVYSZFaepwL2UFF4dNMdhofC1NSNs7U9msgfn2QOUPV59G/hBdknyMi6y2p
 cDJ07teehjT2VThIU6fe43v6sr/6JsOxh2rYvosYy9oUAAAA=
X-Change-ID: 20261014-fix_process_vm_writev_permissions-6fca6598d9fb
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791966080; l=3672;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=4AUJWTyc7KbCcfxwFKwTM88eysOx3eBD6jMVaakiOwE=;
 b=QVMoGNBwzbAB9cCohPi8OpA+DFxeS7RDBSEv+QO289x92BX0jDhEwjuOSJXmx7wIBM8aSTNLx
 qoYSbisTpYaDaA0HJ9vkV9DM5aRLivuHv+xSRkFYvws4r6mv06BDW8f
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
Subject: [LTP] [PATCH] syscalls/cma: Require root for process_vm tests
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

When security modules like Yama LSM are active (e.g. ptrace_scope >= 1),
process_vm_readv() and process_vm_writev() fail with EPERM for
unprivileged sibling processes due to missing CAP_SYS_PTRACE capability.

Require root so tests can reliably execute across different security
configurations.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
The cma testing suite started to fail on modern systems enabling YAMA.
Unfortunately, using CAP_PTRACE capability for users is not enough to
avoid an EPERM. For this reason, it's better to require root and fix the
whole suite in one shot.
---
 testcases/kernel/syscalls/cma/process_vm_readv02.c  | 5 +++++
 testcases/kernel/syscalls/cma/process_vm_readv03.c  | 5 +++++
 testcases/kernel/syscalls/cma/process_vm_writev02.c | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index 1e2ac38fa..d985bdad9 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -10,6 +10,10 @@
  * then the other one calls process_vm_readv and reads from the same
  * memory location, it then verifies if process_vm_readv returns
  * correct data.
+ *
+ * Requires root for ``CAP_SYS_PTRACE`` to access the address space of
+ * another process when security policies such as Yama LSM (ptrace_scope)
+ * are enabled.
  */
 
 #include <stdio.h>
@@ -116,6 +120,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.needs_root = 1,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 };
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 95d35c422..2b533ca56 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -12,6 +12,10 @@
  * locations and the local iovecs initialized to randomly sized and
  * allocated local memory locations. The second child then verifies
  * that the data is copied correctly.
+ *
+ * Requires root for ``CAP_SYS_PTRACE`` to access the address space of
+ * another process when security policies such as Yama LSM (ptrace_scope)
+ * are enabled.
  */
 
 #include <stdio.h>
@@ -189,6 +193,7 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.needs_root = 1,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.tcnt = ARRAY_SIZE(testcases),
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index 15bd66a44..e9edc4a6f 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -9,6 +9,10 @@
  * Fork two children, the first one allocates a chunk of memory and the
  * other one call process_vm_writev to write known data into the first
  * child. Then first child verifies that the data is as expected.
+ *
+ * Requires root for ``CAP_SYS_PTRACE`` to access the address space of
+ * another process when security policies such as Yama LSM (ptrace_scope)
+ * are enabled.
  */
 
 #include <stdlib.h>
@@ -122,6 +126,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.needs_root = 1,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
 	.options =

---
base-commit: c082253808608e57a4fba3e7f3787a9f5c377638
change-id: 20261014-fix_process_vm_writev_permissions-6fca6598d9fb

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
