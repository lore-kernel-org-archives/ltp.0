Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422AEC433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 07:44:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF0373C9AD8
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 08:43:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A6943C951F
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 08:43:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 514EF1A01134
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 08:43:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643960625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1KUhNkInJ2TdCtdJ+UtY3PD5pI0dka415SdcfatXhB4=;
 b=FDb7C5CzgUxZCPj08paVrxygw3hsIuExa6uivEFsyfM1PLO3mKcgN/DlZABWQJ4ORTOFAm
 vUCqONkqsWPC0yqbNSteNprjZTvDEgkQtHi4ue57qrruVFum7t28SV/6E1ng0Aqnzkav4B
 n8C8VebcPMj9aYs721YgF8YcHZzZuuU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-upds3XSrPIC4QlDK4c5-XA-1; Fri, 04 Feb 2022 02:42:30 -0500
X-MC-Unique: upds3XSrPIC4QlDK4c5-XA-1
Received: by mail-yb1-f198.google.com with SMTP id
 127-20020a250f85000000b00611ab6484abso11216237ybp.23
 for <ltp@lists.linux.it>; Thu, 03 Feb 2022 23:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1KUhNkInJ2TdCtdJ+UtY3PD5pI0dka415SdcfatXhB4=;
 b=zMBzJTzxYMfNfIuX4Bhrd/+ARiYEVsgEA/Ned2aPzOFvFDpMrE+f4IULHxc57KReNU
 7dKCWbGpntD0dJkXyfGIdctYuIqUiT43+rCvTqPzVWvVlFppfLOdF8oTS/ALIpE/jGeY
 PMeKVJD4FO35MRW2A/Kdd2GPWaNvXRVDo2w6AzMbo+hNVrG2+4F49gjAjeLXJ2GX34UZ
 eJJG1xKm6kBXoyI5xjuRJwy0SROL+qcXkBG8kY47/lpdgNoRXtDGFIzIkCz1fuLi816c
 5gkUg3AGIeVyAkENBN2MOCq0ctiMfVdAyIzatW8h/y3phN26QpLK9m+szqxUa5P8wKEK
 9JcQ==
X-Gm-Message-State: AOAM532kfCmlRiQzSUYsHwi1ixk7UbRa+9YeQyZoO1nxkZEPRPDgsU0u
 eFZJgxINnDuMt4zGVEKEJeHGjfkRki0AbQjEjb+r3Chs6jZghakcmlXg9eUYXExqeWE89ThGx4N
 mqyJtcpLyQ40EDgSbxBFeGiQgmV8=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr1699600ybp.71.1643960550021;
 Thu, 03 Feb 2022 23:42:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzXo5GrZYjOnemM1VCpWXeVu7SUGHOkbex/XOBbJVTGYF8BbjdhpHNjWyECRmjyU7PxsZVQJgTabEcAThOf9I=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr1699591ybp.71.1643960549835;
 Thu, 03 Feb 2022 23:42:29 -0800 (PST)
MIME-Version: 1.0
References: <20220203081820.29521-1-rpalethorpe@suse.com>
 <20220203081820.29521-2-rpalethorpe@suse.com>
In-Reply-To: <20220203081820.29521-2-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 4 Feb 2022 15:42:15 +0800
Message-ID: <CAEemH2fcnYQh6jgP6LaVCTOtgWqKa4pwfepmjQ9PGpqUWc3LLA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] memcontrol: Lift out some common
 definitions into a shared header
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
Content-Type: multipart/mixed; boundary="===============1057166899=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1057166899==
Content-Type: multipart/alternative; boundary="00000000000099203c05d72c641d"

--00000000000099203c05d72c641d
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--00000000000099203c05d72c641d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com"=
>liwang@redhat.com</a>&gt;<br></div></div><div><br></div>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><di=
v>Li Wang<br></div></div></div></div>

--00000000000099203c05d72c641d--


--===============1057166899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1057166899==--

