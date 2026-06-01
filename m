Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7666DCD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 09:53:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 102303E52DB
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 11:53:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4E1A3E56D1
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:53:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6B663600831
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:53:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3609E67744;
 Mon,  1 Jun 2026 09:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780307577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vD8b6+u7cyy0rjesFeRX25mB2p3jboPfjAyRYi9Xc8I=;
 b=yVYdW8QWkQVpKMYdsnYhE8idWruTAhu6piCSLblRdkgZIWlov/xKeX34GIOlQFCwR9MBQf
 ogVd448tkfM4nnog4ctFrvk6IG1aYWQPGhN/3WZMBrPa0GjMHn2/2JpE0mSlLVZ+nGA/Xu
 kaARrJkzReTYeZEnPIvh1y1PpHa4m+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780307577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vD8b6+u7cyy0rjesFeRX25mB2p3jboPfjAyRYi9Xc8I=;
 b=jt4WpXVQxhtbq5qK6i1FZCVxLYOt5EH6X6EvzeWJ+tZYQcq4yl6ljIO0dnMLoN42r9oNl1
 rC0tinTaC2KE/uDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yVYdW8QW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jt4WpXVQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780307577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vD8b6+u7cyy0rjesFeRX25mB2p3jboPfjAyRYi9Xc8I=;
 b=yVYdW8QWkQVpKMYdsnYhE8idWruTAhu6piCSLblRdkgZIWlov/xKeX34GIOlQFCwR9MBQf
 ogVd448tkfM4nnog4ctFrvk6IG1aYWQPGhN/3WZMBrPa0GjMHn2/2JpE0mSlLVZ+nGA/Xu
 kaARrJkzReTYeZEnPIvh1y1PpHa4m+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780307577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vD8b6+u7cyy0rjesFeRX25mB2p3jboPfjAyRYi9Xc8I=;
 b=jt4WpXVQxhtbq5qK6i1FZCVxLYOt5EH6X6EvzeWJ+tZYQcq4yl6ljIO0dnMLoN42r9oNl1
 rC0tinTaC2KE/uDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19CB4779AA;
 Mon,  1 Jun 2026 09:52:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cD2yBHlWHWrqZwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jun 2026 09:52:57 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jun 2026 11:52:56 +0200
MIME-Version: 1.0
Message-Id: <20260601-doc_update-v1-3-b0f59834fbae@suse.com>
References: <20260601-doc_update-v1-0-b0f59834fbae@suse.com>
In-Reply-To: <20260601-doc_update-v1-0-b0f59834fbae@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780307576; l=5839;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=brr5dltRUxHrX/A4oZx+Ygn4EJAPwIzIZtIhiG7mTsQ=;
 b=CxPolM/RZ1zNoZFxsYS6DNJnbXnqgPvO1IGfbuZxFE6Wdj1pwwK6S+qbGiTIQ6WX392mvD0lp
 J0FpwpbXiMxClVMAPOKTjmBdoudKl9aLaBKoillQEJ3xZAgwMgGzH1a
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3609E67744
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] include: Fix kernel-doc warnings in header
 comments
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

Drop :ref: cross-references to undocumented structs in tst_test.h
and tst_kvercmp.h kernel-doc comments, replacing them with plain
text. These produced 'undefined label' Sphinx warnings.

Downgrade kernel-doc comments to plain comments for struct tst_cmd
and TST_CAP() macro to avoid name collisions with the tst_cmd()
function and struct tst_cap respectively. The kernel-doc parser
flattens names case-insensitively, causing 'name used several times'
errors and duplicate target warnings.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_capability.h |  2 +-
 include/tst_cmd.h        |  2 +-
 include/tst_kvercmp.h    |  2 +-
 include/tst_test.h       | 16 ++++++++--------
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/tst_capability.h b/include/tst_capability.h
index ccf4bd77b5d7f663f35f587ea2c0a7369070552e..34c5d94d2e54fb96742ba208301cfab83bdbcac2 100644
--- a/include/tst_capability.h
+++ b/include/tst_capability.h
@@ -67,7 +67,7 @@ struct tst_cap {
 	char *name;
 };
 
