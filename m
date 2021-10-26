Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75522C433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 06:17:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8E360FD7
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 06:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE8E360FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 097C13C6751
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 08:17:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DE5A3C66D9
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 08:16:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9BF151A01159
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 08:16:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635229016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BVzuULm7rT1LENwyIEx0PbIabU7Qzb3L1F8S7DKaHqg=;
 b=TfmpeO78v50Dw9riflN+aNaEn5NT7w16urAkgpUJ+EOMNUH9W0XNKRoHIDe0i+DGyVvLER
 pWyyiVBpqv3d2rA7ElWA0eWZpEtHmplMz0pgJv0iskOnpeivPWLcqVFg8FIIQ78D0kL/pC
 0dRzvXYdE6RcSS4f9l9OnKRMEubKbzQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-wxvS_IUHPWOGub7bNIQjxg-1; Tue, 26 Oct 2021 02:16:54 -0400
X-MC-Unique: wxvS_IUHPWOGub7bNIQjxg-1
Received: by mail-yb1-f200.google.com with SMTP id
 r67-20020a252b46000000b005bea12c4befso20889831ybr.19
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 23:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BVzuULm7rT1LENwyIEx0PbIabU7Qzb3L1F8S7DKaHqg=;
 b=mXOpAWuw/8ACFrINj3GMsTrgBjxZjENND6Xd1sRJr9jDR+2bj3Ksd9xH9R0ReDx/2S
 IOMrKgx/WHR+pBYAAEbq5Jb8kp+VW8bNO/ui1WC39yUsqVEBtwr0A3KS19vyWlif/WaI
 h7pdUjPU2Zc/B2vURtng3YUi+zdZb+51ZAxd1Cr4FTT2lZ6QRjZceLyazwC34wqKRSuT
 twdFNPtmgV44PJVxaQN8Sdn5QUqiIAbBbiDbLWoY+jBp9kmZMutkqD7Q7GmYf/vZ9xcT
 mUd7VlTAWRSwQEyEaH0vqdcIR/BiLrTWqchlIImxmBfEJVXiH7dSQwHZwF59nDszm0pd
 Madw==
X-Gm-Message-State: AOAM532QdvhweGIALj7QyKbPAyfxGKIusYmcyK4BFSGtShlO3c5MDQEn
 XBIRsfHoSfDIvSwKp17KyVlqg6qGKsG58SrNGw+YY3FHqb3q7ZlmbAAM9nT/GKwZrd53C6JzOIb
 MWs2K9upv1OOgA+77q/osYLMwSuk=
X-Received: by 2002:a25:e4c7:: with SMTP id
 b190mr21430695ybh.302.1635229014092; 
 Mon, 25 Oct 2021 23:16:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8HM54aBhFJfX9ZJyNTrsxkbsA7e4VVCzZsGTXDjlLhdjUdlD4EXX4D/fBGh5UdpkBPdm7cMEMCm/ilF2ghRs=
X-Received: by 2002:a25:e4c7:: with SMTP id
 b190mr21430679ybh.302.1635229013843; 
 Mon, 25 Oct 2021 23:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211025160134.9283-1-chrubis@suse.cz>
 <20211025160134.9283-7-chrubis@suse.cz>
In-Reply-To: <20211025160134.9283-7-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Oct 2021 14:16:41 +0800
Message-ID: <CAEemH2dQcUW5k3Rv-n3=CrznqwpFta3P28QrB0oVZPZH6PyNuw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/6] lib: Add tst_set_runtime() & remove
 tst_set_timeout()
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
Content-Type: multipart/mixed; boundary="===============0653822168=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0653822168==
Content-Type: multipart/alternative; boundary="0000000000007f3a3e05cf3b6cd6"

--0000000000007f3a3e05cf3b6cd6
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 26, 2021 at 12:02 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> Rarely there is a need to set the test runtime dynamically, the only
> tests in LTP that does this are the timer tests that can get two
> parameters, number of iterations and sleep time, and the test runtime is
> close to the multiplication of these two.
>
> It's still cleaner to set the runtime and let the test library figure
> out the timeout in this case.
>

If so, should we consider to hinden the .timeout in struct tst_test
to prevent users from changing it?

IIRC, we currently have ".timeout == -1" to disable test timed
out in unsure situation, e.g some OOM tests. But in this patch,
I saw you remove that, but not handle it in tst_set_runtime.



>
> Also when no parameters are passed to these tests the runtime is a sum
> of multiplications from the tst_timer_test.c source so we define a
> constant in the tst_timer_test.h header and set the max_runtime in the
> testcases accordingly. With this we get correct estimate for the test
> runtime and tighter, but still forgiving enough, timeout as well.
>


-- 
Regards,
Li Wang

--0000000000007f3a3e05cf3b6cd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Oct 26, 2021 at 12:02 AM Cyril Hrubis &lt;<=
a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Rarely there is a need to =
set the test runtime dynamically, the only<br>
tests in LTP that does this are the timer tests that can get two<br>
parameters, number of iterations and sleep time, and the test runtime is<br=
>
close to the multiplication of these two.<br>
<br>
It&#39;s still cleaner to set the runtime and let the test library figure<b=
r>
out the timeout in this case.<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">If so, should we consider to =
hinden the .timeout in struct tst_test=C2=A0</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">to prevent users from changing it?</div><br><=
/div><div><div class=3D"gmail_default" style=3D"font-size:small">IIRC, we c=
urrently have &quot;.timeout =3D=3D -1&quot; to disable test timed=C2=A0</d=
iv><div class=3D"gmail_default" style=3D"font-size:small">out in unsure sit=
uation, e.g some OOM tests. But in this patch,</div><div class=3D"gmail_def=
ault" style=3D"font-size:small">I saw you remove that, but not handle it in=
 tst_set_runtime.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
Also when no parameters are passed to these tests the runtime is a sum<br>
of multiplications from the tst_timer_test.c source so we define a<br>
constant in the tst_timer_test.h header and set the max_runtime in the<br>
testcases accordingly. With this we get correct estimate for the test<br>
runtime and tighter, but still forgiving enough, timeout as well.<br></bloc=
kquote><div><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D=
"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br><=
/div></div></div></div>

--0000000000007f3a3e05cf3b6cd6--


--===============0653822168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0653822168==--

