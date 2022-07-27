Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A86C04A68
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 06:34:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AC3D3C305A
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 08:34:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31DF33C05D5
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 08:34:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4064A6006F6
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 08:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658903672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J6V6klK55hVAghyTStwp0iK9rPUfOeQtpsJWkV8Hx0Y=;
 b=gGmjeeTemkvLJNscBBV24QPHtpFzluRqiqd08ClzB0ppvKR/FgFMIpSJhEvigGciQbg17Q
 bfWwTiJ3eijsePKs/zm9sojUBa6dRETG0sZQqq7jxhxLILEOStLo0F2ip7U/+lkqJs2Mnv
 U12ikzLGhORkW7GufLw49aXGrQ2gGwY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-qaCiSIgnMzy_kFIFZkMW2A-1; Wed, 27 Jul 2022 02:34:31 -0400
X-MC-Unique: qaCiSIgnMzy_kFIFZkMW2A-1
Received: by mail-yb1-f200.google.com with SMTP id
 j11-20020a05690212cb00b006454988d225so12871962ybu.10
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 23:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J6V6klK55hVAghyTStwp0iK9rPUfOeQtpsJWkV8Hx0Y=;
 b=JyMH4CIE5didHCjVoUKaAbkbVeTFOXHJ9rCSrPj1Lrzp3/1chW1rgMlzNhRg4nc5/+
 f+CurrjlVtbQb1yKpKldqCMH12lmCkKq8FLb1MCzAA/MDUU+PoUrGklzhSq6jFyqhyvF
 8IYoH2ria7wdU8qm9l+TUEUraXqIoaUIGjm6lbwGCX+fmQ833Q9fjBGfsfO48rRXJY2j
 LbL6cCdI6l3WgCFFRvAAcZ8PPFkOmYbExoBnjWSq+f5uDeEAnOSe9lgXj3lRwOl1B8Rq
 9l3KiorAR8/ca4qM6pJY4Ek6y1TXsKKEWHquDaSPxXaicxjyWthw46QN2Ei8X7j8w+ZB
 nUGQ==
X-Gm-Message-State: AJIora99p70cNB1z5isljqbXTJyTc+hsFY1nEN4D3vAm9xQq2drfq7cS
 3hhS6kxcXKzYAFYuNChL11cbkxe2Vk7LwE+VuBqek4wF8GHZB4/komIdLTHZwk81s0t0DS2O2Mp
 cbc9JCkG+JALwWnP/RGpZmlYFlpc=
X-Received: by 2002:a25:bf86:0:b0:671:3607:1381 with SMTP id
 l6-20020a25bf86000000b0067136071381mr11192472ybk.355.1658903670278; 
 Tue, 26 Jul 2022 23:34:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uLcL5PujX7qgh3t0TNGnYhwK9Mk/5bk4rFtoNWVtupmQx4KQ9KehLCvXIUqyz8YbSIt5LLxH8kaNUmp9ck5Ic=
X-Received: by 2002:a25:bf86:0:b0:671:3607:1381 with SMTP id
 l6-20020a25bf86000000b0067136071381mr11192468ybk.355.1658903670106; Tue, 26
 Jul 2022 23:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Jul 2022 14:34:18 +0800
Message-ID: <CAEemH2fG_zv2gPhzXUnC45sWr+N87-Kzjyd3Xbx-J2qMR4PdKA@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 00/10] Expand cgroup_lib shell library
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
Content-Type: multipart/mixed; boundary="===============1662161980=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1662161980==
Content-Type: multipart/alternative; boundary="000000000000f9467a05e4c39b27"

--000000000000f9467a05e4c39b27
Content-Type: text/plain; charset="UTF-8"

Hi Petr and all,

I agree with all the changes in V6, pretty good.
Feel free to add my Reviewed-by when you do merge.

-- 
Regards,
Li Wang

--000000000000f9467a05e4c39b27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr and all,</div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">I agree with all the changes in V6, pretty good.</div><div class=3D"g=
mail_default" style=3D"font-size:small">Feel free to add my Reviewed-by whe=
n you do merge.</div></div><div><br></div>-- <br><div dir=3D"ltr"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000f9467a05e4c39b27--


--===============1662161980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1662161980==--

