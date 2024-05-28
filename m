Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AF9C27C43
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 23:12:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF24A3D0620
	for <ltp@archiver.kernel.org>; Wed, 29 May 2024 01:12:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95CD33CFD28
 for <ltp@lists.linux.it>; Wed, 29 May 2024 01:11:49 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=neilb@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CE9611400BCA
 for <ltp@lists.linux.it>; Wed, 29 May 2024 01:11:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 798962048F;
 Tue, 28 May 2024 23:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716937907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d1xqmsHesKNSciEDfpS+I8mFJOg6lBIUMD8j40NmKSw=;
 b=g/NYpOVjbrdfn4O6dgStOLYbVgetLazT5DM1EJUCgpLbUysPZ7wBW+d4fvBgp+eXq6DNe7
 hFgT8lhXFyYBrJ6kohxi7LLPUjjJr3GhAvl6YE1WHABnyHtbO7pm8nN53Nptbc7LQ5fsc2
 PRvSlFkfGQYu47wbO9bcXTDno1OsKqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716937907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d1xqmsHesKNSciEDfpS+I8mFJOg6lBIUMD8j40NmKSw=;
 b=f3wWKC1PnTSwhP34GDnKLrZunQI2LVxxGgyCJ97xfSjDdR0BJbo25EeGOOZssZFJJMIZ8x
 3y1H3ozSRAWefPAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="g/NYpOVj";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=f3wWKC1P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716937907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d1xqmsHesKNSciEDfpS+I8mFJOg6lBIUMD8j40NmKSw=;
 b=g/NYpOVjbrdfn4O6dgStOLYbVgetLazT5DM1EJUCgpLbUysPZ7wBW+d4fvBgp+eXq6DNe7
 hFgT8lhXFyYBrJ6kohxi7LLPUjjJr3GhAvl6YE1WHABnyHtbO7pm8nN53Nptbc7LQ5fsc2
 PRvSlFkfGQYu47wbO9bcXTDno1OsKqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716937907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d1xqmsHesKNSciEDfpS+I8mFJOg6lBIUMD8j40NmKSw=;
 b=f3wWKC1PnTSwhP34GDnKLrZunQI2LVxxGgyCJ97xfSjDdR0BJbo25EeGOOZssZFJJMIZ8x
 3y1H3ozSRAWefPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CE4C13A6B;
 Tue, 28 May 2024 23:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bC15CLBkVmZsAgAAD6G6ig
 (envelope-from <neilb@suse.de>); Tue, 28 May 2024 23:11:44 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Date: Wed, 29 May 2024 09:11:36 +1000
Message-id: <171693789645.27191.13475059024941012614@noble.neil.brown.name>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 798962048F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] NFS: abort nfs_atomic_open_v23 if name is too long.
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
Cc: Aishwarya.TCV@arm.com, broonie@kernel.org, ltp@lists.linux.it,
 linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


An attempt to open a file with a name longer than NFS3_MAXNAMLEN will
trigger a WARN_ON_ONCE in encode_filename3() because
nfs_atomic_open_v23() doesn't have the test on ->d_name.len that
nfs_atomic_open() has.

So add that test.

Reported-by: James Clark <james.clark@arm.com>
Closes: https://lore.kernel.org/all/20240528105249.69200-1-james.clark@arm.com/
Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 342930996226..2b09b5416ef1 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2255,6 +2255,9 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 	 */
 	int error = 0;
 
+	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
+		return -ENAMETOOLONG;
+
 	if (open_flags & O_CREAT) {
 		file->f_mode |= FMODE_CREATED;
 		error = nfs_do_create(dir, dentry, mode, open_flags);
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
