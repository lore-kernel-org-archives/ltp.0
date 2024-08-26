Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2DDC5321D
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 12:45:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 303563D21D4
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 14:45:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B6F23D20F7
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 14:45:07 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5A4691A01071
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 14:45:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724676305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zRYeZnyEJYIH0JcRoZPnllNNDF+r8c20qaCo/pLnU40=;
 b=cz4fPHhUbrKDv8l28/dwjYO9jHx0Ca2nSDz2kGAfioKg8peIaUXUl+Q83EFmm2uw8T2yQO
 ZNWgIZgykFOwKXxHpdtIRZt9oCORDIacNIrKlpfhnRbiEUV/RAJVCwKaB/Et4PkcNSdy+s
 Yy3TTnriFSqyGGF+mhBPrNhaSOxri2c=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-uR5DOgQgMtSiAdOyyW-a7w-1; Mon, 26 Aug 2024 08:45:04 -0400
X-MC-Unique: uR5DOgQgMtSiAdOyyW-a7w-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-2702709b6f3so5329890fac.2
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 05:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724676303; x=1725281103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRYeZnyEJYIH0JcRoZPnllNNDF+r8c20qaCo/pLnU40=;
 b=SkT9vdNBTtwTbkxpEDf5y2xVihP9QVM/5FigVNwv6VZb1LsEm+SId0dn3znJylv1Jv
 t4FLUrhyF4n2PfdZZloMgByuyWdqc1KdW2Tnjqk27C8dpUnl9lYyiyIgYhg5fHNtudVf
 GLrY1f5EJTEpfqN5NL+9bGIQIwgAR2WfQMUxPB3ulCffvG1iDnpV4vU5f7C89EJM11Qp
 IB5lfgGWfXE697m6P/bS1mOSazOFug3ME7eo5UewoVWZ+JqD3ll/FJf/MN6oh4Z+wZrW
 mtRjWO/KKHwwfhaX7PAbGxDl+bfCG9JYS4x9pyFV9PXS6a6189Xl27eSb8Hzoz9LpsUZ
 A1SQ==
X-Gm-Message-State: AOJu0YyufJmCeJIJHm27jBapkajkTLvympiCd1/rAMq1StHBtSWjr+zM
 KTcJ7V9U0pCZ6+x+76MJ2fd12fUERYK1TpVk85xlIsEQf85QoNJhchgkMWrpITkVlxLW4iMC7Cd
 i7aaJb4YCBdXvevRbgS55lnE5wmC62+dw42VPuEwTOxgUBjIvt/rUpJqb3r/B34zR9Jp3uV5t0y
 jJX0PIEDvMVirggOVLDwRp3GE=
X-Received: by 2002:a05:6870:9724:b0:260:3fb2:b724 with SMTP id
 586e51a60fabf-273e66abf7fmr11469234fac.46.1724676303569; 
 Mon, 26 Aug 2024 05:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDeKMppmnwIFt3mmV9S295kxH3xaeV5StPc72BfpxnR5ywS7RTAELyVjB7Zqu452peVlYucrfwoy6IETBAW3Q=
X-Received: by 2002:a05:6870:9724:b0:260:3fb2:b724 with SMTP id
 586e51a60fabf-273e66abf7fmr11469213fac.46.1724676303165; Mon, 26 Aug 2024
 05:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240826120205.5506-1-liwang@redhat.com>
In-Reply-To: <20240826120205.5506-1-liwang@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 26 Aug 2024 14:44:46 +0200
Message-ID: <CAASaF6xA5rmWgVFFfpGMSXjyVRiFYf--ue=GzvjN+-vB26FOPg@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_loop06: no validate block size
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

