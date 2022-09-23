Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC70C6FA82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 11:57:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F118F3CAD73
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 13:57:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A915C3CAD4C
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 13:57:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D3DD56011E4
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 13:57:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E20C91F8FE;
 Fri, 23 Sep 2022 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663934239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kmhBvwPiXDgGlTKtvbkIPwnombMFYiptdrTj1YuWbbc=;
 b=NaO6ToA7Aj9u6eYWOAO7lErV0PoOMZTCeZpqV/jOGRYjiQ6QRQEeOkhDSM+LFZx4cvh17n
 XStqXoUILibQL/bShLjQGu2l3+Pz8pIEAfQev6hihDCFBgcjEHPGIrHjsmlbKjLPvxWoXP
 pl+2kzheun1hN1JckpC/+drfZIELU9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663934239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kmhBvwPiXDgGlTKtvbkIPwnombMFYiptdrTj1YuWbbc=;
 b=/t60TLnVDsIBraltM0LZPidqSl1BN196x10GDEquy9Wiqe7aNRqQ5ViZsN3jHA28NYESUN
 bO8hDrSj6VA1WuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D14BA13A00;
 Fri, 23 Sep 2022 11:57:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZJNRMh+fLWOLZgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 23 Sep 2022 11:57:19 +0000
Date: Fri, 23 Sep 2022 13:59:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yy2fle1RVT/P+mJa@yuki>
References: <Yxr+EpKTnKQbKXTb@yuki> <YyiLZoSRWPgs8Cfh@pevik>
 <Yy2SGpSyfDeApR5o@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yy2SGpSyfDeApR5o@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > ima_keys 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> > ima_keys 1 TINFO: Formatting ext3 with opts='/dev/loop0'
> > ima_keys 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_keys.YArl935DCg/mntpoint
> > ima_keys 1 TCONF: IMA policy does not specify '^measure.*func=KEY_CHECK'
> > tst_device.c:255: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long
> 
> FYI I've fixed this in patchset "IMA + shell API fixes on umount" [1] [2]
> which depends on 2 other patchsets.

Will have a look.

I've tried to merge several smaller fixes during the week. Is there
anything else to consider for inclusion?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
