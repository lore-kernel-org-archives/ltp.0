Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786A4CCD184
	for <ltp@archiver.kernel.org>; Wed, 18 Sep 2024 07:35:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 822673C2E81
	for <ltp@archiver.kernel.org>; Wed, 18 Sep 2024 09:35:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A8A13C2DF4
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 09:35:36 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B33C61A0042A
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 09:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726644933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8zE/9gTuLDUeqeVljA3Aur8EbmIZw/EFhimuyMlz6w=;
 b=bhDU88b4VZUCINB/D+rQ95DtVVjoDnsNaVrq8Y4BO5le2c4iTd5dcni+elCkghaDgEK72d
 TtXOdSKpOUAgIiHkxWoo/rs4zYur7fUAlJMvVMeTj2O85i7rYgD4cGtNjp4M0ZgHmLESSA
 kHQoQqVqSiw7LGriY84QG79Np5BZ8gM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-i7OhNQwJN-K0zhBcwGd1gg-1; Wed, 18 Sep 2024 03:35:31 -0400
X-MC-Unique: i7OhNQwJN-K0zhBcwGd1gg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7d4fc1a2bb7so6924541a12.1
 for <ltp@lists.linux.it>; Wed, 18 Sep 2024 00:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726644930; x=1727249730;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x8zE/9gTuLDUeqeVljA3Aur8EbmIZw/EFhimuyMlz6w=;
 b=BIPyI+oYvYT3VAlLAk7Fc+apHmqbtIOcuMdW05JEi5+rzHIQ0mhIbvLabYI6QvIHyN
 MTjzBuKBfX78yFrAjDyqyhUnr8JS14Mw4CbbQ7iwNCCNKzwW2wz7JEkkRAZVKT6GNGcK
 1cb+C8xTjImWmdlLRf2lCmFaXHItqYAdlp0zKUtfE0Fv2n8aII1siy6lVw3U2zRf7N4C
 hTUyNmSZeG7r//S/J9uX0hwD4GHtMAcDkXElwoDe7D5UU0uCuSilWjraUAbLR/Ezb+vF
 CKbayb/Z9jy8bTsBtjWZSM6vZj5p/0v2flKxdunG/JsSl3janVb8lRwwLuXYQblxM2bS
 d+0A==
X-Gm-Message-State: AOJu0Yz05C5LzsJMr/9wHvaGKNYEGKGmPbTghHnbsAjOqlQiOOH5/uuf
 j3qaWhsw0XnYB5M5T/Ta1rB0wehJyA6ZQWDMnIZYTi+igrFI7SpXQo+wm+1DWCF7mlrp2irdEGW
 ckntbozrowCUCNdwTvIgjHZHBRd5NWN9aCvGqu58uDhRnuXflokQZQUyvwYxA/jLQDPdjfsS1n9
 HQFTk6mjsnKdqmiWupYduAHae3OfpkI505ig==
X-Received: by 2002:a05:6a21:e89:b0:1c8:92ed:7c5e with SMTP id
 adf61e73a8af0-1cf75f01e0fmr14796103637.23.1726644929689; 
 Wed, 18 Sep 2024 00:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY2s8Zz5vCeZn8DCl4wy0k1WjV/7G89rmPogB0d1BCSILv1OZnGio3I48uhYQ36IkeBy/rwIw30to8JCyNr7o=
X-Received: by 2002:a05:6a21:e89:b0:1c8:92ed:7c5e with SMTP id
 adf61e73a8af0-1cf75f01e0fmr14796097637.23.1726644929317; Wed, 18 Sep 2024
 00:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240918073101.13814-1-liwang@redhat.com>
In-Reply-To: <20240918073101.13814-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 18 Sep 2024 15:35:16 +0800
Message-ID: <CAEemH2dWiFOf-03EHj==mo8Sdpo9cHOLkDM3nE-9vZH2Rk0TLw@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib: handle ENOENT errors when processes exit
 during PID scanning
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

Sorry, this patch contains binary mess code, please ignore it.

I will resend a pure one.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
