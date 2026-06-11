Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3D5CD98CC
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 15:04:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4ECE73E1D6A
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 17:04:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68B203C1C6B
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 17:03:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DA0D8600845
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 17:03:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F6E275976;
 Thu, 11 Jun 2026 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781190226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t8Edb3IhGBZG6i63rKmVHsn9u8Dv5EJTDMx/UdJganQ=;
 b=LYu+0F1po0HnIg9SMgy33IhHKJu7dlAjVdIrWm6eQizn6xhe8+T6gLe6tFPgAf9QJlydOq
 NM5coZ9wv9850Dy65U/9JfFykV4vwR1nuseBIkeR+4NOu+p2smuO8eeVI1oEsMDLyAONnv
 u5fZgiaFS4J7L521sSlQ/ABSVuB1ubs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781190226;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t8Edb3IhGBZG6i63rKmVHsn9u8Dv5EJTDMx/UdJganQ=;
 b=F+pA/AACef3t+3LGaqXRO0siHlrtg0idlZFVW5NmXenMstqzMVlYcnZsNjfkM4CN47c921
 8VsoBTXKbR4sq/DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781190224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t8Edb3IhGBZG6i63rKmVHsn9u8Dv5EJTDMx/UdJganQ=;
 b=1Af3YJsNsWb1Px8eKRV+zlXagmy78KSAaVi17vXao2QrvZEDtY9pGkIANDH4A8MxmfcBqw
 AhCEojuYQvpqTkETigNQP7/3oY3NJdSitGGeo+yTXDTOoooEJL7W62Xt/Eh8vg1NsMdEPL
 jL7bCIhgM3aok2EgT6LrWAhQjCmdfvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781190224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t8Edb3IhGBZG6i63rKmVHsn9u8Dv5EJTDMx/UdJganQ=;
 b=tk0UuNkYZomTfvnyGyPwLC2uAd6rJC1J6EAYk2LNeTvwLaT1gvBuFEbk0Kr53SSRHwOQrl
 40BO/SMy+QkArEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 883B4779A7;
 Thu, 11 Jun 2026 15:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Js/kH1DOKmo1dAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jun 2026 15:03:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jun 2026 17:03:41 +0200
MIME-Version: 1.0
Message-Id: <20260611-fix_cgroup_immutable-v1-1-0bcb90faa6fe@suse.com>
X-B4-Tracking: v=1; b=H4sIAEzOKmoC/x2MWwqAIBAArxL7nZCCva4SIWZrLZSGZgTR3ZM+B
 2bmgYiBMEJfPBDwokjeZeBlAWbVbkFGc2YQlairmnNm6VZmCT4divY9nXrakAkhO9vIjtt2hpw
 eAbP3b4fxfT/6blavZgAAAA==
X-Change-ID: 20260611-fix_cgroup_immutable-2259f7591f8d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781190224; l=2044;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=oJbVAGvPpjcfGitg9Zo9QZFtAGf9XTzebKHi7LhlOr8=;
 b=Ze9dK1fnGGriADmAJqPHV+w5JP9E+9bRWrOi25G9wF5kLT/NcF01GUktEe0ObhytHJRv5cer1
 LyOSGe+5X+8C5JHwdXaML1WKiPN4qyumCfY/ED1AYOBl8JK4RQdg4+h
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup_fj: don't disable controller that was already
 enabled
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

On immutable distributions (and systemd-managed systems in general)
the cpuset controller is typically already enabled at the root cgroup
level. The cleanup tried to unconditionally disable it via
subtree_control, which failed with EBUSY because other system cgroups
were still using it, producing a spurious TWARN.

Save whether the controller was already enabled at root before
cgroup_require and skip the root-level disable in cleanup when it
was.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index 153d351d7936effb15527620f565acaaed7ac747..8b5e73466ba32d2c66a2805a03f4d2136c16509b 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -57,6 +57,14 @@ create_subgroup()
 
 common_setup()
 {
+    # Check if the controller is already enabled at root before
+    # cgroup_require potentially enables it, so that cleanup does
+    # not disable a controller the system was already using.
+    if [ -f /sys/fs/cgroup/cgroup.subtree_control ] && \
+       grep -qw "$subsystem" /sys/fs/cgroup/cgroup.subtree_control; then
+        ctrl_was_enabled=1
+    fi
+
     cgroup_require "$subsystem"
     mount_point=$(cgroup_get_mountpoint "$subsystem")
     start_path=$(cgroup_get_test_path "$subsystem")
@@ -77,7 +85,7 @@ common_cleanup()
 
     cgroup_cleanup
 
-    if [ "$cgroup_version" = "2" ]; then
+    if [ "$cgroup_version" = "2" ] && [ "$ctrl_was_enabled" != "1" ]; then
         case "$subsystem" in
         cpu|io|memory|pids)
             :;;

---
base-commit: a375e8deed471723f5a0114c56eb48fe6f6f45d3
change-id: 20260611-fix_cgroup_immutable-2259f7591f8d

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
