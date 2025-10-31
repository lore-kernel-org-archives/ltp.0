Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23365CCF9FF
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 09:27:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E0873CC995
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 10:27:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EC683CC9E0
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 10:27:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 31ACC1400DC0
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 10:27:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B630D22027;
 Fri, 31 Oct 2025 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761902834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qzVhNPcmwM9EIGVLiUc7khV2bUyuZQtmySgn8ZGsHsk=;
 b=VYU7VhJ07entq4cDubGXCAvRfjt95Uvv9oO/sNiZLEJYyqQsmqW4FUifATHAweA6Tp22BD
 9up1eFJRVQuS0zSqqyvpMsdQKPmKdh6JjC2sor+tJL5xPE/RJtOMxm3PMgco3KZfeXFV69
 ie8b/STYnPZ3TQD6PW4T2tMlKT1RuFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761902834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qzVhNPcmwM9EIGVLiUc7khV2bUyuZQtmySgn8ZGsHsk=;
 b=0sPnj5dk5HVrN52nmCuYQuCtAIi+6erdbVuEgV4VLnrW8M/Hg9giG/5EPF4ovMJ7DaVORh
 ZUqCxusGV0hMP4AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VYU7VhJ0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0sPnj5dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761902834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qzVhNPcmwM9EIGVLiUc7khV2bUyuZQtmySgn8ZGsHsk=;
 b=VYU7VhJ07entq4cDubGXCAvRfjt95Uvv9oO/sNiZLEJYyqQsmqW4FUifATHAweA6Tp22BD
 9up1eFJRVQuS0zSqqyvpMsdQKPmKdh6JjC2sor+tJL5xPE/RJtOMxm3PMgco3KZfeXFV69
 ie8b/STYnPZ3TQD6PW4T2tMlKT1RuFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761902834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qzVhNPcmwM9EIGVLiUc7khV2bUyuZQtmySgn8ZGsHsk=;
 b=0sPnj5dk5HVrN52nmCuYQuCtAIi+6erdbVuEgV4VLnrW8M/Hg9giG/5EPF4ovMJ7DaVORh
 ZUqCxusGV0hMP4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C1B213393;
 Fri, 31 Oct 2025 09:27:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bzJqJPKABGk8WQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 31 Oct 2025 09:27:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 31 Oct 2025 10:27:08 +0100
Message-Id: <20251031-kirk_move_submodule-v1-0-3cad4270a0b5@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO2ABGkC/x3MTQqAIBBA4avIrBPUclFXiZDKqYZ+DCUJxLsnL
 b/FewkCesIAHUvgMVIgdxXIisG8jdeKnGwxKKG0FLXkO/ndnC6iCc90OvscyLXUbaMmbS22UMr
 b40Lvf+2HnD+JcxKtZQAAAA==
X-Change-ID: 20251031-kirk_move_submodule-515942b5dde9
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761902834; l=715;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=9pnl+WtO2A66dZkBlseZ/XWLKuElyXlx5wkj6ITH0Dg=;
 b=8dcHEyb/5s9QyzfpKJpAtqqc4Bs73uuQNxDEjMpwLD2raVYHILDAvnbemBkDVCMvhBBVSKM6j
 nNJ2TaGV7PMC6l2Xwfu130t7H4yV4LdMe0NZckkgJFTvPGeZf1CHSs+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Rspamd-Queue-Id: B630D22027
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Move kirk sources from tools/kirk to
 tools/kirk/kirk-src
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

This is the current standard for LTP and it permits to remove Makefile
from the kirk mainline, that is strictly related to LTP install.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      kirk: remove submodule before moving it
      kirk: move kirk source code inside tools/kirk/kirk-src

 .gitmodules                   |  6 +++---
 tools/kirk/Makefile           | 22 ++++++++++++++++++++++
 tools/{kirk => kirk/kirk-src} |  0
 3 files changed, 25 insertions(+), 3 deletions(-)
---
base-commit: 64de9f928970dacfc3ea2acefc407dbc25e539cf
change-id: 20251031-kirk_move_submodule-515942b5dde9

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
