Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9002C3271E
	for <ltp@archiver.kernel.org>; Sat,  6 Jul 2024 03:43:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52F063D0768
	for <ltp@archiver.kernel.org>; Sat,  6 Jul 2024 05:43:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D17523C00FB
 for <ltp@lists.linux.it>; Sat,  6 Jul 2024 05:43:41 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 955F01400441
 for <ltp@lists.linux.it>; Sat,  6 Jul 2024 05:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720237418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bshogGUhgYAz4W+BRr2mngK47NdcUSIgFb7cht366fA=;
 b=Dr5n944Wxkh8M3CfMq+awuBpHG8IgPwggqM3TFGoOD5+E3OlmabntXeZ4GB97oDE/IgzjK
 5xQM6RCkL7laB6f89ifyz7EIOqYI5f97KKy8+a47UUr9Jm38cfwq7M5wt1fMJF7AooaKSX
 UYCKuZVFWFr4kmAj5pPhwKxUpxbYsVo=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-BBPHpt_MP4Cp66gJw1xezA-1; Fri, 05 Jul 2024 23:43:36 -0400
X-MC-Unique: BBPHpt_MP4Cp66gJw1xezA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5c41551a445so1695516eaf.3
 for <ltp@lists.linux.it>; Fri, 05 Jul 2024 20:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720237416; x=1720842216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bshogGUhgYAz4W+BRr2mngK47NdcUSIgFb7cht366fA=;
 b=MpEvNjbTMJfiprgTQTMbeE5083a0pmwXQQatcW+q7638lYJRQraVsxplK+CbCki3f7
 8PuogBK+EEDk8eiWoFfcx9scQWtRI5c3Brt3HZmfUK/FSnkIOHs3VED+0/1V3wscbWzV
 /+O1Z1lEpwKkSXrZc8HwWJOTDpCeuMA0DfBbfurU/e9+H6Jz6UdF3/XH0//g0qIQXcSJ
 gm64X+A45USjgWZzvXbbhqBu82lbA32fj/fEDBUFkLbUQSLLci5NKYoVMIRkHfhe596J
 yGTzjYjDvxm+etZpumIZwt2XS9zGECw3nt8JYGW2WE2zPNL8kmaBBgZEwLGtT88IfcC9
 11Ng==
X-Gm-Message-State: AOJu0YzVjbuPoCDP1PvyOQV4XVxpVsDXknJ5xFTlVUPPX+SEmrWvqNjm
 uzO6D3z7JeLKFDOXlme24+BCVBl6p89dRTavsNWoXAYceZ4DWgJNlAkmgFiH8q2SJ+e61h3BryA
 obj8WJkI38ASmSDj45lvzWUCxBSWVpxes5DRKeYw1jLacgK7fO+bgsVjywjO7cNqlhm5TJSbVQN
 C1aCL+PvNBqiFWEbvG4CgTt0A=
X-Received: by 2002:a05:6358:611e:b0:1aa:b9f2:a0d2 with SMTP id
 e5c5f4694b2df-1aab9f2aaefmr29070755d.10.1720237415749; 
 Fri, 05 Jul 2024 20:43:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3Vcc5dZIb8MvvNtHpqfdB5QgKe7cBiW5Pqik6Av2FqGgkfaiKuF58s3HpaKnkWr3UGNIONvapKxOWyzl3Xpg=
X-Received: by 2002:a05:6358:611e:b0:1aa:b9f2:a0d2 with SMTP id
 e5c5f4694b2df-1aab9f2aaefmr29069555d.10.1720237415305; Fri, 05 Jul 2024
 20:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <IA1PR10MB724059C5A7A69CE2A4AF257698DF2@IA1PR10MB7240.namprd10.prod.outlook.com>
