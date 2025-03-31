Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B8BC3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 11:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743419162; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Vf9YodnMmYd/qtOOQNT74UlaBr5OVVYmdjlSo5hWz0k=;
 b=bI51DN6tTy9Qpy2BtDEVU+zC9romez+rKHmUbnXaE3PwmD5gktrfGboyFLojmhTjswCHP
 IhpHH5bT13JzWvKylWrSnATcV0LK3iU4Y2ynUDLDZk8PQ4ofZ5Z/S/omFOIpEY1Y6X3ezPY
 BU7FMvdzdW3a+COoYSGlsRDjIgXFhsg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CD4D3CABD5
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 13:06:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42EB53C024C
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 13:05:41 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 746E41A0089B
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 13:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743419138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qhh1lSQckzsvJYfT5wvG7AdoC84fAj64KnTEfm18lL0=;
 b=gpO7+Ofd62iLEhEnK1FvWlu8ZUtpo+fKq2ZzqTefBDgpe2aGBEll2k900jbelBLV0ffxXY
 PAUX1sCTBwyFiXgCerHxM1iXSnf3jmZhuNquVdJRqb9NtlpKGsfQ9CG/VyDT6MXXyKXu7S
 an2M4jIt6BydPwHTIH3LcpNt2yVL2cs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-SkLEHIq2O0Ok08GFHRSwvQ-1; Mon, 31 Mar 2025 07:05:36 -0400
X-MC-Unique: SkLEHIq2O0Ok08GFHRSwvQ-1
X-Mimecast-MFC-AGG-ID: SkLEHIq2O0Ok08GFHRSwvQ_1743419135
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff8a2c7912so7378766a91.1
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 04:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743419135; x=1744023935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qhh1lSQckzsvJYfT5wvG7AdoC84fAj64KnTEfm18lL0=;
 b=CLc80+mMjDZYjkv+0psUVMMGDMIW3XiPRXbtxpa9A9vRsuWavYY/DFi3pIqjTwloi4
 AINw2ozxLPlF53kqYrU6CogsjtGW8mfaM7iQPgyd7FoXude0PVZnmh434hX6wNYKMaZm
 B6ophRmF9lgY09Sg47bq3ukxBU5EPP81xJL39LvpORqsGTQ7a7xvIn6Gkn6uCtrRMoOe
 Lpw0EfGBC/OVotAZqw1IHSjda5u/NtXHNA7DavcwmwRfZthtAvwBaGv1EEwmwrhOHhwC
 pT6fYjY0UiAVcRv2TA4uaJ+XAED7i+IlNARJtgSehyzJXo/+X1IQe32RaI1u2WKA5Gqv
 xXtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhj4LkkiC1ZizmBbtrAgc93AY06ULmZFtR9nCwyfXXbf5QK7RMsgyO54bJG7czA8oynrM=@lists.linux.it
X-Gm-Message-State: AOJu0Yyj5C35AHIsb1UQlGN+HSwu9cPcJNcMFvhRFNBcqQ5rmKz0K5WG
 Aytr4mQxFdDJkx3EyciytUGiCcsymNcBFHDzl5oIAP8bNa5GntPAJQxLDRx/zcOZQUeLprAGKYR
 LXDAauNHzaMb39RXsoCcUVKAVOQ2SXjQ0Zwi9m8TS50Web1Wdq3KYaVYxuUYWGPWObtjPO17Xzx
 yRcFFoQPmWxiEjqiyx0OO2PnA=
X-Gm-Gg: ASbGncu3y7zcaGq6GdkefTFCoVihpjuLVHAbMr9Rue1BJSjmcn9vYoOaVRTEOKCIp6H
 VRE/au+KlrkAIHGGEzKXTg2VvXCHaGAIFWdHXpCS/3R05GY6jyuwyQbAfDAIvXme3fgMcrDehAA
 ==
X-Received: by 2002:a17:90a:c887:b0:2fc:aaf:74d3 with SMTP id
 98e67ed59e1d1-3051c85e2a7mr18436056a91.4.1743419135524; 
 Mon, 31 Mar 2025 04:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJdz8a2mbLQc3dgfUJBbof+jTTZfvXxicKQunCbQkdtWz+1QhFcmIMwSRB0TlOQ4wlrWpU4yVV5JV1gISAk1o=
X-Received: by 2002:a17:90a:c887:b0:2fc:aaf:74d3 with SMTP id
 98e67ed59e1d1-3051c85e2a7mr18436030a91.4.1743419135225; Mon, 31 Mar 2025
 04:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250328075958.7616-1-wegao@suse.com>
 <20250331031945.5948-1-wegao@suse.com>
 <20250331031945.5948-2-wegao@suse.com> <20250331103751.GB244431@pevik>
In-Reply-To: <20250331103751.GB244431@pevik>
Date: Mon, 31 Mar 2025 19:05:22 +0800
X-Gm-Features: AQ5f1JoRY8LlVaVAebsMOFhrhNm9AwH6M0iQoH-viFeY5vE9x48C1eYOALzer30
Message-ID: <CAEemH2dPzN3+TSCWejiCb+3Jv3om2s96qu3tJ9qkDOLQ+Oj=ig@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jtb-6pNp-OKEw3vCcJYd60pK-c-Sfqaa4wsQ7_lkgGs_1743419135
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v9 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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

T24gTW9uLCBNYXIgMzEsIDIwMjUgYXQgNjozN+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgV2VpLCBMaSwgQ3lyaWwsCj4KPiAuLi4KPiA+ICtzdGF0aWMgdm9p
ZCBzZXR1cCh2b2lkKQo+ID4gK3sKPiA+ICsgICAgIG5vZGUgPSB0c3RfZ2V0X25vZGVtYXAoVFNU
X05VTUFfTUVNLCBnZXRwYWdlc2l6ZSgpIC8gMTAyNCk7Cj4gPiArICAgICBpZiAobm9kZS0+Y250
IDw9IDEpCj4gPiArICAgICAgICAgICAgIHRzdF9icmsoVENPTkYsICJ0ZXN0IHJlcXVpcmVzIGF0
IGxlYXN0IDIgTlVNQSBtZW1vcnkKPiBub2RlcyIpOwo+CgoKPiBOYWl2ZSBxdWVzdGlvbjogd2h5
IHRlc3QgcmVxdWlyZXMgMiBtZW1vcnkgbm9kZXM/IFdvdWxkbid0IGJlIDEgZW5vdWdoPwo+CgoK
QmVjYXVzZSB0ZXN0NiB2ZXJpZnkgdGhhdCBodWdlcGFnZSArIGNwdXNldCB3b3JrcyB3ZWxsLCBz
byBpZiB3ZSBvbmx5IHVzZQoxIG5vZGUgZm9yIHRlc3RpbmcsIHRoZSBhbGxvY2F0ZWQgaHVnZXBh
Z2Ugd2lsbCBhbHdheXMgaGFwcGVuIG9uIHRoYXQgbm9kZS4KVGhlbiB3ZSB3b3VsZCBsb3NlIHRo
ZSBjaGFuY2UgdG8gZmluZCBidWcgdGhhdCB0aGVyZSBwb3NzaWJseSBhbGxvY2F0ZWQKZnJvbSBv
dGhlciBub2RlcyB3aGVuIHNldHRpbmcgdGhlIGNwdXNldC4KClNvIHRoaXMgdGVzdCBuZWVkcyBh
dCBsZWFzdCB0d28gTlVNQSBub2Rlcy4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
