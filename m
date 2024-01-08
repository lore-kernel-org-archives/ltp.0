Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EC6C3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 11:27:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E76E33CFE20
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 12:27:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B07523CDAFD
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 12:27:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0AD4E1B61FFF
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 12:26:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704713166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4vp0tw4MD1LSDrC7zg+sq8vspNShRlOIZTOV8Cf55ng=;
 b=ZRqWcRotXIMdQjedjHUQN/YVsIsgQOCixUVxWl179+sgPICriWA9JJ73b3TdJt9dBub/J1
 +WcHfdtH1YKVlUXaoEQz7d42XmBwPBgLkykQTLAkfhfT/2jpyjs5RnXj8sNjqup3gTIKeI
 hMtwZ+7v93F+e4rQv8enn7gOyuxxwBs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-FE2Yu6PxNp-OlYVfIZk_gg-1; Mon, 08 Jan 2024 04:23:15 -0500
X-MC-Unique: FE2Yu6PxNp-OlYVfIZk_gg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ccc7c01bd7so10755031fa.0
 for <ltp@lists.linux.it>; Mon, 08 Jan 2024 01:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704705794; x=1705310594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4vp0tw4MD1LSDrC7zg+sq8vspNShRlOIZTOV8Cf55ng=;
 b=VCA+MjWHF2FwiEdGd6Gyy8ox9LCQK+wcCBPQpvgL/CASF2AmuT1WgnDNAs+B4AnuIW
 z5fcgAIkOCyvYJtdvuWYafysHYqZOt7rUZedKjGY7ufbabp4s2bB8ujGtM8zmU9maQI/
 ZvI9GU92LY7xagrFglAR6HksPQxCoDPTVEy16rS2jCvoA+s5hvnIqvYUF8zlDUUrOI1/
 R/B/PW2tHdcaxrnDWXconJzc/s01kYgDlMXI8CDCD4gHvLIsR9gXQVB9q9eL2iLRIXUy
 g6wm2wz5gAZkaVlHdrLE7hsySosMa+IrOTqm9KPsCX9RuqkmGSpmNdDsjiSRVahRnqXO
 Nr9A==
X-Gm-Message-State: AOJu0Yz+F5XOrCzxwGR7FJhlso1m6bQdUUsgZjTBFECOBn68n68MWkRj
 EprJXk/FZpliFEguLiWtxWz611l8hv0cc9P3PurLbV7POLm1pI6ndA1Y5fwCQ1YWaYnOLZJect1
 aD+tlmY1TFEJB7SVDPohprrXc2fNSM1bJ2zk=
X-Received: by 2002:a2e:99c7:0:b0:2cc:fc52:df9e with SMTP id
 l7-20020a2e99c7000000b002ccfc52df9emr1045876ljj.12.1704705794551; 
 Mon, 08 Jan 2024 01:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCHNoAT2SNSI+3nYROznNjexAzUznygozNHYb9bml/l8qQCXyAYWSZDl5d1EHQz5Q4wsjVU7nGicQBeIRePl0=
X-Received: by 2002:a2e:99c7:0:b0:2cc:fc52:df9e with SMTP id
 l7-20020a2e99c7000000b002ccfc52df9emr1045873ljj.12.1704705794290; Mon, 08 Jan
 2024 01:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20240105072843.2098332-1-lizhijian@fujitsu.com>
In-Reply-To: <20240105072843.2098332-1-lizhijian@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 8 Jan 2024 17:23:02 +0800
Message-ID: <CAEemH2ddinSLqF1kKdG2Nf__aa3jraH+NtV1aSFO0=u=MgGtTQ@mail.gmail.com>
To: Li Zhijian <lizhijian@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] syscalls: setgroups: Add missing gitignore
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

Hi Zhijian,

I have pushed the patches, why resend them again?


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
