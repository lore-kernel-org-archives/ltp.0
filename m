Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAC4C6FA82
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 09:45:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64D9B3CAD55
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 11:45:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EF353C0895
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 11:45:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C83FE601097
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 11:45:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663839938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZinaONWTGxgX+YAxoD7OsD4JR/0cEfXbriKer1Rr77M=;
 b=Vuc+1S2cIqwh6qN+ll0DKb5d7DeG/EB4Nwxm+2Jxainu1Tcci/t42BkJn9i497uXdQ8Ujp
 2msWacP6LIFzahbL2QBSFTj3t7rBrAQm6CTuvo5BCU2bO1hBsbuzEogTg1Q07HCLv2iXVW
 cR9Xot5eNbIvuRvSbUwFhEiByiFCUKM=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-392-BaKOuGHsPVC-qO4xyeemjQ-1; Thu, 22 Sep 2022 05:45:36 -0400
X-MC-Unique: BaKOuGHsPVC-qO4xyeemjQ-1
Received: by mail-vs1-f70.google.com with SMTP id
 m186-20020a6726c3000000b0039b2e2e040dso1555720vsm.9
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 02:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=ZinaONWTGxgX+YAxoD7OsD4JR/0cEfXbriKer1Rr77M=;
 b=kLDM35HmNZI1oV9+vSvQ5rb0EGJ1k4qT5crEl5hdE+9DURfoS0OMlmFXIdIy5B2eIs
 qV2b4fehsSj3v6MXUHEzFVSbOFb0IV85URoro5dD1YKWN/+DutvUY6eOEHMmVMHnXcmb
 ea9X5y5bwGMuoQ4252SKR9N/6alc5xyw46392ax++2j3CUhHM5bsJ4vuqXO94PvfBp0m
 2a0Xd4iuOYEncv6CxVtLXs+Zdfvj+pPxJd59eUlUTV3fem2ymkokVI9yUVEFSfey2fUg
 mWhb6PXhBHGYzVilSS0DXIV6BMEXcB3hGPEzI/UBT/KkU8Uwgv1eZZS3n4ZELTRQN37v
 5DFA==
X-Gm-Message-State: ACrzQf0RlLxyY8B9niaXk9M1pSq2r/mbGckKdTvtI/DqOIN9xAz38Ssb
 JE69eVTX+1Zp+afal6PHU/EqnroKbRaidQdUAMxM4meVnV7GlHLKSTGshWBWWWPDbvEslYHhfUO
 sRB+IiskZpgifojL0jJnPKE2hYA0=
X-Received: by 2002:ab0:7789:0:b0:3be:fd5f:768f with SMTP id
 x9-20020ab07789000000b003befd5f768fmr881417uar.109.1663839935948; 
 Thu, 22 Sep 2022 02:45:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6WPn7GItdv0zVEV14KLISlvaixvnIjP74TLL2xhSbm2MwLdOEdSlcREPfw9Yyxy8uxKEPGoON281OQgJzK1oI=
X-Received: by 2002:ab0:7789:0:b0:3be:fd5f:768f with SMTP id
 x9-20020ab07789000000b003befd5f768fmr881412uar.109.1663839935739; Thu, 22 Sep
 2022 02:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <6bac7035adc2cfc8ab3800fe1d2d03223ec57ff5.1663662348.git.jstancek@redhat.com>
 <6c5b161bc3bcf753cbda92954ca3f47cb268c68f.1663665637.git.jstancek@redhat.com>
 <6470a099-8b3a-ca9f-f521-181a33b5a28a@suse.com>
 <CAASaF6wFc0z+cec6y2T0ygWKY==LwkFv21CT2VG0Waqk+0SSkw@mail.gmail.com>
 <YyosAWUf7pbVMpBt@pevik>
In-Reply-To: <YyosAWUf7pbVMpBt@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 22 Sep 2022 11:45:19 +0200
Message-ID: <CAASaF6x=5SDfS7Z+PauaLKXaKpaBagjgL3ogxKXBF6a-6Zs9xA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/futex_waitv0[23]: replace
 TST_THREAD_STATE_WAIT with repeated wake
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Sep 20, 2022 at 11:09 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Jan,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks, any concerns pushing this before release? It's race, but not
very frequent one, so it could wait.

>
> Kind regards,
> Petr
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
