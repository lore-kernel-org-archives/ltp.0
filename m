Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F95C54734
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 12:05:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6F513D2752
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 14:05:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65B5A3D2722
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 14:03:59 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4DA60608A78
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 14:03:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8054321B0F;
 Tue, 27 Aug 2024 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724760236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMsreHR7Aya6FBuwsDht7DjoG0XJbOSU9r6FZb/Hb8Y=;
 b=RTErRGj4vW1eiRtVdLrpn1hg2F79t2dIWCG+LPD9pV65sMFF5Or5OcOIRETwzGGEndGt1U
 Rf3VhiO0oO9VjQz0D6kLzo0/uu0VBSqlUyqfUui9IvUSMImZjGuGBb5E6KSyF3B6NOed8H
 gG5M8ly6ZwpSpIn2aYSV95bPgD4GgiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724760236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMsreHR7Aya6FBuwsDht7DjoG0XJbOSU9r6FZb/Hb8Y=;
 b=oXA9VwAA4QWcHe8lbqCAGqeJh1XbzL0buOJ3R9/FDoY7mx2f6Dn7ThMXdtnbqVsDGGiTZj
 O5umJM1NUxPySLDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FYc5LL1d;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7SUgNE83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724760235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMsreHR7Aya6FBuwsDht7DjoG0XJbOSU9r6FZb/Hb8Y=;
 b=FYc5LL1dEG44vomeywXCH+eRirZKRMDMac83pyivs68kx+GdmR0Aq4C+kILuJNkLRkket4
 kzzugshZud5ZTRsp48wwkNDX8DoCn2am7dg1Aeb/nH1m/Y1DL3/Ng0Ot3BhygrCf7CVgiY
 OVTebKP5zqw5mEueEgIfiPdXtamk7HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724760235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMsreHR7Aya6FBuwsDht7DjoG0XJbOSU9r6FZb/Hb8Y=;
 b=7SUgNE833DVffs4ozTfKMU/l3ekFvH0m1NqimrU7h/AzIrLVALY853Hxzl2bVPKgj6lume
 yHWU8ritg0mVFoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59AB613A94;
 Tue, 27 Aug 2024 12:03:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PgPxFKvAzWYbWgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 27 Aug 2024 12:03:55 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 27 Aug 2024 14:02:36 +0200
Message-ID: <20240827120237.25805-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120237.25805-1-chrubis@suse.cz>
References: <20240827120237.25805-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8054321B0F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,richiejp.com:email,ucw.cz:email];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] libs: Vendor ujson library
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

See: https://github.com/metan-ucw/ujson

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Richard Palethorpe <io@richiejp.com>
---
 include/ujson.h           |   13 +
 include/ujson_common.h    |   69 +++
 include/ujson_reader.h    |  543 +++++++++++++++++++
 include/ujson_utf.h       |  168 ++++++
 include/ujson_writer.h    |  224 ++++++++
 libs/ujson/Makefile       |   12 +
 libs/ujson/ujson_common.c |   38 ++
 libs/ujson/ujson_reader.c | 1081 +++++++++++++++++++++++++++++++++++++
 libs/ujson/ujson_utf.c    |  105 ++++
 libs/ujson/ujson_writer.c |  491 +++++++++++++++++
 10 files changed, 2744 insertions(+)
 create mode 100644 include/ujson.h
 create mode 100644 include/ujson_common.h
 create mode 100644 include/ujson_reader.h
 create mode 100644 include/ujson_utf.h
 create mode 100644 include/ujson_writer.h
 create mode 100644 libs/ujson/Makefile
 create mode 100644 libs/ujson/ujson_common.c
 create mode 100644 libs/ujson/ujson_reader.c
 create mode 100644 libs/ujson/ujson_utf.c
 create mode 100644 libs/ujson/ujson_writer.c

