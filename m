Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C755E77180
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 12:55:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81C8D3E8D9A
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 13:55:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4DE23E8D6D
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 13:54:55 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EBF8960E694
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 13:54:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733835293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpK7aqGrjpL8YXwTlMBg1BdNgrPHkf1YPMr4HXwF3Yo=;
 b=K2GiJkyrkLJbrzAbAvM80lpNxqMyU0xiIw7T2gU1p8/nne41i3/ogBq4vbd7Ql8cvRd6FD
 2awySn8+VCMUMaUMy9O6GGxFqCCIgn7dZhKqwz+gsCetYAhbGEQjZzdafrVIN1oirM3tzd
 KVUg5yCQlmIpArXyP1wMyP8bU315lXE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-gpLegSlXNgyQ1AyCKjknYg-1; Tue, 10 Dec 2024 07:54:51 -0500
X-MC-Unique: gpLegSlXNgyQ1AyCKjknYg-1
X-Mimecast-MFC-AGG-ID: gpLegSlXNgyQ1AyCKjknYg
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5f2a1af1713so1965406eaf.1
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 04:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733835291; x=1734440091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qpK7aqGrjpL8YXwTlMBg1BdNgrPHkf1YPMr4HXwF3Yo=;
 b=JH5K9+sRoipFgJNQpkotyLpr22QJbhVo7CpF0sxEZ87WPT4OsUg+4YKvuGKDKKwcrl
 mJOtZ01kc5vpHGYx5ezqHfyh2YvYvzQ9ApLuaQxKFqKJgSjVgxZJ4y7pOBNS+gyLlYER
 jYVNbmwM8uQLtPy1/6gdrjJJdk4UC+iBk34dCAAFf757fSlREEgO2UD2O8f580n6Ub7C
 SvdLkI9Lddyf9VC7xmUH1JXhrfXliFjEmCk9fMtUCXvWYmNW/WDE6x2NGse1n57kfY0a
 VlKMAagLkm/bO1vheoC7pFJFkvCtzp+rx1Nq0VrPGXLhaLD8NnNO1C+w/pqnq+jk157X
 ykxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4nzWjzcYl10PMOsHoSOqxc73FFRDJ/VJcyK1zQf20ptOhECcG1O/sEL2r1Hn9TBfn7KM=@lists.linux.it
X-Gm-Message-State: AOJu0YxHggz4GNuFUZZJgvDUnzfCT282ABd04ja5LDTF2nnQiZfsoY9R
 zKYZesWY13RGazNTJ9sLXrRUKDPy2pHc1KVMzaL4B8e/7kXzFEdHsRGsJl6VWrsmpUy+INSGoHm
 lYvbM557S0+9CYgOEPRDwpgfRMGMtX+T7rgDUVafzI3TxYmptsIPsk1afigrX4FQXJd6BsTP/sZ
 Lp945BNmOtno+26t2i6cfrxaQ=
X-Gm-Gg: ASbGncuuOGnQ9wMLmfnG+Dxnw6mGpKtGKeP/TsY24RFdAwFSH7HZukyN/A/PUZogT4b
 gR7qEhpAQaPB80KPQYlegAc62oSBM2iQ2MeE=
X-Received: by 2002:a05:6808:ec9:b0:3ea:4f41:81c5 with SMTP id
 5614622812f47-3eb19df843amr9495253b6e.32.1733835291160; 
 Tue, 10 Dec 2024 04:54:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDi2sUgAYpVz8z2qAtFqtelLia1UsSvqZbyOfg+EYkysYJRk44MNatBfy3+LlEdY/6LE4OhP/q4MT4LfncUe0=
X-Received: by 2002:a05:6808:ec9:b0:3ea:4f41:81c5 with SMTP id
 5614622812f47-3eb19df843amr9495241b6e.32.1733835290691; Tue, 10 Dec 2024
 04:54:50 -0800 (PST)
