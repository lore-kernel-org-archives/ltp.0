Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A51C79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 08:36:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B0063E72B9
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 10:36:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CEED3E72BD
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:34:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ECBBE1400B62
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:34:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96EBF1FDED;
 Thu, 10 Sep 2026 08:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+rfaw/XxQipvi9OHKOqDKmltljoEvfkbJafLC+cM7A=;
 b=oul2qsXdwP0kzYrQ6QGXYxe5OOsXN9zMhedj+FnpAtgjU2MVDIfbCGzLDz70X2a3cYm+1O
 SmBK38Ev2fvy/BhbIR8g8WY2HGUSF12ROucSB2MYVkx4ZTJajh1xmk497yDpK0FAfAhYMJ
 VB9pUHZLEnxSjo5OIX/GDRmlhvVH68I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+rfaw/XxQipvi9OHKOqDKmltljoEvfkbJafLC+cM7A=;
 b=4TNMfAz1A9yCxHu7qXqY0KnfZZ/D9xFyrh35O9Le3yXtym/xufPkOlRH9yr7eDdJX7Yp2k
 DfJeR1V5UhFkjQCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kBLapW95;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WUsMxBFV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+rfaw/XxQipvi9OHKOqDKmltljoEvfkbJafLC+cM7A=;
 b=kBLapW95oP4ydh+ecxXH0lMxfGiwW9wtLXNBSFTzgl+7jguA6IP4YeB9AWao7dpE4pkpH8
 RbT/pKBUifO/93hh9h3aoRT20vlcPdBlZSlPuxXb6EObg3Ymf8HPhr5ZLXa+6t7l8pwajP
 RahBtrzW4Ik6YOGSCaodPZ3TaI2pa1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029232;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+rfaw/XxQipvi9OHKOqDKmltljoEvfkbJafLC+cM7A=;
 b=WUsMxBFVYOsfr4VAsXhUwPDBYqG8Mf0gVWv6vMVAUoz12BAvareUe2WHbN9YgPtcljxn0U
 jNrmWNO6ZzA//PBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D63A313A61;
 Thu, 10 Sep 2026 08:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EHeRMmhromqoWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Sep 2026 08:33:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 10:33:49 +0200
MIME-Version: 1.0
Message-Id: <20260910-fix_documentation-v1-9-44313069bbe8@suse.com>
References: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
In-Reply-To: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789029223; l=18884;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=nqkz6NCak1YC2tvcAnLu05OdaATMLSqMbdi8epCI40w=;
 b=rYbCvdjMQ6JLyEccpob1HweTJr+1fby9grIAEf+KhK4jmObpQfrzEHBHb1heXainn1IrCpvKY
 NnBuvuJsMsbAcKQx2U/gH01rJVSAwkFGZfVf/xgEav0FmPWT6OjLUe7
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 96EBF1FDED
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 9/9] include: Fix API comment spelling and style
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

Correct typos in test macros, test harness headers, checkpoints,
buffers, NUMA, and ujson headers. Normalize Return: tags for consistency
with kernel-doc conventions.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tse_numa.h        |  8 ++++----
 include/tst_buffers.h     | 10 +++++-----
 include/tst_checkpoint.h  |  6 +++---
 include/tst_test.h        | 20 ++++++++++----------
 include/tst_test_macros.h | 34 +++++++++++++++++-----------------
 include/ujson_common.h    |  2 +-
 include/ujson_reader.h    |  8 ++++----
 include/ujson_utf.h       |  2 +-
 include/ujson_writer.h    |  2 +-
 9 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/include/tse_numa.h b/include/tse_numa.h
index 4cbef63b7..add048eb4 100644
--- a/include/tse_numa.h
+++ b/include/tse_numa.h
@@ -39,7 +39,7 @@ void tse_nodemap_print_counters(struct tse_nodemap *nodes);
  *
  * @mode: Numa mempolicy mode.
  *
- * return: a name for a mempolicy/mbind mode.
+ * Return: a name for a mempolicy/mbind mode.
  */
 const char *tse_mempolicy_mode_name(int mode);
 
@@ -49,7 +49,7 @@ const char *tse_mempolicy_mode_name(int mode);
  * @path: Path to a file, if not NULL mapping is file based.
  * @size: Mapping size.
  *
