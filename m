Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F13C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 07:53:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92C963C0F41
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 08:53:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8DA53C05C3
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 08:53:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2A43B1000543
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 08:53:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646898823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mB7xE6t/3ye47STmVXGCQDEOO3ceGHn4ockSdf0V1vE=;
 b=LNLVOJIeaWLh7eKQzSef9lPBYm2kq5JWJECFSJmwipTpUvWfyjUMRUyrYD6J1pJxvklIa9
 uWLXjY2hwjy648xP/+GZapw6AQHVxYyF3fC3umBcSo0DLcS72b4g2Gh7wdCTjsuKbG6Bsw
 f7ZxiYWU5XE1G1LHF2Duk6e8mS6UWgQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-EAC2WlzUNx-RjLEOC9zUOg-1; Thu, 10 Mar 2022 02:53:41 -0500
X-MC-Unique: EAC2WlzUNx-RjLEOC9zUOg-1
Received: by mail-yb1-f200.google.com with SMTP id
 g2-20020a5b0242000000b0062892750241so3754758ybp.23
 for <ltp@lists.linux.it>; Wed, 09 Mar 2022 23:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mB7xE6t/3ye47STmVXGCQDEOO3ceGHn4ockSdf0V1vE=;
 b=eo2QhhEov1hf5i+XzNhTOcmA+pxuvzHVmC3wofbRS5PrGYLJbQ2IpW5/7UdAQjSqkc
 BhHHGwFjcED2g3nZNnMjSLVMYQgyE3QS2pXSzQCDjOyT9CtqMg4XpYciLq2XL/pPDAwJ
 siOr4IwJetf9XbpUpJvkflfgvZj26x5Oc6mTrirIKtR8RAiTJ8O1c1wBXpvTSgIRFmCS
 XUhR3Mh0lIIoRx21r1HtIFOkjVT49Uxd3meoxVAFMRqg0kvY4Y1VatfAmO/kO6uYWQ06
 wurnvpWkDXuS7zbAGKdKtdw7tXs3eVqzctFNHJGQCB0JVVAIqXDzJrjgHHYGpmfmDJdC
 UTgA==
X-Gm-Message-State: AOAM532TlR4lRKPoE+JRUD0WPXRRNhfw4dUT0bn3zDtrhrED3zmEQ6u7
 7nOYkDew8NLT5MH42sY8BXAcKzehH/2/eh6zx5CQGiPtXfmtyz2aYA+xsLHZlVQqjW9Tcs9Yn3c
 9vkYitLeVkc4hX5GbPxLuYdvRFtc=
X-Received: by 2002:a81:3744:0:b0:2dc:370:8a0e with SMTP id
 e65-20020a813744000000b002dc03708a0emr3050667ywa.208.1646898820615; 
 Wed, 09 Mar 2022 23:53:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4T8ehX56B4drccXVK6mGxO3AVznMJjyfH1VsoWfT57hntWwBG0BigMdVsDQ2Z59iE0uUbY0Li3N4rfTJlvgE=
X-Received: by 2002:a81:3744:0:b0:2dc:370:8a0e with SMTP id
 e65-20020a813744000000b002dc03708a0emr3050650ywa.208.1646898820153; Wed, 09
 Mar 2022 23:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20220308073709.4125677-1-liwang@redhat.com>
 <20220309030440.4166954-1-liwang@redhat.com>
 <20220309030440.4166954-2-liwang@redhat.com> <6229AC3C.2040608@fujitsu.com>
In-Reply-To: <6229AC3C.2040608@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Mar 2022 15:53:25 +0800
Message-ID: <CAEemH2cNzETHwR2Zj-rj+inO7TxaSop+wH2r=CM0fb-3TRYQQQ@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] lib: enhance .save_restore to support set
 expected value
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
Cc: Bruno Goncalves <bgoncalv@redhat.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0711103343=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0711103343==
Content-Type: multipart/alternative; boundary="00000000000028238605d9d883f1"

--00000000000028238605d9d883f1
Content-Type: text/plain; charset="UTF-8"

> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -259,7 +259,7 @@ struct tst_test {
> >        * NULL terminated array of (/proc, /sys) files to save
> >        * before setup and restore after cleanup
> >        */
> > -     const char * const *save_restore;
> > +     const struct tst_path_val const *save_restore;
> Ci complains about duplicate const see the following url
>
> https://github.com/linux-test-project/ltp/runs/5491806027?check_suite_focus=true#step:10:19
>
> How about using const struct tst_path_val *save_restore like
> other struct pointer( struct tst_cap *caps, const struct tst_tag *tags)?
>

Yes, good catch. Can you send a patch to fix the compiling issue or I do
that?

-- 
Regards,
Li Wang

--00000000000028238605d9d883f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
&gt; --- a/include/tst_test.h<br>
&gt; +++ b/include/tst_test.h<br>
&gt; @@ -259,7 +259,7 @@ struct tst_test {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * NULL terminated array of (/proc, /sys) fi=
les to save<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * before setup and restore after cleanup<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0const char * const *save_restore;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct tst_path_val const *save_restore;<br=
>
Ci complains about duplicate const see the following url<br>
<a href=3D"https://github.com/linux-test-project/ltp/runs/5491806027?check_=
suite_focus=3Dtrue#step:10:19" rel=3D"noreferrer" target=3D"_blank">https:/=
/github.com/linux-test-project/ltp/runs/5491806027?check_suite_focus=3Dtrue=
#step:10:19</a><br>
<br>
How about using const struct tst_path_val *save_restore like<br>
other struct pointer( struct tst_cap *caps, const struct tst_tag *tags)?<br=
></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-siz=
e:small">Yes, good catch. Can you send a patch to fix the=C2=A0compiling is=
sue or I do that?</div><div class=3D"gmail_default" style=3D"font-size:smal=
l"><br></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div d=
ir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000028238605d9d883f1--


--===============0711103343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0711103343==--

