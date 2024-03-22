Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3620FC54E71
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 12:08:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 536F63CF2CF
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 13:08:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A9C33C997B
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 13:07:57 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 695106025B5
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 13:07:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 55A775FDD5
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 12:07:54 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B1C113688
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 12:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0HukDZp0/WXWeAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 12:07:54 +0000
From: Cyril Hrubis <metan@ucw.cz>
To: ltp@lists.linux.it
Date: Fri, 22 Mar 2024 13:07:00 +0100
Message-ID: <20240322120700.3072-2-metan@ucw.cz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240322120700.3072-1-metan@ucw.cz>
References: <20240322120700.3072-1-metan@ucw.cz>
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=none
X-Spamd-Result: default: False [3.95 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 NEURAL_HAM_LONG(-0.34)[-0.336]; RCVD_COUNT_THREE(0.00)[3];
 TO_DN_NONE(0.00)[]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FORGED_SENDER(0.30)[metan@ucw.cz,chrubis@suse.cz];
 FUZZY_BLOCKED(0.00)[rspamd.com]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+];
 FROM_NEQ_ENVFROM(0.10)[metan@ucw.cz,chrubis@suse.cz];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 55A775FDD5
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] include: doc: Convert comments into linuxdoc
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

Signed-off-by: Cyril Hrubis <metan@ucw.cz>
---
 doc_new/developers/api_c_tests.rst |  26 ++
 include/tst_buffers.h              |  86 +++--
 include/tst_capability.h           |  80 ++++-
 include/tst_checkpoint.h           |  64 +++-
 include/tst_compiler.h             |  20 ++
 include/tst_hugepage.h             |   2 +
 include/tst_parse.h                |  65 ++++
 include/tst_res_flags.h            |  72 +++-
 include/tst_test.h                 | 505 +++++++++++++++++++++--------
 9 files changed, 720 insertions(+), 200 deletions(-)
 create mode 100644 include/tst_compiler.h
 create mode 100644 include/tst_parse.h

diff --git a/doc_new/developers/api_c_tests.rst b/doc_new/developers/api_c_tests.rst
index adee17f16..2c0c8419d 100644
--- a/doc_new/developers/api_c_tests.rst
+++ b/doc_new/developers/api_c_tests.rst
@@ -5,3 +5,29 @@
 
 Developing using C API
 ======================
+
+Core LTP API
+------------
+
+.. kernel-doc:: ../../include/tst_res_flags.h
+.. kernel-doc:: ../../include/tst_test.h
+
+Option parsing
+--------------
+
+.. kernel-doc:: ../../include/tst_parse.h
+
+Guarded buffers
+---------------
+
+.. kernel-doc:: ../../include/tst_buffers.h
+
+Checkpoints
+-----------
+
+.. kernel-doc:: ../../include/tst_checkpoint.h
+
+Capabilities
+------------
+
+.. kernel-doc:: ../../include/tst_capability.h
diff --git a/include/tst_buffers.h b/include/tst_buffers.h
index b5f355f0f..f275bfdb8 100644
--- a/include/tst_buffers.h
+++ b/include/tst_buffers.h
@@ -3,69 +3,95 @@
  * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
  */
 
+/**
+ * DOC: Guarded buffers introduction
+ *
+ * Guarded buffer has a page with PROT_NONE allocated right before the start of
+ * the buffer and canary after the end of the buffer. That means that any
+ * memory access before the buffer ends with EFAULT or SEGFAULT and any write
+ * after the end of the buffer will be detected because it would overwrite the
+ * canaries.
+ *
+ * It should be used for all buffers passed to syscalls to make sure off-by-one
+ * buffer accesses does not happen.
+ */
+
 #ifndef TST_BUFFERS_H__
 #define TST_BUFFERS_H__
 
-/*
+/**
+ * struct tst_buffers - A guarded buffer description for allocator.
+ *
  * Buffer description consist of a pointer to a pointer and buffer type/size
  * encoded as a different structure members.
  *
- * Only one of the size and iov_sizes can be set at a time.
+ * @ptr: A pointer to the pointer to buffer. This is dereferenced and set by the
+ *       allocator.
+ * @size: A buffer size in bytes. Only one of size and iov_sizes can be set.
+ * @iov_sizes: An -1 terminated array of sizes used to construct a
+ *             struct iovec buffers.
+ * @str: If size is zero and iov_sizes is NULL this string is going to be
+ *       copied into the buffer.
  */
 struct tst_buffers {
-	/*
-	 * This pointer points to a buffer pointer.
-	 */
 	void *ptr;
-	/*
-	 * Buffer size.
-	 */
 	size_t size;
-	/*
-	 * Array of iov buffer sizes terminated by -1.
-	 */
 	int *iov_sizes;
-	/*
-	 * If size and iov_sizes is NULL this is the string we want to strdup()
-	 * into the buffer.
-	 */
 	char *str;
 };
 
-/*
- * Allocates buffers based on the tst_buffers structure.
+/**
+ * tst_buffers_alloc() - Allocates buffers based on the tst_buffers structure.
  *
- * @bufs NULL terminated array of test buffer descriptions.
+ * @bufs: A NULL terminated array of test buffer descriptions.
  *
- * This is called from the test library if the tst_test->bufs pointer is set.
+ * This is called from the test library if the tst_test.bufs pointer is set.
  */
 void tst_buffers_alloc(struct tst_buffers bufs[]);
 
-/*
- * strdup() that callls tst_alloc().
+/**
+ * tst_strdup() - Copies a string into a guarded buffer.
+ *
+ * @str: A string to be duplicated.
+ * return: A pointer to the string duplicated in a guraded buffer.
+ *
+ * Allocates a buffer with tst_alloc() and copies the string into it.
  */
 char *tst_strdup(const char *str);
 
-/*
- * Allocates size bytes, returns pointer to the allocated buffer.
+/**
+ * tst_alloc() - Allocates a guarded buffer.
+ *
+ * @size: A size of the buffer.
+ * return: A newly allocated guarded buffer.
  */
 void *tst_alloc(size_t size);
 
