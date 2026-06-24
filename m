Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F120CDB47C
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:19:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1B0F3E5335
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:19:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C1573E2E82
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B72821400445
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 90A3E71445
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wUbz9aM656VVV7AfQ4h2y++xKNH5lEvc+xpkgPdJY4=;
 b=d7V+XWwlxKUCewv6FB1oiL5W8l2Zq8iclcP7yTpMqwf3u6P17Ay0LmrsHtBhgK/MLDB2zX
 VmDSSODLOf81msqXXPnnBieCWHvpT8dMZt+i41TSLHPvIGEv5MZ4I3XcVMKCoGJQ+2ny7d
 HF2gD1Uyw7oE2SbDEUwK4aPZitV0ySQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wUbz9aM656VVV7AfQ4h2y++xKNH5lEvc+xpkgPdJY4=;
 b=KIMevFcylR4jKitdPUlMR8ZOKfx0NkUFb72XvKiQHRXXby2gw6vbwA+txSShvhrK0tAGa+
 HL+4PKdPm+p819BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OKx5WRUx;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ykJUvOHw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wUbz9aM656VVV7AfQ4h2y++xKNH5lEvc+xpkgPdJY4=;
 b=OKx5WRUxYpVClskjxwXKXkjOWU7iXIyOn0hnKySIL8zggbeHJUjIVjo99sxC0t3iBE1Zr2
 PqvEPk+ayVbTAHt9nE+9gox9JUcN4OHQcsH0JFc5P5xtYhzIDTHXMT6GRtWxdCt+a0GqkB
 gAu65P+Kyb9V9uQuexbKAYZxVyQZrYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wUbz9aM656VVV7AfQ4h2y++xKNH5lEvc+xpkgPdJY4=;
 b=ykJUvOHw1OISvUnhOrL4r8vNJmauAME14Z+lZSIU3TEUWqYAsI/3nfR8psHlzpyzH8pDkw
 gjNpp8IkfNSE7HCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F9D2779AC
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fhjvHQWhO2pGAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:01 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:49 +0200
Message-ID: <20260624091900.4107041-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624091900.4107041-1-chrubis@suse.cz>
References: <20260624091900.4107041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 90A3E71445
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 02/13] keyctl01.sh: Rewrite to the new shell library
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

No functional changes.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/keyctl/keyctl01.sh | 55 +++++++++++++++------------
 1 file changed, 30 insertions(+), 25 deletions(-)
 mode change 100644 => 100755 testcases/commands/keyctl/keyctl01.sh

diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
old mode 100644
new mode 100755
index 7b357a71e..cdbb8bf8b
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -2,22 +2,36 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Fujitsu Ltd.
 # Ported: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
 #
-# This is a regression test about potential uninitialized variable,
-# the test can crash the buggy kernel, and the bug has been fixed in:
+# ---
+# doc
 #
-#   commit 38327424b40bcebe2de92d07312c89360ac9229a
-#   Author: Dan Carpenter <dan.carpenter@oracle.com>
-#   Date:   Thu Jun 16 15:48:57 2016 +0100
+# This is a regression test for a potential uninitialized variable in
+# key_reject_and_link(). The test can crash the buggy kernel.
+# ---
 #
-#   KEYS: potential uninitialized variable
+# ---
+# env
+# {
+#  "needs_root": true,
+#  "needs_tmpdir": true,
+#  "needs_cmds": [
+#   {"cmd": "keyctl"}
+#  ],
+#  "save_restore": [
+#   ["/proc/sys/kernel/keys/root_maxbytes", null, "TCONF"]
+#  ],
+#  "tags": [
+#   ["linux-git", "38327424b40bcebe2de92d07312c89360ac9229a"],
+#   ["CVE", "2016-4470"]
+#  ]
+# }
+# ---
+
+. tst_loader.sh
 
 TST_SETUP=setup
-TST_CLEANUP=cleanup
-TST_TESTFUNC=do_test
-TST_NEEDS_ROOT=1
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="keyctl"
 
 check_keyctl()
 {
@@ -53,26 +67,18 @@ setup()
 	check_keyctl negate request2 show unlink
 
 	PATH_KEYSTAT="/proc/key-users"
-	PATH_KEYQUOTA="/proc/sys/kernel/keys/root_maxbytes"
 
-	if [ ! -f "$PATH_KEYSTAT" ] || [ ! -f "$PATH_KEYQUOTA" ]; then
-		tst_brk TCONF "'${PATH_KEYSTAT}' or '${PATH_KEYQUOTA}' \
-			does not exist"
+	if [ ! -f "$PATH_KEYSTAT" ]; then
+		tst_brk TCONF "'${PATH_KEYSTAT}' does not exist"
 	fi
 
 	ORIG_KEYSZ=`awk -F' +|/' '/ 0:/ {print $8}' $PATH_KEYSTAT`
-	ORIG_MAXKEYSZ=`cat $PATH_KEYQUOTA`
 }
 
-cleanup()
+tst_test()
 {
-	if [ -n "$ORIG_MAXKEYSZ" ]; then
-		echo $ORIG_MAXKEYSZ >$PATH_KEYQUOTA
-	fi
-}
+	PATH_KEYQUOTA="/proc/sys/kernel/keys/root_maxbytes"
 
-do_test()
-{
 	local quota_excd=0
 	local maxkeysz=$((ORIG_KEYSZ + 100))
 
@@ -108,5 +114,4 @@ do_test()
 	tst_res TPASS "Bug not reproduced"
 }
 
-. tst_test.sh
-tst_run
+. tst_run.sh
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
