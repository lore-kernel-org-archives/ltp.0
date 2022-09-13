Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD64C54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 07:33:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E3F73CABB3
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 09:33:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21D973CAADD
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 09:33:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 579706012D7
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 09:33:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663054420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eRovNzwOEEKjItUXuLnZ3UZFIOh8sW7alOPYTyY0r3k=;
 b=QH/U2ClNPgsGaRdasJPi/vjYTfA05AaIJr39QYo8q0Dyrr924Vu6vAc8fLv5LuD7YgOxA7
 kOYDRQ+smAPe3dpG9XrXjROz7yRuj6uyfttGbnD6MA5tSEYvMIDg6Aa7stp+K4608upgtr
 bhdOw3LI9LIOYukK95pi4KxwGBWP/is=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-APZY5nKqOvuLOvBqET0UmA-1; Tue, 13 Sep 2022 03:33:38 -0400
X-MC-Unique: APZY5nKqOvuLOvBqET0UmA-1
Received: by mail-vk1-f200.google.com with SMTP id
 e196-20020a1f1ecd000000b003a27f3f8d05so650658vke.21
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 00:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=eRovNzwOEEKjItUXuLnZ3UZFIOh8sW7alOPYTyY0r3k=;
 b=ZCyAbBOVbIPBTbiPVxNobGQkuQ4Edhmqx6p+yrkw/HzDPrRMWZttfL2pFYdRSJFF0V
 lf873RK7Nnhesnv9qQK5IpdRxcB1erj7BiwRGh9TKQFB2UrLU5kroZZ3u+PUru3GyRQ7
 9QJPaS22EJuPI5mgL/NItXkVQCYmwm2rR3Nkd+p+1Qmy8x7z5BMV2UYae92mb4ol1grc
 Bw1+IeZIuu3ibtm1r5K+YWOFthIpuNdGlsTJn44IfNRHor3nAJlYTbKQ+pDUjpxycfy8
 Zgq0R8y9td1kgRJpfJv95nL5RiiwWtTtTMbDHgHOIrJ5CrMdqH/su0XAUxFvxth+zSgW
 34+g==
X-Gm-Message-State: ACgBeo0tvL34Ig9wJhzE4cS9par2lZWeGP6hdQBnL+g/3F2qz3mu9V92
 8841sy/XevSV274/0Any7o3JpIXlw2QG408CYg46Ji+XoJvFU1rLasXaL2TfyN0eqg4ZxfBQO0F
 k+VgwgVGJoqVPCYDeS7Q26jV09/k=
X-Received: by 2002:a67:b102:0:b0:398:1e7c:a4a1 with SMTP id
 w2-20020a67b102000000b003981e7ca4a1mr8861785vsl.19.1663054418450; 
 Tue, 13 Sep 2022 00:33:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6/eMT5eWl4wxIHnP9kYlGW98Ms+3HNGwH+SoEdOB+oMjfktLX2UGVlG74Kz8s8VuPWBzvF70qGMG+K6fsVwww=
X-Received: by 2002:a67:b102:0:b0:398:1e7c:a4a1 with SMTP id
 w2-20020a67b102000000b003981e7ca4a1mr8861781vsl.19.1663054418217; Tue, 13 Sep
 2022 00:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220905061425.22852-1-luoxiaoyu9@huawei.com>
 <YyAmPYZ2iaraxraN@pevik>
In-Reply-To: <YyAmPYZ2iaraxraN@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 13 Sep 2022 15:33:26 +0800
Message-ID: <CAEemH2cZ2gkYxiTyPzmzaDmbqcnvxy3uQzunAzj0jRR7CjqAtg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pty04.c/pidfd_send_signal03.c: Drop redundant
 tst_reap_children()
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
Content-Type: multipart/mixed; boundary="===============1083415344=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1083415344==
Content-Type: multipart/alternative; boundary="000000000000d729fb05e88a0742"

--000000000000d729fb05e88a0742
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 13, 2022 at 2:42 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Luo,
>
> > Drop redundant calling of tst_reap_children() in cleanup() since
> > it has been called in the API (run_tests()).
>
> LGTM, I suppose that was a mistake.
>

Hmm, I slightly think that reflact a cautious thought from the author,
in case of test hit tst_brk unexpectly with invoke cleanup it can also
do reap children.

So, it's probably no harmful to keep tst_reap_children there.


-- 
Regards,
Li Wang

--000000000000d729fb05e88a0742
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Sep 13, 2022 at 2:42 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi Luo,<br>
<br>
&gt; Drop redundant calling of tst_reap_children() in cleanup() since<br>
&gt; it has been called in the API (run_tests()).<br>
<br>
LGTM, I suppose that was a mistake.<br></blockquote><div><br></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">Hmm, I slightly think that r=
eflact a cautious thought from the author,</div><div class=3D"gmail_default=
" style=3D"font-size:small">in case of test hit tst_brk unexpectly with inv=
oke cleanup it can also</div><div class=3D"gmail_default" style=3D"font-siz=
e:small">do reap children.</div><div class=3D"gmail_default" style=3D"font-=
size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small=
">So, it&#39;s probably no harmful to keep tst_reap_children there.</div><d=
iv class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div></div>-- <br><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div=
><div>Li Wang<br></div></div></div></div>

--000000000000d729fb05e88a0742--


--===============1083415344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1083415344==--

