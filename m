Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CBBC433EF
	for <ltp@archiver.kernel.org>; Sun,  8 May 2022 02:22:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72A5B3CA8D3
	for <ltp@archiver.kernel.org>; Sun,  8 May 2022 04:22:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EACE3C0595
 for <ltp@lists.linux.it>; Sun,  8 May 2022 04:22:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 38E1E6005CB
 for <ltp@lists.linux.it>; Sun,  8 May 2022 04:22:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651976554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=neWK0VFJmBc4odJ/6Y/hfad9iCjLPa5B/No4FU9zBX0=;
 b=RU5dh5JE4KCZxa3pGlR3nPh4eySsLwR75fjRsY5J1PM7UjD7FviVfea2z1fZ2Ikw7V1ORi
 +3K7tRbA4VjOhKSgHPhzvX9lym3T73MlZuUhah/8jZL8n7J0r4lUHXHIAKCAwv+pV4irEu
 8SX89d0X9ZFDqAmsXA5/ClmLrLj/tgA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-amNed1GXP_Og36U75qqFAg-1; Sat, 07 May 2022 22:22:33 -0400
X-MC-Unique: amNed1GXP_Og36U75qqFAg-1
Received: by mail-yb1-f198.google.com with SMTP id
 j11-20020a05690212cb00b006454988d225so9296594ybu.10
 for <ltp@lists.linux.it>; Sat, 07 May 2022 19:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=neWK0VFJmBc4odJ/6Y/hfad9iCjLPa5B/No4FU9zBX0=;
 b=7gaW3ia6wRkK+W442qdG65JQjlJUq+JrdbsS/kNRFM5o72flBfXAmv72hEKwQ3dOAF
 SxcI0Toz3FbdWALCNiPMc13UJCfvNBxGXBT9jYOmlGYGuTEv2KA7ereqIi2FpcQth8PD
 RxKsaZ0Cpr+DLLjgCFTypVPeT5MQAsOWFW+YjSM+iG2Zbem3hU9IF8JfIaxbsu+FvsmQ
 xCLSqWbwN4bEPgZ59/jlys+ks3dbYyTibjbYP0AMqTMoQaF5EiH6vBQSpP2XpxaZps7V
 Y4WRMSYkW2ePD1SMhbbQtDvjZWwxSgXB5YV+sRR7DzXdTpOeHxtBTpgpjy2KYETri6My
 94hQ==
X-Gm-Message-State: AOAM530goGDBdqlIJAB9hIWLY+cKAewtcbhnR0VVX72mwQdjXJ8wv8LH
 O/TE8HeZ9DhICpVLEz5GBFsNdMevN73Yl/QbaNcaVfkp/o7zRjH4/pL9Oezbg4PCh5kOMseIJsm
 wTuTTTaUrS27z/CxqqFFitPqz7p0=
X-Received: by 2002:a81:7b56:0:b0:2ec:2d65:7ccf with SMTP id
 w83-20020a817b56000000b002ec2d657ccfmr8341807ywc.208.1651976552493; 
 Sat, 07 May 2022 19:22:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+7IqVNbogb9i4TGrtwgHTBwCxwM2vh0fJ1fRabT618QgK/fts2Sluj0J4mzoRgbawunE04sR9doux4VQpPJI=
X-Received: by 2002:a81:7b56:0:b0:2ec:2d65:7ccf with SMTP id
 w83-20020a817b56000000b002ec2d657ccfmr8341803ywc.208.1651976552243; Sat, 07
 May 2022 19:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220428132656.11075-1-liwang@redhat.com>
 <20220428132656.11075-4-liwang@redhat.com> <YnPZl1jFQnj0up8I@yuki>
In-Reply-To: <YnPZl1jFQnj0up8I@yuki>
From: Li Wang <liwang@redhat.com>
Date: Sun, 8 May 2022 10:22:21 +0800
Message-ID: <CAEemH2d-83ubH1LF3SotjvxwD_5C0BiLTTZ+yGtaYqv47n28AQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] rtc02: loosen the compare precision with few
 seconds
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
Cc: Eirik Fuller <efuller@redhat.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1449631782=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1449631782==
Content-Type: multipart/alternative; boundary="00000000000093021f05de76c3f6"

--00000000000093021f05de76c3f6
Content-Type: text/plain; charset="UTF-8"

On Thu, May 5, 2022 at 10:03 PM Cyril Hrubis <chrubis@suse.cz> wrote:


