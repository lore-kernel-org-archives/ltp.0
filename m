Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA00606A331
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KZnbd3ft;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6SzLZbyJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KZnbd3ft;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6SzLZbyJ
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBE6F3EACC0
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 14:12:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC40D3E15F6
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 14:12:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3F5781A007EA
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 14:12:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 87EB321FBA;
 Mon,  9 Nov 2026 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794229933;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i51BSIy8K2LfYr7jHt77vB+OupBhbKgMuERiCue6AZs=;
 b=KZnbd3ftNHn9hloTbA/IEFfcdCpzS03c/6RqeiVEPqypMB70ONBd6/sj4vdIRleVKdoMKe
 YCzhrjW5bMUyMCQ/gjoPAViePSwJEz04kGLLvGKYBEIpHMLNJkLdBMN0LXP2bYDhdhuAZ+
 WQNWZSSLAw2f+96KYaofYDuZsR8/bRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794229933;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i51BSIy8K2LfYr7jHt77vB+OupBhbKgMuERiCue6AZs=;
 b=6SzLZbyJNJzg4QIrjkQixRUxHU/hgpCzGNAMO6lMj2qrmb87rdUp7Y1U9UrzI97MN/n2CI
 fljU6TJAwKidodCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KZnbd3ft;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6SzLZbyJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794229933;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i51BSIy8K2LfYr7jHt77vB+OupBhbKgMuERiCue6AZs=;
 b=KZnbd3ftNHn9hloTbA/IEFfcdCpzS03c/6RqeiVEPqypMB70ONBd6/sj4vdIRleVKdoMKe
 YCzhrjW5bMUyMCQ/gjoPAViePSwJEz04kGLLvGKYBEIpHMLNJkLdBMN0LXP2bYDhdhuAZ+
 WQNWZSSLAw2f+96KYaofYDuZsR8/bRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794229933;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i51BSIy8K2LfYr7jHt77vB+OupBhbKgMuERiCue6AZs=;
 b=6SzLZbyJNJzg4QIrjkQixRUxHU/hgpCzGNAMO6lMj2qrmb87rdUp7Y1U9UrzI97MN/n2CI
 fljU6TJAwKidodCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D4AC13302;
 Mon,  9 Nov 2026 13:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LyAqBa3G8WrLGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Nov 2026 13:12:13 +0000
Date: Mon, 9 Nov 2026 14:12:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20261109131211.GB631538@pevik>
References: <20261106164105.615423-1-pvorel@suse.cz>
 <avG4D4xe2XW9JrIQ@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <avG4D4xe2XW9JrIQ@yuki.lan>
X-Rspamd-Queue-Id: 87EB321FBA
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.71 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -12.71
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] zram01.sh: Rewrite to run by single filesystem
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > 1) test only particular filesystem
> > 2) easily identify which filesystem is slow or fails

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  runtest/kernel_misc                           |  9 +++
> >  .../kernel/device-drivers/zram/zram01.sh      | 75 +++++++++++--------
> >  2 files changed, 54 insertions(+), 30 deletions(-)

> > diff --git a/runtest/kernel_misc b/runtest/kernel_misc
> > index ac14f633e2..05ec709422 100644
> > --- a/runtest/kernel_misc
> > +++ b/runtest/kernel_misc
> > @@ -13,6 +13,15 @@ uaccess uaccess
> >  rcu_torture rcu_torture.sh
> >  lock_torture lock_torture.sh
> >  zram01 zram01.sh
> > +zram01_ext2 zram01.sh -f ext2
> > +zram01_ext3 zram01.sh -f ext3
> > +zram01_ext4 zram01.sh -f ext4
> > +zram01_xfs zram01.sh -f xfs
> > +zram01_btrfs zram01.sh -f btrfs
> > +zram01_bcachefs zram01.sh -f bcachefs
> > +zram01_vfat zram01.sh -f vfat
> > +zram01_exfat zram01.sh -f exfat
> > +zram01_ntfs zram01.sh -f ntfs

> I do not like this. With this we have to maintain the list of the
> filesystems manually in the runtest file. What is the exact problem you
> are trying to fix?

FYI we use this approach also on mkfs01.sh (it was not transformed to use
TST_ALL_FILESYSTEMS).

I'm sorry to not explain it properly. zram01.sh sometimes timeouts on slower
worker (I need to dig further as increasing timeout did not help) and it's not from
the first view obvious what is wrong. One can debug with
LTP_FORCE_SINGLE_FS_TYPE or LTP_SINGLE_FS_TYPE, but it's not that easy to filter
out filesystem one is not interested in (which would be with this one). But ok,
that's general problem of .all_filesystems = 1 approach anyway.

I'll first debug with a custom code using LTP_FORCE_SINGLE_FS_TYPE.

Also rewrite the test to use TST_ALL_FILESYSTEMS would probably help to more
easily see which filesystem is tested (and maybe even with better timeout
handling).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
