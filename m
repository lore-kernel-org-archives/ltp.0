Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F7FC5321E
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 12:00:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2ED2F3CAB70
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 14:00:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EEDF3C01D4
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 13:59:47 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF8081401238
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 13:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724155185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wgqXYkAL+pnHPV0/KxmTFNj1xnykkUjbuEmI5gIsq04=;
 b=PXKcw0qIN8tKO3OQsu5t8vXxGxoCPhdAqkB0osgJ91eXrvfVbCJKy3LuUxEmn/88fxr1Ih
 hWlGnpv6mHYb5liB3kfvEbLruodrNCtkKfaSJAN0porOMN6yqi2OsyC6YePBOxwmdBKRWX
 d3J9iJ0ucPV9OdrrHso98XyVjpiy49I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-vWHmFjFwPXCbsDAmp3k-LA-1; Tue, 20 Aug 2024 07:59:43 -0400
X-MC-Unique: vWHmFjFwPXCbsDAmp3k-LA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2d5cd961ba3so330482a91.2
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 04:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724155181; x=1724759981;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wgqXYkAL+pnHPV0/KxmTFNj1xnykkUjbuEmI5gIsq04=;
 b=MVK7xlIS41IENyv1VdHD/lZiZICEi/geEZK3vFSAoVocQx+FrriX4GwloF5P8k+0ZN
 zKSh1dIBiodygeJjhl4LeyZSIrZQUjnEmO0NGq2415EzrIfRVX6Pvj65TXOf7uVHTmi3
 Yf6EX93tMg3d3otOp+FEtaIOKDPfZ8ZB5E5M+SEtxeDrwJOYlpQPZ54WN65eHERY8o/x
 u4CrTazGD4RRvBqRp/v7Ps5zMB21tZDzdAneA04o1QP/YlyMeUSFZfoFJZbeUGplfC1h
 e/eHQ6m+UMtIYgoPlSgGmi0Q4tlJcHVSz4BokU4ub9U4sfmn8oqT5ci/cHElgzvuHnWs
 28EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8g9W2ziKkiibDyAnvgTkwU+1lUWvbq77rNNjB5y/OzuPwZJwkvNFvsbmf2Kfl2JY/H4/S19G8fsLN5C79bqzzDLQ=
X-Gm-Message-State: AOJu0YypT/Gspgc6Sz4/+RTyRzaH6JmBNioCibqufnwCCfj3KjOsK1Bq
 rn4XPN6Y2J+RtN6qhbh/WSbZX0JvgxPTQsP/DZHiQ9djEpeIol4uNmLTMt8SDj3nAVlR4aZUigg
 YgEybScc03z+mvdsGAfXHXyh8LxafoRmxCHTC2p7iNvM5lQ/+1s2X1BaPFuIDqKteIauLLaLoYr
 b5X9SC5FgFUM0LlA0wP8zJChQyHE0zz6d0Pw==
X-Received: by 2002:a17:90b:4b01:b0:2d3:ce96:eb62 with SMTP id
 98e67ed59e1d1-2d5c0ed4214mr2149359a91.38.1724155181241; 
 Tue, 20 Aug 2024 04:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjH2vU8WOYqZ/TsEtW1XZhvp3eRx874JFYTdKo+3wSUkp8+jhlVJRIrfU6GkHaGyRa5+uKJBLxdg16G7Pqwy8=
X-Received: by 2002:a17:90b:4b01:b0:2d3:ce96:eb62 with SMTP id
 98e67ed59e1d1-2d5c0ed4214mr2149343a91.38.1724155180935; Tue, 20 Aug 2024
 04:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240819082213.2150403-1-maxj.fnst@fujitsu.com>
 <26537985.1r3eYUQgxm@localhost>
In-Reply-To: <26537985.1r3eYUQgxm@localhost>
From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Aug 2024 19:59:29 +0800
Message-ID: <CAEemH2e1xQwU37-4acxv7fxa2GN_ai9ROq5AeAvYuDWVaf6s5Q@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] getdents02: Add case for errno EFAULT
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

Avinesh Kumar <akumar@suse.de> wrote:

Hi,
>
> Reviewed-by: Avinesh Kumar <akumar@suse.de>
>

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
