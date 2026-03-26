Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5085910A62C0
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 12:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774529713; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=++VCbW85gRn3QWWCNrhxhhbTWTqIRtD8OL/mOeZTCG0=;
 b=Z0k6HvSaH5bHXFjE7kWUYQ+HIFk1Cz/PgMzxUjqzIjqGYvkXZ2tpzJGdSl5yczerdj77a
 YTsw4rP4LB3Ygr/fmqQlkfFLMRP2+R4bpoMwuHxjt88ybBxb0zI1mwDBZbzgMxBQ+6fw953
 10kdh2dk9Ogq7KFnpKMjYJqEE2FlVb4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EAB83CB7A6
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 13:55:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C32013C98E7
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 13:54:48 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E9B75600284
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 13:54:47 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so7866295e9.0
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774529687; x=1775134487; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BpGAJxt39UV2Bd0ekdTa8OJ0lCG8o7OWVc+3GGwWx9s=;
 b=HBgCiZ+H0FSeqIyed8FPcKxuhM0YqXvfzZZujuKW5EFtegZeZ8m0Rrd7AEA7VGb0pS
 GNMOhx5cx6Q/I1qx/gw1ZRhteIcdKTp0GjOcp+S00aW43kMiD7DSO/1m1Gyj2BDdEyNE
 nl1c1Nkj1X0XmocJtEKr2KZwLBPQiK0VCUf7PrI2tOcog43ST/uWx4IsG51BN7a+4TEV
 VwLhEh8W0KchB310q6646Il8uQhOJ//GJWgZBNbAXWhlpdxBKpTqF/fyUQSPf3sfAU4s
 XVOjVeWuUOAwdc2Nr7dm9Xofl09PQ9AIjroXueyFuNs0+zzoCWH9UOzVXymu0wqczLMZ
 /LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774529687; x=1775134487;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpGAJxt39UV2Bd0ekdTa8OJ0lCG8o7OWVc+3GGwWx9s=;
 b=s73KKhRPtzM28uTRgmf/84J0i0jRZj/8BoiI0HU9tqNJmvPev+tZT6I+HaRYpAfZ++
 q5RZRdXf+MrGLEc8ctiyrCGK7aFdt/CyQSRGalN7Np20ft9/+QdVPP4EiOzKuvP6lfzt
 df+RDd1GPu1vkH4x34WKjdtnu+cgXyRVGUQkQTFrMfgckOLaQiWUJ2UdBlAB8D3FzVzZ
 6bjTQHAptTjfPRXlpdbHxFYA+noSJE7k7mUeNJCVBE6g8M6yIHmdF9vw3Lp81/IvQyoP
 UuisTmnguqo3fzqb2Aa42D2DPcUw+t9YO/kq86gdSqDKA237N+CIgLGHFtQeqz4nBiaw
 M+OQ==
X-Gm-Message-State: AOJu0Yxg3yQ1r0ePmWu9zWlemq8d8hmj/HkMw0m2qlW4NBA1pIcUA7Cx
 AuMm6ETkPAWBBHOUfxL1JWsRKxd/6c/PRwbJnMNDrchJOEKXCGvwEEffXD9S/DMOJfXef6ZUPQ/
 4aBduvkfjpQ==
X-Gm-Gg: ATEYQzzhBvMnrvd2gbRWx/usCTSc2MGRaaQXhWycArkJTIe0nN58cxx02aq0lH43CiD
 aDDOIxicTiVLFMMOJatOobPAYu6E6YlXI/MfaWZzBMe0e0yNeSCDeuBE30z/crvJsTvZL1tZYrj
 dXAx9JB0lCDphARsPuQDiIVQSrWJgQ7nbog0+vedDq2AVUA5bhuD+nKiYgtpbVEBVePrASuuxm1
 IFVQzC/LsB/lXvRpBKjxtBCQi1IA6znBnYYVpO2icYyTywbFGdPPQSjBnT3mwkOPKhPXGFh7MuA
 jgslrDhfd3Zn/VWNLZW816u5gTOBJUofwGMpUn8LJxl5MOsEAXOWnpoPZCUrN1rJ285x4TCbsVg
 xi7gD/82mb2Y8GleHwDxWVhIQ1XM4/dm9zdf/zu0KC0xXBe6iqTluo7bjlFEeoCGo9EsSN4ELwP
 G7kG+SkX3lnudRcPFlQlXwfiY1bb4H+eC+HYBU9wEMdcWm/qJkVsU=
