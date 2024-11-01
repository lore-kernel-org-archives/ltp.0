Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12F7E6B278
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 14:12:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81F183CD788
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 15:12:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9E4D3CD6B2
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 15:11:31 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 165911BBCF19
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 15:11:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E9D21FECE
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730470289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0l1ai+80MSVkCbX/Fe6QjfKxPg8RSEOmU8exbAx9Dm4=;
 b=ily0q7+NdSEUUY1XunpwYdxXFw/CNHZS61hZ2f+VAuCuAfgEEqPOYfvhWe42JmgPku4Omu
 YCyW+Z6Cr5KBxKA+jPyHVhSuONfg8uKs+GIX16NQvKjsQsyXv3PvtjT/loiChRscFFM/wR
 xXjMmqVYdPVXrXBBPdI6QcjmCTqVDnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730470289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0l1ai+80MSVkCbX/Fe6QjfKxPg8RSEOmU8exbAx9Dm4=;
 b=yaZjXBXrQiEN4KMYD2enea6YgWvEybC+Sdmk0qKEoSJqpiunKMHU96twZZwqLuEkbIr+g6
 o3ohAikXnX0KHEAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ily0q7+N;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yaZjXBXr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730470289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0l1ai+80MSVkCbX/Fe6QjfKxPg8RSEOmU8exbAx9Dm4=;
 b=ily0q7+NdSEUUY1XunpwYdxXFw/CNHZS61hZ2f+VAuCuAfgEEqPOYfvhWe42JmgPku4Omu
 YCyW+Z6Cr5KBxKA+jPyHVhSuONfg8uKs+GIX16NQvKjsQsyXv3PvtjT/loiChRscFFM/wR
 xXjMmqVYdPVXrXBBPdI6QcjmCTqVDnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730470289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0l1ai+80MSVkCbX/Fe6QjfKxPg8RSEOmU8exbAx9Dm4=;
 b=yaZjXBXrQiEN4KMYD2enea6YgWvEybC+Sdmk0qKEoSJqpiunKMHU96twZZwqLuEkbIr+g6
 o3ohAikXnX0KHEAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93D0413B1D
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 14:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sMLhI5HhJGf1BAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 01 Nov 2024 14:11:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Nov 2024 15:11:09 +0100
Message-ID: <20241101141111.104803-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241101141111.104803-1-mdoucha@suse.cz>
References: <20241101141111.104803-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9E9D21FECE
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] Add support for setting loop device size in shell
 tests
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

Add TST_DEVICE_SIZE variable to set loop device size.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 doc/developers/writing_tests.rst | 2 +-
 testcases/lib/tst_test.sh        | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 2293800a1..ab633121e 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -390,7 +390,7 @@ LTP C And Shell Test API Comparison
       - TST_FS_TYPE
 
     * - .dev_min_size
-      - not applicable
+      - TST_DEVICE_SIZE
 
     * - .format_device
       - TST_FORMAT_DEVICE
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c19c30b76..cfdae0230 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -687,6 +687,7 @@ tst_run()
 			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
 			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
 			SKIP_FILESYSTEMS|SKIP_IN_LOCKDOWN|SKIP_IN_SECUREBOOT);;
+			DEVICE_SIZE);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
@@ -750,7 +751,7 @@ tst_run()
 
 	# needs to be after cd $TST_TMPDIR to keep test_dev.img under $TST_TMPDIR
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
-		TST_DEVICE=$(tst_device acquire)
+		TST_DEVICE=$(tst_device acquire $TST_DEVICE_SIZE)
 
 		if [ ! -b "$TST_DEVICE" -o $? -ne 0 ]; then
 			unset TST_DEVICE
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
