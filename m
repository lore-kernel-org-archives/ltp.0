Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8053C3DA7D
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 03:07:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D8963CE0CE
	for <ltp@archiver.kernel.org>; Wed,  4 Jan 2023 04:07:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 988C03CB698
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 04:07:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E4136005E5
 for <ltp@lists.linux.it>; Wed,  4 Jan 2023 04:07:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672801648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l5UIm0x+pF9truwZA+PMohfk1weH346PyOBvfdFEw24=;
 b=PgObu1JDzsBpgF8jOfMdveJsKZyc/Jfl9e9W4eft8d+EP8yw6jtW6m4+0kMWEet2ay6QJz
 Vl7qJcs9KrxP+CndP8GxI7BuIWwyHaLmXpbs0J4QbZP66jzRRLBUnKoEUrkTflZhGpRK2i
 bSxfDwEUdR8kuGBno9L2N/dk/9WOzpA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-Rfv_NsGIN9KbMGkQ4wRCEg-1; Tue, 03 Jan 2023 22:07:26 -0500
X-MC-Unique: Rfv_NsGIN9KbMGkQ4wRCEg-1
Received: by mail-wr1-f69.google.com with SMTP id
 r10-20020adfa14a000000b0025ba73dff40so3993258wrr.12
 for <ltp@lists.linux.it>; Tue, 03 Jan 2023 19:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l5UIm0x+pF9truwZA+PMohfk1weH346PyOBvfdFEw24=;
 b=jaszQ+I0sOb08r/I/JUWh1vaK2sTjFlgfDqk90nLkXWi4yY8Fi6lIzt9AUSOezR8pQ
 Y3lWQ4PnBJaOWwcRV8t0FUpoAfv3NDtuePhAW13Pp3dMg3slmvEYDeYmY6cj8gbSAMbt
 bh9Ewq2LRMzWe/19Qqf+f/mG71MgE3nRKdyFsB3aaWpOTSiKD4D4Bka5qYY6b6BiMkdh
 f4Qka50CJ3pfL0AuRNuiNnCYbiq+lbQx+mRLGfLYXEIsFBqO09ebYsEzu1i5Wg6XTDPn
 wddq28f9OL2glQz82XlD7SYI5Y+Y9VEuptphoXmn5yzXPdtb7J5ijHyrHwOTkJG/ljiF
 v8Nw==
X-Gm-Message-State: AFqh2kpDDH1PFkVRHsKTVKIU+IbDI5ApXz0SoCV8Hhd/w/GcgMphC06W
 1odQ9yOhZ6iyNqO68yFGKd2jTLo4oAeByA1vBvuzN6jNw5UMu8aIVO6rYogE/pvIBeZdlySAEdj
 fTlIgRC6+nuPe2sgfs0bUwsC/2I0=
X-Received: by 2002:a05:600c:201:b0:3d3:58d1:258f with SMTP id
 1-20020a05600c020100b003d358d1258fmr2176381wmi.121.1672801645239; 
 Tue, 03 Jan 2023 19:07:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvDcadqcnpCqfxzfA64TKuMOCNtuMn7usHKyF36i1q8hm5bn1HooSZA/wTAw6d+bAUfM+mKgnv+2pg0soMN/eM=
X-Received: by 2002:a05:600c:201:b0:3d3:58d1:258f with SMTP id
 1-20020a05600c020100b003d358d1258fmr2176380wmi.121.1672801644929; Tue, 03 Jan
 2023 19:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20230103124505.6611-1-pvorel@suse.cz>
In-Reply-To: <20230103124505.6611-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 4 Jan 2023 11:07:13 +0800
Message-ID: <CAEemH2c69cKYLFzivuCRNnpxB8sco-9LRhL8_EYw0i+Srp71CA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] configure.ac: Require 2.64
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
Cc: Mike Frysinger <vapier@gentoo.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

I see other places also used 2.61, do you think we need to correct them as
well?
(e.g. open-posix and realtime)

$ git grep AC_PREREQ
configure.ac:AC_PREREQ(2.61)
testcases/open_posix_testsuite/configure.ac:AC_PREREQ(2.61)
testcases/realtime/configure.ac:AC_PREREQ(2.61)



On Tue, Jan 3, 2023 at 8:45 PM Petr Vorel <pvorel@suse.cz> wrote:

> autoconf 2.64 is required by m4/ax_check_compile_flag.m4
> (for _AC_LANG_PREFIX and AS_VAR_IF).
>
> Testing on old distro (CentOS 6) with autoconf-2.63-5.1.el6.noarch
> make autotools fails:
>
> aclocal -I m4
> configure.ac:397: error: Autoconf version 2.64 or higher is required
> m4/ax_check_compile_flag.m4:39: AX_CHECK_COMPILE_FLAG is expanded from...
> configure.ac:397: the top level
> autom4te: /usr/bin/m4 failed with exit status: 63
> aclocal: autom4te failed with exit status: 63
> make: *** [aclocal.m4] Error 63
>
> Fixes: a08cbaea73 ("Add AX_CHECK_COMPILE_FLAG() autoconf macro")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index 1ab7cc60da..c2b0f48e79 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1,4 +1,4 @@
> -AC_PREREQ(2.61)
> +AC_PREREQ(2.64)
>  AC_INIT([ltp], [LTP_VERSION], [ltp@lists.linux.it])
>  AC_CONFIG_AUX_DIR([.])
>  AM_INIT_AUTOMAKE
> --
> 2.39.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
