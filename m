Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ECAC4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 22:23:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C999C3CFE89
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 00:23:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05DDD3CE531
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 00:23:38 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F2F521A009A4
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 00:23:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F0E561FDFF;
 Thu, 25 Apr 2024 22:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714083816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Lr2dZ8tBAEgl+AlG0IE/yp0qmxlSHQ1G2/Rrp9bODQM=;
 b=IScK5ccBnNllIEbq3bPXmZkeOTefcwS2fyzqsnw0VFIGhAytM+SXtUZMenOZtlRx2iSRdd
 tdVmLOrIrJlgu7wo98ir2mPvVYfjtSb1VS2x2dir3DsXU3SduPtYcyjqdRj/qGHd3mwbiJ
 f43mjZQrA3mh/wNd5QbS0Gz3VjEIaTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714083816;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Lr2dZ8tBAEgl+AlG0IE/yp0qmxlSHQ1G2/Rrp9bODQM=;
 b=dnRbTJBCjUewkrZDSHrqRsnZeXs6kLvs3y/F40q0q/+FsB9RY8gzeh/8kyNd9SNVwPerZ/
 5tkTTrjQpuQCsMDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714083815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Lr2dZ8tBAEgl+AlG0IE/yp0qmxlSHQ1G2/Rrp9bODQM=;
 b=QVXkWAH2c37/CnjaPzQPcFVU21sQsTPokYrnDb077Pyi4uKKhgQ1dnNg/BZaLJ2KNLPFx5
 hNLClMuQFb0V1/Rh32xxALulf/cWXX0rlsr3ap7v0kAJlthyxs1z2yb9qAmYXIKPUEFZji
 OhVcK3k46us/oy5BXg14Z+LmRgUGyuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714083815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Lr2dZ8tBAEgl+AlG0IE/yp0qmxlSHQ1G2/Rrp9bODQM=;
 b=RUVbgDOZ5cN3d1/4qT1g/x9MX9W72HlOzPD9RXL9bOQUm8mJeefTyoPhf7CyFneQ/H4C+o
 NPRfSJ0Ipn6nz8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D436A13991;
 Thu, 25 Apr 2024 22:23:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L/kuM+fXKma6egAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Apr 2024 22:23:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 26 Apr 2024 00:23:31 +0200
Message-ID: <20240425222331.315701-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: Link file/directory names to GitHub sources
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

Convert all the files/directory names which actually points to real
files/directories to the links to GitHub sources. Exception is
datafiles/Makefile and some examples.

For now we use link to the master, maybe we want to change that if we
ever generate stable docs.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/conf.py                           |  2 +-
 doc/developers/test_case_tutorial.rst | 18 +++++++++---------
 doc/developers/writing_tests.rst      | 22 +++++++++++-----------
 doc/users/quick_start.rst             |  2 +-
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index d0f185b28..80f6df99b 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -162,7 +162,7 @@ def generate_syscalls_stats(_):
 
     # generate the statistics file
     tested_syscalls = [key for key, val in syscalls.items() if val]
-    text.append('syscalls which are tested under **testcases/kernel/syscalls**:\n\n')
+    text.append('syscalls which are tested under :master:`testcases/kernel/syscalls`:\n\n')
     text.append(f'* kernel syscalls: {len(ker_syscalls)}\n')
     text.append(f'* tested syscalls: {len(tested_syscalls)}\n\n')
 
diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
index 6ec618b9b..6c38fdbf1 100644
--- a/doc/developers/test_case_tutorial.rst
+++ b/doc/developers/test_case_tutorial.rst
@@ -56,7 +56,7 @@ test. At the time of writing there is no test for this call which was
 introduced in Linux kernel version 4.11.
 
 Linux system call specific tests are primarily contained in
-``testcases/kernel/syscalls``, but you should also ``git grep`` the entire LTP
+:master:`testcases/kernel/syscalls`, but you should also ``git grep`` the entire LTP
 repository to check for any existing usages of a system call.
 
 One way to find a system call which is not currently tested by the LTP is to
@@ -195,7 +195,7 @@ following line after ``testcases.mk``.
 
     statx01: CFLAGS += -pthread
 
-Assuming you are in the test's subdirectory ``testcases/kernel/syscalls/statx``,
+Assuming you are in the test's subdirectory :master:`testcases/kernel/syscalls/statx`,
 please do:
 
 .. code-block:: bash
@@ -204,10 +204,10 @@ please do:
     ./statx01
 
 This should build the test and then run it. However, even though the test is
