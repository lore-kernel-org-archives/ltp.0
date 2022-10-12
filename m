Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADF8C433FE
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 19:14:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C71333CAECB
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 21:14:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 323B13C071D
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 21:14:02 +0200 (CEST)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7C031200ADA
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 21:14:01 +0200 (CEST)
Received: by mail-vs1-xe33.google.com with SMTP id 128so11956371vsz.12
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FbRrnXF50bP7vMFvF3KP4FvV0PXU8Gt9X1T/OSxwOL8=;
 b=YcBbSNNhULc3ZuTE+Ax8TUBB2fkTXkPZVb8SCo+ibwJZjM83CJS9afwdNsqgY+le5A
 zoS/H6a1Tiz8XtR94BZDrqiQlKN6zfV1rlnOJMi3qmx6n7I9ZkFyv39mNpfYNAzipzkL
 xbs2nIK2DlM6J35mr4Iazsz75ia/TXmmLWwyM7adWuRldOoQhMo7Pv77iMpX8BG9uTwo
 w4sI4KQrpYarPMvm0KM9NIsXfHFNofFgFmPBd2r87sVcp8vpmud0qtNMRK3SjRMKfoRj
 qSwMcKPSBJNPHOPZ7HL3DMsoIq28m3/jFY/KYfqKHD+SWZmHyA05nBgV6+BqfY4TCaYu
 TJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FbRrnXF50bP7vMFvF3KP4FvV0PXU8Gt9X1T/OSxwOL8=;
 b=DLsfbd8GJMBdk18sm16EPOeqvpWUNhMHkkJk7iB6bH3lo9aJDOngCNUT5zk7+dzI3y
 SpAKW/JxGy70691oaumOoH4W2LWjopEDxGlcYYaaZc5hi5En3WsFzfT/+KcIX4qMEPXl
 i35BD8N+LjhUQZ/l1tuJ5YViFvaYwoeJofFY4zcNOzOLFhcVeHDTbEKrw1S7NpQ5P3vy
 iB3qQlThToYUqLHNe6ftSNbQwNPMVbqqmCQVi1If9w6+eR/whvyvi0l/+SKmDUcAn6jJ
 E4fEszgFAxiObA4WTf9OgLMfQitAOKeVLzKFwd0o0z3MlChvU5fdC+dFHUM1TXljFaM8
 ppKg==
X-Gm-Message-State: ACrzQf36oZZsIPxfvgtlgkyYUNaY/RGgp31lR77QoA/bLGEUNavQ+sAv
 cwkqqrisZOIozzh7AHiAjXC7Zn1WTRDXzkhcoId9fw==
X-Google-Smtp-Source: AMsMyM44GKivOjB7DGo9ulKIIb2L/7tNj0wOc3v3CWtZQvT1c+lgzgW5ahm+qJvsUgY6vghpHnIM1+DzvbmniqKRk5Q=
X-Received: by 2002:a05:6102:3d14:b0:3a6:e95c:ad6a with SMTP id
 i20-20020a0561023d1400b003a6e95cad6amr14560054vsv.0.1665602040164; Wed, 12
 Oct 2022 12:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221006184228.3281392-1-edliaw@google.com>
 <Y0RbGMRj8rDC2Eti@yuki>
In-Reply-To: <Y0RbGMRj8rDC2Eti@yuki>
Date: Wed, 12 Oct 2022 15:13:34 -0400
Message-ID: <CAG4es9XqHPZJ2Tu9pKy8cpGBy-6Bb=Ztgw5tS-BMroWDdUFW7w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/4] mmapstress01: refactor to ltp framework
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0726822447=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0726822447==
Content-Type: multipart/alternative; boundary="000000000000f1443a05eadb316d"

--000000000000f1443a05eadb316d
Content-Type: text/plain; charset="UTF-8"

Hi Cyril,
I sent a v5 with changes based on your comments.


> * I'm failing to see why we need to block SIGALRM just before alarm(0)
>   as far as I can tell it's completely useless. Also blocking signals
>   while we refork looks questionable.
>

Is the reason it's blocking signals while reforking is due to the second
choice in https://man7.org/linux/man-pages/man7/signal-safety.7.html?  I'm
not familiar with signal handling.
```
Block signal delivery in the main program when calling
functions that are unsafe or operating on global data that is
also accessed by the signal handler.
```

Thanks,
Edward

--000000000000f1443a05eadb316d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hi Cyril,</div><div>I sent=
 a v5 with changes based on your comments.</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">* I&#39;m failing to see why we nee=
d to block SIGALRM just before alarm(0)<br>
=C2=A0 as far as I can tell it&#39;s completely useless. Also blocking sign=
als<br>
=C2=A0 while we refork looks questionable.<br></blockquote><div><br></div><=
div>Is the reason it&#39;s blocking signals while reforking is due to the s=
econd choice in <a href=3D"https://man7.org/linux/man-pages/man7/signal-saf=
ety.7.html">https://man7.org/linux/man-pages/man7/signal-safety.7.html</a>?=
=C2=A0 I&#39;m not familiar with signal handling.</div><div>```</div><div>B=
lock signal delivery in the main program when calling<br>functions that are=
 unsafe or operating on global data that is<br>also accessed by the signal =
handler.<br></div><div>```<br></div><div><br></div><div>Thanks,</div><div>E=
dward</div></div></div>

--000000000000f1443a05eadb316d--

--===============0726822447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0726822447==--