MIME-Version: 1.0
References: <Z1grtnHIJz//u4kB@wegao>
In-Reply-To: <Z1grtnHIJz//u4kB@wegao>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Dec 2024 13:54:35 +0100
Message-ID: <CAASaF6yCT_B87ZN5fjC=n0WodMXjavgVTct=FM4xDi5N+WzwSQ@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g-qAdtS_EpfKn7ZupJJ3qW4obJxMNom6S7RtWa-j6is_1733835291
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Question on hugemmap34
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
Cc: samir@linux.vnet.ibm.com, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 emunson@mgebm.net, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBEZWMgMTAsIDIwMjQgYXQgMTI6NTPigK9QTSBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNv
bT4gd3JvdGU6Cj4KPiBIaSBBTEwKPgo+IElzIHRoZXJlIGFueSBzcGVjaWFsIGNvbmZpZyBuZWVk
ZWQgZm9yIHRoaXMgdGVzdCBjYXNlPyBTaW5jZSB0aGUgdGVzdCBmYWlsZWQgd2l0aCB0aGUgZm9s
bG93aW5nIG91dHB1dCBvbiBteSB0ZXN0IHNldHVwKG9wZW5zdXNlMTUuNSB3aXRoIDYuMTIga2Vy
bmVsKToKPgo+IHRzdF9odWdlcGFnZS5jOjg0OiBUSU5GTzogMSBodWdlcGFnZShzKSByZXNlcnZl
ZAo+IHRzdF90bXBkaXIuYzozMTc6IFRJTkZPOiBVc2luZyAvdG1wL0xUUF9odWdMU0piN3IgYXMg
dG1wZGlyIChidHJmcyBmaWxlc3lzdGVtKQo+IHRzdF90ZXN0LmM6MTEwMDogVElORk86IE1vdW50
aW5nIG5vbmUgdG8gL3RtcC9MVFBfaHVnTFNKYjdyL2h1Z2V0bGJmcyBmc3R5cD1odWdldGxiZnMg
ZmxhZ3M9MAo+IHRzdF90ZXN0LmM6MTg5MDogVElORk86IExUUCB2ZXJzaW9uOiAyMDI0MDkzMAo+
IHRzdF90ZXN0LmM6MTg5NDogVElORk86IFRlc3RlZCBrZXJuZWw6IDYuMTIuMy1scDE1NS4xMS5n
NzhiMDAzMC12YW5pbGxhICMxIFNNUCBGcmkgRGVjICA2IDA4OjU2OjM5IFVUQyAyMDI0ICg3OGIw
MDMwKSBwcGM2NGxlCj4gdHN0X3Rlc3QuYzoxNzI3OiBUSU5GTzogVGltZW91dCBwZXIgcnVuIGlz
IDBoIDAwbSAzMHMKPiB0c3RfY29yZWR1bXAuYzozMjogVElORk86IEF2b2lkIGR1bXBpbmcgY29y
ZWZpbGUgZm9yIHByb2Nlc3MocGlkPTY2NzEpCj4gaHVnZW1tYXAzNC5jOjg4OiBUQlJPSzogd2Fp
dHBpZCgwLDB4N2ZmZmQ4YmFhMjIwLDApIGZhaWxlZDogRUNISUxEICgxMCkKClRoZXJlJ3MgbWlz
c2luZyBleGl0KCkgaW4gZG9fY2hpbGQoKSwgYnV0IHRoYXQncyBub3QgdGhlIG9ubHkgaXNzdWUK
d2l0aCB0aGUgdGVzdC4KCj4gaHVnZW1tYXAzNC5jOjkyOiBURkFJTDogQ2hpbGQ6IGV4aXRlZCB3
aXRoIDIKPgo+IFRoZSByb290IGNhdXNlIGlzIHRoZSBtbWFwIGNhbGwgZW5jb3VudGVyIGZhaWx1
cmUgd2l0aCBFQlVTWS4KPgo+IExUUCBtbWFwIGNhbGwKPiBodHRwczovL2dpdGh1Yi5jb20vbGlu
dXgtdGVzdC1wcm9qZWN0L2x0cC9ibG9iLzdiYjk2MGNjNGY3MzZkODg2MGI2YjI2NjExOWU3MWU3
NjFlMjJiMzIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDM0
LmMjTDcxCj4KPiBoaXQga2VybmVsIGNvZGUKPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC92Ni4xMi9zb3VyY2UvYXJjaC9wb3dlcnBjL21tL2Jvb2szczY0L3NsaWNlLmMjTDU2OAo+
Cj4gTGV0IG1lIGdpdmUgYW4gZXhhbXBsZSB0byBleHBsYWluIHdoeSB0aGlzIGhhcHBlbnMgYmFz
ZSBwbWFwIG9mIHByb2Nlc3MgaW4gbXkgdGVzdCBzeXN0ZW06Cj4KPiBBZGRyZXNzICAgICAgICAg
ICBLYnl0ZXMgICAgIFJTUyAgICAgUFNTICAgRGlydHkgICAgU3dhcCBNb2RlICBNYXBwaW5nCj4g
MDAwMDAwMDAxMDAwMDAwMCAgICAgMjU2ICAgICAyNTYgICAgIDEyOCAgICAgMjU2ICAgICAgIDAg
ci14cC0gL3Jvb3QvbHRwL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVn
ZW1tYXAzNAo+IDAwMDAwMDAwMTAwNDAwMDAgICAgICA2NCAgICAgIDY0ICAgICAgMzIgICAgICA2
NCAgICAgICAwIHItLXAtIC9yb290L2x0cC90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1
Z2VtbWFwL2h1Z2VtbWFwMzQKPiAwMDAwMDAwMDEwMDUwMDAwICAgICAgNjQgICAgICA2NCAgICAg
IDY0ICAgICAgNjQgICAgICAgMCBydy1wLSAvcm9vdC9sdHAvdGVzdGNhc2VzL2tlcm5lbC9tZW0v
aHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDM0Cj4gMDAwMDAwMDAxMDA2MDAwMCAgICAgIDY0ICAg
ICAgNjQgICAgICA2NCAgICAgIDY0ICAgICAgIDAgcnctcC0gICBbIGFub24gXQo+IDAwMDAwMTAw
MTAwOTAwMDAgICAgIDE5MiAgICAgIDY0ICAgICAgNjQgICAgICA2NCAgICAgICAwIHJ3LXAtICAg
WyBhbm9uIF0KPiAwMDAwN2ZmZjhmM2IwMDAwICAgIDIzNjggICAgMTQwOCAgICAgICAwICAgICAg
IDAgICAgICAgMCByLXhwLSAvbGliNjQvbGliYy5zby42Cj4gMDAwMDdmZmY4ZjYwMDAwMCAgICAg
IDY0ICAgICAgNjQgICAgICAzMiAgICAgIDY0ICAgICAgIDAgci0tcC0gL2xpYjY0L2xpYmMuc28u
Ngo+IDAwMDA3ZmZmOGY2MTAwMDAgICAgICA2NCAgICAgIDY0ICAgICAgNjQgICAgICA2NCAgICAg
ICAwIHJ3LXAtIC9saWI2NC9saWJjLnNvLjYKPiAwMDAwN2ZmZjhmNjIwMDAwICAgICAgNjQgICAg
ICA2NCAgICAgIDMyICAgICAgNjQgICAgICAgMCBydy1zLSAvZGV2L3NobS9sdHBfaHVnZW1tYXAz
NF8xNTUxMyAoZGVsZXRlZCkKPiAwMDAwN2ZmZjhmNjMwMDAwICAgICAxMjggICAgICAgMCAgICAg
ICAwICAgICAgIDAgICAgICAgMCByLS1wLSAgIFsgYW5vbiBdCj4gMDAwMDdmZmY4ZjY1MDAwMCAg
ICAgIDY0ICAgICAgIDAgICAgICAgMCAgICAgICAwICAgICAgIDAgci14cC0gICBbIGFub24gXQo+
IDAwMDA3ZmZmOGY2NjAwMDAgICAgIDMyMCAgICAgMTI4ICAgICAgIDAgICAgICAgMCAgICAgICAw
IHIteHAtIC9saWI2NC9sZDY0LnNvLjIKPiAwMDAwN2ZmZjhmNmIwMDAwICAgICAgNjQgICAgICA2
NCAgICAgIDMyICAgICAgNjQgICAgICAgMCByLS1wLSAvbGliNjQvbGQ2NC5zby4yCj4gMDAwMDdm
ZmY4ZjZjMDAwMCAgICAgIDY0ICAgICAgNjQgICAgICA2NCAgICAgIDY0ICAgICAgIDAgcnctcC0g
L2xpYjY0L2xkNjQuc28uMgo+IDAwMDA3ZmZmYzY3NDAwMDAgICAgIDE5MiAgICAgIDY0ICAgICAg
NjQgICAgICA2NCAgICAgICAwIHJ3LXAtICAgWyBzdGFjayBdIDw8PDwKPiAtLS0tLS0tLS0tLS0t
LS0tIC0tLS0tLS0gLS0tLS0tLSAtLS0tLS0tIC0tLS0tLS0gLS0tLS0tLQo+IHRvdGFsIGtCICAg
ICAgICAgICAyMDQxNiAgICAyNDMyICAgIDEzMTggICAgIDg5NiAgICAgICAwCj4KPiBUZXN0IHBv
d2VyIHN5c3RlbSBjb25maWc6Cj4gI2dldGNvbmYgUEFHRV9TSVpFCj4gNjU1MzYKPiAjZ3JlcCBI
dWdlcGFnZXNpemUgL3Byb2MvbWVtaW5mbwo+IEh1Z2VwYWdlc2l6ZTogICAgICAxNjM4NCBrQgo+
Cj4gS2VuZWwgc3BsaXQgVk0gc3BhY2UgaW50bzoKPiAxNiBsb3dfc2xpY2UoNjRLQiBwYWdlIHNp
emUpLCBlYWNoIHNsaWNlIHNpemUgaXMgMjU2TUIKPiA0MDk2IGhpZ2hfc2xpY2UoNjRLIHBhZ2Ug
c2l6ZSksIGVhY2ggc2xpY2Ugc2l6ZSBpcyAxVEIKPgo+IDAwMDA3ZmZmYzY3NDAwMDAoc3RhY2sp
IGlzIGJlbG9uZyAxMjd0aCBoaWdoX3NsaWNlKHJhbmdlIGlzIDAwMDA3ZjAwMDAwMDAwMDAgLSAw
MDAwN2ZmZmZmZmZmZmZmKQo+Cj4gV2hlbiBtbWFwIHRyeSB0byBhbGxvY2F0ZSBhIDE2TSBzcGFj
ZSh3aXRoIHBhZ2Ugc2l6ZSBNTVVfUEFHRV8xNk0pIG5lYXIgc3RhY2sgYWRkcmVzcygwMDAwN2Zm
ZmM2NzQwMDAwKSwKPiBrZXJuZWwgd2lsbCBmaXJzdCBjaGVjayBnb29kX21hc2sgYnV0IGZhaWxl
ZCwgc2luY2UgdGhlIGFsbCBzbGljZXMgaXMgTU1VX1BBR0VfNjRLCj4gYnV0IG1tYXAgcmVxdWVz
dCBwYWdlIHNpemUgaXMgTU1VX1BBR0VfMTZNLgo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L3Y2LjEyL3NvdXJjZS9hcmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvc2xpY2UuYyNMNTMx
Cj4KPiBOZXh0IGtlcm5lbCBzdGFydCBjaGVjayBwb3RlbnRpYWxfbWFzayhzZWFjaCBhbGwgc2xp
Y2Ugd2hpY2ggaGFzIG5vIGFueSBWTSBtYXBwZWQpLCBvYnZpb3VzbHkKPiB0aGUgMTI3dGggc2xp
Y2UgaXMgb2NjdXBpZWQgYW5kIDEyNnRoIGlzIHRoZSBnb29kIGNhbmRpZGF0ZSBvbmUgYnV0IGFk
ZHJlc3MgcmFuZ2Ugbm90IG1hdGNoCj4gdGhlIG1tYXAncyByZXF1ZXN0IGFkZHJlc3MoMHgwMDAw
N2ZmZmM2NzQwMDAwIC0gMiAqIGhwYWdlX3NpemUpLCBzbyBmaW5hbGx5IEVCVVNZIHJldHVybmVk
Lgo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjEyL3NvdXJjZS9hcmNoL3Bv
d2VycGMvbW0vYm9vazNzNjQvc2xpY2UuYyNMNTU5Cj4KPiBCVFc6IEkgaGF2ZSB0ZXN0ZWQgYSBz
Y2VuYXJpbyB3aGljaCBkaXNhYmxlcyBNQVBfRklYRURfTk9SRVBMQUNFLCB0aGUga2VybmVsIHdp
bGwKPiBhbGxvY2F0ZSBzdWNjZXNzZnVsbHkgd2l0aGluIHRoZSByYW5nZSBvZiAxMjZ0aCBoaWdo
IHNsaWNlLgo+Cj4gVGhhbmtzLgo+IFJlZ2FyZHMKPiBXZWkgR2FvCj4KCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
