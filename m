Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B6FC5478C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 15:07:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA2373CEB9C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 16:07:28 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 053543CE0C2
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 16:07:12 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 40E80601BAF
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 16:07:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC77276561;
 Mon,  4 Mar 2024 15:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709564831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Mj/2NSyMyYl3C4z80dJcL+HNZmnyBxu0Ny3Az0COaxI=;
 b=kNWSYmcaJck0TBuHvH2/IsozTSelF1VHG7DrQ+8RKLgzSD6YjrPGLf2ch9/FTWfLXAQZWB
 a2XAYVYEhtxDAi5n031lc1VdRAmX3OvifBq6N86o83ltrB8yKnse5BQ2LLe9tN2VzdkJnT
 +h6Stj1SAkaLTby7F06Gkc2YHGy3AOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709564831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Mj/2NSyMyYl3C4z80dJcL+HNZmnyBxu0Ny3Az0COaxI=;
 b=fotUYyp8A6GNGuYFVz9bNdClIMyxB3AhHFHRLRAwMmaFkGmEva+l52fYy+4kSiM2lNcKAp
 YyoQBgbR4UpljrDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709564830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Mj/2NSyMyYl3C4z80dJcL+HNZmnyBxu0Ny3Az0COaxI=;
 b=iwn7GkewraDyVSF++JHQAEKsLbzf9r2PThr4STpi7HdceGrwKju/lTfNrU9CyRHSZ90yPv
 hB58hlrdwjm5BBrncIPvBYX0O+xU8amtfakZzB2ykw+1VPx+2YkN3RLbkDNFypttRLo5lf
 HHYUDouxBJ+7f3aV54TAKdpj+J8xzNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709564830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Mj/2NSyMyYl3C4z80dJcL+HNZmnyBxu0Ny3Az0COaxI=;
 b=PdXkVyfnzSxbuM7tV8PxUvn6AZgtXgrhtjvFlrVcLDByZRHHf9ndEu0r7JvC3unvkcSOOt
 Vkbcl/atatdo32AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FE5613A5B;
 Mon,  4 Mar 2024 15:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RSqtH57j5WX5YwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Mar 2024 15:07:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon,  4 Mar 2024 16:07:07 +0100
Message-Id: <20240304150709.30260-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iwn7Gkew;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PdXkVyfn
X-Spamd-Result: default: False [4.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[42.96%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CC77276561
X-Spamd-Bar: ++++
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] SysV IPC bug reproducer
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

This patch series provides a bug reproducer for SysV IPC, which has been
written by Michal Hocko.
It also includes the SAFE_MPROTECT macro, useful for many other tests as well.

Andrea Cervesato (2):
  Add SAFE_MPROTECT() macro
  Add shmat04 SysV IPC bug reproducer

 include/tst_safe_macros.h                     |   5 +
 lib/safe_macros.c                             |  40 +++++++
 runtest/syscalls                              |   1 +
 runtest/syscalls-ipc                          |   1 +
 .../kernel/syscalls/ipc/shmat/.gitignore      |   1 +
 testcases/kernel/syscalls/ipc/shmat/shmat04.c | 112 ++++++++++++++++++
 6 files changed, 160 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat04.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
