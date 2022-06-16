Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA19C43334
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 06:00:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C8F33C55A0
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 08:00:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 311E83C29F6
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 08:00:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6385E1A01107
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 08:00:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655359201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WUvc4b6z4hnq97MXdeFrlecUTdWs4eZ5vZM7biKW4Js=;
 b=E+KX0BlDJJU152clVScoy/bMpMFdH2j0sluA7jp5UD4zWjvgbyba71muQOXC2Dpqt+qk9K
 GmG25xEtpXjqAn0FRU8EwKARA/Iab63dsQtu074dzypX7ZrtHRD7xqrl/JsxJdFq2+A5k0
 1tgz+aULtXzhRSQaiRoKNArQ7TCgUKk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-MfO4t1BGMh-M__9ed1kkkA-1; Thu, 16 Jun 2022 01:59:59 -0400
X-MC-Unique: MfO4t1BGMh-M__9ed1kkkA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-313bc9c54acso4767007b3.4
 for <ltp@lists.linux.it>; Wed, 15 Jun 2022 22:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WUvc4b6z4hnq97MXdeFrlecUTdWs4eZ5vZM7biKW4Js=;
 b=bMr047ECQzDSFocnX28eLDhai5FGwcHSQTxJWuGdGSvrW9LZaAKpxdrnWq1LQk99+o
 dIXq2FyIJyPbqHrTgYrvRLnGf6uRBPvsK0GvNWaWdlFfZux6GY4ZeY98CYDoEsXdZ6QO
 VEIW9UfjCvR7QD9IJQVfnknuTVJ0YPxcD82Aq+eGUFyAz13HDEAI7WMQtWsMlaNA/ava
 sJvjRpnartl5riKwXaIwsy2FCvlug/3V3vXTWhtt9BITbgjnL//rBEWBlidvdDolVqJB
 dZFeB3YJaCVnTZIQ20qE39aMMCx8RRbyqSU38TwcBu6QRnOpiaBUriBIgUA0geoEIdQl
 P1Pg==
X-Gm-Message-State: AJIora8Tzs6aye0WeBpafR+fp9laYoLS5hUyRxM4URNVS4mchaGMI9qr
 j0s9muGTERDO3buBgtmmdOt3yhH5a5SNPePb8/l1wyM2zMmq1b+iW1egUDBl/vI5Q9RggTKXRO+
 Rp8gQCPDwfzlrKGSEhDz+n4cUOLQ=
X-Received: by 2002:a81:a0d:0:b0:30c:2422:7931 with SMTP id
 13-20020a810a0d000000b0030c24227931mr3774607ywk.53.1655359199372; 
 Wed, 15 Jun 2022 22:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vcqsV9n0SB7VHfYIReXK3RJlBqDqROT5ik8KQKU5GzZmJ7lhWoz5FwUwpq3x1sK33AgpuADcyKZs7c0C1hiAM=
X-Received: by 2002:a81:a0d:0:b0:30c:2422:7931 with SMTP id
 13-20020a810a0d000000b0030c24227931mr3774578ywk.53.1655359199013; Wed, 15 Jun
 2022 22:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220609214223.4608-1-pvorel@suse.cz>
 <20220609214223.4608-9-pvorel@suse.cz>
In-Reply-To: <20220609214223.4608-9-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Jun 2022 13:59:48 +0800
Message-ID: <CAEemH2fk6XwBiXd6woNW-FE7_5=BqMv-Y=XS1J3erw3tWicf8w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 8/9] shell: Add test for TST_ALL_FILESYSTEMS=1
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
Cc: linux-nfs@vger.kernel.org, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0816322892=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0816322892==
Content-Type: multipart/alternative; boundary="00000000000008842e05e18a59ff"

--00000000000008842e05e18a59ff
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

Nice work! For patches 1/9~8/9:

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--00000000000008842e05e18a59ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr,</div><div class=3D"gmail_default" style=3D"font-size=
:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Ni=
ce work! For patches 1/9~8/9:</div><div class=3D"gmail_default" style=3D"fo=
nt-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sm=
all">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=
=3D"_blank">liwang@redhat.com</a>&gt;<br></div></div><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr"><br></div></div>-- <br><div dir=
=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></di=
v></div></div>

--00000000000008842e05e18a59ff--


--===============0816322892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0816322892==--

