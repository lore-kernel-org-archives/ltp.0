Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5839E77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:02:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60C443ED62C
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 20:02:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDBA23ED62B
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:54 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6641C63398B
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1EEA91F396;
 Wed, 18 Dec 2024 19:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OE16X8Q8zwz+kcshvMRsIuYHhGONAa7heFzqljPmBQU=;
 b=DDJT5L2Iytq4BSnv7u1UIVCTvB8O0RzR24sYS+MyrwwM+hOCgLOml/rtUr/pQgxmm166GA
 Qo79GwgamEe7ZUKs3B8e9ys1bUeHsH/ToyeKNrH6ilJ/BlWYlxz/5vLm+jae26xQiO74iy
 /8duY+3Vfs35lvFa266ji1OiFP2c4F0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548452;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OE16X8Q8zwz+kcshvMRsIuYHhGONAa7heFzqljPmBQU=;
 b=acgOLmExCAdRqGTfhfqlLwsg3Iz9Swoi/dm8zQup0iADiGq7hQoSKr6JAU1stEn6z/z94R
 WjI2xBrfW6xvSQCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OE16X8Q8zwz+kcshvMRsIuYHhGONAa7heFzqljPmBQU=;
 b=DDJT5L2Iytq4BSnv7u1UIVCTvB8O0RzR24sYS+MyrwwM+hOCgLOml/rtUr/pQgxmm166GA
 Qo79GwgamEe7ZUKs3B8e9ys1bUeHsH/ToyeKNrH6ilJ/BlWYlxz/5vLm+jae26xQiO74iy
 /8duY+3Vfs35lvFa266ji1OiFP2c4F0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548452;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OE16X8Q8zwz+kcshvMRsIuYHhGONAa7heFzqljPmBQU=;
 b=acgOLmExCAdRqGTfhfqlLwsg3Iz9Swoi/dm8zQup0iADiGq7hQoSKr6JAU1stEn6z/z94R
 WjI2xBrfW6xvSQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CDF1132EA;
 Wed, 18 Dec 2024 19:00:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id O9y7AeQbY2frdQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 19:00:52 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 20:00:26 +0100
Message-ID: <20241218190029.15015-7-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218190029.15015-1-chrubis@suse.cz>
References: <20241218190029.15015-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/9] metadata: metaparse: Better array parsing.
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

Changes the array parser to concatenate array mebers i.e. everything
between ',' is concatenated to a single string.

We also convert NULL in the middle anonymous structure initialization
into JSON null. With this the save_restore generates a proper arrays.

This fixes a few problems such as:

...
    "hugepages": [
-     "(",
-     "50",
-     "+"
-     "1",
-     ")",
-     "*",
-     "5",
+     "(50+1)*5",
      "TST_NEEDS"
     ],
...
    "save_restore": [
      [
       "PATH_OC_HPAGES",
+      null,
       "TST_SR_TCONF"
      ]
...

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/metaparse.c | 58 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 969293cfc..f133a65d6 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -336,9 +336,42 @@ static void try_apply_macro(char **res)
 	*res = ret->data;
 }
 
+static void finalize_array_entry(char **entry, struct data_node *node)
+{
+	if (!*entry)
+		return;
+
+	data_node_array_add(node, data_node_string(*entry));
+
+	free(*entry);
+	*entry = NULL;
+}
+
+static void str_append(char **res, char *append)
+{
+	char *cur_str = *res;
+
+	if (!cur_str) {
+		*res = strdup(append);
+		if (!*res)
+			goto err;
+		return;
+	}
+
+	if (asprintf(res, "%s%s", cur_str, append) < 0)
+		goto err;
+
+	free(cur_str);
+	return;
+err:
+	fprintf(stderr, "Allocation failed :(\n");
+	exit(1);
+}
+
 static int parse_array(FILE *f, struct data_node *node)
 {
 	char *token;
+	char *entry = NULL;
 
 	for (;;) {
 		if (!(token = next_token(f, NULL)))
@@ -356,20 +389,31 @@ static int parse_array(FILE *f, struct data_node *node)
 			continue;
 		}
 
-		if (!strcmp(token, "}"))
+		if (!strcmp(token, "}")) {
+			struct data_node *arr_last;
+
+			finalize_array_entry(&entry, node);
+
+			/* Remove NULL terminating entry, if present. */
+			arr_last = data_node_array_last(node);
+			if (arr_last && arr_last->type == DATA_NULL)
+				data_node_array_last_rem(node);
+
 			return 0;
+		}
 
-		if (!strcmp(token, ","))
+		if (!strcmp(token, ",")) {
+			finalize_array_entry(&entry, node);
 			continue;
+		}
 
-		if (!strcmp(token, "NULL"))
+		if (!strcmp(token, "NULL")) {
+			data_node_array_add(node, data_node_null());
 			continue;
+		}
 
 		try_apply_macro(&token);
-
-		struct data_node *str = data_node_string(token);
-
-		data_node_array_add(node, str);
+		str_append(&entry, token);
 	}
 
 	return 0;
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
