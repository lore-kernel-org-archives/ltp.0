Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3291CC43334
	for <ltp@archiver.kernel.org>; Thu,  2 Jun 2022 08:18:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 182303C7FBF
	for <ltp@archiver.kernel.org>; Thu,  2 Jun 2022 10:18:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 997013C53F1
 for <ltp@lists.linux.it>; Thu,  2 Jun 2022 10:17:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ED25320017C
 for <ltp@lists.linux.it>; Thu,  2 Jun 2022 10:17:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654157870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rfg9a1BoQFJfcQU/g7VHRRB44/sSZpVOX4P/xMnpFQs=;
 b=KdwcQHp/TjwMTXEFu8xwglzJLAQN+JjFWH/RUT+vfVgZ3H1QGsJV8m10g0kRvqpkafmooL
 5rPUQGBRunF3VqFG1RkrwwRYaCNwFPCoj7bCfW7z1EwY6uQIHA1jwNqGL6loDC6oiYGzlN
 S181HSc2yL34cnr7lb1bC3EIxr5Mebs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-j_I9ccdwOp2GYvj09z5mBw-1; Thu, 02 Jun 2022 04:17:44 -0400
X-MC-Unique: j_I9ccdwOp2GYvj09z5mBw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-30041bd304bso36857377b3.18
 for <ltp@lists.linux.it>; Thu, 02 Jun 2022 01:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rfg9a1BoQFJfcQU/g7VHRRB44/sSZpVOX4P/xMnpFQs=;
 b=O/vCb5y23mBBbNwC3AS9P6BMSf6M8X7qLD2I8zVLuBM4JFM5nevcyh4MhDjFY64vRf
 9UbajlylG1XZQr/p9tutM9YAd7OXnxsM7H2fgwKKvf6/50/L8zAJehYsnsdx4UnnsMLt
 IkiDqb4S0x5aHZXwjnVE56Reo/ImG4/mGEpdIkdP04+qefpyqYRbDFNgrWbIjSaZR3Df
 0gAfhzjQyvfJky4dv1Z4fE0hq8tUdYefliw1eKYkjpKfxCvvg75oCmYjHHv1zULbsfJJ
 6S3hxoN4U5v7pDtddfv1upo3t23lcRakWs/VgIzkikSSWkMPjqrJmuH7wNz03kPHDtW6
 CkLA==
X-Gm-Message-State: AOAM5328egEJHbJp86iVY2ZDEyOVh3AFhjR07mlWySy0RAzdVKGZ5e1e
 ERGSrYw2AOTTDLVosKJihQ6b3WkNQTpXsH0W80GB8hiRe5Y1aHTKTba9+wjbUwKMEq+NSG2hMIY
 NWt7959oSlwxNJvnzwsC86rTJ8DY=
X-Received: by 2002:a81:74a:0:b0:30f:ea59:f12f with SMTP id
 71-20020a81074a000000b0030fea59f12fmr1050282ywh.82.1654157863932; 
 Thu, 02 Jun 2022 01:17:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKbuc4MMEtp9bK3o8sCSWk2nxGuuafoD3F9Jd5PqpUe3z4goBG1+pdxI2s7OartvGTLXOJ2XX5t9ikQo+6qpw=
X-Received: by 2002:a81:74a:0:b0:30f:ea59:f12f with SMTP id
 71-20020a81074a000000b0030fea59f12fmr1050261ywh.82.1654157863693; Thu, 02 Jun
 2022 01:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220602073601.148537-1-zhaogongyi@huawei.com>
In-Reply-To: <20220602073601.148537-1-zhaogongyi@huawei.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 2 Jun 2022 16:17:32 +0800
Message-ID: <CAEemH2c1SQHDP=kNu_ZKde_S58TDJyvOKf_M6XumhpxTp9PBFg@mail.gmail.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_children_cleanup: Add test_children_cleanup
 to .gitignore
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
Content-Type: multipart/mixed; boundary="===============1815985807=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1815985807==
Content-Type: multipart/alternative; boundary="000000000000de48d405e072a36b"

--000000000000de48d405e072a36b
Content-Type: text/plain; charset="UTF-8"

Applied, thanks.

-- 
Regards,
Li Wang

--000000000000de48d405e072a36b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Applied, thanks.</div></div><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr"><br></div></div>-- <br><div dir=3D"ltr" cla=
ss=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang=
<br></div></div></div></div>

--000000000000de48d405e072a36b--


--===============1815985807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1815985807==--

