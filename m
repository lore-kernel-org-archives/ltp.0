Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71105C624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 12:48:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C6083EAD69
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 14:48:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F2443EAD89
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:46:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 862571400C7E
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:46:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 21DA51FE43;
 Thu,  3 Sep 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788439607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RoRgt9JgHnngEJ6u5wh9usjSukfTkJlzUmosIa3JZlo=;
 b=Y3yWRYaVkGEG/hjEws6Xpjziviy59Pd6TN3bhR5zx4km5p1IQYDFWAHFBMbLUL9NWiVNF3
 dUvdKZnIfcFHX8eqHWxyidwLEn8M1FtUXVxyMJJyybI0ZgGld5P4rYkGYIrnKi+GgYcHeO
 u9Bcg1YsAgimnl/C9Sl2O51wCW7qY6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788439607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RoRgt9JgHnngEJ6u5wh9usjSukfTkJlzUmosIa3JZlo=;
 b=qP0yc+GHp0VLsSw6pS4nr4my7yd/S1Waotmu1zdLN9PjLn1mmjyOaVvS2qe6BM68aBtH7e
 uCn5mRcS8ZaT43BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 828AE13888;
 Thu,  3 Sep 2026 12:46:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WLpqHjZsmWqHLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 12:46:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  3 Sep 2026 14:46:31 +0200
Message-ID: <20260903124631.1100746-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903124631.1100746-1-pvorel@suse.cz>
References: <20260903124631.1100746-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 21DA51FE43
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 4/4] controllers: Remove obsolete references to
 ltp-pan
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
Cc: Tim Bird <tim.bird@sony.com>, Steffen Jaeckel <sjaeckel@suse.de>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Kirk should now be used.

Fixes: 5e5fd4a1ae ("pan: Remove")
Reported-by: Steffen Jaeckel <sjaeckel@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh | 2 +-
 testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh b/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh
index 5b53544cf0..0920eb9fd5 100755
--- a/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh
+++ b/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh
@@ -358,7 +358,7 @@ usage ()
 	echo TASKS FIRED
 	echo helloworld > myfifo;
 
-	#wait for the tasks to finish for cleanup and status report to pan
+	#wait for the tasks to finish for cleanup and status report
 	for i in $(seq 1 $TOTAL_TASKS)
 	do
 		wait ${PID[$i]};
diff --git a/testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh b/testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh
index 5b09fb273d..a7bab10625 100755
--- a/testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh
+++ b/testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh
@@ -285,7 +285,7 @@ NUM_CPUS=`tst_ncpus`
 	echo TASKS FIRED
 	echo helloworld > myfifo;
 
-	#wait for the tasks to finish for cleanup and status report to pan
+	#wait for the tasks to finish for cleanup and status report
 	for i in $(seq 1 $TOTAL_TASKS)
 	do
 		wait ${PID[$i]};
@@ -304,4 +304,4 @@ NUM_CPUS=`tst_ncpus`
 	echo "Please review the results in $LTPROOT/output/cpuctl_results_$FILE.txt"
 	cleanup;
 	cd $PWD
-	exit 0;		#to let PAN reprt success of test
+	exit 0;
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
