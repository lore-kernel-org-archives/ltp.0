Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AA5D637B2
	for <ltp@archiver.kernel.org>; Sat, 20 Dec 2025 04:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766205174; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ljTfoTpECVeQVl1oyKqvHX6hvLp/6YjQHfIk7koclJU=;
 b=LQ9dIZvXRSGWe3jKLWP3RO9ocpT/2rLlLzoYwtMhYe5Nitw2fvDz97ctEwcAseZdB628I
 rWEQmmA8gmBtsqUxlBWxq9Kn86f0yVzXMvap4UnpMAR81LA02d8DGcI/MGAE/kWp3sVONhA
 syHkOSrI+X3EDgvtv51h1z96iIGu9BM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7ACF83CF798
	for <ltp@archiver.kernel.org>; Sat, 20 Dec 2025 05:32:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03E743C072D
 for <ltp@lists.linux.it>; Sat, 20 Dec 2025 05:32:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 39F7B140121D
 for <ltp@lists.linux.it>; Sat, 20 Dec 2025 05:32:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766205146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FUd/XpdqMU0hp6juhnbQ3vGqZSrd3uitFoysbeOoLVY=;
 b=FEPxj3ktgU+eYgMXbkLOElAP8l8omcUj6G3tvDGPovFbVPM+vil04sCQwcotQzOhndMQ69
 W03voTxVou5jM2pJRosTEfqPnZXnQ07hgCnCTq1Q/6aFjFCFgfPivsop06TYOyo6hw+FOt
 Y7PqmhmpvZl8i7JmlmBwWm6K4ZejyHU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-B8pimi3mP7eEMWudKaptcw-1; Fri, 19 Dec 2025 23:32:25 -0500
X-MC-Unique: B8pimi3mP7eEMWudKaptcw-1
X-Mimecast-MFC-AGG-ID: B8pimi3mP7eEMWudKaptcw_1766205144
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-64b98593517so1431874a12.3
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 20:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766205144; x=1766809944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUd/XpdqMU0hp6juhnbQ3vGqZSrd3uitFoysbeOoLVY=;
 b=NJ1WAAdQ8TqXpRfYU/tKdAsepbFgpdALMwctakRY2bzJZ1hBri6z+dH5vwPueoPC51
 UxO2DxWaCKqnaTzAmwjslfTPQfBqJDyla7sAPLbFMsa0AiGcs9KlYZh6ddpqoToBq/3/
 kmwAZu0Sbnj1Ht1glAQBXhmqZkz6dycD6es55EjecH2El03qwTM1aAZZQ2VIk8AruVZy
 xWmuaRpGP4gwmzDRWXqbU5km0Dxta3hxXg+cw3SY33xgaJ15/fmLlYw5zll5Dn3ziHlI
 /WAJpi0Cp0MEe5fPDv29eHtt8IoUMZe9P05q3DDc9vamKsq1OE2glWb24cmgKom2rGPq
 T0Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUae9hrH5asE9XmHzFHB2ZB2VPb5df/7pBb4ewPfMjL8ia1+HJn4xvrwqLxLZVYBdkpe9s=@lists.linux.it
X-Gm-Message-State: AOJu0Yxle/pSo9zxfLF/FurYXkXFal7FkSMus3S6qE+sNKKOHQy01Z3g
 H/LyGC9NDkJRQU1n0fANuzQbMoMbc1LP3pdgsuHG84PtUSOU6kosKHugbdRj6Ge6v0S16zj/zv9
 qpd41HG4Qt/fLTHu4lvp5CGswSfVxjNrBKAeweBegACJqsKGOa8/cBsVlQRPqDMJ9BNyUTSIZV1
 vZxfgy0M9FCpm74P48J4V7ZM9kwes=
X-Gm-Gg: AY/fxX4FCRX/0N6t5YJX8bnzpzgIXVLbYx8oc0VkJenRPTWDoj0u35nxnQiNgEP7TFG
 KCKFYXF1yjxIL5Hb9xGoQVyqfgODny+PxJAqRh62RiwCBJRRm+Y1Vw4DWLsW47BupoTBowIm2SD
 JkNRIpLp0Bud+rAZmvAtEZ+r8mnmyhkr28IAsu9uLcpUcKcUdhQ54kWoCiFEvvtCXuWNA=
X-Received: by 2002:a17:907:608d:b0:b76:f57a:b0a7 with SMTP id
 a640c23a62f3a-b803705129emr555930466b.31.1766205143832; 
 Fri, 19 Dec 2025 20:32:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmrjU4Olj9weg2zcH6dhlankEN+oqrdjUIH+wSe6bVhlAksaBsy0xD6zcGeyLHwyRM8weXvYCfIBE6pBGegN8=
X-Received: by 2002:a17:907:608d:b0:b76:f57a:b0a7 with SMTP id
 a640c23a62f3a-b803705129emr555928966b.31.1766205143477; Fri, 19 Dec 2025
 20:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20251219094219.151887-1-pvorel@suse.cz>
 <aUUteQjVmMx1R_X9@yuki.lan>
 <20251219140216.GA247368@pevik> <20251219144102.GA325483@pevik>
 <CAEemH2f2nhCBzxw-5u5qGnDS9BcogD-KWOd+mrOoLvmJ0XPR9w@mail.gmail.com>
In-Reply-To: <CAEemH2f2nhCBzxw-5u5qGnDS9BcogD-KWOd+mrOoLvmJ0XPR9w@mail.gmail.com>
Date: Sat, 20 Dec 2025 12:32:05 +0800
X-Gm-Features: AQt7F2qr6WK9kx7fdLoPXSxZZ4jbJApC5N4I769zc5V_nLoZNQibvy8EU725i98
Message-ID: <CAEemH2dts8FsEAM7gfKQjSv3ohkVehy9fXSf09_bqLfoDnUf1g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UdIH4_TRI4oxRl75NnaqLHR0jvOMMLjKaRU1Ca7PEJg_1766205144
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 1/1] swapon03: Try to swapon() as many files
 until it fails
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> is_swap_supported():
>

Or, naming it as is_swapfile_supported().

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
