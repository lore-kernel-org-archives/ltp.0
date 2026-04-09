Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D14EA3C25
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 10:30:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE36D3E2F37
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 12:30:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0407D3DEBF8
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 12:30:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 768641400DA1
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 12:30:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 86DC55BD1E
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775730630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Vf1hJ9F2NdV1t9RCqqkLHn+Ry6pK0g1NJKets26XhBI=;
 b=RZynngPkDaxciGW3rAHuYStH/tKzNOcRxzCjDTwIO7fmv1iqC56eX2u9Yb2pEcdilQ1CsI
 xpyPoENvcf2OFUvSrCL+OFf7aVsMgLCgmpvf6QWdeTWir2HAQnpHNC3Cno3AQ/u1oJ6ZMe
 IDpRyzMkH1SgnJaVcrDy3GOi1Bj7VzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775730630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Vf1hJ9F2NdV1t9RCqqkLHn+Ry6pK0g1NJKets26XhBI=;
 b=VMj59etomfgmlbNkIkJWSi0pabWvAHn8h0iIORTfVG1VsDV0uqYV8fsUydm2SHj7cZ3+7C
 7eG38OchfwHlzcDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775730630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Vf1hJ9F2NdV1t9RCqqkLHn+Ry6pK0g1NJKets26XhBI=;
 b=RZynngPkDaxciGW3rAHuYStH/tKzNOcRxzCjDTwIO7fmv1iqC56eX2u9Yb2pEcdilQ1CsI
 xpyPoENvcf2OFUvSrCL+OFf7aVsMgLCgmpvf6QWdeTWir2HAQnpHNC3Cno3AQ/u1oJ6ZMe
 IDpRyzMkH1SgnJaVcrDy3GOi1Bj7VzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775730630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Vf1hJ9F2NdV1t9RCqqkLHn+Ry6pK0g1NJKets26XhBI=;
 b=VMj59etomfgmlbNkIkJWSi0pabWvAHn8h0iIORTfVG1VsDV0uqYV8fsUydm2SHj7cZ3+7C
 7eG38OchfwHlzcDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 795E04A0B3
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Px+dHMZ/12krEAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 10:30:30 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Apr 2026 12:30:39 +0200
Message-ID: <20260409103041.8253-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Fix proc parsing in newuname01
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

Turns out some of the strings in procfs can be empty (file with just a
newline) and in such case scanf("%s", ...) fails to read the file while
what we needed instead is a function that would produce an empty string.
This patchset addds such function and makes use of it in the
newuname01 test.

Cyril Hrubis (2):
  lib: safe_file_ops: Add SAFE_FILE_READ_STR()
  syscalls: newuname01: Fix fail on empty domainname

 include/tst_safe_file_ops.h                   | 21 ++++++++++++++++
 lib/safe_file_ops.c                           | 24 +++++++++++++++++++
 .../kernel/syscalls/newuname/newuname01.c     |  8 +++----
 3 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
