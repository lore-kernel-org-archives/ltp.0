Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E57E87822
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 12:50:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2EB03CD15B
	for <ltp@archiver.kernel.org>; Tue,  3 Feb 2026 13:50:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C62D33CC099
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 13:50:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 45DB660067A
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 13:50:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5A495BCC3
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770123029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x4v6+e7TtwZkDaoT/reF+O7qAiOc4uceNVl2BYKNSwA=;
 b=ICNBqeAfzPFETawwloWObWgctC/7dP5RgJV0+RFJ3ZmCw0TWt0Hu9AVIYMIiscrhzkt/y0
 edVzTo3v422Pf8u0MGOj65FY64SoD+URXAL4ksTWQh9kZZAEYWxaQzQIeBkTKq/R6vBQ4C
 vavbqQkeEb9HHEOvdq9nlONC7Q5jAr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770123029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x4v6+e7TtwZkDaoT/reF+O7qAiOc4uceNVl2BYKNSwA=;
 b=RyQQ/jZaUlg2zl++3jukBM/kR+1Jr9flArN+jEpQajZsOWE2hzRB7dHvX1hP2D4qjasmkz
 zOREwErfW+xBl6DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770123029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x4v6+e7TtwZkDaoT/reF+O7qAiOc4uceNVl2BYKNSwA=;
 b=ICNBqeAfzPFETawwloWObWgctC/7dP5RgJV0+RFJ3ZmCw0TWt0Hu9AVIYMIiscrhzkt/y0
 edVzTo3v422Pf8u0MGOj65FY64SoD+URXAL4ksTWQh9kZZAEYWxaQzQIeBkTKq/R6vBQ4C
 vavbqQkeEb9HHEOvdq9nlONC7Q5jAr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770123029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=x4v6+e7TtwZkDaoT/reF+O7qAiOc4uceNVl2BYKNSwA=;
 b=RyQQ/jZaUlg2zl++3jukBM/kR+1Jr9flArN+jEpQajZsOWE2hzRB7dHvX1hP2D4qjasmkz
 zOREwErfW+xBl6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AC5A3EA62
 for <ltp@lists.linux.it>; Tue,  3 Feb 2026 12:50:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zcGuIRXvgWkNcgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 03 Feb 2026 12:50:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Feb 2026 13:50:23 +0100
Message-ID: <20260203125029.15413-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Rewrite aio_cancel_2-1
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

Rewrite another aio_cancel() test which hopes it can win a race
against unblocked writes into a file. Also add shared setup and
cleanup helper functions for AIO writes into a socket pair and
use them in the two already rewritten tests.

Martin Doucha (3):
  openposix/aio_cancel: Add helper functions for setup and cleanup
  openposix/aio_cancel: Use setup helper functions in tests 5 and 7
  aio_cancel_2-1: Rewrite test

 .../conformance/interfaces/aio_cancel/2-1.c   | 86 +++++++++--------
 .../conformance/interfaces/aio_cancel/5-1.c   | 79 +++-------------
 .../conformance/interfaces/aio_cancel/7-1.c   | 79 ++--------------
 .../open_posix_testsuite/include/aio_test.h   | 94 +++++++++++++++++++
 4 files changed, 163 insertions(+), 175 deletions(-)
 create mode 100644 testcases/open_posix_testsuite/include/aio_test.h

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
