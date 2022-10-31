Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACB2ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 12:54:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66DF43CABE4
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 13:54:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34A8D3C08D9
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 13:54:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7191620074B
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 13:54:30 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B8FF03372C;
 Mon, 31 Oct 2022 12:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667220869;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m1H8Div8Nk3AF3ROFmfSYd+p0vHglJ2PxqSeBFuhUw4=;
 b=zjRAcKT60oPTcyFgeTHPHfrqjjc96P4zvzssYq7bTTyR8D/JQc/XIGhwRxNw1OTIwsfa9r
 9Vm0agke+GOSFMrp1eyAQWClfdyEjGvYheO4afmhq3NwI3BucUUGFw7mYRWKDsgrDvrlGa
 WelD2hnxim9kAWh4wJJWafTW6VU4YIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667220869;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m1H8Div8Nk3AF3ROFmfSYd+p0vHglJ2PxqSeBFuhUw4=;
 b=Abym/EvcoKXnKYr7UJ0pymcFfAdao4wu1NZY2VjWU6oEgYjUo+HGVfzHad0PYiTpZIaP44
 G7e3dSxotu3c0xDg==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4163B2C141;
 Mon, 31 Oct 2022 12:54:29 +0000 (UTC)
References: <20221026140408.471609-1-alessandro.carminati@gmail.com>
 <20221026140408.471609-2-alessandro.carminati@gmail.com>
 <87fsf9sk2e.fsf@suse.de>
 <CAPp5cGQ++39EMSV3MrMTTKrTyn5WWRou=yP7f4jbBQ7p-F+cyA@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Mon, 31 Oct 2022 12:08:15 +0000
Organization: Linux Private Site
In-reply-to: <CAPp5cGQ++39EMSV3MrMTTKrTyn5WWRou=yP7f4jbBQ7p-F+cyA@mail.gmail.com>
Message-ID: <87y1swb1bv.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_find_backing_dev: Get dev name from
 /sys/dev/block/*/uevent
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
Cc: acarmina@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Alessandro Carminati <alessandro.carminati@gmail.com> writes:

> Hello Richard,
>
> Il giorno gio 27 ott 2022 alle ore 11:16 Richard Palethorpe <rpalethorpe@suse.de> ha scritto:
>
>  Hello,
>
>  Alessandro Carminati <alessandro.carminati@gmail.com> writes:
>
>  > In some minimal Linux the /dev/root can be missing. The consequence for this
>  > is that mountinfo doesn't contain the correct information.
>  >
>  > The unevent file in sysfs is another method to retrieve device info given 
>  > a major/minor.
>  >
>  > btrfs subvolumes can be an exception to this rule, but they are not expected
>  > to be used in the current usecase.
>
>  Unfortunately this is not true. If you mount /tmp on BTRFS (or set
>  TMPDIR to some BTRFS mount), then we hit this issue.
>
> This is also true if you use the mountinfo strategy.
> I ran a few tests on my test environment, and I could see that the ioctl_loop05 
> on btrfs filesystem doesn't work either with the mountinfo strategy.

OK, so to summarise niether strategy works when the FS is BTRFS and init
has not done something about /dev/root.

I suppose part of the problem is BTRFS can span multiple devices
(IIUC). So there is no definite single backing device.

The command "btrfs devices stat <path>", uses the BTRFS_IOC_DEV_INFO
ioctl to get backing device paths.

>
>  >
>  > This solution requires sysfs to be mounted in /sys, but considering many 
>  > tests depends on the same, including the ioctl_loop05 that triggered this 
>  > patch, this requirement is not too restricted, and the old mountinfo can be 
>  > dropped altogether.
>
>  The mountinfo method is not such a maintenance issue that it needs to be
>  removed IMO. Possibly it could be replaced by tst_stat_mount_dev
>  instead, but we're cautious about touching this function.
>
> tst_find_backing_dev(), the function that is the target of this patch, seems to 
> be referenced in only a couple of points in all the LTP test suite.
> One place is in the ioctl_loop05 test, the other reference I found is in the 
> lib/tst_device.c - tst_dev_block_size().  tst_dev_block_size() is a function 
> that seems not to be referenced by any test.
>  
>  
>  To be clear, I'm not sure anyone compiles Linux without /sys then tries
>  to run LTP on it. However the fact that it is possible to remove /sys is
>  another signal (in addition to BTRFS) that the situation is complicated.
>
> Indeed, if we want to have a test that works in all the possible scenarios, 
> it needs additional work. 
> But IMHO, keeping the mountinfo strategy gives no advantage over not 
> having it. 
>

Well it allows the test to work on BTRFS in most situations. Possibly if
we find that the FS is BTRFS, the device is /dev/root and it doesn't
exist. Then we should call tst_brk(TCONF...

AFAICT what the test actually wants is the block device sector size
(BLKSSZGET). Possibly this can be retrieved with the BTRFS_IOC_FS_INFO
ioctl.

The final option would be to try using some other BTRFS specific ioctl
to get the backing device(s). If there is more than one then just return
the first. That's probably not worth the effort for the current test,
but I think it is quite likely this issue will arise again. io_control01
has a similar requirement.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
