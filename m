Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784F4C79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:05:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A885F3E2F03
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:05:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A59F43E53C4
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E65C714002A7
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 53D6D1FE76;
 Fri, 11 Sep 2026 07:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcrVY3bxUURqI+JtEfQ08rtpEsXjRJi68kgkamyPQXo=;
 b=rOOAga7Sf1tED+jMIZu2oELjkuTHmkUcedmI6lPgfnGTOOYESp6alWzGkqu+feJKTj4JCO
 Z+VtoJ+AmfjnlQC/EcOVJDh+fxGiwGR4Vj9YmtEqLTX2l6o6JBHRZKvCmLFV09tIoqNXbs
 yEibqTMArKEddAutO3K6I9bJnPSaPJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcrVY3bxUURqI+JtEfQ08rtpEsXjRJi68kgkamyPQXo=;
 b=47NryWkmRTV6msl4IGBXnGOPy0m/UIXbzda+BRlCESOO/M164urjaADtmBCuaHQx7XtXvV
 ArdMixWTFOmUmuDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A2dcirKT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QfRcwywq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcrVY3bxUURqI+JtEfQ08rtpEsXjRJi68kgkamyPQXo=;
 b=A2dcirKT1NrIzEsfpxZ8ylbClQOA2BzBRa/DWA1dyeWHrcpX5XvdQnanTtnKcgWXSv5h0E
 u52DNfDilqyYDQ1aJstN6QQg9+LdP3UUM7mOsOA9k5ILjcRQK1OSAa9WaTBPJNu4U7nIWO
 XYyl9WhtEainR6fIW4eaV5w5F6DARR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcrVY3bxUURqI+JtEfQ08rtpEsXjRJi68kgkamyPQXo=;
 b=QfRcwywqfACjeLOfIpaD24dGrJKDg0zyo1eghGyaUyvOdYdmLIeTVTcMBZnlBRK8W+Rdct
 y7o7ujKBTAxhRWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD29513770;
 Fri, 11 Sep 2026 07:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QLlnMPSno2qwLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 07:04:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 09:04:18 +0200
MIME-Version: 1.0
Message-Id: <20260911-fix_documentation-v2-2-716b2613c477@suse.com>
References: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
In-Reply-To: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110260; l=13347;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=ImNpa/qjmvJmjoV/Mr1SjCk/mTGxQH4FMiZY35Z65TI=;
 b=UF+ldnLzU2hLgK8ibFeomhgHLLDyaawJafEbUFFhf5LAEAL+snMta5xfDspEfztXbQXlXDudy
 aabAaJ+hNI8C1yHWqQJN8gjXRXeJMecJirFT0aqssRlwbZdUJH7DpEv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 53D6D1FE76
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.com:mid,suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/9] doc: Correct guide and API descriptions
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

Fix tutorial command options, the cleanup descriptor handling example,
and typo fixes. Correct the CPP variable name in the build system guide
and fix grammar and section references in INSTALL. Complete the argv
documentation for tst_cmd(), fix /proc paths and exit condition in
process state documentation, and correct comparison macro and NUMA types.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 INSTALL                               | 10 +++++-----
 doc/developers/build_system.rst       |  2 +-
 doc/developers/test_case_tutorial.rst | 27 +++++++++++++++------------
 include/tse_numa.h                    |  2 +-
 include/tst_cmd.h                     |  2 ++
 include/tst_process_state.h           |  8 ++++----
 include/tst_test_macros.h             | 24 ++++++++++++------------
 7 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/INSTALL b/INSTALL
