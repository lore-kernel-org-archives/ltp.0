Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AD0ECE57A
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 14:03:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B56863C1810
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 16:03:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0463F3C0FC2
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 16:03:04 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9CDA7600459
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 16:03:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725890582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6sINC+9gak16suJjf6hGFvIkF+cvLF9XT9pjAkduIYU=;
 b=BLNoF+fR6hehI/6D2XZBotzJ28N3fEcrt6F+1saJ035hQdEYm9vpxK2GHgqoEPHWp+U0xU
 cv9VyLc+zlA3W5MglKEDuBXpvw8tSJT3WyOduFPE/9KHsa5edXnRyfj0thVM8oL965yssy
 gQx9TgxKvvGRW3FQmC7LdwVNQMIKHsE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-fPfjtg-SOXyBYJRHTTxHOw-1; Mon, 09 Sep 2024 10:02:56 -0400
X-MC-Unique: fPfjtg-SOXyBYJRHTTxHOw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-718e065f057so2738151b3a.3
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 07:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725890574; x=1726495374;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6sINC+9gak16suJjf6hGFvIkF+cvLF9XT9pjAkduIYU=;
 b=W9SLPXBae70rNoV1QCydZzeMNDiEbSI0trSjS6R16FfEkt1NmhrW102X7wONZOdoAV
 PWp8j0D3jfVm3Yr9iAWUTGCcnw1ZgAyM3eRWWn94SSny7MKc1AxgfgutovzHglKHff9M
 ZI+RoiXv6DN8L5lU5HNpIndDWo5WA8McMzXbdNeirGiW0V4Q6rdpxv6hLvaWDKXZWjL9
 cJMBWzy32R81RvQMgMOziUwf1k3zCD1IvkF8bG776U2Z8nVC56t5W4JdgTBdq0B4EwWE
 eU/847mYykAl1lTc+f/C2nxBLWp4NdO8B3HSNA0OgTgNY/nWWGwP5LczYAVAohMHYL7x
 IP5Q==
X-Gm-Message-State: AOJu0Yxt9fJ5idO3hjWPEbJIbDOHKqbm+TfG2yBTi26QZRFEKTFPJsEf
 oJybjjbl7J70Qjry+kW59IaKEKd9h6neIio67R4mT7AatXeMPqpNExgpp5mL+R3xx0jHPtGwJpM
 mQCSic+hzFhgwCiVVlTQUPRCp9rg7jJ1FzE3OfREpdQjk5ua4zuDJRyLiXy5dqOoNvzZjDAKnb2
 RpQB8LlJ3vS38U6tE5GoVqoRnDiZGf4ldSKA==
X-Received: by 2002:a05:6a00:2d15:b0:714:1bcf:3d93 with SMTP id
 d2e1a72fcca58-718d5deceabmr9993726b3a.5.1725890574501; 
 Mon, 09 Sep 2024 07:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGllam7/chH91PF/TCN8AsdNFew+FD/mBwPqcpqP8dRkf2Ilc4LsqzEOsCRCau3wXmAHZPAy5hP+AIqtxQiqaE=
X-Received: by 2002:a05:6a00:2d15:b0:714:1bcf:3d93 with SMTP id
 d2e1a72fcca58-718d5deceabmr9993680b3a.5.1725890574003; Mon, 09 Sep 2024
 07:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240903140326.773060-1-pvorel@suse.cz>
 <20240909025243.537071-1-liwang@redhat.com>
 <Zt7wE0QO7eTgUKOq@yuki.lan>
In-Reply-To: <Zt7wE0QO7eTgUKOq@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Mon, 9 Sep 2024 22:02:40 +0800
Message-ID: <CAEemH2fDpJ5m-KhtN9fh22cphRgPEVcFHo2i23owY+bxJTLqfw@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] swapoff01/swapon01: Define max_runtime 1 mins
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

Patch merged, thank you all.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
