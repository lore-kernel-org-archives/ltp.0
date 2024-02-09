Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03558C48297
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 08:50:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3112E3CC91B
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 09:50:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6FDF3CC396
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 09:50:04 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE7D82146A5
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 09:50:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 340A41F7F2;
 Fri,  9 Feb 2024 08:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707468600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrkT5D7RKxo1Y3Adx3pYafrSETejcNP6cyJZdXLHFb4=;
 b=Y06A0fHPnaCvJaWPPaGazoLBHWhxUVqN4bHvjeh0uqFAGVvm0hVl5SH1+CjRgM1IVtS9gh
 H+K+UXK7xJhWfB9pcBSyJkleTcJuc0ljQpM93Ihdz6OExfiNHeYhb5gpWGtEzHmBjVZswi
 ZYZ6/3HMUAVyOlbAQ3xxnYSyP1aPH5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707468600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrkT5D7RKxo1Y3Adx3pYafrSETejcNP6cyJZdXLHFb4=;
 b=yF2eCexmDt0J6+z/ffMihJNpAR+BrF40nS3Ig61utzJLIyC2yHiLEmWzYniJiuYx4cSQ/q
 sJdS2IbUHBTxY9BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707468600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrkT5D7RKxo1Y3Adx3pYafrSETejcNP6cyJZdXLHFb4=;
 b=Y06A0fHPnaCvJaWPPaGazoLBHWhxUVqN4bHvjeh0uqFAGVvm0hVl5SH1+CjRgM1IVtS9gh
 H+K+UXK7xJhWfB9pcBSyJkleTcJuc0ljQpM93Ihdz6OExfiNHeYhb5gpWGtEzHmBjVZswi
 ZYZ6/3HMUAVyOlbAQ3xxnYSyP1aPH5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707468600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrkT5D7RKxo1Y3Adx3pYafrSETejcNP6cyJZdXLHFb4=;
 b=yF2eCexmDt0J6+z/ffMihJNpAR+BrF40nS3Ig61utzJLIyC2yHiLEmWzYniJiuYx4cSQ/q
 sJdS2IbUHBTxY9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 993C01326D;
 Fri,  9 Feb 2024 08:49:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zZdKIjfnxWUBBgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Feb 2024 08:49:59 +0000
Date: Fri, 9 Feb 2024 09:49:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240209084953.GA246045@pevik>
References: <20240131151446.936281-1-pvorel@suse.cz>
 <20240131151446.936281-5-pvorel@suse.cz>
 <1ad65f0c-430c-4805-83eb-81198303a888@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1ad65f0c-430c-4805-83eb-81198303a888@suse.cz>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Y06A0fHP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yF2eCexm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[10]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[25.14%]
X-Rspamd-Queue-Id: 340A41F7F2
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] nfsstat01.sh: Run on all NFS versions,
 TCP and UDP
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
Cc: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
 Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi,
> for the whole patchset:

> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

Thanks for your review, merged!

Kind regards,
Petr

> On 31. 01. 24 16:14, Petr Vorel wrote:
> > Due fix in previous version we can run nfsstat01.sh on all NFS versions
> > (added NFSv4, NFSv4.1, NFSv4.2) and on TCP and UDP.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   runtest/net.nfs | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)

> > diff --git a/runtest/net.nfs b/runtest/net.nfs
> > index 463c95c37..9c1c5c63e 100644
> > --- a/runtest/net.nfs
> > +++ b/runtest/net.nfs
> > @@ -94,7 +94,16 @@ nfslock01_v40_ip6t nfslock01.sh -6 -v 4 -t tcp
> >   nfslock01_v41_ip6t nfslock01.sh -6 -v 4.1 -t tcp
> >   nfslock01_v42_ip6t nfslock01.sh -6 -v 4.2 -t tcp
> > -nfsstat01_v30 nfsstat01.sh -v 3
> > +nfsstat01_v30_ip4u nfsstat01.sh -v 3 -t udp
> > +nfsstat01_v30_ip4t nfsstat01.sh -v 3 -t tcp
> > +nfsstat01_v40_ip4t nfsstat01.sh -v 4 -t tcp
> > +nfsstat01_v41_ip4t nfsstat01.sh -v 4.1 -t tcp
> > +nfsstat01_v42_ip4t nfsstat01.sh -v 4.2 -t tcp
> > +nfsstat01_v30_ip6u nfsstat01.sh -6 -v 3 -t udp
> > +nfsstat01_v30_ip6t nfsstat01.sh -6 -v 3 -t tcp
> > +nfsstat01_v40_ip6t nfsstat01.sh -6 -v 4 -t tcp
> > +nfsstat01_v41_ip6t nfsstat01.sh -6 -v 4.1 -t tcp
> > +nfsstat01_v42_ip6t nfsstat01.sh -6 -v 4.2 -t tcp
> >   fsx_v30_ip4u fsx.sh -v 3 -t udp
> >   fsx_v30_ip4t fsx.sh -v 3 -t tcp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
