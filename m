Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BC1C433F5
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 11:10:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA4123C9043
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 12:10:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E3CF3C9017
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 12:10:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EC90D601AB7
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 12:10:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638529821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tFUuITrQBCvAn1Zh1DpHWRQ31+JIVCyI2DZHbbDQQOw=;
 b=d7EidpaQyghnOM9awgiEkOwoaN4f6nAaEwDKtT/Kk2T47H4dS9F2pUyqD52gScaZPAx89z
 hSg2LxIrxWh9BIFNAN49FuDqfyB8m4f5GW8MGsQJPNHh/efCKUg3IYdZjJRrXjM49x/C8b
 PDKTewyJ5sCQjNIFpE5EOuKUHT7P2dE=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-bekL8u0tNrKvqWiD2kGhmQ-1; Fri, 03 Dec 2021 06:09:59 -0500
X-MC-Unique: bekL8u0tNrKvqWiD2kGhmQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 v2-20020a4ae6c2000000b002c622008d77so2218819oot.12
 for <ltp@lists.linux.it>; Fri, 03 Dec 2021 03:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tFUuITrQBCvAn1Zh1DpHWRQ31+JIVCyI2DZHbbDQQOw=;
 b=3dJCxBbvoab/mxMrH7IToyEtKoY4aEFtwBSQtka4UrWJ8ddvMEOMnzOPDUofPP/Wia
 sTVO6Qj0qAY6VzPukauTTfhzrjTw5Ja5laxw5WQVQdHp5qDv/t1W9TNZHfczg39Yr8iw
 G4r4Rhrpn1OLSMoz2Kgh2pvmmiWC1M0P1mTdCN8C9Gx9qW6Y4XAcfhilqj97yzRhjIfQ
 8Js3q8oPSuOrRk+j4grXTTk38Aw+iywYUuwfXDDg6krth6ocfxBNK0PDcix3iqbve7cE
 cuSWHTjGa2tHJR0YjUjB7era82V9wN/3aQ4TRNFlFjq6vuGBnFR4SY7yc2CiNOYtVNNg
 s1IA==
X-Gm-Message-State: AOAM530dYuWrz0egS0KAiLna5W2m4XguJTGpex3pOwn2iAmQOjkWJ+LY
 OfmFco5G+gWIdV9a7/yC8ha9y/MbGmGPUleq2AiuamfMnVENnCxaz78Ngm98xwMOfHWZbp2WYnQ
 bJasZiHev0g7RCi4Un9FGUVrt5gE=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr15936546otl.85.1638529798446; 
 Fri, 03 Dec 2021 03:09:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsMJaJsw2N8aHbZ7RzGpWhUhpIZytYJboKrVESsBTa8eKCFF0iHSOYkA8S1YMLmfprxR6WD/aEl3/OwktSZPU=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr15936528otl.85.1638529798151; 
 Fri, 03 Dec 2021 03:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20211202203006.32259-1-pvorel@suse.cz>
In-Reply-To: <20211202203006.32259-1-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 3 Dec 2021 12:09:42 +0100
Message-ID: <CAASaF6we7wki=+4Rt_8NGg848735VdAUeaMSGNUMBcL-cOX5pg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] configure.ac: Print summary
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

On Thu, Dec 2, 2021 at 9:30 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Due many checks of structs, members etc are chosen testsuites,
> presence of used libraries and docparser config results quite hidden.
> Print them as summary in the end.

Color output would be nice too. But I find this output useful in plain
text as well:
Acked-by: Jan Stancek <jstancek@redhat.com>

>
> Disadvantage of this is need to keep sync m4 macros with configure.ac
> also quite easily results can be misinterpreted.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  configure.ac | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index 4751b14d2..063a8a9d1 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -381,3 +381,26 @@ test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
>  LTP_DETECT_HOST_CPU
>
>  AC_OUTPUT
> +
> +cat << EOF
> +
> +TESTSUITES
> +open posix testsuite: ${with_open_posix_testsuite:-no}
> +realtime testsuite: ${with_realtime_testsuite:-no}
> +
> +LIBRARIES
> +keyutils: ${have_keyutils:-no}
> +libacl: ${have_libacl:-no}
> +libaio: ${have_libaio:-no} (aio: ${have_aio:-no})
> +libcap: $cap_libs (newer: ${has_newer_libcap:-no})
> +libcrypto: $have_libcrypto (sha: ${have_sha:-no})
> +libmnl: ${have_libmnl:-no}
> +libnuma: ${have_libnuma:-no} (headers: ${have_numa_headers:-no}, v2 headers: ${have_numa_headers_v2:-no})
> +libtirpc: ${have_libtirpc:-no}
> +glibc SUN-RPC: ${have_rpc_glibc:-no}
> +
> +METADATA
> +metadata generator: $with_metadata_generator
> +HTML metadata: $with_metadata_html
> +PDF metadata: $with_metadata_pdf
> +EOF
> --
> 2.34.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
