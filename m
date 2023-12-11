Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C641AC10DC3
	for <ltp@archiver.kernel.org>; Mon, 11 Dec 2023 16:18:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD3D73CF808
	for <ltp@archiver.kernel.org>; Mon, 11 Dec 2023 17:18:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A08003CBDE7
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 17:18:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 66AEE1A02362
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 17:18:13 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3FB511FBA0;
 Mon, 11 Dec 2023 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702311492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+pxCkPozzglO3YhGN5OeqYJHDDEu6Dy6HaeI4d9V0T8=;
 b=ZeATADKFYJNS1CJIosnlvWDp4c+ZtKSw4cQeDA+EAYnSUo/YxD6BzcqUYSTLvnplXZZbLr
 m2b+W7JXxfGfwwchEL6pWUSCvfx9gJfy6kcDqspfYmu/G3EAaFR1s5llgVQjWU6Z0I+3bz
 PORdxOv8ED/8Rf4VfvQH33vizLKliFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702311492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+pxCkPozzglO3YhGN5OeqYJHDDEu6Dy6HaeI4d9V0T8=;
 b=FzCJY7n4L52gXzgh/nd5iQfOML3eOsvfNNoI1D4/q+fRjJdu26i1SdrMWdtA3zRoNL/561
 s+k2nTLGx4iirTDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702311492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+pxCkPozzglO3YhGN5OeqYJHDDEu6Dy6HaeI4d9V0T8=;
 b=ZeATADKFYJNS1CJIosnlvWDp4c+ZtKSw4cQeDA+EAYnSUo/YxD6BzcqUYSTLvnplXZZbLr
 m2b+W7JXxfGfwwchEL6pWUSCvfx9gJfy6kcDqspfYmu/G3EAaFR1s5llgVQjWU6Z0I+3bz
 PORdxOv8ED/8Rf4VfvQH33vizLKliFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702311492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+pxCkPozzglO3YhGN5OeqYJHDDEu6Dy6HaeI4d9V0T8=;
 b=FzCJY7n4L52gXzgh/nd5iQfOML3eOsvfNNoI1D4/q+fRjJdu26i1SdrMWdtA3zRoNL/561
 s+k2nTLGx4iirTDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 87FD8138FF;
 Mon, 11 Dec 2023 16:18:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id BZ1BHUM2d2XbCwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 11 Dec 2023 16:18:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 11 Dec 2023 17:18:04 +0100
Message-ID: <20231211161807.526714-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++++++++++++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZeATADKF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FzCJY7n4;
 dmarc=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [13.77 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 BAYES_SPAM(0.00)[22.25%];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(4.60)[~all];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[8];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_SPAM_SHORT(0.08)[0.028]; MIME_GOOD(-0.10)[text/plain];
 DMARC_NA(1.20)[suse.cz];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_SPAM_LONG(3.20)[0.914]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: 3FB511FBA0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] Add TDEBUG tst_res() flag
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

changes v1->v2:
* %s/TDEBUG/TDEBUG/g (Cyril).
* Merged the latest patch and rebased before sending.

Kind regards,
Petr

Petr Vorel (3):
  lib/tests: Add test for testing tst_res() flags
  lib: Add support for TDEBUG tst_res() flag
  fsx-linux: Reduce log output with TDEBUG

 doc/C-Test-API.asciidoc                   |  9 +++--
 include/tst_ansi_color.h                  |  3 ++
 include/tst_common.h                      |  2 +-
 include/tst_res_flags.h                   |  1 +
 include/tst_test.h                        |  5 ++-
 lib/newlib_tests/tst_res_flags.c          | 47 +++++++++++++++++++++++
 lib/tst_ansi_color.c                      |  3 ++
 lib/tst_res.c                             |  9 +++--
 lib/tst_test.c                            | 12 ++++++
 testcases/kernel/fs/fsx-linux/fsx-linux.c | 33 ++++++----------
 10 files changed, 92 insertions(+), 32 deletions(-)
 create mode 100644 lib/newlib_tests/tst_res_flags.c

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