diff --git a/include/ujson.h b/include/ujson.h
new file mode 100644
index 000000000..8faeb18f0
--- /dev/null
+++ b/include/ujson.h
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2021-2024 Cyril Hrubis <metan@ucw.cz>
+ */
+
+#ifndef UJSON_H
+#define UJSON_H
+
+#include <ujson_common.h>
+#include <ujson_reader.h>
+#include <ujson_writer.h>
+
+#endif /* UJSON_H */
diff --git a/include/ujson_common.h b/include/ujson_common.h
new file mode 100644
index 000000000..ed31c090d
--- /dev/null
+++ b/include/ujson_common.h
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2021-2024 Cyril Hrubis <metan@ucw.cz>
+ */
+
+/**
+ * @file ujson_common.h
+ * @brief Common JSON reader/writer definitions.
+ */
+
+#ifndef UJSON_COMMON_H
+#define UJSON_COMMON_H
+
+/** @brief Maximal error message length. */
+#define UJSON_ERR_MAX 128
+/** @brief Maximal id string lenght including terminating null element. */
+#define UJSON_ID_MAX 64
+/** @brief Maximal recursion depth allowed. */
+#define UJSON_RECURSION_MAX 128
+
+#define UJSON_ERR_PRINT ujson_err_handler
+#define UJSON_ERR_PRINT_PRIV stderr
+
+/**
+ * @brief A JSON data type.
+ */
+enum ujson_type {
+	/** @brief No type. Returned when parser finishes. */
+	UJSON_VOID = 0,
+	/** @brief An integer. */
+	UJSON_INT,
+	/** @brief A floating point. */
+	UJSON_FLOAT,
+	/** @brief A boolean. */
+	UJSON_BOOL,
+	/** @brief NULL */
+	UJSON_NULL,
+	/** @brief A string. */
+	UJSON_STR,
+	/** @brief A JSON object. */
+	UJSON_OBJ,
+	/** @brief A JSON array. */
+	UJSON_ARR,
+};
+
+/**
+ * @brief Returns type name.
+ *
+ * @param type A json type.
+ * @return A type name.
+ */
+const char *ujson_type_name(enum ujson_type type);
+
+/**
+ * @brief Default error print handler.
+ *
+ * @param print_priv A json buffer print_priv pointer.
+ * @param line A line of text to be printed.
+ */
+void ujson_err_handler(void *print_priv, const char *line);
+
+typedef struct ujson_reader ujson_reader;
+typedef struct ujson_writer ujson_writer;
+typedef struct ujson_val ujson_val;
+
+/** @brief An array size macro. */
+#define UJSON_ARRAY_SIZE(array) (sizeof(array) / sizeof(*array))
+
+#endif /* UJSON_COMMON_H */
diff --git a/include/ujson_reader.h b/include/ujson_reader.h
new file mode 100644
index 000000000..273fe624a
--- /dev/null
+++ b/include/ujson_reader.h
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2021-2024 Cyril Hrubis <metan@ucw.cz>
+ */
+
+/**
+ * @file ujson_reader.h
+ * @brief A recursive descend JSON parser.
+ *
+ * All the function that parse JSON return zero on success and non-zero on a
+ * failure. Once an error has happened all subsequent attempts to parse more
+ * return with non-zero exit status immediatelly. This is designed so that we
+ * can parse several values without checking each return value and only check
+ * if error has happened at the end of the sequence.
+ */
+
+#ifndef UJSON_READER_H
+#define UJSON_READER_H
+
+#include <stdio.h>
+#include <ujson_common.h>
+
+/**
+ * @brief An ujson_reader initializer with default values.
+ *
+ * @param buf A pointer to a buffer with JSON data.
+ * @param buf_len A JSON data buffer lenght.
+ * @param rflags enum ujson_reader_flags.
+ *
+ * @return An ujson_reader initialized with default values.
+ */
+#define UJSON_READER_INIT(buf, buf_len, rflags) { \
+	.max_depth = UJSON_RECURSION_MAX, \
+	.err_print = UJSON_ERR_PRINT, \
+	.err_print_priv = UJSON_ERR_PRINT_PRIV, \
+	.json = buf, \
+	.len = buf_len, \
+	.flags = rflags \
+}
+
+/** @brief Reader flags. */
+enum ujson_reader_flags {
+	/** @brief If set warnings are treated as errors. */
+	UJSON_READER_STRICT = 0x01,
+};
+
+/**
+ * @brief A JSON parser internal state.
+ */
+struct ujson_reader {
+	/** Pointer to a null terminated JSON string */
+	const char *json;
+	/** A length of the JSON string */
+	size_t len;
+	/** A current offset into the JSON string */
+	size_t off;
+	/** An offset to the start of the last array or object */
+	size_t sub_off;
+	/** Recursion depth increased when array/object is entered decreased on leave */
+	unsigned int depth;
+	/** Maximal recursion depth */
+	unsigned int max_depth;
+
+	/** Reader flags. */
+	enum ujson_reader_flags flags;
+
+	/** Handler to print errors and warnings */
+	void (*err_print)(void *err_print_priv, const char *line);
+	void *err_print_priv;
+
+	char err[UJSON_ERR_MAX];
+	char buf[];
+};
+
+/**
+ * @brief An ujson_val initializer.
+ *
+ * @param sbuf A pointer to a buffer used for string values.
+ * @param sbuf_size A length of the buffer used for string values.
+ *
+ * @return An ujson_val initialized with default values.
+ */
+#define UJSON_VAL_INIT(sbuf, sbuf_size) { \
+	.buf = sbuf, \
+	.buf_size = sbuf_size, \
+}
+
+/**
+ * @brief A parsed JSON key value pair.
+ */
+struct ujson_val {
+	/**
+	 * @brief A value type
+	 *
+	 * UJSON_VALUE_VOID means that no value was parsed.
+	 */
+	enum ujson_type type;
+
+	/** An user supplied buffer and size to store a string values to. */
+	char *buf;
+	size_t buf_size;
+
+	/**
+	 * @brief An index to attribute list.
+	 *
+	 * This is set by the ujson_obj_first_filter() and
+	 * ujson_obj_next_filter() functions.
+	 */
+	size_t idx;
+
+	/** An union to store the parsed value into. */
+	union {
+		/** @brief A boolean value. */
+		int val_bool;
+		/** @brief An integer value. */
+		long long val_int;
+		/** @brief A string value. */
+		const char *val_str;
+	};
+
+	/**
+	 * @brief A floating point value.
+	 *
+	 * Since integer values are subset of floating point values val_float
+	 * is always set when val_int was set.
+	 */
+	double val_float;
+
+	/** @brief An ID for object values */
+	char id[UJSON_ID_MAX];
+
+	char buf__[];
+};
+
+/**
+ * @brief Allocates a JSON value.
+ *
+ * @param buf_size A maximal buffer size for a string value, pass 0 for default.
+ * @return A newly allocated JSON value.
+ */
+ujson_val *ujson_val_alloc(size_t buf_size);
+
+/**
+ * @brief Frees a JSON value.
+ *
+ * @param self A JSON value previously allocated by ujson_val_alloc().
+ */
+void ujson_val_free(ujson_val *self);
+
+/**
+ * @brief Checks is result has valid type.
+ *
+ * @param res An ujson value.
+ * @return Zero if result is not valid, non-zero otherwise.
+ */
+static inline int ujson_val_valid(struct ujson_val *res)
+{
+	return !!res->type;
+}
+
+/**
+ * @brief Fills the reader error.
+ *
+ * Once buffer error is set all parsing functions return immediatelly with type
+ * set to UJSON_VOID.
+ *
+ * @param self An ujson_reader
+ * @param fmt A printf like format string
+ * @param ... A printf like parameters
+ */
+void ujson_err(ujson_reader *self, const char *fmt, ...)
+               __attribute__((format(printf, 2, 3)));
+
+/**
+ * @brief Prints error stored in the buffer.
+ *
+ * The error takes into consideration the current offset in the buffer and
+ * prints a few preceding lines along with the exact position of the error.
+ *
+ * The error is passed to the err_print() handler.
+ *
+ * @param self A ujson_reader
+ */
+void ujson_err_print(ujson_reader *self);
+
+/**
+ * @brief Prints a warning.
+ *
+ * Uses the print handler in the buffer to print a warning along with a few
+ * lines of context from the JSON at the current position.
+ *
+ * @param self A ujson_reader
+ * @param fmt A printf-like error string.
+ * @param ... A printf-like parameters.
+ */
+void ujson_warn(ujson_reader *self, const char *fmt, ...)
+               __attribute__((format(printf, 2, 3)));
+
+/**
+ * @brief Returns true if error was encountered.
+ *
+ * @param self A ujson_reader
+ * @return True if error was encountered false otherwise.
+ */
+static inline int ujson_reader_err(ujson_reader *self)
+{
+	return !!self->err[0];
+}
+
+/**
+ * @brief Returns the type of next element in buffer.
+ *
+ * @param self An ujson_reader
+ * @return A type of next element in the buffer.
+ */
+enum ujson_type ujson_next_type(ujson_reader *self);
+
+/**
+ * @brief Returns if first element in JSON is object or array.
+ *
+ * @param self A ujson_reader
+ * @return On success returns UJSON_OBJ or UJSON_ARR. On failure UJSON_VOID.
+ */
+enum ujson_type ujson_reader_start(ujson_reader *self);
+
+/**
+ * @brief Starts parsing of a JSON object.
+ *
+ * @param self An ujson_reader
+ * @param res An ujson_val to store the parsed value to.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_obj_first(ujson_reader *self, struct ujson_val *res);
+
+/**
+ * @brief Parses next value from a JSON object.
+ *
+ * If the res->type is UJSON_OBJ or UJSON_ARR it has to be parsed or skipped
+ * before next call to this function.
+ *
+ * @param self An ujson_reader.
+ * @param res A ujson_val to store the parsed value to.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_obj_next(ujson_reader *self, struct ujson_val *res);
+
+/**
+ * @brief A loop over a JSON object.
+ *
+ * @code
+ * UJSON_OBJ_FOREACH(reader, val) {
+ *	printf("Got value id '%s' type '%s'", val->id, ujson_type_name(val->type));
+ *	...
+ * }
+ * @endcode
+ *
+ * @param self An ujson_reader.
+ * @param res An ujson_val to store the next parsed value to.
+ */
+#define UJSON_OBJ_FOREACH(self, res) \
+	for (ujson_obj_first(self, res); ujson_val_valid(res); ujson_obj_next(self, res))
+
+/**
+ * @brief Utility function for log(n) lookup in a sorted array.
+ *
+ * @param list Analphabetically sorted array.
+ * @param list_len Array length.
+ *
+ * @return An array index or (size_t)-1 if key wasn't found.
+ */
+size_t ujson_lookup(const void *arr, size_t memb_size, size_t list_len,
+                    const char *key);
+
+/**
+ * @brief A JSON object attribute description i.e. key and type.
+ */
+typedef struct ujson_obj_attr {
+	/** @brief A JSON object key name. */
+	const char *key;
+	/**
+	 * @brief A JSON object value type.
+	 *
+	 * Note that because integer numbers are subset of floating point
+         * numbers if requested type was UJSON_FLOAT it will match if parsed
+         * type was UJSON_INT and the val_float will be set in addition to
+         * val_int.
+         */
+	enum ujson_type type;
+} ujson_obj_attr;
+
+/** @brief A JSON object description */
+typedef struct ujson_obj {
+	/**
+	 * @brief A list of attributes.
+	 *
+	 * Attributes we are looking for, the parser sets the val->idx for these.
+	 */
+	const ujson_obj_attr *attrs;
+	/** @brief A size of attrs array. */
+	size_t attr_cnt;
+} ujson_obj;
+
+static inline size_t ujson_obj_lookup(const ujson_obj *obj, const char *key)
+{
+	return ujson_lookup(obj->attrs, sizeof(*obj->attrs), obj->attr_cnt, key);
+}
+
+/** @brief An ujson_obj_attr initializer. */
+#define UJSON_OBJ_ATTR(keyv, typev) \
+	{.key = keyv, .type = typev}
+
+/** @brief An ujson_obj_attr intializer with an array index. */
+#define UJSON_OBJ_ATTR_IDX(key_idx, keyv, typev) \
+	[key_idx] = {.key = keyv, .type = typev}
+
+/**
+ * @brief Starts parsing of a JSON object with attribute lists.
+ *
+ * @param self An ujson_reader.
+ * @param res An ujson_val to store the parsed value to.
+ * @param obj An ujson_obj object description.
+ * @param ign A list of keys to ignore.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_obj_first_filter(ujson_reader *self, struct ujson_val *res,
+                           const struct ujson_obj *obj, const struct ujson_obj *ign);
+
+/**
+ * @brief An empty object attribute list.
+ *
+ * To be passed to UJSON_OBJ_FOREACH_FITLER() as ignore list.
+ */
+extern const struct ujson_obj *ujson_empty_obj;
+
+/**
+ * @brief Parses next value from a JSON object with attribute lists.
+ *
+ * If the res->type is UJSON_OBJ or UJSON_ARR it has to be parsed or skipped
+ * before next call to this function.
+ *
+ * @param self An ujson_reader.
+ * @param res An ujson_val to store the parsed value to.
+ * @param obj An ujson_obj object description.
+ * @param ign A list of keys to ignore. If set to NULL all unknown keys are
+ *            ignored, if set to ujson_empty_obj all unknown keys produce warnings.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_obj_next_filter(ujson_reader *self, struct ujson_val *res,
+                          const struct ujson_obj *obj, const struct ujson_obj *ign);
+
+/**
+ * @brief A loop over a JSON object with a pre-defined list of expected attributes.
+ *
+ * @code
+ * static struct ujson_obj_attr attrs[] = {
+ *	UJSON_OBJ_ATTR("bool", UJSON_BOOL),
+ *	UJSON_OBJ_ATTR("number", UJSON_INT),
+ * };
+ *
+ * static struct ujson_obj obj = {
+ *	.attrs = filter_attrs,
+ *	.attr_cnt = UJSON_ARRAY_SIZE(filter_attrs)
+ * };
+ *
+ * UJSON_OBJ_FOREACH_FILTER(reader, val, &obj, NULL) {
+ *	printf("Got value id '%s' type '%s'",
+ *	       attrs[val->idx].id, ujson_type_name(val->type));
+ *	...
+ * }
+ * @endcode
+ *
+ * @param self An ujson_reader.
+ * @param res An ujson_val to store the next parsed value to.
+ * @param obj An ujson_obj with a description of attributes to parse.
+ * @param ign An ujson_obj with a description of attributes to ignore.
+ */
+#define UJSON_OBJ_FOREACH_FILTER(self, res, obj, ign) \
+	for (ujson_obj_first_filter(self, res, obj, ign); \
+	     ujson_val_valid(res); \
+	     ujson_obj_next_filter(self, res, obj, ign))
+
+/**
+ * @brief Skips parsing of a JSON object.
+ *
+ * @param self An ujson_reader.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_obj_skip(ujson_reader *self);
+
+/**
+ * @brief Starts parsing of a JSON array.
+ *
+ * @param self An ujson_reader.
+ * @param res An ujson_val to store the parsed value to.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_arr_first(ujson_reader *self, struct ujson_val *res);
+
+/**
+ * @brief Parses next value from a JSON array.
+ *
+ * If the res->type is UJSON_OBJ or UJSON_ARR it has to be parsed or skipped
+ * before next call to this function.
+ *
+ * @param self An ujson_reader.
+ * @param res An ujson_val to store the parsed value to.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_arr_next(ujson_reader *self, struct ujson_val *res);
+
+/**
+ * @brief A loop over a JSON array.
+ *
+ * @code
+ * UJSON_ARR_FOREACH(reader, val) {
+ *	printf("Got value type '%s'", ujson_type_name(val->type));
+ *	...
+ * }
+ * @endcode
+ *
+ * @param self An ujson_reader.
+ * @param res An ujson_val to store the next parsed value to.
+ */
+#define UJSON_ARR_FOREACH(self, res) \
+	for (ujson_arr_first(self, res); ujson_val_valid(res); ujson_arr_next(self, res))
+
+/**
+ * @brief Skips parsing of a JSON array.
+ *
+ * @param self A ujson_reader.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_arr_skip(ujson_reader *self);
+
+/**
+ * @brief A JSON reader state.
+ */
+typedef struct ujson_reader_state {
+	size_t off;
+	unsigned int depth;
+} ujson_reader_state;
+
+/**
+ * @brief Returns a parser state at the start of current object/array.
+ *
+ * This function could be used for the parser to return to the start of the
+ * currently parsed object or array.
+ *
+ * @param self A ujson_reader
+ * @return A state that points to a start of the last object or array.
+ */
+static inline ujson_reader_state ujson_reader_state_save(ujson_reader *self)
+{
+	struct ujson_reader_state ret = {
+		.off = self->sub_off,
+		.depth = self->depth,
+	};
+
+	return ret;
+}
+
+/**
+ * @brief Returns the parser to a saved state.
+ *
+ * This function could be used for the parser to return to the start of
+ * object or array saved by t the ujson_reader_state_get() function.
+ *
+ * @param self A ujson_reader
+ * @param state An parser state as returned by the ujson_reader_state_get().
+ */
+static inline void ujson_reader_state_load(ujson_reader *self, ujson_reader_state state)
+{
+	if (ujson_reader_err(self))
+		return;
+
+	self->off = state.off;
+	self->sub_off = state.off;
+	self->depth = state.depth;
+}
+
+/**
+ * @brief Resets the parser to a start.
+ *
+ * @param self A ujson_reader
+ */
+static inline void ujson_reader_reset(ujson_reader *self)
+{
+	self->off = 0;
+	self->sub_off = 0;
+	self->depth = 0;
+	self->err[0] = 0;
+}
+
+/**
+ * @brief Loads a file into an ujson_reader buffer.
+ *
+ * The reader has to be later freed by ujson_reader_free().
+ *
+ * @param path A path to a file.
+ * @return A ujson_reader or NULL in a case of a failure.
+ */
+ujson_reader *ujson_reader_load(const char *path);
+
+/**
+ * @brief Frees an ujson_reader buffer.
+ *
+ * @param self A ujson_reader allocated by ujson_reader_load() function.
+ */
+void ujson_reader_free(ujson_reader *self);
+
+/**
+ * @brief Prints errors and warnings at the end of parsing.
+ *
+ * Checks if self->err is set and prints the error with ujson_reader_err()
+ *
+ * Checks if there is any text left after the parser has finished with
+ * ujson_reader_consumed() and prints a warning if there were any non-whitespace
+ * characters left.
+ *
+ * @param self A ujson_reader
+ */
+void ujson_reader_finish(ujson_reader *self);
+
+/**
+ * @brief Returns non-zero if whole buffer has been consumed.
+ *
+ * @param self A ujson_reader.
+ * @return Non-zero if whole buffer was consumed.
+ */
+static inline int ujson_reader_consumed(ujson_reader *self)
+{
+	return self->off >= self->len;
+}
+
+#endif /* UJSON_H */
diff --git a/include/ujson_utf.h b/include/ujson_utf.h
new file mode 100644
index 000000000..f939fbe8c
--- /dev/null
+++ b/include/ujson_utf.h
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2022-2024 Cyril Hrubis <metan@ucw.cz>
+ */
+
+/**
+ * @file ujson_utf.h
+ * @brief Unicode helper macros and functions.
+ */
+
+#ifndef UJSON_UTF_H
+#define UJSON_UTF_H
+
+#include <stdint.h>
+#include <stddef.h>
+
+/** Returns true if unicode byte is ASCII */
+#define UJSON_UTF8_IS_ASCII(ch) (!((ch) & 0x80))
+/** Returns true if we have first unicode byte of single byte sequence */
+#define UJSON_UTF8_IS_NBYTE(ch) (((ch) & 0xc0) == 0x80)
+/** Returns true if we have first unicode byte of two byte sequence */
+#define UJSON_UTF8_IS_2BYTE(ch) (((ch) & 0xe0) == 0xc0)
+/** Returns true if we have first unicode byte of three byte sequence */
+#define UJSON_UTF8_IS_3BYTE(ch) (((ch) & 0xf0) == 0xe0)
+/** Returns true if we have first unicode byte of four byte sequence */
+#define UJSON_UTF8_IS_4BYTE(ch) (((ch) & 0xf8) == 0xf0)
+
+#define UJSON_UTF8_NBYTE_MASK 0x3f
+
+/**
+ * @brief Parses next unicode character in UTF-8 string.
+ * @param str A pointer to the C string.
+ * @return A unicode character or 0 on error or end of the string.
+ */
+static inline uint32_t ujson_utf8_next(const char **str)
+{
+	uint32_t s0 = *str[0];
+
+	(*str)++;
+
+	if (UJSON_UTF8_IS_ASCII(s0))
+		return s0;
+
+	uint32_t s1 = *str[0];
+
+	if (!UJSON_UTF8_IS_NBYTE(s1))
+		return 0;
+
+	s1 &= UJSON_UTF8_NBYTE_MASK;
+
+	(*str)++;
+
+	if (UJSON_UTF8_IS_2BYTE(s0))
+		return (s0 & 0x1f)<<6 | s1;
+
+	uint32_t s2 = *str[0];
+
+	if (!UJSON_UTF8_IS_NBYTE(s2))
+		return 0;
+
+	s2 &= UJSON_UTF8_NBYTE_MASK;
+
+	(*str)++;
+
+	if (UJSON_UTF8_IS_3BYTE(s0))
+		return (s0 & 0x0f)<<12 | s1<<6 | s2;
+
+	(*str)++;
+
+	uint32_t s3 = *str[0];
+
+	if (!UJSON_UTF8_IS_NBYTE(s2))
+		return 0;
+
+	s3 &= UJSON_UTF8_NBYTE_MASK;
+
+	if (UJSON_UTF8_IS_4BYTE(s0))
+		return (s0 & 0x07)<<18 | s1<<12 | s2<<6 | s3;
+
+	return 0;
+}
+
+/**
+ * @brief Returns number of bytes next character is occupying in an UTF-8 string.
+ *
+ * @param str A pointer to a string.
+ * @param off An offset into the string, must point to a valid multibyte boundary.
+ * @return Number of bytes next character occupies, zero on string end and -1 on failure.
+ */
+int8_t ujson_utf8_next_chsz(const char *str, size_t off);
+
+/**
+ * @brief Returns number of bytes previous character is occupying in an UTF-8 string.
+ *
+ * @param str A pointer to a string.
+ * @param off An offset into the string, must point to a valid multibyte boundary.
+ * @return Number of bytes previous character occupies, and -1 on failure.
+ */
+int8_t ujson_utf8_prev_chsz(const char *str, size_t off);
+
+/**
+ * @brief Returns a number of characters in UTF-8 string.
+ *
+ * Returns number of characters in an UTF-8 string, which may be less or equal
+ * to what strlen() reports.
+ *
+ * @param str An UTF-8 string.
+ * @return Number of characters in the string.
+ */
+size_t ujson_utf8_strlen(const char *str);
+
+/**
+ * @brief Returns a number of bytes needed to store unicode character into UTF-8.
+ *
+ * @param unicode A unicode character.
+ * @return Number of utf8 bytes required to store a unicode character.
+ */
+static inline unsigned int ujson_utf8_bytes(uint32_t unicode)
+{
+	if (unicode < 0x0080)
+		return 1;
+
+	if (unicode < 0x0800)
+		return 2;
+
+	if (unicode < 0x10000)
+		return 3;
+
+	return 4;
+}
+
+/**
+ * @brief Writes an unicode character into a UTF-8 buffer.
+ *
+ * The buffer _must_ be large enough!
+ *
+ * @param unicode A unicode character.
+ * @param buf A byte buffer.
+ * @return A number of bytes written.
+ */
+static inline int ujson_to_utf8(uint32_t unicode, char *buf)
+{
+	if (unicode < 0x0080) {
+		buf[0] = unicode & 0x007f;
+		return 1;
+	}
+
+	if (unicode < 0x0800) {
+		buf[0] = 0xc0 | (0x1f & (unicode>>6));
+		buf[1] = 0x80 | (0x3f & unicode);
+		return 2;
+	}
+
+	if (unicode < 0x10000) {
+		buf[0] = 0xe0 | (0x0f & (unicode>>12));
+		buf[1] = 0x80 | (0x3f & (unicode>>6));
+		buf[2] = 0x80 | (0x3f & unicode);
+		return 3;
+	}
+
+	buf[0] = 0xf0 | (0x07 & (unicode>>18));
+	buf[1] = 0x80 | (0x3f & (unicode>>12));
+	buf[2] = 0x80 | (0x3f & (unicode>>6));
+	buf[3] = 0x80 | (0x3f & unicode);
+	return 4;
+}
+
+#endif /* UJSON_UTF_H */
diff --git a/include/ujson_writer.h b/include/ujson_writer.h
new file mode 100644
index 000000000..dfcc95053
--- /dev/null
+++ b/include/ujson_writer.h
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2021-2024 Cyril Hrubis <metan@ucw.cz>
+ */
+
+/**
+ * @file ujson_writer.h
+ * @brief A JSON writer.
+ *
+ * All the function that add values return zero on success and non-zero on a
+ * failure. Once an error has happened all subsequent attempts to add more
+ * values return with non-zero exit status immediatelly. This is designed
+ * so that we can add several values without checking each return value
+ * and only check if error has happened at the end of the sequence.
+ *
+ * Failures may occur:
+ * - if we call the functions out of order, e.g. attempt to finish array when
+ *   we are not writing out an array.
+ * - if we run out of recursion stack
+ * - may be propagated from the writer function, e.g. allocation failure, no
+ *   space on disk, etc.
+ */
+
+#ifndef UJSON_WRITER_H
+#define UJSON_WRITER_H
+
+#include <ujson_common.h>
+
+/** @brief A JSON writer */
+struct ujson_writer {
+	unsigned int depth;
+	char depth_type[UJSON_RECURSION_MAX/8];
+	char depth_first[UJSON_RECURSION_MAX/8];
+
+	/** Handler to print errors and warnings */
+	void (*err_print)(void *err_print_priv, const char *line);
+	void *err_print_priv;
+	char err[UJSON_ERR_MAX];
+
+	/** Handler to produce JSON output */
+	int (*out)(struct ujson_writer *self, const char *buf, size_t buf_size);
+	void *out_priv;
+};
+
+/**
+ * @brief An ujson_writer initializer with default values.
+ *
+ * @param vout A pointer to function to write out the data.
+ * @param vout_priv An user pointer passed to the out function.
+ *
+ * @return An ujson_writer initialized with default values.
+ */
+#define UJSON_WRITER_INIT(vout, vout_priv) { \
+	.err_print = UJSON_ERR_PRINT, \
+	.err_print_priv = UJSON_ERR_PRINT_PRIV, \
+	.out = vout, \
+	.out_priv = vout_priv \
+}
+
+/**
+ * @brief Allocates a JSON file writer.
+ *
+ * The call may fail either when file cannot be opened for writing or if
+ * allocation has failed. In all cases errno should be set correctly.
+ *
+ * @param path A path to the file, file is opened for writing and created if it
+ *             does not exist.
+ *
+ * @return A ujson_writer pointer or NULL in a case of failure.
+ */
+ujson_writer *ujson_writer_file_open(const char *path);
+
+/**
+ * @brief Closes and frees a JSON file writer.
+ *
+ * @param self A ujson_writer file writer.
+ *
+ * @return Zero on success, non-zero on a failure and errno is set.
+ */
+int ujson_writer_file_close(ujson_writer *self);
+
+/**
+ * @brief Returns true if writer error happened.
+ *
+ * @param self A JSON writer.
+ *
+ * @return True if error has happened.
+ */
+static inline int ujson_writer_err(ujson_writer *self)
+{
+	return !!self->err[0];
+}
+
+/**
+ * @brief Starts a JSON object.
+ *
+ * For a top level object the id must be NULL, every other object has to have
+ * non-NULL id. The call will also fail if maximal recursion depth
+ * UJSON_RECURSION_MAX has been reached.
+ *
+ * @param self A JSON writer.
+ * @param id An object name.
+ *
+ * @return Zero on a success, non-zero otherwise.
+ */
+int ujson_obj_start(ujson_writer *self, const char *id);
+
+/**
+ * @brief Finishes a JSON object.
+ *
+ * The call will fail if we are currenlty not writing out an object.
+ *
+ * @param self A JSON writer.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_obj_finish(ujson_writer *self);
+
+/**
+ * @brief Starts a JSON array.
+ *
+ * For a top level array the id must be NULL, every other array has to have
+ * non-NULL id. The call will also fail if maximal recursion depth
+ * UJSON_RECURSION_MAX has been reached.
+ *
+ * @param self A JSON writer.
+ * @param id An array name.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_arr_start(ujson_writer *self, const char *id);
+
+/**
+ * @brief Finishes a JSON array.
+ *
+ * The call will fail if we are currenlty not writing out an array.
+ *
+ * @param self A JSON writer.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_arr_finish(ujson_writer *self);
+
+/**
+ * @brief Adds a null value.
+ *
+ * The id must be NULL inside of an array, and must be non-NULL inside of an
+ * object.
+ *
+ * @param self A JSON writer.
+ * @param id A null value name.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_null_add(ujson_writer *self, const char *id);
+
+/**
+ * @brief Adds an integer value.
+ *
+ * The id must be NULL inside of an array, and must be non-NULL inside of an
+ * object.
+ *
+ * @param self A JSON writer.
+ * @param id An integer value name.
+ * @param val An integer value.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_int_add(ujson_writer *self, const char *id, long val);
+
+/**
+ * @brief Adds a bool value.
+ *
+ * The id must be NULL inside of an array, and must be non-NULL inside of an
+ * object.
+ *
+ * @param self A JSON writer.
+ * @param id An boolean value name.
+ * @param val A boolean value.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_bool_add(ujson_writer *self, const char *id, int val);
+
+/**
+ * @brief Adds a float value.
+ *
+ * The id must be NULL inside of an array, and must be non-NULL inside of an
+ * object.
+ *
+ * @param self A JSON writer.
+ * @param id A floating point value name.
+ * @param val A floating point value.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_float_add(ujson_writer *self, const char *id, double val);
+
+/**
+ * @brief Adds a string value.
+ *
+ * The id must be NULL inside of an array, and must be non-NULL inside of an
+ * object.
+ *
+ * @param self A JSON writer.
+ * @param id A string value name.
+ * @param str An UTF8 string value.
+ *
+ * @return Zero on success, non-zero otherwise.
+ */
+int ujson_str_add(ujson_writer *self, const char *id, const char *str);
+
+/**
+ * @brief Finalizes json writer.
+ *
+ * Finalizes the json writer, throws possible errors through the error printing
+ * function.
+ *
+ * @param self A JSON writer.
+ * @return Overall error value.
+ */
+int ujson_writer_finish(ujson_writer *self);
+
+#endif /* UJSON_WRITER_H */
diff --git a/libs/ujson/Makefile b/libs/ujson/Makefile
new file mode 100644
index 000000000..4c8508010
--- /dev/null
+++ b/libs/ujson/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INTERNAL_LIB		:= libujson.a
+
+include $(top_srcdir)/include/mk/lib.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/libs/ujson/ujson_common.c b/libs/ujson/ujson_common.c
new file mode 100644
index 000000000..c9cada9a9
--- /dev/null
+++ b/libs/ujson/ujson_common.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2021-2024 Cyril Hrubis <metan@ucw.cz>
+ */
+
+#include <stdio.h>
+#include "ujson_common.h"
+
+void ujson_err_handler(void *err_print_priv, const char *line)
+{
+	fputs(line, err_print_priv);
+	putc('\n', err_print_priv);
+}
+
+const char *ujson_type_name(enum ujson_type type)
+{
+	switch (type) {
+	case UJSON_VOID:
+		return "void";
+	case UJSON_INT:
+		return "integer";
+	case UJSON_FLOAT:
+		return "float";
+	case UJSON_BOOL:
+		return "boolean";
+	case UJSON_NULL:
+		return "null";
+	case UJSON_STR:
+		return "string";
+	case UJSON_OBJ:
+		return "object";
+	case UJSON_ARR:
+		return "array";
+	default:
+		return "invalid";
+	}
+}
+
diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
new file mode 100644
index 000000000..d508f00d3
--- /dev/null
+++ b/libs/ujson/ujson_reader.c
@@ -0,0 +1,1081 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2021-2024 Cyril Hrubis <metan@ucw.cz>
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdarg.h>
+#include <stdint.h>
+
+#include "ujson_utf.h"
+#include "ujson_reader.h"
+
+static const struct ujson_obj empty = {};
+const struct ujson_obj *ujson_empty_obj = &empty;
+
+static inline int buf_empty(ujson_reader *buf)
+{
+	return buf->off >= buf->len;
+}
+
+static int eatws(ujson_reader *buf)
+{
+	while (!buf_empty(buf)) {
+		switch (buf->json[buf->off]) {
+		case ' ':
+		case '\t':
+		case '\n':
+		case '\r':
+		break;
+		default:
+			goto ret;
+		}
+
+		buf->off += 1;
+	}
+ret:
+	return buf_empty(buf);
+}
+
+static char getb(ujson_reader *buf)
+{
+	if (buf_empty(buf))
+		return 0;
+
+	return buf->json[buf->off++];
+}
+
+static char peekb_off(ujson_reader *buf, size_t off)
+{
+	if (buf->off + off >= buf->len)
+		return 0;
+
+	return buf->json[buf->off + off];
+}
+
+static char peekb(ujson_reader *buf)
+{
+	if (buf_empty(buf))
+		return 0;
+
+	return buf->json[buf->off];
+}
+
+static int eatb(ujson_reader *buf, char ch)
+{
+	if (peekb(buf) != ch)
+		return 0;
+
+	getb(buf);
+	return 1;
+}
+
+static int eatb2(ujson_reader *buf, char ch1, char ch2)
+{
+	if (peekb(buf) != ch1 && peekb(buf) != ch2)
+		return 0;
+
+	getb(buf);
+	return 1;
+}
+
+static int eatstr(ujson_reader *buf, const char *str)
+{
+	while (*str) {
+		if (!eatb(buf, *str))
+			return 0;
+		str++;
+	}
+
+	return 1;
+}
+
+static int hex2val(unsigned char b)
+{
+	switch (b) {
+	case '0' ... '9':
+		return b - '0';
+	case 'a' ... 'f':
+		return b - 'a' + 10;
+	case 'A' ... 'F':
+		return b - 'A' + 10;
+	default:
+		return -1;
+	}
+}
+
+static int32_t parse_ucode_cp(ujson_reader *buf)
+{
+	int ret = 0, v, i;
+
+	for (i = 0; i < 4; i++) {
+		if ((v = hex2val(getb(buf))) < 0)
+			goto err;
+		ret *= 16;
+		ret += v;
+	}
+
+	return ret;
+err:
+	ujson_err(buf, "Expected four hexadecimal digits");
+	return -1;
+}
+
+static unsigned int parse_ucode_esc(ujson_reader *buf, char *str,
+                                    size_t off, size_t len)
+{
+	int32_t ucode = parse_ucode_cp(buf);
+
+	if (ucode < 0)
+		return 0;
+
+	if (!str)
+		return ucode;
+
+	if (ujson_utf8_bytes(ucode) + 1 >= len - off) {
+		ujson_err(buf, "String buffer too short!");
+		return 0;
+	}
+
+	return ujson_to_utf8(ucode, str+off);
+}
+
+static int copy_str(ujson_reader *buf, char *str, size_t len)
+{
+	size_t pos = 0;
+	int esc = 0;
+	unsigned int l;
+
+	eatb(buf, '"');
+
+	for (;;) {
+		if (buf_empty(buf)) {
+			ujson_err(buf, "Unterminated string");
+			return 1;
+		}
+
+		if (!esc && eatb(buf, '"')) {
+			if (str)
+				str[pos] = 0;
+			return 0;
+		}
+
+		unsigned char b = getb(buf);
+
+		if (b < 0x20) {
+			if (!peekb(buf))
+				ujson_err(buf, "Unterminated string");
+			else
+				ujson_err(buf, "Invalid string character 0x%02x", b);
+			return 1;
+		}
+
+		if (!esc && b == '\\') {
+			esc = 1;
+			continue;
+		}
+
+		if (esc) {
+			switch (b) {
+			case '"':
+			case '\\':
+			case '/':
+			break;
+			case 'b':
+				b = '\b';
+			break;
+			case 'f':
+				b = '\f';
+			break;
+			case 'n':
+				b = '\n';
+			break;
+			case 'r':
+				b = '\r';
+			break;
+			case 't':
+				b = '\t';
+			break;
+			case 'u':
+				if (!(l = parse_ucode_esc(buf, str, pos, len)))
+					return 1;
+				pos += l;
+				b = 0;
+			break;
+			default:
+				ujson_err(buf, "Invalid escape \\%c", b);
+				return 1;
+			}
+			esc = 0;
+		}
+
+		if (str && b) {
+			if (pos + 1 >= len) {
+				ujson_err(buf, "String buffer too short!");
+				return 1;
+			}
+
+			str[pos++] = b;
+		}
+	}
+
+	return 1;
+}
+
+static int copy_id_str(ujson_reader *buf, char *str, size_t len)
+{
+	size_t pos = 0;
+
+	if (eatws(buf))
+		goto err0;
+
+	if (!eatb(buf, '"'))
+		goto err0;
+
+	for (;;) {
+		if (buf_empty(buf)) {
+			ujson_err(buf, "Unterminated ID string");
+			return 1;
+		}
+
+		if (eatb(buf, '"')) {
+			str[pos] = 0;
+			break;
+		}
+
+		if (pos >= len-1) {
+			ujson_err(buf, "ID string too long");
+			return 1;
+		}
+
+		str[pos++] = getb(buf);
+	}
+
+	if (eatws(buf))
+		goto err1;
+
+	if (!eatb(buf, ':'))
+		goto err1;
+
+	return 0;
+err0:
+	ujson_err(buf, "Expected ID string");
+	return 1;
+err1:
+	ujson_err(buf, "Expected ':' after ID string");
+	return 1;
+}
+
+static int is_digit(char b)
+{
+	switch (b) {
+	case '0' ... '9':
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int get_int(ujson_reader *buf, struct ujson_val *res)
+{
+	long val = 0;
+	int sign = 1;
+
+	if (eatb(buf, '-')) {
+		sign = -1;
+		if (!is_digit(peekb(buf))) {
+			ujson_err(buf, "Expected digit(s)");
+			return 1;
+		}
+	}
+
+	if (peekb(buf) == '0' && is_digit(peekb_off(buf, 1))) {
+		ujson_err(buf, "Leading zero in number!");
+		return 1;
+	}
+
+	while (is_digit(peekb(buf))) {
+		val *= 10;
+		val += getb(buf) - '0';
+		//TODO: overflow?
+	}
+
+	if (sign < 0)
+		val = -val;
+
+	res->val_int = val;
+	res->val_float = val;
+
+	return 0;
+}
+
+static int eat_digits(ujson_reader *buf)
+{
+	if (!is_digit(peekb(buf))) {
+		ujson_err(buf, "Expected digit(s)");
+		return 1;
+	}
+
+	while (is_digit(peekb(buf)))
+		getb(buf);
+
+	return 0;
+}
+
+static int get_float(ujson_reader *buf, struct ujson_val *res)
+{
+	off_t start = buf->off;
+
+	eatb(buf, '-');
+
+	if (peekb(buf) == '0' && is_digit(peekb_off(buf, 1))) {
+		ujson_err(buf, "Leading zero in float");
+		return 1;
+	}
+
+	if (eat_digits(buf))
+		return 1;
+
+	switch (getb(buf)) {
+	case '.':
+		if (eat_digits(buf))
+			return 1;
+
+		if (!eatb2(buf, 'e', 'E'))
+			break;
+
+		/* fallthrough */
+	case 'e':
+	case 'E':
+		eatb2(buf, '+', '-');
+
+		if (eat_digits(buf))
+			return 1;
+	break;
+	}
+
+	size_t len = buf->off - start;
+	char tmp[len+1];
+
+	memcpy(tmp, buf->json + start, len);
+
+	tmp[len] = 0;
+
+	res->val_float = strtod(tmp, NULL);
+
+	return 0;
+}
+
+static int get_bool(ujson_reader *buf, struct ujson_val *res)
+{
+	switch (peekb(buf)) {
+	case 'f':
+		if (!eatstr(buf, "false")) {
+			ujson_err(buf, "Expected 'false'");
+			return 1;
+		}
+
+		res->val_bool = 0;
+	break;
+	case 't':
+		if (!eatstr(buf, "true")) {
+			ujson_err(buf, "Expected 'true'");
+			return 1;
+		}
+
+		res->val_bool = 1;
+	break;
+	}
+
+	return 0;
+}
+
+static int get_null(ujson_reader *buf)
+{
+	if (!eatstr(buf, "null")) {
+		ujson_err(buf, "Expected 'null'");
+		return 1;
+	}
+
+	return 0;
+}
+
+int ujson_obj_skip(ujson_reader *buf)
+{
+	struct ujson_val res = {};
+
+	UJSON_OBJ_FOREACH(buf, &res) {
+		switch (res.type) {
+		case UJSON_OBJ:
+			if (ujson_obj_skip(buf))
+				return 1;
+		break;
+		case UJSON_ARR:
+			if (ujson_arr_skip(buf))
+				return 1;
+		break;
+		default:
+		break;
+		}
+	}
+
+	return 0;
+}
+
+int ujson_arr_skip(ujson_reader *buf)
+{
+	struct ujson_val res = {};
+
+	UJSON_ARR_FOREACH(buf, &res) {
+		switch (res.type) {
+		case UJSON_OBJ:
+			if (ujson_obj_skip(buf))
+				return 1;
+		break;
+		case UJSON_ARR:
+			if (ujson_arr_skip(buf))
+				return 1;
+		break;
+		default:
+		break;
+		}
+	}
+
+	return 0;
+}
+
+static enum ujson_type next_num_type(ujson_reader *buf)
+{
+	size_t off = 0;
+
+	for (;;) {
+		char b = peekb_off(buf, off++);
+
+		switch (b) {
+		case 0:
+		case ',':
+			return UJSON_INT;
+		case '.':
+		case 'e':
+		case 'E':
+			return UJSON_FLOAT;
+		}
+	}
+
+	return UJSON_VOID;
+}
+
+enum ujson_type ujson_next_type(ujson_reader *buf)
+{
+	if (eatws(buf)) {
+		ujson_err(buf, "Unexpected end");
+		return UJSON_VOID;
+	}
+
+	char b = peekb(buf);
+
+	switch (b) {
+	case '{':
+		return UJSON_OBJ;
+	case '[':
+		return UJSON_ARR;
+	case '"':
+		return UJSON_STR;
+	case '-':
+	case '0' ... '9':
+		return next_num_type(buf);
+	case 'f':
+	case 't':
+		return UJSON_BOOL;
+	break;
+	case 'n':
+		return UJSON_NULL;
+	break;
+	default:
+		ujson_err(buf, "Expected object, array, number or string");
+		return UJSON_VOID;
+	}
+}
+
+enum ujson_type ujson_reader_start(ujson_reader *buf)
+{
+	enum ujson_type type = ujson_next_type(buf);
+
+	switch (type) {
+	case UJSON_ARR:
+	case UJSON_OBJ:
+	case UJSON_VOID:
+	break;
+	default:
+		ujson_err(buf, "JSON can start only with array or object");
+		type = UJSON_VOID;
+	break;
+	}
+
+	return type;
+}
+
+static int get_value(ujson_reader *buf, struct ujson_val *res)
+{
+	int ret = 0;
+
+	res->type = ujson_next_type(buf);
+
+	switch (res->type) {
+	case UJSON_STR:
+		if (copy_str(buf, res->buf, res->buf_size)) {
+			res->type = UJSON_VOID;
+			return 0;
+		}
+		res->val_str = res->buf;
+		return 1;
+	case UJSON_INT:
+		ret = get_int(buf, res);
+	break;
+	case UJSON_FLOAT:
+		ret = get_float(buf, res);
+	break;
+	case UJSON_BOOL:
+		ret = get_bool(buf, res);
+	break;
+	case UJSON_NULL:
+		ret = get_null(buf);
+	break;
+	case UJSON_VOID:
+		return 0;
+	case UJSON_ARR:
+	case UJSON_OBJ:
+		buf->sub_off = buf->off;
+		return 1;
+	}
+
+	if (ret) {
+		res->type = UJSON_VOID;
+		return 0;
+	}
+
+	return 1;
+}
+
+static int pre_next(ujson_reader *buf, struct ujson_val *res)
+{
+	if (!eatb(buf, ',')) {
+		ujson_err(buf, "Expected ','");
+		res->type = UJSON_VOID;
+		return 1;
+	}
+
+	if (eatws(buf)) {
+		ujson_err(buf, "Unexpected end");
+		res->type = UJSON_VOID;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int check_end(ujson_reader *buf, struct ujson_val *res, char b)
+{
+	if (eatws(buf)) {
+		ujson_err(buf, "Unexpected end");
+		return 1;
+	}
+
+	if (eatb(buf, b)) {
+		res->type = UJSON_VOID;
+		eatws(buf);
+		eatb(buf, 0);
+		buf->depth--;
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * This is supposed to return a pointer to a string stored as a first member of
+ * a structure given an array.
+ *
+ * e.g.
+ *
+ *	struct foo {
+ *		const char *key;
+ *		...
+ *	};
+ *
+ *	const struct foo bar[10] = {...};
+ *
+ *      // Returns a pointer to the key string in a second structure in bar[].
+ *	const char *key = list_elem(bar, sizeof(struct foo), 1);
+ */
+static inline const char *list_elem(const void *arr, size_t memb_size, size_t idx)
+{
+	return *(const char**)(arr + idx * memb_size);
+}
+
+size_t ujson_lookup(const void *arr, size_t memb_size, size_t list_len,
+                    const char *key)
+{
+	size_t l = 0;
+	size_t r = list_len-1;
+	size_t mid = -1;
+
+	if (!list_len)
+		return (size_t)-1;
+
+	while (r - l > 1) {
+		mid = (l+r)/2;
+
+		int ret = strcmp(list_elem(arr, memb_size, mid), key);
+		if (!ret)
+			return mid;
+
+		if (ret < 0)
+			l = mid;
+		else
+			r = mid;
+	}
+
+	if (r != mid && !strcmp(list_elem(arr, memb_size, r), key))
+		return r;
+
+	if (l != mid && !strcmp(list_elem(arr, memb_size, l), key))
+		return l;
+
+	return -1;
+}
+
+static int skip_obj_val(ujson_reader *buf)
+{
+	struct ujson_val dummy = {};
+
+	if (!get_value(buf, &dummy))
+		return 0;
+
+	switch (dummy.type) {
+	case UJSON_OBJ:
+		return !ujson_obj_skip(buf);
+	case UJSON_ARR:
+		return !ujson_arr_skip(buf);
+	default:
+		return 1;
+	}
+}
+
+static int obj_next(ujson_reader *buf, struct ujson_val *res)
+{
+	if (copy_id_str(buf, res->id, sizeof(res->id)))
+		return 0;
+
+	return get_value(buf, res);
+}
+
+static int obj_pre_next(ujson_reader *buf, struct ujson_val *res)
+{
+	if (ujson_reader_err(buf))
+		return 1;
+
+	if (check_end(buf, res, '}'))
+		return 1;
+
+	if (pre_next(buf, res))
+		return 1;
+
+	return 0;
+}
+
+static int obj_next_filter(ujson_reader *buf, struct ujson_val *res,
+                           const struct ujson_obj *obj, const struct ujson_obj *ign)
+{
+	const struct ujson_obj_attr *attr;
+
+	for (;;) {
+		if (copy_id_str(buf, res->id, sizeof(res->id)))
+			return 0;
+
+		res->idx = obj ? ujson_obj_lookup(obj, res->id) : (size_t)-1;
+
+		if (res->idx != (size_t)-1) {
+			if (!get_value(buf, res))
+				return 0;
+
+			attr = &obj->attrs[res->idx];
+
+			if (attr->type == UJSON_VOID)
+				return 1;
+
+			if (attr->type == res->type)
+				return 1;
+
+			if (attr->type == UJSON_FLOAT &&
+			    res->type == UJSON_INT)
+				return 1;
+
+			ujson_warn(buf, "Wrong '%s' type expected %s",
+				     attr->key, ujson_type_name(attr->type));
+		} else {
+			if (!skip_obj_val(buf))
+				return 0;
+
+			if (ign && ujson_obj_lookup(ign, res->id) == (size_t)-1)
+				ujson_warn(buf, "Unexpected key '%s'", res->id);
+		}
+
+		if (obj_pre_next(buf, res))
+			return 0;
+	}
+}
+
+static int check_err(ujson_reader *buf, struct ujson_val *res)
+{
+	if (ujson_reader_err(buf)) {
+		res->type = UJSON_VOID;
+		return 1;
+	}
+
+	return 0;
+}
+
+int ujson_obj_next_filter(ujson_reader *buf, struct ujson_val *res,
+                            const struct ujson_obj *obj, const struct ujson_obj *ign)
+{
+	if (check_err(buf, res))
+		return 0;
+
+	if (obj_pre_next(buf, res))
+		return 0;
+
+	return obj_next_filter(buf, res, obj, ign);
+}
+
+int ujson_obj_next(ujson_reader *buf, struct ujson_val *res)
+{
+	if (check_err(buf, res))
+		return 0;
+
+	if (obj_pre_next(buf, res))
+		return 0;
+
+	return obj_next(buf, res);
+}
+
+static int any_first(ujson_reader *buf, char b)
+{
+	if (eatws(buf)) {
+		ujson_err(buf, "Unexpected end");
+		return 1;
+	}
+
+	if (!eatb(buf, b)) {
+		ujson_err(buf, "Expected '%c'", b);
+		return 1;
+	}
+
+	buf->depth++;
+
+	if (buf->depth > buf->max_depth) {
+		ujson_err(buf, "Recursion too deep");
+		return 1;
+	}
+
+	return 0;
+}
+
+int ujson_obj_first_filter(ujson_reader *buf, struct ujson_val *res,
+                             const struct ujson_obj *obj, const struct ujson_obj *ign)
+{
+	if (check_err(buf, res))
+		return 0;
+
+	if (any_first(buf, '{'))
+		return 0;
+
+	if (check_end(buf, res, '}'))
+		return 0;
+
+	return obj_next_filter(buf, res, obj, ign);
+}
+
+int ujson_obj_first(ujson_reader *buf, struct ujson_val *res)
+{
+	if (check_err(buf, res))
+		return 0;
+
+	if (any_first(buf, '{'))
+		return 0;
+
+	if (check_end(buf, res, '}'))
+		return 0;
+
+	return obj_next(buf, res);
+}
+
+static int arr_next(ujson_reader *buf, struct ujson_val *res)
+{
+	return get_value(buf, res);
+}
+
+int ujson_arr_first(ujson_reader *buf, struct ujson_val *res)
+{
+	if (check_err(buf, res))
+		return 0;
+
+	if (any_first(buf, '['))
+		return 0;
+
+	if (check_end(buf, res, ']'))
+		return 0;
+
+	return arr_next(buf, res);
+}
+
+int ujson_arr_next(ujson_reader *buf, struct ujson_val *res)
+{
+	if (check_err(buf, res))
+		return 0;
+
+	if (check_end(buf, res, ']'))
+		return 0;
+
+	if (pre_next(buf, res))
+		return 0;
+
+	return arr_next(buf, res);
+}
+
+static void ujson_err_va(ujson_reader *buf, const char *fmt, va_list va)
+{
+	vsnprintf(buf->err, UJSON_ERR_MAX, fmt, va);
+}
+
+void ujson_err(ujson_reader *buf, const char *fmt, ...)
+{
+	va_list va;
+
+	va_start(va, fmt);
+	ujson_err_va(buf, fmt, va);
+	va_end(va);
+}
+
+static void vprintf_line(ujson_reader *buf, const char *fmt, va_list va)
+{
+	char line[UJSON_ERR_MAX+1];
+
+	vsnprintf(line, sizeof(line), fmt, va);
+
+	line[UJSON_ERR_MAX] = 0;
+
+	buf->err_print(buf->err_print_priv, line);
+}
+
+static void printf_line(ujson_reader *buf, const char *fmt, ...)
+{
+	va_list va;
+
+	va_start(va, fmt);
+	vprintf_line(buf, fmt, va);
+	va_end(va);
+}
+
+static void printf_json_line(ujson_reader *buf, size_t line_nr, const char *buf_pos)
+{
+	char line[UJSON_ERR_MAX+1];
+	size_t plen, i;
+
+	plen = sprintf(line, "%03zu: ", line_nr);
+
+	for (i = 0; i < UJSON_ERR_MAX-plen && buf_pos[i] && buf_pos[i] != '\n'; i++)
+		line[i+plen] = buf_pos[i];
+
+	line[i+plen] = 0;
+
+	buf->err_print(buf->err_print_priv, line);
+}
+
+static void print_arrow(ujson_reader *buf, const char *buf_pos, size_t count)
+{
+	char line[count + 7];
+	size_t i;
+
+	/* The '000: ' prefix */
+	for (i = 0; i <= 5; i++)
+		line[i] = ' ';
+
+	for (i = 0; i < count; i++)
+		line[i+5] = buf_pos[i] == '\t' ? '\t' : ' ';
+
+	line[count+5] = '^';
+	line[count+6] = 0;
+
+	buf->err_print(buf->err_print_priv, line);
+}
+
+#define ERR_LINES 10
+
+#define MIN(A, B) ((A < B) ? (A) : (B))
+
+static void print_snippet(ujson_reader *buf, const char *type)
+{
+	ssize_t i;
+	const char *lines[ERR_LINES] = {};
+	size_t cur_line = 0;
+	size_t cur_off = 0;
+	size_t last_off = buf->off;
+
+	for (;;) {
+		lines[(cur_line++) % ERR_LINES] = buf->json + cur_off;
+
+		while (cur_off < buf->len && buf->json[cur_off] != '\n')
+			cur_off++;
+
+		if (cur_off >= buf->off)
+			break;
+
+		cur_off++;
+		last_off = buf->off - cur_off;
+	}
+
+	printf_line(buf, "%s at line %03zu", type, cur_line);
+	buf->err_print(buf->err_print_priv, "");
+
+	size_t idx = 0;
+
+	for (i = MIN(ERR_LINES, cur_line); i > 0; i--) {
+		idx = (cur_line - i) % ERR_LINES;
+		printf_json_line(buf, cur_line - i + 1, lines[idx]);
+	}
+
+	print_arrow(buf, lines[idx], last_off);
+}
+
+void ujson_err_print(ujson_reader *buf)
+{
+	if (!buf->err_print)
+		return;
+
+	print_snippet(buf, "Parse error");
+	buf->err_print(buf->err_print_priv, buf->err);
+}
+
+void ujson_warn(ujson_reader *buf, const char *fmt, ...)
+{
+	va_list va;
+
+	if (buf->flags & UJSON_READER_STRICT) {
+		va_start(va, fmt);
+		ujson_err_va(buf, fmt, va);
+		va_end(va);
+		return;
+	}
+
+	if (!buf->err_print)
+		return;
+
+	print_snippet(buf, "Warning");
+
+	va_start(va, fmt);
+	vprintf_line(buf, fmt, va);
+	va_end(va);
+}
+
+void ujson_print(void *err_print_priv, const char *line)
+{
+	fputs(line, err_print_priv);
+	putc('\n', err_print_priv);
+}
+
+ujson_reader *ujson_reader_load(const char *path)
+{
+	int fd = open(path, O_RDONLY);
+	ujson_reader *ret;
+	ssize_t res;
+	off_t len, off = 0;
+
+	if (fd < 0)
+		return NULL;
+
+	len = lseek(fd, 0, SEEK_END);
+	if (len == (off_t)-1) {
+		fprintf(stderr, "lseek() failed\n");
+		goto err0;
+	}
+
+	if (lseek(fd, 0, SEEK_SET) == (off_t)-1) {
+		fprintf(stderr, "lseek() failed\n");
+		goto err0;
+	}
+
+	ret = malloc(sizeof(ujson_reader) + len + 1);
+	if (!ret) {
+		fprintf(stderr, "malloc() failed\n");
+		goto err0;
+	}
+
+	memset(ret, 0, sizeof(*ret));
+
+	ret->buf[len] = 0;
+	ret->len = len;
+	ret->max_depth = UJSON_RECURSION_MAX;
+	ret->json = ret->buf;
+	ret->err_print = UJSON_ERR_PRINT;
+	ret->err_print_priv = UJSON_ERR_PRINT_PRIV;
+
+	while (off < len) {
+		res = read(fd, ret->buf + off, len - off);
+		if (res < 0) {
+			fprintf(stderr, "read() failed\n");
+			goto err1;
+		}
+
+		off += res;
+	}
+
+	close(fd);
+
+	return ret;
+err1:
+	free(ret);
+err0:
+	close(fd);
+	return NULL;
+}
+
+void ujson_reader_finish(ujson_reader *self)
+{
+	if (ujson_reader_err(self))
+		ujson_err_print(self);
+	else if (!ujson_reader_consumed(self))
+		ujson_warn(self, "Garbage after JSON string!");
+}
+
+void ujson_reader_free(ujson_reader *buf)
+{
+	free(buf);
+}
+
+ujson_val *ujson_val_alloc(size_t buf_size)
+{
+	buf_size = buf_size == 0 ? 4096 : buf_size;
+	ujson_val *ret;
+
+	ret = malloc(sizeof(ujson_val) + buf_size);
+	if (!ret)
+		return NULL;
+
+	memset(ret, 0, sizeof(ujson_val) + buf_size);
+
+	ret->buf = ret->buf__;
+	ret->buf_size = buf_size;
+
+	return ret;
+}
+
+void ujson_val_free(ujson_val *self)
+{
+	free(self);
+}
diff --git a/libs/ujson/ujson_utf.c b/libs/ujson/ujson_utf.c
new file mode 100644
index 000000000..2c08a39a8
--- /dev/null
+++ b/libs/ujson/ujson_utf.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2022-2024 Cyril Hrubis <metan@ucw.cz>
+ */
+
+#include <stddef.h>
+#include <ujson_utf.h>
+
+int8_t ujson_utf8_next_chsz(const char *str, size_t off)
+{
+	char ch = str[off];
+	uint8_t len = 0;
+
+	if (!ch)
+		return 0;
+
+	if (UJSON_UTF8_IS_ASCII(ch))
+		return 1;
+
+	if (UJSON_UTF8_IS_2BYTE(ch)) {
+		len = 2;
+		goto ret;
+	}
+
+	if (UJSON_UTF8_IS_3BYTE(ch)) {
+		len = 3;
+		goto ret;
+	}
+
+	if (UJSON_UTF8_IS_4BYTE(ch)) {
+		len = 4;
+		goto ret;
+	}
+
+	return -1;
+ret:
+	if (!UJSON_UTF8_IS_NBYTE(str[off+1]))
+		return -1;
+
+	if (len > 2 && !UJSON_UTF8_IS_NBYTE(str[off+2]))
+		return -1;
+
+	if (len > 3 && !UJSON_UTF8_IS_NBYTE(str[off+3]))
+		return -1;
+
+	return len;
+}
+
+int8_t ujson_utf8_prev_chsz(const char *str, size_t off)
+{
+	char ch;
+
+	if (!off)
+		return 0;
+
+	ch = str[--off];
+
+	if (UJSON_UTF8_IS_ASCII(ch))
+		return 1;
+
+	if (!UJSON_UTF8_IS_NBYTE(ch))
+		return -1;
+
+	if (off < 1)
+		return -1;
+
+	ch = str[--off];
+
+	if (UJSON_UTF8_IS_2BYTE(ch))
+		return 2;
+
+	if (!UJSON_UTF8_IS_NBYTE(ch))
+		return -1;
+
+	if (off < 1)
+		return -1;
+
+	ch = str[--off];
+
+	if (UJSON_UTF8_IS_3BYTE(ch))
+		return 3;
+
+	if (!UJSON_UTF8_IS_NBYTE(ch))
+		return -1;
+
+	if (off < 1)
+		return -1;
+
+	ch = str[--off];
+
+	if (UJSON_UTF8_IS_4BYTE(ch))
+		return 4;
+
+	return -1;
+}
+
+size_t ujson_utf8_strlen(const char *str)
+{
+	size_t cnt = 0;
+
+	while (ujson_utf8_next(&str))
+		cnt++;
+
+	return cnt;
+}
diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
new file mode 100644
index 000000000..6275be1ff
--- /dev/null
+++ b/libs/ujson/ujson_writer.c
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * Copyright (C) 2021-2024 Cyril Hrubis <metan@ucw.cz>
+ */
+
+#include <string.h>
+#include <stdarg.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+#include "ujson_utf.h"
+#include "ujson_writer.h"
+
+static inline int get_depth_bit(ujson_writer *self, char *mask)
+{
+	int depth = self->depth - 1;
+
+	if (depth < 0)
+		return -1;
+
+	return !!(mask[depth/8] & (1<<(depth%8)));
+}
+
+static inline void set_depth_bit(ujson_writer *self, int val)
+{
+	if (val)
+		self->depth_type[self->depth/8] |= (1<<(self->depth%8));
+	else
+		self->depth_type[self->depth/8] &= ~(1<<(self->depth%8));
+
+	self->depth_first[self->depth/8] |= (1<<(self->depth%8));
+
+	self->depth++;
+}
+
+static inline void clear_depth_bit(ujson_writer *self)
+{
+	self->depth--;
+}
+
+static inline int in_arr(ujson_writer *self)
+{
+	return !get_depth_bit(self, self->depth_type);
+}
+
+static inline int in_obj(ujson_writer *self)
+{
+	return get_depth_bit(self, self->depth_type);
+}
+
+static inline void clear_depth_first(ujson_writer *self)
+{
+	int depth = self->depth - 1;
+
+	self->depth_first[depth/8] &= ~(1<<(depth%8));
+}
+
+static inline int is_first(ujson_writer *self)
+{
+	int ret = get_depth_bit(self, self->depth_first);
+
+	if (ret == 1)
+		clear_depth_first(self);
+
+	return ret;
+}
+
+static inline void err(ujson_writer *buf, const char *fmt, ...)
+{
+	va_list va;
+
+	va_start(va, fmt);
+	vsnprintf(buf->err, UJSON_ERR_MAX, fmt, va);
+	va_end(va);
+}
+
+static inline int is_err(ujson_writer *buf)
+{
+	return buf->err[0];
+}
+
+static inline int out(ujson_writer *self, const char *buf, size_t len)
+{
+	return self->out(self, buf, len);
+}
+
+static inline int out_str(ujson_writer *self, const char *str)
+{
+	return out(self, str, strlen(str));
+}
+
+static inline int out_ch(ujson_writer *self, char ch)
+{
+	return out(self, &ch, 1);
+}
+
+#define ESC_FLUSH(esc_char) do {\
+	out(self, val, i); \
+	val += i + 1; \
+	i = 0; \
+	out_str(self, esc_char); \
+} while (0)
+
+static inline int out_esc_str(ujson_writer *self, const char *val)
+{
+	if (out_ch(self, '"'))
+		return 1;
+
+	size_t i = 0;
+	int8_t next_chsz;
+
+	do {
+		next_chsz = ujson_utf8_next_chsz(val, i);
+
+		if (next_chsz == 1) {
+			switch (val[i]) {
+			case '\"':
+				ESC_FLUSH("\\\"");
+			break;
+			case '\\':
+				ESC_FLUSH("\\\\");
+			break;
+			case '/':
+				ESC_FLUSH("\\/");
+			break;
+			case '\b':
+				ESC_FLUSH("\\b");
+			break;
+			case '\f':
+				ESC_FLUSH("\\f");
+			break;
+			case '\n':
+				ESC_FLUSH("\\n");
+			break;
+			case '\r':
+				ESC_FLUSH("\\r");
+			break;
+			case '\t':
+				ESC_FLUSH("\\t");
+			break;
+			default:
+				i += next_chsz;
+			}
+		} else {
+			i += next_chsz;
+		}
+	} while (next_chsz);
+
+	if (i) {
+		if (out(self, val, i))
+			return 1;
+	}
+
+	if (out_ch(self, '"'))
+		return 1;
+
+	return 0;
+}
+
+static int do_padd(ujson_writer *self)
+{
+	unsigned int i;
+
+	for (i = 0; i < self->depth; i++) {
+		if (out_ch(self, ' '))
+			return 1;
+	}
+
+	return 0;
+}
+
+static int newline(ujson_writer *self)
+{
+	if (out_ch(self, '\n'))
+		return 0;
+
+	if (do_padd(self))
+		return 1;
+
+	return 0;
+}
+
+static int add_common(ujson_writer *self, const char *id)
+{
+	if (is_err(self))
+		return 1;
+
+	if (!self->depth) {
+		err(self, "Object/Array has to be started first");
+		return 1;
+	}
+
+	if (in_arr(self)) {
+		if (id) {
+			err(self, "Array entries can't have id");
+			return 1;
+		}
+	} else {
+		if (!id) {
+			err(self, "Object entries must have id");
+			return 1;
+		}
+	}
+
+	if (!is_first(self) && out_ch(self, ','))
+		return 1;
+
+	if (self->depth && newline(self))
+		return 1;
+
+	if (id) {
+		if (out_esc_str(self, id))
+			return 1;
+
+		if (out_str(self, ": "))
+			return 1;
+	}
+
+	return 0;
+}
+
+int ujson_obj_start(ujson_writer *self, const char *id)
+{
+	if (self->depth >= UJSON_RECURSION_MAX)
+		return 1;
+
+	if (!self->depth && id) {
+		err(self, "Top level object cannot have id");
+		return 1;
+	}
+
+	if (self->depth && add_common(self, id))
+		return 1;
+
+	if (out_ch(self, '{'))
+		return 1;
+
+	set_depth_bit(self, 1);
+
+	return 0;
+}
+
+int ujson_obj_finish(ujson_writer *self)
+{
+	if (is_err(self))
+		return 1;
+
+	if (!in_obj(self)) {
+		err(self, "Not in object!");
+		return 1;
+	}
+
+	int first = is_first(self);
+
+	clear_depth_bit(self);
+
+	if (!first)
+		newline(self);
+
+	return out_ch(self, '}');
+}
+
+int ujson_arr_start(ujson_writer *self, const char *id)
+{
+	if (self->depth >= UJSON_RECURSION_MAX) {
+		err(self, "Recursion too deep");
+		return 1;
+	}
+
+	if (!self->depth && id) {
+		err(self, "Top level array cannot have id");
+		return 1;
+	}
+
+	if (self->depth && add_common(self, id))
+		return 1;
+
+	if (out_ch(self, '['))
+		return 1;
+
+	set_depth_bit(self, 0);
+
+	return 0;
+}
+
+int ujson_arr_finish(ujson_writer *self)
+{
+	if (is_err(self))
+		return 1;
+
+	if (!in_arr(self)) {
+		err(self, "Not in array!");
+		return 1;
+	}
+
+	int first = is_first(self);
+
+	clear_depth_bit(self);
+
+	if (!first)
+		newline(self);
+
+	return out_ch(self, ']');
+}
+
+int ujson_null_add(ujson_writer *self, const char *id)
+{
+	if (add_common(self, id))
+		return 1;
+
+	return out_str(self, "null");
+}
+
+int ujson_int_add(ujson_writer *self, const char *id, long val)
+{
+	char buf[64];
+
+	if (add_common(self, id))
+		return 1;
+
+	snprintf(buf, sizeof(buf), "%li", val);
+
+	return out_str(self, buf);
+}
+
+int ujson_bool_add(ujson_writer *self, const char *id, int val)
+{
+	if (add_common(self, id))
+		return 1;
+
+	if (val)
+		return out_str(self, "true");
+	else
+		return out_str(self, "false");
+}
+
+int ujson_str_add(ujson_writer *self, const char *id, const char *val)
+{
+	if (add_common(self, id))
+		return 1;
+
+	if (out_esc_str(self, val))
+		return 1;
+
+	return 0;
+}
+
+int ujson_float_add(ujson_writer *self, const char *id, double val)
+{
+	char buf[64];
+
+	if (add_common(self, id))
+		return 1;
+
+	snprintf(buf, sizeof(buf), "%lg", val);
+
+	return out_str(self, buf);
+}
+
+int ujson_writer_finish(ujson_writer *self)
+{
+	if (is_err(self))
+		goto err;
+
+	if (self->depth) {
+		err(self, "Objects and/or Arrays not finished");
+		goto err;
+	}
+
+	if (newline(self))
+		return 1;
+
+	return 0;
+err:
+	if (self->err_print)
+		self->err_print(self->err_print_priv, self->err);
+
+	return 1;
+}
+
+struct json_writer_file {
+	int fd;
+	size_t buf_used;
+	char buf[1024];
+};
+
+static int out_writer_file_write(ujson_writer *self, int fd, const char *buf, ssize_t buf_len)
+{
+	do {
+		ssize_t ret = write(fd, buf, buf_len);
+		if (ret <= 0) {
+			err(self, "Failed to write to a file");
+			return 1;
+		}
+
+		if (ret > buf_len) {
+			err(self, "Wrote more bytes than requested?!");
+			return 1;
+		}
+
+		buf_len -= ret;
+	} while (buf_len);
+
+	return 0;
+}
+
+static int out_writer_file(ujson_writer *self, const char *buf, size_t buf_len)
+{
+	struct json_writer_file *writer_file = self->out_priv;
+	size_t buf_size = sizeof(writer_file->buf);
+	size_t buf_avail = buf_size - writer_file->buf_used;
+
+	if (buf_len > buf_size/4)
+		return out_writer_file_write(self, writer_file->fd, buf, buf_len);
+
+	if (buf_len >= buf_avail) {
+		if (out_writer_file_write(self, writer_file->fd,
+		                          writer_file->buf, writer_file->buf_used))
+			return 1;
+
+		memcpy(writer_file->buf, buf, buf_len);
+		writer_file->buf_used = buf_len;
+		return 0;
+	}
+
+	memcpy(writer_file->buf + writer_file->buf_used, buf, buf_len);
+	writer_file->buf_used += buf_len;
+
+	return 0;
+}
+
+int ujson_writer_file_close(ujson_writer *self)
+{
+	struct json_writer_file *writer_file = self->out_priv;
+	int saved_errno = 0;
+
+	if (writer_file->buf_used) {
+		if (out_writer_file_write(self, writer_file->fd,
+		                          writer_file->buf, writer_file->buf_used))
+
+			saved_errno = errno;
+	}
+
+	if (close(writer_file->fd)) {
+		if (!saved_errno)
+			saved_errno = errno;
+	}
+
+	free(self);
+
+	if (saved_errno) {
+		errno = saved_errno;
+		return 1;
+	}
+
+	return 0;
+}
+
+ujson_writer *ujson_writer_file_open(const char *path)
+{
+	ujson_writer *ret;
+	struct json_writer_file *writer_file;
+
+	ret = malloc(sizeof(ujson_writer) + sizeof(struct json_writer_file));
+	if (!ret)
+		return NULL;
+
+	writer_file = (void*)ret + sizeof(ujson_writer);
+
+	writer_file->fd = open(path, O_CREAT | O_WRONLY | O_TRUNC, 0664);
+	if (!writer_file->fd) {
+		free(ret);
+		return NULL;
+	}
+
+	writer_file->buf_used = 0;
+
+	memset(ret, 0, sizeof(*ret));
+
+	ret->err_print = UJSON_ERR_PRINT;
+	ret->err_print_priv = UJSON_ERR_PRINT_PRIV;
+	ret->out = out_writer_file;
+	ret->out_priv = writer_file;
+
+	return ret;
+}
+
+
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
