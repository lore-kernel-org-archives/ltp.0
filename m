Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7094DC47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 20:46:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAFB23CE72C
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:46:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D720C3C810A
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6BE9B1A004F4
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 21:46:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F28981F831;
 Thu,  4 Jan 2024 20:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzgE5KKpe//ixbaxbxwC1HYPYiRmPdTxNWXRKFTzibY=;
 b=KAGiktU8ctHnP9hlha8yBYzRKPwmrEwH0HQ91TkI0I93GdKLOaMasboKbtBn3ws2K21B2j
 Lx/oTxsXGzw3m9WtnRGGRpnvuv73YdZollFQJp6jnatAY1yk7N27ubrq1Ws7eoouOhKrO7
 7bWfR9DIMDuAWUwD1rq5upkWDmyuJY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzgE5KKpe//ixbaxbxwC1HYPYiRmPdTxNWXRKFTzibY=;
 b=mIWrJtMiQzSoYWjAxgaDerx9/9DWorhxG7zrbJesh40vXxahojHQ7VRXfZpm+YY1GaSr4O
 YvaJxxr3COPFjaDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704401181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzgE5KKpe//ixbaxbxwC1HYPYiRmPdTxNWXRKFTzibY=;
 b=pP/hHICCcI/tUkUKfaMbI/0fOWRZwoqBy3O3OZ7hk27GMF045qamKz/9KFP8hk9ZW3uApF
 AoJ65l/ybdOWJKmzAQ0KZyIf6XywZiz0NzG5CW9OQxgMKhk5pIDJVttCsrvbok2CQx0rpi
 KMCEU6RVmybdnAqzKQxfR7oWdNxJNhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704401181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzgE5KKpe//ixbaxbxwC1HYPYiRmPdTxNWXRKFTzibY=;
 b=cX7hUTcXhNRm76I8cDKqC3kcAWIslpiTUXPB/0e0WaSn69QRgtCHCcgf6LxWZtJyeMMzT+
 DUK6olEZGoLYawAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D99C113C96;
 Thu,  4 Jan 2024 20:46:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mJ9DNB0Zl2WsIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 20:46:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 21:46:11 +0100
Message-ID: <20240104204614.1426027-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104204614.1426027-1-pvorel@suse.cz>
References: <20240104204614.1426027-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; URIBL_BLOCKED(0.00)[suse.cz:email];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[10.48%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/9] metaparse: Add missing blank line on the list
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

Correct list in JSON for correct HTML/PDFformatting via asciidoctor
requires extra space:

 * My CORRECT list (with extra blank line before first item):
 *
 * * foo2
 * * bar2

But people often forget to add it:

 * My BROKEN list (missing blank line before first item):
 * * foo
 * * bar

Therefore add this blank line to fix doc formatting.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 metadata/data_storage.h | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/metadata/data_storage.h b/metadata/data_storage.h
index 91ea70a02..0f4d42a13 100644
--- a/metadata/data_storage.h
+++ b/metadata/data_storage.h
@@ -7,9 +7,10 @@
 #define DATA_STORAGE_H__
 
 #include <stdarg.h>
+#include <stdbool.h>
 #include <stdio.h>
-#include <string.h>
 #include <stdlib.h>
+#include <string.h>
 
 enum data_type {
 	DATA_ARRAY,
@@ -275,6 +276,29 @@ static inline void data_node_print_(struct data_node *self, unsigned int padd)
 	}
 }
 
+static inline bool item_is_str_list_member(struct data_node *self)
+{
+	if (self->type != DATA_STRING)
+		return false;
+
+	return self->string.val[0] == '*' && self->string.val[1] == ' ';
+}
+
+static inline bool item_is_str_empty(struct data_node *self)
+{
+	if (self->type != DATA_STRING)
+		return false;
+
+	return !strlen(self->string.val);
+}
+
+static inline bool missing_space_for_list(struct data_node *cur, struct
+						data_node *prev)
+{
+	return item_is_str_list_member(cur) && !item_is_str_empty(prev) &&
+	    !item_is_str_list_member(prev);
+}
+
 static inline void data_node_print(struct data_node *self)
 {
 	printf("{\n");
@@ -357,6 +381,16 @@ static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int p
 	case DATA_ARRAY:
 		data_fprintf(f, do_padd ? padd : 0, "[\n");
 		for (i = 0; i < self->array.array_used; i++) {
+
+			if (i > 0 &&
+			    missing_space_for_list(self->array.array[i],
+						   self->array.array[i-1])) {
+				fprintf(stderr,
+					"%s:%d: WARNING: missing blank line before first list item, add it\n",
+					__FILE__, __LINE__);
+				data_fprintf(f, padd+1, "\"\",\n");
+			}
+
 			data_to_json_(self->array.array[i], f, padd+1, 1);
 			if (i < self->array.array_used - 1)
 				fprintf(f, ",\n");
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
