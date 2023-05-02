Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78B0C77B7E
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 12:26:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 260BF3CB907
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 14:26:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0FDE3CB8BF
 for <ltp@lists.linux.it>; Tue,  2 May 2023 14:25:52 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DB2F21A0060C
 for <ltp@lists.linux.it>; Tue,  2 May 2023 14:25:51 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2737E61D11;
 Tue,  2 May 2023 12:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04953C433D2;
 Tue,  2 May 2023 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1683030348;
 bh=dE0BXw8S2d8Spp83u+tI7KEEZzL1wh2CX5ZK4sGTLOw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=M5kkGaSkDkzDAjO6Ti1f+vHWcsQ4FhFpP3fjO1N6kShQJuwSWsdi3fYaCVfAO87IQ
 Fsdkarq6Q/eRYlm6OrS8to6wb1EtX99dv5/4PE5Zy5S65+JLPEl+fJf+kpxDU/cagz
 cT1KBAJMgdS2u4U5kqNSRvruqw+uCOWWpqStSXbGW6qsMv4VllFC3iJszI3hL+BuvA
 C1WTGiOWLsVKJzHr/nNZNZyQLNu+t268zIohUNc/xHlK7Ti0aZCVxzpNTQqLLGv3eE
 pC3o/MIwQL1Q7FD4xVwklXbEIed0xfwbu5Rwc3j1u+BTh/NNaJ2+xRZwOyaUGFVmQb
 km3WrCQ+k3ueQ==
Message-ID: <d441b9f9dfcbb4719d97c7b3b5950dfeeb8913d2.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Tue, 02 May 2023 08:25:46 -0400
In-Reply-To: <20230502075921.3614794-1-pvorel@suse.cz>
References: <20230502075921.3614794-1-pvorel@suse.cz>
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 2023-05-02 at 09:59 +0200, Petr Vorel wrote:
> nfs_flock (run via nfslock01.sh) is known to fail on NFS v3 [1]:
> 
>     not unsharing /var makes AF_UNIX socket for host's rpcbind to become
>     available inside ltp_ns. Then, at NFS v3 mount time, kernel creates
>     an instance of lockd for ltp_ns, and ports for that instance leak to
>     host's rpcbind and overwrite ports for lockd already active for root
>     namespace. This breaks nfs3 file locking.
> 

Yeccchhh...that is pretty nasty.

rpcbind was obviously written in a time before namespaces were even a
thought to anyone. I wonder if there is something we can do in rpcbind
itself to guard against these sorts of shenanigans? Probably not, I
guess...

Is /var shared between namespaces in this test for some particular
reason?

> Before bd512e733 ("nfs_flock: fail the test if lock/unlock ops fail")
> it run indefinitely with "unhandled error -107":
> [ 2840.099565] lockd: cannot monitor 10.0.0.2
> [ 2840.109353] lockd: cannot monitor 10.0.0.2
> [ 2843.286811] xs_tcp_setup_socket: connect returned unhandled error -107
> [ 2850.198791] xs_tcp_setup_socket: connect returned unhandled error -107
> 
> bd512e733 caused an early abort (therefore only "cannot monitor 10.0.0.2"
> appears).
> 
> Although there is suggestion, how to fix the problem in kernel [2]:
> 
>     > Maybe rpcb_create_local() shall detect that it is not in root
>     > netns, and only try AF_INET connection to > localhost in that case.
> 
>     That would be simple and might be sensible.  IF changing the AF_UNIX
>     path to "/run/rpcbind.sock" isn't sufficient, then testing for the
>     root_ns is probably the best second option.
> 

Was it determined that changing the location of the socket wasn't
sufficient to fix this? FWIW, My Fedora 38 machine seems to listen on
that socket already:

    [Socket]
    ListenStream=/run/rpcbind.sock

-- 
Jeff Layton <jlayton@kernel.org>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
