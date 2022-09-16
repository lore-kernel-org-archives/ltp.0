Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E349CC54EE9
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 09:04:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CF473CAC78
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 11:04:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 297C63CA493
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 11:03:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 057DA1A006FA
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 11:03:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663319031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7JxRClYjESsE4iFvNbZohDxsDHBqkwqlIzswY+6Nlc=;
 b=ENQZuzS+dkotxQJM79r+FwqiJUyS2Gok8p+6HAZffRobQjD/UaGSyMetnNquTlw+d370Gq
 6utCUPYYzaaWnr/JsxWUwLWmc1aNQgNbgIkm14dAzbjnckL/wnV4aFooUyXTREc4OWF/dE
 qecLPZmOy4A4qmi7kclkhWtZqZBJj1o=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-215-bBtmt5FpNvuvktVX3wVtCA-1; Fri, 16 Sep 2022 05:03:49 -0400
X-MC-Unique: bBtmt5FpNvuvktVX3wVtCA-1
Received: by mail-ua1-f69.google.com with SMTP id
 b28-20020ab05f9c000000b003b42433bfc7so5578703uaj.2
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 02:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=d7JxRClYjESsE4iFvNbZohDxsDHBqkwqlIzswY+6Nlc=;
 b=APmGW17XyPH5+j8tvUNJfPZ1wLhI2WCZ/Ep83vxEgEaEgWAEfJx6gYV3nZweVBq1MF
 zNAFjIoacc8783UIunYzAnmB/4oob6p620QkCO9P2MXohMhOnliCPxCK3XHjrktAvhHW
 uWDU51ZYAL4EE2QV4oRIf6YhMx58XNImZlhB7w9UufJ9pPFAFmc0r1yzit6fRpObXfqd
 mpvWtJaDKAZQQcVNh4Ie3wnt4JdRyezWr9QTls7dyI1OADDWwNoXRwpXtjbGkFCwtUQa
 44Hr7Ar6ZRQyROSOhpJJwNQCbxwr/GpmoTSpf5JYfsuRUK4UO8vcvvvn9XN7Hc8e6NE/
 NVgg==
X-Gm-Message-State: ACrzQf1Y5w/8v04bgO8exQBIh+pwX/i0FLXRRR1G7St8q6Pe43xr8UVx
 DOiW6Qi7dFVs5z9v2LAT5FJt70jsTRpx0gUxOHjc5x+bKgNGLNekLIfzb8xXIQU8HrCWg9aSN2i
 151n6+/H4xDjuGdhN73BYFe/DrOY=
X-Received: by 2002:a67:dd88:0:b0:398:d3f3:3cf0 with SMTP id
 i8-20020a67dd88000000b00398d3f33cf0mr1689492vsk.26.1663319029076; 
 Fri, 16 Sep 2022 02:03:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6KLim4WcrOLTTCsblq3OBOPhYe0kTVGUhPgdnLuIyQZC5FcyXqXZQoaLcqOrUbhgNDsHgGXUqvJMtWX1fjRdU=
X-Received: by 2002:a67:dd88:0:b0:398:d3f3:3cf0 with SMTP id
 i8-20020a67dd88000000b00398d3f33cf0mr1689485vsk.26.1663319028839; Fri, 16 Sep
 2022 02:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <19d19a5d6bbf5b19940a936b62db6dfdd29a085f.1658313770.git.jstancek@redhat.com>
 <YtftUlDCvP5uchp9@rei> <YyI+gHa7zCBIyjcg@pevik>
 <CAASaF6xX=gBBjOVEnp6U4HpjfuzBVpbkyD1i0keW+iVjSCJZWg@mail.gmail.com>
 <YyM/R3TuHGBsUDQY@yuki>
In-Reply-To: <YyM/R3TuHGBsUDQY@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 16 Sep 2022 11:03:32 +0200
Message-ID: <CAASaF6y0_8vEm6+FabPd4iW_50UoFpUbJ3OKbS4Qti4wwcFUEg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fsync02: restore runtime to 5m
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

On Thu, Sep 15, 2022 at 5:03 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > I put it at todo list, but haven't dived into it yet. For release, I'd
> > go with timelimit
> > extension as that can't cause any regressions.
>
> Let's go with that then.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Pushed.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
