Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862D8606A31C
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=C27IEXrL;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fzj3Z+sy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0z6ekm/Z;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cERYtDQv
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71AF23EACBC
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 17:32:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCD613D07C7
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 17:31:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 05990600459
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 17:31:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1173722142
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 16:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794241918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vbbB6d8VJhH80ETUS9KYmsmxpiFsr1S+fp0jqctTnjs=;
 b=C27IEXrLQXWC2ufo1W8X+Bm0YNVjnkcVdeEIhrBXOdI4EpwkcYPvhJPzAdkMjTk9bAnNy5
 DCU1LasjOdegAQZhiT8dcTY+l7fDbRZWfkTKIkutsXYrcBfTVnQ33vLsjbgHIZN4jKe0kP
 FXIve/Yteug4O7UucV4h3+TOopoxB/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794241918;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vbbB6d8VJhH80ETUS9KYmsmxpiFsr1S+fp0jqctTnjs=;
 b=fzj3Z+syL4S4RTYGboLEP/BHHrV0ZH24vI0tg9gOwa4/kpBDSr310qXUuVuabzDIGMgwXX
 TONRYaadzMleviBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="0z6ekm/Z";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cERYtDQv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794241917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vbbB6d8VJhH80ETUS9KYmsmxpiFsr1S+fp0jqctTnjs=;
 b=0z6ekm/Za823X6vvtvfLtIIPOWTv5qI+cXGCBtDgZojxYqTNGksq/xJW9o/SgGr2GIWvqM
 7SYGIp+KqkV2spk8qA1Baptg0Qc366mvdFimGSRV4v+57Eg4Qt1v0Mwtf+IxeRJ0+dCVr+
 3vZ8HlMebQx4ekN94/ZwWHfG52xaE1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794241917;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vbbB6d8VJhH80ETUS9KYmsmxpiFsr1S+fp0jqctTnjs=;
 b=cERYtDQvy9Eu1HugsVkOOanMJ6OfxBSVxvT7a5jWEZbVl1GQeIDzuMKVxUFw+YXBY72/pC
 X4S10bIq2im2CJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCA7B13319
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 16:31:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Pl6BKXz18Wp5bAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 09 Nov 2026 16:31:56 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  9 Nov 2026 17:32:22 +0100
Message-ID: <20261109163222.1488772-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ucw.cz:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 1173722142
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: ujson: Update to ujson 1.0
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Update the bundled ujson library to ujson 1.0.

Includes the fixes send from Andrea + couple of more.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/ujson.h           |  6 +--
 include/ujson_common.h    |  8 ++--
 include/ujson_reader.h    | 14 +++---
 include/ujson_utf.h       | 14 +++---
 include/ujson_writer.h    |  2 +-
 libs/ujson/ujson_common.c |  1 +
 libs/ujson/ujson_reader.c | 97 ++++++++++++++++++++++++++-------------
 libs/ujson/ujson_writer.c | 62 +++++++++++++++++--------
 8 files changed, 132 insertions(+), 72 deletions(-)

diff --git a/include/ujson.h b/include/ujson.h
index 1a4bb6bd9..8faeb18f0 100644
--- a/include/ujson.h
+++ b/include/ujson.h
@@ -3,11 +3,11 @@
  * Copyright (C) 2021-2024 Cyril Hrubis <metan@ucw.cz>
  */
 
-#ifndef UJSON_H__
-#define UJSON_H__
+#ifndef UJSON_H
+#define UJSON_H
 
 #include <ujson_common.h>
 #include <ujson_reader.h>
 #include <ujson_writer.h>
 
-#endif /* UJSON_H__ */
+#endif /* UJSON_H */
diff --git a/include/ujson_common.h b/include/ujson_common.h
index 1eaf3fc72..ed31c090d 100644
--- a/include/ujson_common.h
+++ b/include/ujson_common.h
@@ -8,12 +8,12 @@
  * @brief Common JSON reader/writer definitions.
  */
 
-#ifndef UJSON_COMMON_H__
-#define UJSON_COMMON_H__
+#ifndef UJSON_COMMON_H
+#define UJSON_COMMON_H
 
 /** @brief Maximal error message length. */
 #define UJSON_ERR_MAX 128
-/** @brief Maximal id string length including terminating null element. */
+/** @brief Maximal id string lenght including terminating null element. */
 #define UJSON_ID_MAX 64
 /** @brief Maximal recursion depth allowed. */
 #define UJSON_RECURSION_MAX 128
@@ -66,4 +66,4 @@ typedef struct ujson_val ujson_val;
 /** @brief An array size macro. */
 #define UJSON_ARRAY_SIZE(array) (sizeof(array) / sizeof(*array))
 
