Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ACEC4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 14:55:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 244703CD979
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 15:55:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA76D3CD951
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:54:49 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 13248600146
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:54:49 +0100 (CET)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5cfa65de9ecso41829717b3.2
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701269688; x=1701874488; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XN6fbPDc7qJ5bgWSEwVA9uGClEVCxzY7s0yf8eqDSxQ=;
 b=TsebuX+X0HXrkj6GQuAeCguEcINDApDADG3e00+Lq3ZTfGx2Db0JwHzLXNYom7jQuI
 Ao72JYjZhjdlt+v6vLhaSFDEilB/5T7hsJTGuOyzxkBG/ZGPwIfhdo5g5wiOPlQ1S6vT
 aYLgm+V1VpVDCZxbkQJwepivwBJPt3idTMDPDZ5HUj+UuVdcfmN6lmxchtVeiPtq+d18
 fSpR+KLLdGi4BGYTW+oZ95QYIA5MRdEauc3xUQLdgqEwRyZf2q+PMvLijYV+D57SGes1
 3whCFvdxvMo2zyDFrrUqC48Dh+gktuBaXJee54qUSWwdBVCB8sOgyi4xuOrSGuJSb84r
 V5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701269688; x=1701874488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XN6fbPDc7qJ5bgWSEwVA9uGClEVCxzY7s0yf8eqDSxQ=;
 b=mUqJJCZft1CcVJC8dqXkezDHuHIMIrqi8FATe+6CRiqDgh8Ll+VHslBCSBhIVQF9bm
 Y5AIBTQffir5qUSpU5SSZKpFtfKk5EMuHsCP5x68pdvGJyT6+j31VBM1uALMN4ZRo46M
 5ZaQb+vl/eq40zn/s4By83P/22JpHe5/MmIzwSInYroVgIxr7lhqODvzfLZkHJlADgor
 6qDXasy6JI7hZJM6TTeT/7/lEVQ3+BrBfk7EywOs/LedjM2HB3MnFHbS9iC9OOryhshE
 5OHIkBV9McnTBCu7VM9N+ny20EBJ2vcW0pBhPU9fkWsFrKpOQwtmeXmToEztPmN8cnQm
 PdYg==
X-Gm-Message-State: AOJu0YyCXmmC96GHfcJp7KTbU1Vhw1qcjvLbZXRvAz8r8eLsG85E5OBR
 zT84jfvtpftLae5JXcQlL41U79Ymj5WPgiqs2KKGgQlHN1w=
X-Google-Smtp-Source: AGHT+IGDZARcIuim+yid405RqtIMZ89WvKV7+iJa4jVo6DB8mbjCr4x1esWR5jWKbwRp2dUum7wEmJ5YSkcZBrYmU5Y=
X-Received: by 2002:a81:6008:0:b0:5cd:f157:fd05 with SMTP id
 u8-20020a816008000000b005cdf157fd05mr18604042ywb.25.1701269687857; Wed, 29
 Nov 2023 06:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20231129114617.12660-1-jack@suse.cz>
 <20231129115440.19100-6-jack@suse.cz>
In-Reply-To: <20231129115440.19100-6-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 Nov 2023 16:54:36 +0200
Message-ID: <CAOQ4uxizvzVwJwVEYUgy2=ZA=xHjoQyLRu3TFyGE0sKRWJAwMQ@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/6] fanotify: Convert permission events feature
 check to be performed on fs
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

