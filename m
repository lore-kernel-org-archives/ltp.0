Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEFDC433EF
	for <ltp@archiver.kernel.org>; Fri, 26 Nov 2021 03:25:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 887FF3C0480
	for <ltp@archiver.kernel.org>; Fri, 26 Nov 2021 04:25:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A98903C0428
 for <ltp@lists.linux.it>; Fri, 26 Nov 2021 04:25:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 839231A014BA
 for <ltp@lists.linux.it>; Fri, 26 Nov 2021 04:25:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637897138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I004XHM5g83/2F3IHmo77mTUWiZiU7UsadKoSzwttgM=;
 b=PNajC0cnlyF5pWBNGSZtZ4xWw7lXjzlJAuYtkm/cxXbZvCQ74IxYHn81MgevI1j1M+iZk2
 Jid3y6PX8dFUAVy9yHdbyjSkNPdXDsBOQ4mK+3b40TesJI+xgzCAZuxlSqahV/g2yAOKik
 OputOJhlQHUPN90gn1FqClGG2NnzGMI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-jpoqsDD7P9S3ZGzRCcEjxQ-1; Thu, 25 Nov 2021 22:25:36 -0500
X-MC-Unique: jpoqsDD7P9S3ZGzRCcEjxQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 t24-20020a252d18000000b005c225ae9e16so8874015ybt.15
 for <ltp@lists.linux.it>; Thu, 25 Nov 2021 19:25:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I004XHM5g83/2F3IHmo77mTUWiZiU7UsadKoSzwttgM=;
 b=wluyRY3e4+cTgVP6GgcgeKt2PmNKGth2zCUYNcNkYfbCof/lAcyOdoaWMqSmskxZEt
 Wk5Bc761PR5itBcLI6UoAU/TxAk0br42LNwhXv3RS/4cjjm6SReq1Xve8aowUKFk565t
 Gfv8szKDy4RJrfDWCimCMAzfYB8/IGjTZFV0UhQ0vv/B3FqApFDgmJeJ0+jMZUAUp4g7
 QkKPFw8yuP05yHyxPig8UXtNorDhC+bdsWgdQh9gsLsDxbRNJaZfvQwZQ7gpz19WoXF4
 PDr5UJ8H8Rrmw/8PZdpI3/0oCFbYJS4oJv3w70lf6Sx7GN0uZBnLSe+kkjC2Put4DvNr
 NnUA==
X-Gm-Message-State: AOAM533O6XTQ82IlLbodCHlegBAg8b0cID7lPv9mR+QNys+huZFlChVR
 MmNoEl6g4QNqgi48dUmD5+Jzr+9sbaqza3i1Xhoc7lTAEZoJW9aqUvBMGPPK9n4GBJPejrY5mZH
 2b11rdillMBPhx+VPZxzTDhB/buE=
X-Received: by 2002:a25:82:: with SMTP id 124mr11898791yba.490.1637897136123; 
 Thu, 25 Nov 2021 19:25:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9muJShsdIiJ8QWgJH/hSDTY8L8mBaTtXVudvSQ0foLNxtMcojocSuC4Mmh2fH12LNcIOYiwrrVU6ajQbAJ7s=
X-Received: by 2002:a25:82:: with SMTP id 124mr11898774yba.490.1637897135895; 
 Thu, 25 Nov 2021 19:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20211125064700.90843-1-threefifteen.wangkunfeng@huawei.com>
In-Reply-To: <20211125064700.90843-1-threefifteen.wangkunfeng@huawei.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 26 Nov 2021 11:25:23 +0800
Message-ID: <CAEemH2f3f9sTcvUN0fDXwMjnmB5azMVV_usAJGmPjh+A5mSDbQ@mail.gmail.com>
To: Wang Kunfeng <threefifteen.wangkunfeng@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] acpi/ltp_acpi_cmds: Add kfree() and ACPI_FREE()
 to resolve memory leaks
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
Content-Type: multipart/mixed; boundary="===============2051352287=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2051352287==
Content-Type: multipart/alternative; boundary="000000000000f6cad405d1a8a474"

--000000000000f6cad405d1a8a474
Content-Type: text/plain; charset="UTF-8"

Hi Kunfeng,

Patch applied, plz remember to add "Signed-off-by:" tag in preparing patch
next time.

e.g   `git commit -sm`

-- 
Regards,
Li Wang

--000000000000f6cad405d1a8a474
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Kunfeng,</div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"=
>Patch applied, plz remember to add &quot;Signed-off-by:&quot; tag in prepa=
ring patch next time.</div><div class=3D"gmail_default" style=3D"font-size:=
small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">e.g=
=C2=A0 =C2=A0`git commit -sm`</div></div><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr"><br></div></div>-- <br><div dir=3D"ltr" clas=
s=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<=
br></div></div></div></div>

--000000000000f6cad405d1a8a474--


--===============2051352287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2051352287==--

