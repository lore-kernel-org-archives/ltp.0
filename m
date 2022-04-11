Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B050BC433F5
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 10:58:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 648F83CA45C
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 12:58:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C84893CA2D2
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 12:57:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E4A98600066
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 12:57:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649674669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwmfRgkrXzSif891s6L2mY1MN3kWpJ+8H4YxU/DLAiA=;
 b=cJHSo8eJ3pI6gWs4p7E/OXcFOFHub+TksDdxoqLOWfC+H9Gqz8HzhDuBTiW+xfluY/ZIbT
 xKrEsiY6QQFhyAH3KVgQ6SDzCzxyywOqJF2Y6r12sN5wrf5ISmnhggmz2mv+S7FISSGofM
 CFVO4LAYhCtLjevjnTDkaDbvARU+TNw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-bgGdWPh7NquB81yxLMTgIQ-1; Mon, 11 Apr 2022 06:57:48 -0400
X-MC-Unique: bgGdWPh7NquB81yxLMTgIQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 11-20020a2e154b000000b0024967cd6752so5867997ljv.13
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 03:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XwmfRgkrXzSif891s6L2mY1MN3kWpJ+8H4YxU/DLAiA=;
 b=jUNsFnxDR7IHKveu/R9Yv9ItDPggQ/cAJh+Iu22TBeQoh9Fl4BmBoBVSOhSBWHPBP1
 tUn7nmawFNZ6xzhTUOQn5lFRHV+rKdqLOYvtwMC7orIPO5DDK5sXyRyhODdH9AMz0AdB
 KMXvlCDDw0gHDE+Ka08e9m3CjQCcW0lypRtUlo18PV3CeND5wtkv60xvFG3xt3M8xdXu
 OvuBwx5SOlacDkvozAKJZy0D1Fumi9adpcIbuZt+xftDEV0wr+MvDPQSoa10Q6wCsgLt
 W18zReqCdj30mszz16szgVwuIo03IxuIrz5IL3vOgHzwoGwRAlUS56T7mXfQSjkjEfQH
 vr5g==
X-Gm-Message-State: AOAM5338L8xRxI0in2TrRTJW/2nz7XaZw6eUfJLYM0ErX3jSeUhpGXG/
 NkANVzoZHUSiSThIGmsdOy1phxz1EWTBYbHr1edDduRj132W43N0nudj6pcdRYyY+fnaQHF6jyB
 clh8pPdrtLVH8HFumwwypCQpPYaE=
X-Received: by 2002:a2e:b0ee:0:b0:24b:4a8b:4f3d with SMTP id
 h14-20020a2eb0ee000000b0024b4a8b4f3dmr12165940ljl.252.1649674666788; 
 Mon, 11 Apr 2022 03:57:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhKBuS3uEFcpZxhEkCUgoSZsb+5qdLZNqfWgskyPcfcOyLwCrQl2OJyo/CmZJ+4//hRxKKuMMgJVQ2VgOobwY=
X-Received: by 2002:a2e:b0ee:0:b0:24b:4a8b:4f3d with SMTP id
 h14-20020a2eb0ee000000b0024b4a8b4f3dmr12165921ljl.252.1649674666402; Mon, 11
 Apr 2022 03:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220411094048.1143292-1-liwang@redhat.com>
 <20220411094048.1143292-2-liwang@redhat.com>
In-Reply-To: <20220411094048.1143292-2-liwang@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Apr 2022 12:57:30 +0200
Message-ID: <CAASaF6wZSGKi+ePOcYYiuvQ=RNhu5mPTrY-FFiRMA0UhMaO1Zw@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] pkey: correct the PKEY_DISABLE_ACCESS
 definitions on PowerPC
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Apr 11, 2022 at 11:41 AM Li Wang <liwang@redhat.com> wrote:
>
> Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e9506394a159
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/pkeys/pkey.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/pkeys/pkey.h b/testcases/kernel/syscalls/pkeys/pkey.h
> index 6e32326b6..6cda88ff1 100644
> --- a/testcases/kernel/syscalls/pkeys/pkey.h
> +++ b/testcases/kernel/syscalls/pkeys/pkey.h
> @@ -11,6 +11,13 @@
>  #include "lapi/syscalls.h"
>  #include "lapi/mmap.h"
>
> +#if defined(__powerpc__) || defined(__ppc__)
> +# undef PKEY_DISABLE_ACCESS
> +# define PKEY_DISABLE_ACCESS 0x3

Where does powerpc define PKEY_DISABLE_ACCESS as 0x3?

Comment in tools/testing/selftests/powerpc/include/pkeys.h says it's
older glibc that has this problem, but looking at latest glibc it
still defines it as 0x1:
https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/bits/mman-shared.h;h=00a1f27c0ef51de1ec657071c5744e09299f7ff2;hb=HEAD#l41



> +# undef PKEY_DISABLE_WRITE
> +# define PKEY_DISABLE_WRITE  0x2
> +#endif
> +
>  #ifndef PKEY_DISABLE_ACCESS
>  # define PKEY_DISABLE_ACCESS 0x1
>  # define PKEY_DISABLE_WRITE  0x2
> --
> 2.31.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
