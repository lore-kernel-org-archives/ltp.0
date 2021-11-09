Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1501C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 12:02:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C767560F58
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 12:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C767560F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA2D93C0CAF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 13:02:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59AE03C0797
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 13:02:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 99BD51401153
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 13:02:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636459349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1yyiD4GVLNuNyLNd1G84DdIp0zRh+5ZjjeZ5OUsq5oo=;
 b=D9PBmezVU/xLauzrbzJz8V9AfLDNFreo2cIPCKK7xclTkEfHDY4yFpH2nMVcr7Q46GRGev
 Mrw16il0+kl7fvpnXk/IdIAqdqNh95RvgKNjHUU7TntVSx7hSTZLCrLvX2oa1MKajoq/S9
 FP5Pl0+cdUD0O43jCKRmOThFgth7hE8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-FNJn4fIjOGS44WMW4ZHqdQ-1; Tue, 09 Nov 2021 07:02:27 -0500
X-MC-Unique: FNJn4fIjOGS44WMW4ZHqdQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 z2-20020a254c02000000b005b68ef4fe24so30074958yba.11
 for <ltp@lists.linux.it>; Tue, 09 Nov 2021 04:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1yyiD4GVLNuNyLNd1G84DdIp0zRh+5ZjjeZ5OUsq5oo=;
 b=U8qdDkc7cUy9YXm1LPgjY3D6TvyqSzeENo/MBFOI+Yd+G0qRsTylpf7FnOyMtibsfI
 40cPv39TLmmXq6YQ7zND0Ltm2jlnFhxRwVTiDuc0EbEaRrGAJuOdHVMGkCKbFjzOE4PK
 AIKrTF66C54yOCWOWx/ucaN2OevuIxN9VAW8+AluROYS36dhe/ZM4gT+H6yr7nEKHmID
 NnYeafyYAed+xAz2PejCWv9XyFAzax2nvy9q9mtklcReh7BNwdFwMAnX5C2bG3KWML7E
 9BjR6+OdL6xoSFHyjRV7WunNk0nBUU3V+9G55wzHWQ4RdcNyVZ8X7KrSEIc8tuyG9wA9
 JBTQ==
X-Gm-Message-State: AOAM530kPxCNNjPyZAPo6NFnbIlrqDSfvrFcuhFbqUtQkUPKw83+l+NI
 ugfen2scSTsMptrAFUVy4YISBO2aL4URv05Qv/Kf/QYFU+0+oPDXD5O/E3WNCdywqi78cq4HhIo
 d470NjuoQtd+7Be1CqUHJwt6gqy8=
X-Received: by 2002:a25:2157:: with SMTP id h84mr7873843ybh.425.1636459347199; 
 Tue, 09 Nov 2021 04:02:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxo0SqF8SCNo9SK0QPr04DDZEb6zw94ZN1uxsW+gJ93XrmotNdLR6FdGuC1YnYowyk7btYLQ1eVb+X53gvhewU=
X-Received: by 2002:a25:2157:: with SMTP id h84mr7873814ybh.425.1636459346992; 
 Tue, 09 Nov 2021 04:02:26 -0800 (PST)
MIME-Version: 1.0
References: <a3b6f022fac7447b9ee9a840c0ee212b@huawei.com>
 <YYpOjGf64R9EcIVK@yuki>
In-Reply-To: <YYpOjGf64R9EcIVK@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Nov 2021 20:02:15 +0800
Message-ID: <CAEemH2c0AbbU5-OjrWaznKwVBaxhr23tMFp_MN2TqVO9yHAp-g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_test.c: add *cleanup() before exit
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1279007147=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1279007147==
Content-Type: multipart/alternative; boundary="00000000000011396e05d059e225"

--00000000000011396e05d059e225
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 9, 2021 at 6:32 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > If we run the LTP testcases Concurrently, this might trigger the oom
> > killer to kill the library process before the main process exit, and
> > it might fill up the tmpfs through a long time running.
>
> Then I guess we may as well adjust the oom_score for the test library
> process so that it's less likely to end up being killed.
>

+1

And we have to guarantee that oom_score doesn't be
inherited by any test case. Otherwise, it will break our
OOM tests.

-- 
Regards,
Li Wang

--00000000000011396e05d059e225
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Nov 9, 2021 at 6:32 PM Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; If we run the LTP testcases Concurrently, this might trigger the oom<b=
r>
&gt; killer to kill the library process before the main process exit, and<b=
r>
&gt; it might fill up the tmpfs through a long time running.<br>
<br>
Then I guess we may as well adjust the oom_score for the test library<br>
process so that it&#39;s less likely to end up being killed.<br></blockquot=
e><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small=
">+1=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:small"><br>=
</div><div class=3D"gmail_default" style=3D"font-size:small">And we have to=
 guarantee that oom_score doesn&#39;t be</div><div class=3D"gmail_default" =
style=3D"font-size:small">inherited by any test case. Otherwise, it will br=
eak our</div></div><div class=3D"gmail_default" style=3D"font-size:small">O=
OM tests.</div></div><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr=
"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000011396e05d059e225--


--===============1279007147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1279007147==--

