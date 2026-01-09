Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6EAD16810
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 11:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767958487; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rFVPKvUL6PkmjyFSvxOAI2rqDjWixiZ7HSyOtoh9IbQ=;
 b=mqQOpB7VdevruX2CQTvGQ6Ztu/ok7FCxcsqDx/2hu6ZUUjRhP3QlK5vS0S7f95LDY6GEV
 c86yX2o392NM2SWlL5fpTDS2WTG00eJCfD73+3XrPZpOA4L4pX+ISSF52CwX1hU6QdQbEHN
 c4TDZW5WTVD60FkZLttO3jFi9urO6sM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 698423C768C
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 12:34:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE0893C6AC2
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 12:34:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2CEB5200B2F
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 12:34:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767958462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rcl4wu4qvKA+a2Zc58cqqsBB5ZyJ0SqLW5qirNi6UrQ=;
 b=LT05WuRjjWM46nNFJOPQ11Vha1Ww/HQkmu7bZpJdBZP79ssuL0FzcjyK+NpG1KWbB+cAhn
 QaNf6CmW0g5Dq643mgj8EgOHBUA3Muivk1ZzgQFj7S2JtEP6qrvdd9jwmuK4HEta265UFE
 RAZbn/x9U1kkKhxSbknh7EAlWnNaiYA=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-B41-TIQSNvGUF-vfrqY2KA-1; Fri, 09 Jan 2026 06:34:21 -0500
X-MC-Unique: B41-TIQSNvGUF-vfrqY2KA-1
X-Mimecast-MFC-AGG-ID: B41-TIQSNvGUF-vfrqY2KA_1767958460
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b048fc1656so6858235eec.1
 for <ltp@lists.linux.it>; Fri, 09 Jan 2026 03:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958458; x=1768563258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rcl4wu4qvKA+a2Zc58cqqsBB5ZyJ0SqLW5qirNi6UrQ=;
 b=b4KOfCtAEQQNi6XvTKTgDyUets1VMl6cbxKVYSrfIkB3/ChmmFKQiFzls7pVbUy/KX
 2ehloSGbZioE/Ayzxf7pYi8e8rFqtF4wSKQPH7+ezKjyA0m3L0rhKr1LCEEE+S/mZTSl
 yqr5T6FDOnjND94OFVuOQe2La2mhoyarv5F98y6r1VnNVJRc+Ynouhkwv3Uh5ZfC5UZx
 ZoimJfpBjD60HGCiCazj7MtFKotsIbmcfANnTbum6o/jUr0fa0ii3qiezQuNLm53qQ/s
 7DL0xsrfBiCcgK/06htCRy99Eq0Ercnxn5DYyksaLgcz28UoqTnaGNxEFg3mfMVUCu2p
 Tlag==
X-Gm-Message-State: AOJu0YzShCh9E4TubFdJcigtvvMiv9+PLy7AEXDzjmqyvQHna3XsX05M
 RoHycuJH25GYSQzQfov8ILnr1IfEkYd08gJX7Ig+5C3tZCnmLWHBcikErYHapugejCRSFATcXZU
 KdIrMbMCzX9uvwae/HPhccVmDm0o7VSsa5f+iIqTCqWD8X15HaUJe3cpviiOsJ7RsWyt/bC2c+a
 xantcc1OwXoNUvs0Ff+z0jSs04i7cDoDXht1Y=
X-Gm-Gg: AY/fxX4VplNIclbZrQu9xdLnYAN11yndGX7OrfHNF0XhYEBmI2zuyT/aAi3oRP28Z3u
 qVwLSHx9h92L5mGvRmj4eeMLN+eo5mZrVfyyGJrNIVZjoxxt9vG+EsbE9AKTQiwLFZNfYTWcC7c
 Q6JUamN0W+lbx0LNpaY/R9qAyMJECE9Hb5BxIftMemBxMLs3weJIAVyUNcFu4v/sdsJTs=
X-Received: by 2002:a05:7301:e2b:b0:2ae:5ffa:8daa with SMTP id
 5a478bee46e88-2b17d200bc3mr8149473eec.5.1767958458645; 
 Fri, 09 Jan 2026 03:34:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd9q2xWuruCS9nPBq/4zEFeA/39/gdTSTJwoVNBzEVk3jvID/4yqFMBhwN6WpxQ2Cww+QVo/KRZ+Vy2MTZCeo=
X-Received: by 2002:a05:7301:e2b:b0:2ae:5ffa:8daa with SMTP id
 5a478bee46e88-2b17d200bc3mr8149451eec.5.1767958458219; Fri, 09 Jan 2026
 03:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20260109110815.198224-1-po-hsu.lin@canonical.com>
In-Reply-To: <20260109110815.198224-1-po-hsu.lin@canonical.com>
Date: Fri, 9 Jan 2026 19:34:06 +0800
X-Gm-Features: AZwV_QgionNwTiswW1lDRzRxy-8jirpvNpH1Oiry4pvPSTtHoPL7dO3xpNIiiJI
Message-ID: <CAEemH2fFwknhWW-=NWnZj8Ea5CdcfgQBJ10C=9CkX-VFr541Ew@mail.gmail.com>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kR69Okj2_aUcGn3rrquuijGS7og8Kr0nWMCnI0SJnn8_1767958460
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] block_dev.c: Skip on Lockdown/Secure Boot
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

Hi Po-Hsu,

Both fixes patch of Lockdown/Secure-boot check are merged, thanks!

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
