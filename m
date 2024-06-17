Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF8BC27C79
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 16:23:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B9973D0D46
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 18:23:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 471813CB74E
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 18:23:06 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AB85B201109
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 18:23:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5386560367;
 Mon, 17 Jun 2024 16:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718641384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZB7eOoCMV7x7IiFinUH42JUBc8zwI6Fg5a/YVdn+IY=;
 b=O/gz2haXD8RDrTv8AAbx4x9oXXhIKmAtusugHTonH36z7C/IvXrnk0xTN3Br+HOmBtktuL
 dmVngwJzk3BDRj7O+rGTvrPoNz9VsQ+TK3I6426QaRct0oufbQhlqaB30V9XAjMsVvwtgl
 FLMiPukrKH+7K+j04L/2SECq92/br1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718641384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZB7eOoCMV7x7IiFinUH42JUBc8zwI6Fg5a/YVdn+IY=;
 b=5HCDZ6pyjvV4plfm0n2O0tQ/TKmeH7E0jsucB2rlRr9rAyGSSztX7rsJUrydHqlLbad7za
 dLK0il9ogNwcfrDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="O/gz2haX";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5HCDZ6py
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718641384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZB7eOoCMV7x7IiFinUH42JUBc8zwI6Fg5a/YVdn+IY=;
 b=O/gz2haXD8RDrTv8AAbx4x9oXXhIKmAtusugHTonH36z7C/IvXrnk0xTN3Br+HOmBtktuL
 dmVngwJzk3BDRj7O+rGTvrPoNz9VsQ+TK3I6426QaRct0oufbQhlqaB30V9XAjMsVvwtgl
 FLMiPukrKH+7K+j04L/2SECq92/br1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718641384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZB7eOoCMV7x7IiFinUH42JUBc8zwI6Fg5a/YVdn+IY=;
 b=5HCDZ6pyjvV4plfm0n2O0tQ/TKmeH7E0jsucB2rlRr9rAyGSSztX7rsJUrydHqlLbad7za
 dLK0il9ogNwcfrDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42F0013AAF;
 Mon, 17 Jun 2024 16:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bXI2EOhicGaofAAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 16:23:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id DB2CFA082D; Mon, 17 Jun 2024 18:23:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Jun 2024 18:23:00 +0200
Message-Id: <20240617162303.1596-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617161828.6718-1-jack@suse.cz>
References: <20240617161828.6718-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=jack@suse.cz;
 h=from:subject; bh=xA0ilfoqBjlQha+Z+nsTK/5z/eR9E3y/WE0XMi+Zz1A=;
 b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmcGLk68vj9tfUAoonSEasAykuNKHolKvM5pfBaibj
 /fcwIOWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnBi5AAKCRCcnaoHP2RA2XOpCA
 CvQUZOkNXQYEA044iTceApzqdQwgYl+1eNhVohFdWlQIIv6oJLoF7xomqkJ1ZBmYU/6YnWwlPo13+8
 d9dx38dZ+wRknirraZVgxGFBMqDbZS4VXH9RvGU4l12/wVj7fHqbx2YprkjAA/H40jcehfw6tJGM0t
 xIT4X4+zU64ZmTBbQ8H0OzUWz4FCm+2ZnEyJLqDalSqtoXeyLk5XpqPEqcsZQvYGzhbWaSsL3JCHYt
 3MWsqXcacJujC56D9bpKSOw62YszON+2TvlgAJH7hr5Uu4GHAXpYm0tl6z+XQ4wDVavDtr/WMrsvPw
 xrsBCyUsXY8pEXgGpXziYTvyTJnd5A
X-Developer-Key: i=jack@suse.cz; a=openpgp;
 fpr=93C6099A142276A28BBE35D815BC833443038D8C
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_COUNT_THREE(0.00)[3];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,arm.com,suse.de,ZenIV.linux.org.uk,lists.linux.it,suse.cz];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5386560367
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] fsnotify: Do not generate events for O_PATH file
 descriptors
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
Cc: linux-nfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
 NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it,
 Al Viro <viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Currently we will not generate FS_OPEN events for O_PATH file
descriptors but we will generate FS_CLOSE events for them. This is
asymmetry is confusing. Arguably no fsnotify events should be generated
for O_PATH file descriptors as they cannot be used to access or modify
file content, they are just convenient handles to file objects like
paths. So fix the asymmetry by stopping to generate FS_CLOSE for O_PATH
file descriptors.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/fsnotify.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 4da80e92f804..278620e063ab 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -112,7 +112,13 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 {
 	const struct path *path;
 
-	if (file->f_mode & FMODE_NONOTIFY)
+	/*
+	 * FMODE_NONOTIFY are fds generated by fanotify itself which should not
+	 * generate new events. We also don't want to generate events for
+	 * FMODE_PATH fds (involves open & close events) as they are just
+	 * handle creation / destruction events and not "real" file events.
+	 */
+	if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
 		return 0;
 
 	path = &file->f_path;
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
