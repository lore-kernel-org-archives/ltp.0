Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9C9C02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:36:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D78493C9298
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 16:36:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E10BE3C929B
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:34:48 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6C43F66FED0
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:34:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECF64210F7;
 Thu,  6 Feb 2025 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738856081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=weeMrzkRKYPK7i13N6mryMd4d4j08BfM5rDG5CzvH3w=;
 b=Cd5PPeHY5gl18rCNwTOV2x8MjeIT0Lmaww/fXAf19/MmFJxeCeQAV7AgkxrDPFbCaXnPpb
 NJLPmBwYJGLBP0T4eTIT1Mx857g1Vslw4Rx1PRPAmTvT89eMWhbhQ9o3FmARwHUgEZlNKA
 VS1bljJpNmb/ExkgvpKtC7BfBY9SCPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738856081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=weeMrzkRKYPK7i13N6mryMd4d4j08BfM5rDG5CzvH3w=;
 b=wPkHwdGGOHe4a3LNkAqOhZCfZ+0DzJp4M1TqWPeRnGxGadpAHqnqAsS9i3awJLaZq5WrP3
 mk/fcUj4IsopNkDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wBOwVApa;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CB7hdmIH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738856080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=weeMrzkRKYPK7i13N6mryMd4d4j08BfM5rDG5CzvH3w=;
 b=wBOwVApaAgodWJDYFnxwccpwpaRYDPdlJtMnaWvRa1Pq5PDn3h77WTtPc5nIN8fEEsWLeD
 PW/MiSQYnDNLxz3AcUDZlasqDVdSX/YoFDxAiLZEefe8Jvc3cnnxI8Ar7DCu7HeCzgxmI2
 rB01gikmbg5XS++xgcJLbVUXWo7vJ8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738856080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=weeMrzkRKYPK7i13N6mryMd4d4j08BfM5rDG5CzvH3w=;
 b=CB7hdmIHF6wl4cvMVqqvOE5xhpIxnUY90Pbm519eGiU2PpRrlU6si6p1ZTq3heGz6Lvqzk
 nbw5f+HYvo5tG6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4CCD13697;
 Thu,  6 Feb 2025 15:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qwHdLpDWpGcUOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Feb 2025 15:34:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Feb 2025 16:34:30 +0100
Message-ID: <20250206153435.1602181-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: ECF64210F7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:dkim, ozlabs.org:url,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5] configure.ac and make cleanup
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

Hi,

TL;DR: Commits which fix CI are 1st and 4rd:

  doc/Makefile: Add dependency on metadata/ltp.json
  .github: ci-sphinx-doc: Run autotools and configure

If I don't get any feedback, I'll merge them tonight.
Other commits can wait.

Tested:

https://github.com/pevik/ltp/actions/runs/13182184736
https://github.com/pevik/ltp/actions/runs/13182184734

Changes in v1:
* Remove virtualenv (Andrea)
* Rebase to put fixing commit first
* Further improve make clean pattern, remove unneded distclean patern
* Drop 2 patches which aren't important to fix CI
  - 8662c96207 ("configure: Ignore --with-{bash,python} knobs")
  - 98b6a63202 ("realtime: Document bash and python3 dependencies")

Link to v1:
https://patchwork.ozlabs.org/project/ltp/list/?series=443127&state=*
https://lore.kernel.org/ltp/20250206143421.1571918-1-pvorel@suse.cz/

Kind regards,
Petr

Petr Vorel (5):
  doc/Makefile: Add dependency on metadata/ltp.json
  doc/Makefile: Improve clean target
  doc: documentation.rst: Update build instructions
  .github: ci-sphinx-doc: Run autotools and configure
  configure: make: Add SPDX, update copyright

 .github/workflows/ci-sphinx-doc.yml |  9 +++++++--
 configure.ac                        |  3 +++
 doc/Makefile                        | 14 ++++++++++++--
 doc/developers/documentation.rst    |  8 ++++----
 include/mk/automake.mk              | 24 ++++--------------------
 include/mk/config-openposix.mk.in   |  2 ++
 include/mk/config.mk.in             | 23 +++--------------------
 include/mk/env_post.mk              | 25 ++++---------------------
 include/mk/env_pre.mk               | 26 ++++----------------------
 include/mk/features.mk.in           | 22 ++--------------------
 include/mk/functions.mk             | 25 ++++---------------------
 include/mk/generic_leaf_target.inc  | 24 ++++--------------------
 include/mk/generic_leaf_target.mk   | 24 ++++--------------------
 include/mk/generic_trunk_target.inc | 24 ++++--------------------
 include/mk/generic_trunk_target.mk  | 24 ++++--------------------
 include/mk/lib.mk                   | 27 ++++-----------------------
 include/mk/man.mk                   | 23 +++--------------------
 include/mk/module.mk                | 18 ++----------------
 include/mk/rules.mk                 |  3 +++
 include/mk/sparse.mk                |  2 ++
 include/mk/testcases.mk             | 22 ++--------------------
 21 files changed, 81 insertions(+), 291 deletions(-)

-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
