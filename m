Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC7EC3ABBF
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 11:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746618079; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Qr9rJHOh6xxz56BgoYmagJWigZ0OQj3sfV17YwdUqxM=;
 b=iDkgALtxsuBRXnu7lo0OEbcTwsbHTyiusOhV4qa2DSRDJngEkuLEzhSadT8UhfIrvePpv
 HOqSWkXPWQPLiA1OMCJmnvFFyey6jSWLbZVIdM/FxycrpYZ3XWmq6Mxhq8dZHtsOCx4SPQi
 NNdox3drWbn9YThCr6I1nfgHAMdD05k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A21663C2F97
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 13:41:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED5F13C2F97
 for <ltp@lists.linux.it>; Wed,  7 May 2025 13:40:56 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EC501140004F
 for <ltp@lists.linux.it>; Wed,  7 May 2025 13:40:53 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ee5a5bb66so4491548f8f.3
 for <ltp@lists.linux.it>; Wed, 07 May 2025 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1746618053; x=1747222853; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rzGFLy4ilCTcqZEe7iXutXlzHFyuh8PVkpJub4Z2fJw=;
 b=C22vYVgMLjQ4ygh+odzQD9FDse5lwSKUcjqGj1bPEfzQLT9NJN1JV84PZfpoQ96z83
 IIvcjA/2Kat4dhE8eiLXCVPr2dMBrby4j3e98ZR0WwvU/qjj6avfx81PZI3l6fVJgo9K
 EWD6wifLpduLLvKPK/NTE4aNjvV7IXPDDjxqELopT3l+HbPSEHf8ux5u1wZLvYBSNSab
 E9ZIzy25o9GzctDrtcMLwaoMw15OZnu3xBR7jgm3mC/XDSEEzzGRtlGFLv2PPiY8jU1j
 0rAcmM678fO7T/vOB3+oKyLJbPEPZKhgpaxoTNJqSxT0SEPCJU3ApUk3saWtbuhX9r0V
 7WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746618053; x=1747222853;
 h=in-reply-to:references:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rzGFLy4ilCTcqZEe7iXutXlzHFyuh8PVkpJub4Z2fJw=;
 b=sb26FFjI0YpskGmp/6aJCkZyInI8iUGRJ69u9cy8xK9AcxUfK0MFMLr58cji+9khWl
 MOA4sBLj+1NrcgOLE5zeg9ltU5FsPDGYooVV2ORbXAzb6TCzh+ptfSW9jQFJiokMyCWx
 Jp//NnLKV/NzqT4hGQuUynyVDvbxiev8RgU9rs8gFaPknwHgEwNJno99C2D+E796S05F
 9BW6GgtkuBw7ZEZcI9egGHlFghFGqIxzCSMMMEwP1QwgAFIisFM7+StMTEyU7Mw4p4KP
 fb/FmcDcNaCADnzIz/7ZOs7m91Xbcs2tib9x8DupUxWjq/F6kNSNWWh7GySUQ5IH8KSz
 uY5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYZyDwpOQEBx2Gv2L2iLr85qQCKHwg0v3//FD/UjqtUJgXUP+G9CTOUpaomOoBcTmUxwQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yweizn1P1w5eMblYd7WFyJ/nK94kmvZbCLdEzXy48TiVsgo7mOX
 htrsKZHeT0yUfUou1E9uZUq0lk9WboH2V02rX6A0MtfNAu0cnPubGGK2P0DVVw5bq/EZfKL3uTZ
 u
X-Gm-Gg: ASbGncuulXg4HDZYRichynas/8HKKjBPxd/4BOVn/2WAon6/EzB5u8qTo/hYiFqmqda
 o5xu29ydk1FUxrsc/8bqOVXkWqu1LzcP33M4UlQmNUX3X6Hpm4BDqzx23CuIHXxPdYd5y7mIz6n
 WRk+8jOLIPqnHhx44TmxU8Q/k/4pnEXIjlTcsXr1OAd4S4bcd6NqmY4RcbGXsoHJbH1/mWdyVJO
 6hhMkbQDycxIqKVUAm7SIMJ0taqMquhScaQGacg/TAog4UY82n2pDix9oOZS0Rbo3j2VB+vUMtx
 gsqT1NNaGCU5SOmj7TKZkY8jSncH
X-Google-Smtp-Source: AGHT+IEIVxNKlK4dZTgKS7lv+bqFoXPBBHHg0zHmAdNXJeBmTI5t7DQkBdv8A6fMtrQP6NQ7mVSaIQ==
X-Received: by 2002:a05:6000:2dc6:b0:3a0:b308:8427 with SMTP id
 ffacd0b85a97d-3a0b4a0391fmr2352039f8f.37.1746618053391; 
 Wed, 07 May 2025 04:40:53 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22e152201a1sm90925105ad.114.2025.05.07.04.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 04:40:52 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 07 May 2025 08:40:50 -0300
Message-Id: <D9PWFBAVIR7B.A3IAMRRCLS3@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250507113314.119628-1-pvorel@suse.cz>
In-Reply-To: <20250507113314.119628-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_net.sh: Avoid using tst_require_drivers in
 legacy API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkIE1heSA3LCAyMDI1IGF0IDg6MzMgQU0gLTAzLCBQZXRyIFZvcmVsIHdyb3RlOgo+IHRz
