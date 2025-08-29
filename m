Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02261CA0FF7
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 09:31:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0A6A3CD106
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 11:31:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9E743CBFBB
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 11:30:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ED95D140096B
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 11:30:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3CC09207C9;
 Fri, 29 Aug 2025 09:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756459845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9pJem5/A8ydYfRzQJjPRNjHVWC7sMwl0BR13633baEg=;
 b=veDGcMtIk5V+R8XoSvD11nF1J3ZPNmGcyxE4yEy9HoA8iu2mCZncN3g3/TL4FGQsLXYg59
 FRkbasua/gCi5cQ8rpfpPUiOy/jxlC2x+AbSZmVCS7QZ9gxeOCpLb9LGHmoOU3oKu5rgNl
 5PWlm0BK03erjHUqdCWqsLvMl5L28Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756459845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9pJem5/A8ydYfRzQJjPRNjHVWC7sMwl0BR13633baEg=;
 b=Wnb+MxrLtYrnjbr++nbWLFedm4gJfakCW1uZKtHctAh0oTVuGCHJ+FGR8466qFv7aoyAC9
 64PwCCo5ExeIeoDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756459844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9pJem5/A8ydYfRzQJjPRNjHVWC7sMwl0BR13633baEg=;
 b=g+qQqES7XX/AiJ1c7rUooTtaY932RqwPjnQwruQlsPEHp/FyxgcOXDmjqHbenEfjYsytsw
 NJC80Ino/BLAKUs2WFu0H85ueVekfpLpBgSzJXtTIpK1lUclS+p0mbS62xwM5A0nb9poS8
 pFdOnLEeuZ+VHXGz7sKk2aCI6LctE3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756459844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9pJem5/A8ydYfRzQJjPRNjHVWC7sMwl0BR13633baEg=;
 b=o9bOt5pHoIuTYloBpuEBykBNOdagkkc8+ahj9BUNp8ohYCRFDIJ5xrexPTxPsZmwXqxmxD
 G9WeK+QnT/Ymf6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DEF313326;
 Fri, 29 Aug 2025 09:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZV7OCERzsWhUNQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 29 Aug 2025 09:30:44 +0000
Date: Fri, 29 Aug 2025 11:31:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aLFzZ6xGsZh3CO64@yuki.lan>
References: <20250828-open_tree_attr-v1-0-f339a0e51e22@suse.com>
 <20250828-open_tree_attr-v1-2-f339a0e51e22@suse.com>
 <aLDhgFRA8ppAmYlH@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aLDhgFRA8ppAmYlH@localhost>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mount_setattr01: add open_tree_attr variant
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +static int open_tree_variant1(struct mount_attr *attr)
> > +{
> > +	tst_res(TINFO, "Variant using open_tree() + mount_setattr()");
> > +
> > +	otfd = TST_EXP_FD(open_tree(AT_FDCWD, MNTPOINT,
> > +			AT_EMPTY_PATH | OPEN_TREE_CLONE));
> > +	if (otfd == -1)
> > +		return -1;
> > +
> > +	TST_EXP_PASS(mount_setattr(otfd, "", AT_EMPTY_PATH,
> > +			attr, sizeof(*attr)));
> Duplicate mount_setattr? There is another mount_setattr after this
> called.

As far as I can tell the call that was done later has been removed in
this patch. That is because both of the variants do open_tree and
mount_setattr in the open_tree_variant() functions.

> > +	if (TST_RET == -1)
> > +		return -1;
> > +
> > +	return otfd;
> > +}
> > +
> > +static int open_tree_variant2(struct mount_attr *attr)
> > +{
> > +	tst_res(TINFO, "Variant using open_tree_attr()");
> > +
> > +	otfd = TST_EXP_FD(open_tree_attr(AT_FDCWD, MNTPOINT,
> > +			AT_EMPTY_PATH | OPEN_TREE_CLONE,
> > +			attr, sizeof(*attr)));
> > +
> > +	return otfd;
> > +}
> > +
> >  static void run(unsigned int n)
> >  {
> >  	struct tcase *tc = &tcases[n];
> > -	struct mount_attr attr = {
> > -		.attr_set = tc->mount_attrs,
> > -	};
> >  	struct statvfs buf;
> >  
> > -	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
> > -		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
> > -	if (!TST_PASS)
> > -		return;
> > +	memset(attr, 0, sizeof(*attr));
> > +	attr->attr_set = tc->mount_attrs;
> >  
> > -	otfd = (int)TST_RET;
> > +	if (tst_variant)
> > +		otfd = open_tree_variant1(attr);
> > +	else
> > +		otfd = open_tree_variant2(attr);
> I am not sure this is perfect way loop the function, add function point into struct tcase
> is better in my opinion.

The tst_variant was implemented exactly for the case where we have
different syscalls doing the same job. In this case a shortcut was added
that does open_tree + mount_setattr in a single syscall, so using
variants is very reasonable choice.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
