Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5959ACE79CD
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 11:28:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77AB13CDED4
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 13:27:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 977AB3C0041
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 13:27:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0FF411001F42
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 13:27:47 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0296821E46
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 11:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695209267;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GD2VJibjFLsJxMNntLbIgcy/bOgKWWq1B3StBI/j1XE=;
 b=PnwiPte3nLwlvLIridgo1OSWLuFqCVa0xM9EuFXjUVlpoNxCT37Y8w1LEn/Z1BIrsx6UGy
 ti0GVSVwcIWxHMZnFPqjVUKn3mzaLzl5+n2YRStLCiss13/EApcc/QOp7zCmdRIOce9ym+
 q47lIjHeM8H/y7Cjz6FP1sDRviYSggs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695209267;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GD2VJibjFLsJxMNntLbIgcy/bOgKWWq1B3StBI/j1XE=;
 b=67ScSC/znPLMzFXeeLXVrcfEpcPuqagcAATCQUdsME/yESjromQx/dPEob0rePzK5aMNhQ
 8ZYcMEq8Dvs3ikAA==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id AD0F12C142;
 Wed, 20 Sep 2023 11:27:46 +0000 (UTC)
References: <20230919114701.15327-1-mdoucha@suse.cz>
 <20230919114701.15327-4-mdoucha@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 20 Sep 2023 12:27:38 +0100
Organization: Linux Private Site
In-reply-to: <20230919114701.15327-4-mdoucha@suse.cz>
Message-ID: <87fs39f5ji.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] nfs_lib.sh: Fail the test if NFS unmount fails
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
>  testcases/network/nfs/nfs_stress/nfs_lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index a996f7cc8..099c78759 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -214,7 +214,7 @@ nfs_cleanup()
>  		local_dir="$(get_local_dir $i $n)"
>  		if grep -q "$local_dir" /proc/mounts; then
>  			tst_res TINFO "Unmounting $local_dir"
> -			umount $local_dir
> +			umount $local_dir || tst_res TFAIL "Unmount failed"
>  		fi
>  		n=$(( n + 1 ))
>  	done
> -- 
> 2.42.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
