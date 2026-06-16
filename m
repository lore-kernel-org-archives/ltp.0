Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46149CD98CF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 08:30:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2C6E3E5957
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:30:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C60F3E595F
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:30:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 629FF6003AC
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:30:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1E126C7D7;
 Tue, 16 Jun 2026 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781598606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmQ7Hmjzg9Rl6f4C9Gp+bHpsH6yd83BtCVCKDM9eTyc=;
 b=kGYfpPWkbWQiiMkQT78QvuQG1hKrQyD3OE3ftolILOeoPV2AF2wHlQd/LFCCWcUOCylWYT
 Y6DK96IanYTp98NJLSj4fn7i5GxBY8SVd1xGXbVzQuo/ao/ReHA9ux01beTP/2uQDJ1GML
 vpTojcnGnaA7qEWxQ7zf2XO7peD+dGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781598606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmQ7Hmjzg9Rl6f4C9Gp+bHpsH6yd83BtCVCKDM9eTyc=;
 b=ZhPA0mvLKmbdHLC3igc9C/Tvj/pTmhJaOrTy8g43+EZYP82UH6LYE83xZWPy9M/kpZMP/R
 e+WYlJ7rgcJHNsAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781598606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmQ7Hmjzg9Rl6f4C9Gp+bHpsH6yd83BtCVCKDM9eTyc=;
 b=kGYfpPWkbWQiiMkQT78QvuQG1hKrQyD3OE3ftolILOeoPV2AF2wHlQd/LFCCWcUOCylWYT
 Y6DK96IanYTp98NJLSj4fn7i5GxBY8SVd1xGXbVzQuo/ao/ReHA9ux01beTP/2uQDJ1GML
 vpTojcnGnaA7qEWxQ7zf2XO7peD+dGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781598606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmQ7Hmjzg9Rl6f4C9Gp+bHpsH6yd83BtCVCKDM9eTyc=;
 b=ZhPA0mvLKmbdHLC3igc9C/Tvj/pTmhJaOrTy8g43+EZYP82UH6LYE83xZWPy9M/kpZMP/R
 e+WYlJ7rgcJHNsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98BF8779AB;
 Tue, 16 Jun 2026 08:30:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EFedI44JMWqAfAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 16 Jun 2026 08:30:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 16 Jun 2026 10:30:06 +0200
MIME-Version: 1.0
Message-Id: <20260616-fix_pids_errors-v2-1-a1e1d377f8b7@suse.com>
References: <20260616-fix_pids_errors-v2-0-a1e1d377f8b7@suse.com>
In-Reply-To: <20260616-fix_pids_errors-v2-0-a1e1d377f8b7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781598606; l=1398;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=lHBIzEXisWto7xcEdbSCEK8c8VEnk0ftkGUbU684yT8=;
 b=FQpWcyS7/koV2vtxPSXe2xofSxuw+e9u6wzV/cMvue1aD6Zhw3Fs5cdaeu2lWBmyOL7BBA68E
 l4rvycyY0iXAoMB6sVXbw6GxCMmsBq1/N/SD+XFo29NzeXFEVhpmrG8
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] pids: fix cleanup of orphaned pids_task1
 children
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

pids_task1 forks a child that calls pause(), then the parent exits.
The orphaned child remains in the cgroup but gets reparented to init,
so it is not a child of the test shell.

stop_pids_tasks_path() reads cgroup.procs which includes this orphan.
kill -9 succeeds but wait fails with 'not a child of this shell'.
Using ROD for kill also unnecessarily aborts if the process is already
dead.

Fix by suppressing errors from both kill and wait, and add killall
for pids_task1 in cleanup() to catch any remaining orphans.

Reviewed-by: Li Wang <li.wang@linux.dev>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/controllers/pids/pids.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
index 26a0c6a221ea63e683016ebfea33f2744800aaea..dd27b5616f0c4b55c625ca57efa2507325949b07 100755
--- a/testcases/kernel/controllers/pids/pids.sh
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -35,6 +35,7 @@ EOF
 cleanup()
 {
 	killall -9 pids_task2 >/dev/null 2>&1
+	killall -9 pids_task1 >/dev/null 2>&1
 
 	cgroup_cleanup
 }
@@ -79,8 +80,8 @@ stop_pids_tasks_path()
 	path=$1
 
 	for i in $(cat "$path/$task_list"); do
-		ROD kill -9 $i
-		wait $i
+		kill -9 $i 2>/dev/null
+		wait $i 2>/dev/null
 	done
 }
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
