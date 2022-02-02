Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBF4C433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 03:17:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFBC73C9893
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 04:17:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39C433C9097
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 04:17:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5F6691A0066A
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 04:17:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643771819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4HDp7Aik9w85qAJcYH8vLpKERB5Gq09Ovzo4JfCMa0=;
 b=cp8Nimgr99ru6m5knM2V3AunVRzg53Guw7jkUOCnwtZpTurbIh95fmastLMmqXa0Mvf4SF
 ILS1RzyrlVsr9Jo8AGmI3wk+W2N2Gd+GUZmr/lWX+CG7ARVCRxSxFONwKSZogVkg122Z1P
 O9RqHq9IMUwvV1klnAOQ0X9j3UYvL3U=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-OgdIwdZsOjy3iPd2eAjOEg-1; Tue, 01 Feb 2022 22:16:57 -0500
X-MC-Unique: OgdIwdZsOjy3iPd2eAjOEg-1
Received: by mail-yb1-f197.google.com with SMTP id
 b2-20020a252e42000000b00619593ff8ddso25774015ybn.6
 for <ltp@lists.linux.it>; Tue, 01 Feb 2022 19:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E4HDp7Aik9w85qAJcYH8vLpKERB5Gq09Ovzo4JfCMa0=;
 b=QsMSvMhHfVX1N5ydMRZw+y5pVIrLJZ3vrGa0mlcz1RS23QLJUjMp8zEaxVy1aLFZcM
 yRaYz4XCOf912kUrLPTss3x2sTPMKSoxtncEXdlq5kVZJI1KGSPlZo5pmF05T2TlRaYk
 TiGj/Q5gHwOCkC+jg7W3g9I1HjKT6Uwg7hxS3fxYI6D8oW0sJIrri6h3ZmqQHY9w3jiI
 wjIuMbm6zwrDp4349WaQhqiRuDly3R29Eg3SKzlGwgHdmtg4W1/grIq/vKSlxps9Wifb
 i3Fz7MJx+ocn1Iy2ZnGYrsrRwTCMOzxSanpXMjwOPcKYu/fLmYEQjx1RiOSYcYsUMhcu
 cK5w==
X-Gm-Message-State: AOAM532x4vhlU2f/UnICYm2pzE3Ruq91XftvtYaHyZ5ywEFArnVsTcnQ
 dhaiztw65Kx1MzygcWxaj/7rZUmHVFwAUbhBxjEGPZxsMcDOHPtzeDHyiziYZ5OkYHPhLER9Qqb
 KSr3YYRaLYutgnIaLqqZEoguYkH4=
X-Received: by 2002:a5b:38f:: with SMTP id k15mr43108348ybp.421.1643771816607; 
 Tue, 01 Feb 2022 19:16:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKXDlZTkUSU8ArTTwcZps8sbhOo10Vga/3tQ3YSe2/Du+DK9Rijfjff/Q3qijuxjqaoCijUDBXyD1O25Q/HxQ=
X-Received: by 2002:a5b:38f:: with SMTP id k15mr43108336ybp.421.1643771816430; 
 Tue, 01 Feb 2022 19:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20220201094451.7651-1-pvorel@suse.cz> <YfkMR3oM/QD9a3I9@yuki>
 <YfkPfjqRz9j2Jbuw@pevik>
 <CAEemH2di8y4qiyn45EOgdxQo-oebEsZRhYmyCfkifpvS1rpsaw@mail.gmail.com>
 <YfkueuaAfXqVGOO5@yuki> <YflOvov3Ui9OxRPf@pevik>
In-Reply-To: <YflOvov3Ui9OxRPf@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 2 Feb 2022 11:16:40 +0800
Message-ID: <CAEemH2ff=hhWw=xKoaKz7cixCYQbh=iy6b202ZmtwL+b2c9stQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Feb 1, 2022 at 11:22 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > Hi!
> > > > We have CentOS 7 (EOL 2024) and also fedora:latest, which is 35
> > > > (their devel called rawhide is currently 36).
>
> > > Is there any possibility to convert from CentOS 8 to CentOS Stream 8?
>
> > Is there an official docker image for it? As far as I can tell I do not
> > see it at: https://hub.docker.com/_/centos
>
> Here some unofficial:
> https://hub.docker.com/r/tgagor/centos-stream
> => I'm not sure if we want to use unofficial
>
> which also mention official at quay.io:
> https://quay.io/repository/centos/centos?tab=tags
> => we'd have to figure out how they could work with GitHub Actions.
> Li, feel free to look into it.

Sure. Thanks for the info.

Ps.
I'm not good at deploying CI/CD but will try to figure out that.
Will send a patch if I can achieve it.


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
