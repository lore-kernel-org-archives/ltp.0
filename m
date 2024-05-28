Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EA2C25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 12:49:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C1013D0540
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 14:49:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37F5E3D03A7
 for <ltp@lists.linux.it>; Tue, 28 May 2024 14:48:55 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3CCDB1400B92
 for <ltp@lists.linux.it>; Tue, 28 May 2024 14:48:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 926B4202AA
 for <ltp@lists.linux.it>; Tue, 28 May 2024 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716900533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zDSDNbFoLbujOXjklB3r9pj9z/BJwSyzl344PpQ4X3A=;
 b=ckcFX89EwQEmgaxzmAD271iqlgk65eWlMyA7AK13F2AXgSVPc1Pu/PLkoNgo52ZN78/vYr
 Qb+kDWG5la6iNSwurR90pVjuUpJYoIb+5HQRm8ODavZVXk/2UQRu7VctTpj25uXF6ACf0F
 HvT6N8X9nup25yEZ9WjgUzS921C5f6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716900533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zDSDNbFoLbujOXjklB3r9pj9z/BJwSyzl344PpQ4X3A=;
 b=qwzf5w2QjE2DCuvEpApxcVtGsVdJRrfULmtxAnmOu2b5zwoDhDyYCT89C3oublqv5Z6xkz
 JXGNs1wZZQ2dw3BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ckcFX89E;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qwzf5w2Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716900533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zDSDNbFoLbujOXjklB3r9pj9z/BJwSyzl344PpQ4X3A=;
 b=ckcFX89EwQEmgaxzmAD271iqlgk65eWlMyA7AK13F2AXgSVPc1Pu/PLkoNgo52ZN78/vYr
 Qb+kDWG5la6iNSwurR90pVjuUpJYoIb+5HQRm8ODavZVXk/2UQRu7VctTpj25uXF6ACf0F
 HvT6N8X9nup25yEZ9WjgUzS921C5f6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716900533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zDSDNbFoLbujOXjklB3r9pj9z/BJwSyzl344PpQ4X3A=;
 b=qwzf5w2QjE2DCuvEpApxcVtGsVdJRrfULmtxAnmOu2b5zwoDhDyYCT89C3oublqv5Z6xkz
 JXGNs1wZZQ2dw3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B31413A6B
 for <ltp@lists.linux.it>; Tue, 28 May 2024 12:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nhGsIbXSVWbCcgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 28 May 2024 12:48:53 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 May 2024 14:47:55 +0200
Message-ID: <20240528124756.18977-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 926B4202AA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nfs02: Add subtest for O_DIRECT
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs02.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs02.sh b/testcases/network/nfs/nfs_stress/nfs02.sh
index b7fbbce9c..100909790 100755
--- a/testcases/network/nfs/nfs_stress/nfs02.sh
+++ b/testcases/network/nfs/nfs_stress/nfs02.sh
@@ -8,7 +8,7 @@
 #
 # Ported by: Robbie Williamson (robbiew@us.ibm.com)
 
-TST_CNT=3
+TST_CNT=4
 TST_TESTFUNC="do_test"
 LTP_DATAFILES="$LTPROOT/testcases/bin/datafiles"
 
@@ -46,5 +46,18 @@ do_test3()
 	tst_res TPASS "test3 passed"
 }
 
+do_test4()
+{
+	tst_res TINFO "do_test4, copy data in direct mode"
+	ROD dd oflag=direct if="$LTP_DATAFILES/ascii.jmb" of=ascii2.jmb
+	echo 3 >/proc/sys/vm/drop_caches
+	ROD dd iflag=direct if=ascii2.jmb of="$TST_TMPDIR/ascii2.jmb"
+	echo 3 >/proc/sys/vm/drop_caches
+	tst_res TINFO "compare both ascii.jmbs"
+	ROD diff "$LTP_DATAFILES/ascii.jmb" ascii2.jmb
+	ROD diff "$LTP_DATAFILES/ascii.jmb" "$TST_TMPDIR/ascii2.jmb"
+	tst_res TPASS "test4 passed"
+}
+
 . nfs_lib.sh
 tst_run
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
