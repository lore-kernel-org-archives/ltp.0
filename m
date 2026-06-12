Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D92CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 08:27:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20B943E2FB2
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:27:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 861663C2180
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:27:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F19266008C9
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:27:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 742C26B47C;
 Fri, 12 Jun 2026 08:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781252842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojP3f2ns9GlpI0lf/Xzh2VpxXiE/lOUY/r1prnWdO0I=;
 b=vGVrLO8KijNE0OQfdf8zxgdPR7y8nLj9gFJ1XYl1SCL8aIYEB5MUj8lEtyLweE7oicolXP
 PVD9utGdVPZsSbMcCqMMvopygoUuNF+F0Y9NTurr5RFPZaIl2CBHYyeDyhHdEsiM6CbEIx
 DQP7y/lcuj4NYs/zoFlFc+k7pWo0t3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781252842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojP3f2ns9GlpI0lf/Xzh2VpxXiE/lOUY/r1prnWdO0I=;
 b=r8fKql6G8V7222W94MMLmwS9BHjs/oP3Xp4FjFvlyEcgP50GvOchHG6aaauS3B2Mnf4FL4
 sl9SuSzU6Dds/6BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781252842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojP3f2ns9GlpI0lf/Xzh2VpxXiE/lOUY/r1prnWdO0I=;
 b=vGVrLO8KijNE0OQfdf8zxgdPR7y8nLj9gFJ1XYl1SCL8aIYEB5MUj8lEtyLweE7oicolXP
 PVD9utGdVPZsSbMcCqMMvopygoUuNF+F0Y9NTurr5RFPZaIl2CBHYyeDyhHdEsiM6CbEIx
 DQP7y/lcuj4NYs/zoFlFc+k7pWo0t3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781252842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojP3f2ns9GlpI0lf/Xzh2VpxXiE/lOUY/r1prnWdO0I=;
 b=r8fKql6G8V7222W94MMLmwS9BHjs/oP3Xp4FjFvlyEcgP50GvOchHG6aaauS3B2Mnf4FL4
 sl9SuSzU6Dds/6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52E3A779AA;
 Fri, 12 Jun 2026 08:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MLGEEurCK2rTRAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 12 Jun 2026 08:27:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 12 Jun 2026 10:27:21 +0200
MIME-Version: 1.0
Message-Id: <20260612-doc_add_missing_headers-v8-2-a4639c49cad8@suse.com>
References: <20260612-doc_add_missing_headers-v8-0-a4639c49cad8@suse.com>
In-Reply-To: <20260612-doc_add_missing_headers-v8-0-a4639c49cad8@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781252841; l=1844;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=LhopHx7IpStE4omzWTzzIw2DjJWcJvtdLoxkgphenmc=;
 b=5FpPwOJrmL1JDk1njaTv3yAAkHxqx676YVHzDIeoNSPgXipkv01ZtkY6CqzcTh9vYwoFkSyvf
 VHAVnUrbGgPA5oJl2cN2y6C5DCiGQo9OrpI5aZA0dKChUFlA0HV5yQg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/2] doc: complete struct tst_test documentation
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

Add missing struct tst_test fields in the C API.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/developers/writing_tests.rst | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index dc40324b16d40c4d210fe0dfa6b311b5b3337c7a..4db57898fcf08b83e68be996f666e91c418838fc 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -382,6 +382,12 @@ LTP C And Shell Test API Comparison
     * - .dev_min_size
       - TST_DEVICE_SIZE
 
+    * - .filesystems
+      - \-
+
+    * - .forks_child
+      - not applicable
+
     * - .format_device
       - TST_FORMAT_DEVICE
 
@@ -399,21 +405,33 @@ LTP C And Shell Test API Comparison
     * - .min_mem_avail
       - not applicable
 
-    * - .mnt_flags
-      - TST_MNT_PARAMS
+    * - .min_runtime
+      - \-
 
     * - .min_swap_avail
       - not applicable
 
+    * - .mnt_flags
+      - TST_MNT_PARAMS
+
     * - .mntpoint | .mnt_data
       - TST_MNTPOINT
 
     * - .mount_device
       - TST_MOUNT_DEVICE
 
+    * - .needs_abi_bits
+      - not applicable
+
     * - .needs_cgroup_ctrls
       - \-
 
+    * - .needs_cgroup_nsdelegate
+      - \-
+
+    * - .needs_cgroup_ver
+      - \-
+
     * - .needs_checkpoints
       - TST_NEEDS_CHECKPOINTS
 
@@ -426,6 +444,9 @@ LTP C And Shell Test API Comparison
     * - .needs_device
       - TST_NEEDS_DEVICE
 
+    * - .needs_hugetlbfs
+      - \-
+
     * - removed
       - TST_NEEDS_DRIVERS
 
@@ -453,6 +474,9 @@ LTP C And Shell Test API Comparison
     * - .restore_wallclock
       - not applicable
 
+    * - .runs_script
+      - not applicable
+
     * - .sample
       - \-
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