-/*
- * Printf into a guarded buffer.
+/**
+ * tst_aprintf() - Printf into a guarded buffer.
+ *
+ * @fmt: A printf-like format.
+ * @...: A printf-like parameters.
+ * return: A newly allocated buffer.
+ *
+ * Allocates a buffer with tst_alloc() then prints the data into it.
  */
 char *tst_aprintf(const char *fmt, ...)
       __attribute__((format (printf, 1, 2)));
 
-/*
- * Allocates iovec structure including the buffers.
+/**
+ * tst_iovec_alloc() - Allocates an iovec structure with the buffers.
  *
- * @sizes -1 terminated array of buffer sizes.
+ * @sizes: A -1 terminated array of buffer sizes.
+ * return: Newly allocated iovec structure.
  */
 struct iovec *tst_iovec_alloc(int sizes[]);
 
-/*
- * Frees all allocated buffers.
+/**
+ * tst_free_all() - Frees all allocated buffers.
+ *
+ * It's important to free all guarded buffers because the canaries after the
+ * buffer are checked only when the buffer is being freed.
  *
  * This is called at the end of the test automatically.
  */
diff --git a/include/tst_capability.h b/include/tst_capability.h
index 6067804a3..c24c8789c 100644
--- a/include/tst_capability.h
+++ b/include/tst_capability.h
@@ -2,8 +2,9 @@
 /*
  * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
  */
+
 /**
- * @file tst_capability.h
+ * DOC: Capabilities introduction
  *
  * Limited capability operations without libcap.
  */
@@ -15,22 +16,51 @@
 
 #include "lapi/capability.h"
 
-#define TST_CAP_DROP 1
-#define TST_CAP_REQ  (1 << 1)
-
-#define TST_CAP(action, capability) {action, capability, #capability}
+/**
+ * enum tst_cap_act - A capability action masks.
+ *
+ * @TST_CAP_DROP: Drop capabilities.
+ * @TST_CAP_REQ: Add capabilities.
+ */
+enum tst_cap_act {
+	TST_CAP_DROP = 1,
+	TST_CAP_REQ = (1 << 1)
+};
 
+/**
+ * struct tst_cap_user_header - Kernel capget(), capset() syscall header.
+ *
+ * @version: A capability API version.
+ * @pid: A process to operate on.
+ */
 struct tst_cap_user_header {
 	uint32_t version;
 	int pid;
 };
 
+/**
+ * struct tst_cap_user_data - Kernel capset(), capget() syscall payload.
+ *
+ * @effective: A capability effective set.
+ * @permitted: A capability permitted set.
+ * @inheritable: A capability inheritable set.
+ */
 struct tst_cap_user_data {
 	uint32_t effective;
 	uint32_t permitted;
 	uint32_t inheritable;
 };
 
+/**
+ * struct tst_cap - A capability to alter.
+ *
+ * @action: What should we do, i.e. drop or add a capability.
+ * @id: A capability id.
+ * @name: A capability name.
+ *
+ * This structure is usually constructed with the TST_CAP() macro so that the
+ * name is created automatically.
+ */
 struct tst_cap {
 	uint32_t action;
 	uint32_t id;
@@ -38,25 +68,43 @@ struct tst_cap {
 };
 
 /**
- * Get the capabilities as decided by hdr.
+ * TST_CAP() - Create a struct tst_cap entry.
  *
- * Note that the memory pointed to by data should be large enough to store two
- * structs.
+ * @action: What should we do, i.e. drop or add capability.
+ * @capability: A capability id, e.g. CAP_BPF.
+ */
+#define TST_CAP(action, capability) {action, capability, #capability}
+
+/**
+ * tst_capget() - Get the capabilities as decided by hdr.
+ *
+ * @hdr: A capability user header stores a pid to operate on and which
+ *       capability API version is used.
+ * @data: A memory to store the capabilities to. The memory pointed to by data
+ *        should be large enough to store two structs.
+ *
+ * return: Returns 0 on succes, -1 on a failure and sets errno.
  */
 int tst_capget(struct tst_cap_user_header *hdr,
 	       struct tst_cap_user_data *data);
 
 /**
- * Set the capabilities as decided by hdr and data
+ * tst_capset() - Set the capabilities as decided by hdr and data
  *
- * Note that the memory pointed to by data should be large enough to store two
- * structs.
+ * @hdr: A capability user header stores a pid to operate on and which
+ *       capability API version is used.
+ * @data: A memory to store the capabilities to. The memory pointed to by data
+ *        should be large enough to store two structs.
+ *
+ * return: Returns 0 on succes, -1 on a failure and sets errno.
  */
 int tst_capset(struct tst_cap_user_header *hdr,
 	       const struct tst_cap_user_data *data);
 
 /**
- * Add, check or remove a capability
+ * tst_cap_action() - Add, check or remove a capability.
+ *
+ * @cap: An {} terminated array of capabilities to alter.
  *
  * It will attempt to drop or add capability to the effective set. It will
  * try to detect if this is needed and whether it can or can't be done. If it
@@ -71,13 +119,17 @@ void tst_cap_action(struct tst_cap *cap);
 
 
 /**
- * Add, check or remove a capabilities
+ * tst_cap_setup() - Add, check or remove a capabilities.
+ *
+ * @cap: An {} terminated array of capabilities to alter.
+ * @action_mask: Decides which actions are done, i.e. only drop caps, add them
+ *               or both.
  *
  * Takes a NULL terminated array of structs which describe whether some
  * capabilities are needed or not and mask that determines subset of the
  * actions to be performed. Loops over the array and if mask matches the
  * element action it's passed to tst_cap_action().
  */
-void tst_cap_setup(struct tst_cap *cap, unsigned int action_mask);
+void tst_cap_setup(struct tst_cap *cap, enum tst_cap_act action_mask);
 
 #endif /* TST_CAPABILITY_H */
diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
index 1b6911d73..62d87d60b 100644
--- a/include/tst_checkpoint.h
+++ b/include/tst_checkpoint.h
@@ -1,24 +1,86 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
  * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
  */
 
+/**
+ * DOC: Checkpoints introduction
+ *
+ * Checkpoints implements a futex based synchronization primitive for threads
+ * and processes. When a process calls wait function its execution is suspended
+ * until wake is called for a corresponding checkpoint. Checkpoints are
+ * numbered from 0 and process can use at least hundred of them.
+ *
+ * In order to use checkpoints the test must set the tst_test.needs_checkpoints
+ * flag.
+ */
+
 #ifndef TST_CHECKPOINT__
 #define TST_CHECKPOINT__
 
 #include "tst_checkpoint_fn.h"
 
+/**
+ * TST_CHECKPOINT_WAIT() - Waits for a checkpoint.
+ *
+ * @id: A checkpoint id a positive integer.
+ *
+ * Suspends thread/process execution until it's woken up with a wake. The call
+ * does not wait indefinitelly it gives up after 10 seconds. If an error
+ * happened or timeout was reached the function calls tst_brk(TBROK, ...) which
+ * exits the test.
+ */
 #define TST_CHECKPOINT_WAIT(id) \
         tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0)
 
