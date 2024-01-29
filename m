Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F0FC47422
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 08:26:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2A093CE116
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 09:26:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42B193C6E7B
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 09:26:25 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 83FFD204735
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 09:26:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706516783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tIAk26p/mOPrbUwcsQhrODvIrjOtYryM6+nthLSWcvQ=;
 b=LSTZEMYWXolNdlNFzuHyGCkEMcHSWmQI3IOdUlQYYUDvVRLcvWWFqq7mGFhTAau3Uh0ICT
 URvCYBddlRr+4A5yWaO8Feu+kA2YCTjJOIM61EJFlYa2Ti8o6MgqZuBfEtRm6not4yE/2A
 zNjDe/Y5gJGV7kJO9LZUSs+XVAylL4c=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-wfQo3Jh7PD-xdu9sSkzGJw-1; Mon, 29 Jan 2024 03:26:21 -0500
X-MC-Unique: wfQo3Jh7PD-xdu9sSkzGJw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6ddddbf239aso1300545b3a.3
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 00:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706516780; x=1707121580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tIAk26p/mOPrbUwcsQhrODvIrjOtYryM6+nthLSWcvQ=;
 b=axWHPHE9ntccscHuT7+5fhEm60xJTf9E1lhgTb9tNFGI6u5M7KeXMMKIjFsiRMdkK4
 Z+E0zFMAa5PCAr+EiXg0gi5QU6bTgPN4zU4CgMhIpLmV2R1Yit+Td6jhfhxWvNavg5ym
 4Gca1963WhBOzuczyqFI6mlfnJT1X+1LfRE8HvNtRLeUQs3p8vnnPC8MRyM51CL8Z6Vw
 L0RWsBcMPg43kJKrVEaRupshIwtr0vNJqHdvW8+XhJ9Ecmscp+JeJg4V+UPwxCnn1WLF
 PXQ6KES86ugMfqjZyAw0WawJXPSqvYvzOrRd1cfCyGrRATldJ3AgwR3I2t3wG9jzW3xb
 yZ1Q==
X-Gm-Message-State: AOJu0Yys861qu50ZZ45Oc82AUHidZQg5PF9mpLqEMfH4VapnwZfhQOJy
 EAITPbMwcwW2oHrExRFS5iE2dcB4rQFjxkEuYnqVVBwAAOjM58Af872mFbbzMspV1AfBbhv286T
 3lL+jaK1aTlPUEviBNFjdrrGI9kd5mWdNZvguSE1OPncx8EzIvFzucyvSKxUzcj4Ji5SaW7830Y
 JNfVEjJaEssM+jLFqaafJ7xCk=
X-Received: by 2002:a05:6a00:2f16:b0:6d9:a565:9be6 with SMTP id
 fe22-20020a056a002f1600b006d9a5659be6mr1706630pfb.9.1706516780159; 
 Mon, 29 Jan 2024 00:26:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcrqFdqgL8Od5luvy3XEnG3GhzYDJH+u9aJl3LiU+1cb0h4PmQRgDDQgieAopP6dALyqqkc6BsSLpFqy/xuX4=
X-Received: by 2002:a05:6a00:2f16:b0:6d9:a565:9be6 with SMTP id
 fe22-20020a056a002f1600b006d9a5659be6mr1706625pfb.9.1706516779839; Mon, 29
 Jan 2024 00:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20240128024838.2699248-1-liwang@redhat.com>
 <20240128024838.2699248-8-liwang@redhat.com>
 <20240129080300.GA584389@pevik>
In-Reply-To: <20240129080300.GA584389@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 29 Jan 2024 16:26:07 +0800
Message-ID: <CAEemH2edBcSb+PCg59eTMoOhLjaL2vpPLF99psMsMcB728kTgg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5 7/8] swapon/off: enable all_filesystem in swap
 test
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKYW4gMjksIDIwMjQgYXQgNDowM+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvc3dhcG9mZi9zd2Fwb2ZmMDIuYwo+ID4gQEAgLTE4LDYgKzE4LDggQEAKPiA+ICAjaW5jbHVk
ZSAibGFwaS9zeXNjYWxscy5oIgo+ID4gICNpbmNsdWRlICJsaWJzd2FwLmgiCj4KPiA+ICsjZGVm
aW5lIE1OVFBPSU5UICAgICAibW50cG9pbnQiCj4gPiArCj4gPiAgc3RhdGljIGludCBzZXR1cDAx
KHZvaWQpOwo+ID4gIHN0YXRpYyB2b2lkIGNsZWFudXAwMSh2b2lkKTsKPgo+ID4gQEAgLTg0LDE0
ICs4NiwxMyBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+Cj4gPiAgICAgICBpc19zd2FwX3N1
cHBvcnRlZCgiLi90c3Rzd2FwIik7Cj4gVGhpcyBuZWVkcyB0byBiZSBydW4gb24gTU5UUE9JTlQs
IHNlZSBzd2Fwb24wMS5jIChjaGFuZ2UgZnJvbSBzZWNvbmQKPiBjb21taXQgSQo+IG1hZGU6ICJz
d2Fwb24wMTogVGVzdCBvbiBhbGwgZmlsZXN5c3RlbXMiKS4KPgo+IFRoZSBzYW1lIHByb2JsZW0g
aXMgaW4gb3RoZXIgdGVzdHMuIE90aGVyd2lzZSB3ZSBjaGVjayBhbHdheXMgb24gVE1QRElSCj4g
KHdoaWNoIFRDT05GIHdoZW4gL3RtcCBpcyB0bXBmcykuCj4KCk9oIHllcywgeW91J3JlIHJpZ2h0
LCBJIG92ZXJsb29rZWQgdGhhdC4gVGhhbmtzLgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
