Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457B4C3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 13:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747057857; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GRg+DgWwFqUumJM/VfysXXhf3KBaI5aFLTN7uyvt4YU=;
 b=fmUMR4rfbV0W6Nv0gKJWF6gY6eyrN/nvtoUwBpsqpMtrVudIZX0CQGUW+enDJC8/j8sRJ
 b4ZiZCk6VLA/xDXpHZjZsNZtjPanSLWyVMNynrFM4FOpcO3e0v7YhufbyTpu/FQuBM4XUWK
 PIQaIxFztW4/0WRV8oZf4Atd4uSq3+Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9F383CC2C3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 15:50:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C52193C99DD
 for <ltp@lists.linux.it>; Mon, 12 May 2025 15:50:35 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 78FA5200770
 for <ltp@lists.linux.it>; Mon, 12 May 2025 15:50:34 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso27297595e9.1
 for <ltp@lists.linux.it>; Mon, 12 May 2025 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747057834; x=1747662634; darn=lists.linux.it;
 h=in-reply-to:references:cc:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLh2AW/MHyCnqZs7zANb+0ZawcE5D/r3Dhsr+15e4Mw=;
 b=D4pwarnrYUlx1efni1+kJjnNG8YygpIih99vSjODGP0Bcn2EmT27Hejc3HGGqWTyn0
 c5rovrViK25sduXIfKjYYw/Y3JbzIGDyEUwj4DRaOfp43s1AcWzljRFcUT1+mP6yp5pF
 RMo6RI4KK4juOk+rlSrAoogsNM70fW32hseQTWmKRd+tnQGB3zUkgg8McpwIyt8ebNYy
 JvmN1AxmICkqmShzJ5GZCECtS1m0iqFXhPvNuFF9JtWdqt/iOqger8LoY12JlSv+nr6f
 RhqDqOa7j7mWtF1PvCDOgTHmAFbV/5///dCkEGwa6x23YuifRjf9HF04a/qKEY6ZYKE3
 wqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747057834; x=1747662634;
 h=in-reply-to:references:cc:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DLh2AW/MHyCnqZs7zANb+0ZawcE5D/r3Dhsr+15e4Mw=;
 b=aeOVbAlRf2hTOecZdyaavv4jSjSaSNOqSGwsIL2kDSs2/S5ce8hPEkFI/r7mrPduMU
 FNIvax11KtWKVUl5bexuXq7WnJPPC+iLnENEQgFgLiOm4A7BocqZVmaMcUhKpaMP2xmE
 mEjdmF9CHJUFa42oud7vGL2F3kO375oPm4Pl+Rui3v0MhKTuMeJ66cUn37eqJcM02kLd
 wflA/oVX/m7LA2vI8NDWn1qeYdciXCRJyYEddI0jtFY0cU24Ok4wqE32kpDFxOUMrYKt
 Eb1fpP8nQtWjoQRc43nAfz2h6ubr8ZSr9RTglnV9LyXtqRVSjV2QVs7s8gw4PXBqGVcy
 ZU1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp0S7P5EVHJzJi0gNJEM9TR0iTnm0yR7V75fALRG6dP2FpYJM4QlU+3O1hn3OyVnonK7A=@lists.linux.it
X-Gm-Message-State: AOJu0Yw81fYiwAishuvGZLTRQKodhQ/E4FyhQTDaBKAtbSX0AaOUeqe3
 hvLQsYmMT03Eqf1nrolJYKsZyOoftsxrGXd+Or2yw32r0Ld4vdFTVJkGydPp/4I=
X-Gm-Gg: ASbGncsWrZL+E2j4hT5pgFSH5I9wrC9c87O6RRkohCE4WSKMviNTEMChFfs1iYEbo6h
 67fUxJjj5I1QalKyLWI7bRKvQ7ZpKu6WZqAxRu7nfyfFznVDvrfLEPfnOUpiwUiYNz0CwCLFbId
 d44c6x26yX8gyEOpbZNW11GdZFa8YI+xJyr+QDlM0wVQSnO7osgZ4JsmPZWw5YvUo7FhqMla3uW
 ufHuOHZMYzi5EORpVNFJCH0mw1xX8dt11B28qXuc3rCTwd6joPu3wesU382p8wHtSzZKwy1GfDY
 fc4kGRpQqWuPVDNGpi34RSjuHp/+yWY+y6HS4gc=
X-Google-Smtp-Source: AGHT+IFICgEMz00iBoNn0JwuSB2CgWLGxXuchwqLoXYZnFG6rJHkDSbB/7KHGNezQsSj3I7oCsDTPw==
X-Received: by 2002:a05:6000:1449:b0:38f:4f60:e669 with SMTP id
 ffacd0b85a97d-3a1f6488094mr10540920f8f.29.1747057833695; 
 Mon, 12 May 2025 06:50:33 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-52c63b717c5sm3894678e0c.9.2025.05.12.06.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 06:50:33 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 12 May 2025 10:50:28 -0300
Message-Id: <D9U8BANO8DMR.F8UEA2BX1V1B@suse.com>
To: "Jin Guojie" <guojie.jin@gmail.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <22b831c6-4a7c-4393-a840-d0b00512acbb.jinguojie.jgj@alibaba-inc.com>
 <4ae915b4-0be1-4ea6-b59e-50c9a960c558.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYT=RRPEUQ8WydQWeQkB02xO5=EJd=gqOTXB1F5OUWj9HQ@mail.gmail.com>
