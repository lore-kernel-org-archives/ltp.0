Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DAAC433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 06:20:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A4C63CAE86
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 08:20:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A95693C1B92
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 08:20:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C81E71400B7C
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 08:20:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E65E6218EE;
 Mon, 10 Oct 2022 06:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665382826;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQP8NgxiOJ435WACefmMcvpeTpZErmGvhIkuumS+YVs=;
 b=Wy4ufoWa7PhSK50Kj/r92Pg5oL8jKZVg6Td+gvt3O92uXq83/KXquO9xe6OICHq64GU5lr
 VB/ff7zwW7FMuyRk7u1GJ/Ygechtk/KJ4bzTip+q7bDXpPt4eMFmqT8DmGPHoZi9yyNOgW
 C/6dopD4HwTdV7SuCMJLnB+Y0nwCyRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665382826;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQP8NgxiOJ435WACefmMcvpeTpZErmGvhIkuumS+YVs=;
 b=X3cb4RNZ4f+1F6But9JMswoH4uFnCWsSvgw/l6NhL6os4mQ4KoHIOZNVYPtDBEyuC8HBLt
 SqGQwuWxwprAM5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC80A13479;
 Mon, 10 Oct 2022 06:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3DY/LKq5Q2POOgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 10 Oct 2022 06:20:26 +0000
Date: Mon, 10 Oct 2022 08:20:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y0O5qUOsKZsUDauG@pevik>
References: <20220930091208.5688-1-pvorel@suse.cz> <Yza1B8t2LOueCVUC@yuki>
 <Yza2jwpow0uhaLHu@pevik> <Yza4a2Icm+M9cTiK@yuki>
 <Yzbvg36XX5pVCFkB@pevik>
 <CAEemH2d7B5wXbvj71zN-=VHpRxjO-67_oH_5-87HZrTEfPwypg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d7B5wXbvj71zN-=VHpRxjO-67_oH_5-87HZrTEfPwypg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] zram01.sh: Fix minimal size for XFS on
 kernel 5.19
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

Hi Li,

> Hi Petr, Cyril,

> Thanks for moving on this, and good to see the new released.
> I had to suspend work and deal with some family matters last week,
> so sorry for the later reply.
No problem, understand, hope everything is OK on your side.
And thank you for your work, you're one of the most active reviewers.

Kind regards,
Petr

> On Fri, Sep 30, 2022 at 9:30 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi all,

> > Tested on affected 5.19 kernel and various older SLES kernels.
> > Therefore merged.

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
