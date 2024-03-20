Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5287C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:22:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20F813CFFAE
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:22:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7715A3CFBF2
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:48 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ADA0D1401656
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D5CB347BC;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlXwFVT+vWCpD5d3q8zxHSociMM2lTUxgloHYCYIfeY=;
 b=Bm+XBbicAJhkvZGGuKeQtkbef0X3zQsTuSm9Ln6qxLkwTZL6dcvzhK96c0Rjp0lvqur3oW
 ZG080RFcJNtw8ZPzAbg1jPY0qW1hAxZ2aptj6skuh3/iQnfWfwlsFKk64sLGGba7rZ285u
 p1zakzuYg8sNAA7yR3BRaHO2wjx42Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlXwFVT+vWCpD5d3q8zxHSociMM2lTUxgloHYCYIfeY=;
 b=PfGUPTjCDGCqT0I97dxgxlqoElwgePxp01Tp/oHIJ8pRuLef/0t5PtulSi3vO0t72EzOtE
 RQewz5wDoguBB2Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlXwFVT+vWCpD5d3q8zxHSociMM2lTUxgloHYCYIfeY=;
 b=Bm+XBbicAJhkvZGGuKeQtkbef0X3zQsTuSm9Ln6qxLkwTZL6dcvzhK96c0Rjp0lvqur3oW
 ZG080RFcJNtw8ZPzAbg1jPY0qW1hAxZ2aptj6skuh3/iQnfWfwlsFKk64sLGGba7rZ285u
 p1zakzuYg8sNAA7yR3BRaHO2wjx42Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mlXwFVT+vWCpD5d3q8zxHSociMM2lTUxgloHYCYIfeY=;
 b=PfGUPTjCDGCqT0I97dxgxlqoElwgePxp01Tp/oHIJ8pRuLef/0t5PtulSi3vO0t72EzOtE
 RQewz5wDoguBB2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 692AB1396E;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kMpuGN4M+2U/ZgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 20 Mar 2024 16:20:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 20 Mar 2024 17:20:48 +0100
MIME-Version: 1.0
Message-Id: <20240320-new_website-v1-4-79b603c8aea1@suse.com>
References: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
In-Reply-To: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Bm+XBbic;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PfGUPTjC
X-Rspamd-Queue-Id: 7D5CB347BC
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/10] Refactor patch review guidelines documentation
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

Patch review guidelines documentation has been refactored adding RST
syntax and fixing a couple of typos.
---
 doc_new/maintainers/patch_review.rst | 171 ++++++++++++++++++++++++++++++++++-
 1 file changed, 169 insertions(+), 2 deletions(-)

