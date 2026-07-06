Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D06C43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 12:57:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DB423C2324
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 14:57:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 653493E4B36
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 14:56:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DEF43200046
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 14:56:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8FD175753;
 Mon,  6 Jul 2026 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783342570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ivh6Ku67xTb7SDGdaNOwQtwtJ6V9G7SFq0YWvkbuQGQ=;
 b=VKgHaeCD3gy0XNOzwviqxdJUq279gy19TOKa95zLN9pKlf2cQVnxRqDd7VEwV7XIWzGmEw
 LsTMEUPV4xxVc6LiAF/FAvjg/4ATbukMUyo+UEWCsyRgaBxNkIytxxfFVmh7aUYPZUTjn/
 vQReDCTxrQ+kQV9umDCUXgOYWok1tFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783342570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ivh6Ku67xTb7SDGdaNOwQtwtJ6V9G7SFq0YWvkbuQGQ=;
 b=IkHncmd28DeStKzFUF4BUIJOVZk0u22SfGMn4OVE5WodbaGPw6MjOTNxNGxxQPgf+6OadZ
 HK+1Py/iCjjZRQCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VKgHaeCD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IkHncmd2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783342570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ivh6Ku67xTb7SDGdaNOwQtwtJ6V9G7SFq0YWvkbuQGQ=;
 b=VKgHaeCD3gy0XNOzwviqxdJUq279gy19TOKa95zLN9pKlf2cQVnxRqDd7VEwV7XIWzGmEw
 LsTMEUPV4xxVc6LiAF/FAvjg/4ATbukMUyo+UEWCsyRgaBxNkIytxxfFVmh7aUYPZUTjn/
 vQReDCTxrQ+kQV9umDCUXgOYWok1tFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783342570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ivh6Ku67xTb7SDGdaNOwQtwtJ6V9G7SFq0YWvkbuQGQ=;
 b=IkHncmd28DeStKzFUF4BUIJOVZk0u22SfGMn4OVE5WodbaGPw6MjOTNxNGxxQPgf+6OadZ
 HK+1Py/iCjjZRQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A02E6779AA;
 Mon,  6 Jul 2026 12:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cSaDJeqlS2rfLAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 06 Jul 2026 12:56:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 06 Jul 2026 14:56:09 +0200
Message-Id: <20260706-cve-2026-46331-v1-0-c55d45f022d1@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOmlS2oC/x3MTQqAIBBA4avErBvwD8OuEi3CxpqNhYIE4t2zl
 t/ivQqZElOGeaiQqHDmK3bIcQB/bvEg5L0blFBWTMKiL4Qf0FitJRptgnM+KG8l9OhOFPj5h8v
 a2gvJifxZYAAAAA==
X-Change-ID: 20260706-cve-2026-46331-434f99cf2c61
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783342570; l=660;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=KjAyMNzjxXANLQblT2ggtrq4QBfolwM5SlOMMiDdOJU=;
 b=xUWi1E0Ik8ZuDQ7P83T6KFxDhZenZUod4153cmGWimcQhfJqBdGYrUBBHdHHNdeMvBCmXdvjt
 R/nrzRSqyO4BAw/4hqw2X1Xjhvg9prP6Ur3JMNGBG3SdrayEJRdNZaW
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.com:email, suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B8FD175753
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Reproducer for cve-2026-46331
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      lapi: Add pkt_sched.h and pkt_cls.h fallbacks
      cve: Add act_pedit page-cache corruption test

 include/lapi/pkt_cls.h         |  19 +++
 include/lapi/pkt_sched.h       |  19 +++
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/cve-2026-46331.c | 273 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 313 insertions(+)
---
base-commit: 0b891ea23ed7315afa12df92fe12f1218a420bde
change-id: 20260706-cve-2026-46331-434f99cf2c61

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
