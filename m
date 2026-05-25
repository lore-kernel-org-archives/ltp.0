Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412BDCD5BC9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 15:15:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28A1C3E62D7
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 17:15:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F70A3E1169
 for <ltp@lists.linux.it>; Mon, 25 May 2026 17:15:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DD7B0600704
 for <ltp@lists.linux.it>; Mon, 25 May 2026 17:15:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 173F46AA0C
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779722101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fSKZ2JFTYoeyqMxenFo+NTZ5FVCyuhP+Sbp9G/FRsEY=;
 b=X/h5dV7LW61rqSPLOUXxGpXE7KpxMpF7ac/2kDzSRpnEsS+sfWpw359rpq9mIsHiLh6f2g
 xLJ0soeVOV5+ZAxUUxbS5N/eS62CKwaWxbDiGUq1Rt+9JT7OZnhTVZscVEUB05M3FtbNIT
 9yNv5neKD8RXZf2zkYXeR/qHiEus1Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779722101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fSKZ2JFTYoeyqMxenFo+NTZ5FVCyuhP+Sbp9G/FRsEY=;
 b=04aLWQqRiPvSTqiEsZx/bV/5SAykgMliH9DjZHJIcc9YY2n5sebojbvg8QLx45RhzNUEul
 kRBkX4QTmVNXqpDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="X/h5dV7L";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=04aLWQqR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779722101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fSKZ2JFTYoeyqMxenFo+NTZ5FVCyuhP+Sbp9G/FRsEY=;
 b=X/h5dV7LW61rqSPLOUXxGpXE7KpxMpF7ac/2kDzSRpnEsS+sfWpw359rpq9mIsHiLh6f2g
 xLJ0soeVOV5+ZAxUUxbS5N/eS62CKwaWxbDiGUq1Rt+9JT7OZnhTVZscVEUB05M3FtbNIT
 9yNv5neKD8RXZf2zkYXeR/qHiEus1Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779722101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fSKZ2JFTYoeyqMxenFo+NTZ5FVCyuhP+Sbp9G/FRsEY=;
 b=04aLWQqRiPvSTqiEsZx/bV/5SAykgMliH9DjZHJIcc9YY2n5sebojbvg8QLx45RhzNUEul
 kRBkX4QTmVNXqpDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC7CF59CE6
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:15:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PU+rOHRnFGo4YAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:15:00 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 17:14:47 +0200
Message-ID: <20260525151449.203586-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 173F46AA0C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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

Cyril Hrubis (2):
  safe_macros: Add SAFE_READ_ANY_EAGAIN
  syscalls/inotify{07,08}: Fix TBROK on older kernels

 include/safe_macros_fn.h                      | 10 ++++++++++
 lib/safe_macros.c                             |  5 ++++-
 testcases/kernel/syscalls/inotify/inotify07.c |  2 +-
 testcases/kernel/syscalls/inotify/inotify08.c |  2 +-
 4 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
