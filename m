Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E94C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 06:52:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D126112D
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 06:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 71D126112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C46B3C07B5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 07:52:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 352713C04CF
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 07:52:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9BF8E608A99
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 07:52:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636440749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZsN+qD5mj9bN7MdRJmmYnCQs4rSyVdTgatHb+POyh20=;
 b=TKqRQxBwIG253UENI/POSQCvroYkVCGcVGki5qNYgZYAnIsw70T19ZVIYR8QkozN7syiBT
 o2EL4EtX/azytejqsX98nwxUgXtGH2lqnRRzh1iBzRlyZ/KXitGi0Y23WoPxy+oedDguOh
 kFlc+gO+AMJluVvCI1Y1XHG8Z3BRIAk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-7Sn6fmMHNCOVlYMSpluO2w-1; Tue, 09 Nov 2021 01:52:27 -0500
X-MC-Unique: 7Sn6fmMHNCOVlYMSpluO2w-1
Received: by mail-yb1-f199.google.com with SMTP id
 z65-20020a256544000000b005c21b35717dso28947832ybb.10
 for <ltp@lists.linux.it>; Mon, 08 Nov 2021 22:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZsN+qD5mj9bN7MdRJmmYnCQs4rSyVdTgatHb+POyh20=;
 b=dNgreabIJ+pnAuJrdUdC6tyBTiy+fPHjE4uNa9Z9eQ+su2Koz0nEoOjXxlMqRuouL2
 16lD7Z+OJRbG31xDCfSCZUfVkdyj3GRio77Xp1hzdaeDz1fdC1xesH7tBMBNzFKaj0EI
 FvOmNCBV1QxCUx2j81h4eCIt27Mwnj8SarXNxYVgH6uKBHJLIStHQblH55LwJer8y4xl
 qqFbSsFLtTgYS2yhpWKajAt1DOPmOhwd+sN4esL3m+hUfNZvSDFid4/4tgylp7CyOx92
 wnhnIcScDVOPqeiAVseWKpixVZlRtVHRzyINUGeoza/8cIGN7rsYlDSGinww1OLMtRxd
 WfMw==
X-Gm-Message-State: AOAM531mFOfe05HNf8rJ0kwnSJ1cVgmreZfw9btqljvY2ccqTrneLik1
 Xhux15NJ/jFjC+bGHTbs8i25Q/e7qBlf6oeulaZJDLwGi7FvzedSdVzGWpD3e1VwhNJqjrHbwq+
 lQeJnonXCsT5VFCgmwQCzqNOb6+o=
X-Received: by 2002:a25:a062:: with SMTP id x89mr5926670ybh.339.1636440747001; 
 Mon, 08 Nov 2021 22:52:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyX2gRCek7Q+nh1GHavidJr0mUz1LlXWgAt5TEOkYHLHCmfEOBZrlcmUzmEy0Gl6iuT75+Ft9n6vzbkv0ujdxQ=
X-Received: by 2002:a25:a062:: with SMTP id x89mr5926645ybh.339.1636440746725; 
 Mon, 08 Nov 2021 22:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20211108021450.1460819-1-liwang@redhat.com>
 <20211108021450.1460819-2-liwang@redhat.com>
 <YYkbAEITAiGbdTTk@yuki>
In-Reply-To: <YYkbAEITAiGbdTTk@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Nov 2021 14:52:14 +0800
Message-ID: <CAEemH2eYBJ8X21JZDTcuathM6dZq2OheR1NspCaU3kdixuv6wQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] testcase: make use of .supported_archs
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
Content-Type: multipart/mixed; boundary="===============1784842100=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1784842100==
Content-Type: multipart/alternative; boundary="00000000000067ad3305d0558d78"

