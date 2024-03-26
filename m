Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D529C54E67
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 14:42:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E07013D0EC2
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 15:42:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F000D3CC7D4
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:41:49 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 953431A010D6
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:41:49 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAD2637CCF;
 Tue, 26 Mar 2024 14:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711464108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HsINwNyDjhSu+1EgKPsa4SaU6Kr/bE8BLf1vg9K7SPs=;
 b=BSQQS42n7AVeQxpFUUywmqyWUnXKvSgMJVwna90cLU80Ib9EIub2PUX+8pZc0P1RSecVcs
 RJoZbENNaZCqHFrnAYpOs/tn/hw/AM8RGvJwaOCG71kXcRZfRuKcCKuZXH2J9gFNnl/lQG
 eyHGEm5HCHD+50/ErVvDN77duquydj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711464108;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HsINwNyDjhSu+1EgKPsa4SaU6Kr/bE8BLf1vg9K7SPs=;
 b=3h8OX3Mx1dRjvrVv9CfIOuv/uuu4naVBa2g4FhLnmKsZurL89SAauhrp2CLzHp/ksAGzVK
 4Qfbl5PNKrAhFaAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711464108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HsINwNyDjhSu+1EgKPsa4SaU6Kr/bE8BLf1vg9K7SPs=;
 b=BSQQS42n7AVeQxpFUUywmqyWUnXKvSgMJVwna90cLU80Ib9EIub2PUX+8pZc0P1RSecVcs
 RJoZbENNaZCqHFrnAYpOs/tn/hw/AM8RGvJwaOCG71kXcRZfRuKcCKuZXH2J9gFNnl/lQG
 eyHGEm5HCHD+50/ErVvDN77duquydj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711464108;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HsINwNyDjhSu+1EgKPsa4SaU6Kr/bE8BLf1vg9K7SPs=;
 b=3h8OX3Mx1dRjvrVv9CfIOuv/uuu4naVBa2g4FhLnmKsZurL89SAauhrp2CLzHp/ksAGzVK
 4Qfbl5PNKrAhFaAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A24E413215;
 Tue, 26 Mar 2024 14:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id H1OIJqzeAmYTTAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 26 Mar 2024 14:41:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 26 Mar 2024 15:41:42 +0100
Message-ID: <20240326144145.747735-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BSQQS42n;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3h8OX3Mx
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[43.05%]
X-Rspamd-Queue-Id: CAD2637CCF
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] fanotify14 on SELinux fix
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
* merged first commit (unrelated cleanup)
* modify library to require to pass array size in TST_EXP_FAIL*_ARR()

Mete Durlu (1):
  fanotify14: fix anonymous pipe testcases

Petr Vorel (2):
  lib: Add tst_selinux_enforcing()
  tst_test_macros.h: Require to pass array size in TST_EXP_FAIL_ARR()

 include/tst_security.h                         |  1 +
 include/tst_test_macros.h                      |  8 ++++----
 lib/newlib_tests/test_macros02.c               |  8 ++++----
 lib/tst_security.c                             | 18 ++++++++++++++++--
 .../kernel/syscalls/fanotify/fanotify14.c      | 10 +++++++---
 .../kernel/syscalls/readahead/readahead01.c    |  2 +-
 6 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
