Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00DEC71155
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 15:43:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 387393CC868
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 17:43:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03F873CC6F3
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 17:43:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 726A61400247
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 17:43:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 088281F390;
 Fri, 20 Jun 2025 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750434191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiHHFMMb9mGzulnO3Ir+Mtjps0yUAw/C4dI195/PK/w=;
 b=lDgAR4tKFl3R5Xz413yi7tZgTDSDCajaP+HoTqrE56ybHsB/e+pTQg5wi+APmdCJUPBeA9
 gFaSvLXSONpL9L19me5mF5hqSyuGOBldK4C+hUbRS1V1WcKgFW5xYrLJbkbMnRZ+7xRfag
 EjAKMgnVJcWxLUOgy3MnSjQUg5Ew0kg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750434191;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiHHFMMb9mGzulnO3Ir+Mtjps0yUAw/C4dI195/PK/w=;
 b=lTOqfgkp1OGWAZzJ/R+Nfac7hc10wa3HLPBqCzyL8e5i18yzhVIWDvcxkQ8zvYPmQLfBtv
 FSW8EZ7NOcTD+WDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QSp8ljGT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jKK+BEBz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750434190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiHHFMMb9mGzulnO3Ir+Mtjps0yUAw/C4dI195/PK/w=;
 b=QSp8ljGTN1sNnJ7LGVaAEbczqeTEgr3yQAxCogAnCXpt0rfl8SfmXi4aERSQpFkkEIuwLY
 3ABPHYoICSh8se28AV4bKVA1r38oPUMvyCYIJ/aNtRM8vP9Vu+TrULdb0ZyE7oVCOxNGkd
 0KKuHRboWNIz6RknQQrMlLV4RDe8oaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750434190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiHHFMMb9mGzulnO3Ir+Mtjps0yUAw/C4dI195/PK/w=;
 b=jKK+BEBzoBIifUzZ1bOfl/+pjTCc8TnwpX3Zb2rU5kp8qoRwFc9w/42KGTOomAKFWbKmS4
 N6e4gzBcRig8rwCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDAD813736;
 Fri, 20 Jun 2025 15:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CuXmOI2BVWjOYwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Jun 2025 15:43:09 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 20 Jun 2025 17:43:46 +0200
Message-ID: <20250620154346.19864-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620154346.19864-1-chrubis@suse.cz>
References: <20250620154346.19864-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 088281F390
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] metaparse: Map arrays with designated
 initializers to JSON objects
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

The parser now scans array declarations and if it finds out that
complete initialization is using designated initializers the result is
mapped into a JSON object instead of an arrray.

A diff snippet looks like:

--------------------------
    "filesystems": [
-    [
-     ".type=btrfs"
-    ],
-    [
-     ".type=bcachefs"
-    ],
-    [
-     ".type=xfs",
-     ".min_kver=4.16",
-     ".mkfs_ver=mkfs.xfs >= 1.5.0",
-     [
+    {
+     "type": "btrfs"
+    },
+    {
+     "type": "bcachefs"
+    },
+    {
+     "type": "xfs",
+     "min_kver": "4.16",
+     "mkfs_ver": "mkfs.xfs >= 1.5.0",
+     "mkfs_opts": [
       "-m",
       "reflink=1"
-     ],
-     ".mkfs_opts=(constchar*const[])"
-    ]
+     ]
+    }
    ],
--------------------------

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/data_storage.h |  20 ++++++
 metadata/metaparse.c    | 134 +++++++++++++++++++++++++++++++++-------
 2 files changed, 131 insertions(+), 23 deletions(-)

diff --git a/metadata/data_storage.h b/metadata/data_storage.h
index f837feec8..6ca5d7d90 100644
--- a/metadata/data_storage.h
+++ b/metadata/data_storage.h
@@ -10,6 +10,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
+#include <stdbool.h>
 
 enum data_type {
 	DATA_ARRAY,
@@ -228,6 +229,13 @@ static inline struct data_node *data_node_hash_get(struct data_node *self, const
 	return hash->elems[i].node;
 }
 
+static inline unsigned int data_node_hash_len(struct data_node *self)
+{
+	struct data_node_hash *hash = &self->hash;
+
+	return hash->elems_used;
+}
+
 static inline int data_node_array_add(struct data_node *self, struct data_node *payload)
 {
 	if (self->type != DATA_ARRAY)
@@ -285,6 +293,18 @@ static inline void data_print_padd(unsigned int i)
 		putchar(' ');
 }
 
+static inline bool data_node_is_empty(struct data_node *self)
+{
+	switch (self->type) {
+	case DATA_ARRAY:
+		return data_node_array_len(self) == 0;
+	case DATA_HASH:
+		return data_node_hash_len(self) == 0;
+	default:
+		return false;
+	}
+}
+
 static inline void data_node_print_(struct data_node *self, unsigned int padd)
 {
 	unsigned int i;
diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 9723a92c2..e9e9aee10 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -337,15 +337,20 @@ static void try_apply_macro(char **res)
 	*res = ret->data;
 }
 
-static void finalize_array_entry(char **entry, struct data_node *node)
+static void finalize_array_entry(char **val, char **id, struct data_node *node)
 {
-	if (!*entry)
+	if (!*val)
 		return;
 
-	data_node_array_add(node, data_node_string(*entry));
+	if (*id)
+		data_node_hash_add(node, *id+1, data_node_string(*val));
+	else
+		data_node_array_add(node, data_node_string(*val));
 
-	free(*entry);
-	*entry = NULL;
+	free(*id);
+	free(*val);
+	*id = NULL;
+	*val = NULL;
 }
 
 static void str_append(char **res, char *append)
@@ -369,24 +374,98 @@ err:
 	exit(1);
 }
 
