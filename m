Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670A9E7718A
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 13:07:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F4703ED420
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 14:07:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5FD83E4EFC
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:07:26 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D28D61432AFC
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:07:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734613643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dtub0ksQl0URoZr7FZ/qqTosfhiXzv39dTiSgiLvAIQ=;
 b=AdynkspUlDZmOmQ+svG2zL3ZQpqFADPy87w8uIUepbGYJMtFYAyWqkBVCNKLCacO45gyjz
 Hy1mto4MKvIuntgBsEuYq8pgBzwNjEcx7c+ilvkdRRGOHoz5ByGVIPg7O2yF0IO8b1R1jo
 j+ZnLASXUslvXPErMuoislVlEtuI98g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-cKuFY6HCM2-ecgttQZBiMw-1; Thu, 19 Dec 2024 08:07:21 -0500
X-MC-Unique: cKuFY6HCM2-ecgttQZBiMw-1
X-Mimecast-MFC-AGG-ID: cKuFY6HCM2-ecgttQZBiMw
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ef8c7ef51dso733304a91.1
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 05:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734613640; x=1735218440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dtub0ksQl0URoZr7FZ/qqTosfhiXzv39dTiSgiLvAIQ=;
 b=fPY+IotJmvjcPFmIC2Ha38m39MmIFrHM2uuqbjy77+np/FOZ5PUPh+JSzpx5DNMjgW
 35rIECfdf0yI3pHnsXopBrIW59wSyuNIwb/7RYVcEfFX43fSlooOOZShpa6RLRztkGpu
 ireqeHw1PWzd0a8ZDwH3CN0plSyL/CL3bz8qpvVhEGELrTTGvoK7pvWYvPM+kK/29L+R
 cORxaBPzsy1hJL3wQCeb43W0Wrw5Y9a6g/GZ10zw+3LPTvV9kvOCx/buSh3gns+ygDuA
 FSe2fp5/HzynqdAQZjODZl6lgQMvn/9sS7QtDWZFzO1AOTKiFlWIdpDuc8aNE4o9792o
 9u2A==
X-Gm-Message-State: AOJu0YwtA54CXaJKdJV2I4yXHGvY5/fKRFvAPEO+aTw6ff6AvoB37r34
 3cmDR9jWwwfCdZvvfjhpixx6as2TJZBY4mgSRYlXzRtrgTguKSScXJQEV61jeWFHgJ4gz02AV5S
 VmtYelmjA37Hj/fJ8cOTRilaO4DCs8lIlkkwtdxOyzau8RNM/mTKMTgqyv8a3fWG85wSIkefoxZ
 Z/B2eC7r0/yj+qH8dEnhcvoJ4=
X-Gm-Gg: ASbGnctMCnR44Ow8hmmwXsuUnLKMorE0BBzT8Re2e72DudTK3ZEQBm98KgO2+6EJdcA
 TMd1cRVkfNtKLNDlSlGq1AluIHsJvX2sQXCfmQZU=
X-Received: by 2002:a17:90b:3a4c:b0:2ee:cbd0:4910 with SMTP id
 98e67ed59e1d1-2f443553188mr4892759a91.1.1734613640195; 
 Thu, 19 Dec 2024 05:07:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsmjPB8PWB9uGMuZq8iHxgeSttBCRyK+4268WR6t3VAQBlqcxRk8G73qhjCqxNjudDSsrO09WzC3MhTqZesa4=
X-Received: by 2002:a17:90b:3a4c:b0:2ee:cbd0:4910 with SMTP id
 98e67ed59e1d1-2f443553188mr4892736a91.1.1734613639886; Thu, 19 Dec 2024
 05:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20241212060448.204158-1-liwang@redhat.com>
 <20241219125358.GA93828@pevik>
