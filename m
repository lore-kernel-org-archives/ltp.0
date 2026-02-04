Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5060E9538C
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 11:54:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3ECFC3CE0A4
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 12:54:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BCC23CACD1
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 12:53:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 10CB7600849
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 12:53:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 847123E707;
 Wed,  4 Feb 2026 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770206023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oPttsyKZfYL7uW97YTvZSsUnX0QEB7J8MyYMQ4Wbcjg=;
 b=Otyqj3jb10f/2dCBqTEb2ad6L4MLvlChImlFLalmaezUqFQ6Vk3Ywa6nQjJSujYYkwrXgP
 JtgiFJGAyT4qIThrv4Ja03W6l4sIz0nBhygt/rN64ynLz5ER8sqgEwHmQdxnlIe9cyzZbj
 35AYpNrwciV29qNmCGT9/X/X2GLC3Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770206023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oPttsyKZfYL7uW97YTvZSsUnX0QEB7J8MyYMQ4Wbcjg=;
 b=n2RraMXltsHDVIsczhXsSM+VWUYY8fxFnIxAFplCbhjNgPw87zI0gUbFVIH84rksczwgiC
 e9jRAW2Z0Ay1uiCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Otyqj3jb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=n2RraMXl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770206023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oPttsyKZfYL7uW97YTvZSsUnX0QEB7J8MyYMQ4Wbcjg=;
 b=Otyqj3jb10f/2dCBqTEb2ad6L4MLvlChImlFLalmaezUqFQ6Vk3Ywa6nQjJSujYYkwrXgP
 JtgiFJGAyT4qIThrv4Ja03W6l4sIz0nBhygt/rN64ynLz5ER8sqgEwHmQdxnlIe9cyzZbj
 35AYpNrwciV29qNmCGT9/X/X2GLC3Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770206023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oPttsyKZfYL7uW97YTvZSsUnX0QEB7J8MyYMQ4Wbcjg=;
 b=n2RraMXltsHDVIsczhXsSM+VWUYY8fxFnIxAFplCbhjNgPw87zI0gUbFVIH84rksczwgiC
 e9jRAW2Z0Ay1uiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D97CA3EA63;
 Wed,  4 Feb 2026 11:53:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Xug5MUYzg2kcCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Feb 2026 11:53:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Feb 2026 12:53:35 +0100
Message-ID: <20260204115339.224261-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[15]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FREEMAIL_CC(0.00)[suse.cz,suse.com,suse.de,redhat.com,virtuozzo.com,lists.yoctoproject.org,sony.com,free.fr,bootlin.com,linaro.org];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[free.fr]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 847123E707
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] Remove runltp
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

we finally decided to remove runltp [1].
Kirk is the replacement [2] (embedded also as a submodule in LTP).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/aYMQ63RcLp5KdlVt@yuki.lan/
[2] https://github.com/linux-test-project/kirk

Petr Vorel (4):
  doc: INSTALL: dma_thread_diotest.c: Remove runltp from doc
  testscripts/lvmtest.sh: Replace runltp with kirk
  runltp: Remove
  kirk: Remove runltp-ng symlink

 INSTALL                                       |   4 +-
 Makefile                                      |   2 +-
 doc/developers/test_case_tutorial.rst         |   6 +-
 doc/developers/todo.rst                       |  10 -
 metadata/README.md                            |   2 +-
 runltp                                        | 959 ------------------
 .../kernel/fs/fs_readonly/test_robind.sh      |   2 +-
 .../kernel/io/direct_io/dma_thread_diotest.c  |   3 +-
 testcases/kernel/security/smack/README        |   2 +-
 testcases/network/can/filter-tests/INSTALL    |   2 +-
 testcases/network/rpc/rpc-tirpc/README        |   2 +-
 testscripts/Readme_ROBind                     |   4 +-
 testscripts/lvmtest.sh                        |   2 +-
 tools/kirk/Makefile                           |   2 -
 14 files changed, 16 insertions(+), 986 deletions(-)
 delete mode 100755 runltp

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
