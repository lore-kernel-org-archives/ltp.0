Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7593C433EF
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 12:52:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB9253CAAEB
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 14:52:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FC523C0277
 for <ltp@lists.linux.it>; Fri, 20 May 2022 14:52:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4BEDE1000F39
 for <ltp@lists.linux.it>; Fri, 20 May 2022 14:52:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653051121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U72YBOTPxfArpEWuhUAhUmg4t7u6Q6RHPZdNtESvDc0=;
 b=OZ4RMPcUyWrdDmzUiMq2d7deBh7irwKI9BFZ0sbkSW/bF37sAhNS4iIH/MrWPOQxQQ6yW3
 h9GVkzeiXq4BYNUUjkM78G7fbyfhZ7+yTWnNYQikppTqVYprnGrr8Pbe7anCswEb/csLC0
 dzrNchqUemLH9VgbgPq0qnRBAwjyeQg=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-ge-kfI1zNRyjFZnuCYjRSQ-1; Fri, 20 May 2022 08:52:00 -0400
X-MC-Unique: ge-kfI1zNRyjFZnuCYjRSQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 135-20020a25058d000000b0064dd6bc9cfdso7000955ybf.23
 for <ltp@lists.linux.it>; Fri, 20 May 2022 05:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U72YBOTPxfArpEWuhUAhUmg4t7u6Q6RHPZdNtESvDc0=;
 b=j9ih4dlhcrLDMW7Ikx/AYIz53BBvjujnzoOqAEWiiiR/8FAdug1qSgzV+tdz78EsCV
 yM3Fb+fKhzq3zQR07QwfjWZxYO5X4m6D/0nVj7M9QWzGCbmPSwJOLArZ9EU0m5+pRRP5
 rN1KAlvsqYmkaGCFml8DBvDY+dhWULVmV1iGk26dZzHkkwH2MlkVzc+wBCudai7zG+4v
 FgNdRiYtp6d1tUcbL2MN+TGCAfYQngiUW3A34ZCq5Ae4WktIpNGbI5oglXqp5tDB2+uo
 XOyBpgltKSHoC6qCZ5MkZkZU692bnoRIH7rHmW6prdal+nVgVYgmlraZG+QIhVWAwc58
 KMyQ==
X-Gm-Message-State: AOAM5320kCC6J533mRC/7plfDX8djh6ZXrXFdtFmEjvfcMZMnWWqTtMq
 dCwDJ6DW3npZMDpyjHools6OfR++w4GpPs0an8byBV0lucpM+BnI07aVrRdw6FZsr4Ng/adStd7
 0lfG5YPS76cQTW22Mn9fvvYLIUR8=
X-Received: by 2002:a25:4cc6:0:b0:64d:b8ca:3380 with SMTP id
 z189-20020a254cc6000000b0064db8ca3380mr8835433yba.233.1653051119487; 
 Fri, 20 May 2022 05:51:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMVFcWWNd3qtiDeNM1igjJ8KPJgRNoHuF1eKRLxNfU+z2HI3mDKPafCRm/YU4ZoGgfHKJNBuv4gxuoxlR8p/0=
X-Received: by 2002:a25:4cc6:0:b0:64d:b8ca:3380 with SMTP id
 z189-20020a254cc6000000b0064db8ca3380mr8835421yba.233.1653051119301; Fri, 20
 May 2022 05:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220520083627.2499121-1-liwang@redhat.com>
 <YoeHGDpo1XgQYb+o@yuki>
In-Reply-To: <YoeHGDpo1XgQYb+o@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 20 May 2022 20:51:48 +0800
Message-ID: <CAEemH2e-0WsfqWdxWR9nt-jHxaz4qyXqN6qu7=4YDhb_6LOPvQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] two follow up fix for Introduce-of-max-runtime
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
Content-Type: multipart/mixed; boundary="===============0413534738=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0413534738==
Content-Type: multipart/alternative; boundary="000000000000c30aa905df70f459"

--000000000000c30aa905df70f459
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:

Hi!
> > I run a quick test for verifying those patches with the latest mainline
> kernel.
> > Apart from these two tiny issues, the result looks good.
>
> Can we merge the patchset now?
>

I think yes, at least my test shows it is safe.



>
> There are three things that should be fixed over the latest version,
> that are:
>
> - the heartbeat() call after each test for .tcnt
> - the missing runtime for fuzzy sync
> - default to something more sane in mmap3 and fix the runtest file
>   (could be ammended to the convert mmap3 patch as well)
>
> Should I send v4 after all?
>

No need, unless someone explicitly explains they will do a review/test for
V4.

-- 
Regards,
Li Wang

--000000000000c30aa905df70f459
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D=
"_blank">chrubis@suse.cz</a>&gt; wrote:<br></div><div class=3D"gmail_defaul=
t" style=3D"font-size:small"><br></div></div><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; I run a quick test for verifying those patches with the latest mainlin=
e kernel.<br>
&gt; Apart from these two tiny issues, the result looks good.<br>
<br>
Can we merge the patchset now?<br></blockquote><div><br></div><div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">I think yes, at least my tes=
t shows=C2=A0it is safe.</div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
There are three things that should be fixed over the latest version,<br>
that are:<br>
<br>
- the heartbeat() call after each test for .tcnt<br>
- the missing runtime for fuzzy sync<br>
- default to something more sane in mmap3 and fix the runtest file<br>
=C2=A0 (could be ammended to the convert mmap3 patch as well)<br>
<br>
Should I send v4 after all?<br></blockquote><div><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">No need, unless someone explicitly e=
xplains they will do a review/test for V4.</div></div><div><br></div>-- <br=
><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br><=
/div></div></div></div>

--000000000000c30aa905df70f459--


--===============0413534738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0413534738==--

