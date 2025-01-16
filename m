Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3F7C02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 13:22:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B61703C7BE6
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 14:22:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B8123C7BDE
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 14:21:47 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 664741BE66DF
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 14:21:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737033704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqQ5bdcHGfRK8sEzsufHXlpclSkpkJUS0OTKzYE401g=;
 b=Gyc57woe0MhJpz4dYUq6k8O6HOW5hDNzQr0bNOR4JK5RVfwf9j49JzuPhHwCljI5dYbamU
 SqNbK51syJ7o2q8Ye4ldEcPT15ALK36MFLpXddiKCnhyp5KekMOqKr1BGh2gdexwJR6zO3
 OonJgDeJdo5ixPhmKZq506lkTq7ejbE=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-KVXh0y9zMRORs2p-n8ArqA-1; Thu, 16 Jan 2025 08:21:43 -0500
X-MC-Unique: KVXh0y9zMRORs2p-n8ArqA-1
X-Mimecast-MFC-AGG-ID: KVXh0y9zMRORs2p-n8ArqA
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2a75cda3961so242131fac.0
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 05:21:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737033702; x=1737638502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yqQ5bdcHGfRK8sEzsufHXlpclSkpkJUS0OTKzYE401g=;
 b=k6CyKmllcKmNv7l6BPuCKYNACrhz99nqXrxwNRI7HZbldDCKou3+1WojAJyqjWBWBH
 MI45NyvujBTx3lgkF0xGDcI5O+OxuLCXjEcxby2oItxQ229oV/gXkgOUWio9nwCpyi6j
 rtN6tCievWvyDETmPntvk3YEdU1Nlox/aaRPDLaI100bKRT+28h79zwkZai8iWs7IkI1
 4NwLd8PSvYh2nrxvBJqza40XTYDVAVWcst+ACS4XRnirHZfrvSBB4X7cuR56Wedu0qlb
 ohg+Sq9apG/0ecTWDRn7aulieg/LMhtvtnkZ+ey2rS6to0Lvfv06XOlal+vZjoVQz7D8
 +9cg==
X-Gm-Message-State: AOJu0YzlUB2TUnnSdvjbN5Y94b9JgSgbmcNzc9+0sB2c/r2gyMn7Gi9r
 eUMIRGea8m9QPzzhVo5VR2Hvh+rPVBXkyvKwSeDKD+7rV609Nok3XNa1ZzvaskgOlMeQ+g80MDq
 UOSoBLOmf0khdlKAfPc0Vr3U6E9pwLwekBmpv0XBGuGL1rOFeWAR5+Q0uFCa8xqsimIjpZfvQN0
 qCqrlzz1FJzdctFsXgnsbjU3X+lvGas3I=
X-Gm-Gg: ASbGnctB8HSwiGz4/72+YlU2wqvnCp8aTOuivM+eSJiAMIjjf8mWy9fq7ZNikrrvpjG
 6oMJSGYbYFhDB7waO3LiHfVh8jyFPTbLzoB5ZmQ==
X-Received: by 2002:a05:6870:dc4b:b0:29e:503a:7ea3 with SMTP id
 586e51a60fabf-2aa069c21c6mr19224018fac.36.1737033702285; 
 Thu, 16 Jan 2025 05:21:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY9iIyJVJ57dBuuKviT+s8pceeXs+xhsCVqB9dKwO+6XTb72xQ5tDO9ba6PAodvZ+3DKtKCAghp1blKACDLZE=
X-Received: by 2002:a05:6870:dc4b:b0:29e:503a:7ea3 with SMTP id
 586e51a60fabf-2aa069c21c6mr19224005fac.36.1737033701988; Thu, 16 Jan 2025
 05:21:41 -0800 (PST)
