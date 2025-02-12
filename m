Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7900AC02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 13:16:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874123C9A3F
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 14:16:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D00983C66BB
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 14:16:15 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 683A9101D8E4
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 14:16:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 628571FE1A
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739366174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2VplGZ9WbPSi0KzoLvwn6D352lkWoSSQ8ymB0my4Z0=;
 b=VcI4wljCjgQrZ+C9D4nupeUG0VZ5Z7CDq1bktjgn4I6Dh618LIGjROtQvhcEwMLBm+S2L8
 nnSgTbLQk/kMwAh02X7JwgviHVvO0vOW6knYmxNxVMGJhrq3R52FFXSINGELhHwARmrK2Z
 BDhYd5Rq1aqDMmaEm3pYlN3e0Fpv00k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739366174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2VplGZ9WbPSi0KzoLvwn6D352lkWoSSQ8ymB0my4Z0=;
 b=LmoA1hDD24KY0uVcO+/m7tCAnjiBz2aIhHNcovqeVhwoiSR+EmBUX5p4sg65o8cOau2aoG
 6JwjNr+alwqBVvBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VcI4wljC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LmoA1hDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739366174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2VplGZ9WbPSi0KzoLvwn6D352lkWoSSQ8ymB0my4Z0=;
 b=VcI4wljCjgQrZ+C9D4nupeUG0VZ5Z7CDq1bktjgn4I6Dh618LIGjROtQvhcEwMLBm+S2L8
 nnSgTbLQk/kMwAh02X7JwgviHVvO0vOW6knYmxNxVMGJhrq3R52FFXSINGELhHwARmrK2Z
 BDhYd5Rq1aqDMmaEm3pYlN3e0Fpv00k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739366174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2VplGZ9WbPSi0KzoLvwn6D352lkWoSSQ8ymB0my4Z0=;
 b=LmoA1hDD24KY0uVcO+/m7tCAnjiBz2aIhHNcovqeVhwoiSR+EmBUX5p4sg65o8cOau2aoG
 6JwjNr+alwqBVvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48A7C13AEF
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Dsg1EB6frGcVGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 13:16:14 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Feb 2025 14:16:18 +0100
Message-ID: <20250212131618.6810-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250212131618.6810-1-chrubis@suse.cz>
References: <20250212131618.6810-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 628571FE1A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] metaparse: data_storage: Fix warning
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

Make data_node_hash_get static inline in order to avoid unused warnings.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/data_storage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/metadata/data_storage.h b/metadata/data_storage.h
index 6427ea1ed..82d67b829 100644
--- a/metadata/data_storage.h
+++ b/metadata/data_storage.h
@@ -212,7 +212,7 @@ static inline int data_node_hash_del(struct data_node *self, const char *id)
 	return 1;
 }
 
-static struct data_node *data_node_hash_get(struct data_node *self, const char *id)
+static inline struct data_node *data_node_hash_get(struct data_node *self, const char *id)
 {
 	unsigned int i;
 	struct data_node_hash *hash = &self->hash;
-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
