Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C37BC433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 07:48:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC76B3CA6F5
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 09:48:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 383983C5649
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 09:47:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5C7A760082C
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 09:47:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 678661F753;
 Thu, 21 Apr 2022 07:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650527272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xx9p08WF89WkG3olnPusnd7Ly6quvH7Q3tZrbsDM0qw=;
 b=X7RBp7KqfH6nM+m+MmMM9U1/u2hwdBG079gPQ/BcDwcTaZ4jtPNA467auCvf/Eg5mDsKiR
 65A/J1ay2t5bgN05kCR1TIokLt5xUqr4GeIpzwsK5C2wpRfLJWxFHGNZomz7L8YzUr4IcH
 QudLOD3YAhhN71EKvhgert8JTLZdltY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650527272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xx9p08WF89WkG3olnPusnd7Ly6quvH7Q3tZrbsDM0qw=;
 b=q4/BAPjxD7hl8SUi7k3pM0no0Q9HLZFiWj4wbAagrXWf/k5qbYlmR8Gw80eUqPJldZtCcd
 Vx8wtFPM80u+7JCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE55913A84;
 Thu, 21 Apr 2022 07:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 74VnMicMYWKPFwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 21 Apr 2022 07:47:51 +0000
Date: Thu, 21 Apr 2022 09:47:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YmEMJeVpJHqxG8si@pevik>
References: <20220420114720.1463473-1-liwang@redhat.com>
 <20220420114720.1463473-2-liwang@redhat.com>
 <YmBzdLLeX3kNfbvu@pevik>
 <CAEemH2dBCRC2CRERBQw_Tj6SBrCZazKg-WXrJ+4qMLR3Zp=8Dg@mail.gmail.com>
 <CAEemH2d=r90AUhNzqHFc8mQFHd-eQeEHLebUaJhXNNwUVb=rpA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d=r90AUhNzqHFc8mQFHd-eQeEHLebUaJhXNNwUVb=rpA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mkswap01: wait for the triggered events to
 complete
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
Cc: Martin Doucha <martin.doucha@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Thu, Apr 21, 2022 at 10:18 AM Li Wang <liwang@redhat.com> wrote:



> > On Thu, Apr 21, 2022 at 4:56 AM Petr Vorel <pvorel@suse.cz> wrote:



> >> > -     udevadm trigger --name-match=$TST_DEVICE
> >> > +     udevadm trigger --name-match=$TST_DEVICE --settle

> >> >       if [ -n "$device" ]; then
> >> >               mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size"
> >> "$dev_file"

> >> --settle option for udevadm trigger has been added in v238 (in 2018) [1].
> >> This mean on SLES 12-SP5, RHEL-7.9, 18.04 LTS bionic, ... we get:

> >> trigger: unrecognized option '--settle'


> > Thanks for pointing out this, Petr.


> >> Do we ignore backward compatibility hoping that all distros aren't tested
> >> with
> >> newer LTP?


> > Actually, we only use fixed older-version of LTP for long-term supported
> > distros (e.g RHEL6/7) testing, as it falls into maintaining phase and no
> > new
> > features are added in. So this won't be a problem for us.

> > But if we consider fully backward compatibility of newer LTP for old
> > distros,
> > this is a burden to maintaining work. We might need to make a balance on
> > the patch accept or reject.

> > With regard to this simple patch, if you think it's a problem to SLES
> > 12-SP5, I'm
> > fine to NAK and rewrite with another way (at least for ioctl09 I will do
> > that).

> > But if you're OK with making use of fixed LTP on older distros, feel free
> > to apply this one :).



> Or, just go with the traditional way for compatibility:

> --- a/testcases/commands/mkswap/mkswap01.sh
> +++ b/testcases/commands/mkswap/mkswap01.sh
> @@ -128,7 +128,8 @@ mkswap_test()
>                 return
>         fi

> -       udevadm trigger --name-match=$TST_DEVICE --settle
> +       udevadm trigger --name-match=$TST_DEVICE
> +       udevadm settle --exit-if-exists==$TST_DEVICE

IMHO that'd be better (--exit-if-exists was added in 2009 in udev 174).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>         if [ -n "$device" ]; then
>                 mkswap_verify "$mkswap_op" "$op_arg" "$device" "$size"
> "$dev_file"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
