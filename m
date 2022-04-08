Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E715C433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 02:57:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC4B03CA4FD
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 04:57:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61CF33CA488
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 04:57:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7D42A200047
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 04:57:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649386622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y2mOtEFnHAmT9r6+akt8bPjyzwr57Qn4DtEaGLS0pCE=;
 b=FJUNvH0rIZMOv11VdlDGZIU01gOPAHOgDtOhYaNckpEsfEVGeFZN/P84iySNaRDBrZKCz2
 /09fMkSyC8htZFIgK8dP37ifaCSBfXOkJgxfl+2tkbjqVSqEQu9zsMxszEZsZT8r5IkZtq
 SUvTMBXa8xzj36c+Sz3Lq3jkJNF47F0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-WN8c5jK0Mz2igdSliOyHQw-1; Thu, 07 Apr 2022 22:56:59 -0400
X-MC-Unique: WN8c5jK0Mz2igdSliOyHQw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-2dc7bdd666fso64711977b3.7
 for <ltp@lists.linux.it>; Thu, 07 Apr 2022 19:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y2mOtEFnHAmT9r6+akt8bPjyzwr57Qn4DtEaGLS0pCE=;
 b=2I5VmpRs53j9zwwlXWpq5sgq3K3fuHxTx7VprtaeVsV5kK4rwKMQtV2Ow0xLs44vPZ
 N5+ITctUbQmB+gVp5IKx12kkI7V1Z9XefEIFqMV0Czkd+S6Urxk8ydmU/ScUaN2et/O0
 R/01DbVQ+JRL78Q3p4zpxY5K56eOeN25NKtcunx8ZeJ8tPcgxxxafY5MPNyv6PgKhI2k
 BR5a67e77cpQcg4qFushbKoinX/cE2wj/ej6wS7LIIt5ysNbDItyVg5avfqfxx3/4db5
 iFtTzPy2jZXjTj1oJ/FRbtIuisaB3DYiGTgg8PYM3DNwYszD0PcMH2nnFwQI31WBLY5n
 N82w==
X-Gm-Message-State: AOAM530Ecg9958IH502vkoSmEa38nCu0cJ1nkFJALQWz0rbd4Zhzh3gi
 Qr9IgEZmQUXOCcZmhoL4X+F35dhc9paHWMsay9wn8P67KiU5W14v1wc6nv9vqyTjLqZ/msfNAg2
 lURnZOzf9HC6rVnloN2Nefv7W8oc=
X-Received: by 2002:a81:6e84:0:b0:2eb:99b6:6b80 with SMTP id
 j126-20020a816e84000000b002eb99b66b80mr14418612ywc.170.1649386618898; 
 Thu, 07 Apr 2022 19:56:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybRuqMSNywe+JDFGhi0jZx1ilpH6zTT37MzhKxe7hfCWzyxAK2rycr/rL0+nEfb1O7Hqyl6LBVDERKXwALyxQ=
X-Received: by 2002:a81:6e84:0:b0:2eb:99b6:6b80 with SMTP id
 j126-20020a816e84000000b002eb99b66b80mr14418602ywc.170.1649386618636; Thu, 07
 Apr 2022 19:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220406193650.15653-1-pvorel@suse.cz>
In-Reply-To: <20220406193650.15653-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 8 Apr 2022 10:56:44 +0800
Message-ID: <CAEemH2cN9EiOmcFq3wRDYcQzguduq_PUiqwiTKJ7UXEX51w8AA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] Remove syslog shell tests
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
Content-Type: multipart/mixed; boundary="===============0659164003=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0659164003==
Content-Type: multipart/alternative; boundary="00000000000080616d05dc1bbff8"

--00000000000080616d05dc1bbff8
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 7, 2022 at 3:37 AM Petr Vorel <pvorel@suse.cz> wrote:

> They always had sporadic failures that were related to configuration
> (rsyslog config, journald rate-limiting, etc.) and lot of sleep to
> restart daemon dozens of times.
>
> + there are tests which cover syslog() syscall (kmsg01.c, syslog11.c,
>   syslog12.c)
>


Agreed, as we have some covered it's fine to remove these outdated tests.
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--00000000000080616d05dc1bbff8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Apr 7, 2022 at 3:37 AM Petr Vorel &lt;<a hr=
ef=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">They always had sporadic failure=
s that were related to configuration<br>
(rsyslog config, journald rate-limiting, etc.) and lot of sleep to<br>
restart daemon dozens of times.<br>
<br>
+ there are tests which cover syslog() syscall (kmsg01.c, syslog11.c,<br>
=C2=A0 syslog12.c)<br></blockquote><div><br></div><div><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">Agreed, as we have some covere=
d it&#39;s fine to remove these outdated tests.</div><div class=3D"gmail_de=
fault" style=3D"font-size:small"></div></div><div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:li=
wang@redhat.com">liwang@redhat.com</a>&gt;</div><div class=3D"gmail_default=
" style=3D"font-size:small"></div><br></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<b=
r></div></div></div></div>

--00000000000080616d05dc1bbff8--


--===============0659164003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0659164003==--

