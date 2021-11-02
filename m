Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FFCC433EF
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 09:59:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D614560E73
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 09:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D614560E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5FE23C60A6
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 10:59:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A36FF3C60A6
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 10:59:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A176D60006F
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 10:59:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635847166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QYnCzffObaMDc/+Cd313bp4IWV0M3NZqseA+UcfcaBA=;
 b=fevTfnHvFlPmTWQQl/Si4ttUPNMlCv0Qm1pfBvvH1C4MxaRcbfZx0qq8eIbhY0GC7gfAcU
 jm8RaNZNv3NLq7jKebbv+AYstgw2T/WPGTLMd4Z91ba8CEPuqdZuTezZ2m912+ahn+1/DI
 jsmgFCiiu7UuIIzUOC2m6/YmSxkdMEI=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-SPLyoQS4MtKTnRnSkZDBjA-1; Tue, 02 Nov 2021 05:59:24 -0400
X-MC-Unique: SPLyoQS4MtKTnRnSkZDBjA-1
Received: by mail-yb1-f198.google.com with SMTP id
 w132-20020a25c78a000000b005c27f083240so2388885ybe.16
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 02:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QYnCzffObaMDc/+Cd313bp4IWV0M3NZqseA+UcfcaBA=;
 b=SMXNbYX6Q281GoQ//MR9Ds6qrCt+Zy+XWIzHg3Nzyd/mtTmwFcfkcxnp94E36x/BT+
 Oq9F0KjN1vGcUkhl/pHaVnkJXb8dl6LE7C43AAl8PBUXQrmaJBEXWqWyrPg82VnMRyHj
 hdtzSwQkOhvdBuTW4obyo8i0DzYbkn7jN/49TfH/HKWhTZ9jFBCYXlwvkLn10Vb0/Uec
 bhnPRdDGwJibDvuSDA4Wgac52kiTCvFefrdpNC+5KwXvQk/h/+RG1wDfJGgg014MBWhB
 ME/YsOXbOpatWOIkp1x9RGQxa4mbl53+krjZI1Bio2VV8pb5nyjeig5OkGwmRdyiTrLV
 8PCg==
X-Gm-Message-State: AOAM530T2JwH/ehxzhD13isAuGQBBzxF0+fQOmXUKuZm00k06+0zBG2+
 7zwPcU6Q3KWWc3hYigZnWIYvG8S/QsEz7+GEnRLOtiIHJj4H+T0/gOy0WQoOJqqjW3kfyJ9gcCh
 ON5GxaotKRyAmUeriiNEiySogRYY=
X-Received: by 2002:a5b:445:: with SMTP id s5mr22077441ybp.425.1635847164161; 
 Tue, 02 Nov 2021 02:59:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+DSI0sR2RRymflG3k/zSNaJrAeJ13XOxjiCHxkJUnR+Uz2dUgNCOvatN3tVZHeDfUiqGUjcgjJD9pKAXgXH8=
X-Received: by 2002:a5b:445:: with SMTP id s5mr22077418ybp.425.1635847163970; 
 Tue, 02 Nov 2021 02:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211029080527.28014-1-tangmeng@uniontech.com>
 <20211029080527.28014-3-tangmeng@uniontech.com>
In-Reply-To: <20211029080527.28014-3-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Nov 2021 17:59:12 +0800
Message-ID: <CAEemH2f+DbJB6CeXCLK_TmXdLctz2zF-LSdtF+byk4fiHa8WVQ@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] link/link06: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============0137169637=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0137169637==
Content-Type: multipart/alternative; boundary="0000000000001d9f8805cfcb5964"

--0000000000001d9f8805cfcb5964
Content-Type: text/plain; charset="UTF-8"

> +       TST_EXP_FAIL(link(OLDPATH, NEWPATH), EACCES);
>

As this is also test failure for link() syscal, can we
combine this test content into link04.c?
-- 
Regards,
Li Wang

--0000000000001d9f8805cfcb5964
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_FAIL(link(OLDPATH, NEWPATH), EACCES);<b=
r></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"fo=
nt-size:small">As this is also test failure for link() syscal, can we</div>=
<div class=3D"gmail_default" style=3D"font-size:small">combine this test co=
ntent into link04.c?</div></div></div><div class=3D"gmail_default" style=3D=
"font-size:small"></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regar=
ds,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000001d9f8805cfcb5964--


--===============0137169637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0137169637==--

