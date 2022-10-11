Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC53CC433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 02:55:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86FEC3CAE7A
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 04:55:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1BA83CA91F
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 04:55:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 21D8060080D
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 04:55:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665456921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FclyomOPf9conrAuX5kvk6VwSbuorzJaDwmiVLRN1Zs=;
 b=dApFTvjdnFk35ossZmIc8lJY6utL931+qcnrv5/+vrexpzOfJ2dWU8at9ZiS/4ejtcEndc
 1Y0QZRkMkvbJbSMg3E7e/PGT5H6ca4C9ZqPkjWpKqcnrV+UlOiJ33KrQ7KN82gSR8BBIlw
 Oy2MDU49L5anjb2ciLdM3LTN8x/jTgQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-552-M2HS5pRjNjKEJYSpUYiMmg-1; Mon, 10 Oct 2022 22:55:18 -0400
X-MC-Unique: M2HS5pRjNjKEJYSpUYiMmg-1
Received: by mail-wm1-f72.google.com with SMTP id
 r81-20020a1c4454000000b003c41e9ae97dso5432018wma.6
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 19:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FclyomOPf9conrAuX5kvk6VwSbuorzJaDwmiVLRN1Zs=;
 b=UNJGEd10CaCF0UFhoiNL5oANpLcgO/mp6bUjOfSYFyZw6t3z+Yu07eTM8um1HoCAjj
 jEx6zr6FQwmHoh720KStgpC6hjXbtehXygkmLtBSiDq3A9tYPdZPshAPLFb78TQm7wYz
 emhGywHzy9rHLkZfJZ+dUt0C4DgIPsz3BjtqhmBTlUmd3R0AUbNS+2g0T/bkh8QwzXUs
 ATI7FXFkDkqi2PqedDzsPScPfuRq74Jd17O7MY5MxsElY2WeRJIGCS55zySya2lakxWK
 GruqrlWA/PTIdoekm+zY4+MXb0S+bXktt4D+MQZZUFe3q+5O9BhN7BsDBg5JVKuiSk/g
 lYoQ==
X-Gm-Message-State: ACrzQf0+83yG1/BaAuyGWfZFmJahFJQSMmdkSvrtKtRw5CjiXTyS/qSz
 pNfliCisX3gaOUJvFfjz1h8Tw5tXOrklniwdR8tC+/6cQCJh2fnSv5FaCNguy6Y4mfyBHqymSpZ
 lBkxmvf1bCX1q9c4jU6UycNe2bkM=
X-Received: by 2002:a05:600c:a0b:b0:3b4:f9a7:f79b with SMTP id
 z11-20020a05600c0a0b00b003b4f9a7f79bmr20881568wmp.99.1665456917811; 
 Mon, 10 Oct 2022 19:55:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7++6syLPibYp7uVyUSdWoY+P4Sfd4l7b7aflL/izHJz9Ly0RmYdk7RWkbXdmGnu2FsdTcPlbB1ZM7EVLdkhc8=
X-Received: by 2002:a05:600c:a0b:b0:3b4:f9a7:f79b with SMTP id
 z11-20020a05600c0a0b00b003b4f9a7f79bmr20881560wmp.99.1665456917605; Mon, 10
 Oct 2022 19:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221010085944.26814-1-pvorel@suse.cz>
In-Reply-To: <20221010085944.26814-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Oct 2022 10:55:06 +0800
Message-ID: <CAEemH2cR7FsjMUvNTEd6Bf8nkyivjLF3GytSx9HgiYRD0J2xsQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Create (again) loop device in
 $TST_TMPDIR
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0918561076=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0918561076==
Content-Type: multipart/alternative; boundary="000000000000f68b0305eab96722"

--000000000000f68b0305eab96722
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--000000000000f68b0305eab96722
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com"=
 target=3D"_blank">liwang@redhat.com</a>&gt;<br></div></div><div><br></div>=
-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wan=
g<br></div></div></div></div>

--000000000000f68b0305eab96722--


--===============0918561076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0918561076==--

