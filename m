Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214D7C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 07:12:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF7CD3D1C2C
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:12:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC53B3C60BA
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 09:11:48 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 41B4B14088D7
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 09:11:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B1BA1F74B;
 Wed, 24 Jul 2024 07:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721805105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=R+eYQlhxQJ4MumI78mrzJFHfZMgzlQVdRklQyyVxr3M=;
 b=MetFhbBllnSAdnPd2dAJFYtVz2e2tfcxLRYZX5Lu5+xqpIKkPrBonJOx92OmMzuIkKVKuw
 q9Uf1D68r3nDWrjfykuf0mfG0m+r/colfOGnYmhSoqVBAXdb3b0ZQL/V2pOz5+t9yNS3I8
 5YHTLhx1lEijz06caEfOqP8DNtHdDw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721805105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=R+eYQlhxQJ4MumI78mrzJFHfZMgzlQVdRklQyyVxr3M=;
 b=RGaXRv7TXbifRmIsoTbVweksKJEOpRvfgsSrTUX4TQJ/dGhyT3AV5+HO5FsM/NTcb6ezXH
 vaAdfVlUyi1K+ZBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MetFhbBl;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RGaXRv7T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721805105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=R+eYQlhxQJ4MumI78mrzJFHfZMgzlQVdRklQyyVxr3M=;
 b=MetFhbBllnSAdnPd2dAJFYtVz2e2tfcxLRYZX5Lu5+xqpIKkPrBonJOx92OmMzuIkKVKuw
 q9Uf1D68r3nDWrjfykuf0mfG0m+r/colfOGnYmhSoqVBAXdb3b0ZQL/V2pOz5+t9yNS3I8
 5YHTLhx1lEijz06caEfOqP8DNtHdDw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721805105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=R+eYQlhxQJ4MumI78mrzJFHfZMgzlQVdRklQyyVxr3M=;
 b=RGaXRv7TXbifRmIsoTbVweksKJEOpRvfgsSrTUX4TQJ/dGhyT3AV5+HO5FsM/NTcb6ezXH
 vaAdfVlUyi1K+ZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2DC31324F;
 Wed, 24 Jul 2024 07:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4L60ODCpoGbdMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jul 2024 07:11:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jul 2024 09:11:22 +0200
Message-ID: <20240724071123.923397-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.19 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 4B1BA1F74B
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_tmpdir: Print used temporary dir and its
 filesystem
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

It helps debugging to know used filesystem (and in case of
.all_filesystems the underlying filesystem).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_tmpdir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 1fb1bd698e..dd817c9cc2 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -312,6 +312,9 @@ void tst_tmpdir(void)
 
 		tst_exit();
 	}
+
+	tst_resm(TINFO, "Using %s as tmpdir (%s filesystem)", TESTDIR,
+			 tst_fs_type_name(tst_fs_type(NULL, TESTDIR)));
 }
 
 void tst_rmdir(void)
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
