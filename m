Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0669C5DF74
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:14:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DB9D3CCDDF
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:14:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB62D3CB035
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C3BA5600809
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34B46845C5
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=br3pn/XhpWQIuAzfgjmbGC0xiX/LhzAJpTnC4glCooQ=;
 b=suODVGfZDwOStAvOhdNZBTwTjrcm9uj6nzszyQBPVCYTwCKa7brAGtFtlL26jUUW4baxeq
 apm2CBPfVNPQLZOEiFHy5aE9Fp6V2lzFI0wzQDN4gxKMBYztYUveymkQgnz+n+kkjtmbMu
 599r63JMPoJuwUgiGiswQ0V24KkSWvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062392;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=br3pn/XhpWQIuAzfgjmbGC0xiX/LhzAJpTnC4glCooQ=;
 b=BlHxqjg2XTUNUZQ1Rq5BqGuZr2bFM9fFAPNsCf6I1dvexKzrONOfMPHAyCULbG3OgLDuMY
 Fal5lbfEEmgtojBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UGxbXLHW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JI9Tb7ZO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=br3pn/XhpWQIuAzfgjmbGC0xiX/LhzAJpTnC4glCooQ=;
 b=UGxbXLHWN5ckBvTN01GF7JvkG66zwD2VN3R6JUD0oHS41h/30HoyFsMLptP4IDpQLUmWEy
 CspcI0/Zs3IL1TPSy5aL+pw1SNB3OaqTT9WO/NNXqUkzh7RCjJPVZpVdQQWE2A+BbXwpTM
 5gJtYpJK4ZNBbP+boyeSI+fK6VTlzw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=br3pn/XhpWQIuAzfgjmbGC0xiX/LhzAJpTnC4glCooQ=;
 b=JI9Tb7ZOfP2aN6JHJ4l4rK9rIHaNKGb3/iJ4EB003mhw/lpgqDQ7G1w+gzTsMuQ/Iapam3
 QYJsHdromxxeDEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0588D339C
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Mkx9O3NohGrFcAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:07 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:12:41 +0200
Message-ID: <20260818141311.1265557-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818141311.1265557-1-chrubis@suse.cz>
References: <20260818141311.1265557-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 34B46845C5
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 01/31] lib: Add tst_sysfs_assert
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

Adds helpers for a sysfs testscases.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/developers/api_c_tests.rst |   5 +
 include/tst_sysfs_assert.h     | 588 ++++++++++++++++++++++++
 lib/tst_sysfs_assert.c         | 797 +++++++++++++++++++++++++++++++++
 3 files changed, 1390 insertions(+)
 create mode 100644 include/tst_sysfs_assert.h
 create mode 100644 lib/tst_sysfs_assert.c

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index 1e9e595dd..a0a9ee2ba 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -105,3 +105,8 @@ Test macros
 Uinput
 ------
 .. kernel-doc:: ../../include/tse_uinput.h