T24gTW9uLCBBdWcgMjYsIDIwMjQgYXQgMjowMuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IFNpbmNlIGNvbW1pdCA5NDIzYzY1M2ZlNjExMCAoImxvb3A6IERvbid0
IGJvdGhlciB2YWxpZGF0aW5nIGJsb2Nrc2l6ZSIpIGtlcm5lbAoKVGhpcyBjb21taXQgYWJvdmUg
c2F5cyAiVGhlIGJsb2NrIHF1ZXVlIGxpbWl0cyB2YWxpZGF0aW9uIGRvZXMgdGhpcwpmb3IgdXMg
bm93LiIsCnNob3VsZG4ndCB0aGF0IHN0aWxsIGNhdGNoIHRoZSBlcnJvcnM/Cgo+IGRyb3AgdmFs
aWRhdGluZyBibG9ja3NpemUgZm9yIGJvdGggbG9vcF9jb25maWd1cmUgYW5kIGxvb3Bfc2V0X2Js
b2NrX3NpemUgc28KPiB0aGF0IHNldCBsYXJnZSBibG9jayBzaXplIHN1Y2NlZWRzLgo+Cj4gRXJy
b3IgbG9nOgo+ICAgMTIgaW9jdGxfbG9vcDA2LmM6NzY6IFRJTkZPOiBVc2luZyBMT09QX1NFVF9C
TE9DS19TSVpFIHdpdGggYXJnID4gUEFHRV9TSVpFCj4gICAxMyBpb2N0bF9sb29wMDYuYzo1OTog
VEZBSUw6IFNldCBibG9jayBzaXplIHN1Y2NlZWQgdW5leHBlY3RlZGx5Cj4gICAuLi4KPiAgIDE4
IGlvY3RsX2xvb3AwNi5jOjc2OiBUSU5GTzogVXNpbmcgTE9PUF9DT05GSUdVUkUgd2l0aCBibG9j
a19zaXplID4gUEFHRV9TSVpFCj4gICAxOSBpb2N0bF9sb29wMDYuYzo1OTogIFRGQUlMOiBTZXQg
YmxvY2sgc2l6ZSBzdWNjZWVkIHVuZXhwZWN0ZWRseQo+Cj4gU2lnbmVkLW9mZi1ieTogTGkgV2Fu
ZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
aW9jdGwvaW9jdGxfbG9vcDA2LmMgfCA5ICsrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9p
b2N0bC9pb2N0bF9sb29wMDYuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9j
dGxfbG9vcDA2LmMKPiBpbmRleCAzMTdmNjkzYTAuLjRhYWNkMjg0YSAxMDA2NDQKPiAtLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX2xvb3AwNi5jCj4gKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9sb29wMDYuYwo+IEBAIC0yMyw2ICsy
Myw3IEBAIHN0YXRpYyBjaGFyIGRldl9wYXRoWzEwMjRdOwo+ICBzdGF0aWMgaW50IGRldl9udW0s
IGRldl9mZCwgZmlsZV9mZCwgYXR0YWNoX2ZsYWcsIGxvb3BfY29uZmlndXJlX3N1cCA9IDE7Cj4g
IHN0YXRpYyB1bnNpZ25lZCBpbnQgaW52YWxpZF92YWx1ZSwgaGFsZl92YWx1ZSwgdW5hbGlnbl92
YWx1ZTsKPiAgc3RhdGljIHN0cnVjdCBsb29wX2NvbmZpZyBsb29wY29uZmlnOwo+ICtzdGF0aWMg
aW50IG5vdmFsaWRhdGVfYmxvY2tzaXplID0gMDsKPgo+ICBzdGF0aWMgc3RydWN0IHRjYXNlIHsK
PiAgICAgICAgIHVuc2lnbmVkIGludCAqc2V0dmFsdWU7Cj4gQEAgLTc0LDYgKzc1LDExIEBAIHN0
YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgbikKPiAgICAgICAgIHN0cnVjdCB0Y2FzZSAqdGMg
PSAmdGNhc2VzW25dOwo+Cj4gICAgICAgICB0c3RfcmVzKFRJTkZPLCAiJXMiLCB0Yy0+bWVzc2Fn
ZSk7Cj4gKyAgICAgICBpZiAoKCoodGMtPnNldHZhbHVlKSA9PSBpbnZhbGlkX3ZhbHVlKSAmJiBu
b3ZhbGlkYXRlX2Jsb2Nrc2l6ZSkgewo+ICsgICAgICAgICAgICAgICB0c3RfcmVzKFRDT05GLCAi
S2VybmVsIGRvZXNuJ3QgdmFsaWRhdGUgYmxvY2sgc2l6ZSwgc2tpcCBpbnZhbGlkIHZhbHVlIHRl
c3QiKTsKPiArICAgICAgICAgICAgICAgcmV0dXJuOwo+ICsgICAgICAgfQo+ICsKPiAgICAgICAg
IGlmICh0Yy0+aW9jdGxfZmxhZyA9PSBMT09QX1NFVF9CTE9DS19TSVpFKSB7Cj4gICAgICAgICAg
ICAgICAgIGlmICghYXR0YWNoX2ZsYWcpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICB0c3Rf
YXR0YWNoX2RldmljZShkZXZfcGF0aCwgInRlc3QuaW1nIik7Cj4gQEAgLTEyNiw2ICsxMzIsOSBA
QCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICAgICAgICAgICAgICAgICByZXR1cm47Cj4gICAg
ICAgICB9Cj4gICAgICAgICBsb29wY29uZmlnLmZkID0gZmlsZV9mZDsKPiArCj4gKyAgICAgICBp
ZiAoKHRzdF9rdmVyY21wKDYsIDExLCAwKSkgPj0gMCkKPiArICAgICAgICAgICAgICAgbm92YWxp
ZGF0ZV9ibG9ja3NpemUgPSAxOwo+ICB9Cj4KPiAgc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQo+
IC0tCj4gMi40Ni4wCj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
