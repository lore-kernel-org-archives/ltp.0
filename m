Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5CEC369C2
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 07:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745306787; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4KpvrWbTzHKxuFISdmv2zsug5pW1t5W0/R8dxzmniXM=;
 b=HNZg2m2f9CNaUAyiO1QOnvoELCJt/La6IVX6EvPc1PigJZoREJr2dBbKD1N4vqyFeoz80
 wsSXDtTRKXn+6DOdGBSf2Bjz2y+SwZEkDKHsHNxMHYHNj78FjCibCRUZ4mnUXpnkuKs2RtH
 WbIXtKodUWaNZgKrOz+2C/ZHAIpqoEI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C1CD3C0FEE
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 09:26:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7526F3C02B0
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 09:26:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 86D01680434
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 09:26:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745306762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rytlK3hxaa8qLcozQoZYUZpf/P9pfode8D1n/U+3BYk=;
 b=Ib0tijZowsf4qCIwmqKWNTxe0/CX4TIfY2FYE0iqNcmj5UzptbcaxuAby0dFYPqsl6Ge3Z
 htRSywC6usa3j/o1fvuLY4dk6yNXzy9iZNqGQNVd9OJmvhggLuFBWwYP0WQ2PxxMDgkO5h
 pJPiTU7vMiyU0MvmylxEulSi6NO/P54=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-MEOLw4t-MIK8RAdlO-U0_g-1; Tue, 22 Apr 2025 03:26:01 -0400
X-MC-Unique: MEOLw4t-MIK8RAdlO-U0_g-1
X-Mimecast-MFC-AGG-ID: MEOLw4t-MIK8RAdlO-U0_g_1745306760
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39ee57e254aso2275672f8f.1
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 00:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745306760; x=1745911560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rytlK3hxaa8qLcozQoZYUZpf/P9pfode8D1n/U+3BYk=;
 b=S8lYmM5gxa0JMI0pPgC/TF3qrxQ4QBi1uJYPXQKJNvG4/1Ty+GvC5NUxYaFgaZruTJ
 VaT+TweD0JTPp+BJreVZBnaQJOlTaRKMaa5uG3HodWx4JvTnMaqsyOx/d+28fSSp5W3N
 9ezbVgrY0ZIvc9tRM7GS+Ce2d4J1YEbW8Er/OxpVoMsdHQOaNrFwpBwrEqshmaZ3cDdV
 RcJEO328yez3WG9stT+gJ6FVZXlAzBp/5e7L+aG6OGh0HGkgPFG1ospWn65r/UdBFfFC
 0BUCpwaNajYPSkDWfriQp/KxMSmIoWAuDntxfdqcgqQ9SmeWKAhuTFLuvf80bNrxE51O
 b+8A==
X-Gm-Message-State: AOJu0Yy/krweljcGKNiaj38EZlF8JL74Qrr4hE214oLTSoYGWDqrbtXB
 rMLhPbBVx83qxgE5iK1DUCIe8NHqLqiY7lVn0MgyhIv6yEkrmr/BMLZK/UkBLQq/bPkdMPr8rJ3
 iHMNCJQeVH2W62w4mUJqwRf/6//EVazQZ5Vd424BJ9j6oRYs8MeY/QMLv2AtZBVLTHIzoS6WLf0
 F+EvGSAYqq3Du3qpfeS8xa6Uv1D3lfjA4WqQ==
X-Gm-Gg: ASbGncs6hPEgLqGitrtVn9moV9AgaY2qtSujzjiuDBGXf4jOu8/0EnbqOBxIR33YxyA
 J0UV/Y5IN6zEbSqVxGlmwi1CR9ih0sXyfyfB5VncGb4HSP2TQk/nAL8rwN+tR3byyLJW4
X-Received: by 2002:a05:6000:1888:b0:39f:b604:4691 with SMTP id
 ffacd0b85a97d-39fb60446bemr1011381f8f.58.1745306759919; 
 Tue, 22 Apr 2025 00:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqCaXazu9M6RL2JBJF+t+7/QOcn1lnhz7aq/KPBTsnxX5trKAwU3uJbxmi/CpqdgEKerTR8aYilQ5V59L5fBs=
X-Received: by 2002:a05:6000:1888:b0:39f:b604:4691 with SMTP id
 ffacd0b85a97d-39fb60446bemr1011369f8f.58.1745306759650; Tue, 22 Apr 2025
 00:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <a2bdb9dc2d4160f11751053c4c047bb302d0c1a1.1744880683.git.jstancek@redhat.com>
 <20250417111611.GB655134@pevik>
In-Reply-To: <20250417111611.GB655134@pevik>
Date: Tue, 22 Apr 2025 09:25:42 +0200
X-Gm-Features: ATxdqUGhjH2cILXoKsWwTvSHqI-1jrFp2AcSAQRYLfUp8PZLq7910BF4-ihDVoE
Message-ID: <CAASaF6yPH7_5sZUig2gbAB4ELE7AnPQhKDMZmricU0AR61NUHA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1vQbD36RXLxLRRN6be_SjoCjvZpiHTjF36HcADElBPo_1745306760
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setsockopt10: handle explicit disallow
 of disconnect
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBcHIgMTcsIDIwMjUgYXQgMToxNuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEphbiwKPgo+ID4gU2luY2UgY29tbWl0IDUwNzFhMWU2MDZiMyAo
Im5ldDogdGxzOiBleHBsaWNpdGx5IGRpc2FsbG93IGRpc2Nvbm5lY3QiKSBpbgo+ID4gNi4xNSBr
ZXJuZWwsIGRpc2Nvbm5lY3QgaXMgbm93IGV4cGxpY2l0bHkgZGlzYWxsb3dlZC4KPgo+IFJldmll
d2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KClB1c2hlZC4KCj4KPiBUaGFua3Mg
Zm9yIGZpeGluZyBpdCEKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
