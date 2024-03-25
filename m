Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C35AC54E58
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 11:50:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 501BF3CFEC9
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 12:50:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45C1B3CFB55
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 12:50:42 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A98F7200C61
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 12:50:41 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8FD85C617;
 Mon, 25 Mar 2024 11:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711367440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=V8mXk3/NMnTofdc5yjVdIGeUA4rEG1BagPdxzjdLjlo=;
 b=jIXkLtPRm8rwvQ95j6ItmVdR/R4+Q5/3EgtVPQiEkfKv4t+fJvICk0RB4/OII4dJYssYbd
 Ih0ZThi4c5UlVM3pQbBHEcB7JOUCVSPBBJPwI3VuUkDvCvg7lrhY5Md1ua94A0J9PEgS+A
 DUdpzhbuBXaVzM947aj3v8SdrrneY/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711367440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=V8mXk3/NMnTofdc5yjVdIGeUA4rEG1BagPdxzjdLjlo=;
 b=285Tv8D82j/gtiYnaUDKe/qU7OUIwttj/tGTx7W6vxHBmUQMdSjs9gPWQVAB6KOKCIE1zW
 8X6sDPJrqQHbIrCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711367440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=V8mXk3/NMnTofdc5yjVdIGeUA4rEG1BagPdxzjdLjlo=;
 b=jIXkLtPRm8rwvQ95j6ItmVdR/R4+Q5/3EgtVPQiEkfKv4t+fJvICk0RB4/OII4dJYssYbd
 Ih0ZThi4c5UlVM3pQbBHEcB7JOUCVSPBBJPwI3VuUkDvCvg7lrhY5Md1ua94A0J9PEgS+A
 DUdpzhbuBXaVzM947aj3v8SdrrneY/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711367440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=V8mXk3/NMnTofdc5yjVdIGeUA4rEG1BagPdxzjdLjlo=;
 b=285Tv8D82j/gtiYnaUDKe/qU7OUIwttj/tGTx7W6vxHBmUQMdSjs9gPWQVAB6KOKCIE1zW
 8X6sDPJrqQHbIrCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9879613A2E;
 Mon, 25 Mar 2024 11:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 9cwPJBBlAWZSCQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 25 Mar 2024 11:50:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Mar 2024 12:50:31 +0100
Message-ID: <20240325115034.643892-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [3.70 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[16.30%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Remove double or trailing slashes in TMPDIR in
 C API
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

Changes v1->v2:
* Change algorithm in lib/tst_tmpdir.c (different than the suggested one
  by Cyril in v1).
* Remove warnings about wrong TMPDIR.

Petr Vorel (3):
  lib/tst_tmpdir: Normalize user defined TMPDIR
  lib: Add test for tst_tmpdir
  lib: Improve doc related to $TMPDIR default value

 include/tst_defaults.h        |  3 ++-
 lib/newlib_tests/runtest.sh   |  2 +-
 lib/newlib_tests/tst_tmpdir.c | 49 +++++++++++++++++++++++++++++++++++
 lib/tst_tmpdir.c              | 20 ++++++++++++--
 testcases/lib/tst_test.sh     |  2 ++
 5 files changed, 72 insertions(+), 4 deletions(-)
 create mode 100644 lib/newlib_tests/tst_tmpdir.c

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