-static int parse_array(FILE *f, struct data_node *node)
+static int array_is_hash(FILE *f)
 {
+	long pos = ftell(f);
+	int has_ids = 1;
+	int elem_seen = 0;
+	int in_id = 1;
 	char *token;
-	char *entry = NULL;
+
+	while ((token = next_token(f, NULL))) {
+
+		if (!strcmp(token, "}"))
+			goto ret;
+
+		elem_seen = 1;
+
+		if (!strcmp(token, "{")) {
+			if (in_id) {
+				has_ids = 0;
+				goto ret;
+			}
+
+			int level = 1;
+
+			for (;;) {
+				token = next_token(f, NULL);
+
+				if (!token)
+					goto ret;
+
+				if (!strcmp(token, "{"))
+					level++;
+
+				if (!strcmp(token, "}"))
+					level--;
+
+				if (!level)
+					break;
+			}
+		} else if (!strcmp(token, ",")) {
+			if (in_id) {
+				has_ids = 0;
+				goto ret;
+			}
+
+			in_id = 1;
+		} else if (!strcmp(token, "=")) {
+			in_id = 0;
+		}
+	}
+
+ret:
+	fseek(f, pos, SEEK_SET);
+	return elem_seen && has_ids;
+}
+
+static int parse_array(FILE *f, const char *arr_id, struct data_node **ret)
+{
+	char *token;
+	char *val = NULL, *id = NULL;
 	int parent_cnt = 0;
+	int is_hash = array_is_hash(f);
+
+	if (verbose)
+		fprintf(stderr, "PARSING ARRAY (%s) is_hash = %i\n", arr_id, is_hash);
+
+	if (is_hash)
+		*ret = data_node_hash();
+	else
+		*ret = data_node_array();
 
 	for (;;) {
 		if (!(token = next_token(f, NULL)))
 			return 1;
 
 		if (!strcmp(token, "{")) {
-			struct data_node *ret = data_node_array();
-			parse_array(f, ret);
+			struct data_node *sub_ret;
 
-			if (data_node_array_len(ret))
-				data_node_array_add(node, ret);
-			else
-				data_node_free(ret);
+			parse_array(f, id, &sub_ret);
+
+			if (data_node_is_empty(sub_ret)) {
+				data_node_free(sub_ret);
+			} else {
+				if (is_hash)
+					data_node_hash_add(*ret, id+1, sub_ret);
+				else
+					data_node_array_add(*ret, sub_ret);
+			}
+
+			free(id);
+			id = NULL;
+			free(val);
+			val = NULL;
 
 			continue;
 		}
@@ -394,23 +473,33 @@ static int parse_array(FILE *f, struct data_node *node)
 		if (!strcmp(token, "}")) {
 			struct data_node *arr_last;
 
-			finalize_array_entry(&entry, node);
-
+			finalize_array_entry(&val, &id, *ret);
 			/* Remove NULL terminating entry, if present. */
-			arr_last = data_node_array_last(node);
-			if (arr_last && arr_last->type == DATA_NULL)
-				data_node_array_last_rem(node);
+			if (!is_hash) {
+				arr_last = data_node_array_last(*ret);
+				if (arr_last && arr_last->type == DATA_NULL)
+					data_node_array_last_rem(*ret);
+			}
 
 			return 0;
 		}
 
+		if (is_hash && !strcmp(token, "=") && !id) {
+			id = val;
+			val = NULL;
+			continue;
+		}
+
 		if (!strcmp(token, ",") && parent_cnt <= 0) {
-			finalize_array_entry(&entry, node);
+			finalize_array_entry(&val, &id, *ret);
 			continue;
 		}
 
 		if (!strcmp(token, "NULL")) {
-			data_node_array_add(node, data_node_null());
+			if (is_hash)
+				data_node_hash_add(*ret, id, data_node_null());
+			else
+				data_node_array_add(*ret, data_node_null());
 			continue;
 		}
 
@@ -421,7 +510,7 @@ static int parse_array(FILE *f, struct data_node *node)
 			parent_cnt--;
 
 		try_apply_macro(&token);
-		str_append(&entry, token);
+		str_append(&val, token);
 	}
 
 	return 0;
@@ -605,8 +694,7 @@ static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *n
 		}
 
 		if (!strcmp(token, "{")) {
-			ret = data_node_array();
-			parse_array(f, ret);
+			parse_array(f, id, &ret);
 		} else if (!strcmp(token, "ARRAY_SIZE")) {
 			if (parse_array_size(f, &ret))
 				return 1;
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
