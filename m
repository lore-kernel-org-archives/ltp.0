Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A408BC3DA79
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 12:53:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CA1D3CE355
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 13:53:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 230E13CCC5B
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 13:53:24 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8338860054F
 for <ltp@lists.linux.it>; Mon, 15 Jan 2024 13:53:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 88E6B221BC;
 Mon, 15 Jan 2024 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705323203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ayrAX0HYn2gL3pggmG349CsZI8AZfwKqf4zfhoHjya4=;
 b=I67Sf4IiaL0cZgO8X8nftrUrli6rafiFucNVrWwlVtNd0vRZPHR1qE5Aw0ptgHLPMfZqe8
 SWSWWwtXOpuiZx6tAUB08L8fa0wb3cKoYNLwnIEAp2mDYDfNmwkKEa7IRVRJ0oC/FRgVyY
 et3oxYiUPHc8WE520w8v8ttPMS5/v9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705323203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ayrAX0HYn2gL3pggmG349CsZI8AZfwKqf4zfhoHjya4=;
 b=4qpxphe4IrsEuqgKSdKwxvA2+dMs0wy6ho8aSYO84IOS/55agQ0snHwlfI7ZZIvRkkhldB
 caPjTUW0E2wT5DAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705323203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ayrAX0HYn2gL3pggmG349CsZI8AZfwKqf4zfhoHjya4=;
 b=I67Sf4IiaL0cZgO8X8nftrUrli6rafiFucNVrWwlVtNd0vRZPHR1qE5Aw0ptgHLPMfZqe8
 SWSWWwtXOpuiZx6tAUB08L8fa0wb3cKoYNLwnIEAp2mDYDfNmwkKEa7IRVRJ0oC/FRgVyY
 et3oxYiUPHc8WE520w8v8ttPMS5/v9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705323203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ayrAX0HYn2gL3pggmG349CsZI8AZfwKqf4zfhoHjya4=;
 b=4qpxphe4IrsEuqgKSdKwxvA2+dMs0wy6ho8aSYO84IOS/55agQ0snHwlfI7ZZIvRkkhldB
 caPjTUW0E2wT5DAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A72513751;
 Mon, 15 Jan 2024 12:53:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 30beHMMqpWWNVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jan 2024 12:53:23 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 15 Jan 2024 13:53:47 +0100
Message-ID: <20240115125351.7266-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] Add tst_fd iterator API
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Changes in v3:
  - Made use of newly introduced API to specify an array of possible errors

    Jan and Amir please check if the error sets are not missing anything

  - Fixed a few minor problems as pointed out by Peter

Changes in v2:

 - Changed the API into iterator rather than a funciton callback
 - Added a lot more fd types
 - Added splice test

Cyril Hrubis (4):
  lib: Add tst_fd iterator
  syscalls: readahead01: Make use of tst_fd
  syscalls: accept: Add tst_fd test
  syscalls: splice07: New splice tst_fd iterator test

 include/tst_fd.h                              |  61 ++++
 include/tst_test.h                            |   1 +
 lib/tst_fd.c                                  | 325 ++++++++++++++++++
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/accept/.gitignore   |   1 +
 testcases/kernel/syscalls/accept/accept01.c   |   8 -
 testcases/kernel/syscalls/accept/accept03.c   |  60 ++++
 .../kernel/syscalls/readahead/readahead01.c   |  52 +--
 testcases/kernel/syscalls/splice/.gitignore   |   1 +
 testcases/kernel/syscalls/splice/splice07.c   |  70 ++++
 10 files changed, 548 insertions(+), 33 deletions(-)
 create mode 100644 include/tst_fd.h
 create mode 100644 lib/tst_fd.c
 create mode 100644 testcases/kernel/syscalls/accept/accept03.c
 create mode 100644 testcases/kernel/syscalls/splice/splice07.c

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
