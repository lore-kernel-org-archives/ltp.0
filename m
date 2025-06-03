Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BF1C5AD49
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 14:13:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E1C73CA058
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 16:13:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72CA53C9F5D
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 16:13:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EEFB41A0146C
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 16:13:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A20C219BA
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748960003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SMYdntBF+0g+7W96DBdrer60l/3/wX+BkUD9oh+6cdQ=;
 b=kRhJMztaFzfBZX3z5ajmS+qvAT59ffynLdjunZe+hQuzuAMwenPUveYiKtOczfPmUyqXlg
 bTJOZNMZU1VaVeLY1Nh/dJkwRrceveC8F0/40b5AfUuL1gWy84100j3tqb2aguGO0FwgEg
 ii0HiaHlEmCkiv/oFAcqAlTpfuStFMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748960003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SMYdntBF+0g+7W96DBdrer60l/3/wX+BkUD9oh+6cdQ=;
 b=ifLbvU04VH6jYk4rV3a6+qNuS8Bnacr3sRsPUphY+z3bIsDmiG/RxqwP3nBQ87aS+NFSrZ
 Tztjq1mFwocK1iAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748960003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SMYdntBF+0g+7W96DBdrer60l/3/wX+BkUD9oh+6cdQ=;
 b=kRhJMztaFzfBZX3z5ajmS+qvAT59ffynLdjunZe+hQuzuAMwenPUveYiKtOczfPmUyqXlg
 bTJOZNMZU1VaVeLY1Nh/dJkwRrceveC8F0/40b5AfUuL1gWy84100j3tqb2aguGO0FwgEg
 ii0HiaHlEmCkiv/oFAcqAlTpfuStFMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748960003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SMYdntBF+0g+7W96DBdrer60l/3/wX+BkUD9oh+6cdQ=;
 b=ifLbvU04VH6jYk4rV3a6+qNuS8Bnacr3sRsPUphY+z3bIsDmiG/RxqwP3nBQ87aS+NFSrZ
 Tztjq1mFwocK1iAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12C1913A92
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 14:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FxNYBAMDP2htHgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 14:13:23 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Jun 2025 16:13:15 +0200
Message-ID: <20250603141320.161026-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] epoll_pwait2() timeout regression test
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

There seems to be a regression in kernel v6.14 where epoll_pwait2()
interprets very small timeout values (~1000ns) as infinity and waits
for events forever. This patchset adds regression test for this bug
and a necessary refactor for do_epoll_pwait() to allow high precision
timeouts.

Martin Doucha (2):
  epoll_pwait: Refactor timeout to struct timespec
  Add regression test for epoll_pwait2() timeout

 runtest/syscalls                              |  1 +
 .../kernel/syscalls/epoll_pwait/.gitignore    |  1 +
 .../syscalls/epoll_pwait/epoll_pwait01.c      |  4 +-
 .../syscalls/epoll_pwait/epoll_pwait02.c      |  2 +-
 .../syscalls/epoll_pwait/epoll_pwait03.c      |  9 +-
 .../syscalls/epoll_pwait/epoll_pwait04.c      |  2 +-
 .../syscalls/epoll_pwait/epoll_pwait06.c      | 86 +++++++++++++++++++
 .../syscalls/epoll_pwait/epoll_pwait_var.h    | 22 ++---
 8 files changed, 109 insertions(+), 18 deletions(-)
 create mode 100644 testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c

-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
