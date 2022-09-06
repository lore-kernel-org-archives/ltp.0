Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42379ECAAA1
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 15:56:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 599D33CA97E
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 17:56:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A8B83C071D
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 17:56:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CD0E6200BD6
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 17:56:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 160EB33906;
 Tue,  6 Sep 2022 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662479774;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f98azXsKE46JZH23tz+lQ7eUH1r/BI1oWKJphXGxRVo=;
 b=NiHpCG/Om/D1gnFB1bUuinS+AUBVde7KiGjPoNKQATquqxqNE35rOa9tjzI2X/GQBSNzKo
 cDg6Wma+N6zLoOAAteAxc60nDPEcwE1vi/CjYgMKoCiwvdUXAqo55jfdiJ/s7iKogvkiq0
 6itkztrJUNZu0QE482oyQX4hAoxgkVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662479774;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f98azXsKE46JZH23tz+lQ7eUH1r/BI1oWKJphXGxRVo=;
 b=8x/IvrGBtcDrXrHZT/fyupMuzwZuDSrEhpky/nanbZ77MrZnO0poPWNmC/u9mnJ13w2Vb9
 9xfuUhvKiNRZfmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5A3C13A19;
 Tue,  6 Sep 2022 15:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Jzr4MZ1tF2MeKQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 06 Sep 2022 15:56:13 +0000
Date: Tue, 6 Sep 2022 17:56:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YxdtmzpGWY0d0aFW@pevik>
References: <20220906092615.15116-1-pvorel@suse.cz>
 <20220906092615.15116-4-pvorel@suse.cz>
 <CAOQ4uxitPLeqeaydDbG6=4eDU8=6wfFaSiih0bFXj0_DRdeMnA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxitPLeqeaydDbG6=4eDU8=6wfFaSiih0bFXj0_DRdeMnA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fanotify14: Use TST_EXP_FD_ERRNO()
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, Sep 6, 2022 at 12:26 PM Petr Vorel <pvorel@suse.cz> wrote:

> > That greatly simplifies the code.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Nice cleanup.
> You may add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> I don't think that this patch conflicts with the patch in my FAN_MARK_IGNORE
> series - if there are conflicts they should be trivial, so feel free to
> merge these cleanups either before or after merging my series.

Hi Amir,

thanks! I'll wait little longer if there is some feedback from LTP community
before merging.

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
