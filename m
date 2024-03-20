Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2844C54E67
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 06:59:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B1083CDCBF
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 07:59:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73C033CD943
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 07:59:37 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DB0D560B035
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 07:59:36 +0100 (CET)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-696315c9da5so11336436d6.2
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 23:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710917975; x=1711522775; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrEQi4h4ZYZa6FpLo0qNv2ApK4PYjkagkZ7HmEsfxmU=;
 b=Ls/IM66pU4NDYJz3RfF8qJwOlDG5Vp9xQP1ivCDQ+koe7us99TYzugAeVU7Cq3MqwM
 q3Fbjqu/xtW0X5x9/JQZWwhhJE5u8UM5FOYpb1DGuJPAqW4Hsb1QkazKiDXAWDCA/arD
 Vm+UJyg5rmSqJHWc+LQigaOt4hXptB23CnlhAS8KMd/gY9Q8mlQHaUIvbgNxhvk4jwAx
 HUsR9r/GjRHDts9WzqJgXvCL6H3Gb2JMHPcu+aM4G9HgR5ey9RHmqyC0f4kN1Odbdan9
 hDsD/knJ/BVdHoNYy4Ohme20+TLPJM5jTXShQESbw/z1tqVQFDaMlbQewAQgXMskvO/q
 kqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710917975; x=1711522775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LrEQi4h4ZYZa6FpLo0qNv2ApK4PYjkagkZ7HmEsfxmU=;
 b=QhnR5CUBWLR03oBgEWTmdWMzJair7sIZjXGI2nMELgpkEK8eoTp5KVsvSYh2gCc52u
 exP0Zrf3VMv9ZEJW76Kx10B/fZypqcEHQ1BkDoYVxBuvlzJzhJRGLLhbZU+x9fndWVVs
 +tMa9gkb1QbG39KfyvFnoDL0BOTeZgwecNKloZpNulg6c2h7/a/Y+C0xM6Ekn6KOy2mC
 hFC0/baWz3rVHqHI9bjHs2DQjZujAd3qv+17DgvEHYaqDN3+A6ztjnwZDq02ygYoXNp/
 SKKWy0gevA72SeSgSgycqNmHEso/AxBCQdLZhG49RBeKkegMKZ1KNYLfc/VzXmgUmLf7
 +XKg==
X-Gm-Message-State: AOJu0YxLJu8QXR/AJm0fsF2TZMdZZqEx8BzDzvV05VHxJlHGFL7HvCo3
 54cAlMsn8vVecxuO7XgBX1Ffx6zmnbIVqlHh6GQjEY7xx4Vjd2jVCMMq6j8qdJzT0ZszXAfyDiA
 n0g0lvc0aMF854edxwp1uz6GRhlI=
X-Google-Smtp-Source: AGHT+IHyEJupYuGTnVoelaPIOpLJtP9Rcc0IvIN3HNAitD5ge9mJ+LnbsQYEqQLFc1eH7K7WddCsNm3I5FY12rfQWRc=
X-Received: by 2002:a05:6214:4953:b0:696:42f7:142e with SMTP id
 pe19-20020a056214495300b0069642f7142emr1542734qvb.47.1710917975636; Tue, 19
 Mar 2024 23:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240320063218.449072-1-pvorel@suse.cz>
 <20240320063218.449072-2-pvorel@suse.cz>
