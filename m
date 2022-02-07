Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D38FC433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 12:10:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3434C3C98A3
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 13:10:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E6BC3C0720
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 13:09:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6B5DE20007D
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 13:09:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644235788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cfIOLg4/M0FZ7Lx5KlcaUKBHnp67tdB5ESaJEDFxgKs=;
 b=bq0HaEhwl/oRjh9AAI9a5cWiNDt5jkVS8cpT+JPwAUXomg8D0AyMK02Z3SvaG7jj0YbsPL
 ZnyVHJgdyRS9DhVH/i9P7TFGWQN71z+hddFFagR89RIOSwo9419fZr2GrTkQtnd4Jt7Qaq
 oJQvuKx4vaP7fuBx88v9OueKuTimdT8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-9YNTem1IPoaW2fZwwYks3Q-1; Mon, 07 Feb 2022 07:09:39 -0500
X-MC-Unique: 9YNTem1IPoaW2fZwwYks3Q-1
Received: by mail-yb1-f200.google.com with SMTP id
 3-20020a250103000000b0061d99b7d0b8so7155572ybb.13
 for <ltp@lists.linux.it>; Mon, 07 Feb 2022 04:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cfIOLg4/M0FZ7Lx5KlcaUKBHnp67tdB5ESaJEDFxgKs=;
 b=RPPMVA5zzNNEIxYJae2/1Y8Mcp6domfzzt1EZY9MtrnseE6RG5NZainAleZefEo0us
 ZaS6NePYzJODw+ZVUfDYNAzsrqmwjLLK97LsvfN56TD7iKehCr7t/cJTUGQHfmUKBsPA
 2zSAi2nazDIMatwMsQVp4haKQvV25G3zId3dj2dqbaPZJaE4eJR91ACLeBn+lDcMaAIS
 GtzxHcBX+8uaBRPfe4izXmqqd50+oS0bf9AYqwLP/xBbjRNKm3v44UK6pVpbUGeb6umh
 I3e6NUm4bNjV1nK4m6roQD16KlRBCD/NBRSdckTDqLy+mP0m2kNr+vA2+RnX86fIO1Im
 9OpQ==
X-Gm-Message-State: AOAM530nHWJUMNPV5eOfIM/MR7izoAze4+kFDXrp5WQ29umgUZnSDU2t
 ldBCUAXdzvpro2XEjkfwbSCULTrdl+krRYFY4jGdJDN4asxd5/AsSECEzmLKj02JWhnl1BsbJCh
 0GAJkteF/MjMkqvMABy3thNsYSOc=
X-Received: by 2002:a05:6902:56a:: with SMTP id
 a10mr4552822ybt.398.1644235779479; 
 Mon, 07 Feb 2022 04:09:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/jeYANarIKr80IYy9YY/JljTk4UryZozowSGNZu/pR2qC3ZAkqapr+FD7QHyCsZMuQJFRDUeJDZdMjKPzELY=
X-Received: by 2002:a05:6902:56a:: with SMTP id
 a10mr4552806ybt.398.1644235779236; 
 Mon, 07 Feb 2022 04:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20220207040447.2803113-1-liwang@redhat.com>
 <CAASaF6ytd7ROq_S48NnYWY4-VU+nGjX7NTcgM5aGQG6G0rh_OQ@mail.gmail.com>
In-Reply-To: <CAASaF6ytd7ROq_S48NnYWY4-VU+nGjX7NTcgM5aGQG6G0rh_OQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 7 Feb 2022 20:09:25 +0800
Message-ID: <CAEemH2db9zUH_svdDr+FcgkEnhpqNsju1QqJ-B0_j25CE5Tt+w@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrusage03: skip on small RAM system
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
Content-Type: multipart/mixed; boundary="===============0427507245=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0427507245==
Content-Type: multipart/alternative; boundary="0000000000008c7ae405d76c79a8"

--0000000000008c7ae405d76c79a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 7, 2022 at 5:16 PM Jan Stancek <jstancek@redhat.com> wrote:

