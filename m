Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8E3C433EF
	for <ltp@archiver.kernel.org>; Thu, 31 Mar 2022 03:02:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 800673CA058
	for <ltp@archiver.kernel.org>; Thu, 31 Mar 2022 05:02:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D68323C31F2
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 05:02:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6D97F20007F
 for <ltp@lists.linux.it>; Thu, 31 Mar 2022 05:02:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648695732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wPMPMYF4w46V4/+VFr/MDZR2S+Kfdkflu9/C1QGiNAk=;
 b=Um2ntKcitj4GUr0wJPtuC8Dm89G1gvskEO8ufepEBn2RjCIUoCfCNp3qkSn516GvyUaEPd
 LBdEzDfKtEJw9DXr4pg8EEBrVGznddibW5o3aWxOhstoIRtZfO/gr90MC0aTAXqYhBS/Tw
 1ibUJn7JSqTMYVTQso0S/aeOpsPX8Zc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-QfbP7ONzPmGuSuiLOiBuEQ-1; Wed, 30 Mar 2022 23:02:08 -0400
X-MC-Unique: QfbP7ONzPmGuSuiLOiBuEQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 e8-20020a259248000000b0063391b39d14so16864663ybo.10
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 20:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wPMPMYF4w46V4/+VFr/MDZR2S+Kfdkflu9/C1QGiNAk=;
 b=OFd1s+rOJvosgoyxNczaRfG9xxQ+FEZGKuhzg1eQ8G79s2ou4eEJ0kHRdI6/xgLmaI
 xaQvvGMa/2DslI9rZNAeqi36hbrmGywj+nk6xdb3xj2NNbchydJmb1OuvDgidHrrUE3W
 Q/vWv/9t+jv1RUtNlAPrFLfvr2bu4HAquTH0+aFCzZLqRtGeZZoWOhNMtcPcaQdl/+km
 Ek7J2H4MhmMDsLEsUk/o4CsVBIkjZopcIr2/bztWL0twDsI2+diifF889cL+XWLt6nTG
 JyaN91QTKkYqkdgzozLPH+DntPynuCVrGqxeOpgVJXJlx5/FkImrYzCsYuxXKMo0PH3O
 fsUA==
X-Gm-Message-State: AOAM530OY+lO0QNZJBm2IfOllQqkXDp98D8m5pH25Xuw+y5OS74uwVuY
 XnWcJ0HuIgqzniRfP9JnfikVTTG9yTdyGdcTLyTPAbgc5UGWswAYDps6Qd09eKldxsNS0/L77N1
 muzmM6aMOYvTf4r/lsoZI3lloRH0=
X-Received: by 2002:a81:1211:0:b0:2e5:d8dd:b3d4 with SMTP id
 17-20020a811211000000b002e5d8ddb3d4mr3008449yws.208.1648695728334; 
 Wed, 30 Mar 2022 20:02:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO7oaeFAp0UwrSQIE4o7w9uI1w1a378zx/p4XHWTs8/emmJA40ilDaBBxdBRseQCZA/a3C/UquzsL5x3Zn7hA=
X-Received: by 2002:a81:1211:0:b0:2e5:d8dd:b3d4 with SMTP id
 17-20020a811211000000b002e5d8ddb3d4mr3008434yws.208.1648695728082; Wed, 30
 Mar 2022 20:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220329050351.688432-1-liwang@redhat.com>
 <d14a7c35-db49-4b7c-7951-9ad597b99831@redhat.com>
 <CAEemH2eAaSyZiXE4G792U72iQvmOwQcVe+RoMMqjF7Bc0uajGQ@mail.gmail.com>
 <4011ef1e-f457-3134-d933-b5d9f2646b20@redhat.com>
In-Reply-To: <4011ef1e-f457-3134-d933-b5d9f2646b20@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 31 Mar 2022 11:01:54 +0800
Message-ID: <CAEemH2c+K1tdXO++DCoSB_ODa43LnCP6Tzbhh_Yz1sK7+7uH1Q@mail.gmail.com>
To: Waiman Long <longman@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] clock_gettime04: set threshold based on the
 clock resolution
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Eirik Fuller <efuller@redhat.com>,
 Waiman Long <llong@redhat.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0191934367=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0191934367==
Content-Type: multipart/alternative; boundary="000000000000372b9b05db7ae35f"

--000000000000372b9b05db7ae35f
Content-Type: text/plain; charset="UTF-8"

> I see. So we really need more tolerance for vm. I am OK with your current
> patch then.
>
> Acked-by: Waiman Long <longman@redhat.com> <longman@redhat.com>
>
Patch applied, thanks for reviewing.

-- 
Regards,
Li Wang

--000000000000372b9b05db7ae35f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">=C2=A0<br></div></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div><p>I see. So we really need more=
 tolerance for vm. I am OK with your
      current patch then.</p>
    <p>Acked-by: Waiman Long <a href=3D"mailto:longman@redhat.com" target=
=3D"_blank">&lt;longman@redhat.com&gt;</a></p>
  </div>

</blockquote></div><div class=3D"gmail_default" style=3D"font-size:small">P=
atch applied, thanks for reviewing.</div><div><br></div>-- <br><div dir=3D"=
ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div=
>Li Wang<br></div></div></div></div>

--000000000000372b9b05db7ae35f--


--===============0191934367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0191934367==--

