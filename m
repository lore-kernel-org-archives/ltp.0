Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6F1E7B61D
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 13:55:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D3FD3CEF33
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 15:55:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C21B3CB4B6
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 15:55:24 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C6F7F1A010AE
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 15:55:23 +0200 (CEST)
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4527d65354bso1101989137.0
 for <ltp@lists.linux.it>; Wed, 04 Oct 2023 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696427722; x=1697032522; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnxMde0EiLiD5RMrr/cF2VRBsKVJXuXDWUwSWiGEZS0=;
 b=hdYZHxj0c4R3SXcCcxXJC2rBsvVxnHssriVgcpSMP2yhYvQHLp3Io/n/E/0IISOrje
 7jZV1y57F5eW27cr4TNQFIa8zwUQWrfCcKD7fSQ9LlScauNfrCQtv+kRjOJTORMrkmeS
 0k6EN/Y1XEHJLnVo3Q2wE6OE8VkTvwkdJwLzJlGICAkL5wGVK9NZr6QbFWO+Vaz8uZZ/
 G6w6HVbCaFlpskwaNUC6pT/Kg2oL3yEHVW9R1dZnVbZomxtkXwemW3VjzZY1lrQBv8yv
 rqPyh0t0tgneG14e2H5KBuYJzFdZq9KCCoisg9QAas5kM8mhntedIf5raqbIYPvB2r+4
 jdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696427722; x=1697032522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnxMde0EiLiD5RMrr/cF2VRBsKVJXuXDWUwSWiGEZS0=;
 b=VH+0JTeLpSoJzdMiPAUFaMWnGIL5rqqx6/WE1tZRkb8xRqfOgpvNwaoKLHp5VsOWBz
 GfopsphiNF78eep7chvV5RDurjJjfFm0fh8qf/gJtiZIuMyoFUhieiRb0Fi501xfe3St
 APXKlnHj1nve/kelmVGIr6cC9GjQFwYVLBqa9Xy1KpUvQj2r/748e4LaRq0HKL5cOtFp
 re8kUAcJZGyobsezPm6dZq/EE3PjQi/nI3Z/70sVtmDXovCCPIyVXok7fboOuCTr8j2B
 6r96Sk5Fe1yKq0Z2FWQszsofWN2+IZeB1T75kRxFMu5bIQ3qD/lE7xy8ndyRSj0S4cq0
 3VWA==
X-Gm-Message-State: AOJu0Yx7Xi5jjx9xyDPQOyzvamW6fOAIyacXXvWDsLDnuWIxKXhu+Vzb
 V7d9tJ54QcbJ3rPJMRzh6vFp2Ukm1E+MoDIPWHM=
X-Google-Smtp-Source: AGHT+IG3yXBpD7ZPYx/nzv2oVaR4xk6rIJBJ8YCR08y7FHi5d/vF4Q2E2k+igkKa8WWd8YMJrpeVTqYkcsTRv5kS1zg=
X-Received: by 2002:a67:fdd0:0:b0:454:2d1e:6ced with SMTP id
 l16-20020a67fdd0000000b004542d1e6cedmr2234023vsq.27.1696427722565; Wed, 04
 Oct 2023 06:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231004124712.3833-1-chrubis@suse.cz>
 <20231004124712.3833-3-chrubis@suse.cz>
