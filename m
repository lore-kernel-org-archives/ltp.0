Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D294C433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 08:14:11 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55ADA60E9C
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 08:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55ADA60E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D32613C712D
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 09:14:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 608A83C6A71
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 09:13:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 10B3A600435
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 09:13:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635840835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PsVg1BAjR+Plcx0cm6vANzDFVySqHEBfYdDTWuZwIOw=;
 b=MgK8EXlOeKtgeZOOdNuRZxPT/n9h/vKc7HZn4gfBoYrI+sTSVw7HyzYaLFbWTiEIT2zjFy
 TuZqmF0A8PtpDAIJebAAKrpgUKucnXQ2zUOdWpFImJ10E3piLneRS/uPQ/frEGIaPo1kr7
 m5xsTH3cUtQw0TohSd5jSEAi8Iq2vCM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-AQuw8STTMx2d2VgSkrde9A-1; Tue, 02 Nov 2021 04:13:53 -0400
X-MC-Unique: AQuw8STTMx2d2VgSkrde9A-1
Received: by mail-yb1-f199.google.com with SMTP id
 l28-20020a25b31c000000b005c27dd4987bso2447403ybj.18
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 01:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PsVg1BAjR+Plcx0cm6vANzDFVySqHEBfYdDTWuZwIOw=;
 b=I5YhshTP9KTCtLaspzhLZwYjsw3krO7ZQ58eHpaG1E97oMOPnwGd3ZCFgpQYxKJKDD
 b/dbMciD7lGqcev017HRCTlWTprXuuiweR0xQgtZUHJxf4ggf8YMWgxtu53lAYY3qsD+
 +N4TCkXRd+rPzErsaSs6AKAgnyFzSlbwHEzQsL4tBucsvFNr64dfQmwHdUWoR0SXDMt1
 oQbTYeb4POj8NGuVodUwPZ+fGPY9bxZ0XidvZ151ABg5FsS25ush8MILwNKLMeWaf5NU
 AcenBTAAHjrcYCTkmRuXf6QjXjbLWVPBSDUqESvwZbWqGi3mKmDd6yl+HBtUqmhb+EQn
 HP2w==
X-Gm-Message-State: AOAM5335Il8AIxw0AE4bdVoohkp6L3wkeQ1Trk9mgZzhjIH5j5Sb7kOs
 mZmhl5F+gaI/2bbXDJDG0g3+8aAklBGMmaV1HDtLNquwHdluQBMJxKGLJ9DV6JOKpiNeOKQ5KSP
 Teh0OHDTPT/GmnGDrHlPUGdZ4cRI=
X-Received: by 2002:a05:6902:1543:: with SMTP id
 r3mr13933159ybu.166.1635840833237; 
 Tue, 02 Nov 2021 01:13:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfhsdqhhkeajreJzq06VA8ydYJy11GB13pTFaniSYgkaJ3QCsnBK0KpG1JZb3fIQ8Ku9J266FGiFvzlOMHnfw=
X-Received: by 2002:a05:6902:1543:: with SMTP id
 r3mr13933122ybu.166.1635840832921; 
 Tue, 02 Nov 2021 01:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211102003859.2283-1-tangmeng@uniontech.com>
In-Reply-To: <20211102003859.2283-1-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Nov 2021 16:13:41 +0800
Message-ID: <CAEemH2coWuno30JUb7ZuFnvYcCb0bvDTZc1yuNw1e2NJXod31A@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] dup/dup04: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============1382118014=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1382118014==
Content-Type: multipart/alternative; boundary="000000000000c1784805cfc9df76"

--000000000000c1784805cfc9df76
Content-Type: text/plain; charset="UTF-8"

Patchset applied, thanks for your work.

-- 
Regards,
Li Wang

--000000000000c1784805cfc9df76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Patchset applied, thanks for your work.</div></div><div><br><=
/div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><di=
v>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000c1784805cfc9df76--


--===============1382118014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1382118014==--

