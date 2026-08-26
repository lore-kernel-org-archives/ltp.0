Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAA8C61DBD
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 12:41:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FF993CD046
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 14:41:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB3E73C6F71
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 14:41:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 70DFC1000A29
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 14:41:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 141271F850;
 Wed, 26 Aug 2026 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787748062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qi4RVM85oxkc4RWpxzoys4Ef3Iqlt230Rx8JsA74DlE=;
 b=iSC//hW3bYn48bnwOgPnklYEmZlYWZ94gsHfeIGbbak0d4oVyuUm9XIwKoYssm6KgInn1T
 FBymKs5y8jGBIg2e15j0KV8PTzNtrSYaPbrwWNgiW/+PG+P7APZa08tQ45c7mykkS0Qfpl
 9Ec/u7pQrzI6Pgkvf5At9jMO42NKk/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787748062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qi4RVM85oxkc4RWpxzoys4Ef3Iqlt230Rx8JsA74DlE=;
 b=bqb7YIOsoy+iE83+gFlWQyBncgPIQgJiwf9LgoxakaZEOMUWFQGq855zMzJIcdtcztEvDl
 VEFf+RGApzjTBxBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787748058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qi4RVM85oxkc4RWpxzoys4Ef3Iqlt230Rx8JsA74DlE=;
 b=MZmuGwrV5KGr9PKL0qbBcXkjOcRsyOSP0b9RU+GRtm1SLypyn6JPsM74CvoOx3BB99OkBx
 SL2K/103BL8E5Ay1sMjaN8OXLsLmxwsJF9G05N1Lu/Kj5OJ2syUu2FsMZl2GFo/F6Dsq8+
 VcUgTDfNco53PJNAFAbep3X0r429d1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787748058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qi4RVM85oxkc4RWpxzoys4Ef3Iqlt230Rx8JsA74DlE=;
 b=hdKJ68Cg9PgFg02imUYBS6TmhulNk1Z9p1VeZ3Yx4Qj+GJKGZlX4Y3J6hz36dZ8kb8eXQC
 ITA8y5zs6pvYJFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0E7C13354;
 Wed, 26 Aug 2026 12:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /JpFOdnejmpuNwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 26 Aug 2026 12:40:57 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 26 Aug 2026 14:40:56 +0200
Message-Id: <20260826-cve-ghostlock-v4-0-52ec94d6635f@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANjejmoC/33MTQ6CMBhF0a2Qjq3pH6U4ch/GAbRfoVGpabHRE
 PZuYURIdPhecu6EIgQHEZ2KCQVILjo/5CEOBdJ9M3SAnckbMcIkUYRinQB3vY/j3esblgCiZVb
 W1kiUzTOAde+1d7nm3bs4+vBZ84ku769SophgWqncUrauCDvHV4Sj9g+0hBLbYr7HLONWklIpV
 XIqyA7zv5hnrA0obhvB6rba4Hmev746iDMjAQAA
X-Change-ID: 20260801-cve-ghostlock-6ee4b2f69fd6
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787748057; l=1729;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Rzi4+pf1ACDRiMpxpzG+BuMGipYfzGA/LokA4g20i6w=;
 b=Kf/nelmAvory0HdFF+9CfFW2Wf/tghsP+sbroi32N6HbQiMuDUVY31RrhU/5xEgoDsxPpODTv
 KNJGzWV0eWKA4CN0PuP3bsqFU72QovAzoZF/HnC7dp1EgEG0OTj2s7K
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] Reproducer for ghostlock
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
Changes in v4:
- handle runtime inside the test
- increase futext wait so we don't TBROK before runtime
- comment prctl() syscall
- move static vars out of the run function
- Link to v3: https://lore.kernel.org/20260803-cve-ghostlock-v3-0-cde83fa429b7@suse.com

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
 testcases/cve/Makefile    |   1 +
 testcases/cve/ghostlock.c | 258 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 288 insertions(+)
---
base-commit: 9118a480cc68700f27944aab817e0202e9e6136c
change-id: 20260801-cve-ghostlock-6ee4b2f69fd6

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
