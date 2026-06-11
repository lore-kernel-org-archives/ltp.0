Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32782CD98CE
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 14:03:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C3F73C741F
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 16:03:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E03C03C52FE
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:03:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4E1EA1A00813
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:03:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4D146AF76;
 Thu, 11 Jun 2026 14:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781186604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8tb/ClwU4Uf01Vr3fRHtHJnt+vqG+RyqWEOvMUuCBAo=;
 b=h55TOVlhPxY2zEpQA9fwUSnqbT0u8FKqK0ge/Kmazbo7lNqtxu+03JxMI+a2UljY/4VaPE
 1e9pK5b7XfYJU508FeUk5MH0jK344mpI7zsWdzoXL/oLBolR9cegDkcKdw2lnB8G8fT0NZ
 zZcCRjkvK0Ue5W+Ju1IWf5wZywd0IXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781186604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8tb/ClwU4Uf01Vr3fRHtHJnt+vqG+RyqWEOvMUuCBAo=;
 b=scpIQ1rZj0RzftqTMmMyJjzPHnSJ/4LQXIAI1XMVoztUgcN6Hj0EAjJYbF/FdOaGU/esWh
 /hwMg6Wfd2q4a6Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781186599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8tb/ClwU4Uf01Vr3fRHtHJnt+vqG+RyqWEOvMUuCBAo=;
 b=kjkpx+Ov4PaHL9xjpqG+1vK02cHg2+SCrWDIeb9afMjN3qco/TzLCZKmhGcp7mFtdYyS8w
 MQGDFM1QlxwGWUq2TjJPpzV4uxwI8WwMyNz1rdWhwEIYbW+ljbsYFtJ5e4sZe7nV+mwvzQ
 BFJQMXf+kbp8chZDRI1kjprTK5gqI34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781186599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8tb/ClwU4Uf01Vr3fRHtHJnt+vqG+RyqWEOvMUuCBAo=;
 b=FZF0GcIIgDziDPgh14JrmRPzi6GBghADWNg6Mxfl5HlGoZmUL6zk9bOnEwKWqa+JQE/Yld
 xszAFhp4bb73hSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8341779A7;
 Thu, 11 Jun 2026 14:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VTh2JyfAKmqXNwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jun 2026 14:03:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jun 2026 16:03:15 +0200
MIME-Version: 1.0
Message-Id: <20260611-fix_clone11_min_kver-v1-1-264fba2b01b4@suse.com>
X-B4-Tracking: v=1; b=H4sIACLAKmoC/x2MQQqAIBAAvxJ7TmgtDPtKhMS21lJZKEQQ/T3pO
 DAzDySOwgm64oHIlyQ5QgYsC6BlDDMrmTKDrrSpDKLycjvajsCIbpfg1oujqm1DvrGWNLWQ0zN
 y9v5tP7zvB33RXU1mAAAA
X-Change-ID: 20260611-fix_clone11_min_kver-394cf499c2c7
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781186599; l=1778;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=LG1tkxfmvz9fSh8w91jhXU6sg45bkxoh/nZJ7WipWr4=;
 b=fDg3GHJRzdDvwmwEGW+v2msP3o9Cm5mISL28NYYx8oYKytw41BMnvrq07NLpMXPpGX3Yq/dnt
 G2YWVDQeLMrDN7LAyEBGprzbQj6TxmRskWW4Hb9hlJs8fy4H7oVeRg+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] clone11: skip CLONE_NEWCGROUP on kernels < 4.6
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

CLONE_NEWCGROUP was added in kernel v4.6. On older kernels such as
v4.4, the flag is unknown and clone() returns EINVAL instead of the
expected EPERM, causing a spurious test failure.

Add a per-test-case minimum kernel version check so that the
CLONE_NEWCGROUP case reports TCONF on kernels older than 4.6.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/clone/clone11.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clone/clone11.c b/testcases/kernel/syscalls/clone/clone11.c
index 028da778158de6867a71ac3974f9c2263481d3a3..607e42585fad41784be9104be01f504218559342 100644
--- a/testcases/kernel/syscalls/clone/clone11.c
+++ b/testcases/kernel/syscalls/clone/clone11.c
@@ -21,9 +21,10 @@ static int *child_pid;
 static struct tcase {
 	uint64_t flags;
 	const char *sflags;
+	int min_kver[3];
 } tcases[] = {
 	{ DESC(CLONE_NEWPID) },
-	{ DESC(CLONE_NEWCGROUP) },
+	{ DESC(CLONE_NEWCGROUP), .min_kver = {4, 6, 0} },
 	{ DESC(CLONE_NEWIPC) },
 	{ DESC(CLONE_NEWNET) },
 	{ DESC(CLONE_NEWNS) },
@@ -40,6 +41,13 @@ static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
+	if (tc->min_kver[0] &&
+	    tst_kvercmp(tc->min_kver[0], tc->min_kver[1], tc->min_kver[2]) < 0) {
+		tst_res(TCONF, "clone(%s) needs kernel %d.%d+",
+			tc->sflags, tc->min_kver[0], tc->min_kver[1]);
+		return;
+	}
+
 	TST_EXP_FAIL(ltp_clone(tc->flags, child_fn, NULL, CHILD_STACK_SIZE, child_stack),
 		EPERM, "clone(%s) should fail with EPERM",
 		tc->sflags);

---
base-commit: a375e8deed471723f5a0114c56eb48fe6f6f45d3
change-id: 20260611-fix_clone11_min_kver-394cf499c2c7

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
