Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3378AC433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 16:28:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB01F3C9EFE
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 17:28:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59A213C9C2E
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:27:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD40620096E
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:27:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B8021F3A2;
 Thu, 10 Feb 2022 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644510464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHEn3f7Ku2zAlrXvIbHlCMCbZtYtoxEjmH5oPu96Yyk=;
 b=0W7L/8JjUn+1wdOmScQ8rTAll6aQhXbrivh5rqGQao3IiRTLzHRml1ohSr7u/HfFV07iUJ
 wzKhM7LMdtBHV+4y6NmMv7Ze7v3hsACsi+z1us1X2j+ezHzv6NQ1FMMrCdWCvCB5D/ZOII
 B0qzrJwikTd8OizxKsP/acG8IYBIFSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644510464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHEn3f7Ku2zAlrXvIbHlCMCbZtYtoxEjmH5oPu96Yyk=;
 b=IMMZ7gtUKKsK/uYLiiHeIUoT6CexiPwFE+gzMd20L+2KtDxpya3RYmALnTNqvCmSWFq4QR
 BAxk5/2xT+qPIPCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40DDA13BC1;
 Thu, 10 Feb 2022 16:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EKb/DQA9BWJAMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 10 Feb 2022 16:27:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Feb 2022 17:27:36 +0100
Message-Id: <20220210162739.30159-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210162739.30159-1-pvorel@suse.cz>
References: <20220210162739.30159-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/6] tst_test.sh: Add $TST_FORMAT_DEVICE and
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

NOTE: stop using pattern 'TST_NEEDS_FOO', sometimes 'NEEDS' just does
not fit to variable name.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/shell-test-api.txt    | 31 +++++++++++++++++++++++++++++--
 testcases/lib/tst_test.sh |  6 ++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index a5974b4fad..5caa889c9e 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -189,11 +189,20 @@ space as default value is used. Of course, it's possible to use separate functio
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Similarily to the C library various checks and preparations can be requested
-simply by setting right '$TST_NEEDS_FOO'.
+simply by setting right '$TST_FOO'.
 
 [options="header"]
 |=============================================================================
 | Variable name            | Action done
+| 'TST_DEV_EXTRA_OPTS'     | Pass extra 'mkfs' options _after_ device name,
+|                          | to 'tst_mkfs', use with 'TST_FORMAT_DEVICE=1'.
+| 'TST_DEV_FS_OPTS'        | Pass 'mkfs' options _before_ the device name,
+|                          | to 'tst_mkfs', use with 'TST_FORMAT_DEVICE=1'.
+| 'TST_FORMAT_DEVICE'      | Format a block device with a filesystem, see
+|                          | https://github.com/linux-test-project/ltp/wiki/Shell-Test-API#formatting-device-with-a-filesystem[Formatting device with a filesystem]
+|                          | See also 'TST_DEV_EXTRA_OPTS', 'TST_DEV_FS_OPTS', 'TST_FS_TYPE'.
+|                          | Implies 'TST_NEEDS_DEVICE=1' (no need to set it).
+| 'TST_FS_TYPE'            | Override the default filesystem to be used.
 | 'TST_NEEDS_ROOT'         | Exit the test with 'TCONF' unless executed under root.
 |                          | Alternatively the 'tst_require_root' command can be used.
 | 'TST_NEEDS_TMPDIR'       | Create test temporary directory and cd into it.
@@ -495,7 +504,25 @@ tst_random 0 1000
 Formatting device with a filesystem
 +++++++++++++++++++++++++++++++++++
 
-The 'tst_mkfs' helper will format device with the filesystem.
+'TST_FORMAT_DEVICE=1' can be used to format device before running the test.
+Uses '$TST_FS_TYPE' (used filesystem, by default ext2), '$TST_DEVICE' (used
+block device, usually prepared by 'TST_NEEDS_DEVICE=1'), '$TST_DEV_FS_OPTS'
+('mkfs' options _before_ the device name) and '$TST_DEV_EXTRA_OPTS'
+(extra 'mkfs' options _after_ the device name).
+Library internally uses 'tst_mkfs' function, which can be used for more complex setup.
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
index 64e65f9f53..0968391984 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -616,6 +616,7 @@ tst_run()
 			NET_SKIP_VARIABLE_INIT|NEEDS_CHECKPOINTS);;
 			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
 			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
+			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
@@ -660,6 +661,7 @@ tst_run()
 
 	_tst_setup_timer
 
+	[ "$TST_FORMAT_DEVICE" = 1 ] && TST_NEEDS_DEVICE=1
 	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
 
 	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
@@ -691,6 +693,10 @@ tst_run()
 
 	[ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"
 
+	if [ "$TST_FORMAT_DEVICE" = 1 ]; then
+		tst_mkfs $TST_FS_TYPE $TST_DEV_FS_OPTS $TST_DEVICE $TST_DEV_EXTRA_OPTS
+	fi
+
 	[ -n "$TST_NEEDS_CHECKPOINTS" ] && _tst_init_checkpoints
 
 	if [ -n "$TST_SETUP" ]; then
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
