Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F86C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 10:11:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951FB6115A
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 10:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 951FB6115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B6093C8617
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 12:11:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F16DB3C2659
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 12:11:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 47E4C600A0A
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 12:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632305477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLYrVivZ9geFbbLrgZ6phXukApFe1Eczwkkif5ZV7FE=;
 b=AvrKCXq2iiG2ooMhZ61aAw7jrj6jToavddcNAKd/gV9woAsHUgy9QO7RI8fNGSyFh7bD/q
 B9keDKcFDsg+ubDCRItmfJuC13FZpYf8DCh5ICzH2bqykm/UdCFA6XXzj5IqzmdDgUG6iR
 tf4c3NyFsYsfatX1rl96F6IKWMmaNAE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-CcszFGI6NP6KcSlDOS6mYA-1; Wed, 22 Sep 2021 06:11:11 -0400
X-MC-Unique: CcszFGI6NP6KcSlDOS6mYA-1
Received: by mail-qt1-f200.google.com with SMTP id
 c22-20020ac80096000000b0029f6809300eso7812136qtg.6
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 03:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aLYrVivZ9geFbbLrgZ6phXukApFe1Eczwkkif5ZV7FE=;
 b=0ZIhc2wVqElmP6oUy6kTPUNTHoFqRn1lV5JzP9A7B/kNssywC4pldWUKTpyjHnBCzq
 guuTKIbvcJv7psYlZjHkL4OxrqOMgqMWME9nBiSJogdujIbzz27TgBt0/Gh71eXTwJj5
 A8kEU3Z837Tt8epHnR/W/zppXKxP1dSFN5gSvSxIRTuVO4yg/dPfBHScXDcp8TinfHvA
 81MBMMJRllwoRSci9aDmHgiCgH8DmwhjH9mhGOWjWH0GfBxdHLXCZrCHebZzZBg3AbZY
 T4hW4lXCCAXiEJQXouZlg13rt4ZRlyQ98CIjU8ellmnMyTcQ2I/a1luX9pvG5z0T07sv
 2TPA==
X-Gm-Message-State: AOAM530r4iyS4OhdYjdETx3peaupXUEmJIt4lWzYCioxxni5/AAwNWos
 bu5v2Y05+NEuMpdhk1R/L9TFRY0lu041muByNTCS4YPvWdG90k+1rNT1FXoWJurEyuPPI700Din
 +4qsj+DmWe6SHLlUVDa0QIQ94a/c=
X-Received: by 2002:a25:2455:: with SMTP id k82mr15516465ybk.186.1632305471211; 
 Wed, 22 Sep 2021 03:11:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyU8lz/v54VIj9M9LtwBdH3uRZnZzLXqf9OsUl2hAg8sZ6z0jskVt2iJje0GlzL+B84UWGnPcMlhCjNXnvLdyQ=
X-Received: by 2002:a25:2455:: with SMTP id k82mr15516443ybk.186.1632305471034; 
 Wed, 22 Sep 2021 03:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210922094838.21366-1-chrubis@suse.cz>
In-Reply-To: <20210922094838.21366-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Sep 2021 18:10:59 +0800
Message-ID: <CAEemH2dNy2FiuDtxVKZYpnj4LeZ485fHXJBqzpPAwQ8=RGO8hA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib: shell: Fix timeout process races
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
Content-Type: multipart/mixed; boundary="===============0103494277=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0103494277==
Content-Type: multipart/alternative; boundary="000000000000c4354b05cc92bb7a"

--000000000000c4354b05cc92bb7a
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

Patch tested well from my side, that'd be great if you
can help update code comments in timeout03.sh.

Or, do that separately is also fine, it's not a big deal.

# bash timeout03.sh
timeout03 1 TINFO: timeout per run is 0h 0m 1s
timeout03 1 TINFO: testing killing test after TST_TIMEOUT
Test timed out, sending SIGTERM!
If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
Terminated
timeout03 1 TBROK: test terminated
timeout03 1 TPASS: test run cleanup after timeout
Test is still running...
Test is still running...
Test is still running...
Test is still running...
Test is still running...
Test is still running...
Test is still running...
Test is still running...
Test is still running...
Test is still running...
Test is still running, sending SIGKILL
Killed

-- 
Regards,
Li Wang

--000000000000c4354b05cc92bb7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Review=
ed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</=
a>&gt;<br></div><div class=3D"gmail_default" style=3D"font-size:small"><br>=
</div><div class=3D"gmail_default" style=3D"font-size:small">Patch tested w=
ell from my side, that&#39;d be great if you=C2=A0</div><div class=3D"gmail=
_default" style=3D"font-size:small">can help update code comments in timeou=
t03.sh.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></d=
iv><div class=3D"gmail_default" style=3D"font-size:small">Or, do that separ=
ately=C2=A0is also fine, it&#39;s not a big deal.</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"><span class=3D"gmail=
_default" style=3D"font-size:small"></span># bash timeout03.sh</div>timeout=
03 1 TINFO: timeout per run is 0h 0m 1s<br>timeout03 1 TINFO: testing killi=
ng test after TST_TIMEOUT<br>Test timed out, sending SIGTERM!<br>If you are=
 running on slow machine, try exporting LTP_TIMEOUT_MUL &gt; 1<br>Terminate=
d<br>timeout03 1 TBROK: test terminated<br>timeout03 1 TPASS: test run clea=
nup after timeout<br>Test is still running...<br>Test is still running...<b=
r>Test is still running...<br>Test is still running...<br>Test is still run=
ning...<br>Test is still running...<br>Test is still running...<br>Test is =
still running...<br>Test is still running...<br>Test is still running...<br=
>Test is still running, sending SIGKILL<br>Killed<br></div><div><br></div>-=
- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Rega=
rds,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000c4354b05cc92bb7a--


--===============0103494277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0103494277==--

