Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676ECC3ABBC
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 10:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747046047; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=fNcero2zkM4BztOPPpF4BC+0gdSVBOTyOR7wp1AcV9I=;
 b=ki2lB5+kDcoMLNi0HJ/Pi8T/fSd1M30qtdil6ZuUk62liG1n8VV8UlhS73h+l9CrIKVYx
 F0YcoIMy9nyHRClAyj+UX+THeohJ91sObOAqqQ4OW7MWT8nubQY10cCRgA8RhQQK2kIR4sO
 +cYAWGGIi+Ej2X9+YN160uF8sV5YYKE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B878B3CC2A7
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 12:34:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3488C3CC2A0
 for <ltp@lists.linux.it>; Mon, 12 May 2025 12:33:45 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2B05A140043B
 for <ltp@lists.linux.it>; Mon, 12 May 2025 12:33:45 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso32107155e9.2
 for <ltp@lists.linux.it>; Mon, 12 May 2025 03:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747046024; x=1747650824; darn=lists.linux.it;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQhhvQrs2nm6QqRDnenZl+P1YC5EF9DKIAfbGaLmPII=;
 b=YgDl9IFv9u1AQzPa3zzsri49BHJuWuJvi69f4Q8K5Le9ygcOmVTo5Aeqzf1yP1Ctq/
 NpivaPXWI0D35hiTc1iaRkw8j24ls8md1KA5dv9ZRnqHxJRI9wItWhEt4v3qk/VyiUZW
 mHU2DgHqTdlpYDvJVpXvXOlIax3sYXHtn6N/X9spWnjiVf9hC3vcvdxHZKKjgNqAXVVW
 8Kdn0ZbEfqWuDtaoz/a/A1e2fr3oB/Uf+1JiF6TsZlEqT8USEqmDjrDC2voajqwjk/ct
 Lrhbzpci0osDHrmZaIQnhDQaklqF3pNRYyi0sN/iZJB/x5F75bveDq3JWMn6tNmNkjpv
 UOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747046024; x=1747650824;
 h=in-reply-to:references:to:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vQhhvQrs2nm6QqRDnenZl+P1YC5EF9DKIAfbGaLmPII=;
 b=bd7fT6NGmcspo/9Sp6OIf0e5C0G9r/fgQGPpB9TiyiN3ufpYxEyKVZhJNIBDhhtZrY
 sa5lnY/hHDNvqnlAMeufq1/86mSgI5SvNDSreeMWbWXq2TJMOxQBhX5ZnQGuqTEIqiin
 ntIwy8g2M906zZqONLgyzJb0fDfEjLWND1EcntgcTQU5GUhV6ZAG3LL7Fb/Xwln2cth0
 1HtXqJBVdXJsT6hraU0sOCwiJsy5xpHxdV18gcO9cF8bFJRFucwuR31oaRKWblOPhMD2
 dlAhtcQ8ZTT10g06RuT5iJXUx/uw40zaBkqlV0hdcCWlvn/AS0V/ZJMljelWYdIEtz39
 M/jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv5z8mKSpeNowl3AwOneHfNKi9kIi64dJM/tECvIUoFWceHt7bie+0KzaAX14IbH7aZ8A=@lists.linux.it
X-Gm-Message-State: AOJu0YxTUJocEca1eWQDXOkAbrHrfZ/+/Yj7tTHSoLVaiyjstVw5JI5O
 RjU1hboI8vh0KjDOzlExr3AsD4a63f6gghshYqVYZFo7z8G4OGzx2iom3V0h5zI=
X-Gm-Gg: ASbGnct8su5ykz/V7goeZEHz88M0j5H1c6E1s3MCL81o8btq/pPm3yZh2Q9fWQk5qCi
 6nlYzH4VxSyv7yz3v+rBoKNrQCPjbMikO4g0mVMapbeqFnqskwMF6snmT6xGFH4MsrEODRiwwF+
 yc2L/XK5DZU3NNWM1Mwl7D7dn15VTDoROdJzgavvGuvcKf01HaXDKH8xdcquFp7vCQZDVC/UrL7
 dkrbCQy8js2+5DAaSwjlVFQYRaLhlOt1TGiAXzXobTha5gB6CSuO/KcWQri91ZwBMfH1NiPfWRD
 5WeccqNtRaqjsU0nG/P9xgGMB3Zd4NfvSw3im8WSVV6UHGd0hg==
X-Google-Smtp-Source: AGHT+IFFo1siR+M8k8tEEWRKpecGLJlqyETXtullnMNmajLOv/SDLMyshHKdr1vufPHCT277mnfmkA==
X-Received: by 2002:a05:6000:1786:b0:3a0:8c4d:7033 with SMTP id
 ffacd0b85a97d-3a1f646d8c0mr9712888f8f.5.1747046024398; 
 Mon, 12 May 2025 03:33:44 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-879f626bee0sm4807788241.26.2025.05.12.03.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 03:33:43 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 12 May 2025 07:33:39 -0300
