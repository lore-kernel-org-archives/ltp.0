Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145DBCD6E56
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 09:53:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AA2E3E56D4
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 11:53:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFF853E48AE
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:52:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BA2C0600837
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 11:52:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D790F66E51;
 Mon,  1 Jun 2026 09:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780307577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMguafUOEqW0h5f6CLV22eQ5JhDVGx+I/TBXCuPzKJg=;
 b=0PffMpIfJuz3BzSa4crEMnYM6cPvpxHCFvLkU/NVWUpA6/LRqxmpIqWS5ZwL9hYqtpxzUb
 BBR9eKpn9PBVXVNww1k8gvE87b120LyhINO1xg/D2a5sgKsPdhTX2H41NmtuiLhEEcc5Ud
 twaky4yXKmZ1etZ4I7LqSd9PouqVF3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780307577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMguafUOEqW0h5f6CLV22eQ5JhDVGx+I/TBXCuPzKJg=;
 b=JpxOVGkmxa61SNa7nFR00cVLnYMrh4pCT97b4mzrap93F84F3BC6b8NZTnVJSrjKOZVu0q
 hDkmxt/F6M11+yAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AZR+e0gS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=z7UVEJGb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780307576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMguafUOEqW0h5f6CLV22eQ5JhDVGx+I/TBXCuPzKJg=;
 b=AZR+e0gS4wLXJ3e3k+PJREok29ZQvne4Nl0EzdIAbNoyjUoa08O4zIT7Ef/ovb49N5lKV7
 NEa8woLMDkg8zJTgBVjeJVid6sw+sNq/2OIGAOn0hzv0r0gbZMxmtIcYqTXgk64mTPK6zx
 Jn59Qt12E/p9kk0Y8GR1Hq9a5Ho29U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780307576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMguafUOEqW0h5f6CLV22eQ5JhDVGx+I/TBXCuPzKJg=;
 b=z7UVEJGb8bm0txmA1f6f73kFE4LEXkbPNw5o2/DcY86lyjX/UZvRyAmUAF61SmISygzQb9
 DqtuItRKgQfmA5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBD53779A8;
 Mon,  1 Jun 2026 09:52:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KFs8LHhWHWrqZwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jun 2026 09:52:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jun 2026 11:52:54 +0200
MIME-Version: 1.0
Message-Id: <20260601-doc_update-v1-1-b0f59834fbae@suse.com>
References: <20260601-doc_update-v1-0-b0f59834fbae@suse.com>
In-Reply-To: <20260601-doc_update-v1-0-b0f59834fbae@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780307576; l=10353;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=pcdh00XUW9dIb/p6Tz1nUzviN6ruaHfFtBBPM9CX7Jw=;
 b=dJVAbSRNDEpbx66mFiwrbmUQAlt/pG6V+f9OeVsQR4kqMpfwnF5bBJLqFSwaJA1chxWUS8hmu
 w95NvkG3VCiDo9804Zg+WCBmCoISz3DOZXAEaRkggetu/hIto5QuAwZ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D790F66E51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux-test-project.readthedocs.io:url,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] doc: Fix broken references and outdated content
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

Fix kernel-doc reference to renamed tse_numa.h header, correct
TST_EXP_POSSITIVE typo and RST formatting in tst_test_macros.h,
use :c:struct: instead of :ref: for struct cross-references, fix
broken lapi/ :master: links, drop stale lapi/stat.h notes, correct
kirk invocation example and use md5sum/sha1sum commands.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/developers/api_c_tests.rst            |  2 +-
 doc/developers/api_shell_tests.rst        |  2 +-
 doc/developers/test_case_tutorial.rst     | 19 ++++++++-----------
 doc/developers/todo.rst                   |  2 +-
 doc/developers/writing_tests.rst          |  6 +++---
 doc/maintainers/ltp_release_procedure.rst |  4 ++--
 doc/maintainers/patch_review.rst          |  6 +++---
 include/tst_test_macros.h                 |  8 ++++----
 8 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index 26b46d92d9f0aa724f10a960b6c5cce59ae1d3e8..65cf6d6cd0be5cb4cd9c986e09df021071d968f1 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -50,7 +50,7 @@ Process state
 
 NUMA
 ----
-.. kernel-doc:: ../../include/tst_numa.h
+.. kernel-doc:: ../../include/tse_numa.h
 
 Option parsing
 --------------