--00000000000067ad3305d0558d78
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 8, 2021 at 8:40 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> >       asm volatile (
> >               "add $0x400, %%esp\n\t"
> >               "int $0x80\n\t"
> > @@ -114,15 +112,14 @@ static void run(void)
> >
> >  static struct tst_test test = {
> >       .test_all = run,
> > +     .supported_archs = (const char *const []) {
> > +             "i386",
> > +             "ppc",
> > +             NULL
> > +     },
> >       .tags = (const struct tst_tag[]) {
> >               {"linux-git", "cf01fb9985e8"},
> >               {"CVE", "CVE-2017-7616"},
> >               {}
> >       }
> >  };
> > -
> > -#else /* #if defined(__x86_64__) || defined(__powerpc__) */
> > -
> > -TST_TEST_TCONF("not i386 or powerpc");
> > -
> > -#endif /* #else #if defined(__x86_64__) || defined(__powerpc__) */
>
> Accordingly to this table:
>
> https://wiki.debian.org/ArchitectureSpecificsMemo
>
> __powerpc__ matches both 32bit and 64bit variants.
>
> I guess that we would have to change the checks in the library as:
>

Yes, but I think we can simply reverse the order to solve this.
It will try to match 64bit firstly otherwise 32bit. The s390 does as well.

....
#elif defined(__powerpc64__ || __ppc64__)
        .name = "ppc64",
        .type = TST_PPC64,
#elif defined(__powerpc__ || __ppc__)
        .name = "ppc",
        .type = TST_PPC,
#elif defined(__s390x__)
        .name = "s390x",
        .type = TST_S390X,
#elif defined(__s390__)
        .name = "s390",
        .type = TST_S390,
....



>
> #ifdef __powerpc__
> # ifdef __powerpc64__ || __ppc64__
> .arch = "ppc64",
> .type = TST_PPC64,
> # else
> .arch = "ppc",
> .type = "TST_PPC"
> # endif
> #endif
>
> Also I guess that gcc does not define __x86__ for historical reasons and
> __i386__ really means __x86__, but I haven't checked that one.
>

You are right. And next we have to get rid of __x86__ from ltp testcase.


-- 
Regards,
Li Wang

--00000000000067ad3305d0558d78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Nov 8, 2021 at 8:40 PM Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0asm volatile (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;add $0x400=
, %%esp\n\t&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;int $0x80\=
n\t&quot;<br>
&gt; @@ -114,15 +112,14 @@ static void run(void)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static struct tst_test test =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.test_all =3D run,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.supported_archs =3D (const char *const []) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;i386&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ppc&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.tags =3D (const struct tst_tag[]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;linux-git=
&quot;, &quot;cf01fb9985e8&quot;},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;CVE&quot;=
, &quot;CVE-2017-7616&quot;},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 };<br>
&gt; -<br>
&gt; -#else /* #if defined(__x86_64__) || defined(__powerpc__) */<br>
&gt; -<br>
&gt; -TST_TEST_TCONF(&quot;not i386 or powerpc&quot;);<br>
&gt; -<br>
&gt; -#endif /* #else #if defined(__x86_64__) || defined(__powerpc__) */<br=
>
<br>
Accordingly to this table:<br>
<br>
<a href=3D"https://wiki.debian.org/ArchitectureSpecificsMemo" rel=3D"norefe=
rrer" target=3D"_blank">https://wiki.debian.org/ArchitectureSpecificsMemo</=
a><br>
<br>
__powerpc__ matches both 32bit and 64bit variants.<br>
<br>
I guess that we would have to change the checks in the library as:<br></blo=
ckquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size=
:small">Yes, but I think we can simply reverse the order to solve this.</di=
v><div class=3D"gmail_default" style=3D"font-size:small">It will try to mat=
ch 64bit firstly otherwise 32bit. The s390 does as well.</div><div class=3D=
"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_def=
ault" style=3D"font-size:small">....</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">#elif defined(__powerpc64__ || __ppc64__)</div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;ppc64&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 .type =3D TST_PPC64,<br>#elif defined(__powerpc__ || __ppc__)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &quot;ppc&quot;,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 .type =3D TST_PPC,<br>#elif defined(__s390x__)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 .name =3D &quot;s390x&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .typ=
e =3D TST_S390X,<br>#elif defined(__s390__)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.name =3D &quot;s390&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D TST_S3=
90,<br><div class=3D"gmail_default" style=3D"font-size:small">....</div><br=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
#ifdef __powerpc__<br>
# ifdef __powerpc64__ || __ppc64__<br>
.arch =3D &quot;ppc64&quot;,<br>
.type =3D TST_PPC64,<br>
# else<br>
.arch =3D &quot;ppc&quot;,<br>
.type =3D &quot;TST_PPC&quot;<br>
# endif<br>
#endif<br>
<br>
Also I guess that gcc does not define __x86__ for historical reasons and<br=
>
__i386__ really means __x86__, but I haven&#39;t checked that one.<br></blo=
ckquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size=
:small">You are right. And next we have to get rid of __x86__ from ltp test=
case.</div><br></div><div><br></div></div>-- <br><div dir=3D"ltr" class=3D"=
gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></=
div></div></div></div>

--00000000000067ad3305d0558d78--


--===============1784842100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1784842100==--

