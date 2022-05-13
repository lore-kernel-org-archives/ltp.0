Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A94CC433F5
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 01:51:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E9C83CA9D5
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 03:51:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D21143C8CC3
 for <ltp@lists.linux.it>; Fri, 13 May 2022 03:51:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 354A41A00CB6
 for <ltp@lists.linux.it>; Fri, 13 May 2022 03:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652406682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hhuA957HVb4Rr7qt3M3UqwBjl6X0kncfPHvjEMgH/rw=;
 b=fhqWvqqzy1g/okuJIpvfS1QGIQcsMboLu+ERnCggAL7yT+/rruzlt0mkKGEAxK32owRWV9
 POv7AaRj0Vj0GAYmB3wuU/2+F3waR7zT6Fteo+0Z34wJ6ZbsgYOF+aXxNxjnSxWfoNRzyg
 7h3k9jdp0yTFgwoYUtYJFlaRCLQWWzg=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-y5wLGqgfPISU0PtNbGRONA-1; Thu, 12 May 2022 21:51:21 -0400
X-MC-Unique: y5wLGqgfPISU0PtNbGRONA-1
Received: by mail-yb1-f200.google.com with SMTP id
 g26-20020a25b11a000000b0064984a4ffb7so6065673ybj.7
 for <ltp@lists.linux.it>; Thu, 12 May 2022 18:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hhuA957HVb4Rr7qt3M3UqwBjl6X0kncfPHvjEMgH/rw=;
 b=oLsJtvc84qYoATlvsxX14HgLaHQoXSS+UFq9Mpqsyk0iY58tgHt9LvyDX0VCe4tbC5
 CBSnomsUpBps/V2Y9QbgEG10Z8IG3WVo87bpyAHfffHU27BIsTqDP8KoVEcdHuz7ykF8
 4qYGbNp8CVmWC7AwfBCiw0YDGQRXQgu+aKCIaRJ7O3reJhwfIsEhPqtG7lgXuBRt8T5s
 oT3uZYGSiYPfG4WRF4YMLzEy7OrEGU99nB6k+eRTRYeluP6r329sxcG9hg4ZzjW9zqUb
 uZHeF+gzxfUl/nThs5Kh4igQEGyXHPMW6RUWPjoB3yiMFcQAwQGCPcBue6Z4kPJBQqyd
 sMbw==
X-Gm-Message-State: AOAM531+fc78P0WqTLe3MR/RvWc+uVZt57gnwsg5/1YuzIAbvU6ClO5J
 Z3OUuvF/Copb3kwoO/93pH4Xa3DQ9SEm6FplXNHt4D2nRHQ/iEGWmYC1w1OpdH1HRZX+YN/3aWy
 aF3v86QCo/JakGQVux3sKaF1d2R0=
X-Received: by 2002:a81:5b56:0:b0:2ec:34e7:9b5c with SMTP id
 p83-20020a815b56000000b002ec34e79b5cmr3320380ywb.300.1652406680487; 
 Thu, 12 May 2022 18:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCh943Vj9AFf853t2XBrYEzGA1RT9W0bSM7biSCJvmhENi7MGjZuqh8Ju6AMWnnUPsmPZd36lVSY5KJjk4BvY=
X-Received: by 2002:a81:5b56:0:b0:2ec:34e7:9b5c with SMTP id
 p83-20020a815b56000000b002ec34e79b5cmr3320368ywb.300.1652406680233; Thu, 12
 May 2022 18:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220512013830.8534-1-aarcange@redhat.com>
 <20220512013830.8534-2-aarcange@redhat.com>
In-Reply-To: <20220512013830.8534-2-aarcange@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 13 May 2022 09:51:09 +0800
Message-ID: <CAEemH2cSfESfver7zM9CetNbAjUfdTELBvyoAf_VSNB_Qw4mCw@mail.gmail.com>
To: Andrea Arcangeli <aarcange@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ksm: fix occasional page_volatile false
 positives
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
Cc: Eirik Fuller <efuller@redhat.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============2112363468=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2112363468==
Content-Type: multipart/alternative; boundary="000000000000333de405dedae912"

