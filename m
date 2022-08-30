Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EE7ECAAD1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 06:15:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BFE73CA60D
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 08:15:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC1643C81E1
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 08:14:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AEF3D2001AF
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 08:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661840091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OX9xBFDrUdj7craZgh8K37aIDUsQ7oWKtt0rhXWYhLg=;
 b=G3HyeP+WM9sgfAG6E2qbBSrJq0wCJ1ccjD9hlCGFD+1kFSXnBEVIj2an0PjrPUUW/YFI/D
 Zxcsfps6lFrnr3kBEb51AV9zAROLqtMUSg5kd18yFRhFYmIpMq98Z0JSW/zWVz94SXEOdb
 2TAaFXWfD3ETPNcWC4S+3pftZYIzqlU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-339-hjNEnkI_ONeVbwpxk1By3A-1; Tue, 30 Aug 2022 02:14:49 -0400
X-MC-Unique: hjNEnkI_ONeVbwpxk1By3A-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-33d9f6f4656so163748527b3.21
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 23:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=OX9xBFDrUdj7craZgh8K37aIDUsQ7oWKtt0rhXWYhLg=;
 b=s9qJ39Jc1GugZqwnetdsMWJetMBcLRHHMYAFH5l0oZQWQu9FKAQ5WA26/b1cj84QFR
 +2H7XVuvA8A/cN8xhY/vYQfelDfHq5S6U+pyVnw773IQ6ANBSKY2b8gwT4v2pQqXzsl1
 nW7HVhGqW/WDK7RH6EspOHyYxvfSgZVZYH/pnT2WXqJxHvNgly+C9fZsgr3d2G2EyVYt
 NKZZ9rVC4qTfC/HhHy5ieicLDCddZn5O9SxfhxFKy+RHjbaPmdkX8GdYTU4i3oL4rdv8
 r1cdkpKa/26+fIOsHjJjvUj5ZpMy1zTHLIjmqeEaNdegaPNcWgd96F4QPncs1GVr/MX/
 83hA==
X-Gm-Message-State: ACgBeo2Q8cerOlncJ48iraFSAV5gDwU1+H8E85GGMaeJ0aWwhQf8q1Rw
 CFrtJvIOWdTBCuyOK4TC0Z++h5jUo3yE0fHtIXLNG8H+/CfYWLpQdDjl79CG7LszoYCqkySRtzJ
 /1ROxDZ3vIdspgadMPZijSTGnwQk=
X-Received: by 2002:a25:558:0:b0:696:4e84:6367 with SMTP id
 85-20020a250558000000b006964e846367mr10230042ybf.412.1661840089120; 
 Mon, 29 Aug 2022 23:14:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5jGBGNeJM/R4pWhW8w/gZUByrZsslzb/1XlychWxgAFgqbns8+fbvFIBZPskm1dc2xqa98BPRbUkksNNVcmtQ=
X-Received: by 2002:a25:558:0:b0:696:4e84:6367 with SMTP id
 85-20020a250558000000b006964e846367mr10230030ybf.412.1661840088903; Mon, 29
 Aug 2022 23:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-5-pvorel@suse.cz>
In-Reply-To: <20220827002815.19116-5-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Aug 2022 14:14:37 +0800
Message-ID: <CAEemH2dp=2AdfERRt++JG338ZupmNQ9dLy9iXSXx0F+K9BWOSg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/6] tst_device: Use getopts
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, linux-fsdevel@vger.kernel.org,
 Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============0234962719=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0234962719==
Content-Type: multipart/alternative; boundary="0000000000002c45f005e76f4cea"

--0000000000002c45f005e76f4cea
Content-Type: text/plain; charset="UTF-8"

With fix the tiny issues in description.

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--0000000000002c45f005e76f4cea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr"><div class=3D"gmail_default" style=3D"font-size:small">=
With fix the tiny issues in description.</div><div class=3D"gmail_default" =
style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.co=
m">liwang@redhat.com</a>&gt;</div><br></div></div><div><br></div>-- <br><di=
v dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br><=
/div><div>Li Wang<br></div></div></div></div>

--0000000000002c45f005e76f4cea--


--===============0234962719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0234962719==--