- * return: a pointer to a mapped file.
+ * Return: a pointer to a mapped file.
  */
 void *tse_numa_map(const char *path, size_t size);
 
@@ -76,7 +76,7 @@ static inline void tse_numa_unmap(void *ptr, size_t size)
 }
 
 /**
- * tse_nodemap_count_pages() - Check which numa node resides each page.
+ * tse_nodemap_count_pages() - Check on which NUMA node each page resides.
  *
  * Check on which numa node resides each page of the mapping starting at ptr
  * and continuing pages long and increases nodemap counters accordingly.
@@ -114,7 +114,7 @@ enum tse_numa_types {
  *             requested amount of free+buffers memory it's not included in
  *             the resulting list of nodes.
  *
- * return: On success returns allocated and initialized struct tse_nodemap which contains
+ * Return: On success returns allocated and initialized struct tse_nodemap which contains
  *         array of numa node ids that contains desired resources.
  */
 struct tse_nodemap *tse_get_nodemap(int type, size_t min_mem_kb);
diff --git a/include/tst_buffers.h b/include/tst_buffers.h
index bd1a112a2..c354e2eca 100644
--- a/include/tst_buffers.h
+++ b/include/tst_buffers.h
@@ -22,7 +22,7 @@
 /**
  * struct tst_buffers - A guarded buffer description for allocator.
  *
- * Buffer description consist of a pointer to a pointer and buffer type/size
+ * Buffer description consists of a pointer to a pointer and buffer type/size
  * encoded as a different structure members.
  *
  * @ptr: A pointer to the pointer to buffer. This is dereferenced and set by the
@@ -53,7 +53,7 @@ void tst_buffers_alloc(struct tst_buffers bufs[]);
  * tst_strdup() - Copies a string into a newly allocated guarded buffer.
  *
  * @str: A string to be duplicated.
- * return: A pointer to the string duplicated in a guarded buffer.
+ * Return: A pointer to the string duplicated in a guarded buffer.
  *
  * Allocates a buffer with tst_alloc() and copies the string into it.
  */
@@ -63,7 +63,7 @@ char *tst_strdup(const char *str);
  * tst_alloc() - Allocates a guarded buffer.
  *
  * @size: A size of the buffer.
- * return: A newly allocated guarded buffer.
+ * Return: A newly allocated guarded buffer.
  */
 void *tst_alloc(size_t size);
 
@@ -72,7 +72,7 @@ void *tst_alloc(size_t size);
  *
  * @fmt: A printf-like format.
  * @...: A printf-like parameters.
- * return: A newly allocated buffer.
+ * Return: A newly allocated buffer.
  *
  * Allocates a buffer with tst_alloc() then prints the data into it.
  */
@@ -83,7 +83,7 @@ char *tst_aprintf(const char *fmt, ...)
  * tst_iovec_alloc() - Allocates a complete iovec structure.
  *
  * @sizes: A -1 terminated array of buffer sizes.
- * return: Newly allocated iovec structure.
+ * Return: Newly allocated iovec structure.
  */
 struct iovec *tst_iovec_alloc(int sizes[]);
 
diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
index f202dd03d..d93667b36 100644
--- a/include/tst_checkpoint.h
+++ b/include/tst_checkpoint.h
@@ -6,10 +6,10 @@
 /**
  * DOC: Checkpoints introduction
  *
- * Checkpoints implements a futex based synchronization primitive for threads
+ * Checkpoints implement a futex based synchronization primitive for threads
  * and processes. When a process calls wait function its execution is suspended
  * until wake is called for a corresponding checkpoint. Checkpoints are
- * numbered from 0 and process can use at least hundred of them.
+ * numbered from 0 and process can use at least a hundred of them.
  *
  * In order to use checkpoints the test must set the tst_test.needs_checkpoints
  * flag.
@@ -66,7 +66,7 @@
  * @nr_wake: A number of processes to wake.
  *
  * Wakes up nr_wake processes suspended on a checkpoint and retries if there
- * wasn't enough process suspended on the checkpoint yet. The call does not
+ * were not enough processes suspended on the checkpoint yet. The call does not
  * retry indefinitely but gives up if it does not wake nr_wake processes after
  * 10 seconds. If an error happened or timeout was reached the function calls
  * tst_brk(TBROK, ...) which exits the test.
diff --git a/include/tst_test.h b/include/tst_test.h
index 7d03014d4..53f58180f 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -160,7 +160,7 @@ pid_t safe_fork(const char *filename, unsigned int lineno);
  * tst_strerrno() - Converts an errno number into a name.
  *
  * @err: An errno number.
- * return: An errno name e.g. "EINVAL".
+ * Return: An errno name e.g. "EINVAL".
  */
 const char *tst_strerrno(int err);
 
