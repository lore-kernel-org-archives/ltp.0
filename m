Return-Path: <SRS0=AfES=PH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74800C433FE
	for <ltp@archiver.kernel.org>; Tue, 19 Oct 2021 09:12:09 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C09560ED5
	for <ltp@archiver.kernel.org>; Tue, 19 Oct 2021 09:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C09560ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E50983C4F2C
	for <ltp@archiver.kernel.org>; Tue, 19 Oct 2021 11:12:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBEBC3C02DA
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 11:11:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 61A4E600F6D
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 11:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634634712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3gHUAzbhuz8L2p2m1MA5R19nCLeslW34DGkYSjJL5A=;
 b=WwjzjEIy7frQa3bViV95Bgf/PnrIeTYOjbsGB0dFGr5SxPL3e7VIeW06ja2FZL4Gk3yx7u
 BQvOmFwMIa5Oc8No4a9plIzhF3MJXl2kJBS3Gi++UOSHenFnYrj6jvTm5+PyUAFAiC74cV
 7qVw4UnfKSet5uigQGK2m2O08XE+/C8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-yEgKR-VJO8Ocq1A7IPtNCA-1; Tue, 19 Oct 2021 05:11:14 -0400
X-MC-Unique: yEgKR-VJO8Ocq1A7IPtNCA-1
Received: by mail-yb1-f198.google.com with SMTP id
 v70-20020a256149000000b005ba4d61ea0fso23668807ybb.22
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 02:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X3gHUAzbhuz8L2p2m1MA5R19nCLeslW34DGkYSjJL5A=;
 b=6R/Qr2LnVXd12MGOHVIMIAEdlA0BhKenC9NnSWm7rQId0jULkb2kEbxay4Ts2Z1si4
 Ix9Ef/wdO9V6lsybqiNjoEeeQwZcveDdQnPImCS5ZXYkH92+qaoOojlUFLokH+5Lc+E4
 /eXBLfu37d0TBofWTo9+dvu5eWfRasPEt5XYKUi67Wi2tgOca7a2jepKeP3hCetz73Fs
 +8GNRX8+Iyj29zfdj4ugSG+vUuV1Ucspy0VwiJobRRFQagW3mpEAGW+B9A2ee4w19osi
 SBiItZMgIqXWPnp1nwcTB1DjCv+lfGA5MKV+6WrTFfD2NKEk3wlPMquOa6yXGrmF+owl
 LWIg==
X-Gm-Message-State: AOAM531QneNrdcQmujF67Qx6HMx9YZhGFWK4hzEgS/kWoaX5YDexc098
 pWDvFyxrxZ2y2liJO0I7gLfr1m2Up87ZwFnQHU2xYiAguXve/jtvhbXwm8OR0NVyBkW/naeOxDo
 XIdhZ+rNXHOII0vvt6Q+EnrWhd2s=
X-Received: by 2002:a25:1c08:: with SMTP id c8mr35134156ybc.316.1634634673856; 
 Tue, 19 Oct 2021 02:11:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywFNq+e7llJ8sAlGEa6k0FP3YY7Cun6ppX3aKnMf95MB+5HB5T01Z3RftbX4LsmXggC1v9ZUp9MUk/zu/RNQM=
X-Received: by 2002:a25:1c08:: with SMTP id c8mr35134132ybc.316.1634634673545; 
 Tue, 19 Oct 2021 02:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <ddffbf17d3b5fd2d7812a18435d5cc49b848de8d.1634548566.git.jstancek@redhat.com>
In-Reply-To: <ddffbf17d3b5fd2d7812a18435d5cc49b848de8d.1634548566.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Oct 2021 17:11:01 +0800
Message-ID: <CAEemH2dMimcGK345+83ugS0VdWCF9Q2q5DQB3JHeAw53oJU11A@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix/conformance/clock/1.1: check PASS
 condition periodically
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
Content-Type: multipart/mixed; boundary="===============0183314410=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0183314410==
Content-Type: multipart/alternative; boundary="0000000000000df98c05ceb10b13"

--0000000000000df98c05ceb10b13
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 18, 2021 at 5:18 PM Jan Stancek <jstancek@redhat.com> wrote:

> LTP commit 61312c62a392 ("open_posix/conformance/clock/1.1:
> Deterministic timing") changed test to busy loop for 5 seconds.
> This made the test sometimes fail in environments with high steal
> time.
>
> Move PASS condition inside loop, so in ideal case test can finish
> as soon as it has spent >1 sec of CPU time. Also drop the wrap-around
> check, since that takes order of minutes to happen.
>

Looks like more reliable than that 5sec busy loop, let's see how it
performs then.


>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--0000000000000df98c05ceb10b13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Oct 18, 2021 at 5:18 PM Jan Stancek &lt;<a =
href=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">LTP commit 61312c62a=
392 (&quot;open_posix/conformance/clock/1.1:<br>
Deterministic timing&quot;) changed test to busy loop for 5 seconds.<br>
This made the test sometimes fail in environments with high steal<br>
time.<br>
<br>
Move PASS condition inside loop, so in ideal case test can finish<br>
as soon as it has spent &gt;1 sec of CPU time. Also drop the wrap-around<br=
>
check, since that takes order of minutes to happen.<br></blockquote><div><b=
r></div><div><div class=3D"gmail_default" style=3D"font-size:small">Looks l=
ike more reliable than that 5sec busy loop, let&#39;s see how it performs t=
hen.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
Signed-off-by: Jan Stancek &lt;<a href=3D"mailto:jstancek@redhat.com" targe=
t=3D"_blank">jstancek@redhat.com</a>&gt;<br></blockquote><div><br></div><di=
v class=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &l=
t;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</div><div =
class=3D"gmail_default" style=3D"font-size:small"><br></div></div><div><br>=
</div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><d=
iv>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000000df98c05ceb10b13--


--===============0183314410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0183314410==--

