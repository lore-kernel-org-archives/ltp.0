Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4297CCA47C
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 08:27:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A58E53C952F
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 10:27:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 418703C071A
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:27:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3BFD0200ACF
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:27:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655972834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lz7mr2V/7c3Juhxs5JNUR4vQ7JC8Wx4U8OuqU3TkBGc=;
 b=hT6sqwOkfoHcCe0VN+GRw8SZp7l5yv3UN1/c4HR2a5c33MNC7rGik76WExOP6Bd0dXjTjn
 nhPgdZv9cOMtuBJk95y9TwkIxk59RaEXTSKQG+SJHggPFBYSEX00UPPOpCLzS6MzZS3GJG
 6dK0lCfwA0f+ZqjvAQzSLkipW/QGC6Q=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-8SaiAL-CNP-DAu2LTciwCg-1; Thu, 23 Jun 2022 04:27:13 -0400
X-MC-Unique: 8SaiAL-CNP-DAu2LTciwCg-1
Received: by mail-yb1-f198.google.com with SMTP id
 l6-20020a25bf86000000b00668c915a3f2so13434796ybk.4
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 01:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lz7mr2V/7c3Juhxs5JNUR4vQ7JC8Wx4U8OuqU3TkBGc=;
 b=0oJR1Rx5WtheVRD0SyzvlxHe1YVmIEFboVYeAz+7zJwHnF1Aq3BeDFjnIai6WRGK1r
 YS4PhwSj7U8F/k2sa9AY/kmCUHQIlDs79UPFMhRoRz60tkClB1xK9q9iPWqcUxL2ZI2K
 XH82Zt/4eQ6ux/PzVvLJBQbboGo3dU4LwnT3IT8UBWo2bzn3duJ6tLwvhv01ezw7r0fV
 pR5Q0EI42ysX4sZXdG4sYVt++BIuW9/dUj8VJdC4ez+SxNiH8khZYd5aaEVt+ClF7dXW
 +ueKbnCVOH71qPl2VSWSgVqGGV41oQyvLO2ddUhRyo7lGn869ZcPgmnn7rhpB/aKki1/
 zdWA==
X-Gm-Message-State: AJIora8fs82mJDDzVhwESIffaAfHkoAz2lG35qeXMEseA0PlAGuwf/4n
 TRrpkL+ufEmZXl2G5YiCg+Mi3rXWT2wlVXYLoqFSNtuinfb/mMBUS6alzZCpmX/DSUBT/R0UiyK
 J/n2+AykxWvvKkRLvmJ0KNQqP1VU=
X-Received: by 2002:a0d:c585:0:b0:317:f0d6:1d8 with SMTP id
 h127-20020a0dc585000000b00317f0d601d8mr9375961ywd.86.1655972832671; 
 Thu, 23 Jun 2022 01:27:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t0LPUWo5sEyzkDyHCMp9wceq9Lt0ih9LGZiGuteJg1wTlTK3aoDqKz10WPdkmazVUYxN7FK7kE6pB0kOIxxxU=
X-Received: by 2002:a0d:c585:0:b0:317:f0d6:1d8 with SMTP id
 h127-20020a0dc585000000b00317f0d601d8mr9375949ywd.86.1655972832445; Thu, 23
 Jun 2022 01:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <e942179576028d20ad2c381d442fefec1af6a556.1655797247.git.jstancek@redhat.com>
 <YrGWaXzqNyS4TZOL@yuki>
In-Reply-To: <YrGWaXzqNyS4TZOL@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Jun 2022 16:27:01 +0800
Message-ID: <CAEemH2cit9OOSvQ5wv0oMB5yOgEjC6Qnf1qLwKpTnDgvXGcp0w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/utime03: print more details when test
 fails
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
Content-Type: multipart/mixed; boundary="===============1253374242=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1253374242==
Content-Type: multipart/alternative; boundary="0000000000006f9f6005e2193875"

--0000000000006f9f6005e2193875
Content-Type: text/plain; charset="UTF-8"

Applied, let's see how that show in next.

Thanks!

-- 
Regards,
Li Wang

--0000000000006f9f6005e2193875
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Applied, let&#39;s see how that show in next.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">Thanks!</div></div><div><br></div>-- <br=
><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<=
br></div><div>Li Wang<br></div></div></div></div>

--0000000000006f9f6005e2193875--


--===============1253374242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1253374242==--

