Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E93C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 05:39:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87FCE3CA59D
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 07:39:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CAD53CA552
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 07:38:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A3031600671
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 07:38:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657517933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y7tgZCsRwR+Z5yqaORW5p6Z8ecoeIsglI1+xh6eMwxc=;
 b=iqzJwM8UIpJpDYzDXOS16bjYsgFF3fcD+PoYPNWH3off/b5uC6guHOpYyzQ42Ig1UxrOeh
 iXk8xYnhpH8h1yThWijTF1iseHrE09/s+0LeDbAEDTFZjF1oXe3rURFxSYfueyLX4IyE4W
 oImPL2gRheYSbkuDJsxD0Rk35Tojyw0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-IE1zWaz8PFm82fVknkNakw-1; Mon, 11 Jul 2022 01:38:51 -0400
X-MC-Unique: IE1zWaz8PFm82fVknkNakw-1
Received: by mail-yb1-f199.google.com with SMTP id
 u17-20020a258411000000b0066dfb22644eso3043553ybk.6
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 22:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y7tgZCsRwR+Z5yqaORW5p6Z8ecoeIsglI1+xh6eMwxc=;
 b=XOPke+A94OSOAWOHF6e1OEi2QhPn7wRgJe6HPGsxVTVBFxrEUPXnu5HY07bQLLUzCN
 8CuSWTI3FreTmrdR5lsJwN3zDL0asKIYW9qMq7W2KqtWAn2mNpZhynNRLx3BmPjllevj
 7l/Hqzq3jOluK94S4CH5Iwftw+nX6xVM7mkR3e2vH8f1GAb+Fg4todgzemtu/qP9wQx5
 wjjgO2vxa7vRLOnSwheYTG0R1Z3WarnK6e5fJZ+bsJRwGF6XlkgTpg14fXTP0/RUffKJ
 gXO3bw/3ts01X9YLSMKXG/ADOUKPTSvDWf3k9dIhnTwIBOgqjieOB3x/OfKNC56NX9h4
 93Jw==
X-Gm-Message-State: AJIora/0LVebiVKwb7KT+LO8AkXvPekYPzJpvSc8zx5HZrIvNFeQ+JAm
 BBFRiJDEJ+kXOjZ0/WHGr+Ni3IHIX9lOpy7Fe7xQXfoLZgh2uj+fQayegMhEGKIqqwJPQP280Ed
 lhQ58vyfNfU9hSxZkR1xfk5FSMtU=
X-Received: by 2002:a0d:d58c:0:b0:31c:e04f:33e0 with SMTP id
 x134-20020a0dd58c000000b0031ce04f33e0mr18749329ywd.86.1657517930689; 
 Sun, 10 Jul 2022 22:38:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uFbyaOis00SQH++YNKthbjK77mtxMybpwrR1Hy+8cv703mvJ8q01zgJwIckdffSEIT+tJsyaySEJ8LOvzhlPg=
X-Received: by 2002:a0d:d58c:0:b0:31c:e04f:33e0 with SMTP id
 x134-20020a0dd58c000000b0031ce04f33e0mr18749318ywd.86.1657517930480; Sun, 10
 Jul 2022 22:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <1657277348-2169-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1657277348-2169-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 11 Jul 2022 13:38:39 +0800
Message-ID: <CAEemH2c1n2FEykXXuCthxENcRN1_R0ZahF3YVOviCJCW-yP3FA@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_cgroup: Fix typo
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
Content-Type: multipart/mixed; boundary="===============0110691722=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0110691722==
Content-Type: multipart/alternative; boundary="00000000000074a29305e380f780"

--00000000000074a29305e380f780
Content-Type: text/plain; charset="UTF-8"

Pushed, thanks!


-- 
Regards,
Li Wang

--00000000000074a29305e380f780
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Pushed, thanks!</div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr"><br></div></div>-- <br><div dir=3D"ltr" =
class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li W=
ang<br></div></div></div></div>

--00000000000074a29305e380f780--


--===============0110691722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0110691722==--

