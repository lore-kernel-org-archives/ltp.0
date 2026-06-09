Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF2DCD8CA8
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 10:32:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3CBA3E5EA7
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 12:32:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10EA63E6F2C
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 12:32:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 966BA200155
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 12:32:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 375516AB54;
 Tue,  9 Jun 2026 10:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781001120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jA8nAVZd9wRuARmTj9+SYIZf38N9aKW/HN/1ncLIIL8=;
 b=DJYuQV4hGNzNvAfeuc7D4kWH68S0aKVE2TYLB/jcbazC3EqciNHfdpGBfKUdbWL3SYG46A
 p+TUQkVlpeGewY5Qo5OTNOBRnqc2fC05hvjQerCoqmBUJMrmCSK2TUID6aDbvRec6uJGlz
 KKoYFsOe7Zmh4Hvxt4CaTXzoqS3ILow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781001120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jA8nAVZd9wRuARmTj9+SYIZf38N9aKW/HN/1ncLIIL8=;
 b=T6zYg2vK5Aky4BwCbEkRaTORzyxFIwgRpxR5OELCd6VwvpNt4mwg0C+hoNfKi8GJfMaXw3
 qyYtkzxrnHJuoUAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781001120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jA8nAVZd9wRuARmTj9+SYIZf38N9aKW/HN/1ncLIIL8=;
 b=DJYuQV4hGNzNvAfeuc7D4kWH68S0aKVE2TYLB/jcbazC3EqciNHfdpGBfKUdbWL3SYG46A
 p+TUQkVlpeGewY5Qo5OTNOBRnqc2fC05hvjQerCoqmBUJMrmCSK2TUID6aDbvRec6uJGlz
 KKoYFsOe7Zmh4Hvxt4CaTXzoqS3ILow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781001120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jA8nAVZd9wRuARmTj9+SYIZf38N9aKW/HN/1ncLIIL8=;
 b=T6zYg2vK5Aky4BwCbEkRaTORzyxFIwgRpxR5OELCd6VwvpNt4mwg0C+hoNfKi8GJfMaXw3
 qyYtkzxrnHJuoUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B97B779A7;
 Tue,  9 Jun 2026 10:32:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UCASBaDrJ2ptYQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 09 Jun 2026 10:32:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 09 Jun 2026 12:31:58 +0200
MIME-Version: 1.0
Message-Id: <20260609-doc_add_missing_headers-v7-2-779c18caddef@suse.com>
References: <20260609-doc_add_missing_headers-v7-0-779c18caddef@suse.com>
In-Reply-To: <20260609-doc_add_missing_headers-v7-0-779c18caddef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781001119; l=7632;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=8Vb6UNuXH7pxpkFm2B7PuWFBfJ9k1yVPOc15zVJzFTQ=;
 b=p83YYCHF/S4jD7ToWeXuIf2Q0AqmlMSCrXTIgAshtTTd1IIm8aS+iMC0rUeyXNPKdtv1zGjZ2
 9cv3SqGjTmYBU+Zbprask7oPbnJNUziirWBTZi7/5ophypLE89bM8Y9
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.27 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.17)[-0.833]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 2/2] doc: Complete struct tst_test table and shell
 API docs
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

Add 8 missing struct tst_test fields to the C/Shell API comparison
table in writing_tests.rst: .filesystems, .forks_child, .min_runtime,
.needs_abi_bits, .needs_cgroup_nsdelegate, .needs_cgroup_ver,
.needs_hugetlbfs and .runs_script, and fix the alphabetical ordering
of .mnt_flags and .min_swap_avail.

Add a shell API variables reference section to api_shell_tests.rst
documenting all public TST_* input/output variables, checkpoint
functions, and retry helpers.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/developers/api_shell_tests.rst | 183 +++++++++++++++++++++++++++++++++++++
 doc/developers/writing_tests.rst   |  28 +++++-
 2 files changed, 209 insertions(+), 2 deletions(-)

