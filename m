Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5158D1038D
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 08:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764144936; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=H3RgAsNcAEz8+UJBQrVMVClNymDOx6jDTs4yzRGpWC0=;
 b=nkjdFG22tZhJvgluRQxRoxcczxqp0f4bi73qn2h5vZf52mQ0rEeiPD7OzR+404OARO9sG
 3LFv7A8m8N+xqAo85JcYYzxKnNX6Duth6Y2l0ko7j9df09JAc/bpkRUW21TbB8IQvNXw1VR
 I2rcoNymKSBeA/fHZsESSv6gCUVzxaU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FA453CF2C1
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 09:15:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB8A03C23F1
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 09:15:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DB5F61000A3A
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 09:15:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764144913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/LjhA+xMqPVIj1J2APUZfeNNvD1u7heYqhAl/bRs00=;
 b=Lcr0vAcvpJZ9tIFFSo5aKk3qgXsw89yMi2msdcek2ydEw/hfVtNLtwFVox/MUU1L0+niI1
 l0uJTefaFPfoyXZls/ej5MqLrGzWSjWxsbO35wz2BYNe2sAjVTdFToK/qEae3Nf66fjGyV
 MD2nliZbyusX9zcPciBQ0f68WNaHyTQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-FFHIzhwAPuagsK50ZZSMOA-1; Wed, 26 Nov 2025 03:15:11 -0500
X-MC-Unique: FFHIzhwAPuagsK50ZZSMOA-1
X-Mimecast-MFC-AGG-ID: FFHIzhwAPuagsK50ZZSMOA_1764144910
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b5556d80bso4595231f8f.2
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 00:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764144910; x=1764749710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f/LjhA+xMqPVIj1J2APUZfeNNvD1u7heYqhAl/bRs00=;
 b=oCjoQvg2CnuJS+qFnd2a1rWAwEh1+aWxVobwsGzbzafO8ywhnaLUFbpSSjCTGu89GQ
 wSYSSmHlVdXTvTaiEEZtH2ncO3ZuKBxJxyrXuxnj7rke2KPqOIYGYE9E0E11CRcQHOfb
 Ek3yepCgnZiATFPG2cXF4yjO8i0e3evqcW9LnG02qbOHd9irO4gVm8zVy6upVSSAYI4+
 tMXLyK1NNWfM3Cng7tY3NlO6Jk6im1nlOkw+r8TvSjxCdqQgZHcMi/cdWa2wMlPZHBqe
 a5v40xDknMAD19Za/0qd9SV85c5Mk7ZuEpQIIV902wdtAKA3B2xinQbt5FDFqudroaeJ
 cfpw==
X-Gm-Message-State: AOJu0YwKn9vJsCgxfXf+yj++wgP9wL7HO5oHKf27mhvx29/JQIFdh3+H
 +aglm34e6J6mTpa/LkNypl1igYrWBAxBlhKL2z8y1XAi5bUaR3cwbgP/ICStExPRAeK4i4yespi
 +0E54zKD4wU30obmwM+wpJQTyylhUI1I4MHsj7uBQ/kuyXuhyl0CcsXbumpaKeQLmOiY0CeBVM1
 UbOI9Z3Jnu/SrMrreIMfpOXvCnhto=
X-Gm-Gg: ASbGncvHVaw3x4sEa57dnNYLTvHYyfjxnhM+FNKoaSvE0MlpGaviRN4hU5kx6vTBMuU
 TI7CEB0JqpLktaeipdQiAtOjd8i8Egpp03V5h0iV3lRTLm/Uf7Z6uzsABamIxi8PcW2zLwqOazO
 pmh6WKBC1FPLIjB+XnCpv1zk9hYokv/1mX8D6VUdTSP7kA0JI1ZLUnauZQndC377pA
X-Received: by 2002:a05:6000:3109:b0:42b:4139:577b with SMTP id
 ffacd0b85a97d-42e0f34f7e7mr5711248f8f.45.1764144909992; 
 Wed, 26 Nov 2025 00:15:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOA2skFZbpYFSe0jMsJas1O+Vi8vUYUkt3OLwacTSWrkd9dnYvscc0AhxpBXlb4DdfrlmklKt4zuE8AbXrLdc=
X-Received: by 2002:a05:6000:3109:b0:42b:4139:577b with SMTP id
 ffacd0b85a97d-42e0f34f7e7mr5711225f8f.45.1764144909545; Wed, 26 Nov 2025
 00:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20251126073521.159834-1-liwang@redhat.com>
In-Reply-To: <20251126073521.159834-1-liwang@redhat.com>
Date: Wed, 26 Nov 2025 09:14:52 +0100
X-Gm-Features: AWmQ_bkMXe6ebj8G4nADR-W_vftqHgXK_yiHZYas6I-zWr4CoUS5QMf8Ugu3pW0
Message-ID: <CAASaF6zB399vN6VNGy0MaAfWn77dhpC+zyoMYii2Ca-92VSFCQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: By17dOWYJLS0_mgQyW3YMiz1cVi6eB5zAsB2oiZk57A_1764144910
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] readahead02: detect cache stats via mincore
 per testfile
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

