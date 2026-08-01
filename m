Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD4EC55172
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 10:34:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B179A3EA6A9
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 12:34:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6FC43EA677
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 12:34:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B725310005DF
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 12:34:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0908B43C2;
 Sat,  1 Aug 2026 10:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785580457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+ufOhF2xGni0exqnoxKBKTHCncxBIF9DGS2F7SYzzV4=;
 b=cA8HhYJ72i0Y058KK2sFTiJ+BLOuRS+dF+d5RGhHQGJfvR7y/bdYzx8WIECtjSqqq9dwvw
 cOkwOHTqZhLEp10/jin0vmwYeHU15T6WtUBuJAoDU6v+jVpMMPQFmhos6x0d/+eRIalDfW
 +heUrrldqa2atyaTv4W768g5bT1B4s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785580457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+ufOhF2xGni0exqnoxKBKTHCncxBIF9DGS2F7SYzzV4=;
 b=PBvBqnzmhQArnoOsAeaGyubU7s0DJ2f25fiyyWBfmdF/2z5gaAo0BnVF1p6RQvyugd2bBv
 RehxpA5C8870hQCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785580453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+ufOhF2xGni0exqnoxKBKTHCncxBIF9DGS2F7SYzzV4=;
 b=bGjTir3TRzLyHV1V+DNAEpbeQvT58qBKF+3GdfDaBYVOWsLqGe0eTDTVzNr7AgHagLzb0w
 4UNaWikNmrIgETWdk36sodmgaUKQINKrTmM43IxbcSQhSNlrCZDNrzPz6vic/J4ImbTzj6
 GqCWpjZMbkREFq3+Qpo+nrInwZFmdfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785580453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+ufOhF2xGni0exqnoxKBKTHCncxBIF9DGS2F7SYzzV4=;
 b=akpb2y4AkadUJCp4FcEJsvx0dT1mJRWIEhqbYsgUkFM51Ro2gemUsSgZ27YA00vUgoC4Kk
 v5Ofw4n7WAcq4wCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDF39779BF;
 Sat,  1 Aug 2026 10:34:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9bwcNKTLbWrxXwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Sat, 01 Aug 2026 10:34:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Sat, 01 Aug 2026 12:34:11 +0200
Message-Id: <20260801-cve-ghostlock-v1-0-178f698f9702@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKPLbWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwND3eSyVN30jPzikpz85Gxds9RUkySjNDPLtBQzJaCegqLUtMwKsHn
 RsbW1AIQdeyBfAAAA
X-Change-ID: 20260801-cve-ghostlock-6ee4b2f69fd6
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785580452; l=1180;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=kQGFFvGUpaWhMeLjbAwQJI0LKCfcszCkKoSHPgbIaTs=;
 b=kjVoi2pzS2LO3qXZdjKP0/ISmgUiEMJkfKy7A6N5sMu58ArM8BGsIjL5QTNotTkZ6HxVZrarS
 NKq5Ro+cFFUDgQXn0EijuoHgh/KPS/z9cae1iG4MjLTRZpRIi+qb6Z3
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.988]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Reproducer for ghostlock
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
Andrea Cervesato (2):
      lapi/prctl: add more fallback definitions
      cve: add CVE-2026-43499 reproducer

 configure.ac              |   2 +
 include/lapi/prctl.h      |  25 +++++
 runtest/cve               |   1 +
 testcases/cve/.gitignore  |   1 +
 testcases/cve/Makefile    |   2 +-
 testcases/cve/ghostlock.c | 252 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 282 insertions(+), 1 deletion(-)
---
base-commit: 6891f922f21a56238d3225c9a83e08f4f7c1765b
change-id: 20260801-cve-ghostlock-6ee4b2f69fd6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
