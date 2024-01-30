Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C78C47DA9
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 07:36:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47FF63CE111
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 08:35:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0ACB23CE0E6
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 08:35:12 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6022F1400E17
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 08:35:12 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 173081F833;
 Tue, 30 Jan 2024 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706600111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=clDFRJVHNiO/+swh8uuRyZPKQmMMhVECvdC80duwlXQ=;
 b=Di54TC9SBeHluMx/YQjci95dvz76uxQNY4hVkhu2jfcQ5p1SI9+hQ3VwWJ9PTnzGmXTxXC
 NRWH1PHcnAJ8ApX+CJvpZ+JqHkvVybO8xnlg5trByQQozSnl2SHBclA7Z+CTZGUzfx/l15
 Qo8fiA7Y/hM1d6U9dwc86OSXzOPIhY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706600111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=clDFRJVHNiO/+swh8uuRyZPKQmMMhVECvdC80duwlXQ=;
 b=dntvCQJoI/XQCq5iEbE7f7oGcEjxhwlIRZab1rectvr7w/d1H5bB7VO2dCcDGPK3eqjIRy
 FQdsoFy5fS+6mWDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706600111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=clDFRJVHNiO/+swh8uuRyZPKQmMMhVECvdC80duwlXQ=;
 b=Di54TC9SBeHluMx/YQjci95dvz76uxQNY4hVkhu2jfcQ5p1SI9+hQ3VwWJ9PTnzGmXTxXC
 NRWH1PHcnAJ8ApX+CJvpZ+JqHkvVybO8xnlg5trByQQozSnl2SHBclA7Z+CTZGUzfx/l15
 Qo8fiA7Y/hM1d6U9dwc86OSXzOPIhY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706600111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=clDFRJVHNiO/+swh8uuRyZPKQmMMhVECvdC80duwlXQ=;
 b=dntvCQJoI/XQCq5iEbE7f7oGcEjxhwlIRZab1rectvr7w/d1H5bB7VO2dCcDGPK3eqjIRy
 FQdsoFy5fS+6mWDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F208713462;
 Tue, 30 Jan 2024 07:35:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 9ff2Oa6muGVjTwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 07:35:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Jan 2024 08:35:04 +0100
Message-ID: <20240130073507.662414-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.93 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.97)[99.88%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] runtest cleanup
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

Petr Vorel (3):
  runtest: Move capability related tests to new capability
  runtest: Move io content to ltp-aiodio.part4
  runtest: Remove 'ltp-' prefix from aio* runtests

 runtest/{ltp-aio-stress => aio-stress}     | 0
 runtest/{ltp-aiodio.part1 => aiodio.part1} | 0
 runtest/{ltp-aiodio.part2 => aiodio.part2} | 0
 runtest/{ltp-aiodio.part3 => aiodio.part3} | 0
 runtest/{ltp-aiodio.part4 => aiodio.part4} | 6 +++---
 runtest/cap_bounds                         | 2 --
 runtest/{securebits => capability}         | 5 ++++-
 runtest/filecaps                           | 2 --
 runtest/io                                 | 3 ---
 9 files changed, 7 insertions(+), 11 deletions(-)
 rename runtest/{ltp-aio-stress => aio-stress} (100%)
 rename runtest/{ltp-aiodio.part1 => aiodio.part1} (100%)
 rename runtest/{ltp-aiodio.part2 => aiodio.part2} (100%)
 rename runtest/{ltp-aiodio.part3 => aiodio.part3} (100%)
 rename runtest/{ltp-aiodio.part4 => aiodio.part4} (90%)
 delete mode 100644 runtest/cap_bounds
 rename runtest/{securebits => capability} (53%)
 delete mode 100644 runtest/filecaps
 delete mode 100644 runtest/io

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
