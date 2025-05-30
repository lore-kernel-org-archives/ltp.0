Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED19C5B543
	for <ltp@archiver.kernel.org>; Fri, 30 May 2025 12:24:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 288903C927C
	for <ltp@archiver.kernel.org>; Fri, 30 May 2025 14:24:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB28E3C91BE
 for <ltp@lists.linux.it>; Fri, 30 May 2025 14:23:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BB5FD60072A
 for <ltp@lists.linux.it>; Fri, 30 May 2025 14:23:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D14F21A34;
 Fri, 30 May 2025 12:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748607836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BWrcHS8f06fFTay1PitMBKBF54Nmt7owEWbPA72Qb8o=;
 b=G7mCZvaB8xpuOfU3fSKycWWrWWvb/8q3UYTQuK7WlurUVhQX3OfuhMJ2aQihs1iWnACLtw
 H0+mUqEU4ViufbUFamnzzCChKg8XjhMirAW4GWjE8CYDWDtvRz6Xy4Ad47aQllEubALkgV
 2DSrqvqFVONomrJhZ/v0yjY9YpC8H7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748607836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BWrcHS8f06fFTay1PitMBKBF54Nmt7owEWbPA72Qb8o=;
 b=/rEYR79rAS6v+rB6KKHgQXYij0kM5ALZ315m9SM072Jety8aRVYkLxDEcnjXAwQ37OIF0W
 ZZAgHHAYaOyfp6Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G7mCZvaB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/rEYR79r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748607836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BWrcHS8f06fFTay1PitMBKBF54Nmt7owEWbPA72Qb8o=;
 b=G7mCZvaB8xpuOfU3fSKycWWrWWvb/8q3UYTQuK7WlurUVhQX3OfuhMJ2aQihs1iWnACLtw
 H0+mUqEU4ViufbUFamnzzCChKg8XjhMirAW4GWjE8CYDWDtvRz6Xy4Ad47aQllEubALkgV
 2DSrqvqFVONomrJhZ/v0yjY9YpC8H7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748607836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BWrcHS8f06fFTay1PitMBKBF54Nmt7owEWbPA72Qb8o=;
 b=/rEYR79rAS6v+rB6KKHgQXYij0kM5ALZ315m9SM072Jety8aRVYkLxDEcnjXAwQ37OIF0W
 ZZAgHHAYaOyfp6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51736132D8;
 Fri, 30 May 2025 12:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b6AkElyjOWjgJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 30 May 2025 12:23:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 30 May 2025 14:23:02 +0200
MIME-Version: 1.0
Message-Id: <20250530-fix_irqbalance-v2-1-f5db338b21af@suse.com>
X-B4-Tracking: v=1; b=H4sIACWjOWgC/3WMyw7CIBBFf6WZtRigpQ9X/odpDNCpnURBQYmm4
 d/F7l2em3vOChEDYYRDtULARJG8KyB3FdhFuwsymgqD5FJxVXM20/tM4WH0VTuLzPaDlE3XGrQ
 dFOkesDy24GksvFB8+vDZ+kn81r+pJJhgreJD3TezkpM5xlfEvfU3GHPOX5QpCj6rAAAA
X-Change-ID: 20250530-fix_irqbalance-c8922476bec7
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748607836; l=1864;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=bAmh1vbBP7dXGhV88WnT5RsGeykJd+8t63zscxQqDYA=;
 b=tETWt+tSGxlCmEqSPcQUw+6rLKSrRMfwfkQ1bSxOxVReFxy9d4Fit80rpctqDONBpeyWxtIeq
 E+avYCm3g+fAVcQuYBiPQrnpCR1ZvHWpzbak8ZfH0QXf+UdE+VRA8d6
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 6D14F21A34
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] irq: informative message for irqbalance01 result
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
Changes in v2:
- show an explanation message when TFAIL
- Link to v1: https://lore.kernel.org/r/20250530-fix_irqbalance-v1-1-6509384f52db@suse.com
---
 testcases/kernel/irq/irqbalance01.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/irq/irqbalance01.c b/testcases/kernel/irq/irqbalance01.c
index f7c6b027859816052f08b07a4a700787b1460e0e..664fced1ec7ed901ca79d3c5e11afb11fc62a733 100644
--- a/testcases/kernel/irq/irqbalance01.c
+++ b/testcases/kernel/irq/irqbalance01.c
@@ -285,9 +285,18 @@ static void evidence_of_change(void)
 		}
 	}
 
-	tst_res(changed ? TPASS : TFAIL,
-		"Heuristic: Detected %zu irq-cpu pairs have been dissallowed",
-		changed);
+	if (changed) {
+		tst_res(TPASS, "IRQs assignments have changed %zu times",
+			changed);
+	} else {
+
+		tst_res(TFAIL, "IRQ balancing has not been detected");
+
+		tst_printf("Please, check that:\n"
+			   "- balancing service is not running\n"
+			   "- balancing service is running but rules didn't change\n"
+			   "- balancing rules have been changed, but CPUs didn't perform any interrupt");
+	}
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
