Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC29EC6FA82
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 12:16:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B1163CAD8C
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 14:16:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D96C3CAC98
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 14:16:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DF072201099
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 14:16:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7931321A38;
 Fri, 23 Sep 2022 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663935398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4HvFXN037gtv5nzciOHsRHbkLsa+jbXYFzw5HbQmV74=;
 b=RGP8Dnt/WdRHJ79ZyKspwS08qNbtrlNtNcIlX8KOJ9Ltypd2noDtWIrqn8zJbHuKlz0oDd
 fgiBS5OuNVxBrDvvL0RJ/ox1jKpIRqscjIQtpMGMBnKaCCZddrRyczsMg/Y01gBr5jqTIJ
 Kl7z+SdOZsa+1JoDTkN5mSZ8djvITuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663935398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4HvFXN037gtv5nzciOHsRHbkLsa+jbXYFzw5HbQmV74=;
 b=nIxesl6Q51+ePABXlGnvZtGhTnTnyZBmH8J1vfWyU2S8QgaapZgMXrxs5BhSSwCFqTB2T5
 Fzr2z+V1lVWRc8Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5178713A00;
 Fri, 23 Sep 2022 12:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eR6hEaajLWMocAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Sep 2022 12:16:38 +0000
Date: Fri, 23 Sep 2022 14:16:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yy2jpHOAu0J7MXVF@pevik>
References: <Yxr+EpKTnKQbKXTb@yuki> <YyiLZoSRWPgs8Cfh@pevik>
 <Yy2SGpSyfDeApR5o@pevik> <Yy2fle1RVT/P+mJa@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yy2fle1RVT/P+mJa@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > ima_keys 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> > > ima_keys 1 TINFO: Formatting ext3 with opts='/dev/loop0'
> > > ima_keys 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_keys.YArl935DCg/mntpoint
> > > ima_keys 1 TCONF: IMA policy does not specify '^measure.*func=KEY_CHECK'
> > > tst_device.c:255: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long

> > FYI I've fixed this in patchset "IMA + shell API fixes on umount" [1] [2]
> > which depends on 2 other patchsets.

> Will have a look.

> I've tried to merge several smaller fixes during the week. Is there
> anything else to consider for inclusion?

I wonder, if we want to document in C/shell API docs, that for skipping ext[2-4]
on tests which run on single filesystem we one needs to specify "ext2/ext3/ext4.
It has not been needed so far, thus may not be needed. I understood we're not
going to change this.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
