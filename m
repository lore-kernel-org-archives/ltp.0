Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B480DC982D8
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 12:50:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F25DF3EA196
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 14:50:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69A733E4D45
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 14:50:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 78E8960032C
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 14:50:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1734621DAF;
 Fri, 18 Sep 2026 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789735830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RxOncy+vUiKozMNMDzxKWWZSIDY4WCyhLfdwudbS7cQ=;
 b=SITIQCe16u5hp3CcRB8sumy/IkZivgmyfI73IlRIb7xZ4f3mX05e5c55PU9kQbRM0quI3h
 DsMbtn3rVrdIPOKsqopGPMP2iXxvsPTuUYp3xEYov0x0aCUpAkNhb5DA1f+A8xPIQsC16I
 2LUOB83Cc9F2Odwd8bf9kj+xDB87gA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789735830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RxOncy+vUiKozMNMDzxKWWZSIDY4WCyhLfdwudbS7cQ=;
 b=xpUXN+FDKzVX/zqoJUus4U3nW/xoktUNwzmBAwpy237ceCsSCqzTQPd6tFUgITI+c3Vm87
 s4uFMcxYFGZTTtDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789735826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RxOncy+vUiKozMNMDzxKWWZSIDY4WCyhLfdwudbS7cQ=;
 b=kGp1FzLxjiTTFilKQyuOr+41zWkzRHTE2aKnGXJuxUl1KMfMdEQ7I9zc6sKB0HHv2mMuUL
 RQvOOym16UcpTxGAi/riau1RPVCoNr/MhqI4aQEtFOjsAgpoCcPEvmzJoZ5sH4dbkqq8vo
 8IuSi0Waj8d0GtyQ2+dmM6/3kLfmvlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789735826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RxOncy+vUiKozMNMDzxKWWZSIDY4WCyhLfdwudbS7cQ=;
 b=HiIo1yYUuKqHwEplqc/V4UCsilJsKBZ0FHnYjoWq83FjIRi1A/eCLJa+eY47DPlOOfMH/U
 +8Xgt5YWf8rSliBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A13EA133CF;
 Fri, 18 Sep 2026 12:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ezKRG5EzrWr4FAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 18 Sep 2026 12:50:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 18 Sep 2026 14:50:19 +0200
Message-ID: <20260918125021.1939455-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.993];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] shmctl03 fix on 32bit compat mode
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

Hi all,

this is yet another attempt to fix shmctl03 on 32 bit compat mode,
alternative to Wei's suggestion [1]. We should merge one of these.

Code suggested by Andrea, I turn it into 2 commits.
Based on the fact that general code was needed only for shmctl03, adding
extra enums is probably not worth.

Kind regards,
Petr

[1] https://patchwork.kernel.org/project/ltp/list/?series=1156943&state=*

Andrea Cervesato (2):
  tst_assert: Use 'long long' to fix 32bit compat mode truncation
  shmctl03: Fix shmmax clamped to INT_MAX in 32bit compat mode

 lib/tst_assert.c                            | 9 +++++----
 testcases/kernel/syscalls/shmctl/shmctl03.c | 6 +++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
