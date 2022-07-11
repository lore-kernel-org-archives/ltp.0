Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E285C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 07:17:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63BA03CA6DA
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 09:17:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7512B3CA5B2
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 09:17:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ABD971000608
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 09:17:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657523839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMTB/B0sUWXtAnq/7A7lk2Ly0P9e/HOTpUk0cixVE/k=;
 b=ikSVPKYBKDxJknyyRzVsRBhsiYuqQ7Okwpc9XFXpRutjIO3J/yN4OB6QfmMfESoeuWHa7w
 0kDNtWn8dbMsquIJ5RM5OeIiIk0HrYRXi0MOqhHCBuvb8LLSjPVWwuX/S91voWN8sqFTXW
 qgmV1MBHYLRsMbgUpvYa1SEO2oiAzP4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-agsoItwYNSGX24Rtz-F27g-1; Mon, 11 Jul 2022 03:17:12 -0400
X-MC-Unique: agsoItwYNSGX24Rtz-F27g-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-31d436816e1so36529017b3.15
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 00:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sMTB/B0sUWXtAnq/7A7lk2Ly0P9e/HOTpUk0cixVE/k=;
 b=vaSSo9F7j5wZYqnHISTUHaZ+jQE3j2gzPWf/rtZ5bqZPs3g1WIaFCoRJN7cXccZncw
 l2rhQqVYJDpks4Nw+jdw4ojXoyWiS45vT6Jno3CtFhdF+EGlQU9dK/X1kLir8k4wkKqW
 8hF7TTk6U+c+thZQXy3Dl5Bo1GeeTBZv/H3VgUdabZHWwAKZEKOh45tymNknS1ZvKxz6
 8mmkkLczRw1RT2Fz1NeVMHk+BNsjb1iQNiFB6QYwXYWO8qjf/2jBU5D05TDKpzOofUNO
 KET4UwMOYp270g0WWnOnTPHSXxzjkhNfZZ/sLV9sTBgCE/8eemM0tpyEl+CoEkrQ1IFN
 N1RQ==
X-Gm-Message-State: AJIora/dZsgZpUM9Ju2FqA3QCyFfj0s+JnVJmFD0OvZtFH7Rjux18o4i
 uBFSYpXnpSz7Jx72VnhwxiUsCfBx8PTktwmkn4lc8r/8sAxTx2aeOZjuZsiu1EldI1lGNjTVQDv
 zDyQ9x5mowWf9CqmjQEQjaFGuLM4=
X-Received: by 2002:a0d:f685:0:b0:31d:7685:8a90 with SMTP id
 g127-20020a0df685000000b0031d76858a90mr4483818ywf.12.1657523831915; 
 Mon, 11 Jul 2022 00:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vSrFbVTkxBtM25RfdvLH8aqEuBT7aSz2Gg2aldskj76/vSRMQ/U6uA2b6kjVS0QgWofLNK9ZjGT/yGDDXBpuY=
X-Received: by 2002:a0d:f685:0:b0:31d:7685:8a90 with SMTP id
 g127-20020a0df685000000b0031d76858a90mr4483813ywf.12.1657523831737; Mon, 11
 Jul 2022 00:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <d9cddda87dd121a4c57baa7f2d0e221b7a99bc1c.1657212941.git.jstancek@redhat.com>
In-Reply-To: <d9cddda87dd121a4c57baa7f2d0e221b7a99bc1c.1657212941.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 11 Jul 2022 15:17:00 +0800
Message-ID: <CAEemH2fe7PKvb08jr-jznrb939+0H7E3Xp6pLC80QKAVGsQ0Zw@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/futex_waitv03: replace
 TST_THREAD_STATE_WAIT with repeated wake
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
Content-Type: multipart/mixed; boundary="===============0189484418=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0189484418==
Content-Type: multipart/alternative; boundary="00000000000032af0b05e3825710"

--00000000000032af0b05e3825710
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 8, 2022 at 12:56 AM Jan Stancek <jstancek@redhat.com> wrote:

> TST_THREAD_STATE_WAIT isn't reliable to tell that it's safe to call
> futex_wake().
> futex_wake() can be called prematurely and return 0, which leaves other
> thread
> timing out on futex call:
>   tst_test.c:1459: TINFO: Timeout per run is 0h 10m 00s
>   futex_waitv03.c:37: TINFO: Testing variant: syscall with old kernel spec
>   tst_buffers.c:55: TINFO: Test is using guarded buffers
>   futex_waitv03.c:106: TBROK: futex_waitv returned: -1: ETIMEDOUT (110)
>
> Replace it with repeated futex_wake() until it fails or wakes at least 1
> waiter.
> Also extend timeout to 5 seconds to avoid false positives from systems with
> high steal time (e.g. overloaded s390x host).
>

Though TST_THREAD_STATE_WAIT is unreliable, I guess that would
still add more chances if we keep it?
(I mean go with repeat futex_wake() after checking 'S' state)


-- 
Regards,
Li Wang

--00000000000032af0b05e3825710
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Jul 8, 2022 at 12:56 AM Jan Stancek &lt;<a =
href=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">TST_THREAD_STATE_WAI=
T isn&#39;t reliable to tell that it&#39;s safe to call futex_wake().<br>
futex_wake() can be called prematurely and return 0, which leaves other thr=
ead<br>
timing out on futex call:<br>
=C2=A0 tst_test.c:1459: TINFO: Timeout per run is 0h 10m 00s<br>
=C2=A0 futex_waitv03.c:37: TINFO: Testing variant: syscall with old kernel =
spec<br>
=C2=A0 tst_buffers.c:55: TINFO: Test is using guarded buffers<br>
=C2=A0 futex_waitv03.c:106: TBROK: futex_waitv returned: -1: ETIMEDOUT (110=
)<br>
<br>
Replace it with repeated futex_wake() until it fails or wakes at least 1 wa=
iter.<br>
Also extend timeout to 5 seconds to avoid false positives from systems with=
<br>
high steal time (e.g. overloaded s390x host).<br></blockquote><div><br></di=
v><div><div class=3D"gmail_default" style=3D"font-size:small">Though TST_TH=
READ_STATE_WAIT is unreliable, I guess that would</div><div class=3D"gmail_=
default" style=3D"font-size:small">still add more chances if we keep it?=C2=
=A0</div><div class=3D"gmail_default" style=3D"font-size:small">(I mean go =
with repeat futex_wake() after checking &#39;S&#39; state)</div></div><div>=
<br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signa=
ture"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div><=
/div></div>

--00000000000032af0b05e3825710--


--===============0189484418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0189484418==--

