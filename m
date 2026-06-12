Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEB2CD98D8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 20:51:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91CB33E6B2F
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 22:51:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E277F3CC895
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 22:51:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3A0182003BD
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 22:51:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7FE6176342;
 Fri, 12 Jun 2026 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781272455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BqXvKEn80KAYjYtT8X8i3iTT+W6fWs9K9vE6I28bh5c=;
 b=GHnmN3IUDlve08kD1C9mLXPukuM7eS0taqIWtBOyLJ5gOLNvVFZ5kujGWBKHLLdhxod/gs
 jUSMjvURc7NHliyLKCx969lPxHIp1s6OqQpfctctL3x3hDM9Mb0QnAqUTf//75Lyp2fJ25
 spad8IKqjiLb1R5n6baLCQOqOgupOfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781272455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BqXvKEn80KAYjYtT8X8i3iTT+W6fWs9K9vE6I28bh5c=;
 b=8pTzWk5IcmGqWTy0ifUolXGC3pFx3hgNYAZIODRBQv3snGxeF+xoT+Qfs1vGwVXHeXye1B
 aCseFMwLOwRwQEDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781272455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BqXvKEn80KAYjYtT8X8i3iTT+W6fWs9K9vE6I28bh5c=;
 b=GHnmN3IUDlve08kD1C9mLXPukuM7eS0taqIWtBOyLJ5gOLNvVFZ5kujGWBKHLLdhxod/gs
 jUSMjvURc7NHliyLKCx969lPxHIp1s6OqQpfctctL3x3hDM9Mb0QnAqUTf//75Lyp2fJ25
 spad8IKqjiLb1R5n6baLCQOqOgupOfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781272455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BqXvKEn80KAYjYtT8X8i3iTT+W6fWs9K9vE6I28bh5c=;
 b=8pTzWk5IcmGqWTy0ifUolXGC3pFx3hgNYAZIODRBQv3snGxeF+xoT+Qfs1vGwVXHeXye1B
 aCseFMwLOwRwQEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66BB1779A7;
 Fri, 12 Jun 2026 13:54:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ljV/F4cPLGrGfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 12 Jun 2026 13:54:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 12 Jun 2026 15:54:13 +0200
Message-Id: <20260612-metadata_groups-v1-0-d7a24a7ac7a8@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIUPLGoC/x3MQQqAIBBA0avErBN0iqCuEhFDTjaLNLQiCO+et
 HyL/19IHIUTDNULkW9JEnyBqStYNvKOldhiQI2d7gyqnU+ydNLsYriOpKzFttGMptcGSnVEXuX
 5j+OU8wcksM5+YQAAAA==
X-Change-ID: 20260612-metadata_groups-dd2430e21901
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781272455; l=626;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=9z63GMy6cAQBgj8RjUMOUE4NKcvx6L4i+ltkeb5iMWk=;
 b=Hzesy9tJ7WAvFZtOGaNpa5+IJ6DsNrpCWegAkRn6Ago2PKbd9oUhzsdTid0fHjEO2745u3X+9
 NwAPRcuE6ClCB/TpNct8rla1NTx7ClRQTrgiVTGL2pg7msOJxkuvAke
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Support metadata groups
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
      metadata: add tests grouping support
      doc: conf.py: Show groups in test catalog

 doc/conf.py                  | 14 ++++++-
 metadata/metaparse.c         | 88 ++++++++++++++++++++++++++++++++++++++++++++
 metadata/tests/groups.c      | 11 ++++++
 metadata/tests/groups.c.json | 13 +++++++
 4 files changed, 125 insertions(+), 1 deletion(-)
---
base-commit: a3fda1dc1ce7da882a592a4877da7f214e468650
change-id: 20260612-metadata_groups-dd2430e21901

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
