Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43E0E9537B
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 11:54:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 331873CE0A4
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 12:54:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54B5E3CACD1
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 12:53:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7A12C6008AF
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 12:53:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B46133E70B;
 Wed,  4 Feb 2026 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770206023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9jRSTx/PWOMa4tB6S6/sOOrWzaq8+RAVeiwAkO+fsI=;
 b=A47j0kPkVGdSOlPbl2n9DP8Q4Wq7WhB/yNXwKCiYl4cfteEIrjx65zpDe1z1EO7m74nMrp
 2ePLxvPLWruuDV+UK9WgkAjnJxps541jIuAMqLHUFVV+Qh7JgwJ0PdqlPLhQd7NPj10/CF
 6lLVxPPtusYETn7PLPt4ULhpb+raPQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770206023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9jRSTx/PWOMa4tB6S6/sOOrWzaq8+RAVeiwAkO+fsI=;
 b=FYUkLTS7f//3haEOYZewt9vrFl0X07bmddaj9znvC3FgS/G0fvzLz367XXoBz2KDofo/6k
 uALsgRzf9Y7PSNDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=A47j0kPk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FYUkLTS7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770206023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9jRSTx/PWOMa4tB6S6/sOOrWzaq8+RAVeiwAkO+fsI=;
 b=A47j0kPkVGdSOlPbl2n9DP8Q4Wq7WhB/yNXwKCiYl4cfteEIrjx65zpDe1z1EO7m74nMrp
 2ePLxvPLWruuDV+UK9WgkAjnJxps541jIuAMqLHUFVV+Qh7JgwJ0PdqlPLhQd7NPj10/CF
 6lLVxPPtusYETn7PLPt4ULhpb+raPQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770206023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9jRSTx/PWOMa4tB6S6/sOOrWzaq8+RAVeiwAkO+fsI=;
 b=FYUkLTS7f//3haEOYZewt9vrFl0X07bmddaj9znvC3FgS/G0fvzLz367XXoBz2KDofo/6k
 uALsgRzf9Y7PSNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EAD43EA64;
 Wed,  4 Feb 2026 11:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cB6zHUczg2kcCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Feb 2026 11:53:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Feb 2026 12:53:36 +0100
Message-ID: <20260204115339.224261-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204115339.224261-1-pvorel@suse.cz>
References: <20260204115339.224261-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: B46133E70B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] doc: INSTALL: dma_thread_diotest.c: Remove runltp
 from doc
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

Remove runltp from all doc, replace it with kirk.
Also replace the old runltp-ng with kirk.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 INSTALL                                            |  4 +++-
 doc/developers/test_case_tutorial.rst              |  6 +++---
 doc/developers/todo.rst                            | 10 ----------
 metadata/README.md                                 |  2 +-
 testcases/kernel/fs/fs_readonly/test_robind.sh     |  2 +-
 testcases/kernel/io/direct_io/dma_thread_diotest.c |  3 +--
 testcases/kernel/security/smack/README             |  2 +-
 testcases/network/can/filter-tests/INSTALL         |  2 +-
 testcases/network/rpc/rpc-tirpc/README             |  2 +-
 testscripts/Readme_ROBind                          |  4 ++--
 10 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/INSTALL b/INSTALL
index c44bb4e660..9ef929a971 100644
--- a/INSTALL
+++ b/INSTALL
@@ -105,9 +105,9 @@ Quick Start
 	$ ./configure
 	$ make all
 	# make install
-	$ /opt/ltp/runltp
 
 *NOTE:
+- For running tests use kirk [1], individual test you can run directly.
 - LTP assumes the existence of the nobody, bin, and daemon users and their
 groups.  If these IDs do not exist, certain tests will fail. The respective
 user and group IDs should be the same, i.e. if `nobody's' user ID is 99, then
@@ -117,6 +117,8 @@ its group ID should also be 99. The names of the groups are irrelevant.
 DESTDIR= is also honored for install and will install into $DESTDIR/$prefix,
 if you want to install into a chroot or a rootfs for instance.
 
+[1] https://github.com/linux-test-project/kirk
+
 Detailed Installation
 ---------------------
 
diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
index 08bd1b1519..240897e36b 100644
--- a/doc/developers/test_case_tutorial.rst
+++ b/doc/developers/test_case_tutorial.rst
@@ -205,9 +205,9 @@ please do:
 
 This should build the test and then run it. However, even though the test is
 in :master:`testcases/kernel/syscalls` directory it won't be automatically ran
-as part of the syscalls test group (e.g. not run via ``kirk -r math`` or
-``./runltp -f syscalls``). For this we need to add it to the runtest file. So
-open :master:`runtest/syscalls` and add the lines starting with a ``+``.
+as part of the syscalls test group (e.g. not run via ``kirk -r math``.  For
+this we need to add it to the runtest file. So open :master:`runtest/syscalls`
+and add the lines starting with a ``+``.
 
 .. code-block::
 
diff --git a/doc/developers/todo.rst b/doc/developers/todo.rst
index fe248c819b..4ca8612db7 100644
--- a/doc/developers/todo.rst
+++ b/doc/developers/todo.rst
@@ -7,16 +7,6 @@ This is a comprehensive list of tasks where LTP maintainers are currently
 working on. Priorities might change over time, but these are the most important
 points which are currently being achieved.
 
-Fade out old tests runner
--------------------------
-
-:master:`runltp` script is old and unmaintaned. We are slowly shifting to
-`kirk <https://github.com/linux-test-project/kirk>`_, that will be our official
-tests runner in the future.
-
-Kirk provides support for remote testing via Qemu, SSH, LTX, parallel
-execution and much more.
-
 Test new syscalls
 -----------------
 
