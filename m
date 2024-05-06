Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18073C25B5F
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 11:15:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 588F53CD915
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 13:15:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F197E3C02C5
 for <ltp@lists.linux.it>; Mon,  6 May 2024 13:15:33 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 46B48601BC5
 for <ltp@lists.linux.it>; Mon,  6 May 2024 13:15:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714994130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFliQotsfgogNdz4vzOP08dzke/h7wyopNfq3RAZy20=;
 b=BxPwor1K71eLUymI0gltS1czEQ1h00Ezbfh1WQT3X8NLFol1M4V7vBWTrS+D0AP+Dc9XmY
 QDIXcF/D3/wuKYfji+8ic8v5slrwt3FlBT4qxwbWkYLmqHIVHQr01tH0c1SOH4hQOCefef
 EhHo0cc90phgBT4nPb23dn6d10P2Uzc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-27EKiEMjN6SnC_4ibUEN0w-1; Mon, 06 May 2024 07:15:25 -0400
X-MC-Unique: 27EKiEMjN6SnC_4ibUEN0w-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2b265d41949so1733137a91.1
 for <ltp@lists.linux.it>; Mon, 06 May 2024 04:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714994123; x=1715598923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFliQotsfgogNdz4vzOP08dzke/h7wyopNfq3RAZy20=;
 b=Mad+WMjlj+rKIgQCP5RU29I2CSyVWUY4Ykn5jktKO4gJ0IFgU+Dh8PfRLEm4PUEnZW
 /ZxhZDuIXUKWeDfstmLQCdh4WEpdR6mPrsBtj6IcrovZEw4gVE6ngxEh9hQItN6kJj+f
 5+FpNQFHtPfNVzRCWyCuor+5p7BYavlrnW3Vo0rvhUrjSoB7V7V95F58oEoRrZ6bAsOl
 rmDKe2jZC5v/XTTsPN3ePL4P8Isg6rXxAkG8tXyh2MIbjMeJCW5+/9rlMbiKauOj184g
 5gUqih8itiOAb9fv5Yom+iWcZm83mUjj+7bnIEJtY6lccCz6+htVBX8K4YlvWzomiufU
 z23g==
X-Gm-Message-State: AOJu0YyAO8zqENYlO65MoFYjWONDr2WHIlAtuHJ2MOzr/B1U5cQRZvRy
 fClEBiwNc2NT2Jl8fNFpIP6NUKal1jscHBABk3ZO6vwIFNHTNZnlSCS//xZfX6DdKAItTrFDEmt
 Ku3xW0jyD0LU0PNCrExNp4LRAArRl3+Gt4ozvlvH8RtuFhVNHz/JUiJmuNJy/UX5VrEap/WvL82
 QdmJIbvMB56ekMEIFckVT7lzNuYDzPnDD0Vw==
X-Received: by 2002:a17:90a:c68e:b0:2b2:cb60:6eb8 with SMTP id
 n14-20020a17090ac68e00b002b2cb606eb8mr7757251pjt.32.1714994123300; 
 Mon, 06 May 2024 04:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNbwuxqz4DZF9EcADGORZT16JdX5cSsSWskzD4sBJUinPj/cuFQ5Kq5xq1MuLbuaHVlZf2Z077M0GIjpPW7X8=
X-Received: by 2002:a17:90a:c68e:b0:2b2:cb60:6eb8 with SMTP id
 n14-20020a17090ac68e00b002b2cb606eb8mr7757229pjt.32.1714994122769; Mon, 06
 May 2024 04:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240506053207.12308-1-liwang@redhat.com>
 <20240506053207.12308-2-liwang@redhat.com> <ZjijPWk3RyMchyad@yuki>
In-Reply-To: <ZjijPWk3RyMchyad@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 6 May 2024 19:15:10 +0800
Message-ID: <CAEemH2dmALR5cxcee1VmK3bcLVQGu5xYxQu38PoytSvkLUdcYw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [Patch v3 2/2] kallsyms01: Utilize ksymbol table for
 unauthorized address access
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
Cc: Rafael Aquini <aquini@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cyril Hrubis <chrubis@suse.cz> wrote:

Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

Patch applied, thanks for the review.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