X-Received: by 2002:a05:600c:4705:b0:487:300:d9ca with SMTP id
 5b1f17b1804b1-487160a2a33mr118451695e9.31.1774529687265; 
 Thu, 26 Mar 2026 05:54:47 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fbca47dsm26150915e9.1.2026.03.26.05.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 05:54:46 -0700 (PDT)
Message-ID: <69c52c96.050a0220.3d9c1f.4146@mx.google.com>
To: Samir <samir@linux.ibm.com>
In-Reply-To: <20260317102059.6699-1-samir@linux.ibm.com>
Date: Thu, 26 Mar 2026 12:54:45 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Migrating the
 libhugetlbfs/testcases/truncate_sigbus_versus_oom.c test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Samir <samir@linux.ibm.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgU2FtaXIsCgpUaGFua3MgZm9yIHRoZSBtaWdyYXRpb24uIFRoaXMgaXMganVzdCBhIGZpcnN0
IGxpbmUgcmV2aWV3IG9uIHRoZSBtYWpvcgppc3N1ZXMgcmVsYXRlZCB0byB0aGlzIHBhdGNoLiBQ
cm9iYWJseSBtb3JlIHdpbGwgY29tZSB3aXRoIHRpbWUgaWYgdGhlc2UKaXNzdWVzIHdvbid0IGJl
IGFjaGlldmVkLgoKPiBTdWJqZWN0OiBbUEFUQ0hdIE1pZ3JhdGluZyB0aGUKPiAgbGliaHVnZXRs
YmZzL3Rlc3RjYXNlcy90cnVuY2F0ZV9zaWdidXNfdmVyc3VzX29vbS5jIHRlc3QKClRoZSBzdWJq
ZWN0IHNob3VsZCB1c2UgaW1wZXJhdGl2ZSBtb29kLCBlLmcuOgoKICBodWdlbW1hcDM3OiBNaWdy
YXRlIHRydW5jYXRlX3NpZ2J1c192ZXJzdXNfb29tIGZyb20gbGliaHVnZXRsYmZzCgo+IEluIHRo
aXMgdGVzdCBjYXNlLCB3ZSBhcmUgdmVyaWZ5aW5nIHRoZSBidWcgZml4IGNvbW1pdCB0aGF0IGlz
IGF0dGFjaGVkIGFzIGEgcGFydCBvZiB0aGUgdGVzdCBjYXNlIHN0cnVjdHVyZSwKPgo+IFNvbWUg
a2VybmVsIGhhdmUgYSBidWcgaW4gdGhlIHBvc2l0aW9uaW5nIG9mIHRoZSB0ZXN0IGFnYWluc3QK
CiJTb21lIGtlcm5lbCBoYXZlIiAtPiAiU29tZSBrZXJuZWxzIGhhdmUiLiBUaGUgZmlyc3Qgc2Vu
dGVuY2UgZW5kcyB3aXRoCmEgZGFuZ2xpbmcgY29tbWEgYW5kIGlzIHZhZ3VlLiBDb25zaWRlciBk
cm9wcGluZyBpdCBlbnRpcmVseSDigJQgdGhlCnNlY29uZCBwYXJhZ3JhcGggYWxyZWFkeSBleHBs
YWlucyB0aGUgdGVzdCBjbGVhcmx5LgoKWy4uLl0KCj4gK3ZvaWQgc2V0dXAodm9pZCkKPiArewo+
ICsJc3RydWN0IHNpZ2FjdGlvbiBzYTsKClR3byBpc3N1ZXMgaGVyZToKCjEpIHNldHVwKCkgYW5k
IGNsZWFudXAoKSBhcmUgbWlzc2luZyB0aGUgJ3N0YXRpYycga2V5d29yZC4KCjIpICdzYScgaXMg
dW5pbml0aWFsaXplZCDigJQgc2FfbWFzayBhbmQgb3RoZXIgZmllbGRzIGNvbnRhaW4gZ2FyYmFn
ZS4KICAgWmVyby1pbml0aWFsaXplIGl0OgoKICAgICAgIHN0cnVjdCBzaWdhY3Rpb24gc2EgPSB7
fTsKICAgICAgIHNpZ2VtcHR5c2V0KCZzYS5zYV9tYXNrKTsKCj4gKwlzYS5zYV9mbGFncyA9IFNB
X1NJR0lORk87Cj4gKwlzYS5zYV9oYW5kbGVyID0gc2lnYnVzX2hhbmRsZXI7CgpTQV9TSUdJTkZP
IHRlbGxzIHRoZSBrZXJuZWwgdG8gdXNlIHNhX3NpZ2FjdGlvbiAoMy1hcmd1bWVudCBoYW5kbGVy
KSwKYnV0IHlvdSBhc3NpZ24gdG8gc2FfaGFuZGxlciAoMS1hcmd1bWVudCkuIFRoaXMgaXMgdW5k
ZWZpbmVkIGJlaGF2aW9yCnBlciBQT1NJWC4gU2luY2Ugc2lnYnVzX2hhbmRsZXIoKSB0YWtlcyBh
IHNpbmdsZSBpbnQsIGRyb3AgU0FfU0lHSU5GTzoKCiAgICBzYS5zYV9mbGFncyA9IDA7CiAgICBz
YS5zYV9oYW5kbGVyID0gc2lnYnVzX2hhbmRsZXI7Cgo+ICsJdG90cGFnZXMgPSBTQUZFX1JFQURf
TUVNSU5GTyhNRU1JTkZPX0hQQUdFX0ZSRUUpOwo+ICsJaHBhZ2Vfc2l6ZSA9IHRzdF9nZXRfaHVn
ZXBhZ2Vfc2l6ZSgpOwoKVGhlIHRvdHBhZ2VzIGFzc2lnbm1lbnQgaGVyZSBpcyBkZWFkIGNvZGUg
4oCUIGl0IGdldHMgb3ZlcndyaXR0ZW4gaW4KcnVuX3Rlc3QoKSBiZWZvcmUgdXNlLiBSZW1vdmUg
aXQgZnJvbSBzZXR1cCgpLgoKWy4uLl0KCj4gKwlmZCA9IHRzdF9jcmVhdF91bmxpbmtlZChNTlRQ
T0lOVCwgMCwgMDYwMCk7Cj4gKwlwID0gU0FGRV9NTUFQKE5VTEwsIGhwYWdlX3NpemUsIFBST1Rf
UkVBRCB8IFBST1RfV1JJVEUsIE1BUF9TSEFSRUQsIGZkLCAwKTsKClsuLi5dCgo+ICsJZmR4ID0g
dHN0X2NyZWF0X3VubGlua2VkKE1OVFBPSU5ULCAwLCAwNjAwKTsKClsuLi5dCgo+ICsJcSA9IFNB
RkVfTU1BUChOVUxMLCB0b3RwYWdlcyAqIGhwYWdlX3NpemUsIFBST1RfUkVBRCB8IFBST1RfV1JJ
VEUsIE1BUF9TSEFSRUQsCj4gKwkJCWZkeCwgMCk7CgpmZCBhbmQgZmR4IGFyZSBvcGVuZWQgZWFj
aCBpdGVyYXRpb24gYnV0IG9ubHkgY2xvc2VkIGluIGNsZWFudXAoKS4gT24KLWkgTiBydW5zIHRo
ZSBwcmV2aW91cyBmZHMgbGVhay4gU2ltaWxhcmx5LCBwIGFuZCBxIGFyZSBtbWFwJ2QgYnV0Cm5l
dmVyIG11bm1hcHBlZCwgbGVha2luZyB2aXJ0dWFsIG1lbW9yeSBlYWNoIGl0ZXJhdGlvbi4KCkNs
b3NlIHRoZSBmZHMgYW5kIG11bm1hcCBib3RoIHJlZ2lvbnMgYXQgdGhlIGVuZCBvZiBydW5fdGVz
dCgpLCByZXNldHRpbmcKZmQvZmR4IHRvIC0xLgoKWy4uLl0KCj4gK3ZvaWQgY2xlYW51cCh2b2lk
KQo+ICt7Cj4gKwlpZiAoZmQgPiAwKQo+ICsJCVNBRkVfQ0xPU0UoZmQpOwo+ICsJaWYgKGZkeCA+
IDApCj4gKwkJU0FGRV9DTE9TRShmZHgpOwoKaWYgKGZkICE9IC0xKSBhbmQgZmQgc2hvdWxkIGJl
IGluaXRpYWxpemVkIHRvIC0xLiB6ZXJvIGlzIGEgdmFsaWQgdmFsdWUuCgpSZWdhcmRzLAotLQpB
bmRyZWEgQ2VydmVzYXRvClNVU0UgUUUgQXV0b21hdGlvbiBFbmdpbmVlciBMaW51eAphbmRyZWEu
Y2VydmVzYXRvQHN1c2UuY29tCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
