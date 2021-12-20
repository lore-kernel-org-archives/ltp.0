Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C462C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 05:02:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88EA23C90E4
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 06:02:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5BC53C0EBB
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 06:02:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3502D600793
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 06:02:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639976521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dcn/rzlqYzH2wtEdlMpeT3b4ZkXMn7ZrhP1i8SyTLjo=;
 b=ON4difXMAjxJppkqs+sLwXV8ORIan5O2qA1H/j8RGMH6ZdT0BztSAd6xe+C8Q3nckl1G7v
 q8tB6+ZcN/MDaFdV0eb/9oAM+0CT8xjV5mOyEV4bNmAqgfwBJNFX79MtHzddbugn+uEu2l
 nIrpJy8XISvmQBdXI3X70d7n5Ejy+eY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-UQqCoeCTOQGLkQi7Ms7iGw-1; Mon, 20 Dec 2021 00:01:59 -0500
X-MC-Unique: UQqCoeCTOQGLkQi7Ms7iGw-1
Received: by mail-yb1-f199.google.com with SMTP id
 l145-20020a25cc97000000b005c5d04a1d52so17525522ybf.23
 for <ltp@lists.linux.it>; Sun, 19 Dec 2021 21:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dcn/rzlqYzH2wtEdlMpeT3b4ZkXMn7ZrhP1i8SyTLjo=;
 b=4F4fqUOWumsOsbXeokAP2XcugZ8TWD8PSHZB3zvIxc85IaHz/R3Ka930tKYfj9EomE
 moUcWrkd9uptNdNMYqlJjw0WpZT7baQ3Jo4VfZgzyVFGkT9w8eemUomjIx241l/f5MyX
 peMNzwiBiiQhcXQjq354vO1FJ7bkMo2snoOuZZOevk9f/nd1pARxQrk2n+emXLuWl8BK
 kW/+a9uaYf3ZvFdZwr/buEZeZoDHt7DdA8wV+L+lj5ZgrVEiSIFC8UBdljxBsXlt8V22
 1LuXw3US82kelmRm1Yn7wRIhfNcKbK0upOZdzULHQfR667NN4sNIcgKs11qahbHpQc/N
 l4Sw==
X-Gm-Message-State: AOAM533t24rGxRBilV5EqRwj6TxECRdRIZbabpd9plm5nNrwBGJydTIO
 2eWeFJ7DL8sUcJuQ05dlLadMI9CF0fzu9e/GqNaQjEj/VkgDcl5bE1uXMCAgFWBF3vH82VjyzRJ
 uc3OeV1RWjFs3NR36PML5WZAypsU=
X-Received: by 2002:a05:6902:4f4:: with SMTP id
 w20mr20688217ybs.421.1639976518881; 
 Sun, 19 Dec 2021 21:01:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaN0lDBKsur2HGehoUzNxWSXS6D1Y0Wst5BPHnoEY57MYisUD4F15t2s7yXMFdXR2lBymDvsgGVl19PfvJR8w=
X-Received: by 2002:a05:6902:4f4:: with SMTP id
 w20mr20688192ybs.421.1639976518575; 
 Sun, 19 Dec 2021 21:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20211217113751.359613-1-liwang@redhat.com>
 <20211217113751.359613-3-liwang@redhat.com> <Ybyj5nEb7k+5dtmb@yuki>
In-Reply-To: <Ybyj5nEb7k+5dtmb@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 20 Dec 2021 13:01:45 +0800
Message-ID: <CAEemH2ck0HdR_yoGsstZrSWOa3gRVYzBMowB_kzr+GQ0UfjNQQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] oom: enable OOM protection for mem lib
 process
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
Content-Type: multipart/mixed; boundary="===============1683555746=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1683555746==
Content-Type: multipart/alternative; boundary="000000000000d4819105d38cc9c2"

--000000000000d4819105d38cc9c2
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 17, 2021 at 10:49 PM Cyril Hrubis <chrubis@suse.cz> wrote:


>
> > +     tst_enable_oom_protection(getpid());
> > +
> >       switch (pid = SAFE_FORK()) {
> >       case 0:
> > +             tst_cancel_oom_protection(getpid());
> >               threads = MAX(1, tst_ncpus() - 1);
> >               child_alloc(testcase, lite, threads);
> >       default:
>
> Looking at the code we have, we always pass getpid(). We may as well
> change the library to use /proc/self/oom_score_adj if 0 is passed
> instead of the pid.
>

Yes, agree with all suggestions (include comments in 1/3 2/3).

-- 
Regards,
Li Wang

--000000000000d4819105d38cc9c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Dec 17, 2021 at 10:49 PM Cyril Hrubis &lt;<=
a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"> <br>
&gt; +=C2=A0 =C2=A0 =C2=A0tst_enable_oom_protection(getpid());<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (pid =3D SAFE_FORK()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_cancel_oom_protec=
tion(getpid());<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0threads =3D MAX(=
1, tst_ncpus() - 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0child_alloc(test=
case, lite, threads);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
<br>
Looking at the code we have, we always pass getpid(). We may as well<br>
change the library to use /proc/self/oom_score_adj if 0 is passed<br>
instead of the pid.<br>
</blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size=
:small">Yes, agree with all suggestions (include comments in 1/3 2/3).</div=
></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><di=
v dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></di=
v>

--000000000000d4819105d38cc9c2--


--===============1683555746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1683555746==--

