Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682D6D3EE64
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 13:20:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CFE63CB5C4
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 14:20:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 157FC3CB5A3
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 14:19:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8D0831000655
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 14:19:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A3B5C5BCCA
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769087983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jd6J248I8osBPF7R6VjUEIQXQbm5r+/jE/93m5DI6ZU=;
 b=0vSnEiEmiXIQbDl0qcBSZAM5sQeDQzlK9i2ZYohmMMoQoPBIXTIHt38F8xhoL4E3qMIiWi
 P8OEpNE3Wn4MDtjpRzsvv9gu2SUF0TnjPjqAGHpziKStWxG2AgF7SNwB0P4v/wPSIZS72W
 zAEvDqW17hWLCZK7tpXAebsxfuvDGs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769087983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jd6J248I8osBPF7R6VjUEIQXQbm5r+/jE/93m5DI6ZU=;
 b=ee1BSF3DS/7hAStWvbe6S0jR0iXAUU0ETvm6gzhIh5qNDVDbXY1sLyuK4DsC63E7q1eU9w
 OMYZEAuEUzZUH6Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769087982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jd6J248I8osBPF7R6VjUEIQXQbm5r+/jE/93m5DI6ZU=;
 b=ivl2MDOMLXNbkhLkiArK/IiwB4iBEC2mPRSYzDZHUT9mUBBkIgc4BlSwtyC8SaqUy1dYwb
 FZmH1kcULFTusNYiscE1+HbpDSMQXhfWUStKUyr3BYrig9Tq+sbv/7ISI7Xra66Ov85B1W
 B5Glo+MXRWtJ6ebBG9ikOYdWAqOL4v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769087982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jd6J248I8osBPF7R6VjUEIQXQbm5r+/jE/93m5DI6ZU=;
 b=V9TPL7zuePGk1BDaccqjm5dDHbFbD4YVz5oO2zdqD86ZytfRTrx7MSbAzjCxLqcuY41Mvh
 UzZg7iO6NyxyK5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AF1B1395E
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id seEFIe4jcmmbOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:19:42 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 22 Jan 2026 14:20:57 +0100
Message-ID: <20260122132059.24503-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122132059.24503-1-chrubis@suse.cz>
References: <20260122132059.24503-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] metaparse: data_storage: Add bool type
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
 metadata/data_storage.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/metadata/data_storage.h b/metadata/data_storage.h
index 6ca5d7d90..77073f37d 100644
--- a/metadata/data_storage.h
+++ b/metadata/data_storage.h
@@ -17,6 +17,7 @@ enum data_type {
 	DATA_HASH,
 	DATA_STRING,
 	DATA_INT,
+	DATA_BOOL,
 	DATA_NULL,
 };
 
@@ -49,6 +50,11 @@ struct data_node_int {
 	long val;
 };
 
+struct data_node_bool {
+	enum data_type type;
+	bool val;
+};
+
 struct data_node {
 	union {
 		enum data_type type;
@@ -56,6 +62,7 @@ struct data_node {
 		struct data_node_array array;
 		struct data_node_string string;
 		struct data_node_int i;
+		struct data_node_bool b;
 	};
 };
 
@@ -70,6 +77,8 @@ static inline const char* data_type_name(enum data_type type)
 		return "string";
 	case DATA_INT:
 		return "int";
+	case DATA_BOOL:
+		return "bool";
 	case DATA_NULL:
 		return "null";
 	default:
@@ -104,6 +113,19 @@ static inline struct data_node *data_node_int(long i)
 	return node;
 }
 
+static inline struct data_node *data_node_bool(bool b)
+{
+	struct data_node *node = malloc(sizeof(struct data_node_int));
+
+	if (!node)
+		return NULL;
+
+	node->type = DATA_BOOL;
+	node->b.val = b;
+
+	return node;
+}
+
 static inline struct data_node *data_node_null(void)
 {
 	struct data_node *node = malloc(sizeof(struct data_node));
@@ -175,6 +197,7 @@ static inline void data_node_free(struct data_node *self)
 	switch (self->type) {
 	case DATA_STRING:
 	case DATA_INT:
+	case DATA_BOOL:
 	case DATA_NULL:
 	break;
 	case DATA_HASH:
@@ -314,6 +337,10 @@ static inline void data_node_print_(struct data_node *self, unsigned int padd)
 		data_print_padd(padd);
 		printf("%li\n", self->i.val);
 	break;
+	case DATA_BOOL:
+		data_print_padd(padd);
+		printf("%s\n", self->b.val ? "true" : "false");
+	break;
 	case DATA_STRING:
 		data_print_padd(padd);
 		printf("'%s'\n", self->string.val);
@@ -407,6 +434,10 @@ static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int p
 		padd = do_padd ? padd : 0;
 		data_fprintf(f, padd, "%li", self->i.val);
 	break;
+	case DATA_BOOL:
+		padd = do_padd ? padd : 0;
+		data_fprintf(f, padd, "%s", self->b.val ? "true" : "false");
+	break;
 	case DATA_STRING:
 		padd = do_padd ? padd : 0;
 		data_fprintf_esc(f, padd, self->string.val);
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
