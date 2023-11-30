Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B96C4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 09:37:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B4393CF633
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 10:37:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91C4E3C8960
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:37:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1AD63603454
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 10:37:13 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C55FF21AB1;
 Thu, 30 Nov 2023 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701337031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fNGEfPz/bxEpknsN/e+GJ8e2UP5P0u8R8SolDMCGkEs=;
 b=h5ods8mBJgxySK51BbPvzfIKmTKxw7V27h+w4LxOs7RJLUpGkJsCrRxFocM9bWVJq+0IXr
 JllOxncmjtOexBEct9vnuOp5Eb5PXHV4DIp1pl9W2raHu3f5kRLF7DBLQKThm5Qv255DUg
 iZic/oEx0BpcX8eOQPMvPdD+awQjKXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701337031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fNGEfPz/bxEpknsN/e+GJ8e2UP5P0u8R8SolDMCGkEs=;
 b=cNX2nod/03WFnIhePkxSNxZ8soS4LTM70s6kEcRA8bx9ee23ar5S7TOjDHPU1cbbsP2xKE
 KMJNbYPVpSx2ZfCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B4A7113A5C;
 Thu, 30 Nov 2023 09:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id HqgSLMdXaGVQKAAAn2gu4w
 (envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 09:37:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 44E04A07E3; Thu, 30 Nov 2023 10:37:11 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 30 Nov 2023 10:37:03 +0100
Message-Id: <20231130093533.10036-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[43.04%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6 v2] fanotify: Make feature tests operate against
 tested path
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

some of the fanotify features are not available across all filesystems. Thus
depending on which path is used for placing fanotify mark the feature may or
may not be available. This leads to test failures when some feature is
supported in tmpdir but not on the tested filesystem. Convert all of the
fanotify feature tests to be performed on the path actually being used for
testing.

Changes since v1:
* Added Amir's reviewed by
* Fixed up bug in patch 1 leading to incorrect feature availability detection
* Added patch to print more details in error messages
* Changed FAN_CLASS_CONTENT to FAN_CLASS_NOTIF when testing whether a mark
  type is supported.


								Honza
Previous versions:
Link: http://lore.kernel.org/r/20231129114617.12660-1-jack@suse.cz # v1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
