Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F18AD2ECF7
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 10:00:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C2BC3CAF08
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 11:00:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6184B3C4F45
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 10:59:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CCACC600145
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 10:59:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4C8A8337C6;
 Tue, 20 Jan 2026 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768903187;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEXjVLwmt38RaP3fliXYyB52663Cx/mTV/H6WVD4j3g=;
 b=EE3sTlO6ipNlHQE7T+yR7Ci7xyJJSUFOcPeH7pbD/c4dqnIzlm2mRZQfNXvcsNljgGNtR4
 tD4TqbgZmaiz320lh8x7er94Z56WbgMJJR8KVAwya9UgrfZEeqNAhFKGvQ2vJC7uFhTLMg
 7X75ucO0xzRyYheTGe5HpXpffEpPSnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768903187;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEXjVLwmt38RaP3fliXYyB52663Cx/mTV/H6WVD4j3g=;
 b=fKik/xBTiEKZhMwGpJYs3QEn699czStg48kaPDP/fsV+2FvXogCtoDdKWS+OD3ApwypcAy
 wdQSoNarArSWAvAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EE3sTlO6;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="fKik/xBT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768903187;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEXjVLwmt38RaP3fliXYyB52663Cx/mTV/H6WVD4j3g=;
 b=EE3sTlO6ipNlHQE7T+yR7Ci7xyJJSUFOcPeH7pbD/c4dqnIzlm2mRZQfNXvcsNljgGNtR4
 tD4TqbgZmaiz320lh8x7er94Z56WbgMJJR8KVAwya9UgrfZEeqNAhFKGvQ2vJC7uFhTLMg
 7X75ucO0xzRyYheTGe5HpXpffEpPSnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768903187;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEXjVLwmt38RaP3fliXYyB52663Cx/mTV/H6WVD4j3g=;
 b=fKik/xBTiEKZhMwGpJYs3QEn699czStg48kaPDP/fsV+2FvXogCtoDdKWS+OD3ApwypcAy
 wdQSoNarArSWAvAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 071C13EA63;
 Tue, 20 Jan 2026 09:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y6ImABNSb2nfTgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jan 2026 09:59:47 +0000
Date: Tue, 20 Jan 2026 10:59:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260120095945.GA27808@pevik>
References: <20251014-file_attr_eopnotsupp-v2-1-c9827c8d8127@suse.com>
 <aW4mDAH6pVh_VyC2@yuki.lan> <DFSMEBM9PYDT.3TJXEU3C8W31R@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DFSMEBM9PYDT.3TJXEU3C8W31R@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4C8A8337C6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls: add file_attr05 test
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Mon Jan 19, 2026 at 1:39 PM CET, Cyril Hrubis wrote:
> > Hi!
> > > +	.filesystems = (struct tst_fs []) {
> > > +		{.type = "vfat"},

> > I wonder if we can add more filesystems here, just to make sure that we
> > run the test even when vfat is not compiled in the kernel. Does ext2
> > implement the file_set/getattr calls?

> > > +		{}
> > > +	},

> > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> vfat and ntfs are the only ones which don't support both file_setattr()
> and file_getattr(), while ext family, tmpfs and btrfs don't raise
> EOPNOTSUPP for file_getattr() only.

Interesting, I would expect vfat/ntfs would not support both. (I suppose exfat
also does not support them).

> I'm wondering if that's a bug, since
> xfs is our reference for this implementation, or this has been
> introduced in 6.18-rc2 by 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
> commit.

Maybe ask Andrey Albershteyn (the author) and Christian Brauner (the committer)?


> + * Regression test for "474b155adf39 - fs: make vfs_fileattr_[get|set] return
> + * -EOPNOTSUPP".

I also wonder if any of these should be mentioned in .tags (and in the text
comment, which I find a bit redundant when we have .tags):

474b155adf392 ("fs: make vfs_fileattr_[get|set] return -EOPNOTSUPP") # v6.17
NOTE: got reverted by 4dd5b5ac089bb in v6.18

d90ad28e8aa48 ("fs: return EOPNOTSUPP from file_setattr/file_getattr syscalls") # v6.18

Test itself LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