dF9yZXF1aXJlX2RyaXZlcnMgaXMgb25seSBpbiBuZXcgc2hlbGwgQVBJLiBBdm9pZCB1c2luZyBp
dCBpbiB0aGUgb2xkIEFQSS4KPgo+IFJlcG9ydGVkLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8
cmJtQHN1c2UuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
Pgo+IC0tLQo+IE5PVEU6IHRoZXJlIGFyZSBzdGlsbCA5IHJlbWFpbmluZyB0ZXN0cyBpbiB0aGUg
b2xkIEFQSSwgZS5nLgo+IGZ0cC11cGxvYWQtc3RyZXNzLnNoLiBCdXQgaW5zdGVhZCBvZiBjb252
ZXJ0aW5nIHRoZW0gaXQnZCBiZSBiZXR0ZXIgdG8KPiBzcGVuZCB0aW1lIHRvIHJlaW1wbGVtZW50
IHRoZSB0ZXN0Y2FzZToKPiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0
cC9pc3N1ZXMvMTIwNwo+Cj4gSSdtIG5vdCBzdXJlIGFib3V0IHVzYWJpbGl0eSBvZiBtdWx0aWNh
c3QgdGVzdHMgKGJ1dCBjb252ZXJ0aW5nIHRoZW0gdG8KPiBuZXcgc2hlbGwgQVBJIHNob3VsZCBi
ZSBlYXN5KS4KPgo+ICQgZ2l0IGdyZXAgLWwgVFNUX1VTRV9MRUdBQ1lfQVBJIHRlc3RjYXNlcy9u
ZXR3b3JrLwo+IHRlc3RjYXNlcy9uZXR3b3JrL211bHRpY2FzdC9tY19jbWRzL21jX2NtZHMuc2gK
PiB0ZXN0Y2FzZXMvbmV0d29yay9tdWx0aWNhc3QvbWNfY29tbW8vbWNfY29tbW8uc2gKPiB0ZXN0
Y2FzZXMvbmV0d29yay9tdWx0aWNhc3QvbWNfbWVtYmVyL21jX21lbWJlci5zaAo+IHRlc3RjYXNl
cy9uZXR3b3JrL211bHRpY2FzdC9tY19vcHRzL21jX29wdHMuc2gKPiB0ZXN0Y2FzZXMvbmV0d29y
ay9zdHJlc3MvZG5zL2Rucy1zdHJlc3Muc2gKPiB0ZXN0Y2FzZXMvbmV0d29yay9zdHJlc3MvZnRw
L2Z0cC1kb3dubG9hZC1zdHJlc3Muc2gKPiB0ZXN0Y2FzZXMvbmV0d29yay9zdHJlc3MvZnRwL2Z0
cC11cGxvYWQtc3RyZXNzLnNoCj4gdGVzdGNhc2VzL25ldHdvcmsvc3RyZXNzL2h0dHAvaHR0cC1z
dHJlc3Muc2gKPiB0ZXN0Y2FzZXMvbmV0d29yay90Y3BfY21kcy90Y3BkdW1wL3RjcGR1bXAwMS5z
aAo+Cj4gIHRlc3RjYXNlcy9saWIvdHN0X25ldC5zaCB8IDQgKysrLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2xpYi90c3RfbmV0LnNoIGIvdGVzdGNhc2VzL2xpYi90c3RfbmV0LnNoCj4gaW5kZXggOWE4
YjhkNzIxNC4uNmMyMjc4MzEzYyAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMvbGliL3RzdF9uZXQu
c2gKPiArKysgYi90ZXN0Y2FzZXMvbGliL3RzdF9uZXQuc2gKPiBAQCAtMTc1LDcgKzE3NSw5IEBA
IGluaXRfbHRwX25ldHNwYWNlKCkKPiAgCQl0c3RfcmVxdWlyZV9jbWRzIGlwIHRzdF9uc19jcmVh
dGUgdHN0X25zX2V4ZWMgdHN0X25zX2lmbW92ZQo+ICAJCXRzdF9yZXF1aXJlX3Jvb3QKPiAgCj4g
LQkJdHN0X3JlcXVpcmVfZHJpdmVycyB2ZXRoCj4gKwkJaWYgWyAteiAiJFRTVF9VU0VfTEVHQUNZ
X0FQSSIgXTsgdGhlbgo+ICsJCQl0c3RfcmVxdWlyZV9kcml2ZXJzIHZldGgKPiArCQlmaQoKVGhh
bmtzIGZvciB0aGUgcXVpY2sgZml4IQoKUmV2aWV3ZWQtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJl
IDxyYm1Ac3VzZS5jb20+Cgo+ICAJCVJPRCBpcCBsaW5rIGFkZCBuYW1lIGx0cF9uc192ZXRoMSB0
eXBlIHZldGggcGVlciBuYW1lIGx0cF9uc192ZXRoMgo+ICAJCXBpZD0iJChST0QgdHN0X25zX2Ny
ZWF0ZSBuZXQsbW50KSIKPiAgCQlta2RpciAtcCAvdmFyL3J1bi9uZXRucwoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
