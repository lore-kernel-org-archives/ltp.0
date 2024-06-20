Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60B6C27C53
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 02:38:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 436693D0DF9
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 04:38:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D9E53C2A5B
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 04:38:09 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 74E731400C6A
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 04:38:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718851086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I3Nfb1z2sPy4rtEkOb/PmbdH1reCJE4hFVHd2ntTyO0=;
 b=i0Bl4tj9opbU/tRpSt4kFmhEVfcG3NE6xnu3FDFANQ3aG9K+q8cbNJISCJMkxHvMA0YZPj
 dLV1teMLkeNSetX4NUdEWORh2Z6prq+6kcXo1ULT9mqYkayrsc28qo67RxnwbOXCGy2sd/
 UOYPiLNMaW+pCVzlQ7A2AWN9dFzRxZo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-ENNkcw-zPsa1l_D2rMeE8A-1; Wed, 19 Jun 2024 22:38:04 -0400
X-MC-Unique: ENNkcw-zPsa1l_D2rMeE8A-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c7430b3c4bso541973a91.1
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 19:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718851082; x=1719455882;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I3Nfb1z2sPy4rtEkOb/PmbdH1reCJE4hFVHd2ntTyO0=;
 b=ZfUdmJQ9xuh9ss2WREAHLrdBjSBaQDTG8k5EQTkRfpSU9jl3gK+55SeVVu+IOoHo8r
 tQopN80I6y+cq19MC1XuLO9xHb5MMQrNNNffSjffjpGuhjV0BcA57Wr5CEQYv675atam
 rVmHpLqGm8m9BlM0EabM60PxvZYQr957+svc0jUJg3YaSNl5/vYt/M2aXJxXsMoVknoi
 SuPcCzDBIoWu+IPmQeRGvrFZgrJ+Je3/cg92VsSZRKluzxcNM5SiHzW6QkRP8aF8KIAG
 0H9F0uuTCJ281oerE9ZIp5p1v1P9LVzgUjv31CHIRKB3Eah2I3ePBGUCCJ7txDuJn+7t
 rDgQ==
X-Gm-Message-State: AOJu0Yw1Yw4+Xc0yy+arvQZ6lo2nc+o65F3eLp9jBVTsV5JtpVrSblWA
 tlMgo4i6dGKCI9v/cjATVljAnlM3H2Z8IVi6ywbtBC7ZWepfGy8vgkBsgJ9QiuV88UkpvxdGuzQ
 SSvbbBhKC9oK6SIvCYCvmy+uiUjaoZOzmoYTWmXAsMh08rbTDjunSbZT00nQxdZK6yfK/VelCVF
 igCl/uKz/uwNYqu6ZTBeD92eQBhjVonGcWWakP
X-Received: by 2002:a17:90a:be16:b0:2c7:7718:a9e3 with SMTP id
 98e67ed59e1d1-2c7b59fbb9bmr3976556a91.3.1718851082133; 
 Wed, 19 Jun 2024 19:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWQnbcuC13PvJAYUDUma9FduABaelhGlNWWwibZaKD+cue3ZU3+aGZ2pHxB5qiV1/OGVLaN6c7NXCG+Io65jY=
X-Received: by 2002:a17:90a:be16:b0:2c7:7718:a9e3 with SMTP id
 98e67ed59e1d1-2c7b59fbb9bmr3976547a91.3.1718851081778; Wed, 19 Jun 2024
 19:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240620021635.489505-1-liwang@redhat.com>
In-Reply-To: <20240620021635.489505-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Jun 2024 10:37:49 +0800
Message-ID: <CAEemH2ctF+3AEZkm4Y+KkcTUgYGM4XD24pkfwdJo=6ynQ-Wgxg@mail.gmail.com>
To: ltp@lists.linux.it, pvorel@suse.cz
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] tst_kconfig: Avoid reporting buffer overflow
 when parsing /proc/cmdline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

 Li Wang <liwang@redhat.com> wrote:

When the test is run with a kernel booting with many parameters, the
> buffer size is often not large enough to store the complete command
> line. This results in a buffer overflow and the test complains with
> the following message:
>
>   tst_kconfig.c:609: TWARN: Buffer overflowed while parsing /proc/cmdline
>
> Note:
>
> Petr point out that these configs, which are generated by toolchain will
> be longer than 128 chars someday, but I don't think that is the reason
> we need raise our parsed buffer, since tst_kcmdline_parse() was just add
> for popular parameter (which always pass by user and short). So far I
> don't see any LTP test parse a longer parameters.
>
> Fixes: 180834982 ("kconfig: add funtion to parse /proc/cmdline")
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Petr Vorel <pvorel@suse.cz>
> ---
>  include/tst_kconfig.h | 2 +-
>  lib/tst_kconfig.c     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
> index dcb370574..23f807409 100644
> --- a/include/tst_kconfig.h
> +++ b/include/tst_kconfig.h
> @@ -87,7 +87,7 @@ int tst_kconfig_check(const char *const kconfigs[]);
>   */
>  struct tst_kcmdline_var {
>         const char *key;
> -       char value[128];
> +       char value[256];
>         bool found;
>  };
>
> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index e16ca1400..8eb1b803f 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -569,7 +569,7 @@ char tst_kconfig_get(const char *confname)
>
>  void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t
> params_len)
>  {
> -       char buf[128], line[512];
> +       char buf[256], line[512];
>

Petr, if you are still worried, feel free to enlarge them to char
'buf[512], line[2048];' during merge :).

BTW, I don't want to allocate the size dynamically to make the code more
complicated.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