In-Reply-To: <20231004124712.3833-3-chrubis@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 4 Oct 2023 16:55:11 +0300
Message-ID: <CAOQ4uxg8Z1sQJ35fdXnct3BJoCaahHoQ9ek3rmPs3Ly8cVCz=A@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/readahead01: Make use of
 tst_fd_iterate()
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Reuben Hawkins <reubenhwk@gmail.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBPY3QgNCwgMjAyMyBhdCAzOjQ24oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+CgpIaSBDeXJpbCwKClRoYW5rcyBmb3IgZm9sbG93aW5nIHVwIG9uIHRo
aXMhCgo+IFRPRE86IHJlYWRhaGVhZCgpIG9uIC9wcm9jL3NlbGYvbWFwcyBzZWVtcyB0byBzdWNj
ZWVkIGlzIHRoYXQgdG8gYmUKPiAgICAgICBleHBlY3RlZD8KCk5vdCBzdXJlLgpIb3cgZG9lcyBs
bHNlZWsoKSB3b3JrIG9uIHRoZSBzYW1lIGZkPwpNYXR0aGV3IHN1Z2dlc3RlZCB0aGF0IHdlIGFs
aWduIHRoZSBiZWhhdmlvciBvZiBib3RoIHJlYWRhaGVhZCgyKQphbmQgcG9zaXhfZmFkdmlzZSgy
KSB0byB0aGF0IG9mIGxsc2VlaygyKQoKPgo+IFNpZ25lZC1vZmYtYnk6IEN5cmlsIEhydWJpcyA8
Y2hydWJpc0BzdXNlLmN6Pgo+IC0tLQo+ICAuLi4va2VybmVsL3N5c2NhbGxzL3JlYWRhaGVhZC9y
ZWFkYWhlYWQwMS5jICAgfCA0NiArKysrKysrKy0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyMCBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3JlYWRhaGVhZC9yZWFkYWhlYWQwMS5jIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9yZWFkYWhlYWQvcmVhZGFoZWFkMDEuYwo+IGluZGV4IGJkZWY3OTQ1
ZC4uMjgxMzRkNDE2IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcmVh
ZGFoZWFkL3JlYWRhaGVhZDAxLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Jl
YWRhaGVhZC9yZWFkYWhlYWQwMS5jCj4gQEAgLTI5LDQ0ICsyOSwzOCBAQAo+ICAjaWYgZGVmaW5l
ZChfX05SX3JlYWRhaGVhZCkKPgo+ICBzdGF0aWMgdm9pZCB0ZXN0X2JhZF9mZCh2b2lkKQo+IC17
Cj4gLSAgICAgICBjaGFyIHRlbXBuYW1lW1BBVEhfTUFYXSA9ICJyZWFkYWhlYWQwMV9YWFhYWFgi
Owo+IC0gICAgICAgaW50IGZkOwo+IC0KPiAtICAgICAgIHRzdF9yZXMoVElORk8sICIlcyAtMSIs
IF9fZnVuY19fKTsKPiAtICAgICAgIFRTVF9FWFBfRkFJTChyZWFkYWhlYWQoLTEsIDAsIGdldHBh
Z2VzaXplKCkpLCBFQkFERik7Cj4gLQo+IC0gICAgICAgdHN0X3JlcyhUSU5GTywgIiVzIE9fV1JP
TkxZIiwgX19mdW5jX18pOwo+IC0gICAgICAgZmQgPSBta3N0ZW1wKHRlbXBuYW1lKTsKPiAtICAg
ICAgIGlmIChmZCA9PSAtMSkKPiAtICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCB8IFRFUlJO
TywgIm1rc3RlbXAgZmFpbGVkIik7Cj4gLSAgICAgICBTQUZFX0NMT1NFKGZkKTsKPiAtICAgICAg
IGZkID0gU0FGRV9PUEVOKHRlbXBuYW1lLCBPX1dST05MWSk7Cj4gLSAgICAgICBUU1RfRVhQX0ZB
SUwocmVhZGFoZWFkKGZkLCAwLCBnZXRwYWdlc2l6ZSgpKSwgRUJBREYpOwo+IC0gICAgICAgU0FG
RV9DTE9TRShmZCk7Cj4gLSAgICAgICB1bmxpbmsodGVtcG5hbWUpOwo+IC19Cj4gLQo+IC1zdGF0
aWMgdm9pZCB0ZXN0X2ludmFsaWRfZmQodm9pZCkKPiAgewo+ICAgICAgICAgaW50IGZkWzJdOwo+
Cj4gLSAgICAgICB0c3RfcmVzKFRJTkZPLCAiJXMgcGlwZSIsIF9fZnVuY19fKTsKPiArICAgICAg
IFRTVF9FWFBfRkFJTChyZWFkYWhlYWQoLTEsIDAsIGdldHBhZ2VzaXplKCkpLCBFQkFERiwKPiAr
ICAgICAgICAgICAgICAgICAgICAicmVhZGFoZWFkKCkgd2l0aCBmZCA9IC0xIik7Cj4gKwoKQW55
IHJlYXNvbiBub3QgdG8gaW5jbHVkZSBhIGJhZCBhbmQgYSBjbG9zZWQgZmQgaW4gdGhlIGl0ZXJh
dG9yPwoKPiAgICAgICAgIFNBRkVfUElQRShmZCk7Cj4gLSAgICAgICBUU1RfRVhQX0ZBSUwocmVh
ZGFoZWFkKGZkWzBdLCAwLCBnZXRwYWdlc2l6ZSgpKSwgRUlOVkFMKTsKPiAgICAgICAgIFNBRkVf
Q0xPU0UoZmRbMF0pOwo+ICAgICAgICAgU0FGRV9DTE9TRShmZFsxXSk7Cj4KPiAtICAgICAgIHRz
dF9yZXMoVElORk8sICIlcyBzb2NrZXQiLCBfX2Z1bmNfXyk7Cj4gLSAgICAgICBmZFswXSA9IFNB
RkVfU09DS0VUKEFGX0lORVQsIFNPQ0tfU1RSRUFNLCAwKTsKPiAtICAgICAgIFRTVF9FWFBfRkFJ
TChyZWFkYWhlYWQoZmRbMF0sIDAsIGdldHBhZ2VzaXplKCkpLCBFSU5WQUwpOwo+IC0gICAgICAg
U0FGRV9DTE9TRShmZFswXSk7Cj4gKyAgICAgICBUU1RfRVhQX0ZBSUwocmVhZGFoZWFkKGZkWzBd
LCAwLCBnZXRwYWdlc2l6ZSgpKSwgRUJBREYsCj4gKyAgICAgICAgICAgICAgICAgICAgInJlYWRh
aGVhZCgpIHdpdGggaW52YWxpZCBmZCIpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCB0ZXN0X2lu
dmFsaWRfZmQoc3RydWN0IHRzdF9mZCAqZmQpCj4gK3sKPiArICAgICAgIHN3aXRjaCAoZmQtPnR5
cGUpIHsKPiArICAgICAgIGNhc2UgVFNUX0ZEX0ZJTEU6Cj4gKyAgICAgICBjYXNlIFRTVF9GRF9Q
SVBFX09VVDoKPiArICAgICAgICAgICAgICAgcmV0dXJuOwo+ICsgICAgICAgZGVmYXVsdDoKPiAr
ICAgICAgICAgICAgICAgYnJlYWs7Cj4gKyAgICAgICB9Cj4gKwo+ICsgICAgICAgVFNUX0VYUF9G
QUlMKHJlYWRhaGVhZChmZC0+ZmQsIDAsIGdldHBhZ2VzaXplKCkpLCBFSU5WQUwsCj4gKyAgICAg
ICAgICAgICAgICAgICAgInJlYWRhaGVhZCgpIG9uICVzIiwgdHN0X2ZkX2Rlc2MoZmQpKTsKClRo
aW5raW5nIGZvcndhcmQgYW5kIHdlIHdvdWxkIGxpa2UgdG8gY2hhbmdlIHRoaXMgZXJyb3IgY29k
ZSB0byBFU1BJUEUKaXMgdGhlcmUgYWxyZWFkeSBhIGhlbHBlciB0byBleHBlY3Qgb25lIG9mIGEg
ZmV3IGVycm9yIGNvZGVzPwoKVGhhbmtzLApBbWlyLgoKPiAgfQo+Cj4gIHN0YXRpYyB2b2lkIHRl
c3RfcmVhZGFoZWFkKHZvaWQpCj4gIHsKPiAgICAgICAgIHRlc3RfYmFkX2ZkKCk7Cj4gLSAgICAg
ICB0ZXN0X2ludmFsaWRfZmQoKTsKPiArICAgICAgIHRzdF9mZF9pdGVyYXRlKHRlc3RfaW52YWxp
ZF9mZCk7Cj4gIH0KPgo+ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+IC0tCj4gMi40MS4wCj4K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
