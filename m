Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB55DCA0EFC
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 11:39:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1E063D284E
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 13:39:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 379683CE3C5
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 13:39:26 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6AA7B600D4E
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 13:39:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 622CD1F7C9;
 Fri, 30 Aug 2024 11:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725017963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hofe3rMZPu9m66PysvJ15qIFJeOcQrHzkUzj7VTlDt8=;
 b=if/Ryv2V2iUjWGnWhF+WfcXyJV4rwGm8QDyR/l/jmupF35BKgB3EIRXupD1CF4JeW4nRPE
 oe4+PeRFF9c8t7uQ/ygwrTEWGRwhanRXsptHEsDuKeZgDTmkp9lVkvNe6B9GFjaIgFsOeE
 g4ekX1HlOjWVgfvHpqdfUN/HOY7TjOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725017963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hofe3rMZPu9m66PysvJ15qIFJeOcQrHzkUzj7VTlDt8=;
 b=4S12aLAKRX3+9dzMkHtd/Sq1MgjHlW0TNUTV4t5QgTzWbFsT/ort/4D2Rtv1HqGi121X0J
 lHrM/6RvIC07V2Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="if/Ryv2V";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4S12aLAK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725017963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hofe3rMZPu9m66PysvJ15qIFJeOcQrHzkUzj7VTlDt8=;
 b=if/Ryv2V2iUjWGnWhF+WfcXyJV4rwGm8QDyR/l/jmupF35BKgB3EIRXupD1CF4JeW4nRPE
 oe4+PeRFF9c8t7uQ/ygwrTEWGRwhanRXsptHEsDuKeZgDTmkp9lVkvNe6B9GFjaIgFsOeE
 g4ekX1HlOjWVgfvHpqdfUN/HOY7TjOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725017963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hofe3rMZPu9m66PysvJ15qIFJeOcQrHzkUzj7VTlDt8=;
 b=4S12aLAKRX3+9dzMkHtd/Sq1MgjHlW0TNUTV4t5QgTzWbFsT/ort/4D2Rtv1HqGi121X0J
 lHrM/6RvIC07V2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A97AF13A44;
 Fri, 30 Aug 2024 11:39:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3PMbKGqv0WZ7MwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Aug 2024 11:39:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 30 Aug 2024 13:39:13 +0200
Message-ID: <20240830113913.49675-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 622CD1F7C9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:dkim, suse.cz:mid,
 suse.cz:email, imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] isofs.sh: Use nobody user
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
This should replace
https://patchwork.ozlabs.org/project/ltp/patch/20240829065933.21902-1-wegao@suse.com/

 testcases/kernel/fs/iso9660/isofs.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index d1a362d979..d849a9acbf 100755
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
+	[ "$TEST_USER" ] || TEST_GROUP="$TEST_USER"
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
