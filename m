Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC35CE7A94
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 13:25:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874F33CDD37
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:25:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E59E13C100C
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:24:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 721541401221
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:24:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E660221850;
 Mon, 25 Sep 2023 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695648290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/L/T4sfXtfbKihI9CHEAdmsfmU9jS+Gx7xGG2ULOBEE=;
 b=Ki+CPxL2TdabSrqoTS6jjaQRo/+KtHQBm1DpPwEd4qTdfsUGxBTsjl5kW8sI/pBLw46HOm
 ywILRoHc5EFCdif4A/gMe8PdzfUR1R8O4ylPxEaZAwQh0qKL7fWVuhGGGq/3E+UvStZT3e
 NRbMdaeoG65n5trOUE8Du9G+CpZVqjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695648290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/L/T4sfXtfbKihI9CHEAdmsfmU9jS+Gx7xGG2ULOBEE=;
 b=nTdh0L2RUTjrNg0aDNLF3ex7pPGdbZGMGuPKL7MqTl5BAR4httISRFwkFrvszPqM/1Mepc
 g7mH/pR0WLxYBbCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF8BD13580;
 Mon, 25 Sep 2023 13:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id s3jSMSKKEWVEDgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Sep 2023 13:24:50 +0000
Date: Mon, 25 Sep 2023 15:24:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230925132449.GD60471@pevik>
References: <20230919114701.15327-1-mdoucha@suse.cz>
 <20230919114701.15327-4-mdoucha@suse.cz> <ZQ2Dth3NZO2rhzXP@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQ2Dth3NZO2rhzXP@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > index a996f7cc8..099c78759 100644
> > --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > @@ -214,7 +214,7 @@ nfs_cleanup()
> >  		local_dir="$(get_local_dir $i $n)"
> >  		if grep -q "$local_dir" /proc/mounts; then
> >  			tst_res TINFO "Unmounting $local_dir"
> > -			umount $local_dir
> > +			umount $local_dir || tst_res TFAIL "Unmount failed"

> I suppose that this should be TBROK instead. And that this, apart from

Right, TBROK looks to be the best.
Martin, if you're ok with the change, I'll update it before merge (after the
release).

Kind regards,
Petr

> the previous patches, should be applied after the release.

> Otherwise:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
