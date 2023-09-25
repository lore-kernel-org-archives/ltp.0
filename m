Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4131CE7AAF
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 17:41:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6295A3CE221
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 19:41:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54AAE3C8524
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 19:41:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1F6091000A03
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 19:41:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 98F182183B;
 Mon, 25 Sep 2023 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695663659;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QVFxK1HnsBIGMWMJIaOzA7cKlW1dJGqffK/j3ErB/tQ=;
 b=gKiV3Pz9QcqDOG5KcCOv4/cxRtl0N8fq/MgouD19pHRChn6048NX6l8cIGavGnVwmKsHb5
 5vUeu9fg+oMDsuK8XVTxg4B3Igsgaiu7gY7+Rh4Jx3IGXKrXGgPtymBL5QcjxEbDC1lo1w
 q/OqEKgYhDZmA6pUEYd4ZX1TRti+whw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695663659;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QVFxK1HnsBIGMWMJIaOzA7cKlW1dJGqffK/j3ErB/tQ=;
 b=7vXbj6lWsXDGb4i19kr6WnH5TTVkpNEwK1Iql41NXWkSzdmL3LwrKswv8vFOkgNVenoawW
 GKG+pr/iodqtauDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A3C213580;
 Mon, 25 Sep 2023 17:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pkQuGCvGEWWgGgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Sep 2023 17:40:59 +0000
Date: Mon, 25 Sep 2023 19:40:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230925174057.GA90566@pevik>
References: <20230919114701.15327-1-mdoucha@suse.cz>
 <20230919114701.15327-4-mdoucha@suse.cz> <ZQ2Dth3NZO2rhzXP@yuki>
 <20230925132449.GD60471@pevik>
 <681b8c4b-1965-40ae-4489-ace37f45dad1@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <681b8c4b-1965-40ae-4489-ace37f45dad1@suse.cz>
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

...
> > > > -			umount $local_dir
> > > > +			umount $local_dir || tst_res TFAIL "Unmount failed"

> > > I suppose that this should be TBROK instead. And that this, apart from

> > Right, TBROK looks to be the best.
> > Martin, if you're ok with the change, I'll update it before merge (after the
> > release).
> I don't see the point. This is a cleanup function. The TBROK will be changed
> to TWARN and the test will continue anyway.

But TFAIL in cleanup function looks to me strange as well. Should we endup with
TWARN then?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
