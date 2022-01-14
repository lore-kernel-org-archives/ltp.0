Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D340C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 20:23:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 138003C9559
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 21:23:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21A5A3C19EF
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 21:23:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3DCB4601CC0
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 21:23:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 728B5218EF;
 Fri, 14 Jan 2022 20:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642191822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PTMeeCymm/stlAE3UwWNnv2PEu/LhuJ0dc/7h+ecnDU=;
 b=uWTa+SqUS30aTZd1FDcsKtwyX+gsFKPWk8LTn6FYJ1Z1gGYqfI+1b9Y2omlEYBCcFraYSh
 ZKg2r96rTTg1Hot0McnQgrZcEZcj0oi0cgTDNihIU7P/zrvDhlmxP99pRoOhky4IZIbUAi
 HDOxpzFW9T0Oq51hycsWIufzfbq1YbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642191822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PTMeeCymm/stlAE3UwWNnv2PEu/LhuJ0dc/7h+ecnDU=;
 b=c4dGILGC/8sjnUH+SHTrf0j76ibNoq1Xzcsi4L4/39c3UuXXvkFcMXAri7otYOQU0CEt11
 KlPOMtmfCbYUpeBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C2FD1345F;
 Fri, 14 Jan 2022 20:23:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bFpsDM7b4WGYTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 20:23:42 +0000
Date: Fri, 14 Jan 2022 21:23:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <YeHbzANFrkQguAXh@pevik>
References: <20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com>
 <20220112161942.4065665-2-nikita.yushchenko@virtuozzo.com>
 <YeBKRoYuuZFVBmHf@pevik>
 <590378ee-71af-deb6-6c03-1d2af459ed63@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <590378ee-71af-deb6-6c03-1d2af459ed63@virtuozzo.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs_lib.sh: run exportfs at "server side" in
 LTP_NETNS case
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

> 13.01.2022 18:50, Petr Vorel wrote:
> > Hi Nikita,

> > [ Cc Alexey ]

> > > In LTP_NETNS case, nfs server is the root namespace and nfs client is
> > > the ltp namespace.

> > > Then, exportfs shall be executed locally, without tst_rhost_run.

> > > Otherwise, things implicitly depend on /var/lib/nfs being the same in
> > > the root namespace and the ltp namespace.
> > Not sure if I understand your use case. Do you run rpc.statd (or what is using
> > /var/lib/nfs) in non-default net namespace?

> 'exportfs' command maintains /var/lib/nfs/etab file, to be read by
> rpc.mountd when processing mount requests.

> 'exportfs' must be executed in the same environment where rpc.mountd runs

> In LTP_NETNS case, rpc.mountd runs on the host's root namespaces
> (and mount runs in ltp's non-root namespace).

> Thus for correctness, must execute 'exportfs' in the root namespace.

Ah, you're right.

> Currently ltp runs 'exportfs' in ltpns, which works only because ltpns does
> not unshare /var from root namespace.

> But not unsharing /var makes AF_UNIX socket for host's rpcbind to become
> available inside ltpns. Then, at nfs3 mount time, kernel creates an instance
> of lockd for ltpns, and ports for that instance leak to host's rpcbind and
> overwrite ports for lockd already active for root namespace. This breaks
> nfs3 file locking. But that is not found by nfslock01 test because that test
> ignores the errors from the very operations it is intended to test.

> This patch, and the patch that makes nfslock01 to actually fail on errors, is part of fixing all that mess.
+1. FYI I get errno ENOLCK for NFSv3 on both unpatched and patched nfs_lib.sh.

> > > -	if ! tst_rhost_run -c "test -d $remote_dir"; then
> > > -		tst_rhost_run -s -c "mkdir -p $remote_dir; $export_cmd"
> > > +	if [ -n "$LTP_NETNS" ]; then
> > Please use tst_net_use_netns (as in the patch I Cc you just now).

> > Shouldn't be also $LTP_NFS_NETNS_USE_LO considered?

> The rule is - run exportfs in the environment that plays the 'nfs server' role.

> I'm not sure about exact semantics of $LTP_NFS_NETNS_USE_LO, but per
> what I see in the code, it does not affect how address in $mount_dir is
> configured. Then, it also shall not affect the choice of where 'exportfs'
> runs.
Sorry, $LTP_NFS_NETNS_USE_LO is separated thing (mounting does not affect server
setup).

Waiting for Alexey or Martin if they have any comment before merging both fixes on Monday.

Kind regards,
Petr

> Nikita

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
