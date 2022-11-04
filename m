Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4483DC433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:12:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 691D63CB374
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:12:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DB9B3CB57C
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E1F5A200C0F
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 08:08:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667545729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BSROt+TJXO5AMm/O5x5dRh12ZJM2q3t/Og5S/Y7cuP4=;
 b=Q6/AD/7QZz1cpdfsoBGMor8pjcmCocQqhiYj19cFrToh7VQfZ1zXy3oQFOG/CjIEIWRHS2
 D8rkN9r7gGhQQnWp9EyQKlMpGCvSIEeAw337YI8+zLayv7D52k6VgwlDTakPps5K3O0QU0
 J/TerM69I0pGqUIWcxFb3q0PbUs5aco=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-306-IEqQ7vkDNs-LgWnmPk7b0A-1; Fri, 04 Nov 2022 03:08:42 -0400
X-MC-Unique: IEqQ7vkDNs-LgWnmPk7b0A-1
Received: by mail-ot1-f70.google.com with SMTP id
 cy25-20020a056830699900b00661acac3847so1696471otb.17
 for <ltp@lists.linux.it>; Fri, 04 Nov 2022 00:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BSROt+TJXO5AMm/O5x5dRh12ZJM2q3t/Og5S/Y7cuP4=;
 b=H7XvUN1A4nXOjXo7M4MDbM/G5At7gbiq083hx94NUGolv/5ubNYzwjgYDCxafA1dBV
 S+aNFssNg9p/cFAteBa8f0QVsc1AJ0fjXmo0QJwVFlq+pMa01fbFZNPlevmhrJGKp5Qf
 xC4bbJe+IIrfO6bb+GaMvcJkzJuJwnuO9KCsgbDTdWyYIS96t4jYyBYiJUo9iZ2jT7jZ
 PBy8JPG1l/MBj3jaitS6814SzHMV+KebIWgys9LCpWafNG4+Tusmo7La+Zk2v9/R+kYO
 zUyl57VfM/LXtz4uG7be19pXl7njSwkY1gEwnpKuPGPaIFfZpVGHiQnTv6tHtaU/sXiH
 PGQQ==
X-Gm-Message-State: ACrzQf0fW07/fp9JPI/klynXEO1uEklU2Ht5rHVc0XhkTI7QU5iokIuw
 pouthgz9PedxDiK1LGgDWi0bRHVpgAyVgafLvJEm0rkWDNr70igKwfGRYYAsxm3q5WLPZ8WFf+d
 eiQQfVjQfBD4MMpfD1sjik+1oVxM=
X-Received: by 2002:a05:6808:14cd:b0:357:62f3:d7b7 with SMTP id
 f13-20020a05680814cd00b0035762f3d7b7mr27417546oiw.107.1667545721140; 
 Fri, 04 Nov 2022 00:08:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM52+5UPi8N3xvx6wGza0MsyMgf2le3uBJiA8vxzdIHiU5LhS1X/E+POP5LFDLpBAK/Q9tlhFbPSoEfQMX4Hm20=
X-Received: by 2002:a05:6808:14cd:b0:357:62f3:d7b7 with SMTP id
 f13-20020a05680814cd00b0035762f3d7b7mr27417486oiw.107.1667545719637; Fri, 04
 Nov 2022 00:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221025121853.3590372-1-liwang@redhat.com>
In-Reply-To: <20221025121853.3590372-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 4 Nov 2022 15:08:27 +0800
Message-ID: <CAEemH2ciCbmVhVtm+oMV2JqnWf10qK-GAZNp1bZOiC2ks4cnuQ@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] setitimer01: add interval timer test
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
Content-Type: multipart/mixed; boundary="===============0549951673=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0549951673==
Content-Type: multipart/alternative; boundary="00000000000044213205ec9fbe38"

--00000000000044213205ec9fbe38
Content-Type: text/plain; charset="UTF-8"

Plz ignore this patch, it needs code rebase after Anderea's work:

    b606a7c7d setitimer01: Fix checking of setitimer() parameters

-- 
Regards,
Li Wang

--00000000000044213205ec9fbe38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Plz ignore this patch, it needs code rebase after Anderea&#39=
;s work:</div><div class=3D"gmail_default" style=3D"font-size:small"><br></=
div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 b6=
06a7c7d setitimer01: Fix checking of setitimer() parameters</div></div><div=
><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div>=
<div>Li Wang<br></div></div></div></div>

--00000000000044213205ec9fbe38--


--===============0549951673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0549951673==--

