Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528C6FB44BC
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 06:32:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A0B63E2587
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 08:32:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5CB03E18DC
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 08:31:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F3790200ADE
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 08:31:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 325895BD1E;
 Fri, 24 Apr 2026 06:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777012298;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8nAl8Y8QSVZzHYuwZq8JHdSwdY/cGFLchhM3mzsTPQ=;
 b=R19XU+psiU5GmXXhGq5w4XimBYfNVO2o7vse0Y3/TPZXHBv2afnAlMtK6uuJAFAXEcWApT
 WgpLG+mJaZ24pXcysYspEGXp846G7St/VY4iWna6iNLq+R7Vu0QbzItZQLp9RnGJj3+eCZ
 IOg4EWbK/7Ko5EWv4FNPINwbaXWPg5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777012298;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8nAl8Y8QSVZzHYuwZq8JHdSwdY/cGFLchhM3mzsTPQ=;
 b=459ERU6DnzWfaZoJU5EsAyDZ4RfX54WnhZ89T3h/0T/nJI6vJy2igD7P2kWdv5RMdGaTcF
 skSgFjVINi8a/XCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R19XU+ps;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=459ERU6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777012298;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8nAl8Y8QSVZzHYuwZq8JHdSwdY/cGFLchhM3mzsTPQ=;
 b=R19XU+psiU5GmXXhGq5w4XimBYfNVO2o7vse0Y3/TPZXHBv2afnAlMtK6uuJAFAXEcWApT
 WgpLG+mJaZ24pXcysYspEGXp846G7St/VY4iWna6iNLq+R7Vu0QbzItZQLp9RnGJj3+eCZ
 IOg4EWbK/7Ko5EWv4FNPINwbaXWPg5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777012298;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8nAl8Y8QSVZzHYuwZq8JHdSwdY/cGFLchhM3mzsTPQ=;
 b=459ERU6DnzWfaZoJU5EsAyDZ4RfX54WnhZ89T3h/0T/nJI6vJy2igD7P2kWdv5RMdGaTcF
 skSgFjVINi8a/XCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B5DC593AE;
 Fri, 24 Apr 2026 06:31:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id F4fuAUoO62mzEAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Apr 2026 06:31:38 +0000
Date: Fri, 24 Apr 2026 08:31:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20260424063132.GE462697@pevik>
References: <20260424060543.462475-1-pvorel@suse.cz>
 <aesL6YSphAi5vJbO@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aesL6YSphAi5vJbO@linux.dev>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 325895BD1E
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ioctl_pidfd06: Update kernel version
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

Hi Li,

[ Discussion => Cc Cyril and Jan ]

> Hi Petr, Wei,

> Petr Vorel wrote:

> > Kernel commit ab89060fbc92e ("pidfs: return -EREMOTE when PIDFD_GET_INFO
> > is called on another ns") from v7.0 was backported into stable/LTS
> > kernels v6.18.14 (7446125afb6d9) and v6.19.10 (2920abaf56c09).

> Is this backport just a single stable kernel or a range of version?

It was backported into 6.18 stable (in v6.18.14) and in 6.19 (in v6.19.10).

> > Reported-by: Wei Gao <wegao@suse.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> > index 0f24d4741f..cc66d54cf4 100644
> > --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> > +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> > @@ -54,7 +54,7 @@ static void setup(void)
> >  	if (!ioctl_pidfd_info_exit_supported())
> >  		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");

> > -	if (tst_kvercmp(7, 0, 0) >= 0)
> > +	if (tst_kvercmp(6, 18, 14) >= 0)

> What will happen if this test is run on kernel range: v6.19.0 ~ v6.19.9?

FYI I haven't tested that, but it should fail on 6.18.0..v6.18.13 and on
v6.19.0..v6.19.9 due missing backport.

I'd assume that's correct, because on stable/LTS we should IMHO be more strict
to ensure it behaves as expected. WDYT?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