In-Reply-To: <20241219125358.GA93828@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Dec 2024 21:07:07 +0800
Message-ID: <CAEemH2c4L62tkrtcNN-2nMg=ocvcnW3aRd_K-cPqG=UrVpnd1A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x_WQNX0y5NPR_3y8zp7yMIB4o0Il0WYBuZl2tC52RLw_1734613640
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBEZWMgMTksIDIwMjQgYXQgODo1NOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiAuLi4KPiA+ICsrKyBiL2xpYi90c3RfdGVzdC5jCj4g
PiBAQCAtNTU1LDYgKzU1NSw5IEBAIHN0YXRpYyBpbnQgbXVsdGlwbHlfcnVudGltZShpbnQgbWF4
X3J1bnRpbWUpCj4KPiA+ICAgICAgIHBhcnNlX211bCgmcnVudGltZV9tdWwsICJMVFBfUlVOVElN
RV9NVUwiLCAwLjAwOTksIDEwMCk7Cj4KPiA+ICsgICAgIGlmICh0c3RfaGFzX3Nsb3dfa2NvbmZp
ZygpKQo+ID4gKyAgICAgICAgICAgICBtYXhfcnVudGltZSAqPSA0Owo+Cj4gRllJIHRoaXMgY2hh
bmdlIHByb2xvbmdzIHNvbWUgZnV6enkgc3luYyB0ZXN0cywgZS5nLiBzZXRzb2Nrb3B0MDYgb3IK
PiB3cml0ZXYwMy4KPiBJIGd1ZXNzIHRoaXMgaXMgYSBzaWRlIGVmZmVjdCwgb3Igbm90PyBPciBk
b2VzIHNsb3cgbWFjaGluZSByZWFsbHkgbmVlZHMKPiB0byBydW4KPiBsb25nZXIgaW4gb3JkZXIg
dG8gdHJpZ2dlciBidWcgaW4gZnV6enkgc3luYz8KPgoKWWVzLCB0aGF0IHdpbGwgcHJvbG9uZyB0
aGUgZnV6enkgdGVzdCBvbiBkZWJ1Zy1rZXJuZWwgYnV0IGZvcnR1bmF0ZWx5IGZ1enp5Cmhhcwon
cGFpci0+ZXhlY19sb29wcycgdG8gY29udHJvbCB0aGUgdG90YWwgdGVzdCBudW1iZXJzLiBJdCB3
b3VsZG4ndCBwcm9sb25nCnRvbwpsb25nIEkgZ3Vlc3MuCgpGb3IgdGhlIHRlc3Qgd2hpY2gga2Vl
cHMgbG9vcGluZyB1bnRpbCB0aGV5IHJ1biBvdXQgb2YgcnVudGltZSAoTWFydGluCnBvaW50ZWQp
CndlIG5lZWQgdG8gY29tZSB1cCB3aXRoIGEgd2F5IHRvIGxpbWl0IHRoZSBydW50aW1lLiBJIG5l
ZWQgdG8gZ28gdGhvdWdoIGFuZApzZWUKaG93IG1hbnkgdGhleSBhcmUuCgoKCj4KPiBXZSBoYXZl
IDkwMCBzZWMgdGltZW91dCBpbiBvcGVuUUEgKGRlZmF1bHQgTFRQIHRpbWVvdXQgaXMgNjAwIHNl
YyksIGJ1dAo+IGl0J3Mgbm90IGVub3VnaC4KPiBTdXJlLCB0aGUgc29sdXRpb24gaXMgdG8gaW5j
cmVhc2UgaXQgdG8gMjQwMCAoNCo2MDApLCBidXQgdGhlbiB3ZSBuZWVkCj4gcmVhbGx5IHRvCj4g
aGF2ZSBtb3JlIHByZWNpc2UgLm1heF9ydW50aW1lIHNldHVwIG90aGVyd2lzZSB0ZXN0cyB3aGlj
aCBnb3Qgc3R1Y2sgd2lsbAo+IHByb2xvbmcgdGVzdGluZyA0eCB0aW1lcy4KPgo+IFRoaXMgaXMg
Zm9yIHN5c2NhbGxzLCBJIGhhdmVuJ3QgY2hlY2tlZCBvdGhlciBydW50ZXN0cyAoc3BlY2lhbGx5
IHRoZXNlCj4gd2hpY2gKPiBoYXZlIGhpZ2ggLm1heF9ydW50aW1lLCBlLmcuIGx0cC1haW8tc3Ry
ZXNzKS4KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
