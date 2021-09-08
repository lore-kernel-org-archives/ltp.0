Return-Path: <SRS0=D2qq=N6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B48C433EF
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 01:22:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BAE16113E
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 01:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BAE16113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1B5C3C952F
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 03:22:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 504403C2327
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 03:22:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 37ECE6234A1
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 03:22:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631064135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1dPQjJkntRK7Sua06qHEP926Na9mmXDtF0zUTxCLK78=;
 b=IVeh9MeHaNcvbsog7abrLu56kg3q6JEpBAsNJvdMVsrgpM7h0HBcYEcDl4LDZyHIICIVTZ
 qQOPG4LM2dSq0jERyR9nZWvmeoF3Q3MoXCKSVum0uMiGu+16VsYhgaUPvM9kCqIwzlaLbx
 N74kmFslNC2SsVV9fy9uRdijNfhSR8k=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-pcJ4UcKHNai8dyfN_i1s6w-1; Tue, 07 Sep 2021 21:22:14 -0400
X-MC-Unique: pcJ4UcKHNai8dyfN_i1s6w-1
Received: by mail-yb1-f198.google.com with SMTP id
 f64-20020a2538430000b0290593bfc4b046so528016yba.9
 for <ltp@lists.linux.it>; Tue, 07 Sep 2021 18:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1dPQjJkntRK7Sua06qHEP926Na9mmXDtF0zUTxCLK78=;
 b=KiFiqC1aA0GH6nvgl5dZun67e2ay9KJ80la21iwH114T/MWXPk+aznb2kjf0z/pXkT
 6T0xTlVkHVAsv8WAw+Iyykr9OTbUUGPw5QFyTbZL67KXiTAmHlBFxnJPN1QhStZOwROz
 azUSdotVkkmeMMJ8RqcUvh/J7loJFjJDqSDK5qU1hgGTAuBCw6/zMnGCJYNEp+tSQIXA
 x71bAj5fuTCU6vYJTHdxLWU63I+eGk2gv1J/R2wY3JUFU4mkX9piMid27W1ykDvykEPk
 AYb01pFEGKqKxvMhgkJC/SVuSv11Hgx/hELRq+AtInhliYY4VCrxtv3zpoYwGcOFfvb8
 hdTQ==
X-Gm-Message-State: AOAM5320n+Mxe1zKq/E7ew2IS8ahw/GMrn3h5qFAsamTG+dzl32IiA4z
 8/YBkah66Nd4d0Cn7bxP2Yjtp4Tt2wvx1Rc4pdy0t6nKR5qL/N6JdBRj+ha5zszaQ3q5/iwX+Hq
 t8zTub4rFMyf72v+NJbCxlW3N8B4=
X-Received: by 2002:a25:6902:: with SMTP id e2mr1803655ybc.526.1631064133632; 
 Tue, 07 Sep 2021 18:22:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyakIHpsEM8cImc/DepmGlL0lTsF/SbhDepor+3to38zKVk2+sOn5Mz9eao6bN1AJfixYTKFAjXcJ+mEx0qoYw=
X-Received: by 2002:a25:6902:: with SMTP id e2mr1803637ybc.526.1631064133389; 
 Tue, 07 Sep 2021 18:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210817104625.2559362-1-liwang@redhat.com>
 <CAEemH2fOWt1SjoTyqcWFkSyGf_S28FsPreLrKcUvOHu0pRz9OQ@mail.gmail.com>
 <CAASaF6wWvezTpRcvewaaUF_-duEuQA1Oh2vEd9W-xC+AhGX12A@mail.gmail.com>
In-Reply-To: <CAASaF6wWvezTpRcvewaaUF_-duEuQA1Oh2vEd9W-xC+AhGX12A@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Sep 2021 09:21:59 +0800
Message-ID: <CAEemH2eNd86tGcmLXBu9ScJHymFcdxNiTN53eC9NciQ9Qu+9fw@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Type: multipart/mixed; boundary="===============0935280137=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210908012159.oas4jJ0RFuOKd_vUxXiT5A3xt1t5G1XUR1WTWViRoMw@z>

--===============0935280137==
Content-Type: multipart/alternative; boundary="00000000000046ebb705cb71b6c1"

--00000000000046ebb705cb71b6c1
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 7, 2021 at 4:00 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> On Tue, Sep 7, 2021 at 4:40 AM Li Wang <liwang@redhat.com> wrote:
>
>> Ping~
>>
>> This patch is only to increase the test blocks to make it robust,
>> it's no harmful and actually changes nothing from code logic.
>>
>
> Acked-by: Jan Stancek <jstancek@redhat.com>
>

Thanks for ACK, pushed.

-- 
Regards,
Li Wang

--00000000000046ebb705cb71b6c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Sep 7, 2021 at 4:00 PM Jan Stancek &lt;<a h=
ref=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div=
 dir=3D"ltr"><div style=3D"font-family:monospace"><br></div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 7, =
2021 at 4:40 AM Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"=
_blank">liwang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"fo=
nt-size:small">Ping~</div><div style=3D"font-size:small"><br></div><div sty=
le=3D"font-size:small">This patch is only to increase the test blocks to ma=
ke it robust,</div><div style=3D"font-size:small">it&#39;s no harmful and a=
ctually changes nothing from code logic.</div></div></div></blockquote><div=
><br></div><div><div>Acked-by: Jan Stancek &lt;<a href=3D"mailto:jstancek@r=
edhat.com" target=3D"_blank">jstancek@redhat.com</a>&gt;</div></div></div><=
/div></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font=
-size:small">Thanks for ACK, pushed.</div></div><div><br></div>-- <br><div =
dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></d=
iv><div>Li Wang<br></div></div></div></div>

--00000000000046ebb705cb71b6c1--


--===============0935280137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0935280137==--

