Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C236BC433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 06:37:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 869413C9732
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 08:37:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EDE33C06A9
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 08:36:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EDC791A00241
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 08:36:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658817417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=odEbI9Jh29+HNmBZaBlcTO4wDy/1Gd3yW4fwKcqtwBg=;
 b=EYZUYxWT/bgph2BiLTsqEIFjklOml0XFGgZrU95Y6kLYF6bc2c9e1f3aalMXChsQGdK8Qo
 wRH8aSGjADugNJOnnWOb6O3UzBC51s42+91jkNAwmFNrUxp5qnafnWT1LTolRXhTI/hELh
 T+ArGKy1Zp+9NzL3eHneFgM1A+xHbHs=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-2kBwCC7lPEaO8EuuNEwCiw-1; Tue, 26 Jul 2022 02:36:55 -0400
X-MC-Unique: 2kBwCC7lPEaO8EuuNEwCiw-1
Received: by mail-yb1-f198.google.com with SMTP id
 b129-20020a25e487000000b0066e1c52ac55so10367982ybh.11
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 23:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=odEbI9Jh29+HNmBZaBlcTO4wDy/1Gd3yW4fwKcqtwBg=;
 b=vW0UwdWcMuzq+xzI/aJV1ouwcIRNLKs4/S+IOfhiTtQaEUdOmmWy6H0pXicKkU+8yi
 8mbdODDJCbsvg9K9TPcSWc6Cb/aFva69PUu/xBwE0MmbLSLvWsGWaw3z3CTWr0Ccc1FA
 ckSSRPT2rRFqFUPYeKHr32BudUGUEo0CAHfF0sZblnPp4FH5g0+Gt3P4Xwfh8QSHFf0D
 QOnKM9ZEg82/5sF4jpGTCj5Jl/6bLo7xwRTggrJiFjcORFawEXBDKpGNvLLcs8aj+04O
 wFm1qraOSM+58oUWOEBQuZQQPt4osA26Ff0FYhAEj6/kKh28I5F9yml29wKQKAPC/L2x
 L1oQ==
X-Gm-Message-State: AJIora/qqaeNFLgWPieyWxTQzIdidfenit4q491MlxoUqNouPxtFsj4h
 my8AoHVU/7Tbw+VxpX1pJxDi1J8SzjQJGEYzDklQNBK0Ow7LbfBp1S9UEIBGAWrbRzINE9gE7Rx
 ZySTYiOtcnUqIbRBvHGDHTl6OSIw=
X-Received: by 2002:a05:690c:708:b0:31e:5ba7:9e38 with SMTP id
 bs8-20020a05690c070800b0031e5ba79e38mr12958170ywb.320.1658817415345; 
 Mon, 25 Jul 2022 23:36:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uboyISKEuKbIOkVwnDJ5Q77KF0K7nKgU/8UBu8TPD5tNbkDWCpL8U17+HBfzv7+KFU5EbBpLK8W4+NFdp6Aik=
X-Received: by 2002:a05:690c:708:b0:31e:5ba7:9e38 with SMTP id
 bs8-20020a05690c070800b0031e5ba79e38mr12958156ywb.320.1658817415175; Mon, 25
 Jul 2022 23:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <caab3f8e65b22bf00aa2fa1da9669c7f43df119d.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <8735ep5sdb.fsf@suse.de>
In-Reply-To: <8735ep5sdb.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Jul 2022 14:36:44 +0800
Message-ID: <CAEemH2cYdGEC7hCSxBbqnTrR-qCQxDMRyUjxbpGHF-kNYYrW7Q@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 11/18] controllers: Update cgroup_fj_* to use
 newer cgroup lib and test lib
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
Cc: LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: multipart/mixed; boundary="===============0180394488=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0180394488==
Content-Type: multipart/alternative; boundary="000000000000c774a005e4af8629"

--000000000000c774a005e4af8629
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 25, 2022 at 7:44 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

>
> Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> writes:
>
> > +setup()
> > +{
> > +    common_setup
>
> This can fail and we have not set pid yet.
>
> > +    cgroup_fj_proc&
> > +    pid=$!
> > +    create_subgroup "$start_path/ltp_1"
> > +}
> >
> > -ROD kill -9 $pid
> > -wait $pid
> > -ROD rmdir "$start_path/ltp_1"
> > +cleanup()
> > +{
> > +    kill -9 $pid >/dev/null 2>&1
> > +    wait $pid >/dev/null 2>&1
>
> $pid is unset so this just waits forever. We need something like the
> following:
>
>     if [ -n "$pid" ]; then
>       kill -9 $pid >/dev/null 2>&1
>       wait $pid >/dev/null 2>&1
>     fi
>
>
+1 Someone who merges patch can help fix this.

-- 
Regards,
Li Wang

--000000000000c774a005e4af8629
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Jul 25, 2022 at 7:44 PM Richard Palethorpe =
&lt;<a href=3D"mailto:rpalethorpe@suse.de" target=3D"_blank">rpalethorpe@su=
se.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canoni=
cal.com" target=3D"_blank">luke.nowakowskikrijger@canonical.com</a>&gt; wri=
tes:<br>
<br>
&gt; +setup()<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 common_setup<br>
<br>
This can fail and we have not set pid yet.<br>
<br>
&gt; +=C2=A0 =C2=A0 cgroup_fj_proc&amp;<br>
&gt; +=C2=A0 =C2=A0 pid=3D$!<br>
&gt; +=C2=A0 =C2=A0 create_subgroup &quot;$start_path/ltp_1&quot;<br>
&gt; +}<br>
&gt;=C2=A0 <br>
&gt; -ROD kill -9 $pid<br>
&gt; -wait $pid<br>
&gt; -ROD rmdir &quot;$start_path/ltp_1&quot;<br>
&gt; +cleanup()<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 kill -9 $pid &gt;/dev/null 2&gt;&amp;1<br>
&gt; +=C2=A0 =C2=A0 wait $pid &gt;/dev/null 2&gt;&amp;1<br>
<br>
$pid is unset so this just waits forever. We need something like the<br>
following:<br>
<br>
=C2=A0 =C2=A0 if [ -n &quot;$pid&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 kill -9 $pid &gt;/dev/null 2&gt;&amp;1<br>
=C2=A0 =C2=A0 =C2=A0 wait $pid &gt;/dev/null 2&gt;&amp;1<br>
=C2=A0 =C2=A0 fi<br>
<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-=
size:small">+1 Someone who merges patch can help fix this.</div></div><div>=
<br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><=
div>Li Wang<br></div></div></div></div>

--000000000000c774a005e4af8629--


--===============0180394488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0180394488==--

