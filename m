Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80989C43334
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 03:09:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C43F13C8E6D
	for <ltp@archiver.kernel.org>; Tue,  7 Jun 2022 05:08:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AF853C04C3
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 05:08:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EC132100079B
 for <ltp@lists.linux.it>; Tue,  7 Jun 2022 05:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654571325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DfQ9Sj9z3v1R1gl33JhWb5EAEDraSEdECn2KUVpAVmg=;
 b=ZcV6IKYV3Lm1qgFTGMFkK1vHnibmdT/TlcL6ZtO9SH1IbgaJs/2I/5JFdx9FKqgGTKT/KU
 Yf3nlTz6bDzNmRMPoB0/LHOrvpov4aeXdkUPEFrPs7DqT4CWgo6eus4sg6CqptQXZH7yCZ
 kGReg8X2d+U9Hwx9gskVszA+EScV5hI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-cp92RxIgO36sWbg8LQwAYg-1; Mon, 06 Jun 2022 23:08:43 -0400
X-MC-Unique: cp92RxIgO36sWbg8LQwAYg-1
Received: by mail-yb1-f200.google.com with SMTP id
 a68-20020a25ca47000000b006605f788ff1so10629331ybg.16
 for <ltp@lists.linux.it>; Mon, 06 Jun 2022 20:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DfQ9Sj9z3v1R1gl33JhWb5EAEDraSEdECn2KUVpAVmg=;
 b=LRBIZne8yAZyp+QCOw+QzlTzfXVkR5sZIC8yCDi+/TkYTi1K5IPfrdHVpyK1cXnr6O
 OrlumG9xD/YY3kaSNUa6R6ZyAGbadhcGaYyV8Uasv5Cd4PQ8vq+tzOGoM17w3hDP9Hdh
 k1Qql1AqIsdLfjXBUoEo1EG+bJFIyi6XPxUL16v3xms64ZGKsTLqQ2h7Dd7sqZnjM0AQ
 OGmIGndl53zayJU/Ur5E5CA5P7xOPz9eAQRE/WG+nhfoKpoBVQa+ru3vCCYCZh1523It
 M8hJpAZiNalvk7XEyjBI5qmRn0vLE7xvniBfqFTIcKBDaNJoW2lWnGro8A4By7uKYUaE
 k2yg==
X-Gm-Message-State: AOAM53371ItT0aaAlYKds8JLos68Zxst+GwT3z+YDzgKwfQSaGDnjKMb
 /R/T44mJEqRUM58FRNCOpXXV70xXldQSXnwn6/XyoJIiYu7BSpjEEybRe4B+tEQAsRRJ93ycvGN
 EMQCxMsBJwbOHRClvYuvKt+YhL+A=
X-Received: by 2002:a81:74a:0:b0:30f:ea59:f12f with SMTP id
 71-20020a81074a000000b0030fea59f12fmr25749204ywh.82.1654571323459; 
 Mon, 06 Jun 2022 20:08:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5aPyBON4eHeb+v6m5P9AeCZKAD40Wi64hK1p7SwOm6bxBJQGUXUGhKu8egcN4URCUiCTSsJrOAXszrIU5txY=
X-Received: by 2002:a81:74a:0:b0:30f:ea59:f12f with SMTP id
 71-20020a81074a000000b0030fea59f12fmr25749198ywh.82.1654571323280; Mon, 06
 Jun 2022 20:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220606100034.169493-1-liwang@redhat.com>
 <20220606100034.169493-3-liwang@redhat.com>
 <Yp5kCbzQQyMFnpdI@pevik>
In-Reply-To: <Yp5kCbzQQyMFnpdI@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Jun 2022 11:08:32 +0800
Message-ID: <CAEemH2er+xvO=Z52KjcAZVnd5QHOukj0xSTES2Q4n0+e32nKLA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] memfd_create03: make use of new .hugepages
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
Content-Type: multipart/mixed; boundary="===============1985401271=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1985401271==
Content-Type: multipart/alternative; boundary="000000000000fae99b05e0d2e78a"

--000000000000fae99b05e0d2e78a
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Tue, Jun 7, 2022 at 4:31 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Very nice, thanks :). I guess move_pages12.c can also use .hugepages,
> right?
>

Hmm, I guess that is a bit different from using .hugepages, it needs
reserve page against each node. But our improvement only target for
test does not care about huge page from which nodes:).

Thanks for your review, pushed!


-- 
Regards,
Li Wang

--000000000000fae99b05e0d2e78a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Jun 7, 2022 at 4:31 AM Petr Vorel &lt=
;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
Reviewed-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_bl=
ank">pvorel@suse.cz</a>&gt;<br>
<br>
Very nice, thanks :). I guess move_pages12.c can also use .hugepages, right=
?<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D=
"font-size:small">Hmm, I guess that is a bit different from using .hugepage=
s, it needs</div><div class=3D"gmail_default" style=3D"font-size:small">res=
erve page against each node. But our improvement only target for</div><div =
class=3D"gmail_default" style=3D"font-size:small">test does not care about =
huge page from which nodes:).</div><br></div><div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">Thanks for your review, pushed!</div></div><d=
iv><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_si=
gnature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></di=
v></div></div>

--000000000000fae99b05e0d2e78a--


--===============1985401271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1985401271==--