-#endif /* UJSON_COMMON_H__ */
+#endif /* UJSON_COMMON_H */
diff --git a/include/ujson_reader.h b/include/ujson_reader.h
index 3722fffea..273fe624a 100644
--- a/include/ujson_reader.h
+++ b/include/ujson_reader.h
@@ -14,8 +14,8 @@
  * if error has happened at the end of the sequence.
  */
 
-#ifndef UJSON_READER_H__
-#define UJSON_READER_H__
+#ifndef UJSON_READER_H
+#define UJSON_READER_H
 
 #include <stdio.h>
 #include <ujson_common.h>
@@ -24,7 +24,7 @@
  * @brief An ujson_reader initializer with default values.
  *
  * @param buf A pointer to a buffer with JSON data.
- * @param buf_len A JSON data buffer length.
+ * @param buf_len A JSON data buffer lenght.
  * @param rflags enum ujson_reader_flags.
  *
  * @return An ujson_reader initialized with default values.
@@ -96,7 +96,7 @@ struct ujson_val {
 	 */
 	enum ujson_type type;
 
-	/** A user supplied buffer and size to store a string values to. */
+	/** An user supplied buffer and size to store a string values to. */
 	char *buf;
 	size_t buf_size;
 
@@ -108,7 +108,7 @@ struct ujson_val {
 	 */
 	size_t idx;
 
-	/** A union to store the parsed value into. */
+	/** An union to store the parsed value into. */
 	union {
 		/** @brief A boolean value. */
 		int val_bool;
@@ -311,7 +311,7 @@ static inline size_t ujson_obj_lookup(const ujson_obj *obj, const char *key)
 #define UJSON_OBJ_ATTR(keyv, typev) \
 	{.key = keyv, .type = typev}
 
-/** @brief An ujson_obj_attr initializer with an array index. */
+/** @brief An ujson_obj_attr intializer with an array index. */
 #define UJSON_OBJ_ATTR_IDX(key_idx, keyv, typev) \
 	[key_idx] = {.key = keyv, .type = typev}
 
@@ -540,4 +540,4 @@ static inline int ujson_reader_consumed(ujson_reader *self)
 	return self->off >= self->len;
 }
 
-#endif /* UJSON_H__ */
+#endif /* UJSON_H */
diff --git a/include/ujson_utf.h b/include/ujson_utf.h
index 83fe8ab09..1e3d47c0b 100644
--- a/include/ujson_utf.h
+++ b/include/ujson_utf.h
@@ -8,8 +8,8 @@
  * @brief Unicode helper macros and functions.
  */
 
-#ifndef UJSON_UTF_H__
-#define UJSON_UTF_H__
+#ifndef UJSON_UTF_H
+#define UJSON_UTF_H
 
 #include <stdint.h>
 #include <stddef.h>
@@ -65,15 +65,15 @@ static inline uint32_t ujson_utf8_next(const char **str)
 	if (UJSON_UTF8_IS_3BYTE(s0))
 		return (s0 & 0x0f)<<12 | s1<<6 | s2;
 
-	(*str)++;
-
 	uint32_t s3 = *str[0];
 
-	if (!UJSON_UTF8_IS_NBYTE(s2))
+	if (!UJSON_UTF8_IS_NBYTE(s3))
 		return 0;
 
 	s3 &= UJSON_UTF8_NBYTE_MASK;
 
+	(*str)++;
+
 	if (UJSON_UTF8_IS_4BYTE(s0))
 		return (s0 & 0x07)<<18 | s1<<12 | s2<<6 | s3;
 
@@ -130,7 +130,7 @@ static inline unsigned int ujson_utf8_bytes(uint32_t unicode)
 }
 
 /**
- * @brief Writes a Unicode character into a UTF-8 buffer.
+ * @brief Writes an unicode character into a UTF-8 buffer.
  *
  * The buffer _must_ be large enough!
  *
@@ -165,4 +165,4 @@ static inline int ujson_to_utf8(uint32_t unicode, char *buf)
 	return 4;
 }
 
-#endif /* UJSON_UTF_H__ */
+#endif /* UJSON_UTF_H */
diff --git a/include/ujson_writer.h b/include/ujson_writer.h
index 30d2e92f6..dfcc95053 100644
--- a/include/ujson_writer.h
+++ b/include/ujson_writer.h
@@ -46,7 +46,7 @@ struct ujson_writer {
  * @brief An ujson_writer initializer with default values.
  *
  * @param vout A pointer to function to write out the data.
- * @param vout_priv A user pointer passed to the out function.
+ * @param vout_priv An user pointer passed to the out function.
  *
  * @return An ujson_writer initialized with default values.
  */
diff --git a/libs/ujson/ujson_common.c b/libs/ujson/ujson_common.c
index 639955229..c9cada9a9 100644
--- a/libs/ujson/ujson_common.c
+++ b/libs/ujson/ujson_common.c
@@ -35,3 +35,4 @@ const char *ujson_type_name(enum ujson_type type)
 		return "invalid";
 	}
 }