In-Reply-To: <CA+B+MYT=RRPEUQ8WydQWeQkB02xO5=EJd=gqOTXB1F5OUWj9HQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] controllers: skip test when cgroup v2 is loaded
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
Cc: =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 ltp <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1IERlYyAxOSwgMjAyNCBhdCAzOjM2IEFNIC0wMywgSmluIEd1b2ppZSB3cm90ZToKPiBW
MjoKPiAqIENvcnJlY3Rpb24gb2YgY29tbWVudHMKPgo+IFYxOgo+ICogSW5pdGlhbCBjaGVjayBm
b3IgY2dyb3VwIHYyCj4KPiBXaGVuIHJ1bm5pbmcgImNvbnRyb2xsZXJzIiBjYXNlIG9uIHNvbWUg
bmV3ZXIgTGludXggZGlzdHJpYnV0aW9ucywgdGhlcmUKPiB3aWxsIGJlIDEwIEVSUk9SIG1lc3Nh
Z2VzIGR1cmluZyB0aGUgc2V0dXAgcGhhc2UsIGFuZCBzZXZlcmFsIFRGQUlMCj4gcmVzdWx0cyBh
dCB0aGUgZW5kLgo+Cj4gQ3VycmVudCAiY29udHJvbGxlcnMiIGNhc2VzIG9ubHkgaW1wbGVtZW50
IHRlc3RzIGZvciBjZ3JvdXAgdjEgZmlsZSBpbnRlcmZhY2UuCj4gSXQncyBiZXR0ZXIgdG8gc2tp
cCB0aGUgdGVzdCBhZnRlciBjaGVja2luZyB0aGF0IHYyIGhpZXJhcmNoeSBoYXMKPiBhbHJlYWR5
IGJlZW4gbG9hZGVkLgo+Cj4gWzFdIGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0
cC8yMDI0LURlY2VtYmVyLzA0MTA4Mi5odG1sCj4KPiBTaWduZWQtb2ZmLWJ5OiBKaW4gR3Vvamll
IDxndW9qaWUuamluQGdtYWlsLmNvbT4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9jb250cm9s
bGVycy90ZXN0X2NvbnRyb2xsZXJzLnNoIHwgOSArKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJv
bGxlcnMvdGVzdF9jb250cm9sbGVycy5zaAo+IGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVy
cy90ZXN0X2NvbnRyb2xsZXJzLnNoCj4gaW5kZXggN2FhOTc0ZmYyLi4wYjY3Mzg3ZWMgMTAwNzU1
Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy90ZXN0X2NvbnRyb2xsZXJzLnNo
Cj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy90ZXN0X2NvbnRyb2xsZXJzLnNo
Cj4gQEAgLTM3LDYgKzM3LDE1IEBACj4gICMKPiAgICAgICAgICAgICMKPiAgIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwo+Cj4gKyMgQ3VycmVudGx5IG9ubHkgY2dyb3VwIHYxIGludGVyZmFjZSBj
YW4gYmUgdGVzdGVkLgo+ICsjIFdoZW4gdGhlIHYyIGhpZXJhcmNoeSBpcyBhbHJlYWR5IGxvYWRl
ZCBpbiB0aGUgc3lzdGVtLCBza2lwIHRoZSB0ZXN0Lgo+ICttb3VudCB8IGdyZXAgICIgdHlwZSBj
Z3JvdXAyICIgJj4vZGV2L251bGwKPiAraWYgWyAkPyA9PSAwIF0KPiArdGhlbgo+ICsgICAgICAg
dHN0X2Jya20gVENPTkYgIiIgInRlc3RfY29udHJvbGxlcnMuc2g6IFYxIGNvbnRyb2xsZXIKPiBy
ZXF1aXJlZCwgYnV0IG1vdW50ZWQgb24gVjIiCj4gKyAgICAgICBleGl0IDMyCj4gK2ZpCj4gKwoK
VGVzdGVkLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKRllJIFRoaXMg
dGVzdCB3YXMgZXhjbHVkZWQgZnJvbSBUdW1ibGV3ZWVkIGJ1dCBub3cgaXMgYmVpbmcgdGVzdGVk
CmFnYWluOgoKaHR0cHM6Ly9vcGVucWEub3BlbnN1c2Uub3JnL3Rlc3RzLzUwNTMwMTcjc3RlcC9j
b250cm9sbGVycy84CgpXaXRoIHRoaXMgcGF0Y2gsIHRoZSB0ZXN0IGlzIGNvcnJlY3RseSBza2lw
cGVkOgoKaHR0cHM6Ly9vcGVucWEub3BlbnN1c2Uub3JnL3Rlc3RzLzUwNTQyMDAjc3RlcC9jb250
cm9sbGVycy84CgpJTUhPIGl0IHNob3VsZCBiZSBtZXJnZWQuCgpUaGFua3MsCi0JUmljYXJkby4K
Cgo+ICBpZiBbIC1mIC9wcm9jL2Nncm91cHMgXQo+ICB0aGVuCj4gICAgICAgICBDUFVfQ09OVFJP
TExFUj1gZ3JlcCAtdyBjcHUgL3Byb2MvY2dyb3VwcyB8IGN1dCAtZjFgOwo+IC0tCj4gMi4zNC4x
CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
