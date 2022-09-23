Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C454C6FA82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 12:27:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34FE43CAD7D
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 14:27:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78F903CAC98
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 14:27:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B58C21A016E8
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 14:27:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9C53E21A4F;
 Fri, 23 Sep 2022 12:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663936038;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ozj86BB6kKFpgsbY5yGHzl2oKUebYrvE0ZQAukaPlIc=;
 b=IavLfsDBVDXs64iE6F7qzVbbJ6VCSNtdDMMMQ7NZKvh1quvHeE2kSvMyBYsBKV1eZUZEb/
 T7g5f9AEPA9BpO6asfoqMaEbKI0SewnjMNnv4QHEsUO9nGgk335svgJKnY6A/nX4Ueuv3k
 SC9GwDIhPYRySSqpbndwRpZ9IGyo/oM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663936038;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ozj86BB6kKFpgsbY5yGHzl2oKUebYrvE0ZQAukaPlIc=;
 b=okZaxTrUJ1FcCP16f+Oa81FnLCZcBZynd7BQK/LuajPajUqadVswKPQWedO6hf9nJL05zq
 34stjkKTNV3ZofDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63ED613A00;
 Fri, 23 Sep 2022 12:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qmfjFiamLWN7dAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Sep 2022 12:27:18 +0000
Date: Fri, 23 Sep 2022 14:27:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yy2mJCM79G1uRlhM@pevik>
References: <20220923105554.28942-1-pvorel@suse.cz>
 <20220923105554.28942-2-pvorel@suse.cz> <Yy2g9mGQJcc9d4oN@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yy2g9mGQJcc9d4oN@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] tst_test.sh: cd to $LTPROOT before umount
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
> > It's safer not to expect tests go away from the mountpoint
> > before trying to unmount it, because tests can cd to $TST_MNTPOINT
> > if they use TST_MOUNT_DEVICE=1. Also better to handle it in the library
> > than in all tests which may need it.

> > This fix ima_keys.sh and other following IMA/EVM tests which fail on
> > systems with tmpfs on $TMPDIR since 1f6bd6e66:

> >         ima_keys 1 TCONF: IMA policy does not specify '^measure.*func=KEY_CHECK'
> >         tst_device.c:255: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long

> >         Usage:
> >         tst_device acquire [size [filename]]
> >         tst_device release /path/to/device
> >         tst_device clear /path/to/device

> >         ima_keys 1 TWARN: Failed to release device '/dev/loop0'
> >         rm: cannot remove '/tmp/LTP_ima_keys.YArl935DCg/mntpoint': Device or resource busy

> > Fixme: 1f6bd6e66 ("tst_test.sh: Add $TST_ALL_FILESYSTEMS")
>   ^
>   Fixes?
Lol, thanks for spotting this.

> Otherwise:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