-in the ``syscalls`` directory it won't be automatically ran as part of the
-syscalls test group (e.g. ``./runltp -f syscalls``).
-For this we need to add it to the ``runtest`` file. So open
-``runtest/syscalls`` and add the lines starting with a ``+``.
+in :master:`testcases/kernel/syscalls/` directory it won't be automatically ran
+as part of the syscalls test group (e.g. not run via ``kirk -r math`` or
+``./runltp -f syscalls``). For this we need to add it to the runtest file. So
+open :master:`runtest/syscalls` and add the lines starting with a ``+``.
 
 .. code-block::
 
@@ -219,9 +219,9 @@ For this we need to add it to the ``runtest`` file. So open
     stime01 stime01
     stime02 stime02
 
-The ``runtest`` files are in a two column format. The first column is the test
-name, which is mainly used by test runners for reporting and filtering. It is
-just a single string of text with no spaces. The second column, which can
+The :master:`runtest` files are in a two column format. The first column is the
+test name, which is mainly used by test runners for reporting and filtering. It
+is just a single string of text with no spaces. The second column, which can
 contain spaces, is passed to the shell in order to execute the test. Often it
 is just the executable name, but some tests also take arguments (the LTP has a
 library for argument parsing, by the way).
diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index daaa4b9f8..85a7a1d8a 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -211,7 +211,7 @@ There are several types of checks we use:
 
 * Sometimes it makes sense to define a few macros instead of creating a
   configure test. One example is Linux specific POSIX clock ids in
-  ``include/lapi/posix_clocks.h``
+  :master:`include/lapi/posix_clocks.h`.
 
 Dealing with messed up legacy code
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -242,11 +242,11 @@ portable shell or C. The test gets a configuration via environment variables
 and/or command line parameters, it prints additional information into the
 stdout and reports overall success/failure via the exit value.
 
-Tests are generally placed under the ``testcases/`` directory. Everything that
+Tests are generally placed under the :master:`testcases/` directory. Everything that
 is a syscall or (slightly confusingly) libc syscall wrapper, goes under
-``testcases/kernel/syscalls/``.
+:master:`testcases/kernel/syscalls/`.
 
-There is also ``testcases/open_posix_testsuite/`` which is a well maintained
+There is also :master:`testcases/open_posix_testsuite/` which is a well maintained
 fork of the Open POSIX testsuite project, that has been dead since 2005.
 
 We also have a number of directories with tests for more specific features, such
@@ -256,8 +256,8 @@ Runtest Files
 ~~~~~~~~~~~~~
 
 The list of tests to be executed is stored in runtest files under the
-``runtest/`` directory. The default set of runtest files to be executed is
-stored in ``scenario_groups/default``. When you add a test, you should add
+:master:`runtest/` directory. The default set of runtest files to be executed is
+stored in :master:`scenario_groups/default`. When you add a test, you should add
 corresponding entries into some runtest file(s) as well.
 
 Each line of runtest file contains one test. The first item is the test name.
@@ -270,9 +270,9 @@ All other items, separated by space will be executed as a command.
 
 Blank lines and lines starting with a ``#`` (comments) are ignored.
 
-Syscalls tests, placed under ``testcases/kernel/syscalls/``, use
-``runtest/syscalls`` file. For kernel related tests for memory management we
-have ``runtest/mm``, etc.
+Syscalls tests, placed under :master:`testcases/kernel/syscalls/`, use
+:master:`runtest/syscalls` file. For kernel related tests for memory management we
+have :master:`runtest/mm`, etc.
 
 .. note::
 
@@ -286,7 +286,7 @@ Datafiles
 If your test needs data files, these should be put into a subdirectory
 named ``datafiles`` and installed into the ``testcases/data/$TCID`` directory.
 This will require to add ``INSTALL_DIR := testcases/data/TCID`` into
-``datafiles/Makefile``.
+correspondent ``datafiles/Makefile``.
 
 You can obtain path to datafiles via ``$TST_DATAROOT`` provided by ``test.sh``
 or via C function ``tst_dataroot()`` provided by libltp:
@@ -337,7 +337,7 @@ Testing pre-release kernel features
 -----------------------------------
 
 Tests for features not yet in the mainline kernel release are accepted. However,
-they must be added only to the **staging** runtest file. Once a feature is part
+they must be added only to :master:`runtest/staging`. Once a feature is part
 of the stable kernel ABI, the associated test must be moved out of staging.
 
 Testing builds with GitHub Actions
diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
index 69792999b..4a48745be 100644
--- a/doc/users/quick_start.rst
+++ b/doc/users/quick_start.rst
@@ -123,4 +123,4 @@ Network tests
 -------------
 
 Network tests usually require a certain setup that is described in
-``testcases/network/README.md``.
+:master:`testcases/network/README.md`.
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
