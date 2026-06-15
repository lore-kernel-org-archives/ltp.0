Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C8ACD98CF
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:17:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C5A73E5BDD
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 16:17:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68B363E5C28
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:16:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D31EA60014D
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:16:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B0BCE75A7F;
 Mon, 15 Jun 2026 14:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781532991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZIW23L3/9hCj+9msbPEoT0lRCx44V2UfUVJM6z4xTI=;
 b=xlqqZbWm4GGPwOSX0kHtNfwKI/iIx85j6Pk2TVsX6n4hkJ8lFxn9GozK/XVVYQEMQ0xBND
 3si8Y2xJHHI9j8Ze+OdfMTq/u2OlFXe+as2NJ5CgNVXPGGYN3kYyIYEgXhdf2FvXDNgeY5
 3yu8ekjV04kjTR+OXMpNrpWsdxyDBUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781532991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZIW23L3/9hCj+9msbPEoT0lRCx44V2UfUVJM6z4xTI=;
 b=qh1qnFoWlhHFQcsQn2OCJM7puPy4m7gXSoAYefwbg21H/3hgPM59masMoiU1kLtMlMuFVA
 uVAd0JpGG5YjiWCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=icmd3sr6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CjZXCaOh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781532990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZIW23L3/9hCj+9msbPEoT0lRCx44V2UfUVJM6z4xTI=;
 b=icmd3sr6c8BVetqSGivrJfy0h3BABjMZCv8z8EVCz111jLmyfqblqQzJQ7cYFgAVIQEP6x
 BZhuYw075HYFBQjZ7vI9D+w9gDnoli46jfrfjZxcyEPDVlX+cIOGK57Jwd57RL9Jan8FPc
 MA3Sk31glSs1ImclfJaIAzZfC6BfhTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781532990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZIW23L3/9hCj+9msbPEoT0lRCx44V2UfUVJM6z4xTI=;
 b=CjZXCaOh2x0+36Bg98O5/i1KX7FrzjZfpaczfvLXb8XLHssKD5wxRuXzNqZJa9OA0b1jOt
 Umd2omnrmx+OpiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AC16779A9;
 Mon, 15 Jun 2026 14:16:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AJ1wJD4JMGqYYQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 15 Jun 2026 14:16:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 15 Jun 2026 16:16:29 +0200
MIME-Version: 1.0
Message-Id: <20260615-fix_pids_errors-v1-1-99a54a205180@suse.com>
References: <20260615-fix_pids_errors-v1-0-99a54a205180@suse.com>
In-Reply-To: <20260615-fix_pids_errors-v1-0-99a54a205180@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781532990; l=1356;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=PUHCLOOEdKs2CIFPi1YFlzi0q89ARLTuXT4StH5x8yA=;
 b=Skz195b+KfSyUHzngdj0Z5JKLlfBzQ2Ks8ujTDeNQIJp82TxeRHSRGc2sJtVKGFEeGLMwmkpi
 0KJvPVULJgfATjgPAnCACJioQzyYjq4PcAduX+LIrM28AYi46QjEQdm
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B0BCE75A7F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] pids: fix cleanup of orphaned pids_task1 children
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
