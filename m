Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D451C19F2B
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 12:20:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 599F83C93F9
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 14:20:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FB2C3C25DD
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:19:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BF0DB600155
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:19:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B1B220FBC;
 Thu,  4 Aug 2022 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659615593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCKsDyBWwpM2xjyH9HFase7aQvx5126tp6gx/31tzBs=;
 b=I1eQa3BKWiDK4AOqmrfwxgmfUbzV33pLxme20kdko52AwNZihF6/d0dd+a4GQMg7dGEh2E
 dM14jqTG+CMRjYj7l4a7jmVlH7bQ2jOa7YMKrIlQojchstzkpU8UmbQUEECMo/Kgzy+Y6I
 NifIUr/3efuB6yIfyIlGDjMyycLzFfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659615593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCKsDyBWwpM2xjyH9HFase7aQvx5126tp6gx/31tzBs=;
 b=RXq14mqdkgn2qnU+YjbuCuZmn1GRKM71xGU653ERGSdpAp/5C6Mm6EwoHtrSP0rbM8MdXF
 rsjBbeBYj+VZFbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 119B113A94;
 Thu,  4 Aug 2022 12:19:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MBQZAmm562L2PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Aug 2022 12:19:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Aug 2022 14:19:39 +0200
Message-Id: <20220804121946.19564-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804121946.19564-1-pvorel@suse.cz>
References: <20220804121946.19564-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 03/10] tst_test.sh: Allow $ ;
 after whitelisted variable
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Variable followed by other variable was not whitelisted:
e.g.:
$TST_FS_TYPE$pattern
TWARN: Reserved variable TST_FS_TYPE$ used!

for i in $SKIP_FILESYSTEMS; do
TWARN: Reserved variable TST_SKIP_FILESYSTEMS used!

Also use the same patter for second grep for detection of _tst_*
functions variables.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v3

 testcases/lib/tst_test.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index b7cf5f3d4..3494f7786 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -625,9 +625,10 @@ tst_run()
 	local _tst_data
 	local _tst_max
 	local _tst_name
+	local _tst_pattern='[='\''"} \t\/:`$\;].*'
 
 	if [ -n "$TST_TEST_PATH" ]; then
-		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[='\''"} \t\/:`].*//'); do
+		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed "s/.*TST_//; s/$_tst_pattern//"); do
 			case "$_tst_i" in
 			DISABLE_APPARMOR|DISABLE_SELINUX);;
 			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
@@ -647,7 +648,7 @@ tst_run()
 			esac
 		done
 
-		for _tst_i in $(grep '^[^#]*\b_tst_' "$TST_TEST_PATH" | sed 's/.*_tst_//; s/[="} \t\/:`].*//'); do
+		for _tst_i in $(grep '^[^#]*\b_tst_' "$TST_TEST_PATH" | sed "s/.*_tst_//; s/$_tst_pattern//"); do
 			tst_res TWARN "Private variable or function _tst_$_tst_i used!"
 		done
 	fi
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
