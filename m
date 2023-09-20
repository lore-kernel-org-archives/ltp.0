Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1FDCE79AA
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 11:27:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E2643CE174
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 13:27:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C17D3C0041
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 13:26:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 55DFA1401199
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 13:26:57 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C80B221A1B
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 11:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695209216;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ScaYXxlqiZiQloZjqXR2gvUnL78Dey4Gs8fvZ4Qbqeo=;
 b=SBOTchDMYdVmJGP1VhaW8nfrBaEPQx+qDMToMM9WanmWutrPICOfLZoP5ug7Sdl2ssMAtI
 ISTdWhRzDZaWVaKrg1Wq7JIXncRHNt9+7/MBEw/5w32Ewz91HvmtzB9wFba0q9VMiPF/W6
 ZOXcn+WlZ6lL0e1xMUuzG1kOh88KqUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695209216;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ScaYXxlqiZiQloZjqXR2gvUnL78Dey4Gs8fvZ4Qbqeo=;
 b=anCTQhXkyemYwN/UZZXkuw1Hs0dH+6ovYksXVSbeBn8VKHXTWObxuRgdAf1DHVQM5FZ3xz
 5hK420BTHM2/pwAg==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7DA2E2C142;
 Wed, 20 Sep 2023 11:26:56 +0000 (UTC)
References: <20230919114701.15327-1-mdoucha@suse.cz>
 <20230919114701.15327-2-mdoucha@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 20 Sep 2023 12:26:10 +0100
Organization: Linux Private Site
In-reply-to: <20230919114701.15327-2-mdoucha@suse.cz>
Message-ID: <87jzslf5kx.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] nfs_lib.sh: Log NFS mount and unmount
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


Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Martin Doucha <mdoucha@suse.cz> writes:

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index abf7ba5a2..a996f7cc8 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -191,7 +191,9 @@ nfs_setup()
>  
>  		remote_dir="$(get_remote_dir $i $type)"
>  		nfs_setup_server "$remote_dir" "$(($$ + n))"
> -		nfs_mount "$(get_local_dir $i $n)" "$remote_dir" "-o proto=$type,vers=$i"
> +		local_dir="$(get_local_dir $i $n)"
> +		tst_res TINFO "Mounting $local_dir"
> +		nfs_mount "$local_dir" "$remote_dir" "-o proto=$type,vers=$i"
>  
>  		n=$(( n + 1 ))
>  	done
> @@ -210,7 +212,10 @@ nfs_cleanup()
>  	local n=0
>  	for i in $VERSION; do
>  		local_dir="$(get_local_dir $i $n)"
> -		grep -q "$local_dir" /proc/mounts && umount $local_dir
> +		if grep -q "$local_dir" /proc/mounts; then
> +			tst_res TINFO "Unmounting $local_dir"
> +			umount $local_dir
> +		fi
>  		n=$(( n + 1 ))
>  	done
>  	sleep 2
> -- 
> 2.42.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
