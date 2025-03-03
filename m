Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2277C282CD
	for <ltp@archiver.kernel.org>; Mon,  3 Mar 2025 09:36:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7A7A3C8516
	for <ltp@archiver.kernel.org>; Mon,  3 Mar 2025 10:36:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC00E3C038C
 for <ltp@lists.linux.it>; Mon,  3 Mar 2025 10:35:44 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 15EB9141CBCA
 for <ltp@lists.linux.it>; Mon,  3 Mar 2025 10:35:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740994541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SQo7jU9Mz9wRvWGABL7EfMzs4teqBFDXj8BZaKLm2nU=;
 b=bPRqX7R6ecrkvOpNu6vhathtueI7fPPFXvCHbv0C55tGoENi4EGODmURT8UgVymi/FRXZB
 E3gF+TS19SMRMqSUO6diWNGaWatpCeigYyaR/TzW7XbM7kSNw+P+VySN+sWbfxHkCKa6CG
 FaCJvQ1b8r5z3rUgrlQLB1d3jAKsdOk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-FswBza4WMZiRPDmRrEZ2lA-1; Mon, 03 Mar 2025 04:35:38 -0500
X-MC-Unique: FswBza4WMZiRPDmRrEZ2lA-1
X-Mimecast-MFC-AGG-ID: FswBza4WMZiRPDmRrEZ2lA_1740994537
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fed20dd70cso3701522a91.1
 for <ltp@lists.linux.it>; Mon, 03 Mar 2025 01:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740994537; x=1741599337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SQo7jU9Mz9wRvWGABL7EfMzs4teqBFDXj8BZaKLm2nU=;
 b=Mf92bnTy14J/o6mwIVO9YaEYcIIaBmCXvOEuP1YVUSX5wJ+6GWxtIPV5/2t0O81jTM
 C+rZqxk53dv+Y+cuUp6SdjtD06azdccXc2IIxAjusdUSDpGETbaqa2+mTAjuEdyXsSNH
 5KBeXtacAZ/+p49Xy5IMVbJqHqhOVaxEW55wJ8tyokxguQxWBjDl5sQzz6z5gf7xZOb0
 7QDPmgBRvCpKE90GcVjcVyLAcdc722WooIpqXo2wP0+1LvyN80rnx5C+9fN3YIHPknG7
 hozW1fTXOtwmdFTKyg8hQEGsx2WrkTvllLr2crcfVEq4ACZTb1AO31S7agaVAHgfJu+k
 adCA==
X-Gm-Message-State: AOJu0Yxo9RvBdNYRRJTJJaiJ+27nGAEmT6Pl/XpXRbjPYC6MTElNMGF3
 Z4bliU/k637TQQTzmh79n4Gp9J7pYrN0VTzPsoXfkEbBcO9c2mU0ccgy5PxP86jY4KHP0rPFLI2
 IdVTj9fDAAM/VuUcAHsijOLc+IMS6MDk07jh32S21IHgxADN8LN6mN3OVLROxengmR3LE9dwBIj
 Cg/qroDxakw2eYfGlEs5i+Pcs=
X-Gm-Gg: ASbGnctZDTY2q+Y0pTOCNvzUrCb8MwTPJsI+7BLzf46bp6Hg2asd4Cup02v+l3c0mzq
 MJsmyZ0UVy93LW1zds0AuwaDfDl3dlwH/41kypKbd4RUEJZnwVwQzFqXsDaLQPAZtuhnMUO5VYw
 ==
X-Received: by 2002:a17:90b:180b:b0:2ee:cded:9ac7 with SMTP id
 98e67ed59e1d1-2febab79a02mr19693627a91.20.1740994537367; 
 Mon, 03 Mar 2025 01:35:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsa4vaPZtu+VZjU5Uezy2cZZrHhyOpU4pU6Yve0piLdL/NU6UVq7NrePAsLBkf0dASJIO27TfqjwNDSgNmUf0=
X-Received: by 2002:a17:90b:180b:b0:2ee:cded:9ac7 with SMTP id
 98e67ed59e1d1-2febab79a02mr19693607a91.20.1740994537014; Mon, 03 Mar 2025
 01:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20250228184834.1330657-1-edliaw@google.com>
