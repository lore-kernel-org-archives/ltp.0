Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2888FC433EF
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 07:00:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08497610A2
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 07:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08497610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F0B23C7740
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 08:00:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC3C53C0BAD
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 08:00:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6C5CD14001FF
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 08:00:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636354836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kbowdwup/jtDO6yK7BUy1Zc14FaMxXlO+Uk4LT7Q1PQ=;
 b=DY2EwlWt4N9iN260WrhzaCqesqG9ZkB7LFkOkuMJRgaTKJG0ill12KlSBZEVkDqyEXjveu
 bRhUxqBxMQULFbuUndl8P/8MfFSfMiNScS/UdlFrl7uOB0C24bI8pbM0dGGrwTyuhLX4AO
 x1pnD9NONCS/kn9lEEJiXWS7GpoWsEY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-kxdgp6DvOjiCgP9gD9WyNg-1; Mon, 08 Nov 2021 02:00:32 -0500
X-MC-Unique: kxdgp6DvOjiCgP9gD9WyNg-1
Received: by mail-yb1-f198.google.com with SMTP id
 r67-20020a252b46000000b005bea12c4befso23716669ybr.19
 for <ltp@lists.linux.it>; Sun, 07 Nov 2021 23:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kbowdwup/jtDO6yK7BUy1Zc14FaMxXlO+Uk4LT7Q1PQ=;
 b=MXktq21WTbXnRKmpB6X3AN0BwHoDpSAIToP/cXoQ1bwrYVUjWc+99fn3fXyclId9D5
 oDmwHorXwuOCdsTlHUu0sWmp7DL+6NvmTB6jHkDRCkidz8riH73GoI0u7od8bgrDnuPg
 ogmr5ehuIFt+SPNepn2qvJcqb3IH5f+MwkmPU9JJKqM9nIWciCNPGMznSsW5BBGvENus
 yd5kVOuahVyFUGe5DZ+8xn6yuHw5QXw8Ywc3xVtlGFtUE8xRiixLOpzWJNaKpmraDmdq
 h2rQceqmsUqkmO/XMSamvNWXcpL8wIST3pjSxjlQS0jkM4wYHRluADpHSS3Le0utkTuf
 3vFg==
X-Gm-Message-State: AOAM53082JkV+p5BIYNCiAailC1dCsvhyI6jQh2NjVW8xSDHqBTzqjeX
 MgmwbglthQEHXunjm/1u0u1RQtKj5BMlWUmVYqpF7fl8MtxLNJeGmVlqS3//Loom0LiL4w+V/u7
 XU/3YE8/05Dcmwr/MIUPLAj/RIlo=
X-Received: by 2002:a25:86c4:: with SMTP id y4mr71249832ybm.144.1636354830038; 
 Sun, 07 Nov 2021 23:00:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxg1L/oBMJgNhS2RM2nKWE+VxKDCUgxyFHVhMRHnZcFkOLcPY8Z+c8xjAS7ghOii9YeJryTQb8Fq7nVFXVyEt8=
X-Received: by 2002:a25:86c4:: with SMTP id y4mr71249806ybm.144.1636354829774; 
 Sun, 07 Nov 2021 23:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20211108053225.23442-1-tangmeng@uniontech.com>
 <20211108053225.23442-2-tangmeng@uniontech.com>
In-Reply-To: <20211108053225.23442-2-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 8 Nov 2021 15:00:17 +0800
Message-ID: <CAEemH2fcwZKhZn+-oX75XsLXnBzD=4iidka+ZWrOH8m7=Wmf+w@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] fchdir/fchdir02: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============0787587897=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0787587897==
Content-Type: multipart/alternative; boundary="0000000000005b196a05d0418c75"

--0000000000005b196a05d0418c75
Content-Type: text/plain; charset="UTF-8"

> +static struct tst_test test = {
> +       .test_all = verify_fchdir,
> +       .needs_tmpdir = 1,
>

There is no need to use tmpdir since it is just a fake test for error
checking.

I removed that line and pushed. Thanks~

-- 
Regards,
Li Wang

--0000000000005b196a05d0418c75
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
+static struct tst_test test =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.test_all =3D verify_fchdir,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_tmpdir =3D 1,<br></blockquote><div><br><=
/div><div><div class=3D"gmail_default" style=3D"font-size:small">There is n=
o need to use tmpdir since it is just a fake test for error checking.</div>=
<br></div><div><div class=3D"gmail_default" style=3D"font-size:small">I rem=
oved that line and pushed. Thanks~</div></div></div><div><br></div>-- <br><=
div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br=
></div><div>Li Wang<br></div></div></div></div>

--0000000000005b196a05d0418c75--


--===============0787587897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0787587897==--

