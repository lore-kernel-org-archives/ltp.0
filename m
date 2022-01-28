Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C72C433F5
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 19:06:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACC363C9766
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 20:06:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABBB13C9120
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 20:06:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CCBBB600C7F
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 20:06:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 68D22212B5;
 Fri, 28 Jan 2022 19:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643396769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TamAa4rDiolUHiShit781+clk4Y5MddXeTW1aDMS9FE=;
 b=2CYXFOjZDpVLb6NU9XUXynj6GmL3Mi6E+sjsI9OacXMSYrxywAhkDDoLX2qV+/0PAOnqxi
 ClEUAg1kJfHAmgKyze2a1d3qUP5C2snXDfjqrbu5359KSQrBjaQK++YiduPz9xbsf1U8PO
 ojqCofFU2ARFGZRSH9A+J5C1loGyTVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643396769;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TamAa4rDiolUHiShit781+clk4Y5MddXeTW1aDMS9FE=;
 b=I1S9AmZgN6pxXMX0L7UBaCydZORwd+Px8Pu/KUF4me+2wpgGPzZQOjURbcxH841UwtEG82
 FkW/pzsJy7C+5gBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11A3113A92;
 Fri, 28 Jan 2022 19:06:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zOV/AqE+9GGKNQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Jan 2022 19:06:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Jan 2022 20:06:05 +0100
Message-Id: <20220128190605.7172-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] tst_test.sh: Add $TST_FORMAT_DEVICE and
 related vars
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
Changes v1->v2:
* fixes "Implies 'TST_NEEDS_DEVICE=1' (no need to set it)."
(was under TST_FS_TYPE, belongs to TST_FORMAT_DEVICE).
* Add more doc at "Formatting device with a filesystem"

I wonder where to put variable description. I this case I put it into
the table "1.2 Library environment variables and functions for shell"
[1] or at these sections describing it e.g. here "Formatting device with
a filesystem"?

I'd prefer to put it into the section describing it and just link it
in the table => v3 needed.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#12-library-environment-variables-and-functions-for-shell
[2] https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem

 doc/shell-test-api.txt    | 26 ++++++++++++++++++++++++--
 testcases/lib/tst_test.sh |  7 ++++++-
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index a5974b4fad..41878004fb 100644
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
+|                          | Implies 'TST_NEEDS_DEVICE=1' (no need to set it).
+| 'TST_FS_TYPE'            | Overwrite the default filesystem to be used.
 | 'TST_NEEDS_ROOT'         | Exit the test with 'TCONF' unless executed under root.
 |                          | Alternatively the 'tst_require_root' command can be used.
 | 'TST_NEEDS_TMPDIR'       | Create test temporary directory and cd into it.
@@ -495,7 +502,22 @@ tst_random 0 1000
 Formatting device with a filesystem
 +++++++++++++++++++++++++++++++++++
 
-The 'tst_mkfs' helper will format device with the filesystem.
+'TST_FORMAT_DEVICE=1' can be used to format device before running the test.
+Uses '$TST_FS_TYPE', '$TST_DEVICE', '$TST_DEV_FS_OPTS' and '$TST_DEV_EXTRA_OPTS.
+Library internally uses 'tst_mkfs', which can be used for more complex setup.
+
+[source,sh]
+-------------------------------------------------------------------------------
+TST_FORMAT_DEVICE=1
+TST_DEV_FS_OPTS="-b 1024 -O quota"
+TST_DEV_EXTRA_OPTS="5m"
+TST_TESTFUNC=test
+
+test1()
+{
+	tst_res TPASS "device formatted"
+}
+-------------------------------------------------------------------------------
 
 [source,sh]
 -------------------------------------------------------------------------------
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