MIME-Version: 1.0
References: <1b9d04fe8d4f0f386398216b9a5c172bb010c97f.1737029809.git.jstancek@redhat.com>
In-Reply-To: <1b9d04fe8d4f0f386398216b9a5c172bb010c97f.1737029809.git.jstancek@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 16 Jan 2025 14:21:26 +0100
X-Gm-Features: AbW1kvbdHy-nvbtzzL5ldYdJ65ejVWjYrYNiVFlNYpZ79pcfv9nPw70UHxmkGKM
Message-ID: <CAASaF6x=feaUFiM5bAF5hWsJh6TxCuJ+E4qJ1zv3F7sv5D4vZg@mail.gmail.com>
To: ltp@lists.linux.it, Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n9KqnRLKFydAZRaYVhYTSREVLHNjz-jUTnX-vIoDhyk_1737033702
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio-stress: fix opened fd leak
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
Cc: liwan@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gMTYsIDIwMjUgYXQgMToxOOKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IEluIGNhc2VzIHdoZXJlIHdvcmtlciBjb21wbGV0ZXMgc3Bl
Y2lmaWVkIG51bWJlciBvZiBgaXRlcmF0aW9uc2AgYmVmb3JlCj4gb3BlciBjb21wbGV0ZXMgYWxs
IGB0b3RhbF9pb3NgLCBzdWNoIG9wZXIgcmVtYWlucyBvbiBhY3RpdmVfbGlzdC4KPiBUaGlzIGlz
IGEgcHJvYmxlbSBiZWNhdXNlIGNsZWFudXAgb25seSB3YWxrcyBvdmVyIGZpbmlzaGVkIGxpc3Qs
Cj4gYW5kIGNsb3NlcyBmZHMgb25seSBmb3IgaXRlbXMgb24gdGhpcyBsaXN0LiBTbyBpdCdzIHBv
c3NpYmxlIGZvcgo+IHRlc3QgdG8gZXhoYXVzdCB1bGltaXQgZm9yIG9wZW4gZmlsZXMgYW5kIGZh
aWw6Cj4KPiAkIC4vYWlvLXN0cmVzcyAtYTEgLUkxMDAgLW8yIC1yNCAtZjEgLWQxXgo+IGFpby1z
dHJlc3MuYzoxMzQ3OiBUUEFTUzogVGVzdCBwYXNzZWQKPiBhaW8tc3RyZXNzLmM6MTI4NTogVElO
Rk86IHN0YXJ0aW5nIHdpdGggcmFuZG9tIHdyaXRlCj4gYWlvLXN0cmVzcy5jOjEyOTY6IFRJTkZP
OiBmaWxlIHNpemUgMTAyNE1CLCByZWNvcmQgc2l6ZSAwS0IsIGRlcHRoIDEsIEkvTyBwZXIgaXRl
cmF0aW9uIDEKPiBhaW8tc3RyZXNzLmM6MTI5ODogVElORk86IG1heCBpb19zdWJtaXQgMSwgYnVm
ZmVyIGFsaWdubWVudCBzZXQgdG8gNEtCCj4gYWlvLXN0cmVzcy5jOjEzMDA6IFRJTkZPOiB0aHJl
YWRzIDEgZmlsZXMgMSBjb250ZXh0cyAxIGNvbnRleHQgb2Zmc2V0IDJNQiB2ZXJpZmljYXRpb24g
b2ZmCj4gYWlvLXN0cmVzcy5jOjEzMTQ6IFRCUk9LOiBvcGVuKGZpbGUwLmJpbiwxMDUyNzM4LDA2
MDApIGZhaWxlZDogRU1GSUxFICgyNCkKPgo+IENsZWFuL2ZyZWUgYWxzbyBpdGVtcyBmcm9tIGFj
dGl2ZV9saXN0LiBBbHNvIGRvbid0IGxldCBgc3RhdHVzYCBmcm9tIGNsZWFudXAKPiBiZSBzZXQg
dG8gemVybyBvbmNlIGl0IGJlY29tZXMgbm9uLXplcm8uCj4KPiBTaWduZWQtb2ZmLWJ5OiBKYW4g
U3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9p
by9sdHAtYWlvZGlvL2Fpby1zdHJlc3MuYyB8IDcgKysrKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2tlcm5lbC9pby9sdHAtYWlvZGlvL2Fpby1zdHJlc3MuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvaW8v
bHRwLWFpb2Rpby9haW8tc3RyZXNzLmMKPiBpbmRleCA0MTlmYzJjZDI1YTQuLmU4NDMwOGQxZDBl
OCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vYWlvLXN0cmVz
cy5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Fpby1zdHJlc3MuYwo+
IEBAIC0xMTIyLDcgKzExMjIsMTIgQEAgcmVzdGFydDoKPiAgICAgICAgIHdoaWxlICh0LT5maW5p
c2hlZF9vcGVycykgewo+ICAgICAgICAgICAgICAgICBvcGVyID0gdC0+ZmluaXNoZWRfb3BlcnM7
Cj4gICAgICAgICAgICAgICAgIG9wZXJfbGlzdF9kZWwob3BlciwgJnQtPmZpbmlzaGVkX29wZXJz
KTsKPiAtICAgICAgICAgICAgICAgc3RhdHVzID0gZmluaXNoX29wZXIodCwgb3Blcik7Cj4gKyAg
ICAgICAgICAgICAgIHN0YXR1cyA9IGZpbmlzaF9vcGVyKHQsIG9wZXIpID8gOiBzdGF0dXM7Cj4g
KyAgICAgICB9Cj4gKyAgICAgICB3aGlsZSAodC0+YWN0aXZlX29wZXJzKSB7Cj4gKyAgICAgICAg
ICAgICAgIG9wZXIgPSB0LT5hY3RpdmVfb3BlcnM7Cj4gKyAgICAgICAgICAgICAgIG9wZXJfbGlz
dF9kZWwob3BlciwgJnQtPmFjdGl2ZV9vcGVycyk7Cj4gKyAgICAgICAgICAgICAgIHN0YXR1cyA9
IGZpbmlzaF9vcGVyKHQsIG9wZXIpID8gOiBzdGF0dXM7Cj4gICAgICAgICB9CgpAQW5kcmVhOiBZ
b3UgcmV3cm90ZSB0aGlzIGVudGlyZSB0ZXN0IH55ZWFyIGFnbywgZG8geW91IHRoaW5rIHRoaXMg
Xl4KaXMgZ29vZCBpZGVhPwoKVGhhbmtzLApKYW4KCj4KPiAgICAgICAgIGlmICh0LT5udW1fZ2xv
YmFsX3BlbmRpbmcpCj4gLS0KPiAyLjQzLjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
