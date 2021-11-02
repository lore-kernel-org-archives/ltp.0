Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EC6C433FE
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 10:04:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB3B6023F
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 10:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DB3B6023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B24A3C710C
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:04:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5288E3C6E84
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 11:04:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ACD121401458
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 11:04:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635847463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9l/wSSKuocG7LAVlBky2UP8SvUfLimgXkdtQH2COXyA=;
 b=KK6v+u7P3MzH8OXKkxMsjPOdIoCwffjGnArVFFJoI2u6OkGvJsbQQtKIkB34JX01CpIvaO
 S0QWvLuU11q2enIWIuN/3wSTPkRSqgREsLtlJv8joPs5IbOw0jc9tZTVTBCMPMz71q2+At
 E6uDU7AVsjOwXthSQ/Qsko7E9NvCuyQ=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-GImz4pn-PtGXdVl_DlqrPQ-1; Tue, 02 Nov 2021 06:04:20 -0400
X-MC-Unique: GImz4pn-PtGXdVl_DlqrPQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 v133-20020a25c58b000000b005c20153475dso19260324ybe.17
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 03:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9l/wSSKuocG7LAVlBky2UP8SvUfLimgXkdtQH2COXyA=;
 b=pVRpsAFHZ0/fSc79dBL4+QjbfYO7T4LkMJdtkq+NmKlOw4Clyr1o7IQGdzgc1Lc1Em
 YTg/KZtPcHDWlHWiJyokthVDzIeyCXM2kgcm/4DXQ9UD18pVWqo/Bo2ZSd9q2QpTjKEg
 P8dsFZ2tWOltweUWzSi6G/nLwI4D25iSITGm1604RS7YsTr0sIN0J83vIfp/VFA/zWaB
 wQuS2Rt+DmiODnsqn25k7BbFD9EIorBcw23r3JDeYkjQZKVhraxHrKaUxX0499ab2XjR
 NPxfaK1QVtkJIz8vboPNQVFMCDO35SMrnkq1I/ZAglEbGMD6TwS+HCRyRtA+ipG6Ua8Y
 XwIw==
X-Gm-Message-State: AOAM532u1zitzW4phUqXdQOdlF+JNk03mibn74dvgp59gztN0f27+kyS
 gpjd1DH7btKiI6HK8/jEVJs1CSuiW781/g8p77iUudgBPmkG7ATG3MqgmNylV+JgzgFezgSFSZT
 TQFlXSa7eIjU2K4Is7jELUaeSvqM=
X-Received: by 2002:a05:6902:690:: with SMTP id
 i16mr19560353ybt.302.1635847460167; 
 Tue, 02 Nov 2021 03:04:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwg09kzqNtpzQ8+4eKbmwGquV54K0kkYrnsV216sQLUWpeH69j7IGJXzQEZelZk2esGcBBZZlqVgnsLhnsNR1Y=
X-Received: by 2002:a05:6902:690:: with SMTP id
 i16mr19560338ybt.302.1635847459941; 
 Tue, 02 Nov 2021 03:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211029080527.28014-1-tangmeng@uniontech.com>
 <20211029080527.28014-4-tangmeng@uniontech.com>
In-Reply-To: <20211029080527.28014-4-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Nov 2021 18:04:08 +0800
Message-ID: <CAEemH2fhEZ6mmXoSsC_-KEcWTidWokS2FitFKuS3jgbSwSY+ug@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] link/link07: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============0108336574=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0108336574==
Content-Type: multipart/alternative; boundary="000000000000c1c3c005cfcb6a48"

--000000000000c1c3c005cfcb6a48
Content-Type: text/plain; charset="UTF-8"

And combine this test into link04.c as well.

There wouldn't be very difficult to setup configuration for the specific
tcase before testing.

See how madvise02 achieve that for various situation:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise02.c

-- 
Regards,
Li Wang

--000000000000c1c3c005cfcb6a48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">And combine this test into link04.c as well.</div><div class=3D"gmail_d=
efault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" st=
yle=3D"font-size:small">There wouldn&#39;t be very difficult=C2=A0to setup =
configuration for the specific tcase before testing.</div><div class=3D"gma=
il_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default=
" style=3D"font-size:small">See how madvise02 achieve that for various situ=
ation:</div><div class=3D"gmail_default" style=3D"font-size:small"><a href=
=3D"https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/=
syscalls/madvise/madvise02.c">https://github.com/linux-test-project/ltp/blo=
b/master/testcases/kernel/syscalls/madvise/madvise02.c</a><br></div></div><=
div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D=
"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000c1c3c005cfcb6a48--


--===============0108336574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0108336574==--

