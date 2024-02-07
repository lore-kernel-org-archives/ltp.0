Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2DCC4828D
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 16:06:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 128CE3CF581
	for <ltp@archiver.kernel.org>; Wed,  7 Feb 2024 17:06:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C21C63CC516
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:06:35 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 41BA71BBCF1F
 for <ltp@lists.linux.it>; Wed,  7 Feb 2024 17:06:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DBD8C1FBF9;
 Wed,  7 Feb 2024 16:06:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E2C013931;
 Wed,  7 Feb 2024 16:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oB5YJYqqw2WRSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Feb 2024 16:06:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 Feb 2024 17:06:27 +0100
Message-ID: <20240207160628.125908-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207160628.125908-1-pvorel@suse.cz>
References: <20240207160628.125908-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: DBD8C1FBF9
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] tst_test.sh: Print warning if slashes in $TMPDIR
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

Further improve changes in 273c49793 to print warning, because C API
started to print warning as well. Previous requirement to not actually
modify $TMPDIR (just to cleanup $TST_TMPDIR) required to rewrite the
code).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 0d2fccb95..20bf21660 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -666,6 +666,7 @@ tst_run()
 	local _tst_data
 	local _tst_max
 	local _tst_name
+	local _tst_tmpdir
 	local _tst_pattern='[='\''"} \t\/:`$\;|].*'
 	local ret
 
@@ -734,12 +735,18 @@ tst_run()
 
 	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
 		if [ -z "$TMPDIR" ]; then
-			export TMPDIR="/tmp"
+			_tst_tmpdir="/tmp"
+			export TMPDIR="$_tst_tmpdir"
+		else
+			# remove possible double slashes or trailing slash from TMPDIR
+			_tst_tmpdir=$(echo "$TMPDIR" | sed 's~/\+~/~g; s~/$~~')
+			if [ "$_tst_tmpdir" != "$TMPDIR" ]; then
+				tst_res TINFO "WARNING: Remove double or trailing slashes from TMPDIR," \
+					"please fix your setup to: TMPDIR='$_tst_tmpdir'"
+			fi
 		fi
 
-		TST_TMPDIR=$(mktemp -d "$TMPDIR/LTP_$TST_ID.XXXXXXXXXX")
-		# remove possible trailing slash or double slashes from TMPDIR
-		TST_TMPDIR=$(echo "$TST_TMPDIR" | sed 's~/\+~/~g')
+		TST_TMPDIR=$(mktemp -d "$_tst_tmpdir/LTP_$TST_ID.XXXXXXXXXX")
 
 		chmod 777 "$TST_TMPDIR"
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
