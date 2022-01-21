Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0DFC433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 05:30:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58A113C96E0
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 06:30:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BFD03C2AE9
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 06:29:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2ACAC200C9B
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 06:29:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3CC3B1F395;
 Fri, 21 Jan 2022 05:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642742997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Qrw2tBXZw6BLb51GobWaXyO72dke3+oxt8WFKSSsdI=;
 b=K042C3kcNuCBQxUvzEQgw+gNVNf+M6JJQi9ggO3WMMgOCiiU4TKvKoB3sVeinWbuvlTEqN
 8x8WRrXKetlPU6JEQmsJ1XkRbIZ76PugBlPL07dtMPqlr9d9UdeqAcUepxa+EUrTgH2jcp
 zGGfjDQmC2R6XhVAogCo1f49Vc24+hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642742997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Qrw2tBXZw6BLb51GobWaXyO72dke3+oxt8WFKSSsdI=;
 b=SuSVz97N0JBfHOdVfNxRYhsadDJnh2l2udOIbpj3Ssl0I3jzBzWZhur/xow6N4Cn1LWU8S
 sqlhn+O+iNUG3CCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8255139C3;
 Fri, 21 Jan 2022 05:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SqeuNtRE6mFgdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 05:29:56 +0000
Date: Fri, 21 Jan 2022 06:29:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <YepE066MwWSf7wAK@pevik>
References: <20220120143727.27057-1-nikita.yushchenko@virtuozzo.com>
 <YenNsuS1gcA9tDe3@pevik>
 <da777e8f-ca8a-e1c6-d005-792114b78f84@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <da777e8f-ca8a-e1c6-d005-792114b78f84@virtuozzo.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org, kernel@openvz.org,
 Steve Dickson <SteveD@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Nikita,

> 21.01.2022 00:01, Petr Vorel wrote:
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

> NFS is not involved here, this is about sunrpc tests.
Sure. Just tirpc (in libtirpc or the the old SUN-RPC already removed from glibc)
are used in NFS. Steve is the libtirpc maintainer.

> I had to add this patch to make 'runltp -f net.rpc' pass just after
> container is started - that happens in container autotests here.
Yep, I suspected this. Because on normal linux distro it's working right after
boot (tested on rpc01.sh). Can't this be a setup issue?

Kind regards,
Petr

> Nikita

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
