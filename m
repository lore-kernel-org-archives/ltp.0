Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABC8C433EF
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 03:14:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6361E3C95D1
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 04:14:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C481A3C9554
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 04:14:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A4C22600696
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 04:14:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642389258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VuITJoWFlFXS9VwpQnodim5zOvfeabc93VrF/z1rkpw=;
 b=GLplml8cxrm6/7ZWqkwvqeKiduw0v+YbHtv1QpaQJRINA72mE19HAr4Vkmv/alrj3PD065
 fFPq7AYt3NcC6N4wDUCpBLqKU8FQnoErwMnOoyGtJ182XpOhuTQUCl8Io5osmvtj19XN4E
 plhUcypn8NCFr4Dv0TtngAf5s9McTQc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-p-vWpX4BN1iV7mGRg2uYKA-1; Sun, 16 Jan 2022 22:14:11 -0500
X-MC-Unique: p-vWpX4BN1iV7mGRg2uYKA-1
Received: by mail-yb1-f198.google.com with SMTP id
 y4-20020a5b0f44000000b00611862e546dso30595254ybr.7
 for <ltp@lists.linux.it>; Sun, 16 Jan 2022 19:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VuITJoWFlFXS9VwpQnodim5zOvfeabc93VrF/z1rkpw=;
 b=jzK6NGkDE8fPoETdiMlQIskBesQ+uDuG9ccfrTJJRj9BoMLGdWMmCj//iCsEtvZSI/
 4wtyoLDMiQXo5yewDW9dlnDQoVHMKpDf+r6pVIKA6xhCHtMOJJYRbAGUlcWPQRGIAmv4
 G64zwmI2U9plgqH7l1t+jeuyvhcV+E3Ae3UrS5G6oKfTZRQrVnMzQyXzuujLymz/VJwE
 QedSfLD5bbVOJ1HzdIOY3CfiKIX/o5ly6Bg5b1EbP+6MxBu0i2tIdDCvpbs26uHIZsMG
 ny4LLAOughL5S75/aJgX0q3+Ya29appCW2JcY8yuqXqLvv9rJU6MfIzFftMe7NjGv7FD
 CBMQ==
X-Gm-Message-State: AOAM532PvU++KJJqoOSzlHbN1Cvq6vSIu1BdqFs71HU/jgWAQQ7Mx4m/
 Nmt96Xm6lb1zI8iOMHI/Ou0sxfkp+76+S9nm8vEH+DceJfwkKJgqy6dN3yZCtbia0K3L4IMgNui
 Sgbn2CEUM1uQJYgteA++5tjfk66E=
X-Received: by 2002:a25:4cc5:: with SMTP id
 z188mr24092993yba.248.1642389251412; 
 Sun, 16 Jan 2022 19:14:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXmUKmmbXuOD95eK2HxK5Gn475p1/FzCEnHyBzDB+vTx4o2B5k/5RSo78+rRS4YBVIc1wO52gn/cxrBNShy1M=
X-Received: by 2002:a25:4cc5:: with SMTP id
 z188mr24092984yba.248.1642389251208; 
 Sun, 16 Jan 2022 19:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20220114210034.16177-1-pvorel@suse.cz>
 <CAEemH2ddzfJ48prJTejCBq-=u4O-w0ENR27A_DjUo_OsqShCow@mail.gmail.com>
In-Reply-To: <CAEemH2ddzfJ48prJTejCBq-=u4O-w0ENR27A_DjUo_OsqShCow@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Jan 2022 11:13:58 +0800
Message-ID: <CAEemH2cMpFUz1nzq6DDfe+S-bYam3fYvb8ci=hfXHkjbfxbkeQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] utime03.c: Fix filesystem name
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > +++ b/testcases/kernel/syscalls/utime/utime03.c
> > @@ -93,7 +93,7 @@ static struct tst_test test = {
> >         .mntpoint = MNTPOINT,
> >         .all_filesystems = 1,
> >         .skip_filesystems = (const char *const[]) {
> > -               "v9",
> > +               "9p",
>
> I'm wondering does it really take effect with whatever "v9" or "9p"?
> Because the fs_type_whitelist[] does not include any of them.

Unless removing the .all_filesystems as well otherwise, it is impossible
has a chance to test on 9p.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
