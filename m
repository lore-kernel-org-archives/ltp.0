Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D0CCA100C
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 08:30:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A4E13CD3B2
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 10:29:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B610A3CD2C8
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 10:29:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 34AFB1000350
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 10:29:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6AE941F454;
 Tue,  2 Sep 2025 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756801780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bZBf4Dy/wp2oKRIlhU7td9NTpFrL3rjTVhLy0cVJrzQ=;
 b=qbr8XLxcCuYZp8OCRnsdMgUybdEJCP0RtXsPWZEjK/z/ttQQ0qd9dXwcHGSeQ9dugUN8QE
 9m5EUrTaDjSKTPC6qTLxtXwechGkhKkaYtNYBk998/9BP4zBwdKEkRu0gmJ0uW6/O8GRuG
 VqyyNYUcy9/emelW1ZXQJD8ab4LxYck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756801780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bZBf4Dy/wp2oKRIlhU7td9NTpFrL3rjTVhLy0cVJrzQ=;
 b=3p4cmSYYs1uaO+niKghJ+5YyEeW0sOBwP9Vssd2+iXC3Eox+CP+gABmbRF5djGsMdPhICX
 BGYJK7UnXOaubMCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756801780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bZBf4Dy/wp2oKRIlhU7td9NTpFrL3rjTVhLy0cVJrzQ=;
 b=qbr8XLxcCuYZp8OCRnsdMgUybdEJCP0RtXsPWZEjK/z/ttQQ0qd9dXwcHGSeQ9dugUN8QE
 9m5EUrTaDjSKTPC6qTLxtXwechGkhKkaYtNYBk998/9BP4zBwdKEkRu0gmJ0uW6/O8GRuG
 VqyyNYUcy9/emelW1ZXQJD8ab4LxYck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756801780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bZBf4Dy/wp2oKRIlhU7td9NTpFrL3rjTVhLy0cVJrzQ=;
 b=3p4cmSYYs1uaO+niKghJ+5YyEeW0sOBwP9Vssd2+iXC3Eox+CP+gABmbRF5djGsMdPhICX
 BGYJK7UnXOaubMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A27E13888;
 Tue,  2 Sep 2025 08:29:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WGSjNfOqtmiDdwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Sep 2025 08:29:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Sep 2025 10:29:35 +0200
Message-Id: <20250902-open_tree_attr-v2-0-b23d2585986d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO+qtmgC/3XMQQ7CIBSE4as0by0GXkVrV97DNA3i1LKwNICNp
 uHuYvcu/0nmWykiOERqq5UCFhedn0rwriI7mukB4e6liSVr2XAj/IypTwHoTUpBHG4MC306WmW
 pnOaAwb038NqVHl1MPnw2f1G/9S+1KCHFUNdnI6EVmC/xFbG3/kldzvkL/IblO6sAAAA=
X-Change-ID: 20250828-open_tree_attr-4b2ece576c1c
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756801779; l=996;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=FeQcaiWcvPHQn3fuA1EMcdGLN1Vu/BTUWS3keAv8K9E=;
 b=U/XHSlO9ATmj31PCMbT7kIxSz6qZv7+7R9Cb3GsyYWR7YfzFlLzwnPfzaJV9FjfD9zNmOO7BB
 OiZkAGyU1xAAHfARAOHdF8/QCVNc3A8WvtIxJLH4kQcONH/1kmi7Pej
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] open_tree_attr syscall coverage
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
 .../syscalls/mount_setattr/mount_setattr01.c       | 68 ++++++++++++++++------
 3 files changed, 60 insertions(+), 17 deletions(-)
---
base-commit: 9691c4b2bea4f772d61ca9e9a93d2087c88f6040
change-id: 20250828-open_tree_attr-4b2ece576c1c

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
