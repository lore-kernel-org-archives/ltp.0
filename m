Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5417C433F5
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:48:28 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4F860F9D
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5F4F860F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CB293C2D1B
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 17:48:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0E3D3C02DA
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 17:47:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 722D11400E56
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 17:47:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F4CB1FD81
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634572036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6yvgLmca0D+DvWZGTQScZjVCefxKztz0ThtoSpuaRSY=;
 b=MyOLZ8v2qLvFcWQjvzzCUWE/1JkjeHONWI48DOF+B8E6dkcMsG7Hsw5Q6uswnDAGZ5isva
 ilv2dB17IxtTh6oD1OGwgZWyUFrpCmwrjLHA3ub6c253C+NdVdrzfcN1avA2bLiXL1jLrB
 5oYNe7HszjK8ST3gAvzWcT7jMwkDapE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634572036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6yvgLmca0D+DvWZGTQScZjVCefxKztz0ThtoSpuaRSY=;
 b=FItlebyhpSWXQdbt6Llo0Qw2xpcXOUaGtRokyGdgyuL5QMHIkqy2D8ucRRU4K93E77uzKD
 Y4DgufdQC12Ld1BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 581AC140B7
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:47:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4STDEwSXbWF0JwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:47:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 18 Oct 2021 17:47:55 +0200
Message-Id: <20211018154800.11013-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211018154800.11013-1-chrubis@suse.cz>
References: <20211018154800.11013-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/7] docparse: data_storage: Add integer type node
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
 docparse/data_storage.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/docparse/data_storage.h b/docparse/data_storage.h
index 339450c8b..117c1d127 100644
--- a/docparse/data_storage.h
+++ b/docparse/data_storage.h
@@ -15,6 +15,7 @@ enum data_type {
 	DATA_ARRAY,
 	DATA_HASH,
 	DATA_STRING,
+	DATA_INT,
 };
 
 struct data_node_array {
@@ -41,12 +42,18 @@ struct data_node_string {
 	char val[];
 };
 
+struct data_node_int {
+	enum data_type type;
+	long val;
+};
+
 struct data_node {
 	union {
 		enum data_type type;
 		struct data_node_hash hash;
 		struct data_node_array array;
 		struct data_node_string string;
+		struct data_node_int i;
 	};
 };
 
@@ -64,6 +71,19 @@ static inline struct data_node *data_node_string(const char *string)
 	return node;
 }
 
+static inline struct data_node *data_node_int(long i)
+{
+	struct data_node *node = malloc(sizeof(struct data_node_int));
+
+	if (!node)
+		return NULL;
+
+	node->type = DATA_INT;
+	node->i.val = i;
+
+	return node;
+}
+
 #define MAX_ELEMS 100
 
 static inline struct data_node *data_node_hash(void)
@@ -122,6 +142,7 @@ static inline void data_node_free(struct data_node *self)
 
 	switch (self->type) {
 	case DATA_STRING:
+	case DATA_INT:
 	break;
 	case DATA_HASH:
 		for (i = 0; i < self->hash.elems_used; i++) {
@@ -209,6 +230,10 @@ static inline void data_node_print_(struct data_node *self, unsigned int padd)
 	unsigned int i;
 
 	switch (self->type) {
+	case DATA_INT:
+		data_print_padd(padd);
+		printf("%li\n", self->i.val);
+	break;
 	case DATA_STRING:
 		data_print_padd(padd);
 		printf("'%s'\n", self->string.val);
@@ -295,6 +320,10 @@ static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int p
 	unsigned int i;
 
 	switch (self->type) {
+	case DATA_INT:
+		padd = do_padd ? padd : 0;
+		data_fprintf(f, padd, "%li", self->i.val);
+	break;
 	case DATA_STRING:
 		padd = do_padd ? padd : 0;
 		data_fprintf_esc(f, padd, self->string.val);
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