diff --git a/doc/developers/api_shell_tests.rst b/doc/developers/api_shell_tests.rst
index 937ffee2ea468552e5160775153990f13ea10f88..a70b118db544137850368bb4502c4e93ab1a1589 100644
--- a/doc/developers/api_shell_tests.rst
+++ b/doc/developers/api_shell_tests.rst
@@ -93,3 +93,186 @@ interrupted by :ref:`tst_brk`.
 
    .. literalinclude:: ../../testcases/lib/tests/shell_loader_setup_cleanup.sh
       :language: shell
+
+Shell API variables
+-------------------
+
+The following variables are available to shell tests. Variables marked
+*input* are set by the test before sourcing ``tst_run.sh``; variables
+marked *output* are set by the library for tests to read.
+
+Test definition (input)
+~~~~~~~~~~~~~~~~~~~~~~~
+
+``TST_TESTFUNC``
+    Name of the test function (required).
+
+``TST_CNT``
+    Number of test cases. When set the test function is called
+    ``TST_CNT`` times with a counter argument.
+
+``TST_SETUP``
+    Name of the setup function (called once before tests).
+
+``TST_CLEANUP``
+    Name of the cleanup function (called once after tests or on
+    ``tst_brk``).
+
+``TST_OPTS``
+    Extra getopts option string.
+
+``TST_PARSE_ARGS``
+    Name of a function to parse extra options from ``TST_OPTS``.
+
+``TST_USAGE``
+    Name of a function printing extra usage information.
+
+``TST_POS_ARGS``
+    Number of expected positional arguments.
+
+``TST_TEST_DATA``
+    Space-separated data passed as a second argument to the test
+    function.
+
+``TST_TEST_DATA_IFS``
+    Custom delimiter for ``TST_TEST_DATA`` (default: space).
+
+Requirements (input)
+~~~~~~~~~~~~~~~~~~~~
+
+``TST_NEEDS_ROOT``
+    Set to 1 to require root privileges.
+
+``TST_NEEDS_TMPDIR``
+    Set to 1 to create a temporary directory.
+
+``TST_NEEDS_DEVICE``
+    Set to 1 to prepare a block device.
+
+``TST_NEEDS_CMDS``
+    Space-separated list of required commands.
+
+``TST_NEEDS_MODULE``
+    Kernel module name that must be loadable.
+
+``TST_NEEDS_DRIVERS``
+    Space-separated list of required kernel drivers.
+
+``TST_NEEDS_KCONFIGS``
+    Space-separated list of required kernel config options
+    (e.g. ``CONFIG_NUMA=y``).
+
+``TST_NEEDS_KCONFIGS_IFS``
+    Custom delimiter for ``TST_NEEDS_KCONFIGS`` (default: comma).
+
+``TST_NEEDS_CHECKPOINTS``
+    Set to 1 to enable checkpoint support.
+
+``TST_MIN_KVER``
+    Minimum kernel version string (e.g. ``4.18``).
+
+Device and filesystem (input)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+``TST_FORMAT_DEVICE``
+    Set to 1 to format ``TST_DEVICE`` before the test.
+
+``TST_MOUNT_DEVICE``
+    Set to 1 to mount ``TST_DEVICE`` at ``TST_MNTPOINT``.
+
+``TST_DEV_EXTRA_OPTS``
+    Extra options passed to ``mkfs``.
+
+``TST_DEV_FS_OPTS``
+    Extra filesystem-specific ``mkfs`` options.
+
+``TST_FS_TYPE``
+    Filesystem type for formatting (default: ``ext2``).
+
+``TST_DEVICE_SIZE``
+    Device size in MB.
+
+``TST_ALL_FILESYSTEMS``
+    Set to 1 to repeat the test for each supported filesystem.
+
+``TST_SKIP_FILESYSTEMS``
+    Space-separated list of filesystems to skip.
+
+``TST_MNT_PARAMS``
+    Mount flags/options string.
+
+Miscellaneous (input)
+~~~~~~~~~~~~~~~~~~~~~
+
+``TST_SKIP_IN_LOCKDOWN``
+    Set to 1 to skip when kernel lockdown is active.
+
+``TST_SKIP_IN_SECUREBOOT``
+    Set to 1 to skip when Secure Boot is enabled.
+
+``TST_DISABLE_APPARMOR``
+    Set to 1 to disable AppArmor before the test runs (requires root).
+
+``TST_DISABLE_SELINUX``
+    Set to 1 to put SELinux in permissive mode before the test runs
+    (requires root).
+
+``TST_SKIP_LSM_WARNINGS``
+    Set to 1 to suppress the library's warnings about active LSMs
+    (AppArmor, SELinux) at startup.
+
+``TST_NO_DEFAULT_RUN``
+    Set to a non-empty value to source ``tst_test.sh`` without invoking
+    ``tst_run`` automatically. Useful for shell libraries that build on
+    top of the test API.
+
+``TST_TIMEOUT``
+    Test timeout in seconds.
+
+``TST_TMPDIR_RHOST``
+    Set to 1 to also clean up the temporary directory on the remote
+    host (used by network tests).
+
+Output variables
+~~~~~~~~~~~~~~~~
+
+``TST_TMPDIR``
+    Path to the temporary directory (when ``TST_NEEDS_TMPDIR=1``).
+
+``TST_STARTWD``
+    Original working directory before ``chdir`` to ``TST_TMPDIR``.
+
+``TST_DEVICE``
+    Block device path (when ``TST_NEEDS_DEVICE=1``).
+
+``TST_MNTPOINT``
+    Mount point path.
+
+``TST_MODPATH``
+    Path to the loaded kernel module.
+
+Checkpoint functions
+~~~~~~~~~~~~~~~~~~~~
+
+``TST_CHECKPOINT_WAIT``
+    Wait on checkpoint (argument: checkpoint id).
+
+``TST_CHECKPOINT_WAKE``
+    Wake one waiter on checkpoint (argument: checkpoint id).
+
+``TST_CHECKPOINT_WAKE2``
+    Wake multiple waiters (arguments: checkpoint id, count).
+
+``TST_CHECKPOINT_WAKE_AND_WAIT``
+    Wake one waiter and then wait (argument: checkpoint id).
+
+Retry helpers
+~~~~~~~~~~~~~
+
+``TST_RETRY_FUNC``
+    Retry a function until it succeeds or times out
+    (arguments: function, expected value).
+
+``TST_RETRY_FN_EXP_BACKOFF``
+    Like ``TST_RETRY_FUNC`` with exponential backoff
+    (arguments: function, expected value, max delay).
diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index dc40324b16d40c4d210fe0dfa6b311b5b3337c7a..4db57898fcf08b83e68be996f666e91c418838fc 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -382,6 +382,12 @@ LTP C And Shell Test API Comparison
     * - .dev_min_size
       - TST_DEVICE_SIZE
 
