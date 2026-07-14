Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3849C44501
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:39:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35C7A3E56AF
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:39:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E17A33C5E52
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:39:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D9001600701
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:39:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C37EF3E47;
 Tue, 14 Jul 2026 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784018339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/m1rCtfTHiFlW7lbhtOE3vlH+WuqYwOW2mpJkMnlkto=;
 b=NzPmnLtuDz/heB0h0Qhmv1jD0LGOX0mGSTyJW+jv3JT8l7AmHQRGuVsU9B7bgZ4hlIc8Wb
 vdaNaD0gtuDqyu6AQDIlNNqpFZj6laM7Nx34wlEtbPAQwTdvX16EVr/wETsPRFNKhUC0Jf
 cCLkx6ayjP66CTNIJwEFpFavkHroJDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784018339;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/m1rCtfTHiFlW7lbhtOE3vlH+WuqYwOW2mpJkMnlkto=;
 b=cZVOdoNJDlQzt/KPrc54BDC9y0iMFRSJ2dP2ux4USHXJcJzd+cNipa+0ic5KBalgPd0zpT
 q0qmD59DY8wgquCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NzPmnLtu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cZVOdoNJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784018339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/m1rCtfTHiFlW7lbhtOE3vlH+WuqYwOW2mpJkMnlkto=;
 b=NzPmnLtuDz/heB0h0Qhmv1jD0LGOX0mGSTyJW+jv3JT8l7AmHQRGuVsU9B7bgZ4hlIc8Wb
 vdaNaD0gtuDqyu6AQDIlNNqpFZj6laM7Nx34wlEtbPAQwTdvX16EVr/wETsPRFNKhUC0Jf
 cCLkx6ayjP66CTNIJwEFpFavkHroJDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784018339;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/m1rCtfTHiFlW7lbhtOE3vlH+WuqYwOW2mpJkMnlkto=;
 b=cZVOdoNJDlQzt/KPrc54BDC9y0iMFRSJ2dP2ux4USHXJcJzd+cNipa+0ic5KBalgPd0zpT
 q0qmD59DY8wgquCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85577779AE;
 Tue, 14 Jul 2026 08:38:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0MXOHaP1VWo3OQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 14 Jul 2026 08:38:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Jul 2026 10:38:57 +0200
Message-Id: <20260714-cve-2026-46331-v5-0-bab4ac23c1f7@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKL1VWoC/33MSw6CMBSF4a2Qjq3p7RMcuQ/jgLS30oFgWm00h
 L1bGBGIDv+TfGckCWPARE7VSCLmkMLQl1CHitiu7W9IgytNOOOaGaapzUjnoFILAVQK6ZvGem4
 1kIIeEX14L4eXa+kupOcQP8t/hnn9eZWBMmqVclJ5xrmDc3olPNrhTuanzP9rXrRTKE0LINpab
 rRYa7PTomjhtQenG4NoN1quNIidlkUzVjfeMbCo+UpP0/QFSLV2NmUBAAA=
X-Change-ID: 20260706-cve-2026-46331-434f99cf2c61
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784018339; l=2363;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=KUjFuEYzKXdLefooo5/fQvr2W/RhMuefbEJx9TVW8wg=;
 b=q+ikIkfDUj71PI4Lc1jZsMqFx0BYAfyG1rsbCvqkrTvxMh5SVuPkPWENDMP0siZ2cECNVn7pm
 p3vRupXJ6MxDYeGM9ziDDQchJrOE1d6vrpsR8h6Q4O3NEni2RSeGp0u
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url, suse.de:dkim, suse.com:email,
 suse.com:mid, imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C37EF3E47
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/4] Reproducer for cve-2026-46331
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

tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.1.0-rc5-virtme/build/.config'
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_cveTzmFu2 as tmpdir (overlayfs filesystem)
tst_test.c:2047: TINFO: LTP version: 20260529-80-g0b891ea23
tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc5-virtme #9 SMP PREEMPT_DYNAMIC Mon Jul  6 14:50:05 CEST 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.1.0-rc5-virtme/build/.config'
tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s
cve-2026-46331.c:221: TFAIL: Page cache corrupted via act_pedit partial COW bypass

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=899ee91156e5

HINT: You _MAY_ be vulnerable to CVE(s):

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2026-46331

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- set fd to -1
- better macro documentation
- Link to v4: https://lore.kernel.org/20260713-cve-2026-46331-v4-0-0089fd01ce62@suse.com

Changes in v4:
- fix enum definition
- define NETDEV_MAY_REMOVE_QDISC
- Link to v3: https://lore.kernel.org/20260707-cve-2026-46331-v3-0-3f6f1d697eec@suse.com

Changes in v3:
- fix build failure in opensuse 42.2
- Link to v2: https://lore.kernel.org/20260706-cve-2026-46331-v2-0-d5e47a113a84@suse.com

Changes in v2:
- remove sleep()
- Link to v1: https://lore.kernel.org/20260706-cve-2026-46331-v1-0-c55d45f022d1@suse.com

---
Andrea Cervesato (4):
      lapi: Add pkt_cls.h fallback
      lapi: Add pkt_sched.h fallback
      lapi: Add tc_pedit.h fallback
      cve: Add act_pedit page-cache corruption test

 configure.ac                   |   6 +
 include/lapi/pkt_cls.h         |  19 +++
 include/lapi/pkt_sched.h       |  19 +++
 include/lapi/tc_pedit.h        |  52 ++++++++
 include/tst_netdevice.h        |   7 ++
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/cve-2026-46331.c | 274 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 379 insertions(+)
---
base-commit: 7ca5dc366a558f3666223e6abe579edd90bafd38
change-id: 20260706-cve-2026-46331-434f99cf2c61

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
