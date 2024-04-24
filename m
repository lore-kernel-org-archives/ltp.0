Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9D2C4345F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 14:18:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A91A3D004C
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 16:18:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92BA33CFF34
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 16:17:57 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C9E4010008F4
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 16:17:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 16CEC66EAA;
 Wed, 24 Apr 2024 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713968275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SthDSEFVfk1n35XiVC0KgV4B5GBmi2oIiNh4HqaXRck=;
 b=YG6DtkLDAPoT26tr9vdyrnIEpLgfXkAuu9uTXaj5EU5yYWp6gjzvKRvr41jwxJT0cu9cvv
 pwUljYQt62+O+xW+Q6xI6Kug7XTfigcT/xSjMef5YCVhwOVIWmVBElMOKmFjDPjcLsUV3c
 Y8YzBDVlPZ2YDwSyb4NmNre5/SGKY4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713968275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SthDSEFVfk1n35XiVC0KgV4B5GBmi2oIiNh4HqaXRck=;
 b=8QYJLz6+2pMyAGOaANKecIMB6+c2zdDiGPFgagmS47AsXb47SfORP3jfnn8OOC/kLSljGz
 /L0VQsPgB2sAuDDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YG6DtkLD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8QYJLz6+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713968275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SthDSEFVfk1n35XiVC0KgV4B5GBmi2oIiNh4HqaXRck=;
 b=YG6DtkLDAPoT26tr9vdyrnIEpLgfXkAuu9uTXaj5EU5yYWp6gjzvKRvr41jwxJT0cu9cvv
 pwUljYQt62+O+xW+Q6xI6Kug7XTfigcT/xSjMef5YCVhwOVIWmVBElMOKmFjDPjcLsUV3c
 Y8YzBDVlPZ2YDwSyb4NmNre5/SGKY4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713968275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SthDSEFVfk1n35XiVC0KgV4B5GBmi2oIiNh4HqaXRck=;
 b=8QYJLz6+2pMyAGOaANKecIMB6+c2zdDiGPFgagmS47AsXb47SfORP3jfnn8OOC/kLSljGz
 /L0VQsPgB2sAuDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBBA81393C;
 Wed, 24 Apr 2024 14:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9VHaNJIUKWZ9EgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Apr 2024 14:17:54 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Apr 2024 16:17:49 +0200
Message-ID: <20240424141751.247015-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 16CEC66EAA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Build fixes
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

changes v1->v2:
* include/lapi/fs.h: Add #include <unistd.h>, more comments.
* unlink09.c: replace _GNU_SOURCE with switched lapi/fs.h and tst_test.h
  includes.

Tested:
https://github.com/pevik/ltp/actions/runs/8817947494

Petr Vorel (2):
  lapi/fs: Include lapi/fcntl.h + define _GNU_SOURCE
  lapi: getrandom05: Add getrandom() fallback

 configure.ac                                      |  1 +
 include/lapi/fs.h                                 | 10 +++++++++-
 include/lapi/getrandom.h                          | 15 +++++++++++++--
 testcases/kernel/syscalls/getrandom/getrandom05.c |  3 ++-
 testcases/kernel/syscalls/unlink/unlink09.c       |  2 +-
 5 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