Message-Id: <D9U44LEC2E1Q.1AZIKCSTUCZGM@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, "Linux Test Project"
 <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250512-fixes-modify_ldt-v2-1-eaef5577e44e@suse.com>
 <f4e06a94-e613-4afb-bc7b-afc833fcc5c1@suse.cz>
In-Reply-To: <f4e06a94-e613-4afb-bc7b-afc833fcc5c1@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ldt.h: Add workaround for x86_64
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

T24gTW9uIE1heSAxMiwgMjAyNSBhdCA3OjEwIEFNIC0wMywgTWFydGluIERvdWNoYSB3cm90ZToK
PiBIaSwKPiBSZXZpZXdlZC1ieTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6PgoKVGhh
bmtzIGZvciByZXZpZXdpbmcgYW5kIGFsbCB0aGUgaGVscCEKCi0JUmljYXJkby4KCgo+Cj4gT24g
MTIuIDA1LiAyNSAxMjowNSwgUmljYXJkbyBCLiBNYXJsacOocmUgd3JvdGU6Cj4+IEZyb206IFJp
Y2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4+IAo+PiBUaGUgY29tbWl0IGJlMGFh
Y2EyZjc0MiAoInN5c2NhbGxzL21vZGlmeV9sZHQ6IEFkZCBsYXBpL2xkdC5oIikgbGVmdCBiZWhp
bmQKPj4gYW4gaW1wb3J0YW50IGZhY3RvciBvZiBtb2RpZnlfbGR0KCk6IHRoZSBrZXJuZWwgaW50
ZW50aW9uYWxseSBjYXN0cyB0aGUKPj4gcmV0dXJuIHZhbHVlIHRvIHVuc2lnbmVkIGludC4gVGhp
cyB3YXMgaGFuZGxlZCBpbgo+PiB0ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYyBidXQgd2Fz
IHJlbW92ZWQuIEFkZCBpdCBiYWNrIHRvIHRoZSByZWxldmFudAo+PiBmaWxlLgo+PiAKPj4gUmVw
b3J0ZWQtYnk6IE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFAc3VzZS5jej4KPj4gU2lnbmVkLW9mZi1i
eTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPj4gLS0tCj4+IENoYW5nZXMg
aW4gdjI6Cj4+IC0gQWRkZWQgVEJST0sgZm9yIGFueSByZXQgIT0gMCBpbiBtb2RpZnlfbGR0IGNh
bGwgaW4gY3ZlLTIwMTUtMzI5MC5jCj4+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDI1MDUwNy1maXhlcy1tb2RpZnlfbGR0LXYxLTEtNzBhMjY5NGNmZGRjQHN1c2Uu
Y29tCj4+IC0tLQo+PiAgIGluY2x1ZGUvbGFwaS9sZHQuaCAgICAgICAgICAgIHwgMjIgKysrKysr
KysrKysrKysrKysrKysrLQo+PiAgIHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jIHwgIDgg
KysrKysrKy0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2xkdC5oIGIvaW5jbHVkZS9s
YXBpL2xkdC5oCj4+IGluZGV4IDZiNWEyZDU5Y2I0MWJmYzI0ZWI1YWMyNmMzZDQ3ZDQ5ZmI4ZmY3
OGYuLjE3MzMyMWRkOWFjMzRiYTg3ZWZmMGVlZTk2MDYzNWYzMGQ4Nzg5OTEgMTAwNjQ0Cj4+IC0t
LSBhL2luY2x1ZGUvbGFwaS9sZHQuaAo+PiArKysgYi9pbmNsdWRlL2xhcGkvbGR0LmgKPj4gQEAg
LTMxLDcgKzMxLDI3IEBAIHN0cnVjdCB1c2VyX2Rlc2Mgewo+PiAgIHN0YXRpYyBpbmxpbmUgaW50
IG1vZGlmeV9sZHQoaW50IGZ1bmMsIGNvbnN0IHN0cnVjdCB1c2VyX2Rlc2MgKnB0ciwKPj4gICAJ
CQkgICAgIHVuc2lnbmVkIGxvbmcgYnl0ZWNvdW50KQo+PiAgIHsKPj4gLQlyZXR1cm4gdHN0X3N5
c2NhbGwoX19OUl9tb2RpZnlfbGR0LCBmdW5jLCBwdHIsIGJ5dGVjb3VudCk7Cj4+ICsJbG9uZyBy
dmFsOwo+PiArCj4+ICsJZXJybm8gPSAwOwo+PiArCXJ2YWwgPSB0c3Rfc3lzY2FsbChfX05SX21v
ZGlmeV9sZHQsIGZ1bmMsIHB0ciwgYnl0ZWNvdW50KTsKPj4gKwo+PiArI2lmZGVmIF9feDg2XzY0
X18KPj4gKwkvKgo+PiArCSAqIFRoZSBrZXJuZWwgaW50ZW50aW9uYWxseSBjYXN0cyBtb2RpZnlf
bGR0KCkgcmV0dXJuIHZhbHVlCj4+ICsJICogdG8gdW5zaWduZWQgaW50IHRvIHByZXZlbnQgc2ln
biBleHRlbnNpb24gdG8gNjQgYml0cy4gVGhpcyBtYXkKPj4gKwkgKiByZXN1bHQgaW4gc3lzY2Fs
bCgpIHJldHVybmluZyB0aGUgdmFsdWUgYXMgaXMgaW5zdGVhZCBvZiBzZXR0aW5nCj4+ICsJICog
ZXJybm8gYW5kIHJldHVybmluZyAtMS4KPj4gKwkgKi8KPj4gKwlpZiAocnZhbCA+IDAgJiYgKGlu
dClydmFsIDwgMCkgewo+PiArCQl0c3RfcmVzKFRJTkZPLAo+PiArCQkJIldBUk5JTkc6IExpYmMg
bWlzaGFuZGxlZCBtb2RpZnlfbGR0KCkgcmV0dXJuIHZhbHVlIik7Cj4+ICsJCWVycm5vID0gLShp
bnQpZXJybm87Cj4+ICsJCXJ2YWwgPSAtMTsKPj4gKwl9Cj4+ICsjZW5kaWYgLyogX194ODZfNjRf
XyAqLwo+PiArCj4+ICsJcmV0dXJuIHJ2YWw7Cj4+ICAgfQo+PiAgIAo+PiAgIHN0YXRpYyBpbmxp
bmUgaW50IHNhZmVfbW9kaWZ5X2xkdChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5v
LCBpbnQgZnVuYywKPj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5j
IGIvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMKPj4gaW5kZXggOGVjMWQ1M2JiYjVhOWYz
ZTc3NjFkMzk4NTVkMzRmNTkzZTExOGEyOC4uZTcwNzQyYWNjODdjMzkwODg5NTNlMDJmMTYxNDZi
N2I1OGE3NWZkMSAxMDA2NDQKPj4gLS0tIGEvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMK
Pj4gKysrIGIvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMKPj4gQEAgLTE5Nyw3ICsxOTcs
MTMgQEAgc3RhdGljIHZvaWQgc2V0X2xkdCh2b2lkKQo+PiAgIAkJLnVzZWFibGUJID0gMAo+PiAg
IAl9Owo+PiAgIAo+PiAtCVNBRkVfTU9ESUZZX0xEVCgxLCAmZGF0YV9kZXNjLCBzaXplb2YoZGF0
YV9kZXNjKSk7Cj4+ICsJVEVTVChtb2RpZnlfbGR0KDEsICZkYXRhX2Rlc2MsIHNpemVvZihkYXRh
X2Rlc2MpKSk7Cj4+ICsJaWYgKFRTVF9SRVQgPT0gLTEgJiYgVFNUX0VSUiA9PSBFSU5WQUwpIHsK
Pj4gKwkJdHN0X2JyayhUQ09ORiB8IFRURVJSTk8sCj4+ICsJCQkibW9kaWZ5X2xkdDogMTYtYml0
IGRhdGEgc2VnbWVudHMgYXJlIHByb2JhYmx5IGRpc2FibGVkIik7Cj4+ICsJfSBlbHNlIGlmIChU
U1RfUkVUICE9IDApIHsKPj4gKwkJdHN0X2JyayhUQlJPSyB8IFRURVJSTk8sICJtb2RpZnlfbGR0
Iik7Cj4+ICsJfQo+PiAgIH0KPj4gICAKPj4gICBzdGF0aWMgdm9pZCB0cnlfY29ycnVwdF9zdGFj
ayh1bnNpZ25lZCBzaG9ydCAqb3JpZ19zcykKPj4gCj4+IC0tLQo+PiBiYXNlLWNvbW1pdDogYjA3
MGE1NjkyZTAzNWVjMTJjM2QzYzdhN2U5ZTk3YzI3MGZkNGQ3ZAo+PiBjaGFuZ2UtaWQ6IDIwMjUw
NTA3LWZpeGVzLW1vZGlmeV9sZHQtZWJjZmRkMmE3ZDMwCj4+IAo+PiBCZXN0IHJlZ2FyZHMsCgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
