Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4AAC77B78
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 21:21:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25EC33CE36E
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 23:21:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45A7F3CBB33
 for <ltp@lists.linux.it>; Tue,  2 May 2023 23:21:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ACAB21A002CB
 for <ltp@lists.linux.it>; Tue,  2 May 2023 23:21:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC07921E58;
 Tue,  2 May 2023 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1683062504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqHcT1BHJ1MgKwU0Y2ccjvWhxGEz0csoNFyVUCd7Rgo=;
 b=fSKstwd87A67VkAGyxp24wYQCch5LWg1sRddawQ7q9mLq+98nIvoxFb8F3U7uugQc1RDOV
 VLBcsXFuO2LFKcYSU02uMrvfTP7lWPDAi1RoUjmzuCrbMrtj/kQ+pr/oUcixm7rOdJ7irS
 qr9M3b+Ds4ci3vscjA8XBaCcccoi2xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1683062504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqHcT1BHJ1MgKwU0Y2ccjvWhxGEz0csoNFyVUCd7Rgo=;
 b=RqzhBgbzu8/ejpzKV9hWkYaDlJhWKFobTkMikUPW3DgJyjaVv3K4G/4Eaf9f/AxpT9/6sw
 fi9iOKFpsK7YvdDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F6CF139C3;
 Tue,  2 May 2023 21:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hXLpNeZ+UWStRwAAMHmgww
 (envelope-from <neilb@suse.de>); Tue, 02 May 2023 21:21:42 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
In-reply-to: <d441b9f9dfcbb4719d97c7b3b5950dfeeb8913d2.camel@kernel.org>
References: <20230502075921.3614794-1-pvorel@suse.cz>,
 <d441b9f9dfcbb4719d97c7b3b5950dfeeb8913d2.camel@kernel.org>
Date: Wed, 03 May 2023 07:21:36 +1000
Message-id: <168306249608.19756.8898498995753159325@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfslock01.sh: Don't test on NFS v3 on TCP
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
Cc: linux-nfs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 02 May 2023, Jeff Layton wrote:
> On Tue, 2023-05-02 at 09:59 +0200, Petr Vorel wrote:
> > 
> > Although there is suggestion, how to fix the problem in kernel [2]:
> > 
> >     > Maybe rpcb_create_local() shall detect that it is not in root
> >     > netns, and only try AF_INET connection to > localhost in that case.
> > 
> >     That would be simple and might be sensible.  IF changing the AF_UNIX
> >     path to "/run/rpcbind.sock" isn't sufficient, then testing for the
> >     root_ns is probably the best second option.
> > 
> 
> Was it determined that changing the location of the socket wasn't
> sufficient to fix this? FWIW, My Fedora 38 machine seems to listen on
> that socket already:
> 
>     [Socket]
>     ListenStream=/run/rpcbind.sock

I think the best solution for this problem is to change the kernel to
first try to send to an abstract socket: "\0/run/rpcbind.sock".  Only if
that fails do we try "/run/rpcbind.sock".

We also change rpcbind to listen on both
   ListenStream=@/run/rpcbind.sock
   ListenStream=/run/rpcbind.sock

Abstract sockets are local to a network namespace, while non-abstract
Unix domain sockets are local to a file and so can only be local to a
mount namespace.  We clearly need rpcbind lookup from the kernel to be
netns-local, so abstract is the obvious choice.

NeilBrown

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
