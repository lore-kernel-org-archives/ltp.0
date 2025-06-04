Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34863C5B543
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 13:41:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 546793CA11B
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 15:41:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CBDB3C9349
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 15:40:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A6CC8600CC6
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 15:40:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2F372120F;
 Wed,  4 Jun 2025 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749044444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=33kPwmigl7d4vrqk70G0WATIpxNkmuy8om6vaukVNSY=;
 b=J5fhHCBBm8aZ3djXE4eRit1K3JZKd+/QVjQcqeHJUCf/A7a5dH5ivOVgICV8eK84nQ7uJu
 GXJ0Oeqal+yAm87z7qIeyNJhZcfZlEn72jOQnmjvGKecZXKt8DqDj47qeDkgF9CFShGEnb
 dN8F3KU4q+P45bY1vg5EVhOZZF7oipI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749044444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=33kPwmigl7d4vrqk70G0WATIpxNkmuy8om6vaukVNSY=;
 b=lF4S6PWd9w0aKgw3WW+6IDD+Txi2cUdZ/al3r8qWeu7igRn2Ydb7g6yoA9zUWSemmJsbq1
 WKsNWsgegdSxPIBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749044444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=33kPwmigl7d4vrqk70G0WATIpxNkmuy8om6vaukVNSY=;
 b=J5fhHCBBm8aZ3djXE4eRit1K3JZKd+/QVjQcqeHJUCf/A7a5dH5ivOVgICV8eK84nQ7uJu
 GXJ0Oeqal+yAm87z7qIeyNJhZcfZlEn72jOQnmjvGKecZXKt8DqDj47qeDkgF9CFShGEnb
 dN8F3KU4q+P45bY1vg5EVhOZZF7oipI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749044444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=33kPwmigl7d4vrqk70G0WATIpxNkmuy8om6vaukVNSY=;
 b=lF4S6PWd9w0aKgw3WW+6IDD+Txi2cUdZ/al3r8qWeu7igRn2Ydb7g6yoA9zUWSemmJsbq1
 WKsNWsgegdSxPIBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9823B1369A;
 Wed,  4 Jun 2025 13:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EbhqI9xMQGh3ZwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 04 Jun 2025 13:40:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 04 Jun 2025 15:40:44 +0200
MIME-Version: 1.0
Message-Id: <20250604-lsm_fix_attr_is_overset-v1-1-46ff86423a14@suse.com>
X-B4-Tracking: v=1; b=H4sIANtMQGgC/x2MWwqAIBAArxL7naBmBl0lQqK2WujFrkQQ3j3pc
 2BmXhBkQoG2eIHxJqHzyGDKAsZ1OBZUNGUGq22tvXZqkz3M9IQhRg4k4byRBaMylR2dm41ufAO
 5vhiz9p+7PqUPXa6W6GkAAAA=
X-Change-ID: 20250604-lsm_fix_attr_is_overset-132c44f10767
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749044444; l=2403;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=RGFQFtpD+2B7JlL+AAO/KfOSCaYoo21gMJEtHQsSkZk=;
 b=6i/AsPgypaoxx7zLgsYc1t81UYzLdf4ATislL6qy7VE7AmopuTqtipI+5Lt8t8o2uXWC7lUvC
 b1JQsdKCVBnAJU0QIXnjMtURqLPU/Snx5njUA++/oNsUu+qc5TIdleo
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.985]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, opensuse.org:url,
 suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lsm: fix overset attr test
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

LSM(s) usually handle their own internal errors in a different way,
so the right way to check if they return error, is to verify that the
common return value is -1. This is the max we can do, since errno might
vary according to the LSM implementation.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
This patch will fix all false positive errors, where LSM(s) might
be implemented in a different way. We just skip errno check.

This will also fix:
https://openqa.opensuse.org/tests/5087893#step/lsm_set_self_attr01/8
---
 testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
index caccdda7ecf2edaac1fa8e2dc2ccdd0aff020804..f53768e237364415d1bd15cd3653c24aac653441 100644
--- a/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
+++ b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
@@ -30,21 +30,18 @@ static struct tcase {
 		.attr = LSM_ATTR_CURRENT,
 		.ctx = &ctx_null,
 		.size = &ctx_size,
-		.exp_errno = EFAULT,
 		.msg = "ctx is NULL",
 	},
 	{
 		.attr = LSM_ATTR_CURRENT,
 		.ctx = &ctx,
 		.size = &ctx_size_small,
-		.exp_errno = EINVAL,
 		.msg = "size is too small",
 	},
 	{
 		.attr = LSM_ATTR_CURRENT,
 		.ctx = &ctx,
 		.size = &ctx_size_big,
-		.exp_errno = E2BIG,
 		.msg = "size is too big",
 	},
 	{
@@ -52,14 +49,12 @@ static struct tcase {
 		.ctx = &ctx,
 		.size = &ctx_size,
 		.flags = 1,
-		.exp_errno = EINVAL,
 		.msg = "flags must be zero",
 	},
 	{
-		.attr = LSM_ATTR_CURRENT | LSM_ATTR_EXEC,
+		.attr = LSM_ATTR_CURRENT | LSM_ATTR_PREV,
 		.ctx = &ctx,
 		.size = &ctx_size,
-		.exp_errno = EINVAL,
 		.msg = "attr is overset",
 	}
 };
@@ -77,9 +72,9 @@ static void run(unsigned int n)
 	ctx_size_small = 1;
 	ctx_size_big = ctx_size + 1;
 
-	TST_EXP_FAIL(lsm_set_self_attr(tc->attr, *tc->ctx, *tc->size, tc->flags),
-	      tc->exp_errno,
-	      "%s", tc->msg);
+	TST_EXP_EXPR(lsm_set_self_attr(
+		tc->attr, *tc->ctx, *tc->size, tc->flags) == -1,
+		"%s", tc->msg);
 }
 
 static void setup(void)

---
base-commit: 3ef4bac1dd253628dfdb8a823b51ae0d24fa0616
change-id: 20250604-lsm_fix_attr_is_overset-132c44f10767

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