+/**
+ * TST_CHECKPOINT_WAIT2() - Waits for a checkpoint.
+ *
+ * @id: A checkpoint id a positive integer.
+ * @msec_timeout: A timeout.
+ *
+ * Suspends thread/process execution until it's woken up with a wake. If an
+ * error happened or timeout was reached the function calls tst_brk(TBROK, ...)
+ * which exits the test.
+ */
 #define TST_CHECKPOINT_WAIT2(id, msec_timeout) \
         tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, msec_timeout)
 
+/**
+ * TST_CHECKPOINT_WAKE() - Wakes up a checkpoint.
+ *
+ * @id: A checkpoint id a positive integer.
+ *
+ * Wakes up a process suspended on a checkpoint and retries if there is no
+ * process suspended on the checkpoint yet. The call does not retry
+ * indefinitelly git gives up after 10 seconds. If an error happened or timeout
+ * was reached the function calls tst_brk(TBROK, ...) which exits the test.
+ */
 #define TST_CHECKPOINT_WAKE(id) \
         tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1)
 
+/**
+ * TST_CHECKPOINT_WAKE2() - Wakes up several checkpoints.
+ *
+ * @id: A checkpoint id a positive integer.
+ * @nr_wake: A number of processes to wake.
+ *
+ * Wakes up nr_wake processes suspended on a checkpoint and retries if there
+ * wasn't enough process suspended on the checkpoint yet. The call does not
+ * retry indefinitelly git gives up if it does not wake nr_wake processes after
+ * 10 seconds. If an error happened or timeout was reached the function calls
+ * tst_brk(TBROK, ...) which exits the test.
+ */
 #define TST_CHECKPOINT_WAKE2(id, nr_wake) \
         tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, nr_wake)
 
+/**
+ * TST_CHECKPOINT_WAKE_AND_WAIT() - Wakes up a checkpoint and immediatelly waits on it.
+ *
+ * @id: A checkpoint id a positive integer.
+ *
+ * This is a combination of TST_CHECKPOINT_WAKE() and TST_CHECKPOINT_WAIT().
+ */
 #define TST_CHECKPOINT_WAKE_AND_WAIT(id) do { \
         tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1); \
         tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0); \
diff --git a/include/tst_compiler.h b/include/tst_compiler.h
new file mode 100644
index 000000000..ec88213df
--- /dev/null
+++ b/include/tst_compiler.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/**
+ * @file tst_compiler.h
+ * @brief Macros to support dump compilers.
+ *
+ * The doxygen parser (and possibly other C tooling) does not understand
+ * __attributes__ so we have to hide them with macros.
+ */
+
+#ifndef TST_COMPILER_H__
+#define TST_COMPILER_H__
+
+#ifdef __GNUC__
+# define TST_ATTRIBUTE(...) __attribute__((__VA_ARGS__))
+#else
+# define TST_ATTRIBUTE(...)
+#endif
+
+#endif	/* TST_COMPILER_H__ */
diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
index 46327c79a..6b865b2f2 100644
--- a/include/tst_hugepage.h
+++ b/include/tst_hugepage.h
@@ -24,6 +24,8 @@ enum tst_hp_policy {
 	TST_NEEDS,
 };
 
