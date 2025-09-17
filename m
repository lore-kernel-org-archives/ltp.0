Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44A9CAC599
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 14:26:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1F7F3CDC6A
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 16:26:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69EF03CDC70
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 16:25:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 96CFE1A003FF
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 16:25:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF9ED20541;
 Wed, 17 Sep 2025 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758119150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6emKKzfr8fxjOAizhrOYQjkul92ez2BjdibWKN2pUZ4=;
 b=Fe2Emwfz05AWph7DCg0OhCo33MF+Yu68WyyQSHiKrEFbXKOznxD3wHuLJxbPjBVCdOv3wI
 TSDOJGkNI8b2kV1amhHmvpheGBNWI+fr7RvVUwvl5aKjSWVj+1QbvFeX8AksSDPAjHK6Nj
 FCcXi5KZExp+yp9vf48OTNpOVv5sZoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758119150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6emKKzfr8fxjOAizhrOYQjkul92ez2BjdibWKN2pUZ4=;
 b=qYXv5FDqmMt+dfUOVMCh0tI10inkBcKJTBiLP0ppPKFG+hTodNZx31AEMmgMMqiHQwCt4/
 0rMWzvB9jsIXxlDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dZObJO7x;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="GZXZx/mG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758119149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6emKKzfr8fxjOAizhrOYQjkul92ez2BjdibWKN2pUZ4=;
 b=dZObJO7x+YyOLB8bn/BEHcL5xqtiBgT1t1sQmTEOIXmG5kPj2UEqJS42sA724Om/vgWdBB
 /hKahTExCczHNxF2RsrTbNCzsyfuVW90P5DSOogR6Pifm0WPn7DJLS3ciTGoLN34pkVbyh
 kg7Dw/HG8l87FF1f9otO3GM6t66A4P4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758119149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6emKKzfr8fxjOAizhrOYQjkul92ez2BjdibWKN2pUZ4=;
 b=GZXZx/mGE3AExf0fUxeoGKSuAxyUAmMJoeyhRwFsTn+XJdnokpSWnKfYCHI/nQXLiEk4wA
 uTRkUU8uzZdRhcDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1DAF1368D;
 Wed, 17 Sep 2025 14:25:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S2VEKe3EymjLCQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 17 Sep 2025 14:25:49 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 17 Sep 2025 16:25:44 +0200
Message-Id: <20250917-open_tree_attr-v3-0-d78d4150b662@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOjEymgC/3XMQQ6CMBCF4auQWVvTTi0WV97DGAJlkC6kpK2Nh
 nB3CxtNjMv3ku+fIZC3FOBUzOAp2WDdmIfcFWCGZrwRs13egBwV16iZm2isoyeqmxg9O7RIhtS
 xNMJARpOn3j634OWa92BDdP619ZNY37+pJBhnvZRVw0kJQjyHR6C9cXdYSwk/uuL4ozHrFmWHS
 qtKl92XXpblDVEgeIjpAAAA
X-Change-ID: 20250828-open_tree_attr-4b2ece576c1c
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758119149; l=1158;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=zIl1/5q3fZgE4WaxNZPdNQQQCyPLdsze+6JSaFjKUqk=;
 b=588QHu3MCfp9pkoVm5YYCry/tQqo5StcRJQHFBKX/0I8DhrNoAzyDmA2kpZA4IHt2NGfNLon2
 N0YcOKqOCP/CrjyJ8BVoY7bfAXk6FFS2PKprZXWxif3j1eKyxPa3EaD
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: CF9ED20541
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] open_tree_attr syscall coverage
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

open_tree_attr has been added in kernel 6.15 in the following commit:
https://lore.kernel.org/all/20250128-work-mnt_idmap-update-v2-v1-3-c25feb0d2eb3@kernel.org/

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- define variants only when syscalls are supported
- Link to v2: https://lore.kernel.org/r/20250902-open_tree_attr-v2-0-b23d2585986d@suse.com

Changes in v2:
- close FD after opening it with open_tree()
- revert style edit in setup()
- use TST_EXP_FD_SILENT()
- Link to v1: https://lore.kernel.org/r/20250828-open_tree_attr-v1-0-f339a0e51e22@suse.com

---
Andrea Cervesato (2):
      Add open_tree_attr fallback
      mount_setattr01: add open_tree_attr variant

 configure.ac                                       |  1 +
 include/lapi/fsmount.h                             |  8 +++
 .../syscalls/mount_setattr/mount_setattr01.c       | 83 +++++++++++++++++-----
 3 files changed, 74 insertions(+), 18 deletions(-)
---
base-commit: 2f208c00cfc4a1d7d5d957ac2b866e1248623aa6
change-id: 20250828-open_tree_attr-4b2ece576c1c

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