In-Reply-To: <20240320063218.449072-2-pvorel@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Mar 2024 08:59:24 +0200
Message-ID: <CAOQ4uxg_StmuTqiXg2nuqPCdY3_Bj_Zj-bnJ36CFf1Hcon=n+w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] fanotify14: fix anonymous pipe testcases
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
Cc: Mete Durlu <meted@linux.ibm.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXIgMjAsIDIwMjQgYXQgODozMuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEZyb206IE1ldGUgRHVybHUgPG1ldGVkQGxpbnV4LmlibS5jb20+Cj4K
PiBXaGVuIFNFbGludXggaXMgaW4gZW5mb3JjaW5nIHN0YXRlIGFuZCBTRXBvbGljaWVzIGRpc2Fs
bG93IGFub255bW91cwo+IHBpcGUgdXNhZ2Ugd2l0aCBmYW5vdGlmeV9tYXJrKCksIHJlbGF0ZWQg
ZmFub3RpZnkxNCB0ZXN0Y2FzZXMgZmFpbCB3aXRoCj4gRUFDQ0VTIGluc3RlYWQgb2YgRUlOVkFM
LiBBY2NlcHQgYm90aCBlcnJub3Mgd2hlbiBTRWxpbnV4IGlzIGluCj4gZW5mb3JjaW5nIHN0YXRl
IHRvIGNvcnJlY3RseSBldmFsdWF0ZSB0ZXN0IHJlc3VsdHMuCj4KPiBSZXBsYWNlIFRTVF9FWFBf
RkRfT1JfRkFJTCB3aXRoIFRTVF9FWFBfRkFJTCB3aGVuIHRlc3RpbmcKPiBmYW5vdGlmeV9tYXJr
KCkgYXMgaXQgcmV0dXJucyAtMSBvbiBmYWlsdXJlIGFuZCAwIG9uIHN1Y2Nlc3Mgbm90IGEgZmls
ZQo+IGRlc2NyaXB0b3IuCj4KPiBDby1kZXZlbG9wZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6Pgo+IFNpZ25lZC1vZmYtYnk6IE1ldGUgRHVybHUgPG1ldGVkQGxpbnV4LmlibS5jb20+
Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgpSZXZpZXdlZC1i
eTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KCj4gLS0tCj4gSGksCj4KPiB0
aGlzIGlzIGEgcmVwbGFjZW1lbnQgb2YgTWV0ZSdzIHYyIGZhbm90aWZ5MTQ6IGZpeCBhbm9ueW1v
dXMgcGlwZSB0ZXN0Y2FzZXM6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjQwMzEy
MTIwODI5LjE3ODMwNS0yLW1ldGVkQGxpbnV4LmlibS5jb20vCj4KPiBLaW5kIHJlZ2FyZHMsCj4g
UGV0cgo+Cj4gIC4uLi9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jICAgICB8
IDE5ICsrKysrKysrKysrKysrKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zh
bm90aWZ5L2Zhbm90aWZ5MTQuYwo+IGluZGV4IGQwMmQ4MTQ5NS4uYjU1NGFmMjJhIDEwMDY0NAo+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jCj4g
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMKPiBA
QCAtMzAsNiArMzAsNyBAQAo+Cj4gICNpZmRlZiBIQVZFX1NZU19GQU5PVElGWV9ICj4gICNpbmNs
dWRlICJmYW5vdGlmeS5oIgo+ICsjaW5jbHVkZSAidHN0X3NlbGludXguaCIKPgo+ICAjZGVmaW5l
IE1OVFBPSU5UICJtbnRwb2ludCIKPiAgI2RlZmluZSBGSUxFMSBNTlRQT0lOVCIvZmlsZTEiCj4g
QEAgLTQ3LDYgKzQ4LDcgQEAgc3RhdGljIGludCBwaXBlc1syXSA9IHstMSwgLTF9Owo+ICBzdGF0
aWMgaW50IGZhbm90aWZ5X2ZkOwo+ICBzdGF0aWMgaW50IGlnbm9yZV9tYXJrX3Vuc3VwcG9ydGVk
Owo+ICBzdGF0aWMgaW50IGZpbGVzeXN0ZW1fbWFya191bnN1cHBvcnRlZDsKPiArc3RhdGljIGlu
dCBzZV9lbmZvcmNpbmc7Cj4gIHN0YXRpYyB1bnNpZ25lZCBpbnQgc3VwcG9ydGVkX2luaXRfZmxh
Z3M7Cj4KPiAgc3RydWN0IHRlc3RfY2FzZV9mbGFnc190IHsKPiBAQCAtMjgzLDkgKzI4NSwxOCBA
QCBzdGF0aWMgdm9pZCBkb190ZXN0KHVuc2lnbmVkIGludCBudW1iZXIpCj4KPiAgICAgICAgIHRz
dF9yZXMoVElORk8sICJUZXN0aW5nICVzIHdpdGggJXMiLAo+ICAgICAgICAgICAgICAgICB0Yy0+
bWFyay5kZXNjLCB0Yy0+bWFzay5kZXNjKTsKPiAtICAgICAgIFRTVF9FWFBfRkRfT1JfRkFJTChm
YW5vdGlmeV9tYXJrKGZhbm90aWZ5X2ZkLCBGQU5fTUFSS19BREQgfCB0Yy0+bWFyay5mbGFncywK
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjLT5tYXNrLmZsYWdz
LCBkaXJmZCwgcGF0aCksCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB0Yy0+ZXhwZWN0ZWRfZXJybm8pOwo+ICsKPiArICAgICAgIGlmICh0Yy0+cGZkICYmIHNlX2Vu
Zm9yY2luZykgewo+ICsgICAgICAgICAgICAgICBjb25zdCBpbnQgZXhwX2VycnNbXSA9IHt0Yy0+
ZXhwZWN0ZWRfZXJybm8sIEVBQ0NFU307Cj4gKwo+ICsgICAgICAgICAgICAgICBUU1RfRVhQX0ZB
SUxfQVJSKGZhbm90aWZ5X21hcmsoZmFub3RpZnlfZmQsIEZBTl9NQVJLX0FERCB8IHRjLT5tYXJr
LmZsYWdzLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjLT5tYXNrLmZsYWdz
LCBkaXJmZCwgcGF0aCksCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXhwX2Vy
cnMpOwo+ICsgICAgICAgfSBlbHNlIHsKPiArICAgICAgICAgICAgICAgVFNUX0VYUF9GQUlMKGZh
bm90aWZ5X21hcmsoZmFub3RpZnlfZmQsIEZBTl9NQVJLX0FERCB8IHRjLT5tYXJrLmZsYWdzLAo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0Yy0+bWFz
ay5mbGFncywgZGlyZmQsIHBhdGgpLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB0Yy0+ZXhwZWN0ZWRfZXJybm8pOwo+ICsgICAgICAgfQo+Cj4gICAg
ICAgICAvKgo+ICAgICAgICAgICogRU5PVERJUiBhcmUgZXJyb3JzIGZvciBldmVudHMvZmxhZ3Mg
bm90IGFsbG93ZWQgb24gYSBub24tZGlyIGlub2RlLgo+IEBAIC0zMzQsNiArMzQ1LDggQEAgc3Rh
dGljIHZvaWQgZG9fc2V0dXAodm9pZCkKPiAgICAgICAgIFNBRkVfRklMRV9QUklOVEYoRklMRTEs
ICIwIik7Cj4gICAgICAgICAvKiBDcmVhdGUgYW5vbnltb3VzIHBpcGVzIHRvIHBsYWNlIG1hcmtz
IG9uICovCj4gICAgICAgICBTQUZFX1BJUEUyKHBpcGVzLCBPX0NMT0VYRUMpOwo+ICsKPiArICAg
ICAgIHNlX2VuZm9yY2luZyA9IHRzdF9zZWxpbnV4X2VuZm9yY2luZygpOwo+ICB9Cj4KPiAgc3Rh
dGljIHZvaWQgZG9fY2xlYW51cCh2b2lkKQo+IC0tCj4gMi40My4wCj4KCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
