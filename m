Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B773ECD4F5B
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 12:07:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C27B3CE36F
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 14:07:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 748483CDE37
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 14:07:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C3C09209A16
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 14:07:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F4B9218A0;
 Fri, 22 Sep 2023 12:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695384458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJSdYIlZqr+ESwNKWGZ0JOjg9VVVcSI5iaUNj/v22RM=;
 b=hPZOShgTGoXOCqrTBcKR+GJVK7YLHI2dRiYd1SczFLxi1jkVV4mEd9IqeqaPct0BN9VrcL
 dxbEi61J/Ft8qsXWXgxbr2dTU/uEJgf5+RB0wEFjF0PqbUtPW+NZtEcr6316b2RFngIPV5
 myrm9KyJGsmRCGUpvzRVN2Ts/Auc9bQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695384458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJSdYIlZqr+ESwNKWGZ0JOjg9VVVcSI5iaUNj/v22RM=;
 b=n2kv/1b3VO8/Xh7L8fFB0Y3t4PRk93wxsLKh6RrEUuufTrm8D3l054ZNQDA8Y6hyn9TMG4
 c05GjHi+gxI6fNAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD56713478;
 Fri, 22 Sep 2023 12:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1u6tMImDDWXPMgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 22 Sep 2023 12:07:37 +0000
Date: Fri, 22 Sep 2023 14:08:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZQ2Dth3NZO2rhzXP@yuki>
References: <20230919114701.15327-1-mdoucha@suse.cz>
 <20230919114701.15327-4-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230919114701.15327-4-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
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

I suppose that this should be TBROK instead. And that this, apart from
the previous patches, should be applied after the release.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
