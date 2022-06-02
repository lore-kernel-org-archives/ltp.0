Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3678AC43334
	for <ltp@archiver.kernel.org>; Thu,  2 Jun 2022 04:24:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C31F3C7FBE
	for <ltp@archiver.kernel.org>; Thu,  2 Jun 2022 06:24:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 329083C3302
 for <ltp@lists.linux.it>; Thu,  2 Jun 2022 06:24:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A1F3B200900
 for <ltp@lists.linux.it>; Thu,  2 Jun 2022 06:24:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654143880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A0EZ/JSV55hK40pseA+LV+ovayAKMO6gheLyBkaRzDo=;
 b=Ll0oxeXM2Cbc8hTkPBJwJtWhSAcJm5f++lvXQ76DAbWkNJHFhz4Whoae35CkyAprzC4vMM
 AAfpvm1av138UmOE5nEe/REXyC7HioSl/sIUmJvanXGhgTeWa4EKfHaCSgSa1CeqD6d52t
 Bw40U4UYxmgeig42qq62cQ2thMvlYY8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516--CKQGu9PNNmPMBLT9LyaEg-1; Thu, 02 Jun 2022 00:24:38 -0400
X-MC-Unique: -CKQGu9PNNmPMBLT9LyaEg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-2eb7d137101so33183477b3.12
 for <ltp@lists.linux.it>; Wed, 01 Jun 2022 21:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A0EZ/JSV55hK40pseA+LV+ovayAKMO6gheLyBkaRzDo=;
 b=7KbVEm9Hsl5lurquiN09jumWvFFEAdxRsuQLEl7cFo7yogZFxxfb3vQj4sL76kWknE
 tz/Wl53UULXqeSqm/hrm70Yw5dpN5cAI8F9pvNZ1n6HVAWkHrwtMxd+mwfD8gIWr0ibT
 vXZiLc7FzGU9SaT/7Knj4ezvNQw77NaeWIyaZ8Ri2qwnylxFhkRLJwOudXJuKMDFDAjy
 UrZG6JDNM+hL4LjuYDvD5spQZOz6n+J0BALn/XNQVBCocCg/O0Vgo/vQz38V1bUhKgTJ
 jcLHp+Gk4W69+U4M6N2Rwvac+CEC6XLrLdq5NEiVEVUqWi6jyhQqak5pQoLDUOlAe57P
 5Hqg==
X-Gm-Message-State: AOAM531PQMkc1qq7YNuElQ+3+YPjJMMeW5r24CVixmYoAHGQRgd+b1Pm
 D6bdJrsJJMzG5PERW2wndA6dDbP8QjMhkBuANNBH5QKxZ2MqoL5SsNa3m4Bro33eitVXA2R89Kj
 mjCHgNLQgibbIwpWbkVAGcba1Izo=
X-Received: by 2002:a0d:cc49:0:b0:30c:32ad:ab1b with SMTP id
 o70-20020a0dcc49000000b0030c32adab1bmr3484760ywd.424.1654143877694; 
 Wed, 01 Jun 2022 21:24:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc7XNj/HHj9kdCR8++P0ZCctFaleIehgl42PVzZQo87wg/X8MsjTnDq94HP4c12I6ym297QWeaA1dwnWkFpmM=
X-Received: by 2002:a0d:cc49:0:b0:30c:32ad:ab1b with SMTP id
 o70-20020a0dcc49000000b0030c32adab1bmr3484752ywd.424.1654143877513; Wed, 01
 Jun 2022 21:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220428132949.11719-1-liwang@redhat.com> <YpdWsp9a4ZcpkCAD@yuki>
In-Reply-To: <YpdWsp9a4ZcpkCAD@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 2 Jun 2022 12:24:26 +0800
Message-ID: <CAEemH2fV4La3OY0RbGKRsJpvfqgCEbr4PT9m1_D7pwrXsuB-Gw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/3] lib: extend .request_hugepages to
 guarantee enough pages
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
Content-Type: multipart/mixed; boundary="===============1369157409=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1369157409==
Content-Type: multipart/alternative; boundary="0000000000003a15d305e06f627c"

--0000000000003a15d305e06f627c
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:


