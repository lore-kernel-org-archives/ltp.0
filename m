Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D138DC07E9D
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 21:21:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D8983C92E7
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 23:21:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80C4E3C0FBC
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 23:21:02 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EB3B61000481
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 23:21:01 +0200 (CEST)
Received: by mail-vs1-xe2e.google.com with SMTP id 126so998990vsi.10
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 14:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=3kwkOHAteG+CQkkLyvbpmF82ooOhVFBFu7rwt9JWzqI=;
 b=LhmwW77YIEaiP4SS8gft994ABTHyaAflptfMdIJmEuMD1NTIbzuxulrfNYiUPo3R8I
 j0rWPDz5MRhzpo0EhpvxBrCe79hmJz4Q2x9Ah4jwqdO6Pfj0M9evdjUMYtgCJ5PFD2PO
 U2MxbAeO0MgzAl70rIdTUN1aosa2gMIFLyewcLsi0RI5Iiwd5ub8DerVVYwlzVNTKjdo
 ixzhnDFucl2QKVuE4UrjJhBva8zdld8P2/UtHJ1c0QQonSs34611M+eRqgBkrxSDRu0F
 pKPSd+eQSbcUKN5F4CqRvhV/Q3bZiDMf333tOf5IgEwMX7xsS98tHxeU6tQNMiVPjWXR
 YklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=3kwkOHAteG+CQkkLyvbpmF82ooOhVFBFu7rwt9JWzqI=;
 b=KXbVnCHc3cvbSZAihbL7eZMCzQh5QXk+O3+o2uhSycRSKBhZ9T9MASS2thPv1AtV2q
 MjF38GbjcPm+YeQ8rGxqSLwjVfVBi9HyXI1FNi0aI8P0cD0srSDaaZCE6ye784BN9Ga/
 tm1l9e21vK1ZoIJ8GWTWjxgyx2y3HECXvT9SS5SuRE+vLfMC4IkM4NeScDGc1zIMEcNL
 dROZaHudM+dhmYgceTmINfOUqiMQnc/g4zmI1XhhTMhSbGsEgJwUJWYvsFjFwX8XudIB
 GKXyI4PAcVkfUi3Vhc5sBSLQToSMUUdsXCl/39/V6cb2e8+nOGEk8goozvTOwfd6Qxdy
 9Nhg==
X-Gm-Message-State: ACrzQf2X8DE8pR6+zGRXWVn8RLUA9uzm0Ft1VpXrzgnzbFooESlXjU0g
 XcpnjpD4GtMXFx7ZbgJtZDsRmAC9w2/Q907DA2Galg==
X-Google-Smtp-Source: AMsMyM7Qk27qrQPyN+dMBTUnDU9MFGbjPE/JxGZNA2Ffchvr7id+S+r+Hp8iOUroDNLHM7L0X7H81Kr/QDEBFFw2mQY=
X-Received: by 2002:a67:db83:0:b0:398:4db2:3f83 with SMTP id
 f3-20020a67db83000000b003984db23f83mr12462436vsk.36.1664313660760; Tue, 27
 Sep 2022 14:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220913202839.1807979-1-edliaw@google.com>
 <YyGisrbDIgVa/0QA@yuki>
 <YyHYvCr0PISg6ISY@pevik> <YyHcNcTUNG+gU3rq@pevik>
 <CAG4es9Wi8oGf1OmNUqg41wv51Qmb9gewZrifUQW-wOPL0ZKNhA@mail.gmail.com>
 <YyQ+PiN0JBy6PLJI@yuki>
 <CAG4es9VB6AydFCRkBvPm=cyozOiqCBN8vxEo68_yvm-as+9FeA@mail.gmail.com>
 <YzK9MHWocKPypj8B@yuki>
In-Reply-To: <YzK9MHWocKPypj8B@yuki>
Date: Tue, 27 Sep 2022 14:20:35 -0700
Message-ID: <CAG4es9WajJKetV5HsM+WqoUL7Dwshrx2dkQZq9E8Se3dZLL2ag@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] minmax: fix type warnings
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
Content-Type: multipart/mixed; boundary="===============2046318866=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2046318866==
Content-Type: multipart/alternative; boundary="0000000000008bda6d05e9af3882"

--0000000000008bda6d05e9af3882
Content-Type: text/plain; charset="UTF-8"

Hi Cyril,
On Tue, Sep 27, 2022 at 2:05 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Sure thing, I've made an attempt to port mmapstress01, will send that for
> > feedback before tackling the others.
>
> We are finalizing a LTP release right now, I will have a look once I
> have a bit of time, however it probably wouldn't be sooner than next
> week.
>

Sounds good, thanks!

--0000000000008bda6d05e9af3882
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Cyril,=C2=A0</div><div dir=3D"ltr">On Tue, Sep 27,=
 2022 at 2:05 AM Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubi=
s@suse.cz</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Sure thing, I&#39;ve made an attempt to port mmapstress01, will send t=
hat for<br>
&gt; feedback before tackling the others.<br>
<br>
We are finalizing a LTP release right now, I will have a look once I<br>
have a bit of time, however it probably wouldn&#39;t be sooner than next<br=
>
week.<br></blockquote><div><br></div><div>Sounds good, thanks!</div></div><=
/div>

--0000000000008bda6d05e9af3882--

--===============2046318866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2046318866==--
