Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58519CD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 06:28:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA6533C31E0
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 08:28:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A86693C3048
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 08:27:43 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 036671A00146
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 08:27:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 43DA41FB97;
 Mon,  2 Sep 2024 06:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725258461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W32hvrqHZhIGNWQVQIPMfQR3REUWNAACR2W7GtP2Oig=;
 b=fhNLdqijOIF45JfdotVkulZn/eAzARwySGLgIzwkArZ37Z9WGteNsi0WPLCnkEjwc3S9Po
 M7oi6fI1z8vLoLBtmqStjI+5xBKICyDKl0Cld896UkZFhrwJ/Jy0Q/KLMMwtB/DOTm5xMo
 apilYIPCowY3FMw34dYDtNFrXdB7Fc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725258461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W32hvrqHZhIGNWQVQIPMfQR3REUWNAACR2W7GtP2Oig=;
 b=vXuVzopBBi/mrHzWH3vJLS9e6VOsF0uZm6MbbX/Wynn5nN76wkMZLLQuOKXOcd9JT3dIAY
 BzuZ8FiODavuY+CQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fhNLdqij;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vXuVzopB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725258461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W32hvrqHZhIGNWQVQIPMfQR3REUWNAACR2W7GtP2Oig=;
 b=fhNLdqijOIF45JfdotVkulZn/eAzARwySGLgIzwkArZ37Z9WGteNsi0WPLCnkEjwc3S9Po
 M7oi6fI1z8vLoLBtmqStjI+5xBKICyDKl0Cld896UkZFhrwJ/Jy0Q/KLMMwtB/DOTm5xMo
 apilYIPCowY3FMw34dYDtNFrXdB7Fc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725258461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=W32hvrqHZhIGNWQVQIPMfQR3REUWNAACR2W7GtP2Oig=;
 b=vXuVzopBBi/mrHzWH3vJLS9e6VOsF0uZm6MbbX/Wynn5nN76wkMZLLQuOKXOcd9JT3dIAY
 BzuZ8FiODavuY+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FBD413A7C;
 Mon,  2 Sep 2024 06:27:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7sPTAd1a1WbYHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Sep 2024 06:27:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  2 Sep 2024 08:27:38 +0200
Message-ID: <20240902062738.267190-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 43DA41FB97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] isofs.sh: Use nobody user
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

From: Wei Gao <wegao@suse.com>

Some distros don't have user/group 'bin' (e.g. SUSE SLE-Micro).
Although this user/group is required and created IDcheck.sh.
(This script should be replaced in the future with library call,
but it's still supported).

Replace 'bin' user/group with 'nobody' user (more common on various
Linux distributions). Most of the distros name have 'nobody' user's
group also 'nobody', but at least Debian name it 'nogroup'. Therefore
detect this name with 'id -g -n'.

Reported-by: Wei Gao <wegao@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Correct fallback condition (thanks Wei for the report):
-	[ "$TEST_USER" ] || TEST_GROUP="$TEST_USER"
+	[ "$TEST_GROUP" ] || TEST_GROUP="$TEST_USER"

 testcases/kernel/fs/iso9660/isofs.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index d1a362d979..088e062d67 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -13,10 +13,19 @@ TST_NEEDS_CMDS="mount umount"
 TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=do_test
 TST_CNT=3
+TST_SETUP="setup"
 
 MAX_DEPTH=3
 MAX_DIRS=4
 
+TEST_USER='nobody'
+
+setup()
+{
+	TEST_GROUP="$(id -g -n $TEST_USER)"
+	[ "$TEST_GROUP" ] || TEST_GROUP="$TEST_USER"
+}
+
 gen_fs_tree()
 {
 	local cur_path="$1"
@@ -92,8 +101,8 @@ do_test()
 			"loop,block=512,unhide" \
 			"loop,block=1024,cruft" \
 			"loop,block=2048,nocompress" \
-			"loop,check=strict,map=off,gid=bin,uid=bin" \
-			"loop,check=strict,map=acorn,gid=bin,uid=bin" \
+			"loop,check=strict,map=off,gid=$TEST_GROUP,uid=$TEST_USER" \
+			"loop,check=strict,map=acorn,gid=$TEST_GROUP,uid=$TEST_USER" \
 			"loop,check=relaxed,map=normal" \
 			"loop,block=512,unhide,session=2"
 		do
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
