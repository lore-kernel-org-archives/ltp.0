Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD05EC1EA7
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 12:16:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF7C33CE24F
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 13:16:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E64F3CC3DF
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 13:15:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 39EC020024F
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 13:15:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 586373E7B6;
 Thu,  5 Feb 2026 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770293749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9jRSTx/PWOMa4tB6S6/sOOrWzaq8+RAVeiwAkO+fsI=;
 b=oyHtdWVd/JkWvpwXSm58zEF9DCca7nvFacZu4+jp7kEFf6tQADVQiiGQkKoVWJoqi2qdTR
 S9jVkNt6AwFkckZdDpd6uj0HoV9EvvrFX5G2ouvpxad72zT4dFbailjr2O4GcBjeDX75vj
 MBKJYxUGdejL8CbUR4muQXZ/+Nfg27Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770293749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9jRSTx/PWOMa4tB6S6/sOOrWzaq8+RAVeiwAkO+fsI=;
 b=XP8k/9qYzEy+jOKSs5FXF+H5FJf7wrLfLKC79Qq4b9gTQ9Xezs1p4L/4qdXzoeCL5O6EC+
 Bm9WeCIVGHYZyvDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770293749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9jRSTx/PWOMa4tB6S6/sOOrWzaq8+RAVeiwAkO+fsI=;
 b=oyHtdWVd/JkWvpwXSm58zEF9DCca7nvFacZu4+jp7kEFf6tQADVQiiGQkKoVWJoqi2qdTR
 S9jVkNt6AwFkckZdDpd6uj0HoV9EvvrFX5G2ouvpxad72zT4dFbailjr2O4GcBjeDX75vj
 MBKJYxUGdejL8CbUR4muQXZ/+Nfg27Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770293749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9jRSTx/PWOMa4tB6S6/sOOrWzaq8+RAVeiwAkO+fsI=;
 b=XP8k/9qYzEy+jOKSs5FXF+H5FJf7wrLfLKC79Qq4b9gTQ9Xezs1p4L/4qdXzoeCL5O6EC+
 Bm9WeCIVGHYZyvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15FC73EA64;
 Thu,  5 Feb 2026 12:15:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WIoUBPWJhGmHXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Feb 2026 12:15:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  5 Feb 2026 13:15:35 +0100
Message-ID: <20260205121540.329921-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205121540.329921-1-pvorel@suse.cz>
References: <20260205121540.329921-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,suse.com,redhat.com,lists.yoctoproject.org,gmail.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/6] doc: INSTALL: dma_thread_diotest.c: Remove
 runltp from doc
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
Cc: automated-testing@lists.yoctoproject.org
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
