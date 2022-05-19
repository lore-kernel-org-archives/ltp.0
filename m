Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D46C433EF
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 10:25:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9EAC3CAAD9
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 12:25:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E2DE3C0CD0
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:25:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 82A911000A2D
 for <ltp@lists.linux.it>; Thu, 19 May 2022 12:25:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A473C1F86B;
 Thu, 19 May 2022 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652955927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6DSzhF6hSkBMGadYA1p8EdPpNmzayl9txR5lW2htFR8=;
 b=WSiuS4sxK/P4R8Gu8Pok5hZQLOjWBPPOsieXxnVAM/Inv4i2j3MR34QW9M0aqGpbV6BH/S
 Xaqfgm5WHc6CRQ7DNzDvlxZGvunbUX4Q/CKOJw4sh0wgXk963fM1W3uIgVKjJWVRYdsIbE
 ejGLswT6L0phEQf0N+d5aDU1w9DFq/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652955927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6DSzhF6hSkBMGadYA1p8EdPpNmzayl9txR5lW2htFR8=;
 b=HeHUyJBZ29Iclcq78AiE2NsXHa82Ty+Czno5zS8fJ8/K2pw+DTn2o6saeIBlPDmqQ6n38H
 ehGBVt8tfvYwpZBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8289013456;
 Thu, 19 May 2022 10:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kapnHhcbhmLSSQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 19 May 2022 10:25:27 +0000
Date: Thu, 19 May 2022 12:27:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YoYbm487vwfD8Wne@yuki>
References: <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
 <Yn5NGPpfoddFYTs2@yuki>
 <CAEemH2fHsa+JECK5dW64-coQBwdGR3W9W+jKex8zRmKzfLX1=w@mail.gmail.com>
 <Yn5prUjpZEUjoxbL@yuki> <875ym5di8f.fsf@suse.de>
 <YoN/W4wbow2fyOut@yuki>
 <CAEemH2cazgjqj4C1nuqPcRCC0dZoxwi-yiJymRgJxr0woXXFWw@mail.gmail.com>
 <CAEemH2dYwMczBhFj28yc9xDu0VBg50orjeQBK2s13-8BspK=WQ@mail.gmail.com>
 <YoYIVaJJDzryYNeg@yuki>
 <CAEemH2c50gr-G91_4nbdaDkCeGivCg3OQcYN4O0HTzyP2nf_jw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c50gr-G91_4nbdaDkCeGivCg3OQcYN4O0HTzyP2nf_jw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 22/29] fuzzy_sync: Convert to runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +
> > +               kill(getppid(), SIGUSR1);
> >
> 
> As we already invoke heartbeat() at the beginning of each tcnt loop,
> why are we still sending SIGUSR1 here?

My bad, I did forget to remove it.

> > I guess that this should go in a separate patch on the top of the
> > "Introduce concept of max runtime".
> >
> 
> Agree.

Should I send a V4 with this patch included?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
