Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E361C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 17:06:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E8DB3E4D28
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 19:06:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2710F3E4B2C
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 19:06:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4403C60027A
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 19:06:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CB78975F32;
 Tue, 30 Jun 2026 17:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782839177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dt9RwNAq/p1+UygatMBWqhY21yuHvIPvQFZrAj4Agsk=;
 b=gFw4acFwNoKMThVn51/QE8ngeA/3ahRcbCKVkUJ6AQoI5eYswHSwC6jPEj9g0D4reWVPSL
 1HHRH6M7sUm1VVgknYCYlDH3ftJ1TbKXRTEfkayEr5pXgIa+8H080cpNZqsglvpgNL7FSG
 IawEQczmnuLMrPxDS1eHeO3TjazIz1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782839177;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dt9RwNAq/p1+UygatMBWqhY21yuHvIPvQFZrAj4Agsk=;
 b=nr08s9ztvJWIlCXIt4NmzVcDho4R5YGEvHVG66JKK3fPc47Om2alVuoWa0cJKs6cBpuipW
 82yzDBUPU2v39PAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="UJN0/qmh";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wqwC4KEU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782839176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dt9RwNAq/p1+UygatMBWqhY21yuHvIPvQFZrAj4Agsk=;
 b=UJN0/qmhXKupPi97c+psdu2GYFMPlYI0kRXo33w+eL8bYYpklwRZFJu3kZ6RI2cqvGlY9m
 JhGeFVSmrwrDwOdZc4OvBrU4g8+8Ulp/oTXR6DKPpg/9g2h5pm6Q7n27pCTDmILm/SKoOo
 hnwCZeFP3tlXbGFgm7lYCdEQsKCJwK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782839176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dt9RwNAq/p1+UygatMBWqhY21yuHvIPvQFZrAj4Agsk=;
 b=wqwC4KEU6mxe1jhiP2neDyqb/3n/p/KtKXrvqAQLphONbiYvSiue8/Ld2J5yUn2ieqOX0l
 7B/z1woznoGOyxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DBCF779A8;
 Tue, 30 Jun 2026 17:06:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Kh1jO4f3Q2qxHQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jun 2026 17:06:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Jun 2026 19:06:11 +0200
Message-ID: <20260630170611.479639-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CB78975F32
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] irqbalance01: TCONF on missing interrupts
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

It looks like that at least on s390x VM there are no numeric interrupts
in /proc/interrupts:

                   CPU0       CPU1       CPU2       CPU3
        EXT:      12689      10088       8056       8624
        I/O:        117         27         74         31
        AIO:       1688        957       3464       1323
        CLK:       1645       1521       1355       1191   [EXT] Clock Comparator
        EXC:       1710       3175       1756       2935   [EXT] External Call
        EMS:       9248       5296       4892       4370   [EXT] Emergency Signal
        TMR:          0          0          0          0   [EXT] CPU Timer
        TAL:          0          0          0          0   [EXT] Timing Alert
        PFL:          0          0          0          0   [EXT] Pseudo Page Fault
        DSD:          0          0          0          0   [EXT] DASD Diag
        VRT:          0          0          0          0   [EXT] Virtio
        SCP:         86         96         53        128   [EXT] Service Call
        IUC:          0          0          0          0   [EXT] IUCV
        CMS:          0          0          0          0   [EXT] CPU-Measurement: Sampling
        CMC:          0          0          0          0   [EXT] CPU-Measurement: Counter
        FTP:          0          0          0          0   [EXT] HMC FTP Service
        CIO:          4          1          1          2   [I/O] Common I/O Layer Interrupt
        DAS:          0          0          0          0   [I/O] DASD
        C15:          0          0          0          0   [I/O] 3215
        C70:          0          0          0          0   [I/O] 3270
        TAP:          0          0          0          0   [I/O] Tape
        VMR:          0          0          0          0   [I/O] Unit Record Devices
        LCS:          0          0          0          0   [I/O] LCS
        CTC:          0          0          0          0   [I/O] CTC
        ADM:          0          0          0          0   [I/O] EADM Subchannel
        CSC:          0          0          0          0   [I/O] CHSC Subchannel
        VIR:        113         26         73         29   [I/O] Virtual I/O Devices
        QAI:          0          0          0          0   [AIO] QDIO Adapter Interrupt
        APB:          0          0          0          0   [AIO] AP Bus
        PCF:          0          0          0          0   [AIO] PCI Floating Interrupt
        PCD:          0          0          0          0   [AIO] PCI Directed Interrupt
        MSI:          0          0          0          0   [AIO] MSI Interrupt
        VAI:       1688        957       3464       1323   [AIO] Virtual I/O Devices AI
        GAL:          0          0          0          0   [AIO] GIB Alert
        NMI:          0          0          0          0   [NMI] Machine Check
        RST:          0          1          1          1   [CPU] CPU Restart

Therefore turn TBROK into TCONF. But deliberately keep CPUs check TBROK
(CPUs should be always available).

Also print /proc/interrupts on both errors (no CPUs and no IRQs).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/irq/irqbalance01.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/irq/irqbalance01.c b/testcases/kernel/irq/irqbalance01.c
index 664fced1ec..9d15cdc600 100644
--- a/testcases/kernel/irq/irqbalance01.c
+++ b/testcases/kernel/irq/irqbalance01.c
@@ -41,6 +41,8 @@
 #include "tst_safe_stdio.h"
 #include "tst_safe_file_at.h"
 
+#define PRINT_PROC_INTERRUPTS() safe_print_file(__FILE__, __LINE__, "/proc/interrupts")
+
 enum affinity {
 	ALLOW = '+',
 	DENY = '-',
@@ -304,11 +306,15 @@ static void setup(void)
 	collect_irq_info();
 	print_irq_info();
 
-	if (nr_cpus < 1)
+	if (nr_cpus < 1) {
+		PRINT_PROC_INTERRUPTS();
 		tst_brk(TBROK, "No CPUs found in /proc/interrupts?");
+	}
 
-	if (nr_irqs < 1)
-		tst_brk(TBROK, "No IRQs found in /proc/interrupts?");
+	if (nr_irqs < 1) {
+		PRINT_PROC_INTERRUPTS();
+		tst_brk(TCONF, "No IRQs found in /proc/interrupts?");
+	}
 }
 
 static void run(void)
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