In-Reply-To: <20250228184834.1330657-1-edliaw@google.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 3 Mar 2025 17:35:25 +0800
X-Gm-Features: AQ5f1JpFpZrbRyqWtWIQ0-eWiDcEvnI5S0LOux0EkqCrAuI84p5xn0w-m9s-3Ks
Message-ID: <CAEemH2e-eEvbOT_ByL1cwJODUg7rS16nO0aYVd4DFCAQB=7uPA@mail.gmail.com>
To: Edward Liaw <edliaw@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m1Z_1Hvy0IZY9hFuDFVajsOWjY7TdPMtHygjHlMlVko_1740994537
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] input_common.h: Add retry loop for event device
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU2F0LCBNYXIgMSwgMjAyNSBhdCAyOjQ54oCvQU0gRWR3YXJkIExpYXcgdmlhIGx0cCA8bHRw
QGxpc3RzLmxpbnV4Lml0Pgp3cm90ZToKCj4gQW5kcm9pZCBoYXMgYSBkZWxheSBiZXR3ZWVuIHRo
ZSBlbnRyeSBpbiAvcHJvYy9idXMvaW5wdXQvZGV2aWNlcyBhbmQgdGhlCj4gcGF0aCAvZGV2L2lu
cHV0L2V2ZW50TiBiZWNvbWluZyBhY2Nlc3NpYmxlLiAgQWRkIGEgcmV0cnkgbG9vcCB0byBhY2Nv
dW50Cj4gZm9yIHRoaXMuCj4KCkRpZCB5b3UgY291bnQgZm9yIGhvdyBsb25nIGl0IHRha2VzIHRv
IGVudHJ5PyBUaGUgZGVmYXVsdCB0aW1lClRTVF9SRVRSWV9GVU5DCmlzIGJhY2tvZmYgMSBzZWNv
bmQsIGlmIHRoYXQgdGltZSBpcyBub3QgZW5vdWdoLCB5b3UgY2FuIGNvbnNpZGVyIHRoZQpjb21w
bGV0ZWQKdmVyc2lvbiBUU1RfUkVUUllfRk5fRVhQX0JBQ0tPRkYgZm9yIHNldHRpbmcgbW9yZSBz
ZWNvbmRzLgoKQW55d2F5LCB0aGlzIGxvb2tzIGdvb2QuClJldmlld2VkLWJ5OiBMaSBXYW5nIDxs
aXdhbmdAcmVkaGF0LmNvbT4KCgoKPgo+IFNpZ25lZC1vZmYtYnk6IEVkd2FyZCBMaWF3IDxlZGxp
YXdAZ29vZ2xlLmNvbT4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9pbnB1dC9pbnB1dF9jb21t
b24uaCB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9pbnB1dC9pbnB1dF9jb21tb24u
aAo+IGIvdGVzdGNhc2VzL2tlcm5lbC9pbnB1dC9pbnB1dF9jb21tb24uaAo+IGluZGV4IDBhYzE2
MjRiMy4uNWIxNzU1NzcxIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvaW5wdXQvaW5w
dXRfY29tbW9uLmgKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL2lucHV0L2lucHV0X2NvbW1vbi5o
Cj4gQEAgLTI5LDcgKzI5LDcgQEAgc3RhdGljIGlubGluZSBpbnQgb3Blbl9ldmVudF9kZXZpY2Uo
dm9pZCkKPiAgICAgICAgICAgICAgICAgICAgICAgICBtZW1zZXQocGF0aCwgMCwgc2l6ZW9mKHBh
dGgpKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICBzbnByaW50ZihwYXRoLCBzaXplb2YocGF0
aCksICIvZGV2L2lucHV0LyVzIiwKPiBkZXZpY2UpOwo+Cj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKCFhY2Nlc3MocGF0aCwgRl9PSykpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICBp
ZiAoIVRTVF9SRVRSWV9GVU5DKGFjY2VzcyhwYXRoLCBGX09LKSwKPiBUU1RfUkVUVkFMX0VRMCkp
IHsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJGb3Vu
ZCBldmVudCBkZXZpY2U6ICVzIiwKPiBwYXRoKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiAtLQo+IDIuNDguMS43
MTEuZzJmZWFiYWIyNWEtZ29vZwo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
