Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50495C64EC4
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 16:56:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3AD43CD93A
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 17:55:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 704593C2A67
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 17:55:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7A2161000A37
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 17:55:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 717E81FE4E;
 Wed,  8 Mar 2023 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678294547;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bZtImNYNm+aIdxA4tex5+AkRBOzXc+ZQXXeVNQzb6vY=;
 b=K7WZR71KmbCC67n8XwPHRC6jdus+YgAXdieZTFUyrB65RfFq6XFU8GzTnQxF33/vk6B8U7
 B1ZRDCFiwxE/lSKAxBWvsv2F1EsFIy88ePrg1cd7zTn4g6tWFDiBC1U9lmHzHQeSTjVGUM
 BTVUJ+JbsR/bxmteU12Nmj+UnF3/T2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678294547;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bZtImNYNm+aIdxA4tex5+AkRBOzXc+ZQXXeVNQzb6vY=;
 b=oPfApPM6NsYKj30cLUkjDaKDBg27L4uKoOfA25d52xPIqLn3zMj/RvbK79TX6VwGgnoWwD
 VlFE7q00U0GiOGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BC3B1348D;
 Wed,  8 Mar 2023 16:55:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3Gw6DBO+CGS5QwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Mar 2023 16:55:47 +0000
Date: Wed, 8 Mar 2023 17:55:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrei Gherzan <andrei.gherzan@canonical.com>
Message-ID: <20230308165545.GA428998@pevik>
References: <20230216114745.2389810-1-andrei.gherzan@canonical.com>
 <Y++c8fBZxmUIR3Lb@pevik> <Y/N53BN2yr7WEIzr@qwirkle>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y/N53BN2yr7WEIzr@qwirkle>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fs_fill: Fix test when running on a 256 CPU+
 machine
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

Hi Andrei,

> > > The fs_fill test runs a fill test on all the supported filesystems. One
> > > of them being vfat. This filesystem is configured dynamically or through
> > > flags/arguments for its file allocation table type (12/16/32).

> > > The size of the test device (which is a loop-mounted fs) is 300MB. When not
> > > instructed, mkfs will "automatically select between 12, 16 and 32 bit,
> > > whatever fits better for the filesystem size"[1]. In the case of a 300Mb that
> > > would end up as FAT16.
> > Interesting. BTW we plan to change 300 MB to minimal filesystem which would fit
> > to all existing tests (255 MB was for Btrfs, 300 MB was for XFS, but there might
> > be minimal systems which can use vfat, ext4, ... with smaller resources, e.g.
> > 16 MB for filesystem). Therefore I wonder what is minimal reasonable required
> > size for vfat. i.e. what MB is required for FAT32? (I guess we don't want to
> > check FAT12 or FAT16).

> The minimum/maximum values depend on the sector size. I'm not sure about
> F12 but for the other ones I think it was 32MB for 512b sectors.

Thanks a lot for info. BTW I'm not convinced any more that using as smallest
loop device size as possible is a good idea.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
