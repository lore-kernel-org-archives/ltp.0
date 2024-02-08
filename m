Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4646C4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 08:59:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 008933CF542
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 09:59:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 221073CC4B5
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 09:59:39 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 378EC60672E
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 09:59:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE1131FD7E;
 Thu,  8 Feb 2024 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707382778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Co8z6JE/LJJhpPToeR20NfKEzRi0qJ1J7JET05pkx24=;
 b=M+q9wSFrRnY2ZKPUZ9Q8bMWDJvRp2W8LIFpD1SSeTi2NTD7jJg3vu/uPA8wfuj2SEcx4xD
 T4GHvF7rDCervpFbkha+SC6D4j/P2EpURKyezjZCenUZrXIX9x4sWqSq8LDzxLLxqXVLeo
 iwvQYXUBHa1yzR72gFows13rsINhkX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707382778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Co8z6JE/LJJhpPToeR20NfKEzRi0qJ1J7JET05pkx24=;
 b=8aLPUR/TllFPGF5xlfthU3MfkVl1QpJIXVGu7lFxdI5YOmEF2JNUmuLeIo0buBUGKf2EZb
 3wUi1yL/V7jAsTBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707382777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Co8z6JE/LJJhpPToeR20NfKEzRi0qJ1J7JET05pkx24=;
 b=Qa2fAXLJErWtQU5cqIadFwNYHDIDb19jWxEywXk6jB0XTsIGFbQTgfTIDAD3aaKHQ3cUEe
 +i6bMH0vHDsusXEAjz4vSqWU4dboT82b6x+t/MAxt+fQsAEccj0q2Qggmilr98BTm6nqqu
 HxCzHWRu2cPfuM6iJvuJBZDVLxQJg38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707382777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Co8z6JE/LJJhpPToeR20NfKEzRi0qJ1J7JET05pkx24=;
 b=PJSyggXtbVDYuwohRE5k2xB7ZO1secxePkPyzc4JZnTjWgcDSBJBOPB1EA+/RkBg6gUhWj
 GsE7iGdXzxGfKnAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C189413984;
 Thu,  8 Feb 2024 08:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JvtfLfmXxGUoDgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Feb 2024 08:59:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  8 Feb 2024 09:59:26 +0100
Message-ID: <20240208085932.182167-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Qa2fAXLJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PJSyggXt
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.18)[-0.883];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[27.82%]
X-Rspamd-Queue-Id: DE1131FD7E
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] Remove obsolete network userspace tests
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel (4):
  network: Remove host01.sh
  network: remove xinetd_tests.sh
  network: Remove telnet01.sh test
  network: Remove clockdiff01.sh test

 runtest/net.tcp_cmds                          |   4 -
 testcases/network/tcp_cmds/clockdiff/Makefile |  10 --
 .../network/tcp_cmds/clockdiff/clockdiff01.sh |  30 -----
 testcases/network/tcp_cmds/host/Makefile      |  11 --
 testcases/network/tcp_cmds/host/host01.sh     |  34 ------
 testcases/network/tcp_cmds/telnet/Makefile    |  29 -----
 testcases/network/tcp_cmds/telnet/telnet01.sh |  96 ---------------
 testcases/network/xinetd/Makefile             |  11 --
 testcases/network/xinetd/xinetd_tests.sh      | 113 ------------------
 9 files changed, 338 deletions(-)
 delete mode 100644 testcases/network/tcp_cmds/clockdiff/Makefile
 delete mode 100755 testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
 delete mode 100644 testcases/network/tcp_cmds/host/Makefile
 delete mode 100755 testcases/network/tcp_cmds/host/host01.sh
 delete mode 100644 testcases/network/tcp_cmds/telnet/Makefile
 delete mode 100755 testcases/network/tcp_cmds/telnet/telnet01.sh
 delete mode 100644 testcases/network/xinetd/Makefile
 delete mode 100755 testcases/network/xinetd/xinetd_tests.sh

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
