Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F45ECAAD1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 06:15:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADC0B3CA5F7
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 08:15:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4C603C81E1
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 08:15:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 22C8C2001B1
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 08:15:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661840111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E//AO5gPXEOxaj26TZti2lofBUjT72P0hipJ0ICyCMA=;
 b=h+9I43Xy9ulq85hpjN8drfEUnHvBDs8BoxSFaeVSQWig1bu378IN8tRl9/BeoZ0mD4ZVam
 sb+ziDTDxNqqmopgOH2N03gPI1qeKOsEPehzpobhUs4bHPJIUmT4Ez24U8DIEu0awjXGOP
 nskamfOkij+wI2VYcpoX0ZDtHnfWxwc=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-462-ngJNcjOnMmqD25cx6_HlLQ-1; Tue, 30 Aug 2022 02:15:05 -0400
X-MC-Unique: ngJNcjOnMmqD25cx6_HlLQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-337ed9110c2so162624727b3.15
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 23:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=E//AO5gPXEOxaj26TZti2lofBUjT72P0hipJ0ICyCMA=;
 b=cWh6qbhJG7sPG6eMcHEQZLI8hEoW42axzvFrJctg6/VAGxWV5nPqSyUuZll67BQXuk
 vVH04WLdfV2RgC9CavR8Cxlwe6GAugSKbSsYj8QGciraO7Dxs9g1OcHkG1rCK71TXmE7
 wn50jtfb2qU4gJHtfmYyWHQPD5XXKy3y1KlaNArHrlN/agDmf6DBvV+bj2C3NNZRWyBo
 sqrpHp/p5oA/0/gVLQvP72gI9Yx4PhOD0XLzFD7pOPH9B6+YxqPH5QAQGNnwQIwTDXNM
 Sk4ABkeuTzMTg0Oa+seY8EmzzqxIYyJlQZI7Z2sYkYunwC/gm+Xba2pVdv8H8TA872eB
 sCNg==
X-Gm-Message-State: ACgBeo0jeCRuAk0GANv9b4m5KLkoCabqVKECzUi6Y9L5jZ7RWfPspM9z
 vYXvi5X1wNqnJgCgXfOseZofZdTX33uhhJtxTXeXNHfkOZ4mB82GPQD1YfbuMrhPFaQP+UevNV9
 0v5haWdJaMW1NbZL5keRbK6JK4Qc=
X-Received: by 2002:a81:5a84:0:b0:341:4c44:1230 with SMTP id
 o126-20020a815a84000000b003414c441230mr4371922ywb.53.1661840105025; 
 Mon, 29 Aug 2022 23:15:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6fAHAtU+8oxVI7H36YpjSjHRJViiwaIFYyTaXyXI/A4wEwHOi1huD9MyxrrwEFOac3+kmqGmzTwcjQEs91/lw=
X-Received: by 2002:a81:5a84:0:b0:341:4c44:1230 with SMTP id
 o126-20020a815a84000000b003414c441230mr4371909ywb.53.1661840104837; Mon, 29
 Aug 2022 23:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-6-pvorel@suse.cz>
In-Reply-To: <20220827002815.19116-6-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Aug 2022 14:14:54 +0800
Message-ID: <CAEemH2ffTUaVcQ8PpzyOo4D8Bc2PvNOcKHst4FAhVxNx4CSZEA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] tst_device: Add support -f filesystem
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, linux-fsdevel@vger.kernel.org,
 Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============1560755358=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1560755358==
Content-Type: multipart/alternative; boundary="0000000000001f6a8c05e76f4d78"

--0000000000001f6a8c05e76f4d78
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--0000000000001f6a8c05e76f4d78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr"><div class=3D"gmail_default" style=3D"font-size:small">=
Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redhat=
.com</a>&gt;<br></div></div></div><div><br></div>-- <br><div dir=3D"ltr"><d=
iv dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></d=
iv>

--0000000000001f6a8c05e76f4d78--


--===============1560755358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1560755358==--