index b5c89de32..2a6b5aac2 100644
--- a/INSTALL
+++ b/INSTALL
@@ -113,7 +113,7 @@ groups.  If these IDs do not exist, certain tests will fail. The respective
 user and group IDs should be the same, i.e. if `nobody's' user ID is 99, then
 its group ID should also be 99. The names of the groups are irrelevant.
 - The installation directory is /opt/ltp by default. Please see
-"Using autoconf" above and specify the appropriate path via --prefix.
+"Configuration" above and specify the appropriate path via --prefix.
 DESTDIR= is also honored for install and will install into $DESTDIR/$prefix,
 if you want to install into a chroot or a rootfs for instance.
 
@@ -139,7 +139,7 @@ contributions are welcome.
 3. Build and install everything, as described above. Note the minimum software
    requirements above before doing so.
 
-4. The network tests related installation see testcases/network/README.md.
+4. For network test installation, see testcases/network/README.md.
 
 Cross compiling
 ---------------
@@ -150,7 +150,7 @@ For correct pkgconf / pkg-config detection you need to set
 PKG_CONFIG_SYSROOT_DIR=$SYSROOT
 
 After configure has run, it will generate include/mk/config.mk. You can tweak
-settings in there if need be, but you should not specificy settings on the
+settings in there if need be, but you should not specify settings on the
 command-line when running make.
 
 32 bit build on 64 bit machine
@@ -161,7 +161,7 @@ You need to set CFLAGS=-m32 LDFLAGS=-m32 and PKG_CONFIG_LIBDIR
 * RPM based distributions (openSUSE, Fedora, etc.)
 PKG_CONFIG_LIBDIR=/usr/lib/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure
 
-* Debian / Ubuntu and derivates
+* Debian / Ubuntu and derivatives
 PKG_CONFIG_LIBDIR=/usr/lib/i386-linux-gnu/pkgconfig CFLAGS=-m32 LDFLAGS=-m32 ./configure
 
 * Arch Linux
@@ -174,7 +174,7 @@ LTP contains few kernel modules and tests which are using them.
 These require to be built with the same kernel headers as the running kernel (SUT).
 Sometimes the best way to achieve this is to compile them on the SUT.
 
-Due Linux Kernel Driver Interface unstability [1], error during building kernel
+Due to Linux Kernel Driver Interface instability [1], an error during building kernel
 modules does not break the build. Make errors fatal can be done by FORCE_MODULES=1
 make variable.
 
diff --git a/doc/developers/build_system.rst b/doc/developers/build_system.rst
index 8af431517..e62db7d97 100644
--- a/doc/developers/build_system.rst
+++ b/doc/developers/build_system.rst
@@ -135,7 +135,7 @@ been fulfilled (libraries, headers, etc).
     * - $(CC)
       - The system C compiler
 
-    * - $(CCP)
+    * - $(CPP)
       - The system C preprocessor
 
     * - $(CFLAGS)
diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
index 930e0f989..679de7cde 100644
--- a/doc/developers/test_case_tutorial.rst
+++ b/doc/developers/test_case_tutorial.rst
@@ -205,7 +205,7 @@ please do:
 
 This should build the test and then run it. However, even though the test is
 in :master:`testcases/kernel/syscalls` directory it won't be automatically run
-as part of the syscalls test group (e.g. not run via ``kirk -f math``).
+as part of the syscalls test group (e.g. not run via ``kirk -f syscalls``).
 For this we need to add it to the runtest file. So open :master:`runtest/syscalls`
 and add the lines starting with a ``+``.
 
@@ -292,7 +292,7 @@ Check coding style with ``make check``.
 Install the LTP and run the test with runtest
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Run ``statx01`` on its own, also using ``-I0`` amd ``-I10``.
+Run ``statx01`` on its own, also using ``-i 0`` and ``-i 10``.
 
 Call the system call
 --------------------
@@ -435,7 +435,7 @@ there is a system in place to handle it.
         .min_kver = "4.11",
     };
 
-The ``TEST`` macro sets ``TST_RET`` to the return value of ``tst_statx()`` and
+The ``TEST`` macro sets ``TST_RET`` to the return value of ``sys_statx()`` and
 ``TST_ERR`` to the value of ``errno`` immediately after the functions
 return. This is mainly just for convenience, although it potentially could
 have other uses.
@@ -589,6 +589,9 @@ again on the hard-link, then ``stat`` the file".
 
     #define LNAME "file_to_stat_link"
 
+    static int fd = -1;
+    static int lfd = -1;
+
     ...
 
     static void setup(void)
@@ -600,16 +603,16 @@ again on the hard-link, then ``stat`` the file".
 
     static void cleanup(void)
     {
-        if (lfd != 0)
+        if (lfd != -1)
             SAFE_CLOSE(lfd);
 
-        if (fd != 0)
+        if (fd != -1)
             SAFE_CLOSE(fd);
     }
 
     static void run(void)
     {
-            ...
+        ...
 
         TEST(sys_statx(AT_FDCWD, LNAME, 0, STATX_BASIC_STATS, &statxbuf));
         if (TST_RET == 0)
@@ -646,8 +649,8 @@ Nor do we want to call ``cleanup`` recursively. So during ``cleanup``
 ``tst_brk``, and consequently the ``SAFE`` functions, do not cause the test to
 exit with ``TBROK``. Instead they just print an error message with ``TWARN``.
 
-It is not entirely necessary to check if the file descriptors have a none zero
-value before attempting to close them. However it avoids a bunch of spurious
+It is not entirely necessary to check if the file descriptors are not -1
+before attempting to close them. However it avoids a bunch of spurious
 warning messages if we fail to open ``file_to_stat``. Test case failures can be
 difficult to interpret at the best of times, so avoid filling the log with
 noise.
@@ -804,7 +807,7 @@ branch is ``tutorial-rebase2`` which I just created. I have already done one
 ``tutorial``.
 
 As usual my commit history is starting to look like a bit of mess! There is
-even a commit in there which should not be in the this branch (Remove old API
+even a commit in there which should not be in this branch (Remove old API
 argument), however it can be ignored for now and 'cherry picked' into a new branch
 later.
 
@@ -821,7 +824,7 @@ of all I want to 'squash' (amalgamate) all the commits appended with
 This begins an interactive ``rebase`` where commit ``5ca6427b78`` is the earliest
 commit we want to edit. The ``^`` symbol after the commit hash, specifies the
 commit before this one. The interactive ``rebase`` command takes the last commit
-we want to keep unaltered as it's argument (in other words it takes a
+we want to keep unaltered as its argument (in other words it takes a
 non-inclusive range).
 
 Upon entering a similar command you will be presented with a text file
@@ -993,8 +996,8 @@ Obviously testing the patch is one way of finding errors. You can apply patches
 using :manpage:`git-am(1)`. Then it is just a case of compiling and running the
 tests.
 
-Finally, reading and attempting to comment on other peoples patches, gives
-you a better understanding of the reviewers perspective. This is better for
+Finally, reading and attempting to comment on other people's patches, gives
+you a better understanding of the reviewer's perspective. This is better for
 the project and for you.
 
 Style and organizational issues are best left to after you have found logical
diff --git a/include/tse_numa.h b/include/tse_numa.h
index 839512b2a..4cbef63b7 100644
--- a/include/tse_numa.h
+++ b/include/tse_numa.h
@@ -109,7 +109,7 @@ enum tse_numa_types {
  * tse_get_nodemap() - Allocates and returns numa node map, which is an array of numa nodes which
  * contain desired resources e.g. memory.
  *
- * @type:       Bitflags of enum tst_numa_types specifying desired resources.
+ * @type:       Bitflags of enum tse_numa_types specifying desired resources.
  * @min_mem_kb: Minimal free RAM on memory nodes, if given node has less than
  *             requested amount of free+buffers memory it's not included in
  *             the resulting list of nodes.
diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index 77fbbbc86..4829d0aed 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -72,6 +72,8 @@ static inline int tst_cmd_fds(const char *const argv[],
  * tst_cmd() - Executes tst_cmd_fds() and redirects its output to a file.
  *
  * @argv: A list of two (at least program name + NULL) or more pointers that
+ * represent the argument list to the new program. The array of pointers
+ * must be terminated by a NULL pointer.
  * @stdout_path: Path where to redirect stdout. Set NULL if redirection is
  * not needed.
  * @stderr_path: Path where to redirect stderr. Set NULL if redirection is
diff --git a/include/tst_process_state.h b/include/tst_process_state.h
index b0f640b06..674c54b0f 100644
--- a/include/tst_process_state.h
+++ b/include/tst_process_state.h
@@ -22,7 +22,7 @@
  * @state: A state to wait for.
  * @msec_timeout: A timeout for the wait.
  *
- * Polls `/proc/$PID/state` for a process state changes.
+ * Polls `/proc/$PID/stat` for process state changes.
  *
  * Possible process states (see :manpage:`ps(1)`):
  *
@@ -32,7 +32,7 @@
  * - **Z** Zombie process.
  * - **T** Process is traced.
  * - **t** Tracing stopped.
- * - **X** Process id dead.
+ * - **X** Process is dead.
  */
 #define TST_PROCESS_STATE_WAIT(pid, state, msec_timeout) \
 	tst_process_state_wait(__FILE__, __LINE__, NULL, \
@@ -41,7 +41,7 @@
 /**
  * TST_PROCESS_EXIT_WAIT() - Waits while pid is present on the system.
  *
- * Loops until `kill($PID, 0)` succeds or timeout is reached.
+ * Loops until `kill($PID, 0)` fails with `ESRCH`, or timeout is reached.
  *
  * @pid: A process pid.
  * @msec_timeout: A timeout for the wait.
@@ -52,7 +52,7 @@
 /**
  * TST_THREAD_STATE_WAIT() - Waits for a thread state change.
  *
- * Polls `/proc/self/task/$TID/state` for a thread state change.
+ * Polls `/proc/self/task/$TID/stat` for a thread state change.
  *
  * Possible thread states are the same as for TST_PROCESS_STATE_WAIT().
  *
diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 12bd9d47e..9a93331d5 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -880,10 +880,10 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu")
 
 /**
- * TST_EXP_EQ_SZ() - Compare two unsigned size_t values.
+ * TST_EXP_EQ_SZ() - Compare two size_t values.
  *
- * @VAL_A: unsigned long long value A.
- * @VAL_B: unsigned long long value B.
+ * @VAL_A: size_t value A.
+ * @VAL_B: size_t value B.
  *
  * Reports a pass if values are equal and a fail otherwise.
  */
@@ -898,10 +898,10 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 } while (0)
 
 /**
- * TST_EXP_EQ_SZ_SILENT() - Compare two unsigned size_t values, silent variant.
+ * TST_EXP_EQ_SZ_SILENT() - Compare two size_t values, silent variant.
  *
- * @VAL_A: unsigned long long value A.
- * @VAL_B: unsigned long long value B.
+ * @VAL_A: size_t value A.
+ * @VAL_B: size_t value B.
  *
  * Unlike TST_EXP_EQ_SZ() does not print :c:enum:`TPASS <tst_res_flags>` on
  * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
@@ -910,10 +910,10 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu")
 
 /**
- * TST_EXP_EQ_SSZ() - Compare two unsigned ssize_t values.
+ * TST_EXP_EQ_SSZ() - Compare two ssize_t values.
  *
- * @VAL_A: unsigned long long value A.
- * @VAL_B: unsigned long long value B.
+ * @VAL_A: ssize_t value A.
+ * @VAL_B: ssize_t value B.
  *
  * Reports a pass if values are equal and a fail otherwise.
  */
@@ -928,10 +928,10 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 } while (0)
 
 /**
- * TST_EXP_EQ_SSZ_SILENT() - Compare two unsigned ssize_t values, silent variant.
+ * TST_EXP_EQ_SSZ_SILENT() - Compare two ssize_t values, silent variant.
  *
- * @VAL_A: unsigned long long value A.
- * @VAL_B: unsigned long long value B.
+ * @VAL_A: ssize_t value A.
+ * @VAL_B: ssize_t value B.
  *
  * Unlike TST_EXP_EQ_SSZ() does not print :c:enum:`TPASS <tst_res_flags>` on
  * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
