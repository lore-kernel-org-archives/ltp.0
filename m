Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD699C6FD1F
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 16:42:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7C4B3CD09F
	for <ltp@archiver.kernel.org>; Tue,  2 Apr 2024 18:42:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B2B43C867B
 for <ltp@lists.linux.it>; Tue,  2 Apr 2024 18:42:33 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9F5CF1000F1B
 for <ltp@lists.linux.it>; Tue,  2 Apr 2024 18:42:32 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F9F25C00A
 for <ltp@lists.linux.it>; Tue,  2 Apr 2024 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712076150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cTTXxSqfxgI7YSvOb8rfsfPgwBRVYYdt4S79XtNRDS0=;
 b=u2nUR2hfwkrFrJ1Gr3EVzXErWrxFW0dPmQ8YUA3E5J4yfLWaO3N5jZObVrU+GUfPZAz72R
 LnkIjJYb8DMu8nW13L5pTJbyJ4RfN/P5VFHMkhOrgjrOuelLuRQAOpK9F0sLZVm8UtE2bV
 W/QwwyA/SNIXt/QSKEt/w9mlb2XFmGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712076150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cTTXxSqfxgI7YSvOb8rfsfPgwBRVYYdt4S79XtNRDS0=;
 b=/FpU4iMaOtcSdiaLlaEMhKDwmRUDeVSc9hwgyyQj0GNnjyk3MGPqxZG4S8iztZ189ClXHo
 UgY35McXcV5B9nAA==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B2BC13357
 for <ltp@lists.linux.it>; Tue,  2 Apr 2024 16:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id PzT2FXY1DGajFwAAn2gu4w
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 02 Apr 2024 16:42:30 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  2 Apr 2024 18:41:29 +0200
Message-ID: <20240402164131.12535-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
X-Spamd-Result: default: False [3.38 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_DN_NONE(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.03)[-0.144]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.49)[79.67%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] doc: Add generated API docs
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

This applies over the new doc patchset from Andrea and converts
documentation in headers into a linuxdoc format.

This is a v2 with spelling fixes hopefully all the easily caught
mistakes are fixed now.

If you have a bit of time please read the changes through and report any
problems.

Cyril Hrubis (2):
  doc: Add more to spelling_wordlist
  include: doc: Convert comments into linuxdoc

 doc_new/developers/api_c_tests.rst |  26 ++
 doc_new/spelling_wordlist          |  40 +++
 include/tst_buffers.h              |  86 +++--
 include/tst_capability.h           |  80 ++++-
 include/tst_checkpoint.h           |  64 +++-
 include/tst_compiler.h             |  20 ++
 include/tst_hugepage.h             |   2 +
 include/tst_parse.h                |  65 ++++
 include/tst_res_flags.h            |  72 +++-
 include/tst_test.h                 | 509 +++++++++++++++++++++--------
 10 files changed, 762 insertions(+), 202 deletions(-)
 create mode 100644 include/tst_compiler.h
 create mode 100644 include/tst_parse.h

-- 
2.43.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