+
+Sysfs
+-----
+
+.. kernel-doc:: ../../include/tst_sysfs_assert.h
diff --git a/include/tst_sysfs_assert.h b/include/tst_sysfs_assert.h
new file mode 100644
index 000000000..6cef5271a
--- /dev/null
+++ b/include/tst_sysfs_assert.h
@@ -0,0 +1,588 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_SYSFS_ASSERT_H__
+#define TST_SYSFS_ASSERT_H__
+
+#include <stddef.h>
+
+/**
+ * TST_SYSFS_ASSERT_RANGELL() - Asserts that min <= val <= max.
+ *
+ * The val is read from a path constructed from the fmt. Both bounds are long
+ * int values, hence the LL (long, long) suffix.
+ *
+ * @min: A long int minimal value.
+ * @max: A long int maximal value.
+ * @fmt: A printf-like format to build path to the file to read the val from.
+ * @...: A printf-like parameters for the path.
+ */
+#define TST_SYSFS_ASSERT_RANGELL(min, max, fmt, ...) \
+	tst_sysfs_assert_rangell(__FILE__, __LINE__, min, max, fmt, ##__VA_ARGS__)
+
+void tst_sysfs_assert_rangell(const char *file, const int lineno,
+	long min, long max, const char *fmt, ...);
+
+/**
+ * TST_SYSFS_ASSERT_RANGELL_SILENT() - Asserts that min <= val <= max.
+ *
+ * The val is read from a path constructed from the fmt. Both bounds are long
+ * int values, hence the LL (long, long) suffix.
+ *
+ * Silently skips the check if the file path constructed from fmt does not
+ * exist.
+ *
+ * @min: A minimal value.
+ * @max: A maximal value.
+ * @fmt: A printf-like format to build path to the file to read the val from.
+ * @...: A printf-like parameters for the path.
+ */
+#define TST_SYSFS_ASSERT_RANGELL_SILENT(min, max, fmt, ...) \
+	tst_sysfs_assert_rangell_silent(__FILE__, __LINE__, min, max, fmt, ##__VA_ARGS__)
+
+void tst_sysfs_assert_rangell_silent(const char *file, const int lineno,
+	long min, long max, const char *fmt, ...);
+
+/**
+ * TST_SYSFS_ASSERT_RANGELF() - Asserts that min <= val <= max.
+ *
+ * The min bound is a long int, while the max bound is read from a file, hence
+ * the LF (long, file) suffix. The value and max paths are built by appending
+ * val_suffix/max_suffix to a common prefix built from fmt.
+ *
+ * Skips with TCONF if either file does not exist.
+ *
+ * @min: A minimal value.
+ * @val_suffix: A filename the val is read from.
+ * @max_suffix: A filename the max is read from.
+ * @fmt: A printf-like format to build the path to val and max from.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_RANGELF(min, val_suffix, max_suffix, fmt, ...) \
+	tst_sysfs_assert_rangelf(__FILE__, __LINE__, min, val_suffix, \
+		max_suffix, fmt, ##__VA_ARGS__)
+
+void tst_sysfs_assert_rangelf(const char *file, const int lineno,
+	long min, const char *val_suffix, const char *max_suffix,
+	const char *fmt, ...);
+
+/**
+ * TST_SYSFS_ASSERT_BOOL() - Asserts that file has boolean value.
+ *
+ * Reads a value from the file at the path built from fmt and asserts
+ * that it is a boolean (0 or 1).
+ *
+ * Skips with TCONF if the file does not exist.
+ *
+ * @fmt: A printf-like format to build a path to the boolean file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_BOOL(fmt, ...) \
+	tst_sysfs_assert_bool(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
+void tst_sysfs_assert_bool(const char *file, const int lineno,
+	const char *fmt, ...);
+
+/**
+ * TST_SYSFS_ASSERT_BOOL_SILENT() - Asserts that file has boolean value.
+ *
+ * Reads a value from the file at the path built from fmt and asserts
+ * that it is a boolean (0 or 1).
+ *
+ * Silently skips the check if the file path constructed from fmt does not
+ * exist.
+ *
+ * @fmt: A printf-like format to build a path to the boolean file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_BOOL_SILENT(fmt, ...) \
+	tst_sysfs_assert_bool_silent(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
+void tst_sysfs_assert_bool_silent(const char *file, const int lineno,
+	const char *fmt, ...);
+
+/**
+ * TST_SYSFS_ASSERT_POW2() - Asserts that file has number that is power of two.
+ *
+ * Reads a long value from the file at the path built from fmt and asserts
+ * that it is a power of two, i.e. value > 0 and (value & (value - 1)) == 0.
+ *
+ * Skips with TCONF if the file does not exist.
+ *
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like params for fmt.
+ */
+#define TST_SYSFS_ASSERT_POW2(fmt, ...) \
+	tst_sysfs_assert_pow2(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
+void tst_sysfs_assert_pow2(const char *file, const int lineno,
+	const char *fmt, ...);
+
+/**
+ * TST_SYSFS_ASSERT_CHOICE() - Asserts that file is a list of choices.
+ *
+ * Validates a bracketed-choice file such as:
+ *
+ *   "none mq-deadline kyber [bfq]"
+ *   "[always] madvise never"
+ *
+ * Asserts that exactly one token is [selected]. If allowed is non-NULL (a
+ * NULL-terminated array of strings) it also asserts that every token is a
+ * member of the allowed set. If sel is non-NULL the selected token (with the
+ * brackets stripped) is copied into sel, truncated to sel_size.
+ *
+ * Skips with TCONF if the file does not exist.
+ *
+ * @allowed: Optional NULL terminated array of allowed choices.
+ * @sel: A buffer to copy the selected choice into.
+ * @sel_size: A size of the sel buffer.
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_CHOICE(allowed, sel, sel_size, fmt, ...) \
+	tst_sysfs_assert_choice(__FILE__, __LINE__, allowed, sel, sel_size, \
+		fmt, ##__VA_ARGS__)
+
+void tst_sysfs_assert_choice(const char *file, const int lineno,
+	const char *const allowed[], char *sel, size_t sel_size,
+	const char *fmt, ...);
+
+/**
+ * TST_SYSFS_ASSERT_TOKENS() - Asserts that file is a list of tokens.
+ *
+ * Validates a file that lists a whitespace-separated set of tokens without any
+ * bracketed "current" selection, such as /sys/power/state:
+ *
+ *   "freeze mem disk"
+ *
+ * Asserts that the file is non-empty and, if allowed is non-NULL, that every
+ * token is a member of the allowed set (a NULL-terminated array of strings).
+ *
+ * If find is non-NULL it additionally asserts that find itself was seen
+ * among the tokens, which is useful for cross-checking a "current" value
+ * read from a different file against this file's list, e.g.:
+ *
+ *   TST_SYSFS_ASSERT_TOKENS(NULL, current_clocksource,
+ *                           "%s/available_clocksource", name);
+ *
+ * Skips with TCONF if the file does not exist.
+ *
+ * @allowed: Optional NULL terminated array of allowed tokens.
+ * @find: Optional token that must be present in the file, or NULL to skip
+ *        this check.
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_TOKENS(allowed, find, fmt, ...) \
+	tst_sysfs_assert_tokens(__FILE__, __LINE__, allowed, find, fmt, ##__VA_ARGS__)
+
+void tst_sysfs_assert_tokens(const char *file, const int lineno,
+	const char *const allowed[], const char *find, const char *fmt, ...);
+
+/**
+ * TST_SYSFS_ASSERT_ONEOF() - Asserts that file has one of allowed strings.
+ *
+ * Reads a single whitespace-delimited string token from the file at the path
+ * built from fmt and asserts that it is a member of the allowed set (a
+ * NULL-terminated array of strings), e.g. the cache "type" being one of
+ * Data/Instruction/Unified.
+ *
+ * Skips with TCONF if the file does not exist.
+ *
+ * @allowed: A NULL terminated array of allowed strings.
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_ONEOF(allowed, fmt, ...) \
+	tst_sysfs_assert_oneof(__FILE__, __LINE__, allowed, fmt, ##__VA_ARGS__)
+
+void tst_sysfs_assert_oneof(const char *file, const int lineno,
+	const char *const allowed[], const char *fmt, ...);
+
+/**
+ * TST_SYSFS_ASSERT_PARSE_LIST() - Parses a cpulist/nodelist-style file.
+ *
+ * Parses a file such as "0-1,3", which is used by many sysfs attributes (cpu
+ * online/present/possible, node online/possible, ...).
+ *
+ * On success it stores the number of set entries into count (if non-NULL)
+ * and the highest id present into max_id (if non-NULL) and returns 0. An
+ * empty list yields count == 0 and max_id == -1.
+ *
+ * On failure it reports the reason itself and returns non-zero: TCONF if the
+ * file does not exist, TFAIL if the content cannot be parsed. The caller
+ * only needs to check the return value to decide whether to skip any
+ * further checks that depend on the count/max_id values.
+ *
+ * @count: A pointer to store the number of set entries to, or NULL.
+ * @max_id: A pointer to store the highest id present to, or NULL.
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_PARSE_LIST(count, max_id, fmt, ...) \
+	tst_sysfs_assert_parse_list(__FILE__, __LINE__, count, max_id, \
+		fmt, ##__VA_ARGS__)
+
+int tst_sysfs_assert_parse_list(const char *file, const int lineno,
+	int *count, int *max_id, const char *fmt, ...);
+
+/**
+ * TST_SYSFS_ASSERT_LIST_SUBSET() - Asserts a cpulist/nodelist is a subset.
+ *
+ * Asserts that the cpulist/nodelist in sub_path is a subset of the list in
+ * super_path, i.e. every id set in sub_path is also set in super_path.
+ *
+ * Skips with TCONF if either file does not exist.
+ *
+ * @sub_path: A path to the file with the presumed subset list.
+ * @super_path: A path to the file with the presumed superset list.
+ */
+#define TST_SYSFS_ASSERT_LIST_SUBSET(sub_path, super_path) \
+	tst_sysfs_assert_list_subset(__FILE__, __LINE__, sub_path, super_path)
+
+void tst_sysfs_assert_list_subset(const char *file, const int lineno,
+	const char *sub_path, const char *super_path);
+
+/**
+ * TST_SYSFS_ASSERT_LIST_CONTAINS() - Asserts that id is in a cpulist/nodelist.
+ *
+ * Asserts that id is a member of the cpulist/nodelist in the file at the
+ * path built from fmt, e.g. that a given CPU is listed in its own
+ * thread_siblings_list.
+ *
+ * Skips with TCONF if the file does not exist.
+ *
+ * @id: The id that must be present in the list.
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_LIST_CONTAINS(id, fmt, ...) \
+	tst_sysfs_assert_list_contains(__FILE__, __LINE__, id, fmt, ##__VA_ARGS__)
+
+void tst_sysfs_assert_list_contains(const char *file, const int lineno,
+	int id, const char *fmt, ...);
+
+/**
+ * enum tst_sysfs_cmp - Comparison operators used by tst_sysfs_assert_cmp().
+ *
+ * @TST_SYSFS_CMP_EQ: val1 == val2
+ * @TST_SYSFS_CMP_LT: val1 < val2
+ * @TST_SYSFS_CMP_LE: val1 <= val2
+ */
+enum tst_sysfs_cmp {
+	TST_SYSFS_CMP_EQ,
+	TST_SYSFS_CMP_LT,
+	TST_SYSFS_CMP_LE,
+};
+
+void tst_sysfs_assert_cmp(const char *file, const int lineno,
+	const char *path1, enum tst_sysfs_cmp op, const char *path2);
+
+/**
+ * TST_SYSFS_ASSERT_EQ() - Asserts that val1 == val2.
+ *
+ * Reads a long value from each of path1 and path2 and asserts that they are
+ * equal. Skips with TCONF if either file does not exist.
+ *
+ * @path1: A path to the file with val1.
+ * @path2: A path to the file with val2.
+ */
+#define TST_SYSFS_ASSERT_EQ(path1, path2) \
+	tst_sysfs_assert_cmp(__FILE__, __LINE__, path1, TST_SYSFS_CMP_EQ, path2)
+
+/**
+ * TST_SYSFS_ASSERT_LT() - Asserts that val1 < val2.
+ *
+ * Reads a long value from each of path1 and path2 and asserts that val1 is
+ * less than val2. Skips with TCONF if either file does not exist.
+ *
+ * @path1: A path to the file with val1.
+ * @path2: A path to the file with val2.
+ */
+#define TST_SYSFS_ASSERT_LT(path1, path2) \
+	tst_sysfs_assert_cmp(__FILE__, __LINE__, path1, TST_SYSFS_CMP_LT, path2)
+
+/**
+ * TST_SYSFS_ASSERT_LE() - Asserts that val1 <= val2.
+ *
+ * Reads a long value from each of path1 and path2 and asserts that val1 is
+ * less than or equal to val2. Skips with TCONF if either file does not
+ * exist.
+ *
+ * @path1: A path to the file with val1.
+ * @path2: A path to the file with val2.
+ */
+#define TST_SYSFS_ASSERT_LE(path1, path2) \
+	tst_sysfs_assert_cmp(__FILE__, __LINE__, path1, TST_SYSFS_CMP_LE, path2)
+
+void tst_sysfs_assert_cmp_silent(const char *file, const int lineno,
+	const char *path1, enum tst_sysfs_cmp op, const char *path2);
+
+/**
+ * TST_SYSFS_ASSERT_EQ_SILENT() - Asserts that val1 == val2.
+ *
+ * Same as TST_SYSFS_ASSERT_EQ(), but silently skips the check if either file
+ * does not exist.
+ *
+ * @path1: A path to the file with val1.
+ * @path2: A path to the file with val2.
+ */
+#define TST_SYSFS_ASSERT_EQ_SILENT(path1, path2) \
+	tst_sysfs_assert_cmp_silent(__FILE__, __LINE__, path1, TST_SYSFS_CMP_EQ, path2)
+
+/**
+ * TST_SYSFS_ASSERT_LT_SILENT() - Asserts that val1 < val2.
+ *
+ * Same as TST_SYSFS_ASSERT_LT(), but silently skips the check if either file
+ * does not exist.
+ *
+ * @path1: A path to the file with val1.
+ * @path2: A path to the file with val2.
+ */
+#define TST_SYSFS_ASSERT_LT_SILENT(path1, path2) \
+	tst_sysfs_assert_cmp_silent(__FILE__, __LINE__, path1, TST_SYSFS_CMP_LT, path2)
+
+/**
+ * TST_SYSFS_ASSERT_LE_SILENT() - Asserts that val1 <= val2.
+ *
+ * Same as TST_SYSFS_ASSERT_LE(), but silently skips the check if either file
+ * does not exist.
+ *
+ * @path1: A path to the file with val1.
+ * @path2: A path to the file with val2.
+ */
+#define TST_SYSFS_ASSERT_LE_SILENT(path1, path2) \
+	tst_sysfs_assert_cmp_silent(__FILE__, __LINE__, path1, TST_SYSFS_CMP_LE, path2)
+
+void tst_sysfs_assert_cmp_suffix(const char *file, const int lineno,
+	enum tst_sysfs_cmp op, const char *lo_suffix, const char *hi_suffix,
+	const char *fmt, ...);
+
+/**
+ * TST_SYSFS_ASSERT_EQ_SUFFIX() - Asserts that val1 == val2.
+ *
+ * Same as TST_SYSFS_ASSERT_EQ(), but path1/path2 are built by appending
+ * lo_suffix/hi_suffix to a common prefix built from fmt.
+ *
+ * @lo_suffix: A suffix appended to fmt to build the path to val1.
+ * @hi_suffix: A suffix appended to fmt to build the path to val2.
+ * @fmt: A printf-like format to build the common path prefix.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_EQ_SUFFIX(lo_suffix, hi_suffix, fmt, ...) \
+	tst_sysfs_assert_cmp_suffix(__FILE__, __LINE__, TST_SYSFS_CMP_EQ, \
+		lo_suffix, hi_suffix, fmt, ##__VA_ARGS__)
+
+/**
+ * TST_SYSFS_ASSERT_LT_SUFFIX() - Asserts that val1 < val2.
+ *
+ * Same as TST_SYSFS_ASSERT_LT(), but path1/path2 are built by appending
+ * lo_suffix/hi_suffix to a common prefix built from fmt.
+ *
+ * @lo_suffix: A suffix appended to fmt to build the path to val1.
+ * @hi_suffix: A suffix appended to fmt to build the path to val2.
+ * @fmt: A printf-like format to build the common path prefix.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_LT_SUFFIX(lo_suffix, hi_suffix, fmt, ...) \
+	tst_sysfs_assert_cmp_suffix(__FILE__, __LINE__, TST_SYSFS_CMP_LT, \
+		lo_suffix, hi_suffix, fmt, ##__VA_ARGS__)
+
+/**
+ * TST_SYSFS_ASSERT_LE_SUFFIX() - Asserts that val1 <= val2.
+ *
+ * Same as TST_SYSFS_ASSERT_LE(), but path1/path2 are built by appending
+ * lo_suffix/hi_suffix to a common prefix built from fmt.
+ *
+ * @lo_suffix: A suffix appended to fmt to build the path to val1.
+ * @hi_suffix: A suffix appended to fmt to build the path to val2.
+ * @fmt: A printf-like format to build the common path prefix.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_LE_SUFFIX(lo_suffix, hi_suffix, fmt, ...) \
+	tst_sysfs_assert_cmp_suffix(__FILE__, __LINE__, TST_SYSFS_CMP_LE, \
+		lo_suffix, hi_suffix, fmt, ##__VA_ARGS__)
+
+void tst_sysfs_assert_cmp_suffix_silent(const char *file, const int lineno,
+	enum tst_sysfs_cmp op, const char *lo_suffix, const char *hi_suffix,
+	const char *fmt, ...);
+
+/**
+ * TST_SYSFS_ASSERT_EQ_SUFFIX_SILENT() - Asserts that val1 == val2.
+ *
+ * Same as TST_SYSFS_ASSERT_EQ_SUFFIX(), but silently skips the check if
+ * either file does not exist.
+ *
+ * @lo_suffix: A suffix appended to fmt to build the path to val1.
+ * @hi_suffix: A suffix appended to fmt to build the path to val2.
+ * @fmt: A printf-like format to build the common path prefix.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_EQ_SUFFIX_SILENT(lo_suffix, hi_suffix, fmt, ...) \
+	tst_sysfs_assert_cmp_suffix_silent(__FILE__, __LINE__, \
+		TST_SYSFS_CMP_EQ, lo_suffix, hi_suffix, fmt, ##__VA_ARGS__)
+
+/**
+ * TST_SYSFS_ASSERT_LT_SUFFIX_SILENT() - Asserts that val1 < val2.
+ *
+ * Same as TST_SYSFS_ASSERT_LT_SUFFIX(), but silently skips the check if
+ * either file does not exist.
+ *
+ * @lo_suffix: A suffix appended to fmt to build the path to val1.
+ * @hi_suffix: A suffix appended to fmt to build the path to val2.
+ * @fmt: A printf-like format to build the common path prefix.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_LT_SUFFIX_SILENT(lo_suffix, hi_suffix, fmt, ...) \
+	tst_sysfs_assert_cmp_suffix_silent(__FILE__, __LINE__, \
+		TST_SYSFS_CMP_LT, lo_suffix, hi_suffix, fmt, ##__VA_ARGS__)
+
+/**
+ * TST_SYSFS_ASSERT_LE_SUFFIX_SILENT() - Asserts that val1 <= val2.
+ *
+ * Same as TST_SYSFS_ASSERT_LE_SUFFIX(), but silently skips the check if
+ * either file does not exist.
+ *
+ * @lo_suffix: A suffix appended to fmt to build the path to val1.
+ * @hi_suffix: A suffix appended to fmt to build the path to val2.
+ * @fmt: A printf-like format to build the common path prefix.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_ASSERT_LE_SUFFIX_SILENT(lo_suffix, hi_suffix, fmt, ...) \
+	tst_sysfs_assert_cmp_suffix_silent(__FILE__, __LINE__, \
+		TST_SYSFS_CMP_LE, lo_suffix, hi_suffix, fmt, ##__VA_ARGS__)
+
+/**
+ * tst_sysfs_exists() - Checks whether a file exists.
+ *
+ *
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like parameters for fmt.
+ * return: 1 if the file at the path built from fmt exists, 0 otherwise.
+ */
+int tst_sysfs_exists(const char *fmt, ...);
+
+/**
+ * TST_SYSFS_READ_STR() - Reads a string from a file.
+ *
+ * Reads a string from the file at the path built from fmt into buf, tolerating
+ * empty/whitespace-only files like SAFE_FILE_READ_STR() does, and stripping a
+ * trailing newline.
+ *
+ * Returns 1 and fills buf if the file exists, or 0 and leaves buf untouched
+ * if it does not (no TCONF or other message is printed either way).
+ *
+ * @buf: A buffer to read the string into.
+ * @buf_size: A size of the buf buffer.
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_READ_STR(buf, buf_size, fmt, ...) \
+	tst_sysfs_read_str(__FILE__, __LINE__, buf, buf_size, fmt, ##__VA_ARGS__)
+
+int tst_sysfs_read_str(const char *file, const int lineno, char *buf,
+	size_t buf_size, const char *fmt, ...);
+
+/**
+ * TST_SYSFS_EXP_EQ_LI() - Asserts that a file contains a given number.
+ *
+ * Reads a long value from the file at the path built from fmt and asserts that
+ * it equals val. Reports TPASS/TFAIL with the resolved path and both values,
+ * or TFAIL if the file does not exist or does not contain a number.
+ *
+ * This combines a numeric read and a TST_EXP_EQ_LI() style comparison in a
+ * single call, so tests do not have to build the path and read the value
+ * into a temporary variable themselves.
+ *
+ * @val: The expected long int value.
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_EXP_EQ_LI(val, fmt, ...) \
+	tst_sysfs_exp_eq_li(__FILE__, __LINE__, val, fmt, ##__VA_ARGS__)
+
+void tst_sysfs_exp_eq_li(const char *file, const int lineno, long val,
+	const char *fmt, ...);
+
+/**
+ * TST_SYSFS_EXP_EQ_STR() - Asserts that a file contains a given string.
+ *
+ * Reads a single whitespace-delimited string token from the file at the path
+ * built from fmt and asserts that it equals val. Reports TPASS/TFAIL with the
+ * resolved path and both values, or TCONF if the file does not exist.
+ *
+ * This combines a string read and a TST_EXP_EQ_STR() style comparison in a
+ * single call, so tests do not have to build the path and read the value
+ * into a temporary buffer themselves.
+ *
+ * @val: The expected string value.
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_EXP_EQ_STR(val, fmt, ...) \
+	tst_sysfs_exp_eq_str(__FILE__, __LINE__, val, fmt, ##__VA_ARGS__)
+
+void tst_sysfs_exp_eq_str(const char *file, const int lineno, const char *val,
+	const char *fmt, ...);
+
+/**
+ * TST_SYSFS_READ_LLI() - Reads a long long from a file.
+ *
+ * Reads a long long value from the file at the path built from fmt and
+ * returns it.
+ *
+ * Aborts with TBROK if the file does not exist or does not contain a valid
+ * number: unlike most of the other checks in this header, this is not
+ * expected to be an optional attribute the caller should gracefully skip,
+ * see SAFE_FILE_SCANF().
+ *
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_READ_LLI(fmt, ...) \
+	tst_sysfs_read_lli(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
+long long tst_sysfs_read_lli(const char *file, const int lineno,
+	const char *fmt, ...);
+
+/**
+ * TST_SYSFS_READ_LI() - Reads a long from a file.
+ *
+ * Reads a long value from the file at the path built from fmt and returns it.
+ *
+ * Aborts with TBROK if the file does not exist or does not contain a valid
+ * number: unlike most of the other checks in this header, this is not
+ * expected to be an optional attribute the caller should gracefully skip,
+ * see SAFE_FILE_SCANF().
+ *
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_READ_LI(fmt, ...) \
+	tst_sysfs_read_li(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
+long tst_sysfs_read_li(const char *file, const int lineno,
+	const char *fmt, ...);
+
+/**
+ * TST_SYSFS_READ_LX() - Reads a hexadecimal unsigned long from a file.
+ *
+ * Reads a long value from the file at the path built from fmt and returns it.
+ *
+ * Aborts with TBROK if the file does not exist or does not contain a valid
+ * number: unlike most of the other checks in this header, this is not
+ * expected to be an optional attribute the caller should gracefully skip,
+ * see SAFE_FILE_SCANF().
+ *
+ * @fmt: A printf-like format to build a path to the file.
+ * @...: A printf-like parameters for fmt.
+ */
+#define TST_SYSFS_READ_LX(fmt, ...) \
+	tst_sysfs_read_lx(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
+unsigned long tst_sysfs_read_lx(const char *file, const int lineno,
+	const char *fmt, ...);
+
+#endif /* TST_SYSFS_ASSERT_H__ */
diff --git a/lib/tst_sysfs_assert.c b/lib/tst_sysfs_assert.c
new file mode 100644
index 000000000..02acdee7a
--- /dev/null
+++ b/lib/tst_sysfs_assert.c
@@ -0,0 +1,797 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdarg.h>
+#include <string.h>
+#include <errno.h>
+#include <limits.h>
+#include <unistd.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+static void build_path(char *path, size_t size, const char *fmt, va_list ap)
+{
+	vsnprintf(path, size, fmt, ap);
+}
+
+static void build_suffix_paths(char *path1, char *path2, size_t size,
+			       const char *lo_suffix, const char *hi_suffix,
+			       const char *fmt, va_list ap)
+{
+	char prefix[PATH_MAX];
+
+	build_path(prefix, sizeof(prefix), fmt, ap);
+
+	snprintf(path1, size, "%s%s", prefix, lo_suffix);
+	snprintf(path2, size, "%s%s", prefix, hi_suffix);
+}
+
+static FILE *try_fopen(const char *file, const int lineno, const char *path)
+{
+	FILE *f = fopen(path, "r");
+
+	if (f)
+		return f;
+
+	if (errno == ENOENT)
+		tst_res_(file, lineno, TCONF, "%s does not exist", path);
+	else
+		tst_res_(file, lineno, TBROK | TERRNO, "Failed to open %s", path);
+
+	return NULL;
+}
+
+static void range_check(const char *file, const int lineno,
+			const char *path, long min, long max)
+{
+	long val;
+
+	if (access(path, F_OK)) {
+		tst_res_(file, lineno, TCONF, "%s does not exist", path);
+		return;
+	}
+
+	if (file_scanf(file, lineno, path, "%ld", &val)) {
+		tst_res_(file, lineno, TFAIL, "%s does not contain a number", path);
+		return;
+	}
+
+	if (val < min || val > max) {
+		tst_res_(file, lineno, TFAIL,
+			 "%s = %ld out of range [%ld, %ld]", path, val, min, max);
+		return;
+	}
+
+	tst_res_(file, lineno, TPASS,
+		 "%s = %ld in range [%ld, %ld]", path, val, min, max);
+}
+
+void tst_sysfs_assert_rangell(const char *file, const int lineno,
+			      long min, long max, const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	range_check(file, lineno, path, min, max);
+}
+
+void tst_sysfs_assert_rangell_silent(const char *file, const int lineno,
+				     long min, long max, const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	if (access(path, F_OK))
+		return;
+
+	range_check(file, lineno, path, min, max);
+}
+
+static void range_check_f(const char *file, const int lineno, long min,
+			  const char *val_path, const char *max_path)
+{
+	long max;
+
+	if (access(max_path, F_OK)) {
+		tst_res_(file, lineno, TCONF, "%s does not exist", max_path);
+		return;
+	}
+
+	if (file_scanf(file, lineno, max_path, "%ld", &max)) {
+		tst_res_(file, lineno, TFAIL, "%s does not contain a number",
+			 max_path);
+		return;
+	}
+
+	range_check(file, lineno, val_path, min, max);
+}
+
+void tst_sysfs_assert_rangelf(const char *file, const int lineno,
+			      long min, const char *val_suffix,
+			      const char *max_suffix,
+			      const char *fmt, ...)
+{
+	char val_path[PATH_MAX], max_path[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_suffix_paths(val_path, max_path, sizeof(val_path), val_suffix,
+			   max_suffix, fmt, ap);
+	va_end(ap);
+
+	range_check_f(file, lineno, min, val_path, max_path);
+}
+
+static void bool_check(const char *file, const int lineno, const char *path)
+{
+	long val;
+
+	if (access(path, F_OK)) {
+		tst_res_(file, lineno, TCONF, "%s does not exist", path);
+		return;
+	}
+
+	if (file_scanf(file, lineno, path, "%ld", &val)) {
+		tst_res_(file, lineno, TFAIL, "%s does not contain a number", path);
+		return;
+	}
+
+	if (val != 0 && val != 1) {
+		tst_res_(file, lineno, TFAIL, "%s = %ld is not boolean", path, val);
+		return;
+	}
+
+	tst_res_(file, lineno, TPASS, "%s = %ld is boolean", path, val);
+}
+
+void tst_sysfs_assert_bool(const char *file, const int lineno,
+			   const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	bool_check(file, lineno, path);
+}
+
+void tst_sysfs_assert_bool_silent(const char *file, const int lineno,
+				  const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	if (access(path, F_OK))
+		return;
+
+	bool_check(file, lineno, path);
+}
+
+static void pow2_check(const char *file, const int lineno, const char *path)
+{
+	long val;
+
+	if (access(path, F_OK)) {
+		tst_res_(file, lineno, TCONF, "%s does not exist", path);
+		return;
+	}
+
+	if (file_scanf(file, lineno, path, "%ld", &val)) {
+		tst_res_(file, lineno, TFAIL, "%s does not contain a number", path);
+		return;
+	}
+
+	if (val <= 0 || (val & (val - 1))) {
+		tst_res_(file, lineno, TFAIL,
+			 "%s = %ld is not a power of two", path, val);
+		return;
+	}
+
+	tst_res_(file, lineno, TPASS, "%s = %ld is a power of two", path, val);
+}
+
+void tst_sysfs_assert_pow2(const char *file, const int lineno,
+			   const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	pow2_check(file, lineno, path);
+}
+
+static int is_allowed(const char *const allowed[], const char *val)
+{
+	const char *const *a;
+
+	for (a = allowed; *a; a++) {
+		if (!strcmp(*a, val))
+			return 1;
+	}
+
+	return 0;
+}
+
+static void tokens_check(const char *file, const int lineno,
+			 const char *path, const char *const allowed[],
+			 char *sel, size_t sel_size, int sel_expected,
+			 const char *find)
+{
+	FILE *f;
+	char *tok = NULL;
+	size_t tok_size = 0;
+	ssize_t len;
+	int nselected = 0;
+	int ntokens = 0;
+	int bad = 0;
+	int found = 0;
+
+	f = try_fopen(file, lineno, path);
+	if (!f)
+		return;
+
+	while ((len = getdelim(&tok, &tok_size, ' ', f)) != -1) {
+		int selected = 0;
+		const char *name = tok;
+
+		/* Strip the trailing ' ' or '\n' left by getdelim(). */
+		while (len > 0 && (tok[len - 1] == ' ' || tok[len - 1] == '\n'))
+			tok[--len] = '\0';
+
+		/* Skip empty tokens, e.g. from runs of consecutive spaces. */
+		if (len == 0)
+			continue;
+
+		if (sel_expected && len >= 2 && tok[0] == '[' && tok[len - 1] == ']') {
+			selected = 1;
+			tok[len - 1] = '\0';
+			name = tok + 1;
+		}
+
+		ntokens++;
+
+		if (selected) {
+			nselected++;
+			if (sel && sel_size) {
+				strncpy(sel, name, sel_size - 1);
+				sel[sel_size - 1] = '\0';
+			}
+		}
+
+		if (find && !strcmp(find, name))
+			found = 1;
+
+		if (allowed && !is_allowed(allowed, name)) {
+			tst_res_(file, lineno, TFAIL,
+				 "%s contains unexpected token '%s'",
+				 path, name);
+			bad = 1;
+		}
+	}
+
+	fclose(f);
+
+	if (!ntokens) {
+		tst_res_(file, lineno, TFAIL, "%s is empty", path);
+		goto out;
+	}
+
+	if (sel_expected && nselected != 1) {
+		tst_res_(file, lineno, TFAIL,
+			 "%s has %d selected tokens, expected exactly 1",
+			 path, nselected);
+		goto out;
+	}
+
+	if (bad)
+		goto out;
+
+	if (find && !found) {
+		tst_res_(file, lineno, TFAIL,
+			 "%s does not contain token '%s'", path, find);
+		goto out;
+	}
+
+	if (sel_expected) {
+		tst_res_(file, lineno, TPASS,
+			 "%s has valid choices with single selected", path);
+	} else if (find) {
+		tst_res_(file, lineno, TPASS,
+			 "%s contains token '%s'", path, find);
+	} else {
+		tst_res_(file, lineno, TPASS,
+			 "%s lists only known tokens", path);
+	}
+out:
+	free(tok);
+}
+
+void tst_sysfs_assert_choice(const char *file, const int lineno,
+			     const char *const allowed[], char *sel,
+			     size_t sel_size, const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	tokens_check(file, lineno, path, allowed, sel, sel_size, 1, NULL);
+}
+
+void tst_sysfs_assert_tokens(const char *file, const int lineno,
+			     const char *const allowed[], const char *find,
+			     const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	tokens_check(file, lineno, path, allowed, NULL, 0, 0, find);
+}
+
+void tst_sysfs_assert_oneof(const char *file, const int lineno,
+			    const char *const allowed[], const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	char val[256];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	if (access(path, F_OK)) {
+		tst_res_(file, lineno, TCONF, "%s does not exist", path);
+		return;
+	}
+
+	if (file_scanf(file, lineno, path, "%255s", val)) {
+		tst_res_(file, lineno, TFAIL, "Failed to read %s", path);
+		return;
+	}
+
+	if (is_allowed(allowed, val))
+		tst_res_(file, lineno, TPASS, "%s = '%s' is valid", path, val);
+	else
+		tst_res_(file, lineno, TFAIL,
+			 "%s = '%s' is not an expected value", path, val);
+}
+
+static int parse_range_token(char *tok, int *a, int *b)
+{
+	char *dash;
+	int ret = 0;
+
+	dash = strchr(tok, '-');
+	if (!dash) {
+		if (tst_parse_int(tok, a, 0, INT_MAX))
+			return -1;
+
+		*b = *a;
+		return 0;
+	}
+
+	*dash = '\0';
+
+	if (tst_parse_int(tok, a, 0, INT_MAX) ||
+	    tst_parse_int(dash + 1, b, *a, INT_MAX)) {
+		ret = -1;
+	}
+
+	*dash = '-';
+
+	return ret;
+}
+
+static int parse_list(const char *file, const int lineno, const char *path,
+		      unsigned char *map, int *count, int *max_id)
+{
+	FILE *f;
+	char *tok = NULL;
+	size_t tok_size = 0;
+	ssize_t len;
+	int total = 0;
+	int maxid = -1;
+
+	f = try_fopen(file, lineno, path);
+	if (!f)
+		return -1;
+
+	while ((len = getdelim(&tok, &tok_size, ',', f)) != -1) {
+		int a, b, i;
+
+		/* Strip the trailing ',' or '\n' left by getdelim(). */
+		while (len > 0 && (tok[len - 1] == ',' || tok[len - 1] == '\n'))
+			tok[--len] = '\0';
+
+		/*
+		 * Skip empty tokens, e.g. a lone trailing newline on an
+		 * otherwise empty file (all CPUs online -> empty offline
+		 * cpulist).
+		 */
+		if (len == 0)
+			continue;
+
+		if (parse_range_token(tok, &a, &b)) {
+			tst_res_(file, lineno, TFAIL,
+				 "%s: invalid list token '%s'", path, tok);
+			free(tok);
+			fclose(f);
+			return -1;
+		}
+
+		for (i = a; i <= b; i++) {
+			total++;
+			if (i > maxid)
+				maxid = i;
+			if (map)
+				map[i / 8] |= 1 << (i % 8);
+		}
+	}
+
+	free(tok);
+	fclose(f);
+
+	if (count)
+		*count = total;
+	if (max_id)
+		*max_id = maxid;
+
+	return 0;
+}
+
+int tst_sysfs_assert_parse_list(const char *file, const int lineno,
+				int *count, int *max_id, const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	return parse_list(file, lineno, path, NULL, count, max_id);
+}
+
+static unsigned char *read_list_map(const char *file, const int lineno,
+				    const char *path, int *map_bytes)
+{
+	unsigned char *map;
+	int max_id, bytes;
+
+	/* First pass: only to find the highest id so we can size the bitmap. */
+	if (parse_list(file, lineno, path, NULL, NULL, &max_id))
+		return NULL;
+
+	bytes = max_id < 0 ? 1 : max_id / 8 + 1;
+	map = SAFE_MALLOC(bytes);
+	memset(map, 0, bytes);
+
+	/* Second pass: fill the bitmap. */
+	if (parse_list(file, lineno, path, map, NULL, NULL)) {
+		free(map);
+		return NULL;
+	}
+
+	*map_bytes = bytes;
+	return map;
+}
+
+void tst_sysfs_assert_list_subset(const char *file, const int lineno,
+				  const char *sub_path,
+				  const char *super_path)
+{
+	unsigned char *sub = NULL, *super = NULL;
+	int sub_bytes, super_bytes, i;
+
+	sub = read_list_map(file, lineno, sub_path, &sub_bytes);
+	if (!sub)
+		return;
+
+	super = read_list_map(file, lineno, super_path, &super_bytes);
+	if (!super) {
+		free(sub);
+		return;
+	}
+
+	for (i = 0; i < sub_bytes; i++) {
+		unsigned char super_byte = i < super_bytes ? super[i] : 0;
+
+		if (sub[i] & ~super_byte) {
+			tst_res_(file, lineno, TFAIL,
+				 "%s is not a subset of %s",
+				 sub_path, super_path);
+			free(sub);
+			free(super);
+			return;
+		}
+	}
+
+	free(sub);
+	free(super);
+
+	tst_res_(file, lineno, TPASS,
+		 "%s is a subset of %s", sub_path, super_path);
+}
+
+void tst_sysfs_assert_list_contains(const char *file, const int lineno,
+				    int id, const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	unsigned char *map;
+	int map_bytes;
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	map = read_list_map(file, lineno, path, &map_bytes);
+	if (!map)
+		return;
+
+	if (id >= 0 && id / 8 < map_bytes && (map[id / 8] & (1 << (id % 8)))) {
+		tst_res_(file, lineno, TPASS, "%s contains %d", path, id);
+	} else {
+		tst_res_(file, lineno, TFAIL, "%s does not contain %d", path,
+			 id);
+	}
+
+	free(map);
+}
+
+void tst_sysfs_assert_cmp(const char *file, const int lineno,
+			  const char *path1, enum tst_sysfs_cmp op,
+			  const char *path2)
+{
+	long val1, val2;
+	int res;
+	const char *opstr;
+
+	if (access(path1, F_OK)) {
+		tst_res_(file, lineno, TCONF, "%s does not exist", path1);
+		return;
+	}
+
+	if (access(path2, F_OK)) {
+		tst_res_(file, lineno, TCONF, "%s does not exist", path2);
+		return;
+	}
+
+	if (file_scanf(file, lineno, path1, "%ld", &val1)) {
+		tst_res_(file, lineno, TFAIL, "%s does not contain a number", path1);
+		return;
+	}
+
+	if (file_scanf(file, lineno, path2, "%ld", &val2)) {
+		tst_res_(file, lineno, TFAIL, "%s does not contain a number", path2);
+		return;
+	}
+
+	switch (op) {
+	case TST_SYSFS_CMP_EQ:
+		res = val1 == val2;
+		opstr = "==";
+		break;
+	case TST_SYSFS_CMP_LT:
+		res = val1 < val2;
+		opstr = "<";
+		break;
+	case TST_SYSFS_CMP_LE:
+		res = val1 <= val2;
+		opstr = "<=";
+		break;
+	default:
+		tst_res_(file, lineno, TBROK, "Invalid comparison operator %d", op);
+		return;
+	}
+
+	tst_res_(file, lineno, res ? TPASS : TFAIL,
+		 "%s (%ld) %s %s (%ld)",
+		 path1, val1, opstr, path2, val2);
+}
+
+void tst_sysfs_assert_cmp_silent(const char *file, const int lineno,
+				 const char *path1, enum tst_sysfs_cmp op,
+				 const char *path2)
+{
+	if (access(path1, F_OK) || access(path2, F_OK))
+		return;
+
+	tst_sysfs_assert_cmp(file, lineno, path1, op, path2);
+}
+
+void tst_sysfs_assert_cmp_suffix(const char *file, const int lineno,
+				 enum tst_sysfs_cmp op, const char *lo_suffix,
+				 const char *hi_suffix, const char *fmt, ...)
+{
+	char path1[PATH_MAX], path2[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_suffix_paths(path1, path2, sizeof(path1), lo_suffix, hi_suffix,
+			   fmt, ap);
+	va_end(ap);
+
+	tst_sysfs_assert_cmp(file, lineno, path1, op, path2);
+}
+
+void tst_sysfs_assert_cmp_suffix_silent(const char *file, const int lineno,
+					enum tst_sysfs_cmp op,
+					const char *lo_suffix,
+					const char *hi_suffix,
+					const char *fmt, ...)
+{
+	char path1[PATH_MAX], path2[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_suffix_paths(path1, path2, sizeof(path1), lo_suffix, hi_suffix,
+			   fmt, ap);
+	va_end(ap);
+
+	tst_sysfs_assert_cmp_silent(file, lineno, path1, op, path2);
+}
+
+int tst_sysfs_exists(const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	return !access(path, F_OK);
+}
+
+int tst_sysfs_read_str(const char *file, const int lineno, char *buf,
+		       size_t buf_size, const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	if (access(path, F_OK))
+		return 0;
+
+	safe_file_read_str(file, lineno, path, buf, buf_size);
+	buf[strcspn(buf, "\n")] = '\0';
+
+	return 1;
+}
+
+void tst_sysfs_exp_eq_li(const char *file, const int lineno, long val,
+			 const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	va_list ap;
+	long read_val;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	if (access(path, F_OK)) {
+		tst_res_(file, lineno, TCONF, "%s does not exist", path);
+		return;
+	}
+
+	if (file_scanf(file, lineno, path, "%ld", &read_val)) {
+		tst_res_(file, lineno, TFAIL, "%s does not contain a number", path);
+		return;
+	}
+
+	tst_res_(file, lineno, read_val == val ? TPASS : TFAIL,
+		 "%s (%ld) == %ld", path, read_val, val);
+}
+
+void tst_sysfs_exp_eq_str(const char *file, const int lineno, const char *val,
+			  const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	char read_val[256];
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	if (access(path, F_OK)) {
+		tst_res_(file, lineno, TCONF, "%s does not exist", path);
+		return;
+	}
+
+	if (file_scanf(file, lineno, path, "%255s", read_val)) {
+		tst_res_(file, lineno, TFAIL, "Failed to read %s", path);
+		return;
+	}
+
+	tst_res_(file, lineno, !strcmp(read_val, val) ? TPASS : TFAIL,
+		 "%s ('%s') == '%s'", path, read_val, val);
+}
+
+long long tst_sysfs_read_lli(const char *file, const int lineno,
+			     const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	long long val;
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	safe_file_scanf(file, lineno, NULL, path, "%lld", &val);
+
+	tst_res(TDEBUG, "Read '%s' = %lli", path, val);
+
+	return val;
+}
+
+long tst_sysfs_read_li(const char *file, const int lineno,
+		       const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	long val;
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	safe_file_scanf(file, lineno, NULL, path, "%ld", &val);
+
+	tst_res(TDEBUG, "Read '%s' = %li", path, val);
+
+	return val;
+}
+
+unsigned long tst_sysfs_read_lx(const char *file, const int lineno,
+				const char *fmt, ...)
+{
+	char path[PATH_MAX];
+	unsigned long val;
+	va_list ap;
+
+	va_start(ap, fmt);
+	build_path(path, sizeof(path), fmt, ap);
+	va_end(ap);
+
+	safe_file_scanf(file, lineno, NULL, path, "%lx", &val);
+
+	tst_res(TDEBUG, "Read '%s' = 0x%lx", path, val);
+
+	return val;
+}
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
