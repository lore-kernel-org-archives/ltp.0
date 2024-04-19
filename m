Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965C9C4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 14:08:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BC293CFD8B
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 16:08:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD4EB3CFC99
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 16:07:55 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E94001015447
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 16:07:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7890E22615;
 Fri, 19 Apr 2024 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713535673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5jxcPoozDwIOK11D9iUDVF5XU4gM/9dPWEQv/6EMlt4=;
 b=0CJiVSltsxkYs43NMvNfNokvZk9W/bAbr8rtCi60BbSV34vL0a9FuHZE7JKiKvWg3aQ8az
 1MieK17QD5yCZywSi8qWJRvVRzPBKUrgfy22I2Y8b4PLgfJqlDYgM0J5xygjxvDKbFXfTs
 P3w63v6RuN1eDEI/O/OWoDBjPwmglvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713535673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5jxcPoozDwIOK11D9iUDVF5XU4gM/9dPWEQv/6EMlt4=;
 b=lNq/ewxIwvduUaUrbvxoxCM+k+BZ45mquhRrSEk1YoVi7XxujdeOE0E4Pbxs6KZs1g7HNw
 KqxXg4Rv7bbtyvBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0CJiVSlt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="lNq/ewxI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713535673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5jxcPoozDwIOK11D9iUDVF5XU4gM/9dPWEQv/6EMlt4=;
 b=0CJiVSltsxkYs43NMvNfNokvZk9W/bAbr8rtCi60BbSV34vL0a9FuHZE7JKiKvWg3aQ8az
 1MieK17QD5yCZywSi8qWJRvVRzPBKUrgfy22I2Y8b4PLgfJqlDYgM0J5xygjxvDKbFXfTs
 P3w63v6RuN1eDEI/O/OWoDBjPwmglvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713535673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5jxcPoozDwIOK11D9iUDVF5XU4gM/9dPWEQv/6EMlt4=;
 b=lNq/ewxIwvduUaUrbvxoxCM+k+BZ45mquhRrSEk1YoVi7XxujdeOE0E4Pbxs6KZs1g7HNw
 KqxXg4Rv7bbtyvBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53568136CF;
 Fri, 19 Apr 2024 14:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Pr1pErl6ImaWZAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 19 Apr 2024 14:07:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 19 Apr 2024 16:07:52 +0200
Message-Id: <20240419140752.18003-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7890E22615
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] doc: introduce sphinx extlinks
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

With sphinx extlinks we are now able to avoid duplication of the
github repo link inside documentation. The patch introduces two new
directives which can be used: :repo: and :master:, which are used to
replace repo static link and repo master static link respectively.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/conf.py                               |  7 ++++++-
 doc/developers/test_case_tutorial.rst     |  5 ++---
 doc/developers/writing_tests.rst          |  4 ++--
 doc/maintainers/ltp_release_procedure.rst | 18 ++++++++----------
 doc/users/quick_start.rst                 |  2 +-
 doc/users/supported_systems.rst           |  4 +++-
 6 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index fb3e83cf2..9408ee46e 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -22,10 +22,15 @@ release = '1.0'
 
 extensions = [
     'linuxdoc.rstKernelDoc',
-    'sphinxcontrib.spelling'
+    'sphinxcontrib.spelling',
+    'sphinx.ext.extlinks'
 ]
 
 exclude_patterns = ["html*", '_static*']
+extlinks = {
+    'repo': ('https://github.com/linux-test-project/ltp/%s', '%s'),
+    'master': ('https://github.com/linux-test-project/ltp/blob/master/%s', '%s')
+}
 
 spelling_lang = "en_US"
 spelling_warning = True
diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
index fc56ae58c..71777cffc 100644
--- a/doc/developers/test_case_tutorial.rst
+++ b/doc/developers/test_case_tutorial.rst
@@ -627,9 +627,8 @@ again on the hard-link, then ``stat`` the file".
 
 Because we are now opening a file, we need a ``cleanup`` function to close the
 file descriptors. We have to manually close the files to ensure the temporary
-directory is deleted by the test harness (see the
-https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines[test
-writing guidelines] for details).
+directory is deleted by the test harness (see the test writing guidelines for
+details).
 
 As a matter of good practice, the file descriptors are closed in reverse
 order. In some circumstances the order which ``cleanup`` is performed is
diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 032fbcbd5..2eaf5f9e5 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -343,11 +343,11 @@ of the stable kernel ABI, the associated test must be moved out of staging.
 Testing builds with GitHub Actions
 ----------------------------------
 
-Master branch is tested in `GitHub Actions <https://github.com/linux-test-project/ltp/actions>`_
+Master branch is tested in GitHub :repo:`actions`
 to ensure LTP builds in various distributions, including old, current and
 bleeding edge. ``gcc`` and ``clang`` toolchains are also tested for various
 architectures using cross-compilation. For a full list of tested distros, please
-check ``.github/workflows/ci.yml``.
+check :repo:`.github/workflows/ci.yml`.
 
 .. note::
 
diff --git a/doc/maintainers/ltp_release_procedure.rst b/doc/maintainers/ltp_release_procedure.rst
index f0bc01cee..53eb02855 100644
--- a/doc/maintainers/ltp_release_procedure.rst
+++ b/doc/maintainers/ltp_release_procedure.rst
@@ -44,9 +44,9 @@ Tag the git and push changes to github
 
 The string ``YYYYMMDD`` should be substituted to the current date.
 
-You can use `tools/tag-release.sh <https://github.com/linux-test-project/ltp/blob/master/tools/tag-release.sh>`_
-script to have the above automated process.
-It allows you to verify the tag before pushing it and does other checks.
+You can use :master:`tools/tag-release.sh` script to have the above automated
+process. It allows you to verify the tag before pushing it and does other
+checks.
 
 .. code-block:: bash
 
@@ -121,9 +121,9 @@ metadata documentation:
     make -C metadata
     cp -v docparse/metadata.html ../metadata.YYYYMMDD.html
 
-You can use `tools/create-tarballs-metadata.sh <https://github.com/linux-test-project/ltp/blob/master/tools/create-tarballs-metadata.sh>`_
-script to have the above procedure automated. All generated files are placed
-in the ``ltp-release-YYYYMMDD`` directory.
+You can use :master:`tools/create-tarballs-metadata.sh` script to have the above
+procedure automated. All generated files are placed in the
+``ltp-release-YYYYMMDD`` directory.
 
 .. code-block:: bash
 
@@ -149,10 +149,8 @@ in the ``ltp-release-YYYYMMDD`` directory.
 Upload the generated files to GitHub
 ------------------------------------
 
-Click on `Releases <https://github.com/linux-test-project/ltp/releases>`_, then
-switch to `Tags <https://github.com/linux-test-project/ltp/tags>`_. Click on
-'Add release notes'.  There should be 'Attach binaries ...' link at the
-bottom of the page.
+Go to :repo:`tags`. Click on ``Add release notes``. 
+There should be ``Attach binaries ...`` link at the bottom of the page.
 
 Don't forget to upload checksums for the tarballs and metadata documentation
 as well.
diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
index 40d8dd9c6..69792999b 100644
--- a/doc/users/quick_start.rst
+++ b/doc/users/quick_start.rst
@@ -24,7 +24,7 @@ Basics requirements to build LTP are the following:
 
 .. note::
 
-   For optional library dependencies, take a look at the scripts inside ``ci/``
+   For optional library dependencies, take a look at the scripts inside :master:`ci/`
    directory.
 
 Running single tests
diff --git a/doc/users/supported_systems.rst b/doc/users/supported_systems.rst
index 6220a96e0..4ac2bb08c 100644
--- a/doc/users/supported_systems.rst
+++ b/doc/users/supported_systems.rst
@@ -44,6 +44,8 @@ Oldest tested distributions
       - 2.17
       - \-
 
+For a full list of tested distros, please check :master:`.github/workflows/ci.yml`.
+
 Older distributions are not officially supported, which means that it
 may or may not work. It all depends on your luck. It should be possible
 to compile latest LTP even on slightly older distributions than we
@@ -99,7 +101,7 @@ Supported C libraries
       - Older uClibc might have problems.
 
     * - `musl <https://musl.libc.org/>`_
-      - Not yet fully supported. Check ``ci/alpine.sh`` script.
+      - Not yet fully supported. Check :master:`ci/alpine.sh` script.
 
     * - Android
       - Please use `AOSP fork <https://android.googlesource.com/platform/external/ltp>`_
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
