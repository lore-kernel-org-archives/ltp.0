Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B3AD3B98C
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 18:57:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68DD83D0326
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 19:56:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EFCE3D0323
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 19:56:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C017C60022B
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 19:56:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FEEA337D2;
 Tue,  9 Dec 2025 18:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765306562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UbIiy/SdTMvK5EYrsBSznOLZxuEtmtnvL1HuRjCemA4=;
 b=RM+k6U33UoH+miMtU+D+5q8EoqLQyICXbk7XQLQKf6YwYBc59fqyrjcmxGl9W4VwtCj1rs
 6VmXViOWF5NLTR30/jBS/jRzICCNFiL0iaiQF/tbg92TmP26he1ODshT0Rgs0wQGu5T/fW
 tCvR4LXabI3FbzvZqVpw1cSYmnK2+sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765306562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UbIiy/SdTMvK5EYrsBSznOLZxuEtmtnvL1HuRjCemA4=;
 b=++IE5Z/kpM+kPlUt+CuS51aXKTZURVbeWF5M7mVw4LKmXQDiidocDW2LAHESYuxd3MGAEx
 UuxWQ5YfS5wLDdBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="S/G0eneY";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4Iu5UMnX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765306561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UbIiy/SdTMvK5EYrsBSznOLZxuEtmtnvL1HuRjCemA4=;
 b=S/G0eneYRlsZvvanOlTaPD1hVxYkgttp1uz++bSxphbRl9W4FVftOFbpPFmJFEzZNOEbzQ
 yfWN/Cr0Sty+a6qZs/+eDQyhzMxA70mvThshKJOhdC920yDcaoYJYE0AYU+W48W9QHOaEl
 5nU/8ZiF5Ehgf10candKv7Qnhg2fWIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765306561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UbIiy/SdTMvK5EYrsBSznOLZxuEtmtnvL1HuRjCemA4=;
 b=4Iu5UMnXR/o4nd7p8x6zgX8GUiYuGylsSZVrdxDriZLmCImThLyAedt+1PQOhOLchZLt7i
 qiMHasShqEpISSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09BDA3EA63;
 Tue,  9 Dec 2025 18:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gavLAMFwOGnSSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 18:56:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  9 Dec 2025 19:55:53 +0100
Message-ID: <20251209185557.20598-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5FEEA337D2
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[8];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/4] tst_runas.c, ima_{conditionals,
 measurements}.sh enhancements
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

v3->v4:
Rename tst_sudo.c => tst_runas.c (Li, Cyril)

Link to v3:
https://lore.kernel.org/ltp/20251127082638.224110-1-pvorel@suse.cz/T/#t
https://patchwork.ozlabs.org/project/ltp/list/?series=483681&state=*

Kind regards,
Petr

Petr Vorel (4):
  shell: Add tst_runas.c helper
  tst_test.sh: Add TST_USR_{G,U}ID variables
  ima_{conditionals,measurements}.sh: Use tst_runas
  ima_conditionals.sh: Split test by request

 doc/users/setup_tests.rst                     |  4 +
 runtest/ima                                   |  5 +-
 .../integrity/ima/tests/ima_conditionals.sh   | 78 +++++++++++--------
 .../integrity/ima/tests/ima_measurements.sh   | 11 +--
 testcases/lib/.gitignore                      |  1 +
 testcases/lib/Makefile                        |  2 +-
 testcases/lib/tst_runas.c                     | 51 ++++++++++++
 testcases/lib/tst_test.sh                     |  6 +-
 8 files changed, 115 insertions(+), 43 deletions(-)
 create mode 100644 testcases/lib/tst_runas.c

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
