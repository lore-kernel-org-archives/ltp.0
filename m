Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BC5C433EF
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 16:19:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4F063C1041
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 17:19:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D8143C0512
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 17:19:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8FE861401219
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 17:19:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7C9F1F440;
 Mon, 28 Feb 2022 16:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646065146;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uH89fOV+O4TcQdba98j/yOzjdDdwZZCCb4pBhL7j8g4=;
 b=veZNgNzrPyuI3LvayUViD3VktrbrRGMPpPdMwLZw70uDfALaMofzEoTR7xoFjV95W1trZB
 MgDs7L+YOz72+/f4nR1DSzrgNm0ZLPOKjGPL8KGlQHtCetD7Ob+j2qqHLVbknqryGoezyF
 HdNuX5nDr3PX0ZLECc0dtN6tNh3VTzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646065146;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uH89fOV+O4TcQdba98j/yOzjdDdwZZCCb4pBhL7j8g4=;
 b=6K+7JWus0OWg9JGiGYqCLmmuFYGTsoWtsw2yM3y1F1nAcyMoSof+UX/nIcESBeBDSQESPh
 TLQ/hcvazgNlmMCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5ED0413C4F;
 Mon, 28 Feb 2022 16:19:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M1pRFPr1HGLNDwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 28 Feb 2022 16:19:06 +0000
Date: Mon, 28 Feb 2022 17:19:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yhz1+H3SAlwPaO8H@pevik>
References: <20220223153243.317-1-pvorel@suse.cz>
 <20220223153243.317-3-pvorel@suse.cz>
 <6216E3ED.1050700@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6216E3ED.1050700@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] quotactl08: Use do_mount()
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> Hi Petr
> > to change
> > quotactl08.c:160: TBROK: mount(/dev/loop0, mntpoint, ext4, 0, (nil)) failed: ESRCH (3)
> I doubt why fs quota is not supported on this case since we have check
> kernel config?

There is probably bug on the SUT, thus it might be correct it fails.

But how about martin's fix 4aab31e4c7 ("syscalls/quotactl: Skip tests if FS
quota is not supported") - quotactl04.c also checks for CONFIG_QFMT_V2 and uses
do_mount(). I'll check whether it was another bug on the system.

Kind regards,
Petr

> Best Regards
> Yang Xu

> > to TCONF if FS quota is not supported (the same fix as 4aab31e4c7).

> > Signed-off-by: Petr Vorel<pvorel@suse.cz>
> > ---
> >   testcases/kernel/syscalls/quotactl/quotactl08.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/testcases/kernel/syscalls/quotactl/quotactl08.c b/testcases/kernel/syscalls/quotactl/quotactl08.c
> > index 3793867f23..9f54bebcc0 100644
> > --- a/testcases/kernel/syscalls/quotactl/quotactl08.c
> > +++ b/testcases/kernel/syscalls/quotactl/quotactl08.c
> > @@ -157,7 +157,7 @@ static void setup(void)
> >   	quotactl_info();

> >   	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> > -	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
> > +	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
> >   	mount_flag = 1;

> >   	fd = SAFE_OPEN(MNTPOINT, O_RDONLY);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
