Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DA6C433EF
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 06:09:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 155933C70C2
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 07:09:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A5233C0F90
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 07:09:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A6DDB1400966
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 07:09:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 52E4E21972;
 Mon, 24 Jan 2022 06:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643004549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yJTO1ntaNYhfyc0kwrRnaOw0Kj/PjR12jA28uu4oRjU=;
 b=gkPkSkrJxktYRo5q8bkBxLgOYgT5VoQHIhqHZSdHacQKj6NGb+C8+kic2E+psiUok5bstx
 ZvPX95MKQPn+oyqaut2ncBvKOgfe8gnNwyGTM2SljWTAKQYtk/YpH8BEPSS7NIzceEiw3C
 z3JYPzp3m3VQzgAyxKUBJx8IXwwGDPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643004549;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yJTO1ntaNYhfyc0kwrRnaOw0Kj/PjR12jA28uu4oRjU=;
 b=6IFR7wiLjWPDNg5P8yroLS6y3C9ic/AUuldwLcgG0UHmREBHw6x5Mx1a0vQAOYeKXLniJM
 8cxXY4DKiFaZAbDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13FFD1331A;
 Mon, 24 Jan 2022 06:09:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vZreAoVC7mHabgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Jan 2022 06:09:09 +0000
Date: Mon, 24 Jan 2022 07:09:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>
Message-ID: <Ye5Cg7biIyXQOIDn@pevik>
References: <20220120143727.27057-1-nikita.yushchenko@virtuozzo.com>
 <YenNsuS1gcA9tDe3@pevik>
 <164279789186.8775.7075880084961337149@noble.neil.brown.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <164279789186.8775.7075880084961337149@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rpc_lib.sh: fix portmapper detection in case of
 socket activation
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
Cc: linux-nfs@vger.kernel.org, kernel@openvz.org,
 Steve Dickson <SteveD@redhat.com>, ltp@lists.linux.it,
 Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Fri, 21 Jan 2022, Petr Vorel wrote:
> > Hi Nikita,

> > [ Cc: Steve as user-space maintainer, also Neil and whole linux-nfs ]

> > > On systemd-based linux hosts, rpcbind service is typically started via
> > > socket activation, when the first client connects. If no client has
> > > connected before LTP rpc test starts, rpcbind process will not be
> > > running at the time of check_portmap_rpcbind() execution, causing
> > > check_portmap_rpcbind() to report TCONF error.

> > > Fix that by adding a quiet invocation of 'rpcinfo' before checking for
> > > rpcbind.

> > Looks reasonable, but I'd prefer to have confirmation from NFS experts.

> > > For portmap, similar step is likely not needed, because portmap is used
> > > only on old systemd and those don't use systemd.

> > > Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
> > > ---
> > >  testcases/network/rpc/basic_tests/rpc_lib.sh | 6 ++++++
> > >  1 file changed, 6 insertions(+)

> > > diff --git a/testcases/network/rpc/basic_tests/rpc_lib.sh b/testcases/network/rpc/basic_tests/rpc_lib.sh
> > > index c7c868709..e882e41b3 100644
> > > --- a/testcases/network/rpc/basic_tests/rpc_lib.sh
> > > +++ b/testcases/network/rpc/basic_tests/rpc_lib.sh
> > > @@ -8,6 +8,12 @@ check_portmap_rpcbind()
> > >  	if pgrep portmap > /dev/null; then
> > >  		PORTMAPPER="portmap"
> > >  	else
> > > +		# In case of systemd socket activation, rpcbind could be
> > > +		# not started until somebody tries to connect to it's socket.
> > > +		#
> > > +		# To handle that case properly, run a client now.
> > > +		rpcinfo >/dev/null 2>&1

> If it were me, I would remove the 'pgrep's and just call "rpcbind -p"
> and make sure something responds.

Hi Neil,

I guess you mean: rpcinfo -p

Good idea, thanks!

Kind regards,
Petr

> NeilBrown



> > nit: Shouldn't we keep stderr? In LTP we put required commands into
> > $TST_NEEDS_CMDS. It'd be better not require rpcinfo (not a hard dependency),
> > and thus it'd be better to see "command not found" when rpcinfo missing and test
> > fails.

> > Kind regards,
> > Petr

> > > +
> > >  		pgrep rpcbind > /dev/null && PORTMAPPER="rpcbind" || \
> > >  			tst_brk TCONF "portmap or rpcbind is not running"
> > >  	fi



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