-/**
+/*
  * TST_CAP() - Create a struct tst_cap entry.
  *
  * @action: What should we do, i.e. drop or add capability.
diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index 831cb4da486881f9ef345b9f6ead461feb5dfd46..77fbbbc867b6edf841c5347ac612569a5b8470d1 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -19,7 +19,7 @@ enum tst_cmd_flags {
 	TST_CMD_TCONF_ON_MISSING = 2,
 };
 
-/**
+/*
  * struct tst_cmd - Provides details about a command struct needed by LTP test.
  * @cmd: The name of the command.
  * @optional: A flag indicating if the command is optional.
diff --git a/include/tst_kvercmp.h b/include/tst_kvercmp.h
index 7c991c746a3ab5383535b545c3025f2174d7722b..8457f7926da2022a9fcd215c9404e5cd7f566e0b 100644
--- a/include/tst_kvercmp.h
+++ b/include/tst_kvercmp.h
@@ -93,7 +93,7 @@ struct tst_kern_exv {
  * @r1: Major kernel version.
  * @r2: Minor kernel version.
  * @r3: Kernel patch level.
- * @vers: A {} terminated array of :ref:`struct tst_kern_exv`.
+ * @vers: A {} terminated array of struct tst_kern_exv.
  *
  * Attempts to look up a distro specific kernel version from the struct
  * tst_kern_exv table first and if no match is found falls back to the version
diff --git a/include/tst_test.h b/include/tst_test.h
index 530f22f6e8ee3686bea4b4cc8b080b3c4e6a70c3..16387d21b31896092c82a596147dcc06376933b3 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -298,7 +298,7 @@ struct tst_fs {
  *
  * @tcnt: A number of tests. If set the test() callback is called tcnt times
  *        and each time passed an increasing counter value.
- * @options: An NULL optstr terminated array of :ref:`struct tst_option`.
+ * @options: An NULL optstr terminated array of struct tst_option.
  *
  * @min_kver: A minimal kernel version the test can run on. e.g. "3.10".
  *
@@ -322,7 +322,7 @@ struct tst_fs {
  * @forks_child: Has to be set if the test intends to fork children.
  *
  * @needs_device: If set a block device is prepared for the test, the device
- *                path and size are set in the :ref:`struct tst_device` variable
+ *                path and size are set in the struct tst_device variable
  *                called tst_device. If $LTP_DEV variable exists in the test
  *                environment the test attempts to use that device first and
  *                only if that fails the test falls back to use loop devices.
@@ -361,7 +361,7 @@ struct tst_fs {
  *                   i.e. file system that is supported by the kernel and has
  *                   mkfs installed on the system.The file system is mounted at
  *                   tst_test.mntpoint and file system details, e.g. type are set
- *                   in the :ref:`struct tst_device`. Each execution is independent,
+ *                   in the struct tst_device. Each execution is independent,
  *                   that means that for each iteration tst_test.setup() is
  *                   called at the test start and tst_test.cleanup() is called
  *                   at the end and tst_brk() only exits test for a single
@@ -500,7 +500,7 @@ struct tst_fs {
  *
  * @save_restore: A {} terminated array of /proc or /sys files that should
  *                saved at the start of the test and restored at the end. See
- *                tst_sys_conf_save() and :ref:`struct tst_path_val` for details.
+ *                tst_sys_conf_save() and struct tst_path_val for details.
  *
  * @ulimit: A {} terminated array of process limits RLIMIT_* to be adjusted for
  *          the test.
@@ -522,14 +522,14 @@ struct tst_fs {
  * @bufs: A description of guarded buffers to be allocated for the test. Guarded
  *        buffers are buffers with poisoned page allocated right before the start
  *        of the buffer and canary right after the end of the buffer. See
- *        :ref:`struct tst_buffers` and tst_buffers_alloc() for details.
+ *        struct tst_buffers and tst_buffers_alloc() for details.
  *
  * @caps: A {} terminated array of capabilities to change before the start of
- *        the test. See :ref:`struct tst_cap` and tst_cap_setup() for details.
+ *        the test. See struct tst_cap and tst_cap_setup() for details.
  *
- * @tags: A {} terminated array of test tags. See :ref:`struct tst_tag` for details.
+ * @tags: A {} terminated array of test tags. See struct tst_tag for details.
  *
- * @needs_cmds: A NULL terminated array of :ref:`struct tst_cmd` required for the test to run.
+ * @needs_cmds: A NULL terminated array of struct tst_cmd required for the test to run.
  *
  * @needs_cgroup_ver: If set the test will run only if the specified cgroup
  *                    version is present on the system.

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
