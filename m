Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A456BC43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 14:02:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 097853E9699
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 16:02:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 089963E5E53
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 16:01:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CB8A110006D9
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 16:01:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C1A43E12;
 Mon, 13 Jul 2026 14:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783951300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW0JO12SqVVJK/qLzfrPiTl2ZZIgjyXu5g1wp/nW3p0=;
 b=vUEazfYXmLp4lXXVinV9ATDr0c+I4A+mSjAZabmAWD9wLNBeFE+JdDfxBq5pjMwHJhxHa3
 DCWd/plg9pbU/mJlV/flsAma5EnnM/89Br6sVubkjipOFAE+A54fJ4E0rcRZ7P2HL/oxny
 t4WOWTDr7c5Gwq54CWjKukNltXnpB/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783951300;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW0JO12SqVVJK/qLzfrPiTl2ZZIgjyXu5g1wp/nW3p0=;
 b=ClZnzIUdDnPdfcIOLQVcCwqqHS45yQriNPtdwbPyQmlB4pHjsJcRODnTrMv7ErH3BYIap1
 cBfHSdA8NeqMxPCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783951298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW0JO12SqVVJK/qLzfrPiTl2ZZIgjyXu5g1wp/nW3p0=;
 b=UFAXVGsBIiHeKA66pRGwKw/nn7lryrzI7n8qQGBymVxarEl6CovtlDWpqNNEonfQa2Z+D7
 Vnzkghcl/6Z/rjBcbeo/0ohG4LvHJhjcUIV9+0NVHMTOo04XkCMTtQpM3kEyYWTaVzGATZ
 6r00wd01W+ksdixL5H2plc7kPZMzg+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783951298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LW0JO12SqVVJK/qLzfrPiTl2ZZIgjyXu5g1wp/nW3p0=;
 b=2JDAGuneHhpIKcy76XKzKU0S1J9Ihvl0I7VH3DxymTtfpFQXVywjj0BLvO6HiCDCSOhw1R
 nmOry6kzkIaQF0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41127779B0;
 Mon, 13 Jul 2026 14:01:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IO8jDsLvVGpaEQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 13 Jul 2026 14:01:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 13 Jul 2026 16:01:30 +0200
MIME-Version: 1.0
Message-Id: <20260713-shell_oom_protection-v1-2-b732e8647894@suse.com>
References: <20260713-shell_oom_protection-v1-0-b732e8647894@suse.com>
In-Reply-To: <20260713-shell_oom_protection-v1-0-b732e8647894@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783951297; l=1308;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=lZQqU5TLYzy5l4kw9C/wNIRaj7IOQUav8rtWK7OFgeg=;
 b=SAvWuX+yIBD6tHT96OHIZ8b7j9ftpIKxIDNrbxdsXzUyjF9vWeTE6jnN6jW7KG8mADZer8ze3
 sxNyNnBf8pkDWdx9UCJbx54Wu1kR7WLQ2pXKwqIv//Zt2n1i2mZZIvD
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] memcg_stress: survive OOM by targeting the
 stressors
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

The single-cgroup subtest intentionally lets one process fault in the
whole memory budget to push the system to its memory ceiling, so hitting
the OOM killer is an expected part of the stress. The problem is that the
OOM killer could reap the driver script, turning that expected pressure
into a spurious TBROK.

Activate OOM protection so the driver script won't be the OOM victim.

Fixes: 02961a7b2bb4 ("memcg_stress_test.sh: Fix reserved mem calculate")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 47cac9af8bec970b7fb338c5469ab73d55267740..f32161f3f52a500d83cb2f6465adfb5130055dba 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -14,6 +14,7 @@ TST_CLEANUP=cleanup
 TST_CNT=2
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="mount umount cat kill mkdir rmdir grep awk cut"
+TST_OOM_PROTECTION=1
 
 # Each test case runs for 900 secs when everything fine
 # therefore the default 5 mins timeout is not enough.

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
