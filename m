Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3967C4708E
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 09:38:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCD993CB66D
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 10:38:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDA423C1364
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 10:38:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 17B241A006FD
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 10:38:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672825088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vlihyg3d5koawHeQhRp0JDLjBsv2tC3GQgYCdSJYnAE=;
 b=D5G/IVKY8sEO/Kv38cYQtcYuM9LeTJZveKddy90sMmquQbajpV9zVQHq0uJlfvqqV9g6CC
 5kc4YxhBIUCbUHNcuAzxlYaOWwBZZN9YjGbeLI3lRCmEM5GHd8Saf7ual9RRI3XKwKS3fE
 HIdIvdX3mDhMoN+r+Expt3KXCSjrTMs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-473-zHaLgj2tO12AzHcMCx8jzg-1; Wed, 04 Jan 2023 04:38:05 -0500
X-MC-Unique: zHaLgj2tO12AzHcMCx8jzg-1
Received: by mail-wm1-f72.google.com with SMTP id
 k20-20020a05600c1c9400b003d9717c8b11so15898079wms.7
 for <ltp@lists.linux.it>; Wed, 04 Jan 2023 01:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vlihyg3d5koawHeQhRp0JDLjBsv2tC3GQgYCdSJYnAE=;
 b=x8CiHoQYQVtI5k/8WBXu74qXJ6ND2MIMApw2h4WqfyJqHJORTg64qS/FSYcDhoQIul
 8mE4WoylNWHTw3GbWrPI1sl7jjNrpq58056Lj2f+x09s9MEsFUVx35o9UqKKfdUWHiAU
 5EJGDZRVMkftJnKS9kRA6BSjcY8TEsi75nnXKm2jDlXqMSs8zsP3zAojNP5UCSzzH4xD
 GX29OuZ57VPJKJ7L8/jr+GWwn9w5DlE3QAUeYDZgfyX6qi4t6BUJ+Jp/EVBl+QiakHom
 KaPtEjY4xxl2HKEGAw8+/yHjR+2dKfQ78rlCh38qnh1PTTz6hZf04FhDS1T2Aza/N3fr
 euzA==
X-Gm-Message-State: AFqh2kqbQ/Y9AKJcaJm5N6nJfKk72bTP//74eYsIQLxrtO+d6foH2mms
 g9Z0y/i4yqRxn/4d22uU1uN6C9LuahSvyed4V1yPV1C/uDpRLi60krei9qHX4fQNSdasywEQfPe
 2EpZ75mUq4BLw7ctlo/WILGy2zoU=
X-Received: by 2002:a5d:444d:0:b0:242:3a48:1757 with SMTP id
 x13-20020a5d444d000000b002423a481757mr1845450wrr.528.1672825084224; 
 Wed, 04 Jan 2023 01:38:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXssBEGa0nQgBsQJR8wlwD+mjAq5zpB/XtB3R0JfZfzGaX+H3z3CT4UX6CaGovO0T0pV8UHOnYHr5MOM5Wag39s=
X-Received: by 2002:a5d:444d:0:b0:242:3a48:1757 with SMTP id
 x13-20020a5d444d000000b002423a481757mr1845447wrr.528.1672825083964; Wed, 04
 Jan 2023 01:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20230103124505.6611-1-pvorel@suse.cz>
 <CAEemH2c69cKYLFzivuCRNnpxB8sco-9LRhL8_EYw0i+Srp71CA@mail.gmail.com>
 <Y7VCssq333Y5QgPt@pevik>
In-Reply-To: <Y7VCssq333Y5QgPt@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 4 Jan 2023 17:37:52 +0800
Message-ID: <CAEemH2e3Ob-faePkzSyjhRqHYx_96VwB0_by+tV2S=vPPFz9kw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] configure.ac: Require 2.64
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
Cc: Mike Frysinger <vapier@gentoo.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel <pvorel@suse.cz> wrote:

Hi Li,
>
> > Hi Petr,
>
> > I see other places also used 2.61, do you think we need to correct them
> as
> > well?
> > (e.g. open-posix and realtime)
>
> > $ git grep AC_PREREQ
> > configure.ac:AC_PREREQ(2.61)
> > testcases/open_posix_testsuite/configure.ac:AC_PREREQ(2.61)
> > testcases/realtime/configure.ac:AC_PREREQ(2.61)
>
> Sure, I could do that, but these independent projects actually work with
> older
> version, that's why I didn't do that.
>

Ok, as long as we build it internally of LTP, that is required because
we have to check the configuration at top-level and then go into the
subproject. It will use the upper version first.


>
> FYI realtime will go away, once I find time to port relevant tests to
> rt_tests
> and openposix could one day become in separate git.
>

If so, that older version will be tolerated. Thanks!

For both:
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
