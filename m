Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A735C433F5
	for <ltp@archiver.kernel.org>; Mon, 14 Feb 2022 11:18:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CF3D3C9F7D
	for <ltp@archiver.kernel.org>; Mon, 14 Feb 2022 12:18:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B36573C8D8B
 for <ltp@lists.linux.it>; Mon, 14 Feb 2022 12:18:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D14A2100022F
 for <ltp@lists.linux.it>; Mon, 14 Feb 2022 12:18:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644837514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rAts6HG35W7bTagu8lhw7QyCawAWGvzI7RCG/8MtcII=;
 b=WgMH9uNIZ2J7yrO+N+NFzBj2DsaADq50SmOJdX1rmKL/PwWekXw7JY5d2qaguRp3NRsgNu
 E4NTBDGBT4+5RPH2O8pfWj23iyXTE/dKjzNARC8lEawBEE7MaECSp9froNQGfp8WqdlDUd
 OIPJQiyCtieeAGDQe8TlhrHYd1kkCJY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-12KQB57KPw2e9osOsLv5NA-1; Mon, 14 Feb 2022 06:18:30 -0500
X-MC-Unique: 12KQB57KPw2e9osOsLv5NA-1
Received: by mail-yb1-f198.google.com with SMTP id
 m10-20020a25800a000000b0061daa5b7151so33002616ybk.10
 for <ltp@lists.linux.it>; Mon, 14 Feb 2022 03:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rAts6HG35W7bTagu8lhw7QyCawAWGvzI7RCG/8MtcII=;
 b=oVTPo3gNFK+HqRaKf2/3RBN/i3VTECbfgzJYUQEmU8enpnFNSvwyx9MS++RDHBKXxk
 fuOh9CnBOjKb+TWLnTiqJhynR67xpBc2KVx6aqeM+7LGV630QrCG5mz2N0mILiDdN5kj
 bifz+iwb1BPhuPeyFL7p2zXXfGmwBiwgkeDysCf7GlDZPqaGKCxGgCsNJdYAtNMKh2c6
 INwxmV1+1cvmgn3b2HBLoWNx0Ne0GOcaEdiAroBvSbBRdM3gkMY/01TmE9FGArzmvGHd
 7EwtLxlDRnns7A2DmBb/++3UxKaholaKTJwTaNsK8BeqZZYq/u7urXyaDyY3ZmNlPm7N
 ZRoQ==
X-Gm-Message-State: AOAM530yCJgQsv3jCoGVpi2O3uDODK+PB6b8IV/ntxHmz5hwJB5MWEal
 pFI73r4DgHBQjFUnMQfnsPvMFPoFCKPBMZznOeT277UEuVfR7e778TT0wpwixIeHcw+sn7X+a+W
 ZjOTE+USTxE35g10zQ6+SNmFMwJk=
X-Received: by 2002:a25:ba49:: with SMTP id z9mr11822158ybj.32.1644837510350; 
 Mon, 14 Feb 2022 03:18:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyES4uXeZGDMZR0qAnSHLS+VXVNW6FRTYm0QRdOFPSL6x6h9fHBXhHIy4Yqf+KeJdnZ7akTmjV6AkoJX47MwKw=
X-Received: by 2002:a25:ba49:: with SMTP id z9mr11822139ybj.32.1644837510073; 
 Mon, 14 Feb 2022 03:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20220213042836.3028266-1-liwang@redhat.com>
 <078b0f84-a960-39a5-046c-79fa874daa25@suse.cz>
In-Reply-To: <078b0f84-a960-39a5-046c-79fa874daa25@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 14 Feb 2022 19:18:14 +0800
Message-ID: <CAEemH2c7sf-BZBm1YtNLQ1HQZRPXhgF1nePVczgK38oC6FDqog@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_children_cleanup: allow child zombied for a
 while
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
Content-Type: multipart/mixed; boundary="===============1526649079=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1526649079==
Content-Type: multipart/alternative; boundary="00000000000080686a05d7f893b4"

--00000000000080686a05d7f893b4
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 14, 2022 at 6:40 PM Martin Doucha <mdoucha@suse.cz> wrote:

> On 13. 02. 22 5:28, Li Wang wrote:
> > diff --git a/lib/newlib_tests/test_children_cleanup.sh
> b/lib/newlib_tests/test_children_cleanup.sh
> > index 4b4e8b2f0..ec1a0d4fe 100755
> > --- a/lib/newlib_tests/test_children_cleanup.sh
> > +++ b/lib/newlib_tests/test_children_cleanup.sh
> > @@ -13,7 +13,13 @@ if [ "x$CHILD_PID" = "x" ]; then
> >  elif ! kill -s 0 $CHILD_PID &>/dev/null; then
> >       echo "TPASS: Child process was cleaned up"
> >       exit 0
> > +elif grep -q -E "Z|zombie" /proc/$CHILD_PID/status; then
> > +       echo "TPASS: Child process was in zombie state"
> > +       exit 0
>
> We're in a race condition here either way so reading the status procfile
> after checking whether the process still exists can result in failure
> even when the child was properly killed. I wrongly believed that
>

Ah yes. It is still possible to complete the zombie reclaim just before
doing the grep.



> `kill -s 0` would fail when the target process is a zombie because the
> manpage vaguely suggests that (see the description of ESRCH errno in the
> kill(2) manpage) but it turns out I was wrong again.
>
> I'll send a fix myself later today.
>

Thanks, I look forward to a better solution.


-- 
Regards,
Li Wang

--00000000000080686a05d7f893b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Feb 14, 2022 at 6:40 PM Martin Doucha &lt;<=
a href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On 13. 02. 22 5:28, Li Wan=
g wrote:<br>
&gt; diff --git a/lib/newlib_tests/test_children_cleanup.sh b/lib/newlib_te=
sts/test_children_cleanup.sh<br>
&gt; index 4b4e8b2f0..ec1a0d4fe 100755<br>
&gt; --- a/lib/newlib_tests/test_children_cleanup.sh<br>
&gt; +++ b/lib/newlib_tests/test_children_cleanup.sh<br>
&gt; @@ -13,7 +13,13 @@ if [ &quot;x$CHILD_PID&quot; =3D &quot;x&quot; ]; t=
hen<br>
&gt;=C2=A0 elif ! kill -s 0 $CHILD_PID &amp;&gt;/dev/null; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;TPASS: Child process was cleaned =
up&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 0<br>
&gt; +elif grep -q -E &quot;Z|zombie&quot; /proc/$CHILD_PID/status; then<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;TPASS: Child process was in zom=
bie state&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 0<br>
<br>
We&#39;re in a race condition here either way so reading the status procfil=
e<br>
after checking whether the process still exists can result in failure<br>
even when the child was properly killed. I wrongly believed that<br></block=
quote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:s=
mall">Ah yes. It is still possible to complete the=C2=A0zombie=C2=A0reclaim=
 just before doing the grep.=C2=A0</div><br></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
`kill -s 0` would fail when the target process is a zombie because the<br>
manpage vaguely suggests that (see the description of ESRCH errno in the<br=
>
kill(2) manpage) but it turns out I was wrong again.<br>
<br>
I&#39;ll send a fix myself later today.<br></blockquote><div><br></div></di=
v><div class=3D"gmail_default" style=3D"font-size:small">Thanks, I look for=
ward to a better solution.</div><br clear=3D"all"><div><br></div>-- <br><di=
v dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br><=
/div><div>Li Wang<br></div></div></div></div>

--00000000000080686a05d7f893b4--


--===============1526649079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1526649079==--

