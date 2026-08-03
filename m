Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EFDC55179
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 12:27:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 161673E71A3
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 14:27:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA9713E4A6D
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 14:27:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F340D1400325
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 14:27:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30CA37F0C3;
 Mon,  3 Aug 2026 12:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785760019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cuz7CYXI5OWNY95UHA3PlUHETGRyO/0YqjeAecYDm0s=;
 b=JJhskVlx1NckOsYWc5LyBh2xDSWr+vI/GvcPru2kIJRHrR15/OGXitvRUCG862QgtpaOMW
 nm/if/PU1PQlZnzkzrv3NBc8cwiqI7cdNDTDOYDBbmbHVwpMWj2XDm5D5nNmOxJD23Ei1M
 2Slob/h8A3JuhBlX5C5BhpKuXDnZRuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785760019;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cuz7CYXI5OWNY95UHA3PlUHETGRyO/0YqjeAecYDm0s=;
 b=LhjfFkXcnFnlA35SSl9Q6jRBn+6h3s2IsgDsbbN3iCn7V0MsP08yjdIfHfeoNeV8ZSOHrw
 9gwYFBk0EI2k68Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nmp0QIdF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yQ2pvsAX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785760015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cuz7CYXI5OWNY95UHA3PlUHETGRyO/0YqjeAecYDm0s=;
 b=nmp0QIdF1H1QU+4cqAG2Ntl64sUAjxknD3g2oyouGFL6laZE4uhvgvdg1+PG+fLK9eMoPi
 YfblecMwCT/3Wt7ON3Wd5GIMefUzbfUMeTEZkwZZz70Rrr66N5yVnTMF2Gs9nHWLqzl02n
 uegV88Bqc3Khm2HrBQEUUK56AYHNto0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785760015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cuz7CYXI5OWNY95UHA3PlUHETGRyO/0YqjeAecYDm0s=;
 b=yQ2pvsAXjgE4LCDrOSGblG/zn5JP3fGUGbuGalcJrCv+5eh6uPcjG6I/al4Ldcv+80kp2P
 RVc2jmSsZdyTkNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14A5F779C1;
 Mon,  3 Aug 2026 12:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id F8mJAw+JcGoiSgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 03 Aug 2026 12:26:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 03 Aug 2026 14:26:48 +0200
Message-Id: <20260803-cve-ghostlock-v3-0-cde83fa429b7@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAiJcGoC/3XMQQ6CMBCF4auQWVvTFiiFlfcwLqRMoVGp6WCjI
 dzdwoqYuHwv+b8ZCINDgiabIWB05PyYRn7IwAzXsUfmurRBcqm45oKZiKwfPE13b25MIRattKq
 2nYLUPANa99688yXtwdHkw2fjo1jff1IUjDNR6WRpW1dcnuhFeDT+ASsU5T7Of2OZ4lbxUmtd5
 qLgu3hZli/iTp+L5gAAAA==
X-Change-ID: 20260801-cve-ghostlock-6ee4b2f69fd6
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785760015; l=1475;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=NEUSYiJ1qVjpJ69gEQh4XX6Iy+UXpRb6S09s7FOp/rA=;
 b=haqQYiSsY9EmWMZ+JzJrouzwYt9H2J8DVomIAtFQuJzFKAObdl6gWoI7ANQbdw+2KrjvWXsma
 7tK9ZKjkG9bAw1KAnW4OLMtnakmeZPCIb3Z9/EVeIYBeBZK0lVrhpHc
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,nebusec.ai:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nebusec.ai:url, suse.com:mid, suse.com:email,
 suse.de:dkim, imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Queue-Id: 30CA37F0C3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Reproducer for ghostlock
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

Test for CVE-2026-43499 (GhostLock), a stack use-after-free in the
rtmutex PI code, fixed in kernel v7.1:
3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_waiter()")

Reproducer based on the Nebula Security writeup and open-sourced PoC
(https://nebusec.ai/research/ionstack-part-2/, https://github.com/NebuSec/CyberMeowfia).
Beware, this test will crash the system on a vulnerable kernel.

Assisted by Kimi K3 for the analysis and written mostly with Gemini Pro
3.1 Max.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- improve sync mechanism
- fix lapi imports
- Link to v2: https://lore.kernel.org/20260803-cve-ghostlock-v2-0-b60588853140@suse.com

Changes in v2:
- fix build
- fix 32bit run
- Link to v1: https://lore.kernel.org/20260801-cve-ghostlock-v1-0-178f698f9702@suse.com

---
Andrea Cervesato (2):
      lapi/prctl: add more fallback definitions
      cve: add CVE-2026-43499 reproducer

 configure.ac              |   2 +
 include/lapi/prctl.h      |  25 +++++
 runtest/cve               |   1 +
 testcases/cve/.gitignore  |   1 +
 testcases/cve/Makefile    |   2 +-
 testcases/cve/ghostlock.c | 247 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 277 insertions(+), 1 deletion(-)
---
base-commit: 6891f922f21a56238d3225c9a83e08f4f7c1765b
change-id: 20260801-cve-ghostlock-6ee4b2f69fd6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
