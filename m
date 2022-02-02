Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75CBC433F5
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 07:39:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37DE03C98AF
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 08:39:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF42F3C8DAA
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 08:39:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 50E1E60055F
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 08:39:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D12A1F37C;
 Wed,  2 Feb 2022 07:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643787556;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A8K/6WvJcgiofX2qf79FaIHae7pDdT6/b7OlO7nthdg=;
 b=I7yeQbvV6Ql8xBZf4dVWoah8nHO1UA8c8BRiMTai0dAmeL7LdhH8OZ3HdmZ/YDe+rrsXnC
 5Bzndtdn6E0i5biPJ2VItHP2hSCxhzi3NmNjaM7awL2OCGrBmFTMlAM102YKcKo5i4KpSl
 916S52EarzVtkbxn7kTqww7kPzfmbh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643787556;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A8K/6WvJcgiofX2qf79FaIHae7pDdT6/b7OlO7nthdg=;
 b=DfhwdxGMim5Y67UUimp8ulZi3Vs5LSiCF08wWy86VRG7SQiuuCeRGnXfkrhiyJ6tljyVu3
 Vhx+PS128d5jstBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 135B613B95;
 Wed,  2 Feb 2022 07:39:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LjaoAiQ1+mHbDwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 02 Feb 2022 07:39:16 +0000
Date: Wed, 2 Feb 2022 08:39:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yfo1IqGRdgQHzJCM@pevik>
References: <20220201094451.7651-1-pvorel@suse.cz> <YfkMR3oM/QD9a3I9@yuki>
 <YfkPfjqRz9j2Jbuw@pevik>
 <CAEemH2di8y4qiyn45EOgdxQo-oebEsZRhYmyCfkifpvS1rpsaw@mail.gmail.com>
 <YfkueuaAfXqVGOO5@yuki> <YflOvov3Ui9OxRPf@pevik>
 <CAEemH2ff=hhWw=xKoaKz7cixCYQbh=iy6b202ZmtwL+b2c9stQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ff=hhWw=xKoaKz7cixCYQbh=iy6b202ZmtwL+b2c9stQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ci: Remove CentOS 8
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

> On Tue, Feb 1, 2022 at 11:22 PM Petr Vorel <pvorel@suse.cz> wrote:

> > > Hi!
> > > > > We have CentOS 7 (EOL 2024) and also fedora:latest, which is 35
> > > > > (their devel called rawhide is currently 36).

> > > > Is there any possibility to convert from CentOS 8 to CentOS Stream 8?

> > > Is there an official docker image for it? As far as I can tell I do not
> > > see it at: https://hub.docker.com/_/centos

> > Here some unofficial:
> > https://hub.docker.com/r/tgagor/centos-stream
> > => I'm not sure if we want to use unofficial

> > which also mention official at quay.io:
> > https://quay.io/repository/centos/centos?tab=tags
> > => we'd have to figure out how they could work with GitHub Actions.
> > Li, feel free to look into it.

> Sure. Thanks for the info.

> Ps.
> I'm not good at deploying CI/CD but will try to figure out that.
> Will send a patch if I can achieve it.
Thanks! Appreciate, because I have other TODO list with automation via GitHub
Actions and I've spent quite a lot of my time with CI already.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