@@ -168,7 +168,7 @@ const char *tst_strerrno(int err);
  * tst_strsig() - Converts a signal number into a name.
  *
  * @sig: A signal number.
- * return: A signal name e.g. "SIGINT".
+ * Return: A signal name e.g. "SIGINT".
  */
 const char *tst_strsig(int sig);
 
@@ -181,7 +181,7 @@ const char *tst_strsig(int sig);
  *   Not thread safe.
  *
  * @status: A status as returned by wait()
- * return: A string description for the status e.g. "killed by SIGKILL".
+ * Return: A string description for the status e.g. "killed by SIGKILL".
  */
 const char *tst_strstatus(int status);
 
@@ -436,8 +436,8 @@ struct tst_fs {
  *
  * @filesystems: A NULL type terminated array of per file system type
  *               parameters for mkfs and mount. If the first entry type is NULL
- *               it describes a default parameters for all file system tests.
- *               The rest of the entries the describes per file system type
+ *               it describes default parameters for all file system tests.
+ *               The remaining entries describe per file system type
  *               parameters. If tst_test.all_filesystems is set, the test runs
  *               for all filesystems and uses the array to lookup the mkfs
  *               and mount options. If tst_test.all_filesystems is not set
@@ -546,7 +546,7 @@ struct tst_fs {
  * @needs_cgroup_ctrls: A {} terminated array of cgroup controllers the test
  *                      needs to run.
  *
- * @needs_cgroup_nsdelegate: If set test the will run only if cgroup2 is mounted
+ * @needs_cgroup_nsdelegate: If set the test will run only if cgroup2 is mounted
  *                           with nsdelegate option.
  */
 
@@ -663,7 +663,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 /**
  * tst_reinit() - Reinitialize the test library.
  *
- * In a cases where a test child process calls exec() it no longer can access
+ * In cases where a test child process calls exec() it no longer can access
  * the test library shared memory and therefore use the test reporting
  * functions, checkpoint library, etc. This function re-initializes the test
  * library so that it can be used again.
@@ -701,7 +701,7 @@ void tst_reinit(void);
  * of the script yourself. If you do not need to check the return value
  * yourself you can use tst_reap_children() to wait for the completion. Or let
  * the test library collect the child automatically, just be wary that the
- * script and the test both runs concurently at the same time in this case.
+ * script and the test both run concurrently at the same time in this case.
  *
  * Return: A pid of the (shell) script process.
  */
@@ -794,7 +794,7 @@ int tst_creat_unlinked(const char *path, int flags, mode_t mode);
 /**
  * tst_get_tmpdir_root() - Returns path to the test temporary directory root.
  *
- * The path is either hardcoded as /tmp or could be overrided by a TMPDIR
+ * The path is either hardcoded as /tmp or could be overridden by a TMPDIR
  * environment variable.
  *
  * Return: A path to the test temporary directory root.
@@ -840,7 +840,7 @@ int main(int argc, char *argv[])
  *
  * @message: Error message (the reason to skip test).
  *
- * This macro is used in test that couldn't be compiled either because current
+ * This macro is used in tests that couldn't be compiled either because current
  * CPU architecture is unsupported or because of missing development libraries.
  */
 #define TST_TEST_TCONF(message)                                 \
diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 9a93331d5..fcecf7f82 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -115,7 +115,7 @@ extern int TST_PASS;
  * @SCALL: Tested syscall.
  * @...: A printf-like parameters.
  *
- * This macro calls the SCALL with a TEST() macro and additionaly prints pass
+ * This macro calls the SCALL with a TEST() macro and additionally prints pass
  * or fail message. Apart from TST_ERR and TST_RET set by the TEST() macro
  * TST_PASS global variable is set as well based on the outcome.
  *
@@ -258,8 +258,8 @@ extern int TST_PASS;
  * @VAL: Expected return value.
  * @...: A printf-like parameters.
  *
- * This macro calls the SCALL with a TEST() macro and additionaly prints pass
- * or fail message after comparing the returned value againts the expected
+ * This macro calls the SCALL with a TEST() macro and additionally prints pass
+ * or fail message after comparing the returned value against the expected
  * value. Apart from TST_ERR and TST_RET set by the TEST() macro TST_PASS
  * global variable is set as well based on the outcome.
  *
@@ -337,8 +337,8 @@ extern int TST_PASS;
  * @SCALL: Tested syscall.
  * @...: A printf-like parameters.
  *
- * This macro calls the SCALL with a TEST() macro and additionaly prints pass
- * or fail message after checking the return value againts zero. Apart from
+ * This macro calls the SCALL with a TEST() macro and additionally prints pass
+ * or fail message after checking the return value against zero. Apart from
  * TST_ERR and TST_RET set by the TEST() macro TST_PASS global variable is set
  * as well based on the outcome.
  *
@@ -395,7 +395,7 @@ extern int TST_PASS;
  * @SCALL: Tested syscall.
  * @...: A printf-like parameters.
  *
- * This macro calls the SCALL with a TESTPTR() macro and additionaly prints
+ * This macro calls the SCALL with a TESTPTR() macro and additionally prints
  * pass or fail message after checking the return value against (void \*)-1.
  * Apart from TST_ERR and TST_RET_PTR set by the TESTPTR() macro TST_PASS
  * global variable is set as well based on the outcome.
@@ -509,7 +509,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  * @EXP_ERR: Expected errno.
  * @...: A printf-like parameters.
  *
- * This macro calls the SCALL with a TEST() macro and additionaly prints pass
+ * This macro calls the SCALL with a TEST() macro and additionally prints pass
  * or fail message. The check passes if syscall has returned -1 and failed with
  * the specified errno.
  *
@@ -538,7 +538,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  *
  * @SCALL: Tested syscall.
  * @EXP_ERRS: Array of expected errnos.
- * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
+ * @EXP_ERRS_CNT: Length of EXP_ERRS.
  * @...: A printf-like parameters.
  *
  * This is a variant of TST_EXP_FAIL() with an array of possible errors.
@@ -560,7 +560,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  *
  * @SCALL: Tested syscall.
  * @EXP_ERRS: Array of expected errnos.
- * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
+ * @EXP_ERRS_CNT: Length of EXP_ERRS.
  * @...: A printf-like parameters.
  *
  * This is a variant of TST_EXP_FAIL2() with an array of possible errors.
@@ -576,7 +576,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  * @EXP_ERR: Expected errno.
  * @...: A printf-like parameters.
  *
- * This macro calls the SCALL with a TESTPTR() macro and additionaly prints
+ * This macro calls the SCALL with a TESTPTR() macro and additionally prints
  * pass or fail message after checking the return value against NULL and errno.
  *
  * Apart from TST_ERR and TST_RET_PTR set by the TESTPTR() macro TST_PASS
@@ -598,7 +598,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  *
  * @SCALL: Tested syscall.
  * @EXP_ERRS: Array of expected errnos.
- * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
+ * @EXP_ERRS_CNT: Length of EXP_ERRS.
  * @...: A printf-like parameters.
  *
  * This is a variant of TST_EXP_FAIL_PTR_NULL() with an array of possible
@@ -617,7 +617,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  * @EXP_ERR: Expected errno.
  * @...: A printf-like parameters.
  *
- * This macro calls the SCALL with a TESTPTR() macro and additionaly prints
+ * This macro calls the SCALL with a TESTPTR() macro and additionally prints
  * pass or fail message after checking the return value against (void \*)-1 and
  * errno.
  *
@@ -640,7 +640,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  *
  * @SCALL: Tested syscall.
  * @EXP_ERRS: Array of expected errnos.
- * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
+ * @EXP_ERRS_CNT: Length of EXP_ERRS.
  * @...: A printf-like parameters.
  *
  * This is a variant of TST_EXP_FAIL_PTR_VOID() with an array of possible
@@ -657,11 +657,11 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  * @EXP_ERR: Expected errno.
  * @...: A printf-like parameters.
  *
- * This macro calls the SCALL with a TEST() macro and additionaly prints pass
+ * This macro calls the SCALL with a TEST() macro and additionally prints pass
  * or fail message. The check passes if syscall has returned -1 and failed with
  * the specified errno.
  *
- * The SCALL is supposed to return possitive number on success e.g. pid or file
+ * The SCALL is supposed to return positive number on success e.g. pid or file
  * descriptor. For syscalls that return zero on success TST_EXP_FAIL() has to
  * be used instead.
  *
@@ -718,7 +718,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  *
  * @SCALL: Tested syscall.
  * @EXP_ERRS: Array of expected errnos.
- * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
+ * @EXP_ERRS_CNT: Length of EXP_ERRS.
  * @...: A printf-like parameters.
  *
  * Unlike TST_EXP_FAIL_ARR() does not print :c:enum:`TPASS <tst_res_flags>` on
@@ -733,7 +733,7 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  *
  * @SCALL: Tested syscall.
  * @EXP_ERRS: Array of expected errnos.
- * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
+ * @EXP_ERRS_CNT: Length of EXP_ERRS.
  * @...: A printf-like parameters.
  *
  * Unlike TST_EXP_FAIL2_ARR() does not print :c:enum:`TPASS <tst_res_flags>` on
diff --git a/include/ujson_common.h b/include/ujson_common.h
index 11382c4fb..1eaf3fc72 100644
--- a/include/ujson_common.h
+++ b/include/ujson_common.h
@@ -13,7 +13,7 @@
 
 /** @brief Maximal error message length. */
 #define UJSON_ERR_MAX 128
-/** @brief Maximal id string lenght including terminating null element. */
+/** @brief Maximal id string length including terminating null element. */
 #define UJSON_ID_MAX 64
 /** @brief Maximal recursion depth allowed. */
 #define UJSON_RECURSION_MAX 128
diff --git a/include/ujson_reader.h b/include/ujson_reader.h
index 8608b6c81..3722fffea 100644
--- a/include/ujson_reader.h
+++ b/include/ujson_reader.h
@@ -24,7 +24,7 @@
  * @brief An ujson_reader initializer with default values.
  *
  * @param buf A pointer to a buffer with JSON data.
- * @param buf_len A JSON data buffer lenght.
+ * @param buf_len A JSON data buffer length.
  * @param rflags enum ujson_reader_flags.
  *
  * @return An ujson_reader initialized with default values.
@@ -96,7 +96,7 @@ struct ujson_val {
 	 */
 	enum ujson_type type;
 
-	/** An user supplied buffer and size to store a string values to. */
+	/** A user supplied buffer and size to store a string values to. */
 	char *buf;
 	size_t buf_size;
 
@@ -108,7 +108,7 @@ struct ujson_val {
 	 */
 	size_t idx;
 
-	/** An union to store the parsed value into. */
+	/** A union to store the parsed value into. */
 	union {
 		/** @brief A boolean value. */
 		int val_bool;
@@ -311,7 +311,7 @@ static inline size_t ujson_obj_lookup(const ujson_obj *obj, const char *key)
 #define UJSON_OBJ_ATTR(keyv, typev) \
 	{.key = keyv, .type = typev}
 
-/** @brief An ujson_obj_attr intializer with an array index. */
+/** @brief An ujson_obj_attr initializer with an array index. */
 #define UJSON_OBJ_ATTR_IDX(key_idx, keyv, typev) \
 	[key_idx] = {.key = keyv, .type = typev}
 
diff --git a/include/ujson_utf.h b/include/ujson_utf.h
index 313213d8e..83fe8ab09 100644
--- a/include/ujson_utf.h
+++ b/include/ujson_utf.h
@@ -130,7 +130,7 @@ static inline unsigned int ujson_utf8_bytes(uint32_t unicode)
 }
 
 /**
- * @brief Writes an unicode character into a UTF-8 buffer.
+ * @brief Writes a Unicode character into a UTF-8 buffer.
  *
  * The buffer _must_ be large enough!
  *
diff --git a/include/ujson_writer.h b/include/ujson_writer.h
index dfcc95053..30d2e92f6 100644
--- a/include/ujson_writer.h
+++ b/include/ujson_writer.h
@@ -46,7 +46,7 @@ struct ujson_writer {
  * @brief An ujson_writer initializer with default values.
  *
  * @param vout A pointer to function to write out the data.
- * @param vout_priv An user pointer passed to the out function.
+ * @param vout_priv A user pointer passed to the out function.
  *
  * @return An ujson_writer initialized with default values.
  */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
