Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3A0C433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 02:41:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 072AD3CA544
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 04:41:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 930E93C0305
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 04:41:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6DB7F2001A0
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 04:41:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649731277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bCe9EXziNNqpLX3qzFylfJQ6aU9nsR7rP09SsqeonYM=;
 b=Uikc6tXCTfcH/UiPfD3s15h3W2WqZtjqI9H678vVV42gPnl1m8LcNjQ4yZIA1sf6nYppvA
 h8yviRDMyCHAJJJoQRDgB/PBldQ3Y5sPzDw6NW/POYlQe3kqCfAqgC9cGZZ3KIJtw1tNLZ
 79Tw+Ie3Di1aqZcdUnQJrPm6CekrR2o=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-kRRRKEzKOlyamocURlK1gg-1; Mon, 11 Apr 2022 22:41:16 -0400
X-MC-Unique: kRRRKEzKOlyamocURlK1gg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2ec060cffa5so50494637b3.4
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 19:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bCe9EXziNNqpLX3qzFylfJQ6aU9nsR7rP09SsqeonYM=;
 b=yDB7+W7SBuV/VG/sbgkNC6b41TkxQA7gLcmeeO0GdsysQjUZH1v2RsZeAYWp01nxL4
 fQ+qG2qWyvEmJJA1jyYrB6M2PiEEJTNHnEHbOHBa/Z3PVKxQuLqPVhkjUDhyg64mtEZ9
 WOCGMAdaFgB7WFAzL3IZMiUhHsud13hpkGSWqIhwPgxVwwjWYKqT8OdHI6+dgeJymle7
 bCcVTaDFkOV8G9jC/8MO9VCOHMkpnIsnbJTwzUrjvqJP0qmW6BmeDoOjXi237pMxUnHY
 nWs14OLHcApMg5v0AONlRbmbnhV9XNwE1jGdQNzTyLobM61zzmoIXa53ZSuZYa6THtFH
 Kjuw==
X-Gm-Message-State: AOAM530mBGplRkLYAAwbBVbuwIma6cVEWXjoXLhVeivXZafZkaCXdSgt
 V8ZadQ3B652HLwJyzFDJo0FqgJLKG/Zuqw0/M8FoeI6v98FVKxrZjJP0yuVIjEliCPsv/hsh92f
 I0E1OEPgkST8mN1y17IIIAzhl5uw=
X-Received: by 2002:a81:b60b:0:b0:2eb:f318:6b52 with SMTP id
 u11-20020a81b60b000000b002ebf3186b52mr13518479ywh.19.1649731275713; 
 Mon, 11 Apr 2022 19:41:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJk6B0Je0SRn9jVZlGzzQdCVt9F+9UqJrP5xk5NgLBMUcZTbK9LtnJ6pj98paodIp3eI7k/ig0UyyRvfHa2Os=
X-Received: by 2002:a81:b60b:0:b0:2eb:f318:6b52 with SMTP id
 u11-20020a81b60b000000b002ebf3186b52mr13518467ywh.19.1649731275479; Mon, 11
 Apr 2022 19:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220411151637.1739318-1-edliaw@google.com>
In-Reply-To: <20220411151637.1739318-1-edliaw@google.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Apr 2022 10:40:58 +0800
Message-ID: <CAEemH2f+bDdbfLpK3Jtr_F4THvZHksmbYmV30o9zuz4nXH=xeA@mail.gmail.com>
To: Edward Liaw <edliaw@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fzsync: break inf loop with flag vs
 pthread_cancel
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
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0854365504=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0854365504==
Content-Type: multipart/alternative; boundary="000000000000a6703c05dc6bfead"

--000000000000a6703c05dc6bfead
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 11, 2022 at 11:17 PM Edward Liaw via ltp <ltp@lists.linux.it>
wrote:


Hi, I'm working to get fzsync working with the Android kernel, which
> does not have pthread_cancel available.
>
> In the absence of pthread_cancel, when thread A exits due to a break,
> thread B will get stuck in an infinite loop while waiting for thread A
> to progress.
>
> Instead of cancelling thread B, we can use the exit flag to break out of
> thread B's loop.  This should also remove the need for the wrapper
> around the thread.
>
> Signed-off-by: Edward Liaw <edliaw@google.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000a6703c05dc6bfead
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Apr 11, 2022 at 11:17 PM Edward Liaw via lt=
p &lt;<a href=3D"mailto:ltp@lists.linux.it">ltp@lists.linux.it</a>&gt; wrot=
e:<br></div><div dir=3D"ltr" class=3D"gmail_attr"><br></div><div dir=3D"ltr=
" class=3D"gmail_attr"><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Hi, I&#39;m working to get fzsync working with the Android kernel, =
which<br>
does not have pthread_cancel available.<br>
<br>
In the absence of pthread_cancel, when thread A exits due to a break,<br>
thread B will get stuck in an infinite loop while waiting for thread A<br>
to progress.<br>
<br>
Instead of cancelling thread B, we can use the exit flag to break out of<br=
>
thread B&#39;s loop.=C2=A0 This should also remove the need for the wrapper=
<br>
around the thread.<br>
<br>
Signed-off-by: Edward Liaw &lt;<a href=3D"mailto:edliaw@google.com" target=
=3D"_blank">edliaw@google.com</a>&gt;<br></blockquote><div><br></div><div c=
lass=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<=
a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small"><br></div></div><div><br></d=
iv>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>=
Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000a6703c05dc6bfead--


--===============0854365504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0854365504==--

