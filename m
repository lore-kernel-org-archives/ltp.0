Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801A2C38145
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 10:22:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A12ED3CA8C0
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 12:22:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F6853CA644
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 12:22:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D2B101A003D0
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 12:22:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D01C21011;
 Fri,  2 Sep 2022 10:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662114148;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mxpkb9W/49qWlMmnKn9tw9EQQhgGwVnLpsIEi1G23B8=;
 b=bs1B8ChPK+nh9He8YwD1Gci7qqwxd8yy7AyJw9KkvK3dt1smxzkZKGyHl19YFwDGZnoIOM
 bUxQw72KkR4trWbAgtHFJK0UV22s/Xlo0e3uHdS4XiTLxx4u0rm6T1NdnROh4RhYTq7wRh
 2Ga7kx8P992KmfHOhT0sMUC7XBEDUtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662114148;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mxpkb9W/49qWlMmnKn9tw9EQQhgGwVnLpsIEi1G23B8=;
 b=2vRxh0frW9m9WCaY0/VE+T+Cc0aP2ds7LNEq+eFl4bnt0rhCqFo4DD06fbs0S95WPNlh7N
 iu/X8OfcgyLsPODg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C46C13328;
 Fri,  2 Sep 2022 10:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id t+igHGPZEWNKKgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 02 Sep 2022 10:22:27 +0000
Date: Fri, 2 Sep 2022 12:22:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YxHZYRyIRrCe4QDX@pevik>
References: <20220804121946.19564-1-pvorel@suse.cz>
 <20220804121946.19564-2-pvorel@suse.cz> <87bkry2kv8.fsf@suse.de>
 <YxHOEQwMwvhmq8Mh@pevik> <878rn2151o.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878rn2151o.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 01/10] tst_test.sh: Fix tst_mkfs() for tmpfs
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
Cc: ltp@lists.linux.it, automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Richie,

> >> Hello,

> >> No response and seems reasonable, please merge!

> >> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
> > Thanks a lot for your review! I suppose you mean your ack for whole patchset.

> > If yes, I'll merge all but the last RFC commit which needs more work (i.e.
> > TST_ALL_FILESYSTEMS infrastructure although nothing uses it yet).

> > Merging would help me not having to rebase this work after finishing and get
> > merged "Track minimal size per filesystem" [1] (originally I thought that one
> > would go first, but TST_ALL_FILESYSTEMS infrastructure is ready now).

> > I also plan to convert df01.sh and mkfs01.sh to TST_ALL_FILESYSTEMS.

> > Kind regards,
> > Petr

> > [1] https://patchwork.ozlabs.org/project/ltp/list/?series=315621

> OK, I have acked everything that didn't already have a review tag. It
> would help to include some test conversions in the patch set, but I
> trust you will follow up with df01.sh and mkfs01.sh ;-)

Thanks! As I found that there is tiny issue in TST_ALL_FILESYSTEMS
implementation (there should be equivalent of tst_device->fs_type)
I've merged patches up to "[v3,04/10] tst_mount_device.sh: Cover early
tst_umount call" and send v4 with fixed this version and converted at least one
of df01.sh and mkfs01.sh. Then I base "Track minimal size per filesystem"
patchset on this work (suppose this patchet will be quickly re-reviewed).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
