Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DF8CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 08:34:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF9623E5249
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 10:34:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CB143C5730
 for <ltp@lists.linux.it>; Tue, 26 May 2026 10:34:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 31C331400BD6
 for <ltp@lists.linux.it>; Tue, 26 May 2026 10:34:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 462A36714E
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779784454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=szoLIPAcifAumRqpUCOe1V1t78SEPWQOgWuwQ6LlDM8=;
 b=itK1dzFAiTY8rxkLCsMtQM6BMD4oz+0S/Pj7OlMDf/e/AQGHCPf7R/lpS1TPhib0dtwZfU
 5vS9Enfpr6iwRjSoUnMSiWpZYkFHtUMaPK90BkbgRbBKvzd4ivQ3p8aGtd4z0k7ZAoOnJb
 HEmZAKSYunEg83FvmVfVkyfVA7soXKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779784454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=szoLIPAcifAumRqpUCOe1V1t78SEPWQOgWuwQ6LlDM8=;
 b=JYb4SeNCtl93rsMqDyi00d/zlZUgtF1wwRMxWWN6/Gtw4rtmwJhG0FB80a2MIB8gfoKPlo
 U6g2Op+djpGG4PBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779784453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=szoLIPAcifAumRqpUCOe1V1t78SEPWQOgWuwQ6LlDM8=;
 b=Z/NKa/DvVJFAMN0r7hl6VeA3nMpsYEE3UloVgvgQbHS/uQJkrT+mwVffQBo+N59Z2R1VtT
 1welio3r3cCF4EgMv5AmZ4Y/X6v3xWV8SN+/ZmriF5QrJz7oNkDKQEdPdxfhZcrBHdsnVn
 hUA/w3woND3pJsPSZFTp4tg7M2sTNt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779784453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=szoLIPAcifAumRqpUCOe1V1t78SEPWQOgWuwQ6LlDM8=;
 b=HSF0kxsyHj3AY3lP0SHAD2F7ajhqbpMnNsiIs0tqECGwKTQ/wQUEcwDhEUpl7/UCr3qFrZ
 ZAHerKElylkENxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E8CA5A0F3
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LQiUBgVbFWo4SwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:34:13 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 26 May 2026 10:34:04 +0200
Message-ID: <20260526083406.357092-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 internal_greylist_whitelist(0.00)[10.150.64.97];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Fix inotify{07,08} TBROK where it should TFAIL
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

Fixes regression cause by deda021818a4 ('inotify: modernize with SAFE_ wrappers')

v2: Fix all the typos

Cyril Hrubis (2):
  safe_macros: Add SAFE_READ_ANY_EAGAIN
  syscalls/inotify{07,08}: Fix TBROK on older kernels

 include/safe_macros_fn.h                      | 16 ++++++++++++++--
 lib/safe_macros.c                             | 10 +++++++---
 testcases/kernel/syscalls/inotify/inotify07.c |  2 +-
 testcases/kernel/syscalls/inotify/inotify08.c |  2 +-
 4 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
