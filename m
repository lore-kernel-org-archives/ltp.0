Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABE2C433EF
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 15:01:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA4D13C9483
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 16:01:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AF0C3C0BC1
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 16:01:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1E3791400DFA
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 16:01:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A099210FD;
 Wed, 12 Jan 2022 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641999688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=U5zM8q6Pg2VoQS63GoWOpLU7MUACogR+OPLPqujHpwU=;
 b=Z3Fqw7WZwtrtEqwlo0KFuM3WvKJSSZyXJdrghbqz47BRXCoW5aW5I7iOH4x64uxzv8RCjl
 nviCNvJ+D14YmfPlMEBqZPQf0OcoqW6mlJDTT/ZKCwij+RcysHs0x3hiF5VeQ8ZBIuMJKb
 qx8yuaepOmiia0THEbkPyHoO7Do9CCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641999688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=U5zM8q6Pg2VoQS63GoWOpLU7MUACogR+OPLPqujHpwU=;
 b=NsEaHl43H/6h283EstOfThAkrth9QhMZ3V1EbGWoXIj5e/uptKDYnDZ7x8Ajl1UgCaj7JP
 ifmKGHtC+ATvVlBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D93A513B70;
 Wed, 12 Jan 2022 15:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BHX1Mkft3mEsEwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 12 Jan 2022 15:01:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Jan 2022 16:01:23 +0100
Message-Id: <20220112150123.13768-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ima_measurements.sh: Use /proc/uptime instead of
 date
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
Cc: alexhenrie24@gmail.com, Alex Henrie <alexh@vpitech.com>,
 linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It fixes more iterations (e.g. -i2) which is more precise.
date +%s could be used, but it's better use procfs file instead
requiring binary.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

I hope to get this merged into upcoming release (git freeze is going to
be at January the 14), i.e. this Friday.

Kind regards,
Petr

 .../security/integrity/ima/tests/ima_measurements.sh      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index a83c416de0..6c184f3960 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -55,7 +55,7 @@ check_iversion_support()
 test1()
 {
 	tst_res TINFO "verify adding record to the IMA measurement list"
-	ROD echo "$(date) this is a test file" \> $TEST_FILE
+	ROD echo "$(cat /proc/uptime) this is a test file" \> $TEST_FILE
 	ima_check $TEST_FILE
 }
 
@@ -64,7 +64,7 @@ test2()
 
 	tst_res TINFO "verify updating record in the IMA measurement list"
 	check_iversion_support || return
-	ROD echo "$(date) modified file" \> $TEST_FILE
+	ROD echo "$(cat /proc/uptime) modified file" \> $TEST_FILE
 	ima_check $TEST_FILE
 }
 
@@ -83,11 +83,11 @@ test3()
 		return
 	fi
 
-	mkdir -m 0700 $dir
+	[ -d "$dir" ] || mkdir -m 0700 $dir
 	chown $user $dir
 	cd $dir
 	# need to read file to get updated $ASCII_MEASUREMENTS
-	sudo -n -u $user sh -c "echo $(date) user file > $file; cat $file > /dev/null"
+	sudo -n -u $user sh -c "echo $(cat /proc/uptime) user file > $file; cat $file > /dev/null"
 	cd ..
 
 	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
