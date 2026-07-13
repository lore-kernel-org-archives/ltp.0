Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F19C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 12:37:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE08D3E9A11
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 14:37:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21CEB3E2A3D
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 14:37:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C65E014004FD
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 14:37:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7456778BD;
 Mon, 13 Jul 2026 12:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783946228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZcAKx25+RKf4zTEk6k0pjtUGgdl8005jGOd29SfHge0=;
 b=bbkuztQzCMXcP6TgwUtwywzBsLhgv1BQJCtL/y4U8bjVQIYfX43rBjCPVUJvnRlik9agQY
 6BYRsjyHuX1zrEwz2MAN8I5vzTLh/1nLb9hD92N42TlVVzBBAtNjgbzgpgAvaMfITaxMhJ
 2M1W/YpzCj374yJs7grnLXVWIVHudMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783946228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZcAKx25+RKf4zTEk6k0pjtUGgdl8005jGOd29SfHge0=;
 b=S9GKqx8/8hfel3zxzNF4WnQ1L7NeFhp4Fj+dkYRhKRCWrjd7p82NGr7/fshvM2AWKXgYmh
 IkRODSbFKjwr5nAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ZkKc/5hm";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OkdC1u7w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783946227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZcAKx25+RKf4zTEk6k0pjtUGgdl8005jGOd29SfHge0=;
 b=ZkKc/5hmwtagFIvHBZdgygBqsOtMzQfoMxr/5yMRo7d2je2ppmxH/1Ew60yFwCF6hnWJ4c
 ToDmbyMEaOvQCLf59kaRu0dYTptKX6cU7xW6KXAZk9CrgEYkVBam1xTR1GBkZusMRUcEpB
 tNUu0XgzHg2btoVBEKCvqnakcox+mnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783946227;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZcAKx25+RKf4zTEk6k0pjtUGgdl8005jGOd29SfHge0=;
 b=OkdC1u7wrUeuPrz8GfvWZXsKH/2gszj8GL6VD5o5xhY3V9lhjrXB/eCkhxOO4WGGB7nOoo
 YQl8kiHjNxBwBiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC4A3779AF;
 Mon, 13 Jul 2026 12:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aQVALPPbVGp+OQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 13 Jul 2026 12:37:07 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 13 Jul 2026 14:37:06 +0200
Message-Id: <20260713-cve-2026-46331-v4-0-0089fd01ce62@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPLbVGoC/33MSwrCMBSF4a2UOzaSm6d15D7EQUlubAZaSTQop
 Xs37agoOvwPfGeETClShn0zQqIScxyuNdSmAdd31zOx6GuD4MJwyw1zhdgcTBkpkSmpQtu6IJx
 BqOiWKMTncng81e5jvg/ptfwXnNefVwUZZ05rr3TgQng85EemrRsuMD8V8V+Lqr0mZTtE2e3Uh
 5Zrbb+0rFoGE9Cb1hK5lZ6m6Q1TGO1CJwEAAA==
X-Change-ID: 20260706-cve-2026-46331-434f99cf2c61
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783946227; l=2208;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=qfLkBEAAGkjUHngUrlLq1n3d2gjCZEXv2jnAOkkdOO0=;
 b=nuO/e0aYn6lFh5TdLUacttQwhSv6Hu8jTtdDqFenHM6LKpL9lZ+HxJol5gYJml/FrYmZaKR1L
 p2PgVx7PiGnDzPDd35wTVtyBV7DY0+sHyZ0r2+/Kymq2QOhzyfxzuUN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,configure.ac:url,suse.com:email,suse.com:mid,suse.de:dkim,mitre.org:url];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E7456778BD
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/4] Reproducer for cve-2026-46331
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
 include/tst_netdevice.h        |   3 +
 runtest/cve                    |   1 +
 testcases/cve/.gitignore       |   1 +
 testcases/cve/cve-2026-46331.c | 271 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 372 insertions(+)
---
base-commit: ed2758122173ffd8d1e8dff6c5efc1231073ee4a
change-id: 20260706-cve-2026-46331-434f99cf2c61

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