diff --git a/doc/developers/api_shell_tests.rst b/doc/developers/api_shell_tests.rst
index 51bb04a4e155e83c3302b4664886d49624f51a9f..9a3ff795f1b0cedbfa3b126fe0acad8d24e5c704 100644
--- a/doc/developers/api_shell_tests.rst
+++ b/doc/developers/api_shell_tests.rst
@@ -30,7 +30,7 @@ documentation at https://linux-test-project.readthedocs.io/en/latest/users/test_
 The shell loader test library uses the :doc:`../developers/api_c_tests`
 internally by parsing a special JSON formatted comment and
 initializing it accordingly. The JSON format is nearly 1:1 serialization of the
-:ref:`struct tst_test` into a JSON. The environment must be always preset even
+:c:struct:`tst_test` into a JSON. The environment must be always preset even
 when it's empty.
 
 .. code-block:: shell
diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
index 240897e36b8fd7c5f70cf426f81ef4bfc0e562a0..28eda5ae69f7e358383ae44d5d23bd2e4d79b487 100644
--- a/doc/developers/test_case_tutorial.rst
+++ b/doc/developers/test_case_tutorial.rst
@@ -137,7 +137,7 @@ initialization code. It is important to note that this is a completely
 ordinary, independent C program, however ``main()`` is missing because it is
 implemented in :master:`include/tst_test.h`.
 
-We specify what code we want to run as part of the test using :ref:`struct tst_test`.
+We specify what code we want to run as part of the test using :c:struct:`tst_test`.
 Various callbacks can be set by the test writer, including
 ``test.test_all``, which we have set to ``run()``. The test harness will execute
 this callback in a separate process (using ``fork()``), forcibly terminating it
@@ -205,8 +205,8 @@ please do:
 
 This should build the test and then run it. However, even though the test is
 in :master:`testcases/kernel/syscalls` directory it won't be automatically ran
