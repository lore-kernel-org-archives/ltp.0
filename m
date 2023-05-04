Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA5CC77B78
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 13:57:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA09B3CE0E8
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 15:57:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFDE73CB749
 for <ltp@lists.linux.it>; Thu,  4 May 2023 15:57:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 211F4200AF1
 for <ltp@lists.linux.it>; Thu,  4 May 2023 15:57:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4991B223B7;
 Thu,  4 May 2023 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683208633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yErvE/CQwOKfoZxtMaL3WaZmx5CmbYeLnDjk1/0iieY=;
 b=GQlbHpOvT6jfcvutjjEtcxveT0343g2wKji2LOA1q9Ro2Yjy+JEBD+JEBTtY55dGVIHpHb
 kkD5yk8m+9WaECk6D22d0omo7ZaKNJuynftCGCGGFssF5MomJexWCGMkIVZ7ZmCfyn5ZYJ
 Zn15E44qvBr5PN6W3GKOaLTqhXNPF2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683208633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yErvE/CQwOKfoZxtMaL3WaZmx5CmbYeLnDjk1/0iieY=;
 b=n95AYjdMrNMoqtzuoQ75ehRY8kt/RKepUDvTkP0FJIPhCRyBEle9DiiiKreXPChv0u0Hgm
 i4QCY2M86YMvsQDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3529113444;
 Thu,  4 May 2023 13:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tfmBC7m5U2SHbwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 04 May 2023 13:57:13 +0000
Date: Thu, 4 May 2023 15:58:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZFO597l50v9PEQPP@yuki>
References: <20230504131414.3826283-1-pvorel@suse.cz>
 <20230504131414.3826283-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504131414.3826283-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/5] nfs_lib.sh: Cleanup local and remote
 directories setup
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 52 ++++++++++++++-------
>  1 file changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index af7d46a21..1b5604ab5 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) Linux Test Project, 2016-2022
> +# Copyright (c) Linux Test Project, 2016-2023
>  # Copyright (c) 2015-2018 Oracle and/or its affiliates. All Rights Reserved.
>  # Copyright (c) International Business Machines  Corp., 2001
>  
> @@ -53,6 +53,24 @@ get_socket_type()
>  	done
>  }
>  
> +# directory mounted by NFS client
> +get_local_dir()
> +{
> +	local v="$1"
> +	local n="$2"
> +
> +	echo "$TST_TMPDIR/$v/$n"
> +}
> +
> +# directory on NFS server
> +get_remote_dir()
> +{
> +	local v="$1"
> +	local n="$2"
> +
> +	echo "$TST_TMPDIR/$v/$n"
> +}

It's a bit puzzling why we have two identical functions with a different
name...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