+    * - .filesystems
+      - \-
+
+    * - .forks_child
+      - not applicable
+
     * - .format_device
       - TST_FORMAT_DEVICE
 
@@ -399,21 +405,33 @@ LTP C And Shell Test API Comparison
     * - .min_mem_avail
       - not applicable
 
-    * - .mnt_flags
-      - TST_MNT_PARAMS
+    * - .min_runtime
+      - \-
 
     * - .min_swap_avail
       - not applicable
 
+    * - .mnt_flags
+      - TST_MNT_PARAMS
+
     * - .mntpoint | .mnt_data
       - TST_MNTPOINT
 
     * - .mount_device
       - TST_MOUNT_DEVICE
 
+    * - .needs_abi_bits
+      - not applicable
+
     * - .needs_cgroup_ctrls
       - \-
 
+    * - .needs_cgroup_nsdelegate
+      - \-
+
+    * - .needs_cgroup_ver
+      - \-
+
     * - .needs_checkpoints
       - TST_NEEDS_CHECKPOINTS
 
@@ -426,6 +444,9 @@ LTP C And Shell Test API Comparison
     * - .needs_device
       - TST_NEEDS_DEVICE
 
+    * - .needs_hugetlbfs
+      - \-
+
     * - removed
       - TST_NEEDS_DRIVERS
 
@@ -453,6 +474,9 @@ LTP C And Shell Test API Comparison
     * - .restore_wallclock
       - not applicable
 
+    * - .runs_script
+      - not applicable
+
     * - .sample
       - \-
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