-as part of the syscalls test group (e.g. not run via ``kirk -r math``.  For
-this we need to add it to the runtest file. So open :master:`runtest/syscalls`
+as part of the syscalls test group (e.g. not run via ``kirk -f syscalls``).
+For this we need to add it to the runtest file. So open :master:`runtest/syscalls`
 and add the lines starting with a ``+``.
 
 .. code-block::
@@ -517,15 +517,14 @@ that should be by setting ``.needs_tmpdir = 1``.
     /*************** statx structure and wrapper goes here ! ***************/
     ...
 
-We have added an extra include :master:`lapi/fcntl.h` which wraps the system header by
+We have added an extra include :master:`include/lapi/fcntl.h` which wraps the system header by
 the same name (``#include <fcntl.h>``). This header ensures we have definitions
 for recently added macros such as ``AT_FDCWD`` by providing fall backs if the
-system header does not have them. The :master:`lapi/` directory contains a number of
+system header does not have them. The :master:`include/lapi/` directory contains a number of
 headers like this.
 
-At some point we may wish to add :master:`lapi/stat.h` to provide a fall back for
-macros such as ``STATX_BASIC_STATS``. However for the time being we have just
-defined it in the test.
+The :master:`include/lapi/stat.h` header provides similar fall backs for
+macros such as ``STATX_BASIC_STATS`` used by this test.
 
 
 .. code-block:: c
@@ -759,9 +758,7 @@ the next section and come back later.
 Submitting the test for review
 ------------------------------
 
-Ignoring the fact we should probably create :master:`lapi/stat.h` along with a bunch
-of fallback logic in the build system. We can now get our test ready for
-submission.
+We can now get our test ready for submission.
 
 The first thing you need to do before considering submitting your test is run
 ``make check-statx01`` or ``make check`` in the test's directory. Again, we use
diff --git a/doc/developers/todo.rst b/doc/developers/todo.rst
index 4ca8612db727bf6f5b7f5ed055ae512f077f246a..9f74533807f8dfcd6e85a6540196e8de748d9da8 100644
--- a/doc/developers/todo.rst
+++ b/doc/developers/todo.rst
@@ -61,5 +61,5 @@ LTP root folder:
 
 LTP also provides a shell loader implementation for plain-C tests inside
 :master:`testcases/lib/tst_run_shell.c` and it permits to run shell tests
-into plain-C LTP API, featuring :ref:`struct tst_test` initializations and a
+into plain-C LTP API, featuring :c:struct:`tst_test` initializations and a
 direct access to kernel syscalls.
diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 35ae84c6ddd35cb83b59d6333235d1d3db3d87fd..b875903c2a6caf7c5ef75066b4fcaec108594b2b 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -138,7 +138,7 @@ The following linting code can be found when we run ``make check``:
 
     * - LTP-005
       - Array must terminate with a sentinel value (i.e. ``NULL`` or ``{}``)
-      - When defining arrays in the :ref:`struct tst_test` structure, we need to
+      - When defining arrays in the :c:struct:`tst_test` structure, we need to
         end the array items with a sentinel ``NULL`` value.
 
 Shell coding style
@@ -361,7 +361,7 @@ LTP C And Shell Test API Comparison
 .. list-table::
     :header-rows: 1
 
-    * - C API :ref:`struct tst_test` members
+    * - C API :c:struct:`tst_test` members
       - Shell API ``$TST_*`` variables
 
     * - .all_filesystems
@@ -531,5 +531,5 @@ LTP C And Shell Test API Comparison
     * - C API other structs
       - Shell API ``$TST_*`` variables
 
-    * - :ref:`struct tst_device`
+    * - ``struct tst_device``
       - TST_DEVICE
diff --git a/doc/maintainers/ltp_release_procedure.rst b/doc/maintainers/ltp_release_procedure.rst
index 6dbafa4f81ebd3c843ef66547340012c59521fb8..7851440125ba54707026d3d380e2b3ef0def368d 100644
--- a/doc/maintainers/ltp_release_procedure.rst
+++ b/doc/maintainers/ltp_release_procedure.rst
@@ -112,8 +112,8 @@ metadata documentation:
     tar -cJf ltp-full-YYYYMMDD.tar.xz ltp-full-YYYYMMDD --exclude .git
 
     # Generate checksums
-    md5 ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.md5
-    sha1 ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.sha1
+    md5sum    ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.md5
+    sha1sum   ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.sha1
     sha256sum ltp-full-YYYYMMDD.tar.xz > ltp-full-YYYYMMDD.tar.xz.sha256
 
 You can use :master:`tools/create-tarballs-metadata.sh` script to have the above
diff --git a/doc/maintainers/patch_review.rst b/doc/maintainers/patch_review.rst
index 28bc4faf343047edfcf647b38f053f923b7de5c7..a328948094029c2a6c2b550c66df8e0236c0ab42 100644
--- a/doc/maintainers/patch_review.rst
+++ b/doc/maintainers/patch_review.rst
@@ -146,12 +146,12 @@ New test should
 C tests
 ~~~~~~~
 
-* Use :doc:`../developers/api_c_tests`, implementing :ref:`struct tst_test`
+* Use :doc:`../developers/api_c_tests`, implementing :c:struct:`tst_test`
 * Test binaries are added into corresponding ``.gitignore`` files
 * Check coding style with ``make check``
 * Metadata documentation
-* If a test is a regression test it should include :ref:`.tags<struct tst_tag>` in the
-  :ref:`struct tst_test` definition
+* If a test is a regression test it should include :c:struct:`.tags <tst_tag>` in the
+  :c:struct:`tst_test` definition
 
 Shell tests
 ~~~~~~~~~~~
diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index b1e74278d5ddb25293d38507482dc5a5cdafdbd0..f06c8aeb77558c0c09880f905ccc5b85d9f277a3 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -146,7 +146,7 @@ extern int TST_PASS;
  * @SCALL: Tested syscall.
  * @...: A printf-like parameters.
  *
- * This is a variant of the TST_EXP_POSSITIVE() for a more specific case that
+ * This is a variant of the TST_EXP_POSITIVE() for a more specific case that
  * the returned value is a file descriptor.
  */
 #define TST_EXP_FD(SCALL, ...)                                                 \
@@ -200,7 +200,7 @@ extern int TST_PASS;
  * @SCALL: Tested syscall.
  * @...: A printf-like parameters.
  *
- * This is a variant of the TST_EXP_POSSITIVE() for a more specific case that
+ * This is a variant of the TST_EXP_POSITIVE() for a more specific case that
  * the returned value is a pid.
  */
 #define TST_EXP_PID(SCALL, ...)                                                \
@@ -379,8 +379,8 @@ extern int TST_PASS;
  * @...: A printf-like parameters.
  *
  * This macro works like TST_EXP_PASS_PTR_VOID() but checks the return
- * value against NULL instead of (void *)-1. Use this for libc functions
- * such as fopen() that return NULL on failure.
+ * value against NULL instead of ``(void *)-1``. Use this for libc functions
+ * such as :manpage:`fopen(3)` that return NULL on failure.
  */
 #define TST_EXP_PASS_PTR_NULL(SCALL, ...)                                      \
 	TST_EXP_PASS_PTR_(SCALL, #SCALL, NULL, ##__VA_ARGS__)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
