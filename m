Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E03C43334
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 07:23:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B3E23C9407
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 09:23:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C28EB3C8CA7
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 09:23:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 667EC600241
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 09:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655191403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbc/UKtcev7uSeZK2Agu2kI4RBW3epAL75jEDuZeZwY=;
 b=MkAlnXNXIDT3fJbrMmXCEXUsgGnHwleU3+gcb0+7dW7PpZQ8230fAErOcHaq0qTCj5lvID
 gobVwUYAnPXothiNtIMixJMiJp8xV3/Q/XzNXQPrGBhBymXMy0u4Q7XUoffL8RDSR4u1qE
 0IPUJ/Xg/xtLgkQbgtfJFfT/YcawTxw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-O9K9F6dNNgiBCx33reWmhg-1; Tue, 14 Jun 2022 03:23:22 -0400
X-MC-Unique: O9K9F6dNNgiBCx33reWmhg-1
Received: by mail-yb1-f199.google.com with SMTP id
 10-20020a250d0a000000b0065ca0e7be90so6909072ybn.17
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 00:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lbc/UKtcev7uSeZK2Agu2kI4RBW3epAL75jEDuZeZwY=;
 b=d9SZi7IIJrX0WutsKaOUqlCjkgGLaMXfa1nekhsKlkalnYzRw58JnxesKVvurDP+xl
 Ad2rYFt1SnddwxaB4QWmwfnc0xHzW2TXQecxuWPnaKLme7gWj2nz3dqHsMPgP2fZ5Ms2
 NWjHsYDfa91zR46t8ah8FG9NTe+Ni290Pq7OxH2rjB9gsZ4xQhNjqJn9PqwxR9MU2ASz
 oS3Sv9EscSWrW1PIpgwn9mnRNQsdNj0MW8judI4hayg0TS4ruC8eZ2LQwjBy1xumWCOQ
 uk3G+qW+EGJ6z+bVCdCJSLO2d20ktFpmVVDBHKgPS7ApJqyxZ9JPzjImRjDNNeVzIjOI
 hz1A==
X-Gm-Message-State: AJIora9MwdEo7gfyksFTrs8BJJb5VpckAJ1GDnvPcYbFZa7VkEGoxPLF
 36eX+hpKOP6J+Z/JMhu2VGYFZhyJbvCXmfWXyiolGJaLB0/P84nd+57CVLsv/piVGtflp0km2HA
 y8cGCL6CRdQPsRsz6cNFQU7uNG/w=
X-Received: by 2002:a81:74a:0:b0:30f:ea59:f12f with SMTP id
 71-20020a81074a000000b0030fea59f12fmr3983435ywh.82.1655191401851; 
 Tue, 14 Jun 2022 00:23:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1veTJyP/CXVPqURLyqkl0HmoW83sJSmShrkCtpMlPR3qtG9WbpFUKDjd3G+cg9Wr3ZI2rvJr4laQB19Jhe3CHM=
X-Received: by 2002:a81:74a:0:b0:30f:ea59:f12f with SMTP id
 71-20020a81074a000000b0030fea59f12fmr3983426ywh.82.1655191401632; Tue, 14 Jun
 2022 00:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220411094048.1143292-1-liwang@redhat.com>
 <YqL96JmZdDfL4ziv@yuki>
In-Reply-To: <YqL96JmZdDfL4ziv@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 14 Jun 2022 15:23:10 +0800
Message-ID: <CAEemH2d9_psdQHtUF5TOmpKAHeqRMaNXvQcotzx_qp6+BdKmPg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] pkey01: print more info when write buff fail
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
Content-Type: multipart/mixed; boundary="===============0150532803=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0150532803==
Content-Type: multipart/alternative; boundary="00000000000087b10605e16347ce"

--00000000000087b10605e16347ce
Content-Type: text/plain; charset="UTF-8"

> This looks good to me, in case you are going to push the patch:
>

Thanks, I have pushed patch-1/2, hope it helps to catch something useful.

-- 
Regards,
Li Wang

--00000000000087b10605e16347ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
This looks good to me, in case you are going to push the patch:<br></blockq=
uote><div><br></div><div class=3D"gmail_default" style=3D"font-size:small">=
Thanks, I have pushed patch-1/2, hope it helps to catch something useful.</=
div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">=
<div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div><=
/div>

--00000000000087b10605e16347ce--


--===============0150532803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0150532803==--

