Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFE6C5AE59
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 09:01:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BFF93CA2FC
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 11:01:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5A0A3C1A2E
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 11:00:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BAE251000D20
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 11:00:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C3D855C03E;
 Thu,  5 Jun 2025 09:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749114040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BsvcWwwKKF4UTNOF76TUKfUH3fFfQUOr+HhWsWVYth8=;
 b=g6TrHQHGMwk1SgUl8MZuvN1iqcqw0/IBCqj6zrFP+UjzlmyHqHY12FKQ2aceEfwZ95HmI0
 5W12mvhu7cSgTontMKPkitIOocIrAYbuvHUTh1wDzeHInZnHboAGECb9FBDTTJnIiy2KRw
 XmODltjnrsxcjsH46ZRvxZWJTV4AZM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749114040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BsvcWwwKKF4UTNOF76TUKfUH3fFfQUOr+HhWsWVYth8=;
 b=3/Yozl0sjFS9dHrRadtGacRJJPg5e6oQEoE/jFsPWBY4WKE89GgNz+XTQ9vmqMxvYevbF8
 yKQRl7TbvupsmrAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749114040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BsvcWwwKKF4UTNOF76TUKfUH3fFfQUOr+HhWsWVYth8=;
 b=g6TrHQHGMwk1SgUl8MZuvN1iqcqw0/IBCqj6zrFP+UjzlmyHqHY12FKQ2aceEfwZ95HmI0
 5W12mvhu7cSgTontMKPkitIOocIrAYbuvHUTh1wDzeHInZnHboAGECb9FBDTTJnIiy2KRw
 XmODltjnrsxcjsH46ZRvxZWJTV4AZM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749114040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BsvcWwwKKF4UTNOF76TUKfUH3fFfQUOr+HhWsWVYth8=;
 b=3/Yozl0sjFS9dHrRadtGacRJJPg5e6oQEoE/jFsPWBY4WKE89GgNz+XTQ9vmqMxvYevbF8
 yKQRl7TbvupsmrAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB058137FE;
 Thu,  5 Jun 2025 09:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KRwWKLhcQWgzUAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 05 Jun 2025 09:00:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 05 Jun 2025 10:59:54 +0200
MIME-Version: 1.0
Message-Id: <20250605-lsm_fix_attr_is_overset-v2-1-dd10ddb04238@suse.com>
X-B4-Tracking: v=1; b=H4sIAIlcQWgC/4WNUQrCMBBEr1L220iSxlT88h5SQqkbu2Cbko1BK
 bm7sRfw8w0zbzZgjIQMl2aDiJmYwlJBHxoYp2F5oKB7ZdBSn6SVRjx5dp7ebkgpOmIXMkbGJFS
 rR2O8kp3toK7XiLW2m2995Yk4hfjZj7L6pf+dWQkljPX+bI1uB2Wu/GI8jmGGvpTyBZZd6xS9A
 AAA
X-Change-ID: 20250604-lsm_fix_attr_is_overset-132c44f10767
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749114040; l=3166;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=EoO1DhePXjcjg0F85RIgSpMorue4HRRJIp13HSf1hBY=;
 b=tqAGcdMfm52sV199ayl3nfDplUEs7X+8v12AjRQam3+KPD3ewqLoVVLwGRJb+k2ZosG6oHKK7
 Q8SzOeToJf5B5+B39XyIYQJYfbcTJz77xBQkdvbUac7jne9Ow/vRBod
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.11 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_SHORT(-0.01)[-0.039]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo, opensuse.org:url]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lsm: fix overset attr test
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

At the same time, overset attr test is _not_ checking if attr is
overset, but rather checking if attr is out-of-bounds, considering OR
operator as a valid way to generate an invalid value with
LSM_ATTR_CURRENT. This is not correct, since any OR operation using
LSM_ATTR_CURRENT will generate a valid value for the LSM(s) code. So we
remove this test that doesn't make much sense at the moment and replace
it with an "invalid attr test" instead.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
This patch will fix all false positive errors, where LSM(s) might
be implemented in a different way. We just skip errno check.

This will also fix:
https://openqa.opensuse.org/tests/5087893#step/lsm_set_self_attr01/8
---
Changes in v2:
- remove exp_errno from struct
- change attr overset test
- Link to v1: https://lore.kernel.org/r/20250604-lsm_fix_attr_is_overset-v1-1-46ff86423a14@suse.com
---
 testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
index caccdda7ecf2edaac1fa8e2dc2ccdd0aff020804..cde9c2e706ed607024dff362b7ff00cbcef1d6a5 100644
--- a/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
+++ b/testcases/kernel/syscalls/lsm/lsm_set_self_attr01.c
@@ -23,28 +23,24 @@ static struct tcase {
 	struct lsm_ctx **ctx;
 	uint32_t *size;
 	uint32_t flags;
-	int exp_errno;
 	char *msg;
 } tcases[] = {
 	{
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
@@ -52,15 +48,13 @@ static struct tcase {
 		.ctx = &ctx,
 		.size = &ctx_size,
 		.flags = 1,
-		.exp_errno = EINVAL,
 		.msg = "flags must be zero",
 	},
 	{
-		.attr = LSM_ATTR_CURRENT | LSM_ATTR_EXEC,
+		.attr = -1000,
 		.ctx = &ctx,
 		.size = &ctx_size,
-		.exp_errno = EINVAL,
-		.msg = "attr is overset",
+		.msg = "attr is invalid",
 	}
 };
 
@@ -77,9 +71,9 @@ static void run(unsigned int n)
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