T24gV2VkLCBOb3YgMjYsIDIwMjUgYXQgODozNeKAr0FNIExpIFdhbmcgdmlhIGx0cCA8bHRwQGxp
c3RzLmxpbnV4Lml0PiB3cm90ZToKPgo+IFN0b3Agc2FtcGxpbmcgZ2xvYmFsIOKAnENhY2hlZOKA
nSBmcm9tIC9wcm9jL21lbWluZm8gYW5kIGluc3RlYWQgbWVhc3VyZSBob3cKPiBtYW55IGJ5dGVz
IG9mIHRoZSBjdXJyZW50IHRlc3QgZmlsZSBhcmUgcmVzaWRlbnQgdmlhIG1pbmNvcmUoKS4gVGhp
cyBsZXRzCj4gdGhlIHRlc3QgcmVwb3J0IHBlci1maWxlIGNhY2hlIHVzYWdlLCByZW1vdmVzIHRo
ZSBNRU1JTkZPIGRlcGVuZGVuY3ksIGFuZAo+IG1ha2VzIHRoZSByZWFkYWhlYWQgd2FpdCBsb29w
IHdhdGNoIHRoZSBhY3R1YWwgZmlsZSBjYWNoZSBncm93dGguCj4KPiBCZWNhdXNlIHRoZSBtaW5j
b3JlIHZhbHVlcyBhcmUgYWxyZWFkeSBpbiBieXRlcyB3ZSBubyBsb25nZXIganVnZ2xlCj4gY2Fj
aGVkX2hpZ2gvY2FjaGVkX2xvdyBkZWx0YXMgbm9yIHNjYWxlIGJ5IDEwMjQuIFRoZSBjYWNoZS1j
YXBhY2l0eSBnYXRlCj4gbm93IGNvbXBhcmVzIGNhY2hlZF9tYXggZGlyZWN0bHkgYWdhaW5zdCB0
ZXN0ZmlsZV9zaXplLCBhbmQgdGhlIHVzZXItCj4gdmlzaWJsZSBrQiBwcmludHMgYXJlIGRlcml2
ZWQgZnJvbSB0aGUgYnl0ZSBjb3VudGVycy4KPgo+IE5vdGU6IHRoaXMgcGF0Y2ggYmVzZWQgb24g
Q3lyaWwncyBjaGFuZ2U6Cj4gICAgIGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0
cC8yMDI1LU5vdmVtYmVyLzA0NTcxOC5odG1sCj4KPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxs
aXdhbmdAcmVkaGF0LmNvbT4KPiAtLS0KPiAgLi4uL2tlcm5lbC9zeXNjYWxscy9yZWFkYWhlYWQv
cmVhZGFoZWFkMDIuYyAgIHwgODYgKysrKysrKysrKysrLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNTMgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZWFkYWhlYWQvcmVhZGFoZWFkMDIuYyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvcmVhZGFoZWFkL3JlYWRhaGVhZDAyLmMKPiBpbmRleCBlMGY1NmU5
ODkuLjAwYWI0NzBjNCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Jl
YWRhaGVhZC9yZWFkYWhlYWQwMi5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9y
ZWFkYWhlYWQvcmVhZGFoZWFkMDIuYwo+IEBAIC0zNiw3ICszNiw2IEBACj4KPiAgc3RhdGljIGNo
YXIgdGVzdGZpbGVbUEFUSF9NQVhdID0gInRlc3RmaWxlIjsKPiAgI2RlZmluZSBEUk9QX0NBQ0hF
U19GTkFNRSAiL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzIgo+IC0jZGVmaW5lIE1FTUlORk9fRk5B
TUUgIi9wcm9jL21lbWluZm8iCj4gICNkZWZpbmUgUFJPQ19JT19GTkFNRSAiL3Byb2Mvc2VsZi9p
byIKPiAgI2RlZmluZSBERUZBVUxUX0ZJTEVTSVpFICg2NCAqIDEwMjQgKiAxMDI0KQo+ICAjZGVm
aW5lIElOSVRJQUxfU0hPUlRfU0xFRVBfVVMgMTAwMDAKPiBAQCAtMTEwLDEzICsxMDksNDUgQEAg
c3RhdGljIHVuc2lnbmVkIGxvbmcgZ2V0X2J5dGVzX3JlYWQodm9pZCkKPiAgICAgICAgIHJldHVy
biByZXQ7Cj4gIH0KPgo+IC1zdGF0aWMgdW5zaWduZWQgbG9uZyBnZXRfY2FjaGVkX3NpemUodm9p
ZCkKPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgZ2V0X2ZpbGVfY2FjaGVkX2J5dGVzKGNvbnN0IGNo
YXIgKnBhdGgsIHNpemVfdCBsZW5ndGgpCgpBdG0uIEkgZG9uJ3Qgc2VlIGFuIGlzc3VlIHdpdGgg
dGhpcyBhcHByb2FjaCwganVzdCB3b25kZXJpbmcgd2hldGhlcgp0aGlzIGZ1bmN0aW9uIHdvdWxk
IGJlIHVzZWZ1bAp0byBoYXZlIHNvbWV3aGVyZSBpbiBsaWIsIHdoYXQgZG8geW91IHRoaW5rPwoK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
