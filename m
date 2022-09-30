Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6D3C433F5
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 17:53:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D98F93CA93A
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 19:53:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF6C83C1B40
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 19:53:26 +0200 (CEST)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 91FFE1000778
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 19:53:25 +0200 (CEST)
Received: by mail-vk1-xa30.google.com with SMTP id y129so2635185vkg.8
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 10:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=WfLWUGYOL/3XwdrQjfXxLwYib5dm5EWq4rqzqwE1a3I=;
 b=UjcFNdCa4x1CN7fzDVpE+Jg5SaybBK3liQ//J0ZObqfAJy57WveqtElH2S3FasakUB
 VGEkOlGVggQ0WZAy8YLU9CsrwGCIoTsi/6xOYXUwT/QXtdK1vff+UcvJLgxmGX8DD946
 XbndJs58ss99GRfSmhwj3tOCTaVET6oeHrX31EZffZ+S1kBW0ZzEw18oQWEs35f+Fmf2
 itLv5ABi97CY4ZDvNAd8Vnv8CsD3ChXgrH3TMqZoEPUtWwWa5UrlZza2M962mr6mFg/K
 VPjt7gjZiufZ3PF5yCeKj/pRpYBQU+8eVaBWc0/FAEG2AZhlWTPzt/ihnjAf6VJJt5VK
 hy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=WfLWUGYOL/3XwdrQjfXxLwYib5dm5EWq4rqzqwE1a3I=;
 b=cuORXT9CeUg2uFmB0opgyn87SaRqEN9L7RtvEuEk0NFwwbUU5fKrHutiCVxddIsoSg
 cR7wLtoHmMOuQzQWudX/X6hbrWbCDkbgUXDnk1lfeZyq/UoaPdT7xnBHGzcrJYVLthLz
 uBDHiC/29SAxCeTTdHhJADgEfvASGLCCRkFtoq1lQoz5ZqR3XDTsM7kyZ0JophjhljHj
 Rug3dpfZNE/rkYZCgZK3cv0RWhrIPCBX/vbjrIsjX59a/coofuwLLHgBt41eZNxiIcuM
 dDdf3492kyaqI08zkehZ6lgOAqgz1MPt4E7W32WuUnDUfBPzY71AGypB+bmuSb4Ilk0X
 f+wQ==
X-Gm-Message-State: ACrzQf0rvjgaAQhC0/SnRC3Gc3mROSX2VYDaXsMbo1sxa1BBL+jJFODP
 FhXQypflCNgRznhEcEEmzKmrilmQe8nI3WGVU2kMaQizkes=
X-Google-Smtp-Source: AMsMyM5kzH8fBPRk9YJFYEOzr7ICMtYNgnE+w4ow+m/kuO/wyVAO6ElZxVgykbzoaw3XxzWH1yir6lqVkYjdv/jsxrc=
X-Received: by 2002:a1f:980a:0:b0:3a8:68d3:736f with SMTP id
 a10-20020a1f980a000000b003a868d3736fmr5206689vke.36.1664560404111; Fri, 30
 Sep 2022 10:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220926182625.103275-1-edliaw@google.com>
In-Reply-To: <20220926182625.103275-1-edliaw@google.com>
Date: Fri, 30 Sep 2022 10:52:53 -0700
Message-ID: <CAG4es9UEjFHeXRCLa8AS8mMCfWW9zPhXfLqci04_8tQ6i3xvow@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/4] mmapstress01: refactor to ltp framework
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
Cc: kernel-team@android.com
Content-Type: multipart/mixed; boundary="===============0679922470=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0679922470==
Content-Type: multipart/alternative; boundary="000000000000987fa905e9e8ab04"

--000000000000987fa905e9e8ab04
Content-Type: text/plain; charset="UTF-8"

Will send a v2 to clean up formatting and fix up a few things I missed.

On Mon, Sep 26, 2022 at 11:26 AM Edward Liaw <edliaw@google.com> wrote:

> Attempt to refactor mmapstress01 to use the ltp framework.
>
> It was using LARGE_FILE to switch between 32 and 64 bit sized off_t. Is
> it correct to use FILE_OFFSET_BITS instead?
>
> Edward Liaw (4):
>   mmapstress01: refactor to tst_test framework
>   mmapstress01: refactor options
>   mmapstress01: use FILE_OFFSET_BITS=64
>   mmapstress01: use safe macros
>
>  testcases/kernel/mem/mmapstress/Makefile      |   2 +
>  .../kernel/mem/mmapstress/mmapstress01.c      | 624 ++++++------------
>  2 files changed, 212 insertions(+), 414 deletions(-)
>
> --
> 2.37.3.998.g577e59143f-goog
>
>

--000000000000987fa905e9e8ab04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Will send a v2 to clean up formatting and fix up a few thi=
ngs I missed.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Mon, Sep 26, 2022 at 11:26 AM Edward Liaw &lt;<a href=3D"ma=
ilto:edliaw@google.com">edliaw@google.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Attempt to refactor mmapstress01 t=
o use the ltp framework.<br>
<br>
It was using LARGE_FILE to switch between 32 and 64 bit sized off_t. Is<br>
it correct to use FILE_OFFSET_BITS instead?<br>
<br>
Edward Liaw (4):<br>
=C2=A0 mmapstress01: refactor to tst_test framework<br>
=C2=A0 mmapstress01: refactor options<br>
=C2=A0 mmapstress01: use FILE_OFFSET_BITS=3D64<br>
=C2=A0 mmapstress01: use safe macros<br>
<br>
=C2=A0testcases/kernel/mem/mmapstress/Makefile=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +<br>
=C2=A0.../kernel/mem/mmapstress/mmapstress01.c=C2=A0 =C2=A0 =C2=A0 | 624 ++=
++++------------<br>
=C2=A02 files changed, 212 insertions(+), 414 deletions(-)<br>
<br>
-- <br>
2.37.3.998.g577e59143f-goog<br>
<br>
</blockquote></div>

--000000000000987fa905e9e8ab04--

--===============0679922470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0679922470==--
