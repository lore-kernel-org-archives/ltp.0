Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3CEC54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 10:53:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBCEF3E71DC
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 12:53:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A663D3E7218
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 12:51:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 171E1200AD5
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 12:51:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D5803EF6;
 Fri, 31 Jul 2026 10:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785495105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v7GRqTvMdG58Dh0Oltbtiweqzr0GbF+d8l0WYBeT/oM=;
 b=j2xmvNZykzSoPMppTNqY76u44TIpMqnOaMt7QPLcCBOUkF/T3bzQcdJu8PYCOfkTPGoOZY
 5BeUsaBZuUXRunsDYjK4U/7POa6zgNFpBNsA3kCaPx6bsN1Mu2D6MIIT38BGblf4mxnymt
 ILFT7YZmSDoSDx3y6qGuQmhuhwpSa0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785495105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v7GRqTvMdG58Dh0Oltbtiweqzr0GbF+d8l0WYBeT/oM=;
 b=Zqydd9ks4j0iAK+9g6bRMnNvjFamTQ6Kxo9Xr58AQcLR7qxVPOCxnwdGb8li8Rj4PQKl8T
 5Pmb5mnLQhTWveCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785495101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v7GRqTvMdG58Dh0Oltbtiweqzr0GbF+d8l0WYBeT/oM=;
 b=JucWnEImKiShmeMZE8j127T9aEwbFxyIf8AZIiW/jQCprdJJQaWDhlSF59npI+TXpWd+/m
 hSSyY1MjWS48rPbQwB5Y7oCVrV1pKtbmR9hkW3MXexjg0HgwRQ/WdCuh6rrw4aC6rbmkdk
 wmpIBIdNrh0xYDTmimAdZwHa0Vb7zwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785495101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v7GRqTvMdG58Dh0Oltbtiweqzr0GbF+d8l0WYBeT/oM=;
 b=vjQudmZfu2CM1NdLsURIMeAAdx1sFtLGKl0CKbYbIuQEHZMsgk9wqlrcO697V0iy+heK4Y
 tU151pBKbeGRCRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89824779C6;
 Fri, 31 Jul 2026 10:51:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tU3fHzx+bGoTJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jul 2026 10:51:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 31 Jul 2026 12:51:27 +0200
Message-ID: <20260731105132.187177-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.974];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/5] Add support for .max_kver
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

Changes v2->v3:
* Allow to pass mainline release (e.g. max_version = "7.1") on any stable
  release (e.g. 7.1.5). Stable releases (e.g. 7.1.5) are compared as
  expected. For this I'd like an explicit ack.

Link to v2:
https://lore.kernel.org/ltp/6a6a2091.9b80fa5d.4e4ae.7aac@mx.google.com/T/#t

Changes v1->v2:
* Fixed version 6.11 => 6.10 (execve04, creat07)
* Fixed version 7.2 => 7.1 (fanotify20)

Link to v1:
https://lore.kernel.org/ltp/20260729091717.23042-1-pvorel@suse.cz/T/#t
https://patchwork.ozlabs.org/project/ltp/list/?series=516120&state=*

Petr Vorel (5):
  lib: Rename function check_kver() => check_min_kver()
  lib: Add support for max_kver to struct tst_test and tst_fs
  execve04: Use .max_kver
  creat07: Use .max_kver
  fanotify20: Skip on v7.2

 include/tst_test.h                            | 13 ++++-
 lib/tst_test.c                                | 57 +++++++++++++++++--
 testcases/kernel/syscalls/creat/creat07.c     | 14 ++---
 testcases/kernel/syscalls/execve/execve04.c   | 14 ++---
 .../kernel/syscalls/fanotify/fanotify20.c     |  4 ++
 5 files changed, 76 insertions(+), 26 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
