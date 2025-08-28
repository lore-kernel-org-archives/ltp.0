Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFE5CA0EED
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 13:11:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F6CA3CCE90
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 15:11:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9385A3CCE90
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 15:11:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EAC8510000C7
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 15:11:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E765B20BCE;
 Thu, 28 Aug 2025 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756386686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wBix2VuPh1h3vl3s9L9kuRmDWZOK9kjI9FpsB+iA96I=;
 b=WV7xnldH91VxRt81P981Q0oxahAw3eH8Hys0e/nuoSq5AcrmQta00mGTJAgxxDHgNkKBIY
 s6T5PtlwMvgmueLxLf/3pajosJpIWUL4aa+xzyobaVm3HGmTXbdaePXrghTLtbRcVG+x9i
 zYyDvNaAvFZ0J+WaAkADl/mnJJ2G3ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756386686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wBix2VuPh1h3vl3s9L9kuRmDWZOK9kjI9FpsB+iA96I=;
 b=fXPVTf8LlCE9wcl7uU2FeUS2DhVYHhHA+iZWzqZ+5J5tnI+VGumq3VgiOFulowGfPD/AsA
 t5Nn2188Wz0FZqBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gO5YL3Lr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IAyEoOcS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756386685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wBix2VuPh1h3vl3s9L9kuRmDWZOK9kjI9FpsB+iA96I=;
 b=gO5YL3LrtEVvw7pE9Zas16kTS38QFCrQQKxYZfxchilhnSn9uBEM1ovhh+KndoRYBgxA0W
 L1wQMIhwa6rNx5Qu4SDi67eoj5YGQZrOv1P+qs045u2NxzCcFdeOmoYyYmtD335IdkHjDy
 dfI9l5jeZITnS/cMSk0jEfj/gUHluj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756386685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wBix2VuPh1h3vl3s9L9kuRmDWZOK9kjI9FpsB+iA96I=;
 b=IAyEoOcSYOCAX0RAqUofz+auFI+76T3Wy68HH8YTKQ/pS5AvVk5Q7t/jkaQ9thY/FRoDHl
 q3crfAcYZjkUssDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C324B13326;
 Thu, 28 Aug 2025 13:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7R0iLX1VsGjfCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 28 Aug 2025 13:11:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 28 Aug 2025 15:11:23 +0200
Message-Id: <20250828-open_tree_attr-v1-0-f339a0e51e22@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHxVsGgC/x3MQQqAIBBG4avErBNKsqKrREjZX83GYpQIwrsnL
 b/Fey8FCCPQULwkuDnw6TPqsiB3zH6H4jWbdKVN1etenRe8jQLYOUZRzaLhYLrW1Y5ydAk2fv7
 hOKX0ARjPWxBgAAAA
X-Change-ID: 20250828-open_tree_attr-4b2ece576c1c
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756386685; l=776;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=QcRkZ/wZMw7xfXggBkZlh6Q0LLoxsiGp92CnQ+/0ofQ=;
 b=BBDtFzxMxG8lx3fcQ7z54yoEuhHSQcbNgzxvFi6/X/HvaiTZzEwVy6Fo9zodCMR9GNs29L/fI
 oCgRgsCFK5fDi5upjbaCjENoB6olMxCBRVgjlp7GN68o1r0YCt7FB1a
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: E765B20BCE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] open_tree_attr syscall coverage
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
Andrea Cervesato (2):
      Add open_tree_attr fallback
      mount_setattr01: add open_tree_attr variant

 configure.ac                                       |  1 +
 include/lapi/fsmount.h                             |  8 +++
 .../syscalls/mount_setattr/mount_setattr01.c       | 69 ++++++++++++++++------
 3 files changed, 61 insertions(+), 17 deletions(-)
---
base-commit: 2f465c71bc999ed1796b69f68330495f2c69e131
change-id: 20250828-open_tree_attr-4b2ece576c1c

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
