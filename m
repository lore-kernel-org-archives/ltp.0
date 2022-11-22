Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271CAC433FE
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 08:02:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9504C3CCACA
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 09:02:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C689C3CCAB6
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:02:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4DAAB124722E
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:02:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669104144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SdQRfNPNPxcSDRlSbcE0wdQaCvLO8XiKcQPeBtWm4kk=;
 b=G33dneThK3lhB9dWRdS8ZlsBG7ba2PDCB6udFqcBGyUqnG8Wge2faVE2vrxavNYaNvoQL6
 3YfVVTB3q0uWCmnn8t2q7xUF062gYVuPDatuXifJwjrlCYwy02HApWXLi4K17RwK7FjGdD
 paP2J3jouZHvai4ZLelUUy+Oo/bTDaM=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-361-OK2uovD_PL29ssmSaul14Q-1; Tue, 22 Nov 2022 03:02:23 -0500
X-MC-Unique: OK2uovD_PL29ssmSaul14Q-1
Received: by mail-ua1-f70.google.com with SMTP id
 q9-20020ab04a09000000b003dfecbdc5cdso6021785uae.15
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 00:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdQRfNPNPxcSDRlSbcE0wdQaCvLO8XiKcQPeBtWm4kk=;
 b=jTndWtla9P7U017VLOkUXUmniK3hPeC19K5uhR6EgADCbRX0fxlPPuC62RWzvhBrtW
 Bwd58pW6H+cddrhzatnmsKSd7hTRUDtXA1Dr3XQtlrnveYukMfieOT+Z3nPy+mYJewP9
 QhQpxaZJT+p/GOFW0cWZulnlJwQOteh13QkrsvI3aYNx1zSvh/capIec5jqdU5CKNBUd
 6zXTvdTfn/Mh6CiZeaUn0sCHHRdKVyzLyFZs0vvzVwcCtLsEBBFl/fMqDS8YjwizrhNV
 K9Rd+wPeJSCK+UEE71jRD6XQWxRQBDOCBJs0KWV57S6wYAUsNs+ccAKDgtBwm/mZM9aZ
 5lLw==
X-Gm-Message-State: ANoB5pmpBAad8ksA5afMo9pMo+3Kf+1DFbF4KHmO9FtkAdps62ynPGa4
 2lVkbD/rKi9L91m6qeML7Ra/WQAb7bGlryvDY2U/s7/WEtJjTlkYvPRE4tEyeEQV3NIbsMpkUHg
 GvcJA/+B0ReZmyWcUavvUrLdHnbE=
X-Received: by 2002:a05:6122:990:b0:3bc:721:4fec with SMTP id
 g16-20020a056122099000b003bc07214fecmr11926334vkd.8.1669104139655; 
 Tue, 22 Nov 2022 00:02:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7FWuRuAGXo/pyAJVDMx52qNzXoLprk6Drz8RUa+Y8YDX7yXejhgYRXq6Q61CVvkE87UrqpEIF1UDCsEUyP9vA=
X-Received: by 2002:a05:6122:990:b0:3bc:721:4fec with SMTP id
 g16-20020a056122099000b003bc07214fecmr11926322vkd.8.1669104139353; Tue, 22
 Nov 2022 00:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20221116160715.10082-1-mdoucha@suse.cz>
 <CAEemH2dGJ3LzO=OS7hrxxgMJ+T4FguiBFgB3KXirJw-R7zVBBQ@mail.gmail.com>
 <Y3eJNAi81ucutljP@yuki>
In-Reply-To: <Y3eJNAi81ucutljP@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 22 Nov 2022 09:02:02 +0100
Message-ID: <CAASaF6yaPmG1Q5fdecM7xhE3uqHa_PCMZBGj-hUj9xrVU42Z6A@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] save_restore: Introduce new struct field for
 flags
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Nov 18, 2022 at 2:30 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > +#define TST_SR_TCONF (TST_SR_TCONF_MISSING | TST_SR_TCONF_RO)
> > > +#define TST_SR_TBROK (TST_SR_TBROK_MISSING | TST_SR_TBROK_RO)
> > > +#define TST_SR_SKIP (TST_SR_SKIP_MISSING | TST_SR_SKIP_RO)
> > >
> >
> > I'd suggest using "_TSKIP" to replace "_SKIP' to be consistent.
> > Then the whole format will look quite perfect and easy to memorize:).
>
> I think that it makse sense to keep it as _SKIP because that is the
> option that does not map directly to the test result flags. If we named
> it TSKIP people will be confused that there is no TSKIP in the test
> result flags at all.

+1 for SKIP

Feel free to add my Acked-by back.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
