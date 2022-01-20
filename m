Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B92DC433EF
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 12:24:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 171573C96CB
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 13:24:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6889A3C21D9
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 13:24:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CA2FB600C49
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 13:24:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D96F521709;
 Thu, 20 Jan 2022 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642681451;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2TLzZj5p/B0jP9JWghnskbUe3yLhtT75vusRbb/2YDM=;
 b=jJRBTFJQCssCP3ZCi1NoTngd1fq0m3Z2b0TuFJZnAyqln3QBzcNjhSYskqK3FBmFz3iZLC
 2p2TGXB/So77W2Gz28LKux3+k+0MK5/nSAN/EUlJA0nOaXOZ3HJUXiuVTGX0eUk8xjVR0d
 6xdOGjhNT/0qGNtKfxqW521IrgNZPws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642681451;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2TLzZj5p/B0jP9JWghnskbUe3yLhtT75vusRbb/2YDM=;
 b=xM/jIuRbUc2vXj4quCBjH2f9+8QZ3E2tTnqchcmorOVk1mY3CR4z5xLVXLD/PNzTeFfpLK
 5h7pYfgj+YPQrDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8740B13E9E;
 Thu, 20 Jan 2022 12:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jIpjH2tU6WE7XQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jan 2022 12:24:11 +0000
Date: Thu, 20 Jan 2022 13:24:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: NeilBrown <neilb@suse.de>
Message-ID: <YelUaQHlCp8FHAeQ@pevik>
References: <YebcNQg0u5cU1QyQ@pevik>
 <164254391708.24166.6930987548904227011@noble.neil.brown.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <164254391708.24166.6930987548904227011@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP nfslock01 test failing on NFS v3 (lockd: cannot
 monitor 10.0.0.2)
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
Cc: linux-nfs@vger.kernel.org, Steve Dickson <SteveD@redhat.com>,
 Anna Schumaker <anna.schumaker@netapp.com>,
 "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, ltp@lists.linux.it,
 Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Neil, all,

> On Wed, 19 Jan 2022, Petr Vorel wrote:
> > Hi all,

> > this is a test failure posted by Nikita Yushchenko [1]. LTP NFS test nfslock01
> > looks to be failing on NFS v3:

> > "not unsharing /var makes AF_UNIX socket for host's rpcbind to become available
> > inside ltpns. Then, at nfs3 mount time, kernel creates an instance of lockd for
> > ltpns, and ports for that instance leak to host's rpcbind and overwrite ports
> > for lockd already active for root namespace. This breaks nfs3 file locking."

> "not unsharing /var" ....  can this be fixed by simply unsharing /var?
> Or is that not simple?

> On could easily argue that RPCBIND_SOCK_PATHNAME in the kernel should be
> changed to "/run/rpcbind.sock".  Does this test suite unshare /run ??

> BTW, your email contains [1], [2], etc which suggests there are links
> somewhere - but there aren't.
I'm sorry, here they are:

[1] https://lore.kernel.org/ltp/590378ee-71af-deb6-6c03-1d2af459ed63@virtuozzo.com/
(the report)

[2] https://lore.kernel.org/ltp/20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com/
(the not yet merged LTP Nikita's patch)

[3] https://github.com/pevik/ltp/commits/nfs_flock/fail-on-error
(my LTP fork with Nikita's patch [2] + strace debugging - with this code I post
the report)

Kind regards,
Petr

> NeilBrown

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
