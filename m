Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89295C44514
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 08:03:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E21443E76BA
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 10:03:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AD663D00A7
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 10:03:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A8DA61A0009C
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 10:03:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C1B683E4B;
 Fri, 17 Jul 2026 08:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784275384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qL7mACgWPiDFxXs87dhYbgXRfhfIY5Va7SxaOgK2Dvo=;
 b=wkcL6FjYEEQwT0cP81SFtyU1BTm11zi3ucV9pe2wVmAPLaDP81Vxch5rcMRzlektPRsMT1
 1zMhwLHRVzzWMet7i5hxGgJzVJrEau3Lits6faVa5emQoe4i14fxpt42ZNmcEvhgCH7AKF
 FM0gfLw2fBHXwpj0w7i26lZDscCuz3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784275384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qL7mACgWPiDFxXs87dhYbgXRfhfIY5Va7SxaOgK2Dvo=;
 b=anfagZ3PU8/b7VZair7AACwk9kgHqcO7omjwuZm6lBG0PEzAnPZjehgtTIQGQm7OzwyVWl
 Pm+Xb2Z4SoKi1YDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784275379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qL7mACgWPiDFxXs87dhYbgXRfhfIY5Va7SxaOgK2Dvo=;
 b=HUsKv/Mw+ApRFrOyVrY+M9lS95KTwJ3afr10thF+cS2wGwmDzhdvCQf0Owz3cnNuYfVFJm
 m5A6vvM728hh8d2MGpb7H6h+MrZsfKmf7eBVvGLXNmfWWgbENJtyyHkxWoZce08b9bVRaf
 YTOD/rOiobm7+Lt2PEANrBMT5OTIbm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784275379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qL7mACgWPiDFxXs87dhYbgXRfhfIY5Va7SxaOgK2Dvo=;
 b=nub8nqDb5j78/f1enEciO12K2EzFPLaGvu3qOQp4pSVrY/gpcv5enlfVGJRAVLXWTGn89Y
 VhOOgKpcd7XMVvCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9000C779AA;
 Fri, 17 Jul 2026 08:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LAaCILPhWWqJJQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 17 Jul 2026 08:02:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 17 Jul 2026 10:02:58 +0200
MIME-Version: 1.0
Message-Id: <20260717-fix_tst_test_hugepages-v2-1-235342ee6fe6@suse.com>
X-B4-Tracking: v=1; b=H4sIALLhWWoC/4WNTQqDMBCFryKzboqJkNiueo8ionFMZlGVTAwtk
 rs39QLdPPge7+cAxkDIcK8OCJiIaV0KqEsF1g+LQ0FTYVC10rWRRsz07iPHPmIRvzvcBocs5rG
 xbYs3I7WFUt4CluQ5/OwKe+K4hs/5k+TP/TuZpJBi0M04K2unSZoH74xXu76gyzl/AU1F4HW7A
 AAA
X-Change-ID: 20260717-fix_tst_test_hugepages-fb3c88e9716c
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784275379; l=1744;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=cNlmT8lG+meAhNECvQWwkB/qssAFXZmzWGWjXNzhDPg=;
 b=berpShIp7f6qnLf3+/20Scdz24YlWGBGGovl2AAx25McTMg0MWYL1ZFpVXoUtGnjDlN1xbjH8
 Ejq7VMQwkBrCwFiegPQgk7my35cYbQM0dron9HU2nVwheC2L4YyK6fh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo, linux.dev:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] hugepages: make compact_memory setup optional
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

Writing 1 to /proc/sys/vm/compact_memory only triggers proactive
memory compaction. It's a best-effort hint that makes a hugepage
reservation more likely to succeed by defragmenting memory
beforehand, but the reservation itself does not depend on it.

The kernel can (and often will) still satisfy the request without
any explicit compaction step. So treating a missing compact_memory
(i.e. CONFIG_COMPACTION=n) as a hard TCONF is too strict: it skips
tests that could otherwise run perfectly fine.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Suggested-by: Li Wang <li.wang@linux.dev>
---
The issue was raised by https://github.com/linux-test-project/ltp/pull/1335
that is trying to solve a problem with cachestat03.
---
Changes in v2:
- change the patch with Li suggestion and description
- Link to v1: https://lore.kernel.org/20260717-fix_tst_test_hugepages-v1-1-a63bf2ccdd17@suse.com
---
 lib/tst_hugepage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index 40ecfa162a236a8674628f8ffe7a8fd2ccd52712..d5e1650d2ae65eaede662af9a2435fea2d3ef61f 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -47,7 +47,7 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
 	}
 
 	SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "3");
-	SAFE_FILE_PRINTF(PATH_VM_COMPACT_MEMORY, "1");
+	FILE_PRINTF(PATH_VM_COMPACT_MEMORY, "1");
 	if (hp->policy == TST_NEEDS) {
 		tst_hugepages += SAFE_READ_MEMINFO("HugePages_Total:");
 		goto set_hugepages;

---
base-commit: b8eb2e087e13eb85c9a77baa3fb3533eedd55098
change-id: 20260717-fix_tst_test_hugepages-fb3c88e9716c

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