diff --git a/doc_new/maintainers/patch_review.rst b/doc_new/maintainers/patch_review.rst
index 1fb76b8bc..81d198532 100644
--- a/doc_new/maintainers/patch_review.rst
+++ b/doc_new/maintainers/patch_review.rst
@@ -1,4 +1,171 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
-Patch reviewing
-===============
+Patch review
+============
+
+Anyone can and should review patches. It's the only way to get good at patch
+review and for the project to scale. For this reason, we have a short guide on
+what to do during the review process.
+
+Goals of patch review
+---------------------
+
+#. Prevent false positive test results
+#. Prevent false negative test results
+#. Keep the code as simple as possible, but no simpler
+
+How to find clear errors
+------------------------
+
+A clear error is one where there is unlikely to be any argument if you
+provide evidence of it. Evidence being an error trace or logical proof
+that an error will occur in a common situation.
+
+The following are examples and may not be appropriate for all tests.
+
+* Merge the patch locally. It should apply cleanly to master.
+* Compile the patch with default and non-default configurations.
+
+  * Use sanitizers e.g. undefined behaviour, address.
+  * Compile on non-x86
+  * Compile on x86 with ``-m32``
+  * Compile testing patches with GitHub Actions in LTP repo fork can cover
+    various distros/architectures
+
+* Use ``make check``
+* Run effected tests in a VM
+
+  * Use single vCPU
+  * Use many vCPUs and enable NUMA
+  * Restrict RAM to < 1GB.
+
+* Run effected tests on an embedded device
+* Run effected tests on non-x86 machine in general
+* Run reproducers on a kernel where the bug is present
+* Run tests with ``-i0`` and ``-i2``
+* Compare usage of system calls with man page descriptions
+* Compare usage of system calls with kernel code
+* Double check commit message
+* Search the LTP library for existing helper functions
+* Check doc formatting, i.e. ``make doc && chromium docparse/metadata.html``
+
+How to find subtle errors
+-------------------------
+
+A subtle error is one where you can expect some argument because you
+do not have clear evidence of an error. It is best to state these as
+questions and not make assertions if possible.
+
+Although if it is a matter of style or "taste" then senior maintainers
+can assert what is correct to avoid bike shedding.
+
+* Ask what happens if there is an error, could it be debugged just
+  with the test output?
+* Are we testing undefined behavior?
+
+  * Could future kernel behaviour change without "breaking userland"?
+  * Does the kernel behave differently depending on hardware?
+  * Does it behave differently depending on kernel configuration?
+  * Does it behave differently depending on the compiler?
+  * Would it behave differently if the order of checks on syscall parameters
+    changed in the kernel?
+
+* Will it scale to tiny and huge systems?
+
+  * What happens if there are 100+ CPUs?
+  * What happens if each CPU core is very slow?
+  * What happens if there are 2TB of RAM?
+
+* Are we repeating a pattern that can be turned into a library function?
+* Is a single test trying to do too much?
+* Could multiple similar tests be merged?
+* Race conditions
+
+  * What happens if a process gets preempted?
+  * Could checkpoints or fuzzsync by used instead?
+  * Note, usually you can insert a sleep to prove a race condition
+    exists however finding them is hard
+
+* Is there a simpler way to achieve the same kernel coverage?
+
+How to get patches merged
+-------------------------
+
+Once you think a patch is good enough you should add your ``Reviewed-by``
+and/or ``Tested-by`` tags. This means you will get some credit for getting
+the patch merged. Also some blame if there are problems.
+
+If you ran the test you can add the ``Tested-by`` tag. If you read the
+code or used static analysis tools on it, you can add the Reviewed-by
+tag.
+
+In addition you can expect others to review your patches and add their
+tags. This will speed up the process of getting your patches merged.
+
+Maintainers Checklist
+---------------------
+
+Patchset should be tested locally and ideally also in maintainer's fork in
+GitHub Actions on GitHub.
+
+.. note::
+
+    GitHub Actions do only build testing, passing the CI means only that
+    the test compiles fine on variety of different distributions and releases.
+
+The test should be executed at least once locally and should PASS as well.
+
+Commit messages should have
+
+* Author's ``Signed-off-by`` tag
+* Committer's ``Reviewed-by`` or ``Signed-off-by`` tag
+* Check also mailing lists for other reviewers / testers tags, notes and failure
+  reports
+* ``Fixes: hash`` if it fixes particular LTP commit
+* ``Fixes: #N`` if it fixes github issue number N, so it's automatically closed
+* LTP documentation should be kept up to date.
+
+After patch is accepted or rejected, set correct state and archive in the
+`LTP patchwork instance <https://patchwork.ozlabs.org/project/ltp/list/>`_.
+
+New tests
+---------
+
+New test should
+
+* Have a record in runtest file
+* Test should work fine with more than one iteration (e.g. run with ``-i 100``)
+* Run with ``-i 0`` to check that setup and cleanup are coded properly
+  (no test is being run)
+* Have a brief description
+* License: the default license for new tests is GPL v2 or later, use
+  ``GPL-2.0-or-later``; the licence for test (e.g. GPL-2.0) should not change
+  unless test is completely rewritten
+* Old copyrights should be kept unless test is completely rewritten
+
+C tests
+~~~~~~~
+
+* Use the new C API, implementing ``struct tst_test``
+* Test binaries are added into corresponding ``.gitignore`` files
+* Check coding style with ``make check``
+* Docparse documentation
+* If a test is a regression test it should include ``.tags`` in the
+  ``struct tst_test`` definition
+* When rewriting old tests, `uClinux <https://en.wikipedia.org/wiki/%CE%9CClinux>`_
+  support should be removed (project has been discontinued).
+  E.g. remove ``#ifdef UCLINUX``, replace ``FORK_OR_VFORK()`` with simple
+  ``fork()`` or ``SAFE_FORK()``.
+
+Shell tests
+~~~~~~~~~~~
+
+* Use new shell API
+* Check coding style with ``make check``
+* If a test is a regression test it should include related kernel or glibc
+  commits as a comment
+
+LTP library
+~~~~~~~~~~~
+
+For patchset touching the LTP library, follow the LTP library guidelines.

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
