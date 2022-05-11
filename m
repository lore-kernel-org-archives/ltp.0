Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C543DC433F5
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 09:49:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 464163CA99F
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 11:49:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8A383C9485
 for <ltp@lists.linux.it>; Wed, 11 May 2022 11:48:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 73AC71A00A31
 for <ltp@lists.linux.it>; Wed, 11 May 2022 11:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652262530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqbL+9MWoS3m7iB+AKmq0g3fb4BxjvrDIJVdXj3zTYs=;
 b=OBjaLFy5AhLmFI9V4tvIeKJPRNEgN8zIBZlRp8K8JVzByxo7oIo75ilrsIHC6s8Orzg29M
 6R7LRtV2aqhx4mLnP7iZx+3b4K4V5c4pg1JsAhxmk0Xms1rz4EaeClUWIy1npuI0z93AYV
 qmjtRKCZWQbgA8Cz4meKuobFRWSnWMg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-qiraArDIP1a1HPEWXwxpsw-1; Wed, 11 May 2022 05:48:48 -0400
X-MC-Unique: qiraArDIP1a1HPEWXwxpsw-1
Received: by mail-yb1-f199.google.com with SMTP id
 n6-20020a254006000000b0064b2e352561so1403419yba.12
 for <ltp@lists.linux.it>; Wed, 11 May 2022 02:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kqbL+9MWoS3m7iB+AKmq0g3fb4BxjvrDIJVdXj3zTYs=;
 b=g9vI4t9UHvz1eihtT/WoR//yiinDX4inP0GjtqETolhHWC2C2UijcECASKElKgor6a
 bnLeCEJPQFYNt7lLnalyf23bh4GZ633RvNI9DA4lk6cFYLkeyMQGvuHJG1XC6VPZdwCO
 pxgSvttcs8Q0LFYiNIGHdpkxHP5gtSOCYDpooLykMrS31NhTefJS18EqrtMPGImp+vew
 GMyRqcra2oIf597O9glVGo78GO91ei9dGs1STEUG6+Qe6COIgIamwzFo1z9DhfFG0JlW
 jCwCDrJruqjIjAbHdUn1KdenlJx91dU2kMPcPivHbCbFpfOgRVZhC5eui500aPGMTvuU
 y1YA==
X-Gm-Message-State: AOAM532/jBNJrOKaVYWYz68YK8EFFOJ6evf/YuxqOjnQy86O5bDPbEX9
 P8a44a8ssEH9EpFYlEA4l3IG4mA7VL/UVU4zvboADtd1N9vKspi1sn6zMakIGG9OFCUcYRq0y4c
 jhdokhdHNcE3R/ktbGOtq/xN0iKw=
X-Received: by 2002:a81:1901:0:b0:2f8:3983:78f7 with SMTP id
 1-20020a811901000000b002f8398378f7mr24029705ywz.370.1652262528032; 
 Wed, 11 May 2022 02:48:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvZDHo5YQUD2XQ0z3A5+FUDJfZolEjOWrW79pqNBVZMxIxq3eUnJ+enKGLGx/7Xf25uxSjhkm9nvhAtQrT+bM=
X-Received: by 2002:a81:1901:0:b0:2f8:3983:78f7 with SMTP id
 1-20020a811901000000b002f8398378f7mr24029687ywz.370.1652262527813; Wed, 11
 May 2022 02:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220511021636.2166562-1-liwang@redhat.com>
 <Ynt3c8ks6kkAGs/z@yuki>
In-Reply-To: <Ynt3c8ks6kkAGs/z@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 11 May 2022 17:48:37 +0800
Message-ID: <CAEemH2ftLWEu76r7+7JHmMmHNxeZyrFaZw-BANR62v_0r4LSWg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] rtc02: loosen the compare precision with few
 seconds
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
Cc: Eirik Fuller <efuller@redhat.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0302907611=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0302907611==
Content-Type: multipart/alternative; boundary="0000000000000be0f905deb959ff"

--0000000000000be0f905deb959ff
Content-Type: text/plain; charset="UTF-8"

Pushed, thanks for review.

-- 
Regards,
Li Wang

--0000000000000be0f905deb959ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Pushed, thanks for review.</div></div><div><br></div>-- <br><=
div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br=
></div><div>Li Wang<br></div></div></div></div>

--0000000000000be0f905deb959ff--


--===============0302907611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0302907611==--

