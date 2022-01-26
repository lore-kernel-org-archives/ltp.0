Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFAFC28CF5
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 18:12:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9646D3C972B
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 19:12:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4DC73C54C9
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 19:12:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E06171A00215
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 19:12:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75309218FA;
 Wed, 26 Jan 2022 18:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643220736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwNShP9nBBnuoxIX5HfEXsR3kiGmg5xtL8H7Au6lrvo=;
 b=HPM4HPBV03VIxmVi7DKzZo3LlLISs68Sz4YbkT/RaZnr1spJbByYOdnQvca0MvG7HadGrq
 /4J2BxcNLfo+OsYKHD1qaaUJPGlcEjlYUMPm4eghnt3ETNoHXXBmDQhkYxy2NOMiu5KQaG
 hnUXZgVOOSTwK89iTznYmJoK9iwUNPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643220736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwNShP9nBBnuoxIX5HfEXsR3kiGmg5xtL8H7Au6lrvo=;
 b=FGCg/zAjxru9EsfHZxEYikgn43CwEHc1U6aD3H0A2+MjeLe7+WPGiGUre50paGaDeNhoUa
 x4dYEkMbARFkbJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B2F213E30;
 Wed, 26 Jan 2022 18:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WNg8EACP8WGbcQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 18:12:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 19:12:08 +0100
Message-Id: <20220126181210.24897-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126181210.24897-1-pvorel@suse.cz>
References: <20220126181210.24897-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] tst_test.sh: Add $TST_FORMAT_DEVICE and related
 vars
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

i.e.: TST_DEV_EXTRA_OPTS, TST_DEV_FS_OPTS, TST_FS_TYPE
(to sync with C API).

Also stop using pattern 'TST_NEEDS_FOO', sometimes 'NEEDS' just does not
fit to variable name.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/shell-test-api.txt    | 9 ++++++++-
 testcases/lib/tst_test.sh | 7 ++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index e082808f7e..6605c65b47 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -189,11 +189,18 @@ space as default value is used. Of course, it's possible to use separate functio
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Similarily to the C library various checks and preparations can be requested
-simply by setting right '$TST_NEEDS_FOO'.
+simply by setting right '$TST_FOO'.
 
 [options="header"]
 |=============================================================================
 | Variable name            | Action done
+| 'TST_DEV_EXTRA_OPTS'     | Pass additional 'mkfs' options when use 'TST_FORMAT_DEVICE'.
+| 'TST_DEV_FS_OPTS'        | Pass extra 'mkfs' options after the device name
+|                          | when use 'TST_FORMAT_DEVICE'.
+| 'TST_FORMAT_DEVICE'      | Format a block device with a filesystem. See also
+|                          | 'TST_DEV_EXTRA_OPTS', 'TST_DEV_FS_OPTS', 'TST_FS_TYPE'.
+| 'TST_FS_TYPE'            | Overwrite the default filesystem to be used.
+|                          | Implies 'TST_NEEDS_DEVICE=1' (no need to set it).
 | 'TST_NEEDS_ROOT'         | Exit the test with 'TCONF' unless executed under root.
 |                          | Alternatively the 'tst_require_root' command can be used.
 | 'TST_NEEDS_TMPDIR'       | Create test temporary directory and cd into it.
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 4707613158..49eee8d00f 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -613,7 +613,7 @@ tst_run()
 			NET_SKIP_VARIABLE_INIT|NEEDS_CHECKPOINTS);;
 			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
 			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
-			DEFAULT_FS_TYPE);;
+			DEFAULT_FS_TYPE|DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
@@ -658,6 +658,7 @@ tst_run()
 
 	_tst_setup_timer
 
+	[ "$TST_FORMAT_DEVICE" = 1 ] && TST_NEEDS_DEVICE=1
 	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
 
 	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
@@ -689,6 +690,10 @@ tst_run()
 
 	[ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"
 
+	if [ "$TST_FORMAT_DEVICE" = 1 ]; then
+		tst_mkfs "$TST_FS_TYPE" "$TST_DEVICE" "$TST_DEV_FS_OPTS" "$TST_DEV_EXTRA_OPTS"
+	fi
+
 	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
 
 	if [ -n "$TST_SETUP" ]; then
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
