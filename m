Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5B1C636CC
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 10:13:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 974E33CC0F3
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 11:13:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 523253C9339
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 11:13:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 06EC560070C
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 11:13:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675851209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=24zEm7ckkzX08VQOgNW5Py3xKRWE0Rq808VZNq7h03A=;
 b=QWOrtdF0tjL4rnQ1Aoyz+GEcUbVCEcxLWsAGbPVLeyv11M05DeUIHiUTnnRTVJ7Es8ekvV
 ertENfcbwNTSPx+FnFJA2mF0DbE/VrTWDIMeGtgQdPrjALxvxQdVbeeaNrTmDAz3A5BTgj
 i51zygZn5QqCd0wkxkvsb3CfKPg60Mo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-7ByEGoE4PhqRoFhW0hh-Hg-1; Wed, 08 Feb 2023 05:13:27 -0500
X-MC-Unique: 7ByEGoE4PhqRoFhW0hh-Hg-1
Received: by mail-wm1-f72.google.com with SMTP id
 bd21-20020a05600c1f1500b003dc5cb10dcfso8667683wmb.9
 for <ltp@lists.linux.it>; Wed, 08 Feb 2023 02:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=24zEm7ckkzX08VQOgNW5Py3xKRWE0Rq808VZNq7h03A=;
 b=OFtdtyTTCLTqhXJeqXR93V6YvM77dx22lz2vTixpeXJCMt3rM4cHtvXtkB/cOtiBNs
 /UOgvCadcmJwqCbzHvbiSYxuQRlIj5xl3++Y0YyQNqnXvx6KEs+fKmLqXHtnnpMfJspH
 aeAhBQrtEYKj0UF9/KmN0m+EmAJduzGfWfM8lLh/lrxR2EBXgxdM2hIDiz+q29CcrMju
 zX/xzmqGVz5ntvglhV+OPsqZqOlQ3Nk2yto4GjFZQDPwY5+I55MNCKjPaVlg2yZxYKsF
 e3IS6XaN6VKFFDk0GNCuVg/sf/On0qAcGENMCiWK+8s/HAnrxXW/zYpsIS7dMhRjQ8ZD
 1S1g==
X-Gm-Message-State: AO0yUKXDO86/OV+e2dON7ORJxtEr2VlMgyjLkM9Eovz306V741TSX362
 zt8QHjgKkVsSEzPEV3ofDXh7Fcgb/aQm4Tlce7GgIdgmLl3ZGM1MHNUtlygrxiSkE+83ldNJ68T
 BgvAdOT9ilGGdg2s1DkXKbT0DYZ0=
X-Received: by 2002:a05:600c:1d05:b0:3df:4bc8:edfb with SMTP id
 l5-20020a05600c1d0500b003df4bc8edfbmr168443wms.168.1675851206610; 
 Wed, 08 Feb 2023 02:13:26 -0800 (PST)
X-Google-Smtp-Source: AK7set9mZ/LMqWvZvNACoVy9HZp1KqZmnpvhRZoH+rSWqsU5xLVQeM43YMtBr3efh5VO7TOrG/WQC6cni26b0YTYD4c=
X-Received: by 2002:a05:600c:1d05:b0:3df:4bc8:edfb with SMTP id
 l5-20020a05600c1d0500b003df4bc8edfbmr168441wms.168.1675851206460; Wed, 08 Feb
 2023 02:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20230207131714.2500-1-pvorel@suse.cz>
 <20230207131714.2500-2-pvorel@suse.cz>
In-Reply-To: <20230207131714.2500-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Feb 2023 18:13:15 +0800
Message-ID: <CAEemH2chcTe263-zqpSF2Gc2CVc8NC+G-KZsFMbwoxEKyjA01w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/3] ioctl01: Add default tty device
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Tue, Feb 7, 2023 at 9:17 PM Petr Vorel <pvorel@suse.cz> wrote:

> Saves user to specify it when run manually.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl01.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c
> b/testcases/kernel/syscalls/ioctl/ioctl01.c
> index 1be38e79d3..cb184aee40 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
> @@ -27,6 +27,7 @@
>  #include "lapi/ioctl.h"
>
>  #define        INVAL_IOCTL     9999999
> +#define        DEFAULT_TTY_DEVICE      "/dev/tty0"
>

Hidden the device path parameter is a good idea.

But maybe can we add a function to find available char devices instead
of using the tty0 as default? In that function, we do the S_ISCHR() check
and return the valid path of it. Then the rest test (e.g. ioctl02) can make
use of it but not set the specified device as well. WDYT?



>
>  static int fd, fd_file;
>  static int bfd = -1;
> @@ -70,7 +71,9 @@ static void verify_ioctl(unsigned int i)
>  static void setup(void)
>  {
>         if (!device)
> -               tst_brk(TBROK, "You must specify a tty device with -D
> option");
> +               device = DEFAULT_TTY_DEVICE;
> +
> +       tst_res(TINFO, "Using device '%s'", device);
>
>         fd = SAFE_OPEN(device, O_RDWR, 0777);
>         fd_file = SAFE_OPEN("x", O_CREAT, 0777);
> --
> 2.39.1
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