> > +      * To handle the normal and special situations:
> > +      * 1#
> > +      *       set_tm:  2022-04-28 13:00:50
> > +      *       read_tm: 2022-04-28 13:00:50
> > +      * 2#
> > +      *       set_tm:  2022-04-28 13:00:50
> > +      *       read_tm: 2022-04-28 13:00:51
> > +      * 3#
> > +      *       set_tm:  2022-04-28 13:00:59
> > +      *       read_tm: 2022-04-28 13:01:00
> > +      * 4#
> > +      *       set_tm:  2022-04-28 13:59:59
> > +      *       read_tm: 2022-04-28 14:00:00
> > +      *
> > +      * Note: as we have avoided testing around the zero
> > +      * clock, so it's impossible to hit situation 5#
> > +      *       set_tm:  2022-04-28 23:59:59
> > +      *       read_tm: 2022-04-29 00:00:00
> > +      */
> > +
> > +     /* 1~3 */
> > +     if (set_tm->tm_hour == read_tm->tm_hour) {
> > +             if (set_tm->tm_min == read_tm->tm_min - 1)
> > +                     delta += 60;
> > +             else if (set_tm->tm_min != read_tm->tm_min)
> > +                     return 1;
> > +     }
> > +
> > +     /* 4 */
> > +     if ((set_tm->tm_hour == read_tm->tm_hour - 1) &&
> > +                     (set_tm->tm_min == read_tm->tm_min + 59))
> > +             delta += 60;
> > +     else if ((set_tm->tm_hour != read_tm->tm_hour))
> > +             return 1;
> > +
> > +     if (delta < 0 || delta > 3)
> > +             return 1;
> > +
> > +     return !((set_tm->tm_mday == read_tm->tm_mday)
> >               && (set_tm->tm_mon == read_tm->tm_mon)
> >               && (set_tm->tm_year == read_tm->tm_year));
>
> Wouldn't it be easier to convert both dates into a 64bit timestamp and
> compare the timestamps?
>

Yeah, this is a good thought. And we don't even need to convert all dates
because we have avoided the zero clock setting. IOW, just take the
hours/min/sec to be compared should be enough.
Update process:
  patch1/3: drop this one until we find a good way to detect hardware
support.
  patch2/3: pushed.
  patch3/3: will send a V2.

-- 
Regards,
Li Wang

--00000000000093021f05de76c3f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, May 5, 2022 at 10:03 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 * To handle the normal and special situations:<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 * 1#<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0set_tm:=C2=A0 2022-0=
4-28 13:00:50<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0read_tm: 2022-04-28 =
13:00:50<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * 2#<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0set_tm:=C2=A0 2022-0=
4-28 13:00:50<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0read_tm: 2022-04-28 =
13:00:51<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * 3#<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0set_tm:=C2=A0 2022-0=
4-28 13:00:59<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0read_tm: 2022-04-28 =
13:01:00<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * 4#<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0set_tm:=C2=A0 2022-0=
4-28 13:59:59<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0read_tm: 2022-04-28 =
14:00:00<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Note: as we have avoided testing around the ze=
ro<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * clock, so it&#39;s impossible to hit situation=
 5#<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0set_tm:=C2=A0 2022-0=
4-28 23:59:59<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0read_tm: 2022-04-29 =
00:00:00<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* 1~3 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (set_tm-&gt;tm_hour =3D=3D read_tm-&gt;tm_hour=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (set_tm-&gt;tm_min=
 =3D=3D read_tm-&gt;tm_min - 1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0delta +=3D 60;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (set_tm-&gt;t=
m_min !=3D read_tm-&gt;tm_min)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* 4 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if ((set_tm-&gt;tm_hour =3D=3D read_tm-&gt;tm_hou=
r - 1) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(set_tm-&gt;tm_min =3D=3D read_tm-&gt;tm_min + 59))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delta +=3D 60;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else if ((set_tm-&gt;tm_hour !=3D read_tm-&gt;tm_=
hour))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (delta &lt; 0 || delta &gt; 3)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return !((set_tm-&gt;tm_mday =3D=3D read_tm-&gt;t=
m_mday)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; (set_=
tm-&gt;tm_mon =3D=3D read_tm-&gt;tm_mon)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; (set_=
tm-&gt;tm_year =3D=3D read_tm-&gt;tm_year));<br>
<br>
Wouldn&#39;t it be easier to convert both dates into a 64bit timestamp and<=
br>
compare the timestamps?<br></blockquote><div><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">Yeah, this is a good=C2=A0thought. And w=
e don&#39;t even need to convert all dates</div><div class=3D"gmail_default=
" style=3D"font-size:small">because we have avoided the zero clock setting.=
 IOW, just take the=C2=A0</div><div class=3D"gmail_default" style=3D"font-s=
ize:small">hours/min/sec to be compared should be=C2=A0enough.</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"></div><div class=3D"gmail_d=
efault" style=3D"font-size:small">Update process:</div><div class=3D"gmail_=
default" style=3D"font-size:small">=C2=A0 patch1/3: drop this one until we =
find a good way to detect hardware support.</div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">=C2=A0 patch2/3: pushed.</div><div class=3D"gm=
ail_default" style=3D"font-size:small">=C2=A0 patch3/3: will send a V2.</di=
v></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></d=
iv>

--00000000000093021f05de76c3f6--


--===============1449631782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1449631782==--

