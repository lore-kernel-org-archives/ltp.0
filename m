Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078F1C433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 07:41:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44D2A3C5A9E
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 08:41:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E02D3C3344
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 08:41:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3DD501A0121C
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 08:41:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648194064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oaGrPW3bvn1PGkVc4inCTPpb3cgC3gi0PUimRIDnAcI=;
 b=ZpD4h0jfNhXsGyXu5WqmWaKjHcf+MJv3tNrUqH9V6JibK+u3HNK9mPzXSJePCwufYp1UiD
 17hanMQZuXivAV0OUVB3c8S4D6HP1iYANP5CuPEpIRrl7qMaBHxbgM5D3aUz09kVzIDHLL
 +jLq9KVqVLdlyNLZskJ8AbF7Bncp2t8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-wFB6cL4hN6qXlCuVQpW4YQ-1; Fri, 25 Mar 2022 03:41:03 -0400
X-MC-Unique: wFB6cL4hN6qXlCuVQpW4YQ-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-2d2d45c0df7so54903067b3.1
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 00:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oaGrPW3bvn1PGkVc4inCTPpb3cgC3gi0PUimRIDnAcI=;
 b=zvx/BS2dNW/FiY2LJpG7cX4jdx7EVIfEtbVxve/4/9Hjd4EuK4ZJQZDGPGJuv5nprK
 tmGu6eetPzajTYCH6FcpyYxJ6G6fD3813MGOBdGtbdpUOpbsGlcAHy2fZMcuMSOhdGik
 1HmWic8UI2b9cHNuxSfeN+B+AfuS3iOW9PraePkuD9Pww7fy4bbOUljnYsKetlCmgJL4
 eOVOJue9r/iaBbJElW7tLEoFYi5g5vMVgc9LLmrBGIRj70eplQRY1FzvHMkeqUVcSilX
 7n/bxjycyEJ2ROTht+Bu3onW08xumbZySxZ0CpzDqnTha6RKQDg8euOeiqoLgoqBgkUV
 KaGw==
X-Gm-Message-State: AOAM531/BYLAAxCeUkRBAWqMmRnmp98c6uMLbitnD78H75SD4lKd0BHW
 Ih0id3udOXzZuW6cNNv5Idgt4l9MSw/W977Cj2gSrNLxkaiaa9ZbbQ4p0FYm+5npe3l0cXyXEHi
 KVrxlp80HwJCvVL9CPotwnz2JRk0=
X-Received: by 2002:a05:690c:314:b0:2e5:9e04:7ed3 with SMTP id
 bg20-20020a05690c031400b002e59e047ed3mr9431047ywb.370.1648194062425; 
 Fri, 25 Mar 2022 00:41:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6qs/9YBL1I54OL+1ilQSRMxQ4ZQ5v1oDNFWlh+I6ZvUD+yzUXhmRoNULpVIYy0iKN46MYRVD0kdOFAc+n3R0=
X-Received: by 2002:a05:690c:314:b0:2e5:9e04:7ed3 with SMTP id
 bg20-20020a05690c031400b002e59e047ed3mr9431035ywb.370.1648194062235; Fri, 25
 Mar 2022 00:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220325014821.2286280-1-chuhu@redhat.com>
In-Reply-To: <20220325014821.2286280-1-chuhu@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 25 Mar 2022 15:40:50 +0800
Message-ID: <CAEemH2ckzJRMB8HBkHx_3TVS38Ofy-neT8sK+5oYoNk=A0+TBA@mail.gmail.com>
To: Chunyu Hu <chuhu@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] futex_waitv03: fix SIGSEGV in TCONF cleanup
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
Content-Type: multipart/mixed; boundary="===============1759014523=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1759014523==
Content-Type: multipart/alternative; boundary="00000000000099ce1805db0615fc"

--00000000000099ce1805db0615fc
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--00000000000099ce1805db0615fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><div class=3D"gmail_default">Reviewed-by: Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt;</=
div><font color=3D"#888888"><br></font></div></div><div><br></div>-- <br><d=
iv dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br>=
</div><div>Li Wang<br></div></div></div></div>

--00000000000099ce1805db0615fc--


--===============1759014523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1759014523==--