--000000000000333de405dedae912
Content-Type: text/plain; charset="UTF-8"

Andrea Arcangeli <aarcange@redhat.com> wrote:

The KSM scan keeps running while checking the KSM status in sysfs, but
> during the KSM scan the the rmap_items in the stale unstable tree of
> the old pass are removed from it and are later reinserted in the new
> unstable tree of the current pass, leading to some page_volatile
> false positives.
>
> The fix is stop the KSM scan temporarily while the KSM status is being
> read from sysfs.
>
> For reference here's an instance of the fixed false positives:
>
> mem.c:255: TFAIL: pages_volatile is not 0 but 1.
> mem.c:255: TFAIL: pages_unshared is not 1 but 0.
>
> Reported-by: Eirik Fuller <efuller@redhat.com>
> Co-developed-by: Li Wang <liwan@redhat.com>
> Tested-by: Li Wang <liwan@redhat.com>
>

This email address is valid but I prefer to use the my
name liwang@ for better remembering :).
(Anyway this doesn't matter, we can ignore this.)



> Tested-by: Eirik Fuller <efuller@redhat.com>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>

@Cryril, I vote for adding this patch in the new release.
Plz take this into consideration, thanks.


-- 
Regards,
Li Wang

--000000000000333de405dedae912
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Andrea Arcangeli &lt;<a href=3D"mailto:aarcange@redhat.com" t=
arget=3D"_blank">aarcange@redhat.com</a>&gt; wrote:<br></div><div class=3D"=
gmail_default" style=3D"font-size:small"><br></div></div><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">The KSM scan kee=
ps running while checking the KSM status in sysfs, but<br>
during the KSM scan the the rmap_items in the stale unstable tree of<br>
the old pass are removed from it and are later reinserted in the new<br>
unstable tree of the current pass, leading to some page_volatile<br>
false positives.<br>
<br>
The fix is stop the KSM scan temporarily while the KSM status is being<br>
read from sysfs.<br>
<br>
For reference here&#39;s an instance of the fixed false positives:<br>
<br>
mem.c:255: TFAIL: pages_volatile is not 0 but 1.<br>
mem.c:255: TFAIL: pages_unshared is not 1 but 0.<br>
<br>
Reported-by: Eirik Fuller &lt;<a href=3D"mailto:efuller@redhat.com" target=
=3D"_blank">efuller@redhat.com</a>&gt;<br>
Co-developed-by: Li Wang &lt;<a href=3D"mailto:liwan@redhat.com" target=3D"=
_blank">liwan@redhat.com</a>&gt;<br>
Tested-by: Li Wang &lt;<a href=3D"mailto:liwan@redhat.com" target=3D"_blank=
">liwan@redhat.com</a>&gt;<br></blockquote><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">This email address is valid bu=
t I prefer to use the my</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">name liwang@ for better remembering :).</div><div class=3D"gmail_=
default" style=3D"font-size:small">(Anyway this doesn&#39;t matter, we can =
ignore this.)</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
Tested-by: Eirik Fuller &lt;<a href=3D"mailto:efuller@redhat.com" target=3D=
"_blank">efuller@redhat.com</a>&gt;<br>
Signed-off-by: Andrea Arcangeli &lt;<a href=3D"mailto:aarcange@redhat.com" =
target=3D"_blank">aarcange@redhat.com</a>&gt;<br></blockquote><div><br></di=
v><div class=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wa=
ng &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</div>=
<div class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">@Cryril, I vote for adding thi=
s patch in the new release.</div><div class=3D"gmail_default" style=3D"font=
-size:small">Plz take this into=C2=A0consideration,=C2=A0thanks.</div><div =
class=3D"gmail_default" style=3D"font-size:small"><br></div></div><div><br>=
</div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>=
Li Wang<br></div></div></div></div>

--000000000000333de405dedae912--


--===============2112363468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2112363468==--

