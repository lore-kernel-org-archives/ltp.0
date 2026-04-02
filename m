Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD83D3941A
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:19:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C9CA3E2A1C
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:19:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C05823E2A19
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BCE7D1A01122
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E83D84D337
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/LPG0Rl9ZnLxKtHDOHL7nykSer+yjpvuPhXpKZNHbw=;
 b=S2Qocrnz8fQ5wyIcpMyPd1mP7qZcVmhap7exePcQc8z7XBVmNF3S16L4/+U7BoYGLArqKm
 JzJX8307sq4ftvKF/lb9kcl+K4a/qLusg1K/YJMHl+nfns+OEk4V7tnVyczUZ3IeSAX8L6
 FEZgRD2NffJ4TnLnCLqEP3GRzmufKJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/LPG0Rl9ZnLxKtHDOHL7nykSer+yjpvuPhXpKZNHbw=;
 b=7bPX0pl7xHqIvV09u/Dg6TBV4vn4ycovtZFjnUQ0Y+S8SejS/mELXbwMOx817RxC6hLjVm
 6SI65DWc8M+G41AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0nDQ57Hb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ClLOMKO2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/LPG0Rl9ZnLxKtHDOHL7nykSer+yjpvuPhXpKZNHbw=;
 b=0nDQ57HbRP3Fmb+m9UsvG6LcS147832uoe7ZtaHwyiKdDJc5yQw9z3jaVjvqX+R2sDda7i
 5hHQmIQK7DQ7H9XoP+zuHoscEGDTedpq5CjC1Wm3fBjZHmBLHbuZo40usf1kzaxgqSXCyZ
 G6fbRxZMKWXC1qhPWYhEHd+llhkpMlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/LPG0Rl9ZnLxKtHDOHL7nykSer+yjpvuPhXpKZNHbw=;
 b=ClLOMKO2Feu1/2JOyQp0jGIdWhmsgWG8i3OLi5Fu5mSYTNpa5zQZFn5xXHomQViD48chbH
 UDeNWMNaQafenVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA4334A0B0
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k7+ENKldzmkADwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:14:33 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:56 +0200
Message-ID: <20260402121356.31266-18-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402121356.31266-1-chrubis@suse.cz>
References: <20260402121356.31266-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:mid, suse.cz:dkim, suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E83D84D337
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 17/17] doc: metadata: Remove needs_drivers from docs
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/developers/writing_tests.rst |  3 ---
 doc/old/C-Test-API.asciidoc      | 13 ++++++-------
 metadata/README.md               | 15 ++++++---------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 992374f8b..5b1516ba5 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -435,9 +435,6 @@ LTP C And Shell Test API Comparison
     * - .needs_device
       - TST_NEEDS_DEVICE
 
-    * - .needs_drivers
-      - TST_NEEDS_DRIVERS
-
     * - .needs_kconfigs
       - TST_NEEDS_KCONFIGS
 
diff --git a/doc/old/C-Test-API.asciidoc b/doc/old/C-Test-API.asciidoc
index 72fd2731d..7493fc578 100644
--- a/doc/old/C-Test-API.asciidoc
+++ b/doc/old/C-Test-API.asciidoc
@@ -1621,13 +1621,12 @@ test should include 'tst_checksum.h' header, then can call 'tst_crc32c()'.
 1.26 Checking kernel for the driver support
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Some tests may need specific kernel drivers, either compiled in, or built
-as a module. If '.needs_drivers' points to a 'NULL' terminated array of kernel
-module names these are all checked and the test exits with 'TCONF' on the
-first missing driver.
-
-The detection is based on reading 'modules.dep' and 'modules.builtin' files
-generated by kmod. The check is skipped on Android.
+Some tests may need specific kernel drivers, either compiled in, or built as a
+module. For this cases a mappping of kernel config options to modules is
+maintained in the kconfig checker. When a kernel config option is requested by
+a test that has associated mapping in the kconfig source the 'modules.dep' file
+is checked for module presence when the option is set to 'm'. The check is
+skipped on Android.
 
 1.27 Saving & restoring /proc|sys values
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/metadata/README.md b/metadata/README.md
index 2cf978d39..950e49f6e 100644
--- a/metadata/README.md
+++ b/metadata/README.md
@@ -144,15 +144,14 @@ struct tst_test test = {
 	/* Indicates that the test is messing with system wall clock */
 	.restore_wallclock = 1,
 
-	/* Tests needs uinput either compiled in or loaded as a module */
-	.needs_drivers = (const char *[]) {
-		"uinput",
-		NULL
-	},
-
 	/* Tests needs enabled kernel config flags */
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_X86_INTEL_UMIP=y",
+        /*
+         * For config options that enable modules we also check the presence of
+         * the module if the config option has module mapping set and is set to 'm'.
+         */
+        "CONFIG_INPUT_UINPUT",
 		NULL
 	},
 
@@ -185,11 +184,9 @@ Which will yield following JSON output:
   "dev_min_size": "1024",
   "dev_fs_type": "ext4",
   "restore_wallclock": "1",
-  "needs_drivers": [
-    "uinput",
-  ],
   "needs_kconfigs": [
     "CONFIG_X86_INTEL_UMIP=y",
+    "CONFIG_INPUT_UINPUT",
   ],
   "tags": [
     [
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
