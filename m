Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9881EB64DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 11:01:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CF9E3C98F4
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 13:01:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 115ED3C9733
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 13:00:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7977E1400451
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 13:00:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B1E521B27;
 Wed, 19 Jul 2023 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689764457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2qfkxP5Yykfg1tSV2XqfZsrWXK1B97QjCzbwsJgO74=;
 b=avYkrTlFp3E0kg7rzj+fcxgmyin8I3TDlDUAgXhA2XeKYaefy6QLXNlxBf6K5UR28163ba
 cv23sQlN6E63dvvtf2buGc90ng+LY0z/oB3AfLGr/Cta9dN/2gPyAC6bvFQv7TNWHVTVVM
 fQgpzrwN81Q8CUmTKZ/O8BOcUGQUL38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689764457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2qfkxP5Yykfg1tSV2XqfZsrWXK1B97QjCzbwsJgO74=;
 b=xJg7lf7PO39xyy88V9vINCf14aVqN0uE27lIn4YjYYY1omZkL4eRK4y+My12Eg77YEAeoV
 ijWtrBLrwlQIE7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB3311361C;
 Wed, 19 Jul 2023 11:00:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yNfrMmjCt2RtUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jul 2023 11:00:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Jul 2023 13:00:51 +0200
Message-Id: <20230719110051.1237775-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719110051.1237775-1-pvorel@suse.cz>
References: <20230719110051.1237775-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] lib: Move gitignore entries to their directory
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .gitignore           | 18 ------------------
 lib/.gitignore       |  1 +
 lib/tests/.gitignore | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 18 deletions(-)
 create mode 100644 lib/tests/.gitignore

diff --git a/.gitignore b/.gitignore
index 915d22104..85bcf052b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -41,7 +41,6 @@ autom4te.cache
 /include/mk/config-openposix.mk
 /include/mk/features.mk
 /m4/ltp-version.m4
-/lib/ltp.pc
 /pan/ltp-bump
 /pan/ltp-pan
 
@@ -63,20 +62,3 @@ patches/
 logfile.*
 
 /utils/benchmark/ebizzy-0.3/ebizzy
-/lib/tests/tst_tmpdir_test
-/lib/tests/tst_checkpoint
-/lib/tests/tst_checkpoint_wait_timeout
-/lib/tests/tst_checkpoint_wake_timeout
-/lib/tests/tst_process_state
-/lib/tests/tst_cleanup_once
-/lib/tests/tst_safe_macros
-/lib/tests/tst_strsig
-/lib/tests/tst_strerrno
-/lib/tests/tst_fs_fill_subdirs
-/lib/tests/tst_fs_fill_hardlinks
-/lib/tests/tst_device
-/lib/tests/tst_record_childstatus
-/lib/tests/trerrno
-/lib/tests/tst_dataroot01
-/lib/tests/tst_dataroot02
-/lib/tests/tst_dataroot03
diff --git a/lib/.gitignore b/lib/.gitignore
index 1bd967e2f..eb9901169 100644
--- a/lib/.gitignore
+++ b/lib/.gitignore
@@ -1,2 +1,3 @@
 /ltp-version.h
 /cached-version
+/ltp.pc
diff --git a/lib/tests/.gitignore b/lib/tests/.gitignore
new file mode 100644
index 000000000..1d880c1b7
--- /dev/null
+++ b/lib/tests/.gitignore
@@ -0,0 +1,17 @@
+/tst_tmpdir_test
+/tst_checkpoint
+/tst_checkpoint_wait_timeout
+/tst_checkpoint_wake_timeout
+/tst_process_state
+/tst_cleanup_once
+/tst_safe_macros
+/tst_strsig
+/tst_strerrno
+/tst_fs_fill_subdirs
+/tst_fs_fill_hardlinks
+/tst_device
+/tst_record_childstatus
+/trerrno
+/tst_dataroot01
+/tst_dataroot02
+/tst_dataroot03
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