+
diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
index 9f86f25b7..964878b51 100644
--- a/libs/ujson/ujson_reader.c
+++ b/libs/ujson/ujson_reader.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <stdarg.h>
 #include <stdint.h>
+#include <limits.h>
 
 #include "ujson_utf.h"
 #include "ujson_reader.h"
@@ -134,8 +135,36 @@ static unsigned int parse_ucode_esc(ujson_reader *buf, char *str,
 	if (ucode < 0)
 		return 0;
 
+	if (ucode >= 0xdc00 && ucode <= 0xdfff) {
+		ujson_err(buf, "Unpaired low surrogate");
+		return 0;
+	}
+
+	if (ucode >= 0xd800 && ucode <= 0xdbff) {
+		int32_t low;
+
+		if (peekb(buf) != '\\' || peekb_off(buf, 1) != 'u') {
+			ujson_err(buf, "Unpaired high surrogate");
+			return 0;
+		}
+
+		getb(buf);
+		getb(buf);
+
+		low = parse_ucode_cp(buf);
+		if (low < 0)
+			return 0;
+
+		if (low < 0xdc00 || low > 0xdfff) {
+			ujson_err(buf, "Invalid low surrogate in escape sequence");
+			return 0;
+		}
+
+		ucode = 0x10000 + (((ucode - 0xd800) << 10) | (low - 0xdc00));
+	}
+
 	if (!str)
-		return ucode;
+		return ujson_utf8_bytes(ucode);
 
 	if (ujson_utf8_bytes(ucode) + 1 >= len - off) {
 		ujson_err(buf, "String buffer too short!");
@@ -229,31 +258,15 @@ static int copy_str(ujson_reader *buf, char *str, size_t len)
 
 static int copy_id_str(ujson_reader *buf, char *str, size_t len)
 {
-	size_t pos = 0;
-
 	if (eatws(buf))
 		goto err0;
 
-	if (!eatb(buf, '"'))
+	if (peekb(buf) != '"')
 		goto err0;
 
-	for (;;) {
-		if (buf_empty(buf)) {
-			ujson_err(buf, "Unterminated ID string");
-			return 1;
-		}
-
-		if (eatb(buf, '"')) {
-			str[pos] = 0;
-			break;
-		}
-
-		if (pos >= len-1) {
-			ujson_err(buf, "ID string too long");
-			return 1;
-		}
-
-		str[pos++] = getb(buf);
+	if (copy_str(buf, str, len)) {
+		ujson_err(buf, "Unterminated ID string");
+		return 1;
 	}
 
 	if (eatws(buf))
@@ -283,7 +296,7 @@ static int is_digit(char b)
 
 static int get_int(ujson_reader *buf, struct ujson_val *res)
 {
-	long val = 0;
+	unsigned long val = 0;
 	int sign = 1;
 
 	if (eatb(buf, '-')) {
@@ -299,17 +312,28 @@ static int get_int(ujson_reader *buf, struct ujson_val *res)
 		return 1;
 	}
 
+	unsigned long max = LONG_MAX;
+
+	if (sign < 0)
+		max++;
+
 	while (is_digit(peekb(buf))) {
-		val *= 10;
-		val += getb(buf) - '0';
-		//TODO: overflow?
+		unsigned int d = getb(buf) - '0';
+
+		if (val > (max - d) / 10) {
+			ujson_err(buf, "Integer overflow");
+			return 1;
+		}
+
+		val = val * 10 + d;
 	}
 
 	if (sign < 0)
-		val = -val;
+		res->val_int = -(long)val;
+	else
+		res->val_int = (long)val;
 
-	res->val_int = val;
-	res->val_float = val;
+	res->val_float = res->val_int;
 
 	return 0;
 }
@@ -669,8 +693,10 @@ static int skip_obj_val(ujson_reader *buf)
 
 static int obj_next(ujson_reader *buf, struct ujson_val *res)
 {
-	if (copy_id_str(buf, res->id, sizeof(res->id)))
+	if (copy_id_str(buf, res->id, sizeof(res->id))) {
+		res->type = UJSON_VOID;
 		return 0;
+	}
 
 	return get_value(buf, res);
 }
@@ -695,8 +721,10 @@ static int obj_next_filter(ujson_reader *buf, struct ujson_val *res,
 	const struct ujson_obj_attr *attr;
 
 	for (;;) {
-		if (copy_id_str(buf, res->id, sizeof(res->id)))
+		if (copy_id_str(buf, res->id, sizeof(res->id))) {
+			res->type = UJSON_VOID;
 			return 0;
+		}
 
 		res->idx = obj ? ujson_obj_lookup(obj, res->id) : (size_t)-1;
 
@@ -1032,6 +1060,11 @@ ujson_reader *ujson_reader_load(const char *path)
 			goto err1;
 		}
 
+		if (res == 0) {
+			fprintf(stderr, "read() returned 0 (file was truncated?)\n");
+			goto err1;
+		}
+
 		off += res;
 	}
 
@@ -1047,9 +1080,9 @@ err0:
 
 void ujson_reader_finish(ujson_reader *self)
 {
-	if (ujson_reader_err(self))
+	if (ujson_reader_err(self)) {
 		ujson_err_print(self);
-	else if (!ujson_reader_consumed(self)) {
+	} else if (!ujson_reader_consumed(self)) {
 		ujson_warn(self, "Garbage after JSON string!");
 
 		if (ujson_reader_err(self))
diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
index c86a3b2af..214e20846 100644
--- a/libs/ujson/ujson_writer.c
+++ b/libs/ujson/ujson_writer.c
@@ -97,13 +97,6 @@ static inline int out_ch(ujson_writer *self, char ch)
 	return out(self, &ch, 1);
 }
 
-#define ESC_FLUSH(esc_char) do {\
-	out(self, val, i); \
-	val += i + 1; \
-	i = 0; \
-	out_str(self, esc_char); \
-} while (0)
-
 static inline int out_esc_str(ujson_writer *self, const char *val)
 {
 	if (out_ch(self, '"'))
@@ -116,32 +109,46 @@ static inline int out_esc_str(ujson_writer *self, const char *val)
 		next_chsz = ujson_utf8_next_chsz(val, i);
 
 		if (next_chsz == 1) {
+			char *esc_str = NULL;
+
 			switch (val[i]) {
 			case '\"':
-				ESC_FLUSH("\\\"");
+				esc_str = "\\\"";
 			break;
 			case '\\':
-				ESC_FLUSH("\\\\");
+				esc_str = "\\\\";
 			break;
 			case '/':
-				ESC_FLUSH("\\/");
+				esc_str = "\\/";
 			break;
 			case '\b':
-				ESC_FLUSH("\\b");
+				esc_str = "\\b";
 			break;
 			case '\f':
-				ESC_FLUSH("\\f");
+				esc_str = "\\f";
 			break;
 			case '\n':
-				ESC_FLUSH("\\n");
+				esc_str = "\\n";
 			break;
 			case '\r':
-				ESC_FLUSH("\\r");
+				esc_str = "\\r";
 			break;
 			case '\t':
-				ESC_FLUSH("\\t");
+				esc_str = "\\t";
 			break;
-			default:
+			}
+
+			/* flush buffer, write escape */
+			if (esc_str) {
+				if (out(self, val, i))
+					return 1;
+
+				val += i + 1;
+				i = 0;
+
+				if (out_str(self, esc_str))
+					return 1;
+			} else {
 				i += next_chsz;
 			}
 		} else {
@@ -389,15 +396,25 @@ struct json_writer_file {
 
 static int out_writer_file_write(ujson_writer *self, int fd, const char *buf, ssize_t buf_len)
 {
+	if (!buf_len)
+		return 0;
+
 	do {
 		ssize_t ret = write(fd, buf, buf_len);
-		if (ret <= 0) {
+		if (ret < 0) {
 			err(self, "Failed to write to a file");
 			return 1;
 		}
 
+		if (ret == 0) {
+			err(self, "The write() syscall returned 0");
+			errno = EAGAIN;
+			return 1;
+		}
+
 		if (ret > buf_len) {
 			err(self, "Wrote more bytes than requested?!");
+			errno = EIO;
 			return 1;
 		}
 
@@ -413,8 +430,15 @@ static int out_writer_file(ujson_writer *self, const char *buf, size_t buf_len)
 	size_t buf_size = sizeof(writer_file->buf);
 	size_t buf_avail = buf_size - writer_file->buf_used;
 
-	if (buf_len > buf_size/4)
+	if (buf_len > buf_size / 4) {
+		if (out_writer_file_write(self, writer_file->fd,
+					  writer_file->buf, writer_file->buf_used))
+			return 1;
+
+		writer_file->buf_used = 0;
+
 		return out_writer_file_write(self, writer_file->fd, buf, buf_len);
+	}
 
 	if (buf_len >= buf_avail) {
 		if (out_writer_file_write(self, writer_file->fd,
@@ -487,3 +511,5 @@ ujson_writer *ujson_writer_file_open(const char *path)
 
 	return ret;
 }
+
+
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