diff --git a/metadata/README.md b/metadata/README.md
index c71062759d..2cf978d39e 100644
--- a/metadata/README.md
+++ b/metadata/README.md
@@ -245,4 +245,4 @@ things and how to format them.
 
 So far this proof of concept generates a metadata file. I guess that we need
 actual consumers which will help to settle things down, I will try to look into
-making use of this in the runltp-ng at least as a reference implementation.
+making use of this in the kirk at least as a reference implementation.
diff --git a/testcases/kernel/fs/fs_readonly/test_robind.sh b/testcases/kernel/fs/fs_readonly/test_robind.sh
index 2d9a87b7e0..0f5a67db2e 100755
--- a/testcases/kernel/fs/fs_readonly/test_robind.sh
+++ b/testcases/kernel/fs/fs_readonly/test_robind.sh
@@ -25,7 +25,7 @@
 #   DESCRIPTION:    Performs filesystems tests for RO mount.
 #     For filesystem, like ext2, ext3, reiserfs, jfs & xfs,
 #     This test needs a big block device(>=500MB is ok), and you can specify
-#     it by -z option when running runltp.
+#     it by exporting LTP_BIG_DEV environment variable.
 #        a)  mounts on dir1,
 #        b)  mount --bind dir2
 #        c)  mount -o remount,ro
diff --git a/testcases/kernel/io/direct_io/dma_thread_diotest.c b/testcases/kernel/io/direct_io/dma_thread_diotest.c
index b757ba0e2d..82fab12d98 100644
--- a/testcases/kernel/io/direct_io/dma_thread_diotest.c
+++ b/testcases/kernel/io/direct_io/dma_thread_diotest.c
@@ -389,8 +389,7 @@ static void setup(void)
 
 	/*
 	 * verify whether the current directory has enough free space,
-	 * if it is not satisfied, we will use the LTP_BIG_DEV, which
-	 * will be exported by runltp with "-z" option.
+	 * if it is not satisfied, we will use the LTP_BIG_DEV.
 	 */
 	if (!directflag || !tst_fs_has_free(NULL, ".", 1300, TST_MB)) {
 		device = getenv("LTP_BIG_DEV");
diff --git a/testcases/kernel/security/smack/README b/testcases/kernel/security/smack/README
index 1b56ac6335..375a8ff595 100644
--- a/testcases/kernel/security/smack/README
+++ b/testcases/kernel/security/smack/README
@@ -20,7 +20,7 @@ using the default make target.
 	(cd testcases/kernel/security/smack; make && make install)
 
 5) Running the tests:
-	./runltp -f smack
+	kirk -f smack
 
 Each test exits with 0 on success and an error code on failure.
 
diff --git a/testcases/network/can/filter-tests/INSTALL b/testcases/network/can/filter-tests/INSTALL
index 7d62d65fe7..f07a0976e8 100644
--- a/testcases/network/can/filter-tests/INSTALL
+++ b/testcases/network/can/filter-tests/INSTALL
@@ -16,7 +16,7 @@ $ ./can_filter
 $ ./can_rcv_own_msgs
 
 3) To let LTP run the tests from $LTPROOT, execute:
-$ ./runltp -f can
+$ kirk -f can
 
 4) Clean up using:
 $ make clean
diff --git a/testcases/network/rpc/rpc-tirpc/README b/testcases/network/rpc/rpc-tirpc/README
index 139162751c..51c48360c2 100644
--- a/testcases/network/rpc/rpc-tirpc/README
+++ b/testcases/network/rpc/rpc-tirpc/README
@@ -46,6 +46,6 @@ instead of a bunch of scripts from the above web page.
 The basic group of test cases can be executed from
  * runtest/net.rpc_tests - for TS-RPC testing
  * runtest/net.tirpc_tests - for TI-RPC testing
-using the LTP framework (ltp-pan, runltp and etc).
+using kirk.
 
 Additional test cases (like stress, complex and etc) are to be integrated.
diff --git a/testscripts/Readme_ROBind b/testscripts/Readme_ROBind
index 2f961d43f1..02efb0f172 100644
--- a/testscripts/Readme_ROBind
+++ b/testscripts/Readme_ROBind
@@ -3,9 +3,9 @@ the {LTPROOT}/testcases/kernel/fs .
 
 EXECUTING TESTS
 ==================
-The tests can be executed through runltp like:
+The tests can be executed with kirk:
 
-./runltp -f fs_readonly
+kirk -f fs_readonly
 
 Following tests are executed when the above is invoked:
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
