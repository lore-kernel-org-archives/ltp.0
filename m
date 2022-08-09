Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F2CC19F2D
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 09:25:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E83123C948B
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 11:25:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 946FB3C076A
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 11:25:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BEAED600745
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 11:25:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660037130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VxYfr5eY6BZvku5zorxTAOoVxncoEjEknWcVbLP0DCQ=;
 b=DcCnAJDld5z/p3v6IHxi/E8WyKsn10fsQ42FK8e2rsafQ6iNVGXZMNB8KmMvt7Y/iKzTk5
 uRTj6n3XD/KctKQq1lBgNILI9FSsaIhvBI6Iliqf8KSC0DYTsbAYfvYnGLZbOxfeaCTSYM
 ogolaETUe14EZEqfMcrd5895ohzrI8M=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-aDQ0AJvOPka8mf-u7uWHiw-1; Tue, 09 Aug 2022 05:25:26 -0400
X-MC-Unique: aDQ0AJvOPka8mf-u7uWHiw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-329aa33ca23so46297957b3.13
 for <ltp@lists.linux.it>; Tue, 09 Aug 2022 02:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VxYfr5eY6BZvku5zorxTAOoVxncoEjEknWcVbLP0DCQ=;
 b=2EetEmksLiip1CERj7UYNkjAkCEmJD9g4PcHHuv6e5cwZMH/e5mql/h1Q6wJqa9Gd2
 x+A0a3IXe8+WbTRLgrPEbpbrqTwfbkLXntWD3jy9qIlMXqFig9a3WML8Mmt6hLMXB8cb
 Mshgw9Vm/Jd5Z5izlMv5/wkIaSng9gWxU1hAFw+JWqNdpYMVECBnQmr4u21QTSFpWNCv
 AcV1tod2dhE0RyxVa+fkRDMfDd1TJC5GzKlSjDDjjd1hr0G80iMloFPF7Gm1TMbHNUGO
 zuYApeMhyp8Bu0C0d25EM5T/0J5h0GIKjCDQzI81FZBd8J7iutaF3G1L5jWjQEmhqc5v
 MW2w==
X-Gm-Message-State: ACgBeo0yfoSnnluHxXySG8Y2JOGtHCzd1/YDr/oMPdoLS2LQr2j4nI0w
 86fX5kNTrd/GNuPAXfug123fC+sdfcrMJHwIpPX4qR2peDTSR+VjvV2r6ncyJ+PKna4RhdvFfI/
 7MyA4PrwiXEJJ2oZUeD1D+f0UeAI=
X-Received: by 2002:a25:800b:0:b0:675:ebb4:c43e with SMTP id
 m11-20020a25800b000000b00675ebb4c43emr19762236ybk.412.1660037125401; 
 Tue, 09 Aug 2022 02:25:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7nfq4TBMoytMCkTGAGVq13POlwmxs2/4H6ecMKcoj7bmxl2tuuj0+RHTk/57AJMxjgTSXdiGYJ0/TvyhVJ9Aw=
X-Received: by 2002:a25:800b:0:b0:675:ebb4:c43e with SMTP id
 m11-20020a25800b000000b00675ebb4c43emr19762224ybk.412.1660037125163; Tue, 09
 Aug 2022 02:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220808113756.11582-1-pvorel@suse.cz>
 <20220808113756.11582-2-pvorel@suse.cz>
In-Reply-To: <20220808113756.11582-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Aug 2022 17:25:14 +0800
Message-ID: <CAEemH2dn0o1bpOZ6pKQrzbcmyjkj+ZfMdsDSEiNoQPkbKS6_uw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/4] tst_test.sh: runtest.sh: Remove unused code
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
Content-Type: multipart/mixed; boundary="===============0548339023=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0548339023==
Content-Type: multipart/alternative; boundary="00000000000028e7a505e5cb83d4"

--00000000000028e7a505e5cb83d4
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--00000000000028e7a505e5cb83d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com"=
>liwang@redhat.com</a>&gt;<br></div></div><div><br></div>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><di=
v>Li Wang<br></div></div></div></div>

--00000000000028e7a505e5cb83d4--


--===============0548339023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0548339023==--

