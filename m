Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B382C4829C
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 16:07:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7380A3CF582
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 17:07:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06EC13CC516
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:06:36 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 38C481BB95A7
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:06:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 028BC1F78B;
 Wed,  7 Feb 2024 16:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707321994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Spc+6pSLjWbOwzvmwGNUihoMBcCsIDskK3RIj6Z6DnQ=;
 b=Ylh8r0geRvol9QV/WK/J4S7pTg313Y2C0Y7dptCSRzG8ScyEH44Co1LaHzVAOFVZlYAAke
 BUMVqSx+H8I3959gWl9qyvMEu/2t+8KihlsRDuOv2M7gxCMQzMfq7AESH1VhXmBssGL9Gx
 ssMITicdU1UhjcNVVF8VBV5J9cgB+ZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707321994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Spc+6pSLjWbOwzvmwGNUihoMBcCsIDskK3RIj6Z6DnQ=;
 b=/gSFAPQoQFnJaxWaV6K6BbV34YokvcVqMLjRZynYe72U+JNiKpRAwgYw/SGBwNdPJbhYvh
 eg7CqZhVTQxolBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707321994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Spc+6pSLjWbOwzvmwGNUihoMBcCsIDskK3RIj6Z6DnQ=;
 b=Ylh8r0geRvol9QV/WK/J4S7pTg313Y2C0Y7dptCSRzG8ScyEH44Co1LaHzVAOFVZlYAAke
 BUMVqSx+H8I3959gWl9qyvMEu/2t+8KihlsRDuOv2M7gxCMQzMfq7AESH1VhXmBssGL9Gx
 ssMITicdU1UhjcNVVF8VBV5J9cgB+ZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707321994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Spc+6pSLjWbOwzvmwGNUihoMBcCsIDskK3RIj6Z6DnQ=;
 b=/gSFAPQoQFnJaxWaV6K6BbV34YokvcVqMLjRZynYe72U+JNiKpRAwgYw/SGBwNdPJbhYvh
 eg7CqZhVTQxolBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 992D513931;
 Wed,  7 Feb 2024 16:06:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AhEpJImqw2WRSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Feb 2024 16:06:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 Feb 2024 17:06:24 +0100
Message-ID: <20240207160628.125908-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[18.57%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] Remove double or trailing slashes in TMPDIR in C
 API
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

the initial motivation to avoid problems when people set
TMPDIR=/var/tmp/ instead of TMPDIR=/var/tmp (which is needed for
runtest/fs or runtest/syscalls since [1]).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20240201101603.GA78772@pevik/

Petr Vorel (4):
  lib/tst_tmpdir: Normalize user defined TMPDIR
  lib: Add test for tst_tmpdir
  tst_test.sh: Print warning if slashes in $TMPDIR
  lib: Improve doc related to $TMPDIR default value

 include/tst_defaults.h        |  5 ++--
 lib/newlib_tests/runtest.sh   |  2 +-
 lib/newlib_tests/tst_tmpdir.c | 48 +++++++++++++++++++++++++++++++++++
 lib/tst_tmpdir.c              | 20 ++++++++++++++-
 testcases/lib/tst_test.sh     | 17 ++++++++++---
 5 files changed, 84 insertions(+), 8 deletions(-)
 create mode 100644 lib/newlib_tests/tst_tmpdir.c

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
