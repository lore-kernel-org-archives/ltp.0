Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1075CE79AB
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 08:05:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EA353CDEB4
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 10:05:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 005773C9274
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 10:04:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B081C1400DD3
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 10:04:49 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1B08E1FD91
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 08:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695197089;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YVnd3vr7VL/tdV/Qll0Ch4tlW01bxMILrYRDCLexMU8=;
 b=GxDzzo49/e3Qp7HxrZQ6icjs8fRHgEf4URsb19o0DF7XiFkTAMA9mWXLjGZwTygYZzPktf
 WxHJROEbVmS0tBm8mfzgfhXpsZzAWXyTBqzwE48HY+Hf5DUI5PM7+BgKvEHTB+dFA8rUwa
 TPAL1GSUMyoSXJZfz2I26kSCU2w9hrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695197089;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YVnd3vr7VL/tdV/Qll0Ch4tlW01bxMILrYRDCLexMU8=;
 b=qNgfEs1/pW/o9Ro/39yc5zJz4dfCD/r1WJ9V2P5kb75mlzx1ec81nORtXuWCidhtw8N6OP
 IgbZEr+jSG4GeiDQ==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C5FAF2C142;
 Wed, 20 Sep 2023 08:04:48 +0000 (UTC)
References: <20230919114701.15327-1-mdoucha@suse.cz>
 <20230919114701.15327-3-mdoucha@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 20 Sep 2023 08:59:12 +0100
Organization: Linux Private Site
In-reply-to: <20230919114701.15327-3-mdoucha@suse.cz>
Message-ID: <87o7hxfexs.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] nfs03.sh: Wait for all files to be removed
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Martin Doucha <mdoucha@suse.cz> writes:

> A race condition between the two parallel calls of rm_files may cause
> NFS unmount to fail and then the NFS client will get confused by remote
> filesystem change which leads to strange failures. Make sure both
> rm_files calls finish before returning from the main test function.

You mean unmounting fails if there are still operations in progress?

Like does umount fail with EBUSY?

>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/network/nfs/nfs_stress/nfs03.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/testcases/network/nfs/nfs_stress/nfs03.sh b/testcases/network/nfs/nfs_stress/nfs03.sh
> index e5f4de67c..e9ef5fb78 100755
> --- a/testcases/network/nfs/nfs_stress/nfs03.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs03.sh
> @@ -66,11 +66,13 @@ do_test()
>  	cd ../dir1
>  	wait $pid1
>  	rm_files &
> +	pid3=$!
>  
>  	tst_res TINFO "cd dir2 & removing files"
>  	cd ../dir2
>  	wait $pid2
>  	rm_files
> +	wait $pid3
>  
>  	tst_res TPASS "test done"
>  }
> -- 
> 2.42.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
