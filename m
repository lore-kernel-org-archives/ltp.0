Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E622C71155
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 14:33:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D28C3CC104
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 16:33:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AE1D3CA1EF
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:33:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 85860600258
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:33:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B04101F74A
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750084391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ppJznMEV0/ihgibiyzvN9l/jIiMsVETb3mE4iUG1e74=;
 b=g6ap3I9wV83DDlIsEZD1Bp3AmTR/g0ye6I67tESDUhZLABjhbJqUlF/QIz/jITI4XUnlBJ
 qtnnFA+hEnx1q6M48LCSWtJNwTXfgrebxI2kbUGhFhnFs+abAWXn5Bj4LCqP0d371UJYJQ
 og0rA1BstINJvcQFj8qW7O/lHDPZzPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750084391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ppJznMEV0/ihgibiyzvN9l/jIiMsVETb3mE4iUG1e74=;
 b=DVANL+Fwv0R3W/pHOT+umRMq/+37LMbuWXqV1owv9NZuEVUJOftnPxGx05oidyLygXn0at
 0UvJnb9hUmwIT/CA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x5sYwne6;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="5xYzE/Bv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750084385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ppJznMEV0/ihgibiyzvN9l/jIiMsVETb3mE4iUG1e74=;
 b=x5sYwne6/r/EeMS6IBZdYx5LsZpxQwyDrNIBRtawtOQ5lYEt0yLSRUVi622v7Ss19U2uH6
 chKzHctvXxmo1ifqwEL9cBoZSfJwD/xGHOc6UceQglUoEGuq5fCLUUUDxUChH3+DzJ1MxR
 pFqmdVIANVqIiLaDOPphj30uQg0w9cY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750084385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ppJznMEV0/ihgibiyzvN9l/jIiMsVETb3mE4iUG1e74=;
 b=5xYzE/Bvk8fzXfiJCp3LA5cVyXJV56M21JrZJ7BvP47bIcfmwXkDCVWbvTCBf0sbxoGBcv
 v48qGMFSYyBG62Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91F8D13A6B
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 14:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +z2AIhwrUGisVAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 14:33:00 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 16 Jun 2025 16:33:36 +0200
Message-ID: <20250616143336.30881-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 ASN_FAIL(0.00)[7.9.0.0.4.6.0.0.0.5.1.0.0.1.0.0.4.0.1.0.1.8.2.b.0.4.e.d.7.0.a.2.asn6.rspamd.com:server
 fail]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:mid, suse.cz:email]
X-Rspamd-Queue-Id: B04101F74A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] [PATCH] syscalls: open12: Fix metadata export
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

Setting the .fs_type exilicitly to NULL makes it into the metadata and
later crashes the documentation generator. There is no point in setting
something to NULL in a global variable like this, so let's remove it.

Fixes: 26a59051d940 (open12: Convert to new API)
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---

I've dared to push this in order to fix the documentation build.

 testcases/kernel/syscalls/open/open12.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index 433eb700b..515e18cb1 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -190,7 +190,7 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.mntpoint = MNTPOINT,
 	.filesystems = (struct tst_fs[]){
-		{ .type = NULL, .mnt_flags = MS_STRICTATIME },
+		{ .mnt_flags = MS_STRICTATIME },
 		{}
 	}
 };
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
