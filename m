Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22802C433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 03:35:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 964123CA75B
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 05:35:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E91313C0797
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 05:35:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F1840100042E
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 05:35:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650857738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nj9cikNM3CPba5yizpTNewjDxsJsjNepy2jQa68gq7Q=;
 b=bJehmYhVedCSANjMCpnoAEzMXQEFkl/F0F2359F8hygZrzPoFhU15EA7UUgvcRBzkEyIhg
 7p09H91SkpppLP70EpZrU+nhsOvw+zn8jBDhXkDXDZ6O1OHuua7T2Y0ZeG6m+OBjoY9eG1
 DR9S5ziFc3Sgan0Q8xjnuX5GUzAVXFk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-3-KJpeudPj2sTekAoI0Juw-1; Sun, 24 Apr 2022 23:35:34 -0400
X-MC-Unique: 3-KJpeudPj2sTekAoI0Juw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2f4d9e92a0aso86691907b3.9
 for <ltp@lists.linux.it>; Sun, 24 Apr 2022 20:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nj9cikNM3CPba5yizpTNewjDxsJsjNepy2jQa68gq7Q=;
 b=abXi40ObDePdi1gjFc4THQoSPxbQ4hMULf3csQlRmMB6LSzb6bt0XkMMot/mhEgaa6
 aHgAl3BhpNIXvVehU3unHoSZqTR9AzArfSIJIekcQlVHo3zzUvCNb+mcqV8hyIYx9UMf
 WUYlpqLMBW6ThDAF+rcj7QtRr31txL6B+OtwO8a9gdeaPOGQRz4LVSqFLwo5mPc3MVc1
 kgbz1l1Oq/H/eMuq4LPr7xTF3dlfEtFCobLF0X9XkqRHasa3VCflqDM/gF/krsD6fMSc
 xreM6kncZZS7qBlaXANcutS/pFBO0aWYqH1Opmvla295ziOSBVsLD0AWgej6Z9NhS7r0
 uLgw==
X-Gm-Message-State: AOAM532sO2dYwKVYW4bIdq+8yoNOajUE9lRhiT+pI2kn9mS1W3sRlgrB
 VqJtUmJli+2SBa0RXI/pHwVkNyQUQAOQ/yfukTNNW1Ew8fnlK7IBc1fcatX+TW85u3xmEvbxrFE
 n3UrYBM/dQHPuiS8H8uQM9bdy6cM=
X-Received: by 2002:a81:5b56:0:b0:2ec:34e7:9b5c with SMTP id
 p83-20020a815b56000000b002ec34e79b5cmr15307393ywb.300.1650857734261; 
 Sun, 24 Apr 2022 20:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxT49LWbiXWmbPndTXiwGzvCh2tmDuRPbuaxHbaavtDKkCmIP5o/qjs98UzawTLdBYZv1fRgRDB29dk2e85dc=
X-Received: by 2002:a81:5b56:0:b0:2ec:34e7:9b5c with SMTP id
 p83-20020a815b56000000b002ec34e79b5cmr15307384ywb.300.1650857734017; Sun, 24
 Apr 2022 20:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220422144141.16848-1-pvorel@suse.cz>
In-Reply-To: <20220422144141.16848-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 25 Apr 2022 11:35:19 +0800
Message-ID: <CAEemH2fXi4S+cMot4jLWfr_atQhhZehD3rEYKbV1xkLcuHnz6w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/4] shell: Cleanup getopts usage
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
Cc: Martin Doucha <martin.doucha@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1509428054=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1509428054==
Content-Type: multipart/alternative; boundary="000000000000cfb2e205dd724420"

--000000000000cfb2e205dd724420
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Fri, Apr 22, 2022 at 10:41 PM Petr Vorel <pvorel@suse.cz> wrote:


>
> Petr Vorel (4):
>   shell: Use conditional expansion for library setup/cleanup
>   doc: Update library API doc
>   tst_test.sh: Cleanup getopts usage
>   doc: Update shell API examples
>

Basically looks good. Thanks for your update!

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000cfb2e205dd724420
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Apr 22, 2022 at 10:41 PM Petr Vorel &=
lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&g=
t; wrote:<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Petr Vorel (4):<br>
=C2=A0 shell: Use conditional expansion for library setup/cleanup<br>
=C2=A0 doc: Update library API doc<br>
=C2=A0 tst_test.sh: Cleanup getopts usage<br>
=C2=A0 doc: Update shell API examples<br></blockquote><div><br></div><div><=
div class=3D"gmail_default" style=3D"font-size:small">Basically looks good.=
 Thanks for your update!</div><div class=3D"gmail_default" style=3D"font-si=
ze:small"></div><br></div><div><div class=3D"gmail_default" style=3D"font-s=
ize:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">li=
wang@redhat.com</a>&gt;</div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><br></div></div></div><div><br></div>-- <br><div dir=3D"ltr"><div =
dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000cfb2e205dd724420--


--===============1509428054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1509428054==--

