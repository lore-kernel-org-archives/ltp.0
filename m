Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED82BC04A68
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 07:28:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57EB73C61C3
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 09:28:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 360743C0EF2
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 09:28:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 95F18600917
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 09:28:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 89CB620462;
 Wed, 27 Jul 2022 07:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658906904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e+0QBn6bHEJhEkh3ANzwshggi9ndZFsbPZrdyGFjAbo=;
 b=NA2xBPyu5ll5SYwi86DFQofDUtZEpoGW/mI6jY/y/mkgOHpVBl5D0Vl3XzM7lzrK51N5ch
 2t7ZfeapFFKVErWp6Z+RffvM4SKF5uX4IDKMmpSnAbyN1TS9ERwqM/iWxpOzMdSvHNB65G
 n057QnO/AVHGvv4dvWtYc7e9BsNRjBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658906904;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e+0QBn6bHEJhEkh3ANzwshggi9ndZFsbPZrdyGFjAbo=;
 b=LYzIXZUhq6Tyfk8e1yih5xkLU6U2TCNwmqHTW8ojV3Rtne8J1cXS3tRW+b4XHrjoPasUfp
 Bs9zopnqnWxYLFDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC50B13AD7;
 Wed, 27 Jul 2022 07:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c41MKhbp4GKMEgAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 27 Jul 2022 07:28:22 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Jul 2022 12:58:20 +0530
Message-ID: <4729784.GXAFRqVoOG@localhost>
Organization: SUSE
In-Reply-To: <YtAXuBDka4VC90q/@pevik>
References: <20220714124611.9772-1-akumar@suse.de> <YtAXuBDka4VC90q/@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] open06.c: convert to new LTP API
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Thursday, July 14, 2022 6:48:48 PM IST Petr Vorel wrote:
> Hi Avinesh,
> 
> > -	if (mknod(fname, S_IFIFO | 0644, 0) == -1)
> > -		tst_brkm(TBROK, cleanup, "mknod FAILED");
> > +	SAFE_MKFIFO(TEMP_FIFO, 0644);
> You changed test from mknod() to mkfifo(). May I know why?
> It would be worth to mention the reason in the commit message.
> 
> Should not we keep mknod() ?
> SAFE_MKNOD(TEMP_FIFO, S_IFIFO | 0644, 0);
> 
> According to man mknod(2) your change is correct:
> 
>        POSIX.1-2001 says: "The only portable use of mknod() is to create
>        a FIFO-special file.  If mode is not S_IFIFO or dev is not 0, the
>        behavior of mknod() is unspecified."  However, nowadays one
>        should never use mknod() for this purpose; one should use
>        mkfifo(3), a function especially defined for this purpose.
> 
> Also note LTP tests should test even deprecated kernel API, we *might* want to
> test both mkfifo() and mknod() via .test_variants. But I'd like to hear the
> input of the others, because both glibc and musl use SYS_mknod or SYS_mknodat
> for mkfifo() implementation with very thin wrapper, thus not sure if it's worth
> to test also mknod().
I changed to SAFE_MKFIFO as it seemed more intuitive in this open() test,
but yes, I should have mentioned it in the commit message.
I have not checked the mkfifo() implementation in libraries, so please
lmk which one to proceed with here, I will send updated version if needed.

> 
> Kind regards,
> Petr
> 

Thanks,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
