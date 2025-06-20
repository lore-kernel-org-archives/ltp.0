Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DEBC7115C
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 15:44:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C28F3CC8D4
	for <ltp@archiver.kernel.org>; Fri, 20 Jun 2025 17:44:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0626C3CC8CD
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 17:43:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 618DB600798
 for <ltp@lists.linux.it>; Fri, 20 Jun 2025 17:43:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9731F2124D;
 Fri, 20 Jun 2025 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750434189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=INpGD5gMlnSs3sr2Iwh2LC60IKMqwl1o8nCAqzfU3lA=;
 b=ET/sHCCZZvsPdqcFUipeKlb6N/t6E5L8KjSYRkqh1Pq0ZfvIGzAfU6A/LggnGThNX4czQ4
 Udp5Gi6xfbb/ewCM8U0s/GBlOdGqSf7mB+zstlirzJ0+yxrrlZTiVc8ewWT+Atvm724kO7
 c3TcIFrskuAaeaAKBy8TfWMpMqwNYSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750434189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=INpGD5gMlnSs3sr2Iwh2LC60IKMqwl1o8nCAqzfU3lA=;
 b=JZWgBQdsS9GmmXfWGL8yDa/uL7H1APEJtOV50E2pggdR/03URygQp676WyaE08jsWUPG6X
 L6kS66isbVT5WmAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750434189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=INpGD5gMlnSs3sr2Iwh2LC60IKMqwl1o8nCAqzfU3lA=;
 b=ET/sHCCZZvsPdqcFUipeKlb6N/t6E5L8KjSYRkqh1Pq0ZfvIGzAfU6A/LggnGThNX4czQ4
 Udp5Gi6xfbb/ewCM8U0s/GBlOdGqSf7mB+zstlirzJ0+yxrrlZTiVc8ewWT+Atvm724kO7
 c3TcIFrskuAaeaAKBy8TfWMpMqwNYSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750434189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=INpGD5gMlnSs3sr2Iwh2LC60IKMqwl1o8nCAqzfU3lA=;
 b=JZWgBQdsS9GmmXfWGL8yDa/uL7H1APEJtOV50E2pggdR/03URygQp676WyaE08jsWUPG6X
 L6kS66isbVT5WmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8676313736;
 Fri, 20 Jun 2025 15:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ocKYH42BVWjLYwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Jun 2025 15:43:09 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 20 Jun 2025 17:43:45 +0200
Message-ID: <20250620154346.19864-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620154346.19864-1-chrubis@suse.cz>
References: <20250620154346.19864-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] metadata: data_storage: Fix hash to json object
 serialization
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

We have to move the curly braces into the switch() that prints the JSON
values otherwise inner object will not have curly braces around them and
the resulting JSON is not valid.

The changes between the old generated metadata and new metadata are only
in the whitespaces:

diff -w ltp-prev.json ltp.json
7c7
<   "version": "20250530-41-g080ced081"
---
>   "version": "20250530-42-g73a97b583"

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/data_storage.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/metadata/data_storage.h b/metadata/data_storage.h
index 82d67b829..f837feec8 100644
--- a/metadata/data_storage.h
+++ b/metadata/data_storage.h
@@ -396,14 +396,16 @@ static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int p
 		data_fprintf(f, padd, "null");
 	break;
 	case DATA_HASH:
+		data_fprintf(f, do_padd ? padd : 0, "{\n");
 		for (i = 0; i < self->hash.elems_used; i++) {
-			data_fprintf(f, padd, "\"%s\": ", self->hash.elems[i].id);
+			data_fprintf(f, padd+1, "\"%s\": ", self->hash.elems[i].id);
 			data_to_json_(self->hash.elems[i].node, f, padd+1, 0);
 			if (i < self->hash.elems_used - 1)
 				fprintf(f, ",\n");
 			else
 				fprintf(f, "\n");
 		}
+		data_fprintf(f, padd, "}");
 	break;
 	case DATA_ARRAY:
 		data_fprintf(f, do_padd ? padd : 0, "[\n");
@@ -421,9 +423,7 @@ static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int p
 
 static inline void data_to_json(struct data_node *self, FILE *f, unsigned int padd)
 {
-	fprintf(f, "{\n");
-	data_to_json_(self, f, padd + 1, 1);
-	data_fprintf(f, padd, "}");
+	data_to_json_(self, f, padd, 0);
 }
 
 #endif /* DATA_STORAGE_H__ */
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