+#define TST_NO_HUGEPAGES ((unsigned long)-1)
+
 struct tst_hugepage {
 	const unsigned long number;
 	enum  tst_hp_policy policy;
diff --git a/include/tst_parse.h b/include/tst_parse.h
new file mode 100644
index 000000000..11c36e812
--- /dev/null
+++ b/include/tst_parse.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2015-2024 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/**
+ * DOC: Option parsing functions
+ *
+ * Implements simple helpers on the top of the strtol() and strtod() for
+ * command line option parsing.
+ */
+
+#ifndef TST_PARSE_H__
+#define TST_PARSE_H__
+
+/**
+ * tst_parse_int() - Parse an integer from a string.
+ *
+ * @str: A string with an integer number.
+ * @val: A pointer to integer to store the result to.
+ * @min: A lower bound, pass INT_MIN for full range.
+ * @max: An upper bound, pass INT_MAX for full range.
+ * return: A zero if whole string was consumed and the value was within bounds,
+ *         an errno otherwise.
+ */
+int tst_parse_int(const char *str, int *val, int min, int max);
+
+/**
+ * tst_parse_long() - Parse a long integer from a string.
+ *
+ * @str: A string with an integer number.
+ * @val: A pointer to long integer to store the result to.
+ * @min: A lower bound, pass LONG_MIN for full range.
+ * @max: An upper bound, pass LONG_MAX for full range.
+ * return: A zero if whole string was consumed and the value was within bounds,
+ *         an errno otherwise.
+ */
+int tst_parse_long(const char *str, long *val, long min, long max);
+
+/**
+ * tst_parse_float() - Parse a floating point number from a string.
+ *
+ * @str: A string with an integer number.
+ * @val: A pointer to float to store the result to.
+ * @min: A lower bound.
+ * @max: An upper bound.
+ * return: A zero if whole string was consumed and the value was within bounds,
+ *         an errno otherwise.
+ */
+int tst_parse_float(const char *str, float *val, float min, float max);
+
+/**
+ * tst_parse_filesize() - Parse a file size from a string.
+ *
+ * @str: A string a positive number optionally followed by an unit, i.e. K, M,
+ *       or G for kilobytes, megabytes and gigabytes.
+ * @val: A pointer to long long integer to store the size in bytes to.
+ * @min: A lower bound.
+ * @max: An upper bound.
+ * return: A zero if whole string was consumed and the value was within bounds,
+ *         an errno otherwise.
+ */
+int tst_parse_filesize(const char *str, long long *val, long long min, long long max);
+
+#endif	/* TST_PARSE_H__ */
diff --git a/include/tst_res_flags.h b/include/tst_res_flags.h
index 872352144..8a2cf9a71 100644
--- a/include/tst_res_flags.h
+++ b/include/tst_res_flags.h
@@ -1,24 +1,66 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
  * Copyright (c) Linux Test Project, 2014
  */
 
 #ifndef TST_RES_FLAGS_H
 #define TST_RES_FLAGS_H
 
-/* Use low 6 bits to encode test type */
-#define TTYPE_MASK	0x3f
-#define TPASS	0	/* Test passed flag */
-#define TFAIL	1	/* Test failed flag */
-#define TBROK	2	/* Test broken flag */
-#define TWARN	4	/* Test warning flag */
-#define TDEBUG	8	/* Test debug information flag */
-#define TINFO	16	/* Test information flag */
-#define TCONF	32	/* Test not appropriate for configuration flag */
-#define TTYPE_RESULT(ttype)	((ttype) & TTYPE_MASK)
+/**
+ * enum tst_res_flags - Test result reporting flags.
+ *
+ * @TPASS: Reports a single success.
+ * @TFAIL: Reports a single failure.
+ * @TBROK: Reports a single breakage.
+ * @TWARN: Reports a signle warning. Warnings increment a warning counter and
+ *         show up in test results.
+ *
+ * @TDEBUG: Prints additional debugging messages, it does not change the test result counters and
+ *          the message is not displayed unless debugging is enabled with -D
+ *          test command line parameter.
+ *
+ * @TINFO: Prints an additional information, it does not change the test result
+ *         counters but unlike TDEBUG the message is always displayed.
+ *
+ * @TCONF: Reports unsupported configuration. When tests produce this result at
+ *         least a subset of test was skipped, because it couldn't run. The
+ *         usuall resasons are, missing kernel modules or CONFIG options.
+ *         Unsuitable CPU architecture, not enough memory, etc.
+ *
+ * @TERRNO: Combine bitwise with result flags to append errno to the output message.
+ *
+ * @TTERRNO: Combine bitwise with result flags to append error from TST_ERR to
+ *           the message. The TST_TEST() macros store the errno into the
+ *           TST_ERR global variable in order to make sure it's not change
+ *           between the test is done and results are printed.
+ *
+ * @TRERRNO: Combine bitwise with result flags to errno from TST_RET variable
+ *           to the message. The TST_TEST() macros store return value into the
+ *           TST_RET global variable and quite a few, e.g. pthread functions,
+ *           return the error value directly instead of storing it to the errno.
+ *
+ * A result flag with optional biwise combination of errno flag are passed to
+ * the tst_res() and tst_brk() functions. Each message counts as a single test
+ * result and tests can produce arbitrary number of results, i.e. TPASS, TFAIL,
+ * TBROK, TWARN and TCONF messages. Each such message increases a result
+ * counter in a piece of shared memory, which means that reported results are
+ * accounted immediatelly even from child processes and there is no need for
+ * result propagation.
+ */
+enum tst_res_flags {
+	TPASS = 0,
+	TFAIL = 1,
+	TBROK = 2,
+	TWARN = 4,
+	TDEBUG = 8,
+	TINFO = 16,
+	TCONF = 32,
+	TERRNO = 0x100,
+	TTERRNO = 0x200,
+	TRERRNO	= 0x400,
+};
 
-#define TERRNO	0x100	/* Append errno information to output */
-#define TTERRNO	0x200	/* Append TEST_ERRNO information to output */
-#define TRERRNO	0x400	/* Capture errno information from TEST_RETURN to
-			   output; useful for pthread-like APIs :). */
+#define TTYPE_RESULT(ttype)	((ttype) & TTYPE_MASK)
+#define TTYPE_MASK 0x3f
 
 #endif /* TST_RES_FLAGS_H */
diff --git a/include/tst_test.h b/include/tst_test.h
index 47b5902f9..d83354b8e 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) Linux Test Project, 2016-2019
@@ -19,6 +19,7 @@
 
 #include "tst_common.h"
 #include "tst_res_flags.h"
+#include "tst_parse.h"
 #include "tst_test_macros.h"
 #include "tst_checkpoint.h"
 #include "tst_device.h"
@@ -47,13 +48,24 @@
 #include "tst_arch.h"
 #include "tst_fd.h"
 
-/*
- * Reports testcase result.
- */
 void tst_res_(const char *file, const int lineno, int ttype,
               const char *fmt, ...)
               __attribute__ ((format (printf, 4, 5)));
 
