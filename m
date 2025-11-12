Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051CFCCF9F8
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 12:21:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E68F3CF731
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 13:21:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7844D3CF71B
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 13:21:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B2949600778
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 13:21:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 372F21F453;
 Wed, 12 Nov 2025 12:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762950092;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i0OkXXmqnQ+pLwl0ijfQTZinTnr+kUZZy8UUewL4ZBs=;
 b=xoRXU+orJFWASzM7Z7UcD7XVRSfVIghb2chHBVO21RBB1Heqhl8ucxnE8UgmJnxpKnbK0y
 mi+6B55lGYLPasMFHbdeSbxPrbHsMdqwIcXjjTE7RajQrIdtDkoiH7uKC2jtHOj3QBcFpI
 +w6YOShN/rtmlJ6YeXqrRovgb1Iofh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762950092;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i0OkXXmqnQ+pLwl0ijfQTZinTnr+kUZZy8UUewL4ZBs=;
 b=R2Xhg8v1UV1TYqIQ4cDQR0LTGPU6EWY73K+8zqaQEbPuowrntI3AhcUSIBH1+OTHc0qol0
 nHPzx8UHyHJkfCBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xoRXU+or;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R2Xhg8v1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762950092;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i0OkXXmqnQ+pLwl0ijfQTZinTnr+kUZZy8UUewL4ZBs=;
 b=xoRXU+orJFWASzM7Z7UcD7XVRSfVIghb2chHBVO21RBB1Heqhl8ucxnE8UgmJnxpKnbK0y
 mi+6B55lGYLPasMFHbdeSbxPrbHsMdqwIcXjjTE7RajQrIdtDkoiH7uKC2jtHOj3QBcFpI
 +w6YOShN/rtmlJ6YeXqrRovgb1Iofh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762950092;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i0OkXXmqnQ+pLwl0ijfQTZinTnr+kUZZy8UUewL4ZBs=;
 b=R2Xhg8v1UV1TYqIQ4cDQR0LTGPU6EWY73K+8zqaQEbPuowrntI3AhcUSIBH1+OTHc0qol0
 nHPzx8UHyHJkfCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1729C3EA61;
 Wed, 12 Nov 2025 12:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D/0sBMx7FGn/LQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Nov 2025 12:21:32 +0000
Date: Wed, 12 Nov 2025 13:21:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251112122126.GB80114@pevik>
References: <20250924084223.20597-1-wegao@suse.com>
 <20251101012320.24972-1-wegao@suse.com>
 <20251101012320.24972-2-wegao@suse.com>
 <20251111120600.GA50277@pevik>
 <aRQuc47d3PpTczVB@autotest-wegao.qe.prg2.suse.org>
 <20251112092236.GA80114@pevik> <aRRiLUyES4M5qjOm@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRRiLUyES4M5qjOm@yuki.lan>
X-Rspamd-Queue-Id: 372F21F453
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_filesystems01.c: Add test for
 .filesystems
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

> Hi!
> > > > > +static void do_test(void)
> > > > > +{
> > > > > +	long fs_type;
> > > > > +
> > > > > +	fs_type = tst_fs_type(MOUNT_POINT);
> > > > > +
> > > > > +	if (fs_type == TST_EXT234_MAGIC) {
> > > > > +		TST_EXP_PASS((check_inode_size(128)));
> > > > > +		TST_EXP_PASS((check_mkfs_size_opt(10240)));

> > > > very nit: I would personally add #define for 128 and 10240, but sure it's ok to
> > > > keep it hardcoded on 2 places.
> > > I thought also use #define but i found and can not replace it in
> > > "mkfs_opts = (const char *const []){"-I", "128", "-b", "1024", NULL}",
> > > so i keep hardcoded number here.

> > Thanks for info. Sure, no problem.

> > Cc Cyril in case it's worth to fix it in metaparse.c.

> The metaparse tool does macro expansion, that shouldn't be a problem.

> Also metaparse only scans testcases/ directory during the build. The
> lib/ directory is not parsed at all.

@Cyril Ah, I'm sorry I forget it's a library test, not an ordinary test.

@Wei I thought tested and see the problem, but you probably just suspect it
would be a problem.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
