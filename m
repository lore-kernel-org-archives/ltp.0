Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F31C02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 10:57:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8ECF3C936C
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 11:57:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7BF33C2F48
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 11:56:05 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F12AB65BAD2
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 11:56:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CAB4F1F44E;
 Fri,  7 Feb 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96B2513AC0;
 Fri,  7 Feb 2025 10:56:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oGSCI8PmpWddeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Feb 2025 10:56:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Feb 2025 11:55:49 +0100
Message-ID: <20250207105551.1736356-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250207105551.1736356-1-pvorel@suse.cz>
References: <20250207105551.1736356-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CAB4F1F44E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] doc: Replace docparse info with sphinx
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

Update doc changes from previous commit.

* Remove docparse example output from release procedure
* Patch review links to building docs with sphinx
* Comments in lib/tst_test.c now point to sphinx

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/writing_tests.rst          | 13 +++++++------
 doc/maintainers/ltp_release_procedure.rst |  6 ------
 doc/maintainers/patch_review.rst          |  4 ++--
 lib/tst_test.c                            |  4 ++--
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index ab633121ed..4e4f5ce34a 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -63,12 +63,13 @@ things are done.
 
 Never ever comment the obvious.
 
-In case of LTP testcases, it's customary to add an asciidoc formatted comment
-paragraph with high-level test description at the beginning of the file right
-under the GPL SPDX header. This helps other people to understand the overall
-goal of the test before they dive into the technical details. It's also
-exported into generated documentation hence it should mostly explain what is
-tested.
+In case of LTP testcases, it's customary to add an `RST
+<https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html>`_
+formatted comment paragraph with high-level test description at the beginning
+of the file right under the GPL SPDX header. This helps other people to
+understand the overall goal of the test before they dive into the technical
+details. It's also exported into generated documentation hence it should mostly
+explain what is tested.
 
 DRY (Code duplication)
 ~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/maintainers/ltp_release_procedure.rst b/doc/maintainers/ltp_release_procedure.rst
index 5cb0bbb07f..6259afe0ea 100644
--- a/doc/maintainers/ltp_release_procedure.rst
+++ b/doc/maintainers/ltp_release_procedure.rst
@@ -116,11 +116,6 @@ metadata documentation:
     sha1 ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.sha1
     sha256sum ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.sha256
 
-    # Generate metadata documentation
-    ./configure --with-metadata-generator=asciidoctor
-    make -C metadata
-    cp -v docparse/metadata.html ../metadata.YYYYMMDD.html
-
 You can use :master:`tools/create-tarballs-metadata.sh` script to have the above
 procedure automated. All generated files are placed in the
 ``ltp-release-YYYYMMDD`` directory.
@@ -143,7 +138,6 @@ procedure automated. All generated files are placed in the
     ===== Generate metadata documentation =====
     checking for a BSD-compatible install... /usr/bin/install -c
     ...
-    'docparse/metadata.html' -> '/home/foo/ltp-release-YYYYMMDD/metadata.YYYYMMDD.html'
     Generated files are in '/home/foo/ltp-release-YYYYMMDD', upload them to github
 
 Upload the generated files to GitHub
diff --git a/doc/maintainers/patch_review.rst b/doc/maintainers/patch_review.rst
index 36caaf23bd..28bc4faf34 100644
--- a/doc/maintainers/patch_review.rst
+++ b/doc/maintainers/patch_review.rst
@@ -47,7 +47,7 @@ The following are examples and may not be appropriate for all tests.
 * Compare usage of system calls with kernel code
 * Double check commit message
 * Search the LTP library for existing helper functions
-* Check doc formatting, i.e. ``make doc && chromium docparse/metadata.html``
+* Check doc formatting, see :doc:`../developers/documentation`.
 
 How to find subtle errors
 -------------------------
@@ -149,7 +149,7 @@ C tests
 * Use :doc:`../developers/api_c_tests`, implementing :ref:`struct tst_test`
 * Test binaries are added into corresponding ``.gitignore`` files
 * Check coding style with ``make check``
-* Docparse documentation
+* Metadata documentation
 * If a test is a regression test it should include :ref:`.tags<struct tst_tag>` in the
   :ref:`struct tst_test` definition
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 934a7f866d..e2803f04a7 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -44,7 +44,7 @@
  */
 const char *TCID __attribute__((weak));
 
-/* update also docparse/testinfo.pl */
+/* update also doc/conf.py */
 #define LINUX_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id="
 #define LINUX_STABLE_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id="
 #define GLIBC_GIT_URL "https://sourceware.org/git/?p=glibc.git;a=commit;h="
@@ -898,7 +898,7 @@ static void print_failure_hint(const char *tag, const char *hint,
 
 static int show_failure_hints;
 
-/* update also docparse/testinfo.pl */
+/* update also doc/conf.py */
 static void print_failure_hints(void)
 {
 	print_failure_hint("linux-git", "missing kernel fixes", LINUX_GIT_URL);
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
