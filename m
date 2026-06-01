Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052E7CD6E56
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 09:54:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BC823E56CD
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 11:54:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80AD33E56E9
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:53:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D29CA2005EC
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:53:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 566FB6B8F5;
 Mon,  1 Jun 2026 09:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780307577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3ez90MKybKMf300lyYU7t3Q/63TrNElSPxae6G+3DQ=;
 b=ISTyLGdHXzVGr4mmm7asF365Ww1uN1SF2yDDFoaqG3+MzYML0lI6pi8Vh3LXEhkC0Ju0Bc
 FtwMtTsmXZFPEzQEoawl0hriRERE9bnaGIJFEZw6z5GV3DkQrchU/EoNUHCrFHHHYSrCa/
 zzTUyT/USGNx+Jz/n4xBwVJsD0VTne8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780307577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3ez90MKybKMf300lyYU7t3Q/63TrNElSPxae6G+3DQ=;
 b=8BLgCnQo758TYI+H1/HZna0gBbGAwp8HyoCPqK6/asu8zJ0mjAVyHK2fQqRIKTVbYbGcL9
 AGi/hDiMpYCPDLDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780307577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3ez90MKybKMf300lyYU7t3Q/63TrNElSPxae6G+3DQ=;
 b=ISTyLGdHXzVGr4mmm7asF365Ww1uN1SF2yDDFoaqG3+MzYML0lI6pi8Vh3LXEhkC0Ju0Bc
 FtwMtTsmXZFPEzQEoawl0hriRERE9bnaGIJFEZw6z5GV3DkQrchU/EoNUHCrFHHHYSrCa/
 zzTUyT/USGNx+Jz/n4xBwVJsD0VTne8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780307577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3ez90MKybKMf300lyYU7t3Q/63TrNElSPxae6G+3DQ=;
 b=8BLgCnQo758TYI+H1/HZna0gBbGAwp8HyoCPqK6/asu8zJ0mjAVyHK2fQqRIKTVbYbGcL9
 AGi/hDiMpYCPDLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CF02779A7;
 Mon,  1 Jun 2026 09:52:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uDQ9DXlWHWrqZwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jun 2026 09:52:57 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jun 2026 11:52:57 +0200
MIME-Version: 1.0
Message-Id: <20260601-doc_update-v1-4-b0f59834fbae@suse.com>
References: <20260601-doc_update-v1-0-b0f59834fbae@suse.com>
In-Reply-To: <20260601-doc_update-v1-0-b0f59834fbae@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780307576; l=4095;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=uo70DSVyxRrfGbsnTPZ+jAl3y/9ZHqRISvaJUOeb/cY=;
 b=z6f/MqqYLSss9SPIwPpHkh0WgUX2y8MXANzBxPcWgyVx/yqIufaIt37vdcZ5JIpkixn9ykc0M
 YfLUN/RtrA2CwxZNLqYjdKwtmIPUHk26K699TwNW6CjObkAHREV1gvk
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] doc: Fix incorrect struct tst_test field
 references
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

Fix several inaccuracies in ground_rules.rst and writing_tests.rst
where struct tst_test fields were referenced incorrectly:

- .save_restore and .needs_cgroup_ctrls are not boolean flags, drop
  the '= 1' assignment examples.
- .supported_archs example had a stray ')' in the type cast.
- .max_runtime renamed to .runtime per commit
  a6a369c5eeb4 ("lib: redefine the overall timeout logic of test").
- .tst_hugepage -> .hugepages (the actual field name).
- .dev_extra_opts, .dev_fs_opts, .dev_fs_type never existed as C
  struct fields; move them to the shell-only section of the
  comparison table.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/developers/ground_rules.rst  |  6 +++---
 doc/developers/writing_tests.rst | 28 ++++++++++++++--------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/doc/developers/ground_rules.rst b/doc/developers/ground_rules.rst
index 1b68ce3427682e68866768b8344aca008939b7be..e03f32ad39ca8931ff1b616fc4e8383101cf523e 100644
--- a/doc/developers/ground_rules.rst
+++ b/doc/developers/ground_rules.rst
@@ -100,10 +100,10 @@ paths too.
 The test library can simplify cleanup greatly as there are various helpers such as:
 
 - :c:type:`.needs_tmpdir = 1 <tst_test>` that creates and deletes a temporary directory for the test
-- :c:type:`.save_restore = 1 <tst_test>` that saves and restores /sys/ and /proc/ files
+- :c:type:`.save_restore <tst_test>` that saves and restores /sys/ and /proc/ files
 - :c:type:`.needs_device = 1 <tst_test>` sets up and tears down a block device for the test
 - :c:type:`.restore_wallclock = 1 <tst_test>` that restores wall clock after the test
-- :c:type:`.needs_cgroup_ctrls = 1 <tst_test>` sets up and cleans up cgroups for the test
+- :c:type:`.needs_cgroup_ctrls <tst_test>` sets up and cleans up cgroups for the test
 - And many more.
 
 
@@ -115,7 +115,7 @@ Avoid nonstandard libc APIs when a portable equivalent exists; don't assume
 
 If the test is specific to a certain architecture, make sure that it at least
 compiles at the rest of architectures and set the
-:c:type:`.supported_archs = const char *const []){"s390x", ..., NULL} <tst_test>`.
+:c:type:`.supported_archs = (const char *const []){"s390x", ..., NULL} <tst_test>`.
 
 This also applies to shell code where it's easy to use bash features that are
 not available on other shell implementations, e.g. dash or busybox. Make sure
diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 2c1349eea190d79e99c4bf6562eb62806cb58b48..dc40324b16d40c4d210fe0dfa6b311b5b3337c7a 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -379,25 +379,16 @@ LTP C And Shell Test API Comparison
     * - .cleanup
       - TST_CLEANUP
 
-    * - .dev_extra_opts
-      - TST_DEV_EXTRA_OPTS
-
-    * - .dev_fs_opts
-      - TST_DEV_FS_OPTS
-
-    * - .dev_fs_type
-      - TST_FS_TYPE
-
     * - .dev_min_size
       - TST_DEVICE_SIZE
 
     * - .format_device
       - TST_FORMAT_DEVICE
 
-    * - .max_runtime
-      - TST_TIMEOUT (not exactly the same, a real timeout based on old .timeout
-        concept. .max_runtime has also an extra 30 sec safety margin for
-        teardown of the test.)
+    * - .runtime
+      - TST_TIMEOUT (not exactly the same, TST_TIMEOUT is a real timeout.
+        .runtime controls the test execution loop duration and has an extra
+        30 sec safety margin for setup and cleanup.)
 
     * - .min_cpus
       - not applicable
@@ -507,7 +498,7 @@ LTP C And Shell Test API Comparison
     * - .test_variants
       - \-
 
-    * - .tst_hugepage
+    * - .hugepages
       - not applicable
 
     * - .ulimit
@@ -525,6 +516,15 @@ LTP C And Shell Test API Comparison
     * - not applicable
       - TST_USAGE
 
+    * - not applicable
+      - TST_DEV_EXTRA_OPTS
+
+    * - not applicable
+      - TST_DEV_FS_OPTS
+
+    * - not applicable
+      - TST_FS_TYPE
+
 .. list-table::
     :header-rows: 1
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
