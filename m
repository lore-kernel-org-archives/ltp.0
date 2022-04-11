Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D477C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 09:36:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A56D3CA51F
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 11:36:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E6443C0653
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:36:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 870E36006C1
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649669759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8t5uwGSI+n4ctLjdptNK0tPnS40CskaM7LgdWuvkoUg=;
 b=fYJFCTPjw2xCjaaM21I47papkLzaFnYobOwXCv0MFX662eDtE/098Fhq8Uu0XyQVLwP1UY
 WFZYmMz+6J4C6czHLpNM1EmAWs2bIhfgh8gY6KogCJ3zSHnL0loMsEpzilSjHty3evhrfd
 o35b2hqGsYle9yXYpsPQF7aOxyZXMuI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-vRFLEGMJOj-wyw2VtAfHwQ-1; Mon, 11 Apr 2022 05:35:58 -0400
X-MC-Unique: vRFLEGMJOj-wyw2VtAfHwQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2ebef8022c7so55785977b3.11
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 02:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8t5uwGSI+n4ctLjdptNK0tPnS40CskaM7LgdWuvkoUg=;
 b=e8+CQ8HCBU1RMJvDeO+U/acISu7zkeZciqXKK+/IebtDp8bbGGaGukG9bY0FPTp5O5
 PxyJGLoHEAkymuEE6AwOBbSJ+WMcWzF3ulYIXRkOVxEP548wrWXPWEzeatKLdEoHJzbR
 Llvj6qX8QJnDWNWUR7RrZ+p7MxGPcKOmPmTMjdcSwLFZugh6CseUrGQl+pNdU5/M/9TQ
 l28BPeEyhzzO/DJV7b4iQgj+WoFmqccug0AiYGh9qURJUe7Eh/201cWUdo5iNFyhhCgU
 X+5GtYkLIA5zOHzjb1PK2+VP2o4BefnnN2hrZ9JDt8guUiziaV1fFxsnkoiyuSdyh02d
 7JLA==
X-Gm-Message-State: AOAM533bH5QOSlZvruY8B6Kj3Z8VALq2xu9WDv+K6IKrN1YbpnmJYDEW
 pWJ1AzFctQFhhdG0X872iUxRux2GPDjz8JORefnWxrVVUH8exhUfM7u20NBztlG247Efp9tWUVL
 9ZP6NP3bv6FQqVER17N71CY74FOI=
X-Received: by 2002:a81:7b56:0:b0:2ec:2d65:7ccf with SMTP id
 w83-20020a817b56000000b002ec2d657ccfmr2673868ywc.208.1649669757865; 
 Mon, 11 Apr 2022 02:35:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKAoPujNdFxCsKwmbbBuDBqaft1X5kBYGBQssx2QDUJkAuip6b67KjOreIR0p9USbzVGkpBC31G27awc3jR0w=
X-Received: by 2002:a81:7b56:0:b0:2ec:2d65:7ccf with SMTP id
 w83-20020a817b56000000b002ec2d657ccfmr2673857ywc.208.1649669757589; Mon, 11
 Apr 2022 02:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220405170607.3596657-1-edliaw@google.com>
 <CAEemH2dZiWZjHWMzrRuuiar5YQHF741TMu4p=uMtWgTPG4Oh+w@mail.gmail.com>
 <87sfqkggtq.fsf@suse.de>
 <CAEemH2eh=AX6-DMW1UaVs+MGtqFXq8HoJD41D3paB93vQZ9ZUw@mail.gmail.com>
 <87k0bwgebk.fsf@suse.de>
In-Reply-To: <87k0bwgebk.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Mon, 11 Apr 2022 17:35:43 +0800
Message-ID: <CAEemH2fkjkyYagLkThYRRwgwJk+oMg7fs5=Af6rimLf_kesJPw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>, Edward Liaw <edliaw@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fzsync: break inf loop with flag vs
 pthread_cancel
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
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0288193982=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0288193982==
Content-Type: multipart/alternative; boundary="000000000000e5f33205dc5dab4a"

--000000000000e5f33205dc5dab4a
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 11, 2022 at 5:27 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:


> > Exactly, maybe do something to make tst_fzsync_pair_cleanup
> > avoid joining to itself when the invoke come from B?
>
> I suppose we could save thread A or B's TID and then check it. I think
> that should be in a seperate patch.
>

Agreed, feel free to send a patch, Richard.

>  > +                       tst_atomic_store(1, &pair->exit);
> >  > +                       usleep(100000);
> >
> >  Why do we need usleep?
> >
> > Seems not very needed.
>
> +1
>

@Edward,  It'd be appreciated if you can send a patch V2 base on
the comments above. Or, do you have different thoughts?

-- 
Regards,
Li Wang

--000000000000e5f33205dc5dab4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Apr 11, 2022 at 5:27 PM Richard Palethorpe =
&lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@suse.de</a>&gt; wrot=
e:</div><div dir=3D"ltr" class=3D"gmail_attr"><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><br>
&gt; Exactly, maybe do something to make tst_fzsync_pair_cleanup<br>
&gt; avoid joining to itself when the invoke come from B?<br>
<br>
I suppose we could save thread A or B&#39;s TID and then check it. I think<=
br>
that should be in a seperate patch.<br></blockquote><div><br></div><div><di=
v class=3D"gmail_default" style=3D"font-size:small">Agreed, feel free to se=
nd a patch, Richard.</div></div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_atomic_store(1, &amp;pair-&gt;exit);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0usleep(100000);<br>
&gt;<br>
&gt;=C2=A0 Why do we need usleep?<br>
&gt;<br>
&gt; Seems not very needed. <br>
<br>
+1<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-size:small">@Edward,=C2=A0 It&#39;d be appreciated if you can send a patc=
h V2 base on</div><div class=3D"gmail_default" style=3D"font-size:small">th=
e comments above. Or, do you have different thoughts?</div></div><div><br><=
/div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><di=
v>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000e5f33205dc5dab4a--


--===============0288193982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0288193982==--

