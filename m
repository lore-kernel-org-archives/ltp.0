Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC99E77188
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:02:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D4D93ED621
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 20:02:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B57D3ED634
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:52 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3E0E21BCC65E
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E66C21164;
 Wed, 18 Dec 2024 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP5aytU/FrB2VwA4qe7mTtdr6zyKC26bEa7hMtFbIU8=;
 b=cD6HGsrdnUXHSYl/Hz+LajafQMkspM6g6Sw3xheZt6cbc/EoJPJhlsbZkiaLhDz7NY3Wul
 vMtqsJSp6zr4I+t5X7ehm96mq1iiJuofvzhese1ZNq+TLay+4+BbIkPyNhbylD2blijybs
 1H/5nvENxeaKXSZtuKYIaH8jnzURjpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP5aytU/FrB2VwA4qe7mTtdr6zyKC26bEa7hMtFbIU8=;
 b=gsyCOQs3/1mQsAXHFRZRf8zhzGKJ65D3jro3ynZ+xDf8n49mNClB+J3DVo/H0HovAbgOvj
 C4yt41NmIojC5uBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP5aytU/FrB2VwA4qe7mTtdr6zyKC26bEa7hMtFbIU8=;
 b=cD6HGsrdnUXHSYl/Hz+LajafQMkspM6g6Sw3xheZt6cbc/EoJPJhlsbZkiaLhDz7NY3Wul
 vMtqsJSp6zr4I+t5X7ehm96mq1iiJuofvzhese1ZNq+TLay+4+BbIkPyNhbylD2blijybs
 1H/5nvENxeaKXSZtuKYIaH8jnzURjpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JP5aytU/FrB2VwA4qe7mTtdr6zyKC26bEa7hMtFbIU8=;
 b=gsyCOQs3/1mQsAXHFRZRf8zhzGKJ65D3jro3ynZ+xDf8n49mNClB+J3DVo/H0HovAbgOvj
 C4yt41NmIojC5uBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BA81132EA;
 Wed, 18 Dec 2024 19:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U66XCeMbY2fndQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 19:00:51 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 20:00:24 +0100
Message-ID: <20241218190029.15015-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218190029.15015-1-chrubis@suse.cz>
References: <20241218190029.15015-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/9] metadata: data_storage: Add JSON null type
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/data_storage.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/metadata/data_storage.h b/metadata/data_storage.h
index 91ea70a02..e72be6187 100644
--- a/metadata/data_storage.h
+++ b/metadata/data_storage.h
@@ -16,6 +16,7 @@ enum data_type {
 	DATA_HASH,
 	DATA_STRING,
 	DATA_INT,
+	DATA_NULL,
 };
 
 struct data_node_array {
@@ -68,6 +69,8 @@ static inline const char* data_type_name(enum data_type type)
 		return "string";
 	case DATA_INT:
 		return "int";
+	case DATA_NULL:
+		return "null";
 	default:
 		return "???";
 	}
@@ -100,6 +103,18 @@ static inline struct data_node *data_node_int(long i)
 	return node;
 }
 
+static inline struct data_node *data_node_null(void)
+{
+	struct data_node *node = malloc(sizeof(struct data_node));
+
+	if (!node)
+		return NULL;
+
+	node->type = DATA_NULL;
+
+	return node;
+}
+
 #define MAX_ELEMS 100
 
 static inline struct data_node *data_node_hash(void)
@@ -159,6 +174,7 @@ static inline void data_node_free(struct data_node *self)
 	switch (self->type) {
 	case DATA_STRING:
 	case DATA_INT:
+	case DATA_NULL:
 	break;
 	case DATA_HASH:
 		for (i = 0; i < self->hash.elems_used; i++) {
@@ -254,6 +270,10 @@ static inline void data_node_print_(struct data_node *self, unsigned int padd)
 		data_print_padd(padd);
 		printf("'%s'\n", self->string.val);
 	break;
+	case DATA_NULL:
+		data_print_padd(padd);
+		printf("null\n");
+	break;
 	case DATA_HASH:
 		for (i = 0; i < self->hash.elems_used; i++) {
 			data_print_padd(padd);
@@ -297,7 +317,6 @@ static inline void data_fprintf(FILE *f, unsigned int padd, const char *fmt, ...
 	va_end(va);
 }
 
-
 static inline void data_fprintf_esc(FILE *f, unsigned int padd, const char *str)
 {
 	while (padd-- > 0)
@@ -344,6 +363,10 @@ static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int p
 		padd = do_padd ? padd : 0;
 		data_fprintf_esc(f, padd, self->string.val);
 	break;
+	case DATA_NULL:
+		padd = do_padd ? padd : 0;
+		data_fprintf(f, padd, "null");
+	break;
 	case DATA_HASH:
 		for (i = 0; i < self->hash.elems_used; i++) {
 			data_fprintf(f, padd, "\"%s\": ", self->hash.elems[i].id);
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
