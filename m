Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3D5C6FD20
	for <ltp@archiver.kernel.org>; Wed, 22 Mar 2023 02:04:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 113CE3CE3B4
	for <ltp@archiver.kernel.org>; Wed, 22 Mar 2023 03:04:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC3FF3CD30C
 for <ltp@lists.linux.it>; Wed, 22 Mar 2023 03:04:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E230310009B6
 for <ltp@lists.linux.it>; Wed, 22 Mar 2023 03:04:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679450663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1SnDbAgrTbYuqrNF7Th53ghSzeATVrAjAX+pAMG9dnU=;
 b=GMShrgckhRZMn28A4JpLueY4pDLPjChUVV6rf287vR+XcfwaJQVvVqGptHikiuU68UxJa+
 1euGtV3GxZisJQ2BuHomN5tnPou1QtOrqX7dX63sBxBGtWwob6sa8cDo4uY0la1TCUJxfX
 HPXuzRjOI0y7U3GWO4JCF7HzwfHCt7k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-QW02SEn7PYa5RfCkpf_GsQ-1; Tue, 21 Mar 2023 22:04:21 -0400
X-MC-Unique: QW02SEn7PYa5RfCkpf_GsQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 i3-20020a05600c354300b003edfa408811so3719142wmq.1
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 19:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679450660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1SnDbAgrTbYuqrNF7Th53ghSzeATVrAjAX+pAMG9dnU=;
 b=kWMY7mBQCr6xhVnlxHG3levbBM85d9yvX9o8PS9OSyFq7QYuVElyd22vQPAD4sq7Jn
 iFFtvBC8xsMbTwjn0tfw5royiFrJ4kbrCdhapmP/eNFwaVqdAZafvRsrqlSaNKC4xmf3
 jYL+vE884u/He8J80zyNjR63tu+FXTxqtDRCgkUSneZns57gCdhTMnTiQfPMCzdQPPv1
 6L2TFTLEsKcpKSTWt/n9l6h30ZBAVdQSVFSXvo3GzjQNgQ1WkYpp69fTi7xsixqODQv4
 vdXyAricPRS7CnO2HZnIO9GkKm6MzWtjW2wHD9t24eUNjIAZAEorm8xWV5k60qn2tBOI
 L0/Q==
X-Gm-Message-State: AO0yUKV0JVtRzyDsVNKpeDxDzlxyGXLFC8yV5cRRSxPhiWpYxJJaERl1
 QWKWE5Us5ZbFLXKZ9Tf6sElJWkMnbPdPGMXhTZC6G0/ysmhYABSfzu92TlgYQgLV7XMIDEYKecV
 oPifb+9G0+yuhp993gvX/XrEkcEQ=
X-Received: by 2002:a1c:4c01:0:b0:3ed:4c9e:d5d8 with SMTP id
 z1-20020a1c4c01000000b003ed4c9ed5d8mr126302wmf.1.1679450660856; 
 Tue, 21 Mar 2023 19:04:20 -0700 (PDT)
X-Google-Smtp-Source: AK7set/vR1umQmwc/hF+Hxa7YZXRJocmOpsfXtUY2TqbN5cs1Go/BsWPR7wOERolBHQZ7zkLaHjko1d07RGCQq/FwX8=
X-Received: by 2002:a1c:4c01:0:b0:3ed:4c9e:d5d8 with SMTP id
 z1-20020a1c4c01000000b003ed4c9ed5d8mr126300wmf.1.1679450660567; Tue, 21 Mar
 2023 19:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230320092332.36187-1-pifang@redhat.com>
 <CAEemH2edWRT1f=8wb=qQn2=3L0CXD-sQ4qQUSk+DwcRWE8xqqA@mail.gmail.com>
 <CANKfEn7M8X8vKGVAUGRLkYh82vv_xBYg=n-pyU+sA7X=4UuX=g@mail.gmail.com>
 <CAEemH2dRTX4Ru161v4Fosnhy9-bX6jdd4Y=7gqhfGKDqEFq0mQ@mail.gmail.com>
In-Reply-To: <CAEemH2dRTX4Ru161v4Fosnhy9-bX6jdd4Y=7gqhfGKDqEFq0mQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Mar 2023 10:04:09 +0800
Message-ID: <CAEemH2fGPvEqChw0HanpHXqPm2wTK8tmbo+XX0F8xe_54dnOjg@mail.gmail.com>
To: Ping Fang <pifang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] getcpu01: Fix strtoul incorrectly returns 0
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
Cc: shichen@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Pushed, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
