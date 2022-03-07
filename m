Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986E5C433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 01:10:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BEF13C1BC4
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 02:10:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C460E3C1B69
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 02:10:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3270A1000616
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 02:10:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646615417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6tZEv1Swxm63OrRt89Gsn6nnJBO5BWg4hBRi20oQJ8I=;
 b=BNxR6H2kfHgXpoWfitRXKLHByhrZhKZbPmHYMApBuG2otVs4cVn+afcjy7jl8bh6TQX+Gj
 Se2rxaZ1eltp/fQaGM//28LVyrfrif9U+mhy54fArTtt40PXzfn1FiSBp2wyEPOwrGtvQv
 5TGoONCQY2OP0qXVDrn4U1Wjuw/7SW8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470--w-LZwdyPyWC5-XggnriQQ-1; Sun, 06 Mar 2022 20:10:15 -0500
X-MC-Unique: -w-LZwdyPyWC5-XggnriQQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 b18-20020a25fa12000000b0062412a8200eso12264390ybe.22
 for <ltp@lists.linux.it>; Sun, 06 Mar 2022 17:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6tZEv1Swxm63OrRt89Gsn6nnJBO5BWg4hBRi20oQJ8I=;
 b=yPrIikeZZ/8+1JYYqBJuUEXfgYyuKKBV1XQkQF/jXPqU3mywNa49szdB69r7ppH1vh
 rajt1wQFO3DWpw0m9u/0p2GQUM9oSsGbD+qhngZ5DDwCVjZLedG/9wr0VkTgjOYJRcjT
 W5ljUYlqYtqFX03LTDrq1pU2WSnrNkGoQhL9UGGxzNTnjS4pB+Rn0Zy29RLT5knUDAQe
 +38n6KVh8RwHRLhNXP7+wFA6la9YDxvTFgoox8n7wZhqv3BiHvWmDze6jd1ebc7L+mGq
 TEsKAqx/qHS5uXtCixupFPkabFNc8GCbcduJPwKYjp02B2T0AXfAOLiF/rq6l4srbp4N
 7DHA==
X-Gm-Message-State: AOAM532gL7ykeCg8tK3Nb9agyNGT3vsj4+kiI44dVBMLFdJpZLSAyV22
 ybrk7306aBuGgoBYqv+f45KbWsR5dvd4aOCLM3kcF+IgMVANWTbN6Fbj7glTEGPTaxfyXog37V5
 hPUzxelDAHDF4zIoy+8Wj/6i7hsM=
X-Received: by 2002:a25:2f83:0:b0:629:2551:2309 with SMTP id
 v125-20020a252f83000000b0062925512309mr4564706ybv.211.1646615415173; 
 Sun, 06 Mar 2022 17:10:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAVTUkiKh3RlexFTkzYnHmb3ZdI1oHNH+ZdkV4hVI5FTSBAcXgkVqQmLTZbOlwzPGngMx9oNWiAR/ZUwTajQQ=
X-Received: by 2002:a25:2f83:0:b0:629:2551:2309 with SMTP id
 v125-20020a252f83000000b0062925512309mr4564691ybv.211.1646615414815; Sun, 06
 Mar 2022 17:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20220303083429.3827302-1-liwang@redhat.com>
 <YiI4XgwISfrk1BdP@yuki>
 <CAASaF6xyMDgn1_wCt0nbOhB2dZC901m260Ugdb0DaBOa9dV6OA@mail.gmail.com>
In-Reply-To: <CAASaF6xyMDgn1_wCt0nbOhB2dZC901m260Ugdb0DaBOa9dV6OA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 7 Mar 2022 09:09:51 +0800
Message-ID: <CAEemH2eJNJK0PEWN4SnYa1DHttOjKwbYx_P8uhYn999fZYZ6mg@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] migrate_pages02: check file exist before opening
 it
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
Cc: LTP List <ltp@lists.linux.it>, Bruno Goncalves <bgoncalv@redhat.com>
Content-Type: multipart/mixed; boundary="===============1909778718=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1909778718==
Content-Type: multipart/alternative; boundary="000000000000e1d2e505d9968627"

--000000000000e1d2e505d9968627
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 7, 2022 at 2:51 AM Jan Stancek <jstancek@redhat.com> wrote:

> > +               "?NUMA_BALANCING",
> You probably meant "?"NUMA_BALANCING
>

I guess both should be fine.
(tried locally with original patch and works well)


>
> >
> > Maybe we just need to enhance the .save_restore with another parameter;
> > a value to set the knob to if it does exists, so in add_key05.c it would
> > look like:
> >
> > struct tst_path_val {
> >         const char *path;
> >         const char *val;
> > };
> >
> >         .save_restore = (const struct tst_path_val const[]) {
> >                 {"?/proc/sys/kernel/keys/gc_delay", "1"},
> >                 {"?/proc/sys/kernel/keys/maxkeys", "200"},
> >                 {"?/proc/sys/kernel/keys/maxbytes", "20000"}
> >                 NULL,
> >         },
> >
> > And in cases we do not need to set value we would just pass NULL as
> val...
>

+1



>
> That should work for most testcases, I don't recall one where we need
> to cycle through more values.
>

Agree, even we have that requirement in the future, pass NULL at the
beginning
and reset it via FILE_PRINTF for more cycle values that should be working.
Thanks for the suggestions, I will get start work on V2.

-- 
Regards,
Li Wang

--000000000000e1d2e505d9968627
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Mar 7, 2022 at 2:51 AM Jan Stancek &lt;<a h=
ref=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; +=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;?NUMA_BALANCING&quot;,<br>
You probably meant &quot;?&quot;NUMA_BALANCING<br></blockquote><div><br></d=
iv><div><div class=3D"gmail_default" style=3D"font-size:small">I guess both=
 should be fine.</div></div><div class=3D"gmail_default" style=3D"font-size=
:small">(tried locally with original patch and works well)</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Maybe we just need to enhance the .save_restore with another parameter=
;<br>
&gt; a value to set the knob to if it does exists, so in add_key05.c it wou=
ld<br>
&gt; look like:<br>
&gt;<br>
&gt; struct tst_path_val {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *path;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *val;<br>
&gt; };<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.save_restore =3D (const struct tst_p=
ath_val const[]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/=
proc/sys/kernel/keys/gc_delay&quot;, &quot;1&quot;},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/=
proc/sys/kernel/keys/maxkeys&quot;, &quot;200&quot;},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/=
proc/sys/kernel/keys/maxbytes&quot;, &quot;20000&quot;}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt;<br>
&gt; And in cases we do not need to set value we would just pass NULL as va=
l...<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=
=3D"font-size:small">+1</div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
That should work for most testcases, I don&#39;t recall one where we need<b=
r>
to cycle through more values.<br></blockquote><div><br></div><div class=3D"=
gmail_default" style=3D"font-size:small">Agree, even we have that requireme=
nt in the future, pass NULL at the beginning</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">and reset it via FILE_PRINTF for more cycle v=
alues that should be working.</div></div><div class=3D"gmail_default" style=
=3D"font-size:small"></div><div><div class=3D"gmail_default" style=3D"font-=
size:small">Thanks for the suggestions, I will get start work on V2.</div><=
/div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div =
dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000e1d2e505d9968627--


--===============1909778718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1909778718==--

