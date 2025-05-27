Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D908C54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 09:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748338750; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4HsSp9wg7QFpFM+wfuY+TWzAlH6B4ScuhT5UaEehQCM=;
 b=jvf0k2s8mPVrx/ISAu33Ljr4yuGRgVmrAeWh0U6hIwNNRwziw1qtRCnmWE6ilZTyTPDPw
 6fBuik5z2Nk6F6RuYHUApg3sUTHqDQ1vWjwOHkM7ypdCtO2sNGQxmbTfOAO3GgLOIAH/yFL
 b8ZcR0sVcGNMGMzfw9cNjUW1EhTxh0g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8BC63C58A4
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:39:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DD693C2C13
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:38:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2805B600715
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:38:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748338725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2QXe7Nt7fR0fV1+a9f4alyNlZMqjW7CLzC9Y77cY5eg=;
 b=Kms3nalQCDhxtS68j9EOxu8Z1eRPCle7zu6xcf9CFOyfbgA+MOswu6w/+NnZWKMYW9Ph/v
 HNV9rC5RBfFQpcwD2vW80mjxzOOifEwznTv9RmkToeSYOls2x+NEFrclLuUU6uVsAcC/ny
 HWMM/GTgWmw0qmYymQD5PxxCm6XYtjM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-CeR5PnVwMJCj0SCY6jS2PQ-1; Tue, 27 May 2025 05:38:43 -0400
X-MC-Unique: CeR5PnVwMJCj0SCY6jS2PQ-1
X-Mimecast-MFC-AGG-ID: CeR5PnVwMJCj0SCY6jS2PQ_1748338723
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3112c5671d1so2419368a91.3
 for <ltp@lists.linux.it>; Tue, 27 May 2025 02:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748338723; x=1748943523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2QXe7Nt7fR0fV1+a9f4alyNlZMqjW7CLzC9Y77cY5eg=;
 b=UDLb3Ktspt1MnlUR+5y8J+iWkkCgBVjBxMS4wo1ImS1MmtLzfaQ/8Umrte9ZNFjZxq
 9FM491/5pCn31v+Gfa8TCo8SMB6NVMpVWZBcgE3CK0w55KchifeTLuMvMd07qh2U8xK0
 IZBIGt7of7Qek09syoqDtVLdSy5ZpYSt4j5Ylm/dTmamJPkjtzLhwp0fX/uqegJAMKjB
 Jult2mYGqI8f4t3kQVaKZOarHktKOsj52R2mUFnRDdJWfaedYk5WsOcMoAUNZ6AB6Tn2
 OnfufP71JvuJA7OmbLrUj15850otOQiHMWvGV4R5MrTXYGCQ1JozlPiCaVBIhyJfxvq7
 y/aw==
X-Gm-Message-State: AOJu0YxUIsozqkws2QoBBnRL3je00BMz2jEm5ZFt2fLG4w0g4eib4e0k
 IDi/+y/7DcRDuan6SPITTYpaRYXAnjS2oSVME5X2xQ9AXlx6X24cyXPBw8OyIWywp3QACVcgLL0
 ycY2D5SRjoRlutvdmpH9x31TmDoa4UmzDVW/3xnUP44JL0lHQhJ7Amui4QPuuaSkizgFSylmUof
 p7EGNicW//Ooi6M5hw4A4zRmGyV/w=
X-Gm-Gg: ASbGncuR2ESYGE7G6EWMoDw9ZicrxuDE6C7gFA3mK5idpGtu0JCJpU1Z1f6lxSsdtlm
 9NjeFIIDOCxdt8bdXAPHWFYT9PFI/sfmmwNLpbPRSOp1BnW9VT+1+9KcbXPCcUIf2rkiCQQ==
X-Received: by 2002:a17:90a:ec8b:b0:2fe:994d:613b with SMTP id
 98e67ed59e1d1-31111c49349mr18687301a91.35.1748338722824; 
 Tue, 27 May 2025 02:38:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCTyiW2Wj8Ev1IiO76AlRxoegC3vl4AITbuRD3o7kjVsPfqmNJJg5KHsjNRscv57Coy5TsFSQ1SrfDwoI+z9Q=
X-Received: by 2002:a17:90a:ec8b:b0:2fe:994d:613b with SMTP id
 98e67ed59e1d1-31111c49349mr18687284a91.35.1748338722506; Tue, 27 May 2025
 02:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250526143429.22997-1-chrubis@suse.cz>
 <20250526155132.GA151544@pevik>
 <CAEemH2eyj5k5tUAQyo+b-JXKF5-GcLzQA5SXbP7xpqU1xU73NQ@mail.gmail.com>
 <aDWGfyEGaap9WiV9@yuki.lan>
In-Reply-To: <aDWGfyEGaap9WiV9@yuki.lan>
Date: Tue, 27 May 2025 17:38:29 +0800
X-Gm-Features: AX0GCFv4uugiS2GiSBz9TEdipHmOvd9aVmQAg7k2CwtsCxT0_pKOFrhTa_6xHDk
Message-ID: <CAEemH2e2DhK1zFhNdFXYzO9n7ETGH+LFWHsm8XU8kGdFuNHBPA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zNecOOb5rgZVlsx5AXgMAu2oRMzzk4qcTkb9p6ix53Q_1748338723
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] lib: LTP_SINGLE_FS_TYPE and
 LTP_FORCE_SINGLE_FS_TYPE
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXkgMjcsIDIwMjUgYXQgNTozMeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gT25lIG1vcmUgdGhpbmcgSSdtIGEgYml0IGhlc2l0
YW50IGFib3V0LCBkbyB3ZSBuZWVkIHRvIGV4cGxpY2l0bHkgc2V0Cj4gPiBmc190eXBlc1sxXSB0
byBOVUxMIGhlcmU/Cj4KPiBJdCdzIGEgc3RhdGljIHZhcmlhYmxlIHNvIHRoZSB3aG9sZSBhcnJh
eSBpcyBpbml0aWFsaXplZCB0byBOVUxMIGJ5IHRoZQo+IGNvbXBpbGVyLgoKVHJ1ZSwgdW5sZXNz
IHRoZSBmdW5jdGlvbiAgdHN0X2dldF9zdXBwb3J0ZWRfZnNfdHlwZXMoKSBpcyBiZWluZyBjYWxs
ZWQKbWFueSB0aW1lcyAod2hpY2ggY291bGQgY2hhbmdlIHRoZSBmc190eXBlcyBjb250ZW50cyks
IGJ1dCBzbyBmYXIgSQpmaW5kIGl0IG9ubHkgYmVlbiB1c2VkIG9uY2UgaW4gdHN0X3Rlc3QuYy4K
Ckl0IHNob3VsZCBiZSBmaW5lIGJ5IG5vdy4KCi0tClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
