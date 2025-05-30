Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BC0C5B552
	for <ltp@archiver.kernel.org>; Fri, 30 May 2025 10:22:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAA753C9287
	for <ltp@archiver.kernel.org>; Fri, 30 May 2025 12:22:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E31663C8239
 for <ltp@lists.linux.it>; Fri, 30 May 2025 12:22:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3CB1C1000530
 for <ltp@lists.linux.it>; Fri, 30 May 2025 12:22:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8477B21168;
 Fri, 30 May 2025 10:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748600552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=13iudQBs76wiGjI5xCfq1zHmzqOefT1scs2gY5+miHA=;
 b=Amv5j18yORC4Y3YcHGNoergVIu9bgHvP4X3UV1Gf8qMsDGXUu94iC+b89j6PN3+/UvlLfA
 DtwnfTI23JdIkcPotvIddnJQHsgxZjehLgyHO7tFfH+PC2MTfctc+ra8+ZIiPRF+IRa/U1
 VkEZMGihtl5tFObzQl6cpH1ERDmrXLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748600552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=13iudQBs76wiGjI5xCfq1zHmzqOefT1scs2gY5+miHA=;
 b=ZZjvqsaNOZWJPNB1tRrQgaZR6VO0zHAIr/WdLJStfPyh33IPUi6KkY5TRZ3qUTi5rVrYRN
 V7wdiTth/7Rz4PAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Amv5j18y;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZZjvqsaN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748600552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=13iudQBs76wiGjI5xCfq1zHmzqOefT1scs2gY5+miHA=;
 b=Amv5j18yORC4Y3YcHGNoergVIu9bgHvP4X3UV1Gf8qMsDGXUu94iC+b89j6PN3+/UvlLfA
 DtwnfTI23JdIkcPotvIddnJQHsgxZjehLgyHO7tFfH+PC2MTfctc+ra8+ZIiPRF+IRa/U1
 VkEZMGihtl5tFObzQl6cpH1ERDmrXLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748600552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=13iudQBs76wiGjI5xCfq1zHmzqOefT1scs2gY5+miHA=;
 b=ZZjvqsaNOZWJPNB1tRrQgaZR6VO0zHAIr/WdLJStfPyh33IPUi6KkY5TRZ3qUTi5rVrYRN
 V7wdiTth/7Rz4PAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 667E9132D8;
 Fri, 30 May 2025 10:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n77mFuiGOWjFAQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 30 May 2025 10:22:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 30 May 2025 12:22:02 +0200
MIME-Version: 1.0
Message-Id: <20250530-fix_irqbalance-v1-1-6509384f52db@suse.com>
X-B4-Tracking: v=1; b=H4sIAMmGOWgC/x2MQQqAIBAAvyJ7TjDLrL4SEWZbLYSVQgTi35OOA
 zMTIaAnDNCzCB4fCnS6DGXBwO7GbchpyQxSSCVUJfhK70T+ns1hnEVu207KWjczWg05ujxm4x8
 OY0ofWEvGP2AAAAA=
X-Change-ID: 20250530-fix_irqbalance-c8922476bec7
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748600552; l=1676;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=wP+FiBdflcCS2twiq9FzEWxgOeO4T7QJhRxI/z+efhs=;
 b=y/R1t4bPJ8U+0tdVQ25kLfHQX7A6QCkbnRImKC4uxuZmuq2N+Ppn7Te7PtOHrmZxcFgEUwmeT
 vxalsX3OhRgBokSUxYR83IHdcIr41HJIbdxPVip2PKvAjPGvskkK/Tt
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8477B21168
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:mid,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] irq: informative TINFO for irqbalance01 result
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

Change heuristic message when irqbalance01 test is sending the result.
The test can't detect if an IRQ balance service is up and running, so
after a test failure users should verify that:

- a balancing service is up and running on the system
- a balancing service is running, but it didn't perform any IRQ
  assignment on any CPU
- a balancing service is running, but CPUs didn't performed any
  interrupt after IRQs assignments

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/irq/irqbalance01.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/irq/irqbalance01.c b/testcases/kernel/irq/irqbalance01.c
index f7c6b027859816052f08b07a4a700787b1460e0e..4120b2eae6e2f862e0d86b4f86e3db5b2760db84 100644
--- a/testcases/kernel/irq/irqbalance01.c
+++ b/testcases/kernel/irq/irqbalance01.c
@@ -285,9 +285,17 @@ static void evidence_of_change(void)
 		}
 	}
 
-	tst_res(changed ? TPASS : TFAIL,
-		"Heuristic: Detected %zu irq-cpu pairs have been dissallowed",
-		changed);
+	if (changed) {
+		tst_res(TPASS, "IRQs assignments have changed %zu times",
+			changed);
+		return;
+	}
+
+	tst_res(TFAIL,
+		"IRQ balancing has not been detected. It might be that:\n"
+		"- balancing service is not running\n"
+		"- balancing service is running but rules didn't change\n"
+		"- balancing rules have been changed, but CPUs didn't perform any interrupt");
 }
 
 static void setup(void)

---
base-commit: a16ec9409a99d41cd4268ed3f8bbe49108d51a4d
change-id: 20250530-fix_irqbalance-c8922476bec7

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
