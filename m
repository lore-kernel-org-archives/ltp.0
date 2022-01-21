Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616A2C433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 20:45:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B61923C972D
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 21:45:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D517B3C8D83
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 21:44:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 40C926006CB
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 21:44:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 615BC1F37D;
 Fri, 21 Jan 2022 20:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642797897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0UoJNm8/P0M9Dl+haSgiXy8MmyWzhrLLwFnIgMKkJcM=;
 b=qZxyY5O/GNcNhI8dN/FHi9je7s68xtPz67gvLD+EkDyFSVZw3qAAxE24NrqFZwzP+TY9ZH
 G4VM43rKx5uGupc8awVopzE6Mp4d302a2215qooKcm8S3BftxUG66vC1HZYGHo8ZIYMJJF
 IS7isDFUSYG/G2EJ+EqRIF8YfVd/TRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642797897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0UoJNm8/P0M9Dl+haSgiXy8MmyWzhrLLwFnIgMKkJcM=;
 b=N3QoIhx8U/xs1naDA+3LUpExA70xH1zSgJpMGmnUFQdGt6OG7onYGPKekD0eQlbTlibVhL
 HOqHLqr9taFFi8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6053313A98;
 Fri, 21 Jan 2022 20:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RxcAB0cb62G/AgAAMHmgww
 (envelope-from <neilb@suse.de>); Fri, 21 Jan 2022 20:44:55 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Petr Vorel" <pvorel@suse.cz>
In-reply-to: <YenNsuS1gcA9tDe3@pevik>
References: <20220120143727.27057-1-nikita.yushchenko@virtuozzo.com>,
 <YenNsuS1gcA9tDe3@pevik>
Date: Sat, 22 Jan 2022 07:44:51 +1100
Message-id: <164279789186.8775.7075880084961337149@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Cc: linux-nfs@vger.kernel.org, kernel@openvz.org,
 Steve Dickson <SteveD@redhat.com>, ltp@lists.linux.it,
 Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 21 Jan 2022, Petr Vorel wrote:
> Hi Nikita,
> 
> [ Cc: Steve as user-space maintainer, also Neil and whole linux-nfs ]
> 
> > On systemd-based linux hosts, rpcbind service is typically started via
> > socket activation, when the first client connects. If no client has
> > connected before LTP rpc test starts, rpcbind process will not be
> > running at the time of check_portmap_rpcbind() execution, causing
> > check_portmap_rpcbind() to report TCONF error.
> 
> > Fix that by adding a quiet invocation of 'rpcinfo' before checking for
> > rpcbind.
> 
> Looks reasonable, but I'd prefer to have confirmation from NFS experts.
> 
> > For portmap, similar step is likely not needed, because portmap is used
> > only on old systemd and those don't use systemd.
> 
> > Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
> > ---
> >  testcases/network/rpc/basic_tests/rpc_lib.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> > diff --git a/testcases/network/rpc/basic_tests/rpc_lib.sh b/testcases/network/rpc/basic_tests/rpc_lib.sh
> > index c7c868709..e882e41b3 100644
> > --- a/testcases/network/rpc/basic_tests/rpc_lib.sh
> > +++ b/testcases/network/rpc/basic_tests/rpc_lib.sh
> > @@ -8,6 +8,12 @@ check_portmap_rpcbind()
> >  	if pgrep portmap > /dev/null; then
> >  		PORTMAPPER="portmap"
> >  	else
> > +		# In case of systemd socket activation, rpcbind could be
> > +		# not started until somebody tries to connect to it's socket.
> > +		#
> > +		# To handle that case properly, run a client now.
> > +		rpcinfo >/dev/null 2>&1

If it were me, I would remove the 'pgrep's and just call "rpcbind -p"
and make sure something responds.

NeilBrown



> nit: Shouldn't we keep stderr? In LTP we put required commands into
> $TST_NEEDS_CMDS. It'd be better not require rpcinfo (not a hard dependency),
> and thus it'd be better to see "command not found" when rpcinfo missing and test
> fails.
> 
> Kind regards,
> Petr
> 
> > +
> >  		pgrep rpcbind > /dev/null && PORTMAPPER="rpcbind" || \
> >  			tst_brk TCONF "portmap or rpcbind is not running"
> >  	fi
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
