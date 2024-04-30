Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE49C4345F
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 12:25:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 960603CB46B
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 14:25:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AACEC3CB23E
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:06 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1F0671000969
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFC341F7D7
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spcCpeH1gsuX8FKv1CZsWToPSV4ezHbmXmp+BA6oJ1Q=;
 b=p1dD4cUJ3Y8HS1rS3gwOjcC0WwLTSYRrBaCqaNxgsftKUeHUYK96Bek2hkYWJmCn//SPK7
 sSR4RjhqmNc3O9znaaEu9KQ6HfdA2hco8qyh66yrUzozlt/7Y318WiWCTlKjCi4EC2dTrm
 2lrLv5KP1Gur3D4eVHZtiE1Ar3h0TNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spcCpeH1gsuX8FKv1CZsWToPSV4ezHbmXmp+BA6oJ1Q=;
 b=emYEALKsJwsiSS42Yi4Yig5s4z8ACSOWDjZKQo0k2Wcw56NrnsoA/WHYlM3CVtKC3djOn6
 cP0O7eHk2iq5YrBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=p1dD4cUJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=emYEALKs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spcCpeH1gsuX8FKv1CZsWToPSV4ezHbmXmp+BA6oJ1Q=;
 b=p1dD4cUJ3Y8HS1rS3gwOjcC0WwLTSYRrBaCqaNxgsftKUeHUYK96Bek2hkYWJmCn//SPK7
 sSR4RjhqmNc3O9znaaEu9KQ6HfdA2hco8qyh66yrUzozlt/7Y318WiWCTlKjCi4EC2dTrm
 2lrLv5KP1Gur3D4eVHZtiE1Ar3h0TNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=spcCpeH1gsuX8FKv1CZsWToPSV4ezHbmXmp+BA6oJ1Q=;
 b=emYEALKsJwsiSS42Yi4Yig5s4z8ACSOWDjZKQo0k2Wcw56NrnsoA/WHYlM3CVtKC3djOn6
 cP0O7eHk2iq5YrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C590113A23
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YEweMKjiMGaQHAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Apr 2024 14:22:01 +0200
Message-ID: <20240430122208.13043-6-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430122208.13043-1-mdoucha@suse.cz>
References: <20240430122208.13043-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DFC341F7D7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.90 / 50.00]; BAYES_HAM(-2.89)[99.51%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/9] kvm_find_free_descriptor(): Skip descriptor 0
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

The GDT/LDT descriptor 0 should always be empty. Start search for free
descriptor table entry at index 1.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/lib_x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/kvm/lib_x86.c b/testcases/kernel/kvm/lib_x86.c
index 3e6656f11..1c0e629c3 100644
--- a/testcases/kernel/kvm/lib_x86.c
+++ b/testcases/kernel/kvm/lib_x86.c
@@ -174,7 +174,7 @@ int kvm_find_free_descriptor(const struct segment_descriptor *table,
 	const struct segment_descriptor *ptr;
 	size_t i;
 
-	for (i = 0, ptr = table; i < size; i++, ptr++) {
+	for (i = 1, ptr = table + 1; i < size; i++, ptr++) {
 		if (!(ptr->flags_lo & SEGFLAG_PRESENT))
 			return i;
 
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
