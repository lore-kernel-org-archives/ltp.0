Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD734C27C79
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 02:56:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D1E63D0BA9
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 04:56:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB80E3C006F
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 04:55:49 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=neilb@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B773F140075B
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 04:55:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CBEE620E49;
 Wed, 12 Jun 2024 02:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718160947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/btJp52x6H5kgv/jR8z+3XSQ/4SH6/WdXpxSMLKM3U=;
 b=HnBguCffpXlQE5lNoNrD1iAZCzOx7MKcBvU13zSgMPlBdzyXItj3sG317S71ShPfLLJVUS
 ygDf53cBGHafhqz4C3mcq9hDS+CujKgDEMit4EOF61ItG9zjqZC/yLFMLmP3lbPtYxRi1D
 YAe6/0TAJhbtOJ4DBxrHaoVAdle+Flw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718160947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/btJp52x6H5kgv/jR8z+3XSQ/4SH6/WdXpxSMLKM3U=;
 b=P+G7PaQI9wQ69zlBmPm3tK1W9z0tIcijUFV4TAu06akCknpdoUcjp7PrSe7Ua4W46plY/u
 qeva8bmxWc6UaZAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718160947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/btJp52x6H5kgv/jR8z+3XSQ/4SH6/WdXpxSMLKM3U=;
 b=HnBguCffpXlQE5lNoNrD1iAZCzOx7MKcBvU13zSgMPlBdzyXItj3sG317S71ShPfLLJVUS
 ygDf53cBGHafhqz4C3mcq9hDS+CujKgDEMit4EOF61ItG9zjqZC/yLFMLmP3lbPtYxRi1D
 YAe6/0TAJhbtOJ4DBxrHaoVAdle+Flw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718160947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/btJp52x6H5kgv/jR8z+3XSQ/4SH6/WdXpxSMLKM3U=;
 b=P+G7PaQI9wQ69zlBmPm3tK1W9z0tIcijUFV4TAu06akCknpdoUcjp7PrSe7Ua4W46plY/u
 qeva8bmxWc6UaZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FDDD137DF;
 Wed, 12 Jun 2024 02:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tv4oLS8OaWZPCgAAD6G6ig
 (envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 02:55:43 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
In-reply-to: <20240612023748.GG1629371@ZenIV>
References: <171815791109.14261.10223988071271993465@noble.neil.brown.name>,
 <20240612023748.GG1629371@ZenIV>
Date: Wed, 12 Jun 2024 12:55:40 +1000
Message-id: <171816094008.14261.10304380583720747013@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[kernel.org,suse.cz,gmail.com,arm.com,lists.linux.it,vger.kernel.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 12 Jun 2024, Al Viro wrote:
> On Wed, Jun 12, 2024 at 12:05:11PM +1000, NeilBrown wrote:
> 
> > For finish_open() there are three cases:
> >  - finish_open is used in ->atomic_open handlers.  For these we add a
> >    call to fsnotify_open() in do_open() if FMODE_OPENED is set - which
> >    means do_dentry_open() has been called. This happens after fsnotify_create().
> 
> 	Hummm....  There's a bit of behaviour change; in case we fail in
> may_open(), we used to get fsnotify_open()+fsnotify_close() and with that
> patch we's get fsnotify_close() alone.

True.  Presumably we could fix that by doing
diff --git a/fs/namei.c b/fs/namei.c
index 37fb0a8aa09a..6fd04c9046fa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3645,6 +3645,8 @@ static int do_open(struct nameidata *nd,
 			return error;
 		do_truncate = true;
 	}
+	if (file->f_mode & FMODE_OPENED)
+		fsnotify_open(file);
 	error = may_open(idmap, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
 		error = vfs_open(&nd->path, file);
@@ -3702,6 +3704,7 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
 	dput(child);
 	if (error)
 		return error;
+	fsnotify_open(file);
 	/* Don't check for other permissions, the inode was just created */
 	error = may_open(idmap, &file->f_path, 0, file->f_flags);
 	if (error)

instead, but it seems a little weird sending an OPEN notification if
may_open() fails.

> 
> 	IF we don't care about that, we might as well take fsnotify_open()
> out of vfs_open() and, for do_open()/do_tmpfile()/do_o_path(), into
> path_openat() itself.  I mean, having
>         if (likely(!error)) {
>                 if (likely(file->f_mode & FMODE_OPENED)) {
> 			fsnotify_open(file);
>                         return file;
> 		}
> in there would be a lot easier to follow...  It would lose fsnotify_open()
> in a few more failure exits, but if we don't give a damn about having it
> paired with fsnotify_close()...
> 

Should we have fsnotify_open() set a new ->f_mode flag, and
fsnotify_close() abort if it isn't set (and clear it if it is)?
Then we would be guaranteed a balance - which does seem like a good
idea.

Thanks,
NeilBrown


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
