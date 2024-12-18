Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5F9E77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:01:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B06653ED62B
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 20:01:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C2573ED633
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:52 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1F29622B5B3
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A75F721165;
 Wed, 18 Dec 2024 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u7H8uApi5otOLdvHzPwY/GMX6IVGhISbYK0KckFZB8Y=;
 b=uXPyo15ErilF28MVtIOnWUx6KOTsP5/0+VRFcakiRfzlutG7sWW1SlyV/FsfnGf0KKaOp2
 t/7vEEr69PJiF3kN6iN1upYv2yGCqsGa64hu886hf3wKsosTmXdaGKyWDWOAcMeQ4oTala
 1m6JUFqvsszpamlp1vq0D9F64HCe4EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u7H8uApi5otOLdvHzPwY/GMX6IVGhISbYK0KckFZB8Y=;
 b=YEvk77eo/nvOF5rfWZlyjI+vUG5C+n2qxwmI9AwS84IRtRTGU0UFq38kSOnPshhg6Xtx3a
 Bt6pSdhDK8JZRKCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u7H8uApi5otOLdvHzPwY/GMX6IVGhISbYK0KckFZB8Y=;
 b=uXPyo15ErilF28MVtIOnWUx6KOTsP5/0+VRFcakiRfzlutG7sWW1SlyV/FsfnGf0KKaOp2
 t/7vEEr69PJiF3kN6iN1upYv2yGCqsGa64hu886hf3wKsosTmXdaGKyWDWOAcMeQ4oTala
 1m6JUFqvsszpamlp1vq0D9F64HCe4EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548451;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u7H8uApi5otOLdvHzPwY/GMX6IVGhISbYK0KckFZB8Y=;
 b=YEvk77eo/nvOF5rfWZlyjI+vUG5C+n2qxwmI9AwS84IRtRTGU0UFq38kSOnPshhg6Xtx3a
 Bt6pSdhDK8JZRKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96B1A132EA;
 Wed, 18 Dec 2024 19:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id okm/I+MbY2fpdQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 19:00:51 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 20:00:25 +0100
Message-ID: <20241218190029.15015-6-chrubis@suse.cz>
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/9] metadata: data_storage: Add two array functions
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

- data_node_array_last() returns last element in an array or NULL if empty

- data_node_array_last_rem() removes and frees last element from an array

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/data_storage.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/metadata/data_storage.h b/metadata/data_storage.h
index e72be6187..6427ea1ed 100644
--- a/metadata/data_storage.h
+++ b/metadata/data_storage.h
@@ -251,6 +251,34 @@ static inline unsigned int data_node_array_len(struct data_node *self)
 	return self->array.array_used;
 }
 
+
+static inline struct data_node *data_node_array_last(struct data_node *self)
+{
+	if (self->type != DATA_ARRAY)
+		return NULL;
+
+	unsigned int array_used = self->array.array_used;
+	if (!array_used)
+		return NULL;
+
+	return self->array.array[array_used-1];
+}
+
+static inline void data_node_array_last_rem(struct data_node *self)
+{
+	if (self->type != DATA_ARRAY)
+		return;
+
+	unsigned int array_used = self->array.array_used;
+	if (!array_used)
+		return;
+
+	data_node_free(self->array.array[array_used-1]);
+
+	self->array.array[array_used-1] = NULL;
+	self->array.array_used--;
+}
+
 static inline void data_print_padd(unsigned int i)
 {
 	while (i-- > 0)
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
