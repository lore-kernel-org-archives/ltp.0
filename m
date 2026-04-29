Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB95FF8875
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 10:57:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E95DE3E49C0
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 12:57:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E92E43C60F2
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:56:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 18F99600955
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:56:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2FC606A864;
 Wed, 29 Apr 2026 10:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777460209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Eso/OZhlPQaEzXj02oDTeegxv4Rjq5D0tgHPj9oiniQ=;
 b=V0FMtDJRKQPN8ihag/kOfLuCZ67i1xqdZnguWA2j9Ch7l7GWrDSns0NSgUZuYNTPIo1k3f
 z9+nPypRt5CN3gzZTSOtquNEmdzwJ42tEs1xBAwkB0Ikj8aoYkiOBqKSEFmR2nI/7DBExQ
 zFVtwgTR+VJUPFscvYpUcGCNBtlMcFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777460209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Eso/OZhlPQaEzXj02oDTeegxv4Rjq5D0tgHPj9oiniQ=;
 b=dxR2jiIrvdEuri6sjEWWoqSusZlNN8LvYGJ9MuR+655e+hgV9baJo8aYQZcPPL2ucNL/I2
 OegQaUXGNHMQVfCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777460209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Eso/OZhlPQaEzXj02oDTeegxv4Rjq5D0tgHPj9oiniQ=;
 b=V0FMtDJRKQPN8ihag/kOfLuCZ67i1xqdZnguWA2j9Ch7l7GWrDSns0NSgUZuYNTPIo1k3f
 z9+nPypRt5CN3gzZTSOtquNEmdzwJ42tEs1xBAwkB0Ikj8aoYkiOBqKSEFmR2nI/7DBExQ
 zFVtwgTR+VJUPFscvYpUcGCNBtlMcFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777460209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Eso/OZhlPQaEzXj02oDTeegxv4Rjq5D0tgHPj9oiniQ=;
 b=dxR2jiIrvdEuri6sjEWWoqSusZlNN8LvYGJ9MuR+655e+hgV9baJo8aYQZcPPL2ucNL/I2
 OegQaUXGNHMQVfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5B02593B0;
 Wed, 29 Apr 2026 10:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lEq1MvDj8WmADwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Apr 2026 10:56:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Apr 2026 12:56:44 +0200
Message-ID: <20260429105644.986278-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWELVE(0.00)[13]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] Move runtest/irq into runtest/kernel_misc
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
Cc: Tim Bird <tim.bird@sony.com>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

runtest/irq contains single test irqbalance01. Although it's not good to
remove existing runtest it's not worth to start SUT for only single
test in a runtest (at least in SUSE we boot SUT, run single runtest
and shutdown SUT).

Also test fails when run immediately after boot (journalctl):

    08:49:41 susetest systemd[1]: Started irqbalance daemon.
    08:49:41 susetest irqbalance[782]: thermal: failed to receive messages.
    08:49:41 susetest irqbalance[782]: Failed to initialize thermal events.
    09:18:12 susetest irqbalance[782]: Cannot change IRQ 47 affinity: Permission denied
    09:18:12 susetest irqbalance[782]: IRQ 47 affinity is now unmanaged

Therefore move irqbalance01 into runtest/kernel_misc. If we happen to
get more irq tests we can restore runtest/irq again and keep
irqbalance01 at the end.

Reported-by: Petr Cervinka <pcervinka@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/irq         | 1 -
 runtest/kernel_misc | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)
 delete mode 100644 runtest/irq

diff --git a/runtest/irq b/runtest/irq
deleted file mode 100644
index 56d0d23c87..0000000000
--- a/runtest/irq
+++ /dev/null
@@ -1 +0,0 @@
-irqbalance01 irqbalance01
diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 78f00d305f..e50a1a725f 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -16,3 +16,4 @@ zram02 zram02.sh
 zram03 zram03
 umip_basic_test umip_basic_test
 aslr01 aslr01
+irqbalance01 irqbalance01
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
