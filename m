Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2049C6FA82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 12:03:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3175E3CAD82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 14:03:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 876B73CAC98
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 14:03:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B5FAA20109E
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 14:03:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A06651F947;
 Fri, 23 Sep 2022 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663934593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eQuDWh+q6fq+JmQWa7X1AdSBlqLe1ZSfTQaTwjZsevs=;
 b=0rGk1W6Xpz+R1vuT0bfegWbMd0suVb4p1i2z1lO/DWjToOsdiZdAAkY3kYwEZVC1DQkVEC
 AUZMptPQwClPxOyUDOGMzOd5nW4HITgjZ1dB6NIOTn1FXvQATT/hMZry4LUJWXPrDndLvL
 coTtytwsBATcjWQswY0tvzVns63UcB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663934593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eQuDWh+q6fq+JmQWa7X1AdSBlqLe1ZSfTQaTwjZsevs=;
 b=zBjoafsFFyxQDnRzsX4NOCLz1dyQUHjAAqZXq0dF1g6WZ6ftjAOHIPhl8qwBbgC3BR1Svh
 9TCqwf02UtjNtrBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89AEE13A00;
 Fri, 23 Sep 2022 12:03:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LR9eIIGgLWO3aQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 23 Sep 2022 12:03:13 +0000
Date: Fri, 23 Sep 2022 14:05:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yy2g9mGQJcc9d4oN@yuki>
References: <20220923105554.28942-1-pvorel@suse.cz>
 <20220923105554.28942-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220923105554.28942-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> It's safer not to expect tests go away from the mountpoint
> before trying to unmount it, because tests can cd to $TST_MNTPOINT
> if they use TST_MOUNT_DEVICE=1. Also better to handle it in the library
> than in all tests which may need it.
> 
> This fix ima_keys.sh and other following IMA/EVM tests which fail on
> systems with tmpfs on $TMPDIR since 1f6bd6e66:
> 
>         ima_keys 1 TCONF: IMA policy does not specify '^measure.*func=KEY_CHECK'
>         tst_device.c:255: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long
> 
>         Usage:
>         tst_device acquire [size [filename]]
>         tst_device release /path/to/device
>         tst_device clear /path/to/device
> 
>         ima_keys 1 TWARN: Failed to release device '/dev/loop0'
>         rm: cannot remove '/tmp/LTP_ima_keys.YArl935DCg/mntpoint': Device or resource busy
> 
> Fixme: 1f6bd6e66 ("tst_test.sh: Add $TST_ALL_FILESYSTEMS")
  ^
  Fixes?

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
