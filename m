Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26616C05027
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 06:19:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAC573CB125
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 07:19:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BEB03CB107
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 07:19:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE86560071A
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 07:19:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675923563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qU2TJTqHZu+EOez0MZBP22cmzaE5PqJe0n6Df1x0ps=;
 b=dUdpyqncNEXBxJHiLvie+vmF79oxn6SLpNvjoASuDVGyqC+PRoBd/5beeUSdFPcauH/w95
 Tca4KCsJ8flvzwrPto3AkWSwWABgvX2RzasK9l26MXhhnIgt9GEP1UlEhEwomRgAol1Pe/
 CKHVjubsRODExqEIXPlJhzL/hOtRGpQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-452-SU3Nj6rHNfWq5ic15qhfSQ-1; Thu, 09 Feb 2023 01:19:19 -0500
X-MC-Unique: SU3Nj6rHNfWq5ic15qhfSQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 r14-20020a05600c35ce00b003e10bfcd160so536532wmq.6
 for <ltp@lists.linux.it>; Wed, 08 Feb 2023 22:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2qU2TJTqHZu+EOez0MZBP22cmzaE5PqJe0n6Df1x0ps=;
 b=OBPjMMR0NrMzr/rLTWI8+Lm+I4kRQslNiqJzTagKxgh24CF8ywQ7QEG6kMKCNRGZxh
 /Gs3bTKT109x+L03juVJWB8ilPws88PbvbcbZFsv23oM3zF+lDxYJc0TCoeOKU7CLEEl
 0npSz+FqpTZFNj/07JwCjJ6iZVmYx3WKlgFBJ0zjURkjCuwCn/BNBucapotrKFcImznN
 8q0z9NlRKc4X3qWmooLgeUkgnkX8XNgoA87H4KeHexchb9rge+yg2xCvr5FfEshJfHhh
 ud3VDL9zF5L2F/aFGFeEt2Biijjz4NhUk3TObDiiJT3LLvHa1hVhDxrNGZO019HDlSb1
 xrbg==
X-Gm-Message-State: AO0yUKUXfYHqaUHi/dkr41pT85Z8nYFzFr7zfbs6MBxDiC6NoU6Lj6hI
 TdNaJhyvsW4/VYTQVweBlxGxmeYo9y0F7ppBDWd/FGpVpLVWVA1R08UeZxX0jqNmeLBHRPOLN4i
 om1ZS4sELW2BoZT9phPmtGYhP6Cc=
X-Received: by 2002:a05:600c:3ac7:b0:3dd:1a1e:fa58 with SMTP id
 d7-20020a05600c3ac700b003dd1a1efa58mr282702wms.99.1675923558689; 
 Wed, 08 Feb 2023 22:19:18 -0800 (PST)
X-Google-Smtp-Source: AK7set+pZSO9CEGR00zJ2iFo2Jt2Re9uPLrndIX2C6jDTyuzs6gSF0qctBvPfh4wsoyypEtTjhMSWrycLb3CHyxEJBc=
X-Received: by 2002:a05:600c:3ac7:b0:3dd:1a1e:fa58 with SMTP id
 d7-20020a05600c3ac700b003dd1a1efa58mr282699wms.99.1675923558519; Wed, 08 Feb
 2023 22:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20230207131714.2500-1-pvorel@suse.cz>
 <20230207131714.2500-2-pvorel@suse.cz>
 <CAEemH2chcTe263-zqpSF2Gc2CVc8NC+G-KZsFMbwoxEKyjA01w@mail.gmail.com>
 <20230208135404.GB31469@pevik> <20230208141309.GC31469@pevik>
In-Reply-To: <20230208141309.GC31469@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Feb 2023 14:19:07 +0800
Message-ID: <CAEemH2dTnMwyi5hvD9GvSNOHWON=pi6z5eF8xTVb7rUobuoWKQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/3] ioctl01: Add default tty device
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

On Wed, Feb 8, 2023 at 10:13 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Li,
>
> > > > +#define        DEFAULT_TTY_DEVICE      "/dev/tty0"
>
> > > Hidden the device path parameter is a good idea.
>
> > > But maybe can we add a function to find available char devices instead
> > > of using the tty0 as default? In that function, we do the S_ISCHR()
> check
> > > and return the valid path of it. Then the rest test (e.g. ioctl02) can
> make
> > > use of it but not set the specified device as well. WDYT?
>
> > FYI I'm using S_ISCHR() in other patches, which check if device can be
> used.
> > Implementing search looks like a good idea. Are useful files any
> /dev/tty*
> > (including /dev/tty, /dev/ttyACM0, /dev/ttyS0) or should I avoid any file
> > or include other paths?
>
> I also wonder if we still want to keep -D parameter (i.e. allow tester to
> pass a
> file).
>

I think there is no necessary keep "-D" parameter since this ioctl01
is to check errno of ioctl(2) syscall, it might meaningless to specify a
different char device.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
