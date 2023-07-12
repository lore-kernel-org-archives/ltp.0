Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79790EB64DA
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 10:28:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A81C33CECF7
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 12:28:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 555733C0424
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 12:28:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 691F9600041
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 12:28:15 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D805E616F5;
 Wed, 12 Jul 2023 10:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B711C433C8;
 Wed, 12 Jul 2023 10:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689157692;
 bh=oQlkjIo7H+tZ3xk0sqmoRP6tmOypxWcNLa41lRtM1Hk=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=f2qYoPngKZpU/Vy7qpJKQDjAeFQdDCQg4HKfYzgHmYV/HBODtm4eoUbt60gL+MyjQ
 2Fq+fvrMD6jcZylIpRx1rFrt6okXYDgQb2st9/wrZj80cdV6zn+iolwRv2YC6+RxrJ
 fihjnEbdj6MIp+jPnBxMoVebpnrQE5zh/YtEgsBDs+rR+hkxjHRxw8Wuldm9FGb6HS
 49GadWj/MzzxBGeO10j1us7CdYa0zneJsRVUAdlogJ/QJq7OYgeOQrdfQ6PRLwFECm
 XVvddbPjKa/dQOxw1JjO0hfQkGlRHULhnKWBmgI8wvB/x98LnW7oUwM5UHV/gYh5xF
 ugC++rQ5SVHeg==
Message-ID: <e4d22ae6cefb34463ed7d04287ca9e81cd0949d8.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Wed, 12 Jul 2023 06:28:10 -0400
In-Reply-To: <20230622084648.490498-1-pvorel@suse.cz>
References: <20230622084648.490498-1-pvorel@suse.cz>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] runtest/net.nfs: Run nfs02_06 on TCP only
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
Cc: Olga Kornievskaia <olga.kornievskaia@gmail.com>,
 Chuck Lever <chuck.lever@oracle.com>,
 Anna Schumaker <Anna.Schumaker@Netapp.com>, linux-nfs@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 2023-06-22 at 10:46 +0200, Petr Vorel wrote:
> UDP support disabled was on NFS server in kernel 5.6.
> Due that 2 of 3 nfs06.sh tests runs are being skipped on newer kernels.
> 
> Therefore NFSv3 job in nfs02_06 test as TCP. This way all jobs in the
> test are TCP, thus test will not be skipped. This also bring NFSv3
> testing also under TCP (previously it was tested only on UDP).
> 
> Keep UDP in nfs01_06 jobs, so that NFSv3 on UDP is still covered for
> older kernels.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/net.nfs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/runtest/net.nfs b/runtest/net.nfs
> index 72cf4b307..15a960017 100644
> --- a/runtest/net.nfs
> +++ b/runtest/net.nfs
> @@ -58,7 +58,7 @@ nfs41_ipv6_05 nfs05.sh -6 -v 4.1 -t tcp
>  nfs42_ipv6_05 nfs05.sh -6 -v 4.2 -t tcp
>  
>  nfs01_06  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
> -nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "udp,tcp,tcp,tcp,tcp,tcp"
> +nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
>  nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
>  
>  nfs3_07 nfs07.sh -v 3 -t udp

UDP support is more or less being deprecated at this point, so testing
on tcp is preferred.

Acked-by: Jeff Layton <jlayton@kernel.org>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
