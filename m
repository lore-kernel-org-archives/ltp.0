Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836F2FD2D88
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 13:37:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 343C33E57F6
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 14:37:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EAD53E23C4
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 14:36:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D83960066E
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 14:36:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 183A54D266;
 Tue, 10 Mar 2026 13:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773149801;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BxmAovkZ/Wto2h40TZ54bVBXmdlou+4lCD/Fev2drg=;
 b=JFaci2jkdiXbO+YoNW4xnzftPVNNxdAeFrFdEXaIqHPIMW4Md4UYFlusxQC86nsVHjat8y
 2muGdPnEZA7573ZeOvp8rR+bUOK+5rOtxsCwhe/VPlJN6A2xDJbjOjoS6Pn9KwE6r1dU28
 6me0wlodtuHLVGgK6lyR6i9MlzMPq7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773149801;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BxmAovkZ/Wto2h40TZ54bVBXmdlou+4lCD/Fev2drg=;
 b=Cplw+e7cMklUyfnG8xPeW/bYKU4s1CwiD1qezS75DJbGC0Clj02U3zSboZ1qfHuu6V9E+f
 Py9dtXM4+6AEayBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773149801;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BxmAovkZ/Wto2h40TZ54bVBXmdlou+4lCD/Fev2drg=;
 b=JFaci2jkdiXbO+YoNW4xnzftPVNNxdAeFrFdEXaIqHPIMW4Md4UYFlusxQC86nsVHjat8y
 2muGdPnEZA7573ZeOvp8rR+bUOK+5rOtxsCwhe/VPlJN6A2xDJbjOjoS6Pn9KwE6r1dU28
 6me0wlodtuHLVGgK6lyR6i9MlzMPq7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773149801;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BxmAovkZ/Wto2h40TZ54bVBXmdlou+4lCD/Fev2drg=;
 b=Cplw+e7cMklUyfnG8xPeW/bYKU4s1CwiD1qezS75DJbGC0Clj02U3zSboZ1qfHuu6V9E+f
 Py9dtXM4+6AEayBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFECF3F4A0;
 Tue, 10 Mar 2026 13:36:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8jdbOWgesGnBXQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Mar 2026 13:36:40 +0000
Date: Tue, 10 Mar 2026 14:36:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>, chrubis@suse.cz,
 Linux Test Project <ltp@lists.linux.it>
Message-ID: <20260310133639.GE39882@pevik>
References: <20260309172057.272946-1-japo@linux.ibm.com>
 <20260309172057.272946-2-japo@linux.ibm.com>
 <20260310132522.GD39882@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260310132522.GD39882@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/3] fsetxattr02: Adapt test for kernel 7.0+
 socket xattr support
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> Hi Jan,

> > Starting with kernel 7.0.0, sockets support extended attributes in the
> > user.* namespace. This behavior was enabled by dc0876b9846d ("xattr: support
> > extended attributes on sockets"), which permits user.* xattrs on S_IFSOCK
> > inodes (previously rejected with -EPERM).

I double checked kernel version for dc0876b9846d.

$ git tag --contains dc0876b9846d3d48bb8528332106d1b051578a02
next-20260305
next-20260306
next-20260309

=> IMHO it will be for v7.1. And indeed, current LTP master works on openSUSE
7.0.0-rc2-2.g0bfc1b0-default kernel and fails with your patch.

> Good catch, thanks!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > Adapts the test to expect success (exp_err = 0) instead of EPERM when
> > testing fsetxattr(2) on sockets with kernel 7.0+.

> > Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> > ---
> >  testcases/kernel/syscalls/fsetxattr/fsetxattr02.c | 4 ++++
> >  1 file changed, 4 insertions(+)

> > diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
> > index 18490a865871..ede86b218ee6 100644
> > --- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
> > +++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
> > @@ -158,6 +158,10 @@ static void verify_fsetxattr(unsigned int i)
> >  	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
> >  		tst_brk(TCONF, "fsetxattr(2) not supported");

> > +	/* consider newer kernels */
> very nit: The commit is obvious. If anything to add, I would add the git hash itself.

> Kind regards,
> Petr

> > +	if ((tst_kvercmp(7, 0, 0) >= 0) && (strncmp(tc[i].fname, SOCK, strlen(SOCK)) == 0))
> > +		tc[i].exp_err = 0;

It should be tst_kvercmp(7, 1, 0) >= 0

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
