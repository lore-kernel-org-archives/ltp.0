Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B49C433FE
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 10:35:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A382F61051
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 10:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A382F61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 854973C951E
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 12:35:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16C413C077E
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 12:35:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C4EEE200AE4
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 12:35:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630924535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2e8s5OEHxYVD8kI3qGCPQoTafewqlZuu/Gc75/51cEs=;
 b=EHsQUz/agujy8u51OQ49f8/5azVa+sQLD4OioJC2LOuJtlpX4xG1+n/+kpVpSpPVv6IkAO
 4OiizF1hLGGCZdn3gFo9mW4XmgkGK+HUP+nPky084wb9Q2C54JDoefQYrZgqtSPLLQaXJ6
 l+CVKZdq7GKCjl5rYA97pH6fG3xF+vY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-MWNM4BegNC-vA6UjX6sS8Q-1; Mon, 06 Sep 2021 06:35:32 -0400
X-MC-Unique: MWNM4BegNC-vA6UjX6sS8Q-1
Received: by mail-yb1-f198.google.com with SMTP id
 f64-20020a2538430000b0290593bfc4b046so7899003yba.9
 for <ltp@lists.linux.it>; Mon, 06 Sep 2021 03:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2e8s5OEHxYVD8kI3qGCPQoTafewqlZuu/Gc75/51cEs=;
 b=rcwZDmuSeaFkEdle7b4PwW0VtMQB6HH/iqDVXNKFmqESIVGKPpNNzBVDPRqu3Ie1+g
 aq+/AltKeKiIs7qUTsSaPLFoQzLZbUOat7XVWsGJLTH94VtC0JUT4mDBZcW4oWWjcQhL
 a8JMw+p1zKqI2w9GN53X/GTIcUSk1fbW+/HW3n9OjIDPx2HRtvP72ygZ7CPLTmiN6uXC
 rprE9TNYOZI7hN7s7hAuEjlKvN36BwBYLwkuRvmxsnkO7M5gFGgrljbrZ8akVqTcphZI
 r1gz95HBR4UgrqnBhCp3M5XnTSVWbWAVHtORfjB478gn+guG64d4D2XsFxIGC8/aAMUK
 XcDQ==
X-Gm-Message-State: AOAM5316wUXux36e3n+245FgstWg5cGbI1TTHCMzjdhG69tsR+afNGP/
 QAJSotLLG2nQMV1mWvC7tj00M+YPv5k/V+fUqaVAdBMJjVmCSQcHvoerOLJH7UpKNNVchTuHXt7
 qzETGpgdGsnEq19XHf5dRpHmhNuI=
X-Received: by 2002:a25:e6d2:: with SMTP id
 d201mr15363079ybh.396.1630924531565; 
 Mon, 06 Sep 2021 03:35:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq55Htv0a/VMoTLBXuvwWoueRvwyWpRvCI2gTsYKaNbh38cWp8/lXygGQ99XZ171PcR1FLNggid/cBck3jXuU=
X-Received: by 2002:a25:e6d2:: with SMTP id
 d201mr15363054ybh.396.1630924531274; 
 Mon, 06 Sep 2021 03:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210906060020.3219023-1-liwang@redhat.com>
 <YTXYixG37nBTzhXk@yuki>
In-Reply-To: <YTXYixG37nBTzhXk@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 6 Sep 2021 18:35:19 +0800
Message-ID: <CAEemH2frfyGCsZAsam7CgGfW-BC1ah9YQZz=H=meJMM+zrTnAw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] copy_file_range03: comparing timestamp in
 tst_timespec_diff
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
Content-Type: multipart/mixed; boundary="===============1168200709=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210906103519.NjyycIn-N2LO3ogm1z_uF0mFQpq5FCf4FEsU2VJstHo@z>

--===============1168200709==
Content-Type: multipart/alternative; boundary="00000000000057acb305cb513542"

--00000000000057acb305cb513542
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 6, 2021 at 4:59 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > -     updated_timestamp = get_timestamp(fd_dest);
> > +     timestamp2 = get_timestamp(fd_dest);
> >
> > -     if (timestamp == updated_timestamp)
> > +     diff = tst_timespec_diff(timestamp1, timestamp2);
> > +
> > +     if (!diff.tv_sec && !diff.tv_nsec)
> >               tst_brk(TFAIL, "copy_file_range did not update
> timestamp.");
>
> So as we changed the code to sleep for 1.5 sec I guess that we can
> expect the difference to be at least 1 second because:
>
> - the minimal granularity is 1s in which case we will get exactly 1s in
>   the diff
>
> - if the granularity is greater, we will get a bit more than 1s
>
> So I would go for something as:
>
>         long long diff_us = tst_timespec_diff_us(timestamp2, timestamp1);
>
>         if (diff_us >= 1000000 && diff_us <= 2000000)
>                 tst_res(TPASS, "...");
>
> Which expects that the difference between timestamps is in a sane range
> not that it just have been changed.
>

Theoretically, this is correct, but I'm fearing that the process might
cost more time on performing with different system loads.

This means 'diff_us <= 2000000' is an unreliable condition to
many virtual machines. That largely depends on the system
scheduler at that moment as well.



>
> >       tst_res(TPASS, "copy_file_range sucessfully updated the
> timestamp");
> > --
> > 2.31.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
>

-- 
Regards,
Li Wang

--00000000000057acb305cb513542
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 6, 2021 at 4:59 PM Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; -=C2=A0 =C2=A0 =C2=A0updated_timestamp =3D get_timestamp(fd_dest);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0timestamp2 =3D get_timestamp(fd_dest);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (timestamp =3D=3D updated_timestamp)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0diff =3D tst_timespec_diff(timestamp1, timestamp2=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!diff.tv_sec &amp;&amp; !diff.tv_nsec)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TFAIL, &=
quot;copy_file_range did not update timestamp.&quot;);<br>
<br>
So as we changed the code to sleep for 1.5 sec I guess that we can<br>
expect the difference to be at least 1 second because:<br>
<br>
- the minimal granularity is 1s in which case we will get exactly 1s in<br>
=C2=A0 the diff<br>
<br>
- if the granularity is greater, we will get a bit more than 1s<br>
<br>
So I would go for something as:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 long long diff_us =3D tst_timespec_diff_us(time=
stamp2, timestamp1);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (diff_us &gt;=3D 1000000 &amp;&amp; diff_us =
&lt;=3D 2000000)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TPASS, &quo=
t;...&quot;);<br>
<br>
Which expects that the difference between timestamps is in a sane range<br>
not that it just have been changed.<br></blockquote><div><br></div><div><di=
v class=3D"gmail_default" style=3D"font-size:small">Theoretically, this is =
correct, but I&#39;m fearing that the process might</div><div class=3D"gmai=
l_default" style=3D"font-size:small">cost more time on performing with diff=
erent system loads.</div><div class=3D"gmail_default" style=3D"font-size:sm=
all"><br></div><div class=3D"gmail_default" style=3D"font-size:small">This =
means &#39;diff_us &lt;=3D 2000000&#39; is an unreliable condition to</div>=
<div class=3D"gmail_default" style=3D"font-size:small">many virtual machine=
s. That largely depends on the system</div><div class=3D"gmail_default" sty=
le=3D"font-size:small">scheduler at that moment as well.</div><br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TPASS, &quot;copy_file_range sucessf=
ully updated the timestamp&quot;);<br>
&gt; -- <br>
&gt; 2.31.1<br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=
=3D"noreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><b=
r>
<br>
-- <br>
Cyril Hrubis<br>
<a href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a><br=
>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--00000000000057acb305cb513542--


--===============1168200709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1168200709==--

