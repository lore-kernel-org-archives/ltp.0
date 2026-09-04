Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC19C79F80
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:57:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17ED83E9364
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:57:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6EAF3E9371
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:56:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A3256000F2
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:56:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6BDDB1F7C1;
 Fri,  4 Sep 2026 08:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788512173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PX5bpKkXL1ohITvopV4HSjxhb4B32RNUWmByrVE+Kp0=;
 b=SArdisZ+wbOTTkvrRv5dqArL4uKGcohU/2ryiqEEwnUds8O9pdojttk6YbAR/cVu2fyWFs
 v4ezinBH3vjIME6ApJ2zAK9BlAxkrl5P15eHM6QTic4ZR/1g9Za4T6a9F85gcP6CTpgdBa
 dOOsOwkCKIY+uiKzqWqQ39UDgniq0uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788512173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PX5bpKkXL1ohITvopV4HSjxhb4B32RNUWmByrVE+Kp0=;
 b=2Yymt7EXIGD8SudFocWdseNeltm2I98HW8Q2KBkNh6BhHjbgT+HxhJ9c+1dPJHMPRLk4SG
 8xQayIPj9NczypAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=k297JgaE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ABUabc/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788512169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PX5bpKkXL1ohITvopV4HSjxhb4B32RNUWmByrVE+Kp0=;
 b=k297JgaEWVcNPxdQyx6i0eNnvYdU4BrqIBqtDPEVdCUEYWCON4QWSOpMfa79ihkL/Jj/OQ
 AbeRhK06SvVBg6mgFOmsrFmluMKO61jtbtb66aGSEYwZXtzwFIj1ZD2sycpZBTY+eQ9g1c
 IxO5FTBVG2B3ggaIiJHQrx/RmANX7yI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788512169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PX5bpKkXL1ohITvopV4HSjxhb4B32RNUWmByrVE+Kp0=;
 b=ABUabc/gtfqcDLFXisaZDIStjn9pgm73dfgV3szjwjunmUBMKuvfBKaM+n+jH8f91ANnKO
 hoTCP7hWqK6kZnBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFFED13886;
 Fri,  4 Sep 2026 08:56:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EMtxNaiHmmqraAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 04 Sep 2026 08:56:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  4 Sep 2026 10:55:55 +0200
Message-ID: <20260904085555.1202288-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904085555.1202288-1-pvorel@suse.cz>
References: <20260904085555.1202288-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6BDDB1F7C1
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWELVE(0.00)[12]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email,suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] controllers: Remove obsolete references to
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
Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>
Acked-by: Avinesh Kumar <avinesh.kumar@suse.com>
Acked-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Remove also remaining ltp-pan comments in other scripts.

 testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh | 4 ++--
 testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh        | 4 ++--
 testcases/kernel/controllers/memctl/run_memctl_test.sh        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh b/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh
index 5b53544cf0..b443451f10 100755
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
@@ -377,4 +377,4 @@ usage ()
 	echo "Please review the results in $LTPROOT/output/cpuctl_results_$FILE.txt"
 	cleanup;
 	cd $PWD
-	exit 0;		#to let PAN reprt success of test
+	exit 0;
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
diff --git a/testcases/kernel/controllers/memctl/run_memctl_test.sh b/testcases/kernel/controllers/memctl/run_memctl_test.sh
index 2e9620f602..c06d1af4fe 100755
--- a/testcases/kernel/controllers/memctl/run_memctl_test.sh
+++ b/testcases/kernel/controllers/memctl/run_memctl_test.sh
@@ -263,4 +263,4 @@ case $TEST_NUM in
 	echo "Memory Resource Controller test executed successfully.";
 	cleanup;
 	cd $PWD
-	exit 0;         #to let PAN reprt success of test
+	exit 0;
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
