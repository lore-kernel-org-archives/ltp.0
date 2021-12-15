Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48556C433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 09:50:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35DBA3C8E88
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 10:50:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 266FE3C092C
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:50:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 71B4F14011AF
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:50:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639561800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zlQbn+DGy0tvaA68Zkamx4pIe7sJ4kBRrJHMeiMtAT0=;
 b=UQ2aqJZxuWuGfWgdtkdW+2mZ6aGlgeYQoBby7eg9n+EgdY9SkysaK2zf6nEToxC0dVQXYb
 nlgidYm8Ffq4D/PMjF8m6rjMqNwB9XAFCUTat8dY+Jd7iZd5+ZDjA0LwySzrE6NxeaZwxi
 UXGyQmorrfNAp21vqyHxQ4/0mAE8oY4=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-RtglAc0nNk-H3880zVZjdw-1; Wed, 15 Dec 2021 04:49:58 -0500
X-MC-Unique: RtglAc0nNk-H3880zVZjdw-1
Received: by mail-yb1-f200.google.com with SMTP id
 e131-20020a25d389000000b005fb5e6eb757so42096033ybf.22
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 01:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zlQbn+DGy0tvaA68Zkamx4pIe7sJ4kBRrJHMeiMtAT0=;
 b=Qr2FsBLHG3so63+UL9EoHP/PCQzlqtnjnEwt4E2uFa72/PJI5HI4bIzP29qOT2t351
 xDvHywdI5SI+zagZvsOEzVQnhY1kcADly8iEmkJAGAWeWVl+T0sliOfIsk8p3HlKBeI4
 XtFm4cVageuvamotDxmdOJ9vn7aoHvPtNKG+pzWcEHlduALh5jsudTQLzuUTR9ZUbHh5
 8SekzZP8l2HBc25kZEIzzASlXYfuIx5atzhAYLyJIeKu67MujFtcvQp3n7cajCi3qq/m
 K9+9Po/ye+RM/x48SBr7AUAOzBBYX9CKYa+20CJaSb5NCEZvUjmf5nsFhlAVWVk178aI
 Q9sg==
X-Gm-Message-State: AOAM531RHUeKi2eSfXyKzerpNG6v0O7IfajTE6YT8cwOXk0IdQ6uURBR
 Qy4VPmshnGPkziK2tbBJFX69AWR6DEO1/5IfPngi96zZHjoTXVS6xFhq44nkuj7cAYlMYso5398
 RaKHqX9i28OjWhXzQl15oq4mZGms=
X-Received: by 2002:a25:8c9:: with SMTP id 192mr4960099ybi.102.1639561798105; 
 Wed, 15 Dec 2021 01:49:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0xYhfOwySx3KxiXGj8E/s2ioODSRfw3tUlH8TETCeCT+7lhXFVJ11FBgTW0AzF1FmWGfqYM87iSbJ5/6otbg=
X-Received: by 2002:a25:8c9:: with SMTP id 192mr4960061ybi.102.1639561797629; 
 Wed, 15 Dec 2021 01:49:57 -0800 (PST)
MIME-Version: 1.0
References: <20211214144309.6704-1-pvorel@suse.cz>
 <20211214144309.6704-4-pvorel@suse.cz>
 <YbjAOffrWpsMvinQ@yuki> <YbjKV7yUJS+njaCY@pevik>
 <CAEemH2eXMWXt5GeY8EXaoPbS66-fju71iY+hJERNKMip+DqxLA@mail.gmail.com>
 <Ybm1vgG1OfmTjzzO@yuki>
In-Reply-To: <Ybm1vgG1OfmTjzzO@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 15 Dec 2021 17:49:44 +0800
Message-ID: <CAEemH2fkMVnRipZ-M_tYber5Y71RzrujyKVJFyEHyt+3AGfX4Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] lib: Add support for debugging
 .all_filesystems
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
Content-Type: multipart/mixed; boundary="===============1324970421=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1324970421==
Content-Type: multipart/alternative; boundary="000000000000890f9105d32c3a5d"

--000000000000890f9105d32c3a5d
Content-Type: text/plain; charset="UTF-8"

Hi Petr, Cyril

On Wed, Dec 15, 2021 at 5:29 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Hmm, I think it also makes sense to people who care about the
> > only one filesystem on their product. So this should _NOT_ be limit
> > for test/debug, because it can help to reduce testing time for specific
> > requirements.
>
> With that line of reasoning it should be just called LTP_FS_TYPES and
> user should be able to specify a list...
>

Okay right, so just let it is, if there is new requirement we can add that.


-- 
Regards,
Li Wang

--000000000000890f9105d32c3a5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr, Cyril</div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 15, 2021 at 5:29 PM Cyril Hru=
bis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Hmm, I think it also makes sense to people who care about the<br>
&gt; only one filesystem on their product. So this should _NOT_ be limit<br=
>
&gt; for test/debug, because it can help to reduce testing time for specifi=
c<br>
&gt; requirements.<br>
<br>
With that line of reasoning it should be just called LTP_FS_TYPES and<br>
user should be able to specify a list...<br></blockquote><div><br></div><di=
v><div class=3D"gmail_default" style=3D"font-size:small">Okay right, so jus=
t let it is, if there is new requirement=C2=A0we can add that.</div></div><=
div><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></d=
iv></div></div>

--000000000000890f9105d32c3a5d--


--===============1324970421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1324970421==--