+/**
+ * tst_res() - Reports a test result.
+ *
+ * @ttype: An enum tst_res_type.
+ * @arg_fmt: A printf-like format.
+ * @...: A printf-like parameters.
+ *
+ * This is the main test reporting function. Each time this function is called
+ * with one of TPASS, TFAIL, TCONF, TBROK or TWARN a counter in page of shared
+ * memory is incremented. This means that there is no need to propagate test
+ * results from children and that results are accounted for once this function
+ * returns. The counters are incremented atomically which makes this funciton
+ * thread-safe.
+ */
 #define tst_res(ttype, arg_fmt, ...) \
 	({									\
 		TST_RES_SUPPORTS_TCONF_TDEBUG_TFAIL_TINFO_TPASS_TWARN(\
@@ -65,18 +77,43 @@ void tst_res_(const char *file, const int lineno, int ttype,
 void tst_resm_hexd_(const char *file, const int lineno, int ttype,
 	const void *buf, size_t size, const char *arg_fmt, ...)
 	__attribute__ ((format (printf, 6, 7)));
-
+/**
+ * tst_res_hexd() - Reports a test result along with hexdump of a buffer.
+ *
+ * This call is the same as tst_res() but includes a pointer and size of the
+ * buffer that is going to be printed in the output in a hexadecimal format.
+ *
+ * @ttype: An enum tst_res_type.
+ * @buf: A pointer to a buffer to print in hexadecimal format.
+ * @size: A size of the buffer.
+ * @arg_fmt: A printf-like format.
+ * @...: A printf-like parameters.
+ */
 #define tst_res_hexd(ttype, buf, size, arg_fmt, ...) \
 	tst_resm_hexd_(__FILE__, __LINE__, (ttype), (buf), (size), \
 			(arg_fmt), ##__VA_ARGS__)
 
-/*
- * Reports result and exits a test.
- */
 void tst_brk_(const char *file, const int lineno, int ttype,
               const char *fmt, ...)
               __attribute__ ((format (printf, 4, 5)));
 
+/**
+ * tst_brk() - Reports a breakage and exits the test.
+ *
+ * @ttype: An enum tst_res_type.
+ * @arg_fmt: A printf-like format.
+ * @...: A printf-like parameters.
+ *
+ * Reports either TBROK or TCONF and exits the test immediatelly. When called
+ * all children in the same process group as the main test library process are
+ * killed. This function, unless in a test cleanup, calls _exit() and does not
+ * return.
+ *
+ * When test is in cleanup() function TBROK is converted into TWARN by the test
+ * library and we attempt to carry on with a cleanup even when tst_brk() was
+ * called. This makes it possible to use SAFE_FOO() macros in the test cleanup
+ * without interrupting the cleanup process on a failure.
+ */
 #define tst_brk(ttype, arg_fmt, ...)						\
 	({									\
 		TST_BRK_SUPPORTS_ONLY_TCONF_TBROK(!((ttype) &			\
@@ -87,10 +124,26 @@ void tst_brk_(const char *file, const int lineno, int ttype,
 void tst_printf(const char *const fmt, ...)
 		__attribute__((nonnull(1), format (printf, 1, 2)));
 
-/* flush stderr and stdout */
+/**
+ * tst_flush() - Flushes the output file streams.
+ *
+ * There are rare cases when we want to flush the output file streams
+ * explicitly, e.g. before we do an action that may crash the test to ensure
+ * that the messages have been written out.
+ *
+ * This is also called by the SAFE_FORK() because otherwise each child would
+ * end up with the same copy of the file in it's memory and any messages in
+ * buffers would be multiplied.
+ */
 void tst_flush(void);
 
 pid_t safe_fork(const char *filename, unsigned int lineno);
+/**
+ * SAFE_FORK() - Forks a test child.
+ *
+ * This call makes sure that output file streams are flushed and also handles
+ * errors from fork(). Use this instead of fork() whenever possible!
+ */
 #define SAFE_FORK() \
 	safe_fork(__FILE__, __LINE__)
 
@@ -98,15 +151,30 @@ pid_t safe_fork(const char *filename, unsigned int lineno);
 	({int ret = expr;                                           \
 	  ret != 0 ? tst_res(TINFO, #expr " failed"), ret : ret; }) \
 
-/*
- * Functions to convert ERRNO to its name and SIGNAL to its name.
+/**
+ * tst_strerrno() - Converts an errno number into a name.
+ *
+ * @err: An errno number.
+ * return: An errno name e.g. "EINVAL".
  */
 const char *tst_strerrno(int err);
+
+/**
+ * tst_strsig() - Converts a signal number into a name.
+ *
+ * @sig: A signal number.
+ * return: A signal name e.g. "SIGINT".
+ */
 const char *tst_strsig(int sig);
-/*
- * Returns string describing status as returned by wait().
+
+
+/**
+ * tst_strstatus() - Returns string describing status as returned by wait().
+ *
+ * WARNING: Not thread safe.
  *
- * BEWARE: Not thread safe.
+ * @status: A status as returned by wait()
+ * return: A string description for the status e.g. "killed by SIGKILL".
  */
 const char *tst_strstatus(int status);
 
@@ -116,30 +184,49 @@ const char *tst_strstatus(int status);
 #include "tst_clone.h"
 #include "tst_cgroup.h"
 
-/*
- * Wait for all children and exit with TBROK if
- * any of them returned a non-zero exit status.
+/**
+ * tst_reap_children() - Waits for all child processes to exit.
+ *
+ * Wait for all children and exit with TBROK if any of them returned a non-zero
+ * exit status.
  */
 void tst_reap_children(void);
 
+/**
+ * struct tst_option - Test command line option.
+ *
+ * @optstr: A short command line option, e.g. "a" or "a:".
+ * @arg: A pointer to store the option value to.
+ * @help: A help string for the option displayed when test is passed '-h' on
+ *        the commandline.
+ */
 struct tst_option {
 	char *optstr;
 	char **arg;
 	char *help;
 };
 
-/*
- * Options parsing helpers.
+/**
+ * struct tst_tag - A test tag.
  *
- * If str is NULL these are No-op.
+ * @name: A tag name.
+ * @value: A tag value.
  *
- * On failure non-zero (errno) is returned.
+ * This structure is used to encode pointers to upstream commits in regression
+ * tests as well as CVE numbers or any additional useful hints.
+ *
+ * The content of these tags is printed by the test on a failure to help the
+ * testers with debugging.
+ *
+ * The supported tags are:
+ *
+ * - "linux-git" with first 12 numbers from an upstream kernel git hash.
+ * - "CVE" with a CVE number e.g. "2000-1234".
+ * - "glibc-git" with first 12 numbers from an upstream glibc git hash.
+ * - "musl-git" with first 12 numbers from an upstream musl git hash.
+ * - "known-fail" a message describing something that is supposed to work but
+ *   rather than that produces a longstanding failures.
  */
-int tst_parse_int(const char *str, int *val, int min, int max);
-int tst_parse_long(const char *str, long *val, long min, long max);
-int tst_parse_float(const char *str, float *val, float min, float max);
-int tst_parse_filesize(const char *str, long long *val, long long min, long long max);
-
 struct tst_tag {
 	const char *name;
 	const char *value;
@@ -147,30 +234,246 @@ struct tst_tag {
 
 extern unsigned int tst_variant;
 
-#define TST_NO_HUGEPAGES ((unsigned long)-1)
-
 #define TST_UNLIMITED_RUNTIME (-1)
 
+/**
+ * struct tst_ulimit_val - An ulimit resource and value.
+ *
+ * @resource: Which resource limits should be adjusted. See setrlimit(2) for
+ *            the list of the RLIMIT_* constants.
+ * @rlim_cur: A limit value.
+ */
 struct tst_ulimit_val {
 	int resource;
 	rlim_t rlim_cur;
 };
 
-struct tst_test {
-	/* number of tests available in test() function */
+/**
+ * struct tst_test - A test description.
+ *
+ * @tcnt: A number of tests. If set the test() callback is called tcnt times
+ *        and each time passed an increasing counter value.
+ * @options: An NULL opstr terminated array of struct tst_option.
+ *
+ * @min_kver: A minimal kernel version the test can run on. e.g. "3.10".
+ *
+ * @supported_archs: A NULL terminated array of architectures the test runs on
+ *                   e.g. {"x86_64, "x86", NULL}. Calls tst_is_on_arch() to
+ *                   check if current CPU architecture is supported and exits
+ *                   the test with TCONF if it's not.
+ *
+ * @tconf_msg: If set the test exits with TCONF right after entering the test
+ *             library. This is used by the TST_TEST_TCONF() macro to disable
+ *             tests at compile time.
+ *
+ * @needs_tmpdir: If set a temporary directory is prepared for the test inside
+ *                $TMPDIR and the test $CWD is set to point to it. The content
+ *                of the temporary directory is removed automatically after
+ *                the test is finished.
+ *
+ * @needs_root: If set the test exit with TCONF unless it's executed under root
+ *              user.
+ *
+ * @forks_child: Has to be set if the test intends to fork children.
+ *
+ * @needs_device: If set a block device is prepared for the test, the device
+ *                path and size are set in the struct tst_device variable
+ *                called tst_device. If $LTP_DEV variable exists in the test
+ *                environment the test attempts to use that device first and
+ *                only if that fails the test falls back to use loop devices.
+ *                This flag implies needs_tmpdir flag because loop device
+ *                backing files are created in the test temporary directory.
+ *
+ * @needs_checkpoints: Has to be set if the test wants to use checkpoint
+ *                     synchronization primitives.
+ *
+ * @needs_overlay: If set overlay filesystem is mounted on the top of the
+ *                 filesystem at tst_test.mntpoint.
+ *
+ * @format_device: Does all tst_test.needs_device would do and also formats
+ *                 the device with tst_test.dev_fs_type filesystem as well.
+ *
+ * @mount_device: Does all tst_test.format_device would do and also mounts the
+ *                device at tst_test.mntpoint.
+ *
+ * @needs_rofs: If set a read-only filesystem is mounted at tst_test.mntpoint.
+ *
+ * @child_needs_reinit: Has to be set if the test needs to call tst_reinit()
+ *                      from a process started by exec().
+ *
+ * @needs_devfs: If set the devfs is mounted at tst_test.mntpoint. This is
+ *               needed for tests that need to create device files since tmpfs
+ *               at /tmp is usually mounted with 'nodev' option.
+ *
+ * @restore_wallclock: Saves wall clock at the start of the test and restores
+ *                     it at the end with the help of monotonic timers.
+ *                     Testcases that modify system wallclock use this to
+ *                     restore the system to the previous state.
+ *
+ * @all_filesystems: If set the test is executed for all supported filesytems,
+ *                   i.e. filesystem that is supported by the kernel and has
+ *                   mkfs installed on the system. The filesystem is mounted at
+ *                   tst_test.tmpdir and filesytem details, e.g. type are set
+ *                   in the struct tst_device. Each execution is independent,
+ *                   that means that for each iteration tst_test.setup() is
+ *                   called at the test start and tst_test.cleanup() is called
+ *                   at the end and tst_brk() exit only test for a single
+ *                   filesystem. That especially means that calling
+ *                   tst_brk(TCONF, ...) in the test setup will skip the
+ *                   current filesystem.
+ *
+ * @skip_in_lockdown: Skip the test if kernel lockdown is enabled.
+ *
+ * @skip_in_secureboot: Skip the test if secureboot is enabled.
+ *
+ * @skip_in_compat: Skip the test if we are executing 32bit binary on a 64bit
+ *                  kernel, i.e. we are testing the kernel compat layer.
+ *
+ * @needs_hugetlbfs: If set hugetlbfs is mounted at tst_test.mntpoint.
+ *
+ * @skip_filesystems: A NULL terminated array of unsupported filesystems. The
+ *                    test reports TCONF if the filesystem to be tested is
+ *                    present in the array. This is especially useful to filter
+ *                    out unsupported filesystem when tst_test.all_filesystems
+ *                    is enabled.
+ *
+ * @min_cpus: Minimal number of online CPUs the test needs to run.
+ *
+ * @min_mem_avail: Minimal amount of available RAM memory in megabytes required
+ *                 for the test to run.
+ *
+ * @min_swap_avail: Minimal amount of available swap memory in megabytes
+ *                  required for the test to run.
+ *
+ * @hugepages: An interface to reserve hugepages prior running the test.
+ *             Request how many hugepages should be reserved in the global
+ *             pool and also if having hugepages is required for the test run
+ *             or not, i.e. if test should exit with TCONF if the requested
+ *             amount of hugepages cannot be reserved. If TST_REQUEST is set
+ *             the library will try it's best to reserve the hugepages and
+ *             return the number of available hugepages in tst_hugepages, which
+ *             may be 0 if there is no free memory or hugepages are not
+ *             supported at all. If TST_NEEDS the requested hugepages are
+ *             required for the test and the test exits if it couldn't be
+ *             required. It can also be used to disable hugepages by setting
+ *             .hugepages = {TST_NO_HUGEPAGES}. The test library restores the
+ *             original poll allocations after the test has finished.
+ *
+ * @taint_check: If set the test fails if kernel is tainted during the test run.
+ *               That means tst_taint_init() is called during the test setup
+ *               and tst_taint_check() at the end of the test. If all_filesystems
+ *               is set taint check will be performed after each iteration and
+ *               testing will be terminated by TBROK if taint is detected.
+ *
+ * @test_variants: If set denotes number of test variant, the test is executed
+ *                 variants times each time with tst_variant set to different
+ *                 number. This allows us to run the same test for different
+ *                 settings. The intended use is to test different syscall
+ *                 wrappers/variants but the API is generic and does not limit
+ *                 usage in any way.
+ *
+ * @dev_min_size: A minimal device size in megabytes.
+ *
+ * @dev_fs_type: If set overrides the default filesystem type for the device and
+ *               sets the tst_device.fs_type.
+ *
+ * @dev_fs_opts: A NULL terminated array of options passed to mkfs in the case
+ *               of 'tst_test.format_device'. These options are passed to mkfs
+ *               before the device path.
+ *
+ * @dev_extra_opts: A NULL terminated array of extra options passed to mkfs in
+ *                  the case of 'tst_test.format_device'. Extra options are
+ *                  passed to mkfs after the device path. Commonly the option
+ *                  after mkfs is the number of blocks and can be used to limit
+ *                  the filesystem not to use the whole block device.
+ *
+ * @mntpoint: A mount point where the test library mounts requested filesystem.
+ *            The directory is created by the library, the test must not create
+ *            it itself.
+ *
+ * @mnt_flags: MS_* flags passed to mount(2) when the test library mounts a
+ *             device in the case of 'tst_test.mount_device'.
+ *
+ * @mnt_data: The data passed to mount(2) when the test library mounts a device
+ *            in the case of 'tst_test.mount_device'.
+ *
+ * @max_runtime: Maximal test runtime in seconds. Any test that runs for more
+ *               than a second or two should set this and also use
+ *               tst_remaining_runtime() to exit when runtime was used up.
+ *               Tests may finish sooner, for example if requested number of
+ *               iterations was reached before the runtime runs out. If test
+ *               runtime cannot be know in advance it should be set to
+ *               TST_UNLIMITED_RUNTIME.
+ *
+ * @setup: Setup callback is called once at the start of the test in order to
+ *         prepare the test environment.
+ *
+ * @cleanup: Cleanup callback is either called at the end of the test, or in a
+ *           case that tst_brk() was called. That means that cleanup must be
+ *           able to handle all possible states the test can be in. This
+ *           usually means that we have to check if file descriptor was opened
+ *           before we attempt to close it in the setup, etc.
+ *
+ *
+ * @test: A main test function, only one of the tst_test.test and test_all can
+ *        be set. When this function is set the tst_test.tcnt must be set to a
+ *        positive integer and this function will be executed tcnt times
+ *        during a single test iteration. May be executed several times if test
+ *        was passed '-i' or '-d' command line parameters.
+ *
+ * @test_all: A main test function, only one of the tst_test.test and test_all
+ *            can be set. May be executed several times if test was passed '-i'
+ *            or '-d' command line parameters.
+ *
+ * @resource_files: A NULL terminated array of filenames that will be copied
+ *                  to the test temporary directory from the LTP datafiles
+ *                  directory.
+ *
+ * @needs_drivers: A NULL terminated array of kernel modules required to run
+ *                 the test. The module has to be build in or present in order
+ *                 for the test to run.
+ *
+ * @save_restore: A {} terminated array of /proc or /sys files that should
+ *                saved at the start of the test and restored at the end. See
+ *                tst_sys_conf_save() and struct tst_path_val for details.
+ *
+ * @ulimit: A {} terminated array of process limits RLIMIT_* to be adjusted for
+ *          the test.
+ *
+ * @needs_kconfigs: A NULL terminated array of kernel config options that are
+ *                  required for the test. All strings in the array have to be
+ *                  evaluated to true for the test to run. Boolean opearors
+ *                  and parenthesis are supported, e.g.
+ *                  "CONFIG_X86_INTEL_UMIP=y | CONFIG_X86_UIMP=y" is evaluated
+ *                  to true if at least one of the options is present.
+ *
+ * @bufs: A description of guarded buffers to be allocated for the test. Guarded
+ *        buffers are buffers with poisoned page allocated right before the start
+ *        of the buffer and canary right after the end of the buffer. See
+ *        struct tst_buffers and tst_buffer_alloc() for details.
+ *
+ * @caps: A {} terminated array of capabilities to change before the start of
+ *        the test. See struct tst_cap and tst_cap_setup() for details.
+ *
+ * @tags: A {} terminated array of test tags. See struct tst_tag for details.
+ *
+ * @needs_cmds: A NULL terminated array of commands required for the test to run.
+ *
+ * @needs_cgroup_ver: If set the test will run only if the specified cgroup
+ *                    version is present on the system.
+ *
+ * @needs_cgroup_ctrls: List of cgroup controllers the test needs to run.
+ */
+
+ struct tst_test {
 	unsigned int tcnt;
 
 	struct tst_option *options;
 
 	const char *min_kver;
 
-	/*
-	 * The supported_archs is a NULL terminated list of archs the test
-	 * does support.
-	 */
 	const char *const *supported_archs;
 
-	/* If set the test is compiled out */
 	const char *tconf_msg;
 
 	int needs_tmpdir:1;
@@ -186,182 +489,98 @@ struct tst_test {
 	int needs_devfs:1;
 	int restore_wallclock:1;
 
-	/*
-	 * If set the test function will be executed for all available
-	 * filesystems and the current filesystem type would be set in the
-	 * tst_device->fs_type.
-	 *
-	 * The test setup and cleanup are executed before/after __EACH__ call
-	 * to the test function.
-	 */
 	int all_filesystems:1;
 
 	int skip_in_lockdown:1;
 	int skip_in_secureboot:1;
 	int skip_in_compat:1;
 
-	/*
-	 * If set, the hugetlbfs will be mounted at .mntpoint.
-	 */
 	int needs_hugetlbfs:1;
 
-	/*
-	 * The skip_filesystems is a NULL terminated list of filesystems the
-	 * test does not support. It can also be used to disable whole class of
-	 * filesystems with a special keywords such as "fuse".
-	 */
 	const char *const *skip_filesystems;
 
-	/* Minimum number of online CPU required by the test */
 	unsigned long min_cpus;
-
-	/* Minimum size(MB) of MemAvailable required by the test */
 	unsigned long min_mem_avail;
-
-	/* Minimum size(MB) of SwapFree required by the test */
 	unsigned long min_swap_avail;
 
-	/*
-	 * Two policies for reserving hugepage:
-	 *
-	 * TST_REQUEST:
-	 *   It will try the best to reserve available huge pages and return the number
-	 *   of available hugepages in tst_hugepages, which may be 0 if hugepages are
-	 *   not supported at all.
-	 *
-	 * TST_NEEDS:
-	 *   This is an enforced requirement, LTP should strictly do hpages applying and
-	 *   guarantee the 'HugePages_Free' no less than pages which makes that test can
-	 *   use these specified numbers correctly. Otherwise, test exits with TCONF if
-	 *   the attempt to reserve hugepages fails or reserves less than requested.
-	 *
-	 * With success test stores the reserved hugepage number in 'tst_hugepages. For
-	 * the system without hugetlb supporting, variable 'tst_hugepages' will be set to 0.
-	 * If the hugepage number needs to be set to 0 on supported hugetlb system, please
-	 * use '.hugepages = {TST_NO_HUGEPAGES}'.
-	 *
-	 * Also, we do cleanup and restore work for the hpages resetting automatically.
-	 */
 	struct tst_hugepage hugepages;
 
-	/*
-	 * If set to non-zero, call tst_taint_init(taint_check) during setup
-	 * and check kernel taint at the end of the test. If all_filesystems
-	 * is non-zero, taint check will be performed after each FS test and
-	 * testing will be terminated by TBROK if taint is detected.
-	 */
 	unsigned int taint_check;
 
-	/*
-	 * If set non-zero denotes number of test variant, the test is executed
-	 * variants times each time with tst_variant set to different number.
-	 *
-	 * This allows us to run the same test for different settings. The
-	 * intended use is to test different syscall wrappers/variants but the
-	 * API is generic and does not limit the usage in any way.
-	 */
 	unsigned int test_variants;
 
-	/* Minimal device size in megabytes */
 	unsigned int dev_min_size;
 
-	/* Device filesystem type override NULL == default */
 	const char *dev_fs_type;
 
-	/* Options passed to SAFE_MKFS() when format_device is set */
 	const char *const *dev_fs_opts;
 	const char *const *dev_extra_opts;
 
-	/* Device mount options, used if mount_device is set */
 	const char *mntpoint;
 	unsigned int mnt_flags;
 	void *mnt_data;
 
-	/*
-	 * Maximal test runtime in seconds.
-	 *
-	 * Any test that runs for more than a second or two should set this and
-	 * also use tst_remaining_runtime() to exit when runtime was used up.
-	 * Tests may finish sooner, for example if requested number of
-	 * iterations was reached before the runtime runs out.
-	 *
-	 * If test runtime cannot be know in advance it should be set to
-	 * TST_UNLIMITED_RUNTIME.
-	 */
 	int max_runtime;
 
 	void (*setup)(void);
 	void (*cleanup)(void);
-
 	void (*test)(unsigned int test_nr);
 	void (*test_all)(void);
 
-	/* Syscall name used by the timer measurement library */
 	const char *scall;
-
-	/* Sampling function for timer measurement testcases */
 	int (*sample)(int clk_id, long long usec);
 
-	/* NULL terminated array of resource file names */
 	const char *const *resource_files;
-
-	/* NULL terminated array of needed kernel drivers */
 	const char * const *needs_drivers;
 
-	/*
-	 * {NULL, NULL} terminated array of (/proc, /sys) files to save
-	 * before setup and restore after cleanup
-	 */
 	const struct tst_path_val *save_restore;
 
-	/*
-	 * {} terminated array of ulimit resource type and value.
-	 */
 	const struct tst_ulimit_val *ulimit;
 
-	/*
-	 * NULL terminated array of kernel config options required for the
-	 * test.
-	 */
 	const char *const *needs_kconfigs;
 
-	/*
-	 * {NULL, NULL} terminated array to be allocated buffers.
-	 */
 	struct tst_buffers *bufs;
 
-	/*
-	 * {NULL, NULL} terminated array of capability settings
-	 */
 	struct tst_cap *caps;
 
-	/*
-	 * {NULL, NULL} terminated array of tags.
-	 */
 	const struct tst_tag *tags;
 
-	/* NULL terminated array of required commands */
 	const char *const *needs_cmds;
 
-	/* Requires a particular CGroup API version. */
 	const enum tst_cg_ver needs_cgroup_ver;
 
 	/* {} terminated array of required CGroup controllers */
 	const char *const *needs_cgroup_ctrls;
 };
 
-/*
- * Runs tests.
+/**
+ * tst_run_tcases() - Entry point to the test library.
+ *
+ * @argc: An argc that was passed to the main().
+ * @argv: An argv that was passed to the main().
+ * @self: The test description and callbacks packed in the struct tst_test
+ *        structure.
+ *
+ * A main() function which calls this function is added to each test
+ * automatically by including the tst_test.h header. The test has to define the
+ * struct tst_test called tst_test.
+ *
+ * This fuction does not return, i.e. calls exit() after the test has finished.
  */
 void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
                     __attribute__ ((noreturn));
 
 #define IPC_ENV_VAR "LTP_IPC_PATH"
 
-/*
- * Does library initialization for child processes started by exec()
+/**
+ * tst_reinit() - Reinitialize the test library.
  *
- * The LTP_IPC_PATH variable must be passed to the program environment.
+ * In a cases where a test child process calls exec() it no longer can access
+ * the test library shared memory and therefore use the test reporting
+ * functions, checkpoint library, etc. This function reinitializes the test
+ * library so that it can be used again.
+ *
+ * @important The LTP_IPC_PATH variable must be passed to the program environment.
  */
 void tst_reinit(void);
 
@@ -416,6 +635,12 @@ int main(int argc, char *argv[])
 
 #endif /* TST_NO_DEFAULT_MAIN */
 
+/**
+ * TST_TEST_TCONF() - Exit tests with a TCONF message.
+ *
+ * This macro is used in test that couldn't be compiled either because current
+ * CPU architecture is unsupported or because of missing development libraries.
+ */
 #define TST_TEST_TCONF(message)                                 \
         static struct tst_test test = { .tconf_msg = message  } \
 
-- 
2.43.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