> +TST_FLEXIBLE:
> > +  If set non-zero number in .request_hugepages, ltp will try to reserve
> the
> > +  expected number of hugepage for testing in setup phase. If system
> does not
> > +  have enough memory for that, it will try the best to reserve 80%
> available
> > +  huge pages.
> > +
> > +TST_ENFORCED:
> > +  This is an enforced requirement for huge page reserve, ltp should
> strictly do
> > +  hpages applying and guarantee the 'HugePages_Free' no less than
> specified pages
> > +  which gives that test can use these specified numbers correctly.
>
> As for the naming I would probably go for TST_NEEDS and TST_REQUEST. We
> use the word 'needs' in the tst_test to describe something that is
> required for the test. And 'request' sounds better to me than flexible
> in a sense that you can request a lot but get less than what was
> requested.
>

Sounds better, if so, I'd also rename '.request_hugepages' to '.hugepages'
in tst_test because there have been overlaps in the tst_policy words.

 struct tst_test test = {
        .test_all = run,
-       .request_hugepages = 2,
+       .hugepages = {2, TST_REQUEST},
        ...
 };
No hugepage change to:

    .hugepages = {TST_NO_HUGEPAGES, TST_REQUEST},

API in header file change to:

-unsigned long tst_request_hugepages(unsigned long hpages);
+unsigned long tst_reserve_hugepages(struct tst_hugepage *hp);

> -     unsigned long request_hugepages;
> > +     struct tst_hugepage *request_hugepages;
>
> Why is this treated as an array even though we work with only single
> struct tst_hugepage instance?
>

Right, it no needs an array in that case.


-- 
Regards,
Li Wang

--0000000000003a15d305e06f627c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@s=
use.cz</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div><br></=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +TST_FLEXIBLE:<br>
&gt; +=C2=A0 If set non-zero number in .request_hugepages, ltp will try to =
reserve the<br>
&gt; +=C2=A0 expected number of hugepage for testing in setup phase. If sys=
tem does not<br>
&gt; +=C2=A0 have enough memory for that, it will try the best to reserve 8=
0% available<br>
&gt; +=C2=A0 huge pages.<br>
&gt; +<br>
&gt; +TST_ENFORCED:<br>
&gt; +=C2=A0 This is an enforced requirement for huge page reserve, ltp sho=
uld strictly do<br>
&gt; +=C2=A0 hpages applying and guarantee the &#39;HugePages_Free&#39; no =
less than specified pages<br>
&gt; +=C2=A0 which gives that test can use these specified numbers correctl=
y.<br>
<br>
As for the naming I would probably go for TST_NEEDS and TST_REQUEST. We<br>
use the word &#39;needs&#39; in the tst_test to describe something that is<=
br>
required for the test. And &#39;request&#39; sounds better to me than flexi=
ble<br>
in a sense that you can request a lot but get less than what was<br>
requested.<br></blockquote><div><br></div><div class=3D"gmail_default" styl=
e=3D"font-size:small">Sounds better, if so, I&#39;d also rename &#39;.reque=
st_hugepages&#39; to &#39;.hugepages&#39;</div><div><div class=3D"gmail_def=
ault">in tst_test because there have=C2=A0been overlaps in the tst_policy w=
ords.</div></div><div><div class=3D"gmail_default"><br></div>=C2=A0struct t=
st_test test =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_all =3D run,<br>- =
=C2=A0 =C2=A0 =C2=A0 .request_hugepages =3D 2,<br>+ =C2=A0 =C2=A0 =C2=A0 .h=
ugepages =3D {2, TST_REQUEST},<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>=C2=A0=
};<br><div class=3D"gmail_default"></div><div class=3D"gmail_default">No hu=
gepage change to:</div><div class=3D"gmail_default"><br></div><div class=3D=
"gmail_default">=C2=A0 =C2=A0 .hugepages =3D {TST_NO_HUGEPAGES, TST_REQUEST=
},<br></div><div class=3D"gmail_default"><br></div><div class=3D"gmail_defa=
ult">API in header file change to:</div><div class=3D"gmail_default"><br></=
div><div class=3D"gmail_default">-unsigned long tst_request_hugepages(unsig=
ned long hpages);<br></div></div><div class=3D"gmail_default" style=3D"font=
-size:small">+unsigned long tst_reserve_hugepages(struct tst_hugepage *hp);=
</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div=
 class=3D"gmail_default" style=3D"font-size:small"></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned long request_hugepages;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct tst_hugepage *request_hugepages;<br>
<br>
Why is this treated as an array even though we work with only single<br>
struct tst_hugepage instance?<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Right, it no needs an array i=
n that case.</div></div><div><br></div></div><div><br></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div>=
<div>Li Wang<br></div></div></div></div>

--0000000000003a15d305e06f627c--


--===============1369157409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1369157409==--

