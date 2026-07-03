Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3F3C43458
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 08:23:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A11D3E72D0
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 10:23:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD5C73E2325
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 10:23:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D4AE1400E55
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 10:23:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E93B5747DA;
 Fri,  3 Jul 2026 08:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783066989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k4Sbt/X2uAZdydPvxRx9ax8VYrK8JeZ9SoLEBD+dYx4=;
 b=wD8HPfdQCnNCKmOhTGQZANTgkuUYREGi25mqH5RkqiArEWZJf8IIR4X7Pxi5dtBRUUyVPK
 AiVxdfzaraE0oi7Ojc6tS7cxwE7t3Z1A3c93p3VVKoww3CkvbBj6FvQmYINq5IpuUEQV00
 n6/4+BNfXzZ9SYeAlvFkuE/V4TtTulY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783066989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k4Sbt/X2uAZdydPvxRx9ax8VYrK8JeZ9SoLEBD+dYx4=;
 b=9r+F+6wZoHdMcI6dVXs/o4hvWD1VFe9/QsqVFQ//RvJFSEHkwAudf/6W+kfX6+mu29RukS
 vkgznHpFWb/eL5BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783066988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k4Sbt/X2uAZdydPvxRx9ax8VYrK8JeZ9SoLEBD+dYx4=;
 b=p8UU0/jY6yLWOtptqF4n3nQaHJRC405GlFdAKyi1u4l552/qCAvxeTNBH5ca5Wm9yU0vUi
 Ydg8iD+i3lfhbbnjmABMwBNGq5nSKt8Za/9WbNesVmY77pWmVjG3l74ZVC64dERaO8uuAn
 THCkLoOoUk9XPlbox/9jUbXz7ZPBWFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783066988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k4Sbt/X2uAZdydPvxRx9ax8VYrK8JeZ9SoLEBD+dYx4=;
 b=KLQREeeF67dtHwsu9KV+ISYUyaswKNUGWlJtoaA9+vdgb//FlQeFgQZdmSy6jf9JU8eFl1
 hk9VdS2OPQe1uoAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE0A2779AA;
 Fri,  3 Jul 2026 08:23:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +gAzMGxxR2obMgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 03 Jul 2026 08:23:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 03 Jul 2026 10:23:08 +0200
MIME-Version: 1.0
Message-Id: <20260703-fix_memcg_stress-v1-1-93bd09a62446@suse.com>
X-B4-Tracking: v=1; b=H4sIAGtxR2oC/x2MWwqAIBAAryL7nWBGG3WViChbbT964EYE4d2TP
 gdm5gWhyCTQqRci3Sx87BnKQoFbpz2Q5iUzWGPRNKbSnp9xo82FUa5IIto4RGxnP9UeIWdnpOz
 8y35I6QNWQ3hIYgAAAA==
X-Change-ID: 20260703-fix_memcg_stress-0c6669bfa5f6
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783066988; l=2317;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=OGcQlUrUh3eG51j4dXlkGohgY6mR0TkZAw4iFJXuelU=;
 b=kqzn8JumTtbhm7kahRgDMdtc5a11CIS6IlG7V/xq+1QQKih9yPJdYntGjipNvkASTdWlmGU52
 GgNX8zjb3YICr4cnV/jB75DiVUnovcpL/hEjKbv0osMvudG6xRb+ctL
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg_stress: survive OOM by targeting the stressors
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

The single-cgroup subtest intentionally lets one process fault in the
whole memory budget to push the system to its memory ceiling, so hitting
the OOM killer is an expected part of the stress. The problem is that the
OOM killer could reap the driver script, turning that expected pressure
into a spurious TBROK.

Mark the stress processes as the preferred OOM victims. A killed stressor
is already reaped and cleaned up by the test, while the driver survives
and reports the result.

Fixes: 02961a7b2bb4 ("memcg_stress_test.sh: Fix reserved mem calculate")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
On some systems this might happens:

[  244.207623][T117130] kirk[3061]: memcg_stress: start (command: memcg_stress_test.sh)
[  244.391438][T117164] memcg_stress_te (117164): drop_caches: 3
[ 1444.509722][T119900] kirk[3061]: memcg_stress: end (returncode: -1)
[ 1444.629434][T119934] kirk[3061]: memcg_control: start (command: memcg_control_test.sh)
[ 1445.856012][T120020] mem_process invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
---
 testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index 47cac9af8bec970b7fb338c5469ab73d55267740..14a5ddeeaa45a1bc5e30b2fa7640bcb1effbd94b 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -71,8 +71,12 @@ run_stress()
 	for i in $(seq 0 $(($cgroups-1))); do
 		ROD mkdir "$test_path/$i"
 		memcg_process_stress $mem_size $interval &
-		ROD echo $! \> "$test_path/$i/$task_list"
-		pids="$pids $!"
+		pid=$!
+		ROD echo $pid \> "$test_path/$i/$task_list"
+		# Make the stress process the preferred OOM victim so that memory
+		# pressure kills a stressor rather than the driver script.
+		echo 1000 > "/proc/$pid/oom_score_adj" 2>/dev/null
+		pids="$pids $pid"
 	done
 
 	for pid in $pids; do

---
base-commit: 4898cb95b01b8a3ab5e1ea752990deca7a66ca34
change-id: 20260703-fix_memcg_stress-0c6669bfa5f6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
