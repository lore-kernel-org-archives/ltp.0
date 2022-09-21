Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA28C54EE9
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 02:08:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77E2F3CAD41
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 04:08:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A770A3CAA99
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 04:08:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ADFDD1400FB3
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 04:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663726121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BslsDAWiWAX+gOUMo99B4cXaJgZ05gKP3UjSiL44vvw=;
 b=b9ahwmnUk2OLxEVM64CO67DZPlNdqrsFmJ9Dn5erP0y+tomUt7T9D/KLoV+9SWemgphBoS
 Wq/or4/vqRc32BmJTwupmbz5oYKm+iP8pyYVirAt0q1Uu2gBRW2fmpyiwUqOJ+JffjqfJP
 epMCraJPksuvXv0Yt9sWiCtVtBk0tvc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-354-YqWd2Z65OzG9JfnU07g6MQ-1; Tue, 20 Sep 2022 22:08:37 -0400
X-MC-Unique: YqWd2Z65OzG9JfnU07g6MQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 84-20020a1c0257000000b003b4be28d7e3so556520wmc.0
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 19:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=BslsDAWiWAX+gOUMo99B4cXaJgZ05gKP3UjSiL44vvw=;
 b=DsIeZdYSBqhkhlyeYDOF9Swy9FvflxsZJ40kIDNIFpyLGl7H4qwhPMFTTuSLlwtcnt
 Mk9PIvTear82mkDpzvSlBSLb9T04awPtKbPOKVDj9SVVWZAgWFKS4LBN/g6je/FrIvRh
 ac6AY+EwmKAVOXmKKsfkJ3wq02VxF+bkdPc0Euefay6JdMfd7rU7M91PIKja7uIxUH+W
 5/G3RrS7RZS4bKyMsirSnT2ZAJYMjHseuH4JuWqnazjvXjCqVOm/uQaS9qjVTjcPhG6Y
 SSUBX8OHhnMRv4Qb18iE9mVNilqgCblTHwV8mSU67EHVdYE75Y2SVeQIx2AfSr9vbFnZ
 Mf+Q==
X-Gm-Message-State: ACrzQf1e8NnejOOORYTNzExxMkDAv8xirE0KLlFId7WZYFvWPw3h0OXb
 Whmwfsu0PeTqLPvhMQhMRGOkfB+M9/iU4Pg5L1wbeQ01FB5L78REIXgHUVHtt+r+y+IUYCMIjRa
 cDQqaP2lREN6FJtQrYkzld3bWXsM=
X-Received: by 2002:a05:6000:22b:b0:226:d378:50f1 with SMTP id
 l11-20020a056000022b00b00226d37850f1mr15853190wrz.316.1663726115525; 
 Tue, 20 Sep 2022 19:08:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Kry/Qvjo7Hle7vmzLD2IGQKJsf3FtaeCjqqOSYUCXKJC5eVtg5GpGuSSE8jmMrUub5q3fdlYwHcDJBbShpQo=
X-Received: by 2002:a05:6000:22b:b0:226:d378:50f1 with SMTP id
 l11-20020a056000022b00b00226d37850f1mr15853181wrz.316.1663726115357; Tue, 20
 Sep 2022 19:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220920214301.12828-1-pvorel@suse.cz>
In-Reply-To: <20220920214301.12828-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 21 Sep 2022 10:08:23 +0800
Message-ID: <CAEemH2cgaonz0YqySVBEX-QxbOFMZVjphPmmMXU1SSV3e9vnQg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ima_setup.sh: Fix loop device workaround
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
Content-Type: multipart/mixed; boundary="===============1796202867=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1796202867==
Content-Type: multipart/alternative; boundary="0000000000001c1fa005e9266cef"

--0000000000001c1fa005e9266cef
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--0000000000001c1fa005e9266cef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr"><div class=3D"gmail_default" style=3D"font-size:small">=
Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redhat=
.com</a>&gt;</div><br></div></div><div><br></div>-- <br><div dir=3D"ltr" cl=
ass=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wan=
g<br></div></div></div></div>

--0000000000001c1fa005e9266cef--


--===============1796202867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1796202867==--

