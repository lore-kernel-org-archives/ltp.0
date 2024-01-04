Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7FBC47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 12:23:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1554E3CE709
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 13:23:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D242E3CE6E2
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:23:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A93DB601B25
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 13:23:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E473721E42;
 Thu,  4 Jan 2024 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704370994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KFz2By1Hkkw7twH5c0BxxJ+x3HmIm/tCnSo7V9HZgRQ=;
 b=GA/CtCugiEOPfiIyFK42WpHTyAMjt2GtDx0s/DECDLKB6NN4G2FdfJaz2OpObCb0hd0pP5
 OcZx+PcdiFU+NR2M8aG5UAVOnZJjZUs9TGbaEcninO3gzv7q8SFmACXNuixrIVO6Yiv6ul
 hOO4HLpjOEx6TpOufhQVgW9rRTcIs3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704370994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KFz2By1Hkkw7twH5c0BxxJ+x3HmIm/tCnSo7V9HZgRQ=;
 b=3ipuHImYOuieARUSaaPuJibG9nOrpfqxXtNWjuTu/TjuCgEJecGVupq/iu7WzH/YdpU0Jy
 PenPRQBL6PmgRRDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704370993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KFz2By1Hkkw7twH5c0BxxJ+x3HmIm/tCnSo7V9HZgRQ=;
 b=3KbShl7TwkQWn8g5Tz5f99qlDFd6OLfJ9l3CvP+bUG9thwOjGnE4/3j6NmM9qm97p9BoaM
 fPBmteNZX2Gf0S04dpzhXlTzpnbteU3XDol6nmlcxJdzwiIV8yc+85U7rn5rV9M9IK+Kod
 DEkm8BsZKnIl7/9EPigoO3KiPwPA2fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704370993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KFz2By1Hkkw7twH5c0BxxJ+x3HmIm/tCnSo7V9HZgRQ=;
 b=D4PXPKTvx8mFpak/zHcHsIP+PjnM13AIFFn/EMNPeV28d9uj3AtYzLtawAzIJk7ABtekD8
 YjV96OviSlvqfoAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95A2C137E8;
 Thu,  4 Jan 2024 12:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QjmzIjGjlmUVFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 12:23:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 13:23:05 +0100
Message-ID: <20240104122308.1158487-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3KbShl7T;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=D4PXPKTv
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[26.71%]
X-Rspamd-Queue-Id: E473721E42
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Cleanup environment variables prefixes
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

this is a cleanup work based on discussion:

https://lore.kernel.org/ltp/CAEemH2fwu+LSBrsQh6x6C-QsOLJ5O33xMYHG7wjbiPfN4D=fMw@mail.gmail.com/

I'd like to get it merged before release (TST_ENABLE_DEBUG has not been
released yet, it'd be good to get it fixed before release). We should
mention LTP_NO_CLEANUP in the release notes.

Kind regards,
Petr

Petr Vorel (3):
  lib: Use LTP_ prefix for LTP_ENABLE_DEBUG variable
  lib: Use LTP_ prefix for LTP_NO_CLEANUP variable
  doc: Add info about 'LTP_' and 'TST_' variable prefixes

 doc/C-Test-API.asciidoc          |  2 +-
 doc/User-Guidelines.asciidoc     | 10 +++++++---
 lib/newlib_tests/tst_res_flags.c |  2 +-
 lib/tst_test.c                   |  2 +-
 testcases/lib/test.sh            |  2 +-
 testcases/lib/tst_test.sh        |  2 +-
 6 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