> On Mon, Feb 7, 2022 at 5:05 AM Li Wang <liwang@redhat.com> wrote:
> >
> > It is easy to get VmSwap increase with a small system, here is
> > run with a 1G RAM kvm guest and TBROK:
> >
> >     7   tst_test.c:1365: TINFO: Timeout per run is 0h 05m 00s
> >     8   getrusage03.c:43: TPASS: initial.self ~=3D child.self
> >     9   getrusage03.c:57: TPASS: initial.children ~=3D 100MB
> >     10  getrusage03.c:66: TPASS: child.children =3D=3D 0
> >     11  getrusage03.c:84: TPASS: child.children ~=3D 300MB
> >     12  getrusage03.c:104: TPASS: initial.children ~=3D pre_wait.childr=
en
> >     13  getrusage03.c:112: TPASS: post_wait.children ~=3D 400MB
> >     14  getrusage03.h:25: TBROK: VmSwap is not zero
> >     15  getrusage03.c:133: TPASS: initial.children ~=3D
> after_zombie.children
> >     16  getrusage03.h:25: TBROK: VmSwap is not zero
> >     17  getrusage03_child.c:57: TPASS: initial.self ~=3D exec.self
> >     18  getrusage03_child.c:62: TPASS: initial.children ~=3D exec.child=
ren
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
>
> Acked-by: Jan Stancek <jstancek@redhat.com>
>
> This should fix the immediate failure, just wondering,
> would there be any downside of replacing that TBROK with TCONF?
>

I'm not quite sure. Seems it trying to test without swap happened to
guarantee less disturbing for the =E2=80=99->ru_maxrss=E2=80=98 counting.
TCONF looks a bit weak to attention if the regression occurs ATM.

--=20
Regards,
Li Wang

--0000000000008c7ae405d76c79a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Feb 7, 2022 at 5:16 PM Jan Stancek &lt;<a h=
ref=3D"mailto:jstancek@redhat.com" target=3D"_blank">jstancek@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Mon, Feb 7, 2022 at 5:05 AM Li Wang &lt;<a href=3D"mailto:liwang@redhat.com=
" target=3D"_blank">liwang@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; It is easy to get VmSwap increase with a small system, here is<br>
&gt; run with a 1G RAM kvm guest and TBROK:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A07=C2=A0 =C2=A0tst_test.c:1365: TINFO: Timeout per r=
un is 0h 05m 00s<br>
&gt;=C2=A0 =C2=A0 =C2=A08=C2=A0 =C2=A0getrusage03.c:43: TPASS: initial.self=
 ~=3D child.self<br>
&gt;=C2=A0 =C2=A0 =C2=A09=C2=A0 =C2=A0getrusage03.c:57: TPASS: initial.chil=
dren ~=3D 100MB<br>
&gt;=C2=A0 =C2=A0 =C2=A010=C2=A0 getrusage03.c:66: TPASS: child.children =
=3D=3D 0<br>
&gt;=C2=A0 =C2=A0 =C2=A011=C2=A0 getrusage03.c:84: TPASS: child.children ~=
=3D 300MB<br>
&gt;=C2=A0 =C2=A0 =C2=A012=C2=A0 getrusage03.c:104: TPASS: initial.children=
 ~=3D pre_wait.children<br>
&gt;=C2=A0 =C2=A0 =C2=A013=C2=A0 getrusage03.c:112: TPASS: post_wait.childr=
en ~=3D 400MB<br>
&gt;=C2=A0 =C2=A0 =C2=A014=C2=A0 getrusage03.h:25: TBROK: VmSwap is not zer=
o<br>
&gt;=C2=A0 =C2=A0 =C2=A015=C2=A0 getrusage03.c:133: TPASS: initial.children=
 ~=3D after_zombie.children<br>
&gt;=C2=A0 =C2=A0 =C2=A016=C2=A0 getrusage03.h:25: TBROK: VmSwap is not zer=
o<br>
&gt;=C2=A0 =C2=A0 =C2=A017=C2=A0 getrusage03_child.c:57: TPASS: initial.sel=
f ~=3D exec.self<br>
&gt;=C2=A0 =C2=A0 =C2=A018=C2=A0 getrusage03_child.c:62: TPASS: initial.chi=
ldren ~=3D exec.children<br>
&gt;<br>
&gt; Signed-off-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=
=3D"_blank">liwang@redhat.com</a>&gt;<br>
<br>
Acked-by: Jan Stancek &lt;<a href=3D"mailto:jstancek@redhat.com" target=3D"=
_blank">jstancek@redhat.com</a>&gt;<br>
<br>
This should fix the immediate failure, just wondering,<br>
would there be any downside of replacing that TBROK with TCONF?<br></blockq=
uote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:sm=
all">I&#39;m not quite sure. Seems it trying to test without swap happened =
to</div><div class=3D"gmail_default" style=3D"font-size:small">guarantee le=
ss disturbing for the =E2=80=99-&gt;ru_maxrss=E2=80=98 counting.</div></div=
><div class=3D"gmail_default" style=3D"font-size:small">TCONF looks a bit=
=C2=A0weak to attention if the regression occurs ATM.</div></div><div><br><=
/div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>L=
i Wang<br></div></div></div></div>

--0000000000008c7ae405d76c79a8--


--===============0427507245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0427507245==--