In-Reply-To: <IA1PR10MB724059C5A7A69CE2A4AF257698DF2@IA1PR10MB7240.namprd10.prod.outlook.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 6 Jul 2024 11:43:23 +0800
Message-ID: <CAEemH2fLGJY6D+GAgmFcoCk5jSw7-K5VkoDb1CEqTbwqfKw+Wg@mail.gmail.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Request for Modification of test cases
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgR3VsYW0sCgpPbiBTYXQsIEp1bCA2LCAyMDI0IGF0IDM6NDjigK9BTSBHdWxhbSBNb2hhbWVk
IHZpYSBsdHAgPGx0cEBsaXN0cy5saW51eC5pdD4Kd3JvdGU6Cgo+IEhpIFRlYW0sCj4KPiAgICAg
VGhpcyBpcyByZWdhcmRpbmcgdGhlIGNoYW5nZSBpbiBrZXJuZWwgYmVoYXZpb3IgYWJvdXQgdGhl
IHdheSB0aGUgbG9vcAo+IGRldmljZSBpcyBkZXRhY2hlZC4KPgo+ICAgICAgICAgICAgICAgQ3Vy
cmVudCBiZWhhdmlvcgo+ICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAg
ICAgICAgICAgICAgIFdoZW4gdGhlIExPT1BfQ0xSX0ZEIGlvY3RsIGNvbW1hbmQgaXMgc2VudCB0
byBkZXRhY2ggdGhlCj4gbG9vcCBkZXZpY2UsIHRoZSBlYXJsaWVyIGJlaGF2aW9yIHdhcyB0aGF0
IHRoZSBsb29wICAgICBkZXZpY2UgdXNlZCB0byBiZQo+IGRldGFjaGVkIGF0IHRoYXQgaW5zdGFu
Y2UgaXRzZWxmIGlmIHRoZXJlIHdhcyBhIHNpbmdsZSBvcGVuZXIgb25seS4gSWYKPiAgICAgICAg
ICAgICAgICB0aGVyZSB3ZXJlIG11bHRpcGxlIG9wZW5lcnMgb2YgdGhlIGxvb3AgZGV2aWNlLCB0
aGUKPiBiZWhhdmlvciB3YXMgdG8gZGVmZXIgdGhlIGRldGFjaCBvcGVyYXRpb24gYXQgdGhlIGxh
c3QgY2xvc2Ugb2YgdGhlIGRldmljZS4KPgo+ICAgICAgICAgICAgICAgTmV3IGJlaGF2aW9yCj4g
ICAgICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0KPiAgICAgICAgICAgICAgIEFzIHBlciB0
aGUgbmV3IGJlaGF2aW9yLCBpcnJlc3BlY3RpdmUgb2Ygd2hldGhlciB0aGVyZSBhcmUKPiBhbnkg
b3BlbmVycyBvZiB0aGUgbG9vcCBkZXZpY2Ugb3Igbm90LCB0aGUgZGV0YWNoIG9wZXJhdGlvbiBp
cyBkZWZlcnJlZCB0bwo+IHRoZSBsYXN0IGNsb3NlIG9mIHRoZSBkZXZpY2UuIFRoaXMgd2FzIGRv
bmUgdG8gYWRkcmVzcyBhbiBpc3N1ZSwgZHVlCj4gICAgICAgICAgICAgICB0byByYWNlIGNvZGl0
aW9ucywgcmVjZW50bHkgd2UgaGFkIGluIGtlcm5lbC4KPgo+ICAgICAgICAgICAgICAgV2l0aCB0
aGUgbmV3IGtlcm5lbCBiZWhhdmlvciBpbiBwbGFjZSwgc29tZSBvZiB0aGUgTFRQIHRlc3QKPiBj
YXNlcyBpbiAidGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC8iIGFyZSBmYWlsaW5nIGFz
IHRoZSBkZXZpY2UgaXMKPiBjbG9zZWQgYXQgdGhlIGVuZCBvZiB0aGUgdGVzdCBhbmQgdGhlIHRl
c3QgY2FzZXMgYXJlIGV4cGVjdGluZyBmb3IgdGhlCj4gICAgICAgICAgICAgICAgcmVzdWx0cyB3
aGljaCBjYW4gb2NjdXIgYWZ0ZXIgdGhlIGRldmljZSBpcyBkZXRhY2hlZC4gU29tZQo+IG9mIHRo
ZSB0ZXN0IGNhc2VzIHdoaWNoIGFyZSBmYWlsaW5nIGFyZToKPgo+ICAgICAgICAgICAgICAgMS4g
aW9jdGwwNCwgaW9jdGwwNSwgaW9jdGwwNiwgaW9jdGwwNywgaW9jdGwwOQo+ICAgICAgICAgICAg
ICAgMi4gaW9jdGxfbG9vcDAxLCBpb2N0bF9sb29wMDIsIGlvY3RsX2xvb3AwMywgaW9jdGxfbG9v
cDA0LAo+IGlvY3RsX2xvb3AwNSwgaW9jdGxfbG9vcDA2LCBpb2N0bF9sb29wMDcKPgo+ICAgICAg
ICAgICAgICAgVGhlIG1haW4gcm9vdCBjYXVzZSBvZiB0aGUgbW9zdCBvZiB0aGUgdGVzdCBmYWls
dXJlcywgaXMgdGhlCj4gZnVuY3Rpb24gInRzdF9kZXRhY2hfZGV2aWNlX2J5X2ZkKCkiIHdoZXJl
IHRoZSBmdW5jdGlvbiBpcyBleHBlY3RpbmcgZXJyb3IKPiBFTlhJTyB3aGljaCBpcyByZXR1cm5l
ZCBvbmx5IGFmdGVyIHRoZSBkZXZpY2UgaXMgZGV0YWNoZWQuIEJ1dAo+ICAgICAgICAgICAgICAg
ZGV0YWNoLCBhcyBwZXIgbmV3IGJlaGF2aW9yLCBoYXBwZW5zIG9ubHkgYWZ0ZXIgdGhlIGxhc3QK
PiBjbG9zZSAoaS5lIGFmdGVyIHRoaXMgZnVuY3Rpb24gaXMgcmV0dXJuZWQpLCB0aGUgdGVzdCB3
aWxsIGZhaWwgd2l0aAo+IGZvbGxvd2luZyBlcnJvcjoKPgo+ICAgICAgICAgICAgICAgImlvY3Rs
KC9kZXYvbG9vcDAsIExPT1BfQ0xSX0ZELCAwKSBubyBFTlhJTyBmb3IgdG9vIGxvbmciCj4KPiAg
ICAgICAgICAgICAgIFNpbWlsYXJseSwgc29tZSBvdGhlciB0ZXN0IGNhc2VzIGFyZSBleHBlY3Rp
bmcgcmVzdWx0cyB3aGljaAo+IGFyZSByZXR1cm5lZCBhZnRlciB0aGUgZGV0YWNoIG9wZXJhdGlv
biwgYnV0IGFzIHRoZSBkZXRhY2ggZGlkIG5vdCBoYXBwZW4sCj4gdW5leHBlY3RlZCB2YWx1ZXMg
YXJlIHJldHVybmVkIHJlc3VsdGluZyBpbiB0aGUgdGVzdCBmYWlsdXJlLgo+Cj4gICAgICAgICAg
ICAgICBTbywgY2FuIExUUCBtYWludGFpbmVycyB0ZWFtIGNoYW5nZSB0aGUgaW1wYWN0ZWQgdGVz
dCBjYXNlcwo+IHRvIGFjY29tbW9kYXRlIHRoZSBuZXcgYmVoYXZpb3Igb2Yga2VybmVsIGZvciB0
aGUgZGV0YWNoIG9wZXJhdGlvbiBvZiB0aGUKPiBsb29wIGRldmljZT8KPgoKClRoYW5rcyBmb3Ig
aGlnaGxpZ2h0aW5nIHRoZSBpc3N1ZSwgY2FuIHlvdSB0ZWxsIHdoaWNoIGtlcm5lbCB2ZXJzaW9u
Cihjb21taXQgPykKaW50cm9kdWNlZCB0aGF0IGNoYW5nZSwgdGhlbiB3ZSBjb3VsZCBhZGp1c3Qg
dGhlIHRlc3QgYWdhaW5zdCB0aGUgZGlmZmVyZW50Cmtlcm5lbHMuCgoKLS0gClJlZ2FyZHMsCkxp
IFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