T24gV2VkLCBOb3YgMjksIDIwMjMgYXQgMTo1NOKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gQ29udmVydCBmZWF0dXJlIGNoZWNrIGZvciBhdmFpbGFiaWxpdHkgb2YgcGVy
bWlzc2lvbiBldmVudHMgdG8gYmUKPiBwZXJmb3JtZWQgb24gdGhlIHRlc3RlZCBmaWxlc3lzdGVt
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KClJldmlld2VkLWJ5
OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgoKPiAtLS0KPiAgdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oICAgfCA1ICsrKy0tCj4gIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkwMy5jIHwgMyArLS0KPiAgdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTA3LmMgfCAzICstLQo+ICAz
IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmggYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmgKPiBpbmRleCAwNTJi
MjlhN2NlZGMuLjdjZDIyMTNlMTdiZiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmgKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmgKPiBAQCAtMTMzLDEzICsxMzMsMTQgQEAgc3RhdGljIGlu
bGluZSBpbnQgZmFub3RpZnlfc2F2ZV9maWQoY29uc3QgY2hhciAqcGF0aCwKPiAgI2RlZmluZSBJ
TklUX0ZBTk9USUZZX01BUktfVFlQRSh0KSBcCj4gICAgICAgICB7IEZBTl9NQVJLXyAjIyB0LCAi
RkFOX01BUktfIiAjdCB9Cj4KPiAtc3RhdGljIGlubGluZSB2b2lkIHJlcXVpcmVfZmFub3RpZnlf
YWNjZXNzX3Blcm1pc3Npb25zX3N1cHBvcnRlZF9ieV9rZXJuZWwodm9pZCkKPiArc3RhdGljIGlu
bGluZSB2b2lkIHJlcXVpcmVfZmFub3RpZnlfYWNjZXNzX3Blcm1pc3Npb25zX3N1cHBvcnRlZF9v
bl9mcygKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbnN0IGNoYXIgKmZuYW1lKQo+ICB7Cj4gICAgICAgICBpbnQgZmQ7Cj4KPiAgICAg
ICAgIGZkID0gU0FGRV9GQU5PVElGWV9JTklUKEZBTl9DTEFTU19DT05URU5ULCBPX1JET05MWSk7
Cj4KPiAtICAgICAgIGlmIChmYW5vdGlmeV9tYXJrKGZkLCBGQU5fTUFSS19BREQsIEZBTl9BQ0NF
U1NfUEVSTSwgQVRfRkRDV0QsICIuIikgPCAwKSB7Cj4gKyAgICAgICBpZiAoZmFub3RpZnlfbWFy
ayhmZCwgRkFOX01BUktfQURELCBGQU5fQUNDRVNTX1BFUk0sIEFUX0ZEQ1dELCBmbmFtZSkgPCAw
KSB7Cj4gICAgICAgICAgICAgICAgIGlmIChlcnJubyA9PSBFSU5WQUwpIHsKPiAgICAgICAgICAg
ICAgICAgICAgICAgICB0c3RfYnJrKFRDT05GIHwgVEVSUk5PLAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIkNPTkZJR19GQU5PVElGWV9BQ0NFU1NfUEVSTUlTU0lPTlMgbm90IGNv
bmZpZ3VyZWQgaW4ga2VybmVsPyIpOwo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZmFub3RpZnkvZmFub3RpZnkwMy5jCj4gaW5kZXggMzQzYmE4NTdlMWFlLi4wMjhkYTc0MmM3NmMg
MTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlm
eTAzLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5
MDMuYwo+IEBAIC0zMjAsMTEgKzMyMCwxMCBAQCBzdGF0aWMgdm9pZCB0ZXN0X2Zhbm90aWZ5KHVu
c2lnbmVkIGludCBuKQo+Cj4gIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gIHsKPiAtICAgICAg
IHJlcXVpcmVfZmFub3RpZnlfYWNjZXNzX3Blcm1pc3Npb25zX3N1cHBvcnRlZF9ieV9rZXJuZWwo
KTsKPiAtCj4gICAgICAgICBzcHJpbnRmKGZuYW1lLCBNT1VOVF9QQVRIIi9mbmFtZV8lZCIsIGdl
dHBpZCgpKTsKPiAgICAgICAgIFNBRkVfRklMRV9QUklOVEYoZm5hbWUsICIxIik7Cj4KPiArICAg
ICAgIHJlcXVpcmVfZmFub3RpZnlfYWNjZXNzX3Blcm1pc3Npb25zX3N1cHBvcnRlZF9vbl9mcyhm
bmFtZSk7Cj4gICAgICAgICBmaWxlc3lzdGVtX21hcmtfdW5zdXBwb3J0ZWQgPSBmYW5vdGlmeV9t
YXJrX3N1cHBvcnRlZF9vbl9mcyhGQU5fTUFSS19GSUxFU1lTVEVNLCBmbmFtZSk7Cj4gICAgICAg
ICBleGVjX2V2ZW50c191bnN1cHBvcnRlZCA9IGZhbm90aWZ5X2ZsYWdzX3N1cHBvcnRlZF9vbl9m
cyhGQU5fQ0xBU1NfQ09OVEVOVCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgMCwgRkFOX09QRU5fRVhFQ19QRVJNLCBmbmFtZSk7Cj4gZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkwNy5jIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTA3LmMKPiBpbmRleCAzOTZjODQ5MGVlZGEu
LjM0YWE4MTBjN2RhYyAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zh
bm90aWZ5L2Zhbm90aWZ5MDcuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFu
b3RpZnkvZmFub3RpZnkwNy5jCj4gQEAgLTE4OSwxMCArMTg5LDkgQEAgc3RhdGljIHZvaWQgdGVz
dF9mYW5vdGlmeSh2b2lkKQo+Cj4gIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gIHsKPiAtICAg
ICAgIHJlcXVpcmVfZmFub3RpZnlfYWNjZXNzX3Blcm1pc3Npb25zX3N1cHBvcnRlZF9ieV9rZXJu
ZWwoKTsKPiAtCj4gICAgICAgICBzcHJpbnRmKGZuYW1lLCAiZm5hbWVfJWQiLCBnZXRwaWQoKSk7
Cj4gICAgICAgICBTQUZFX0ZJTEVfUFJJTlRGKGZuYW1lLCAiJXMiLCBmbmFtZSk7Cj4gKyAgICAg
ICByZXF1aXJlX2Zhbm90aWZ5X2FjY2Vzc19wZXJtaXNzaW9uc19zdXBwb3J0ZWRfb25fZnMoZm5h
bWUpOwo+ICB9Cj4KPiAgc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQo+IC0tCj4gMi4zNS4zCj4K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
