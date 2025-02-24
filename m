Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8921EC021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740425086; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=S4OgaLSpp7coidtEOlEhvfy0EByI4iH7zPUUTc+16X4=;
 b=m494BkjR2Nw1+4DZVtcA3g0iGXx/R+Qx3KVHL4xFFBAWWrHamVDKmtxxF8DjLyvGvEqbr
 gN+tpoi6vZXRh3Rp6/I5n4jF4y/HS9TKiDw4XIwTEczfWLKBNBKtVOd88UOcYAltcQC3ok3
 vwceBjsAQN/YrP/nPhQJVD8ncK7VZu4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3B993C9A19
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 20:24:46 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAD1D3C988C
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 20:24:25 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AE14D1008608
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 20:24:24 +0100 (CET)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e0452f859cso7469498a12.2
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740425064; x=1741029864; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKnj0YHSo2IzJ8woZvIBDldXp8jRzYtWZ+dnNqVT3cE=;
 b=gyDoYfb5KUrYkg1bhPpPhCEx9IYYulIHLMMlT9R1NEY4z+GSF+B4mWyF5uDe58XD/f
 ppPkwp9P9na+hHVGFwaTl3sFGsmNRYT0oPL3lQoYoRu8jdsA6rnY9WNETOjdwWj92O2p
 BS00wBaUL4PzWyPFTIwul55O08aECg1/w+yBkQ4/dqfJToYSl9fk0EW4X+DyijPKCGxi
 0/C/tgBPvz+PkKAnyDtxqJNz9k0+uggyw+zo9jecXzL1ewfKwEQyKnYM285kUIzhbxIB
 zgz+4A1Yx0TJ31TGOp/I/Ang5aCNIr375oQI/o+HwYg++Ty+IUYJnZXPDz8Mp7eK5mhy
 82Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740425064; x=1741029864;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HKnj0YHSo2IzJ8woZvIBDldXp8jRzYtWZ+dnNqVT3cE=;
 b=dRcwCl8OvUfFY66+K61ndVzytdVceVW/3e9ypZj5ZPc4tQUP8fljBB7dGZJJuE3vBD
 iVmrB86hLoiyyBJgIk7PGwt0rRwpUtNCcHnxOHd1JC5hopdXlFZEuK65j5OncMxleWNf
 RA292vPFXQz2fvPUd3La0ByYhzUCSP5aubnS86iMUuLPhNKPSAjyRYxeP3ydsCDaPYMX
 I1BLmYjH+XMd1FHmWgcsvyJxOIEa/aIO/Tjw7ssbbbngGWXB0l1rcl7fodS+vZnmnd2p
 pQSuv2UOUr0l3KePh6ju5BCntcZ2QY7tdujzo559bpvV368DS19TqHOLsJhqK89cmE5Y
 yP7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjeQSCYI++TwbviicHJ8WA5XkS8N9VCc9EfzKrD39nLGepEoYhAAsyMp6az7Qxafcy0ZU=@lists.linux.it
X-Gm-Message-State: AOJu0Yz31d7McS4I7HFSuKehUnUH41r+I1lLqTx6VxSWvwuBXtLr5nwR
 Avzr94Mgl9G5TtHFHcI+HUd9aCj2Cwgxef8yHyOLVV20lQd5JhFNphts+7iqUeE=
X-Gm-Gg: ASbGnctv9Undqt3qVhlcl0ua7wAJh1DPRNLUKJbGwxkbCRylYYOWL+l/Wv1UyVE4obT
 Vt6dyKQ9CSJJe5pzVVs/iBeaZq5B7XatAJXI2QqMmj8NcTsmVPSHh9ZoccZ+iAjayt9e1o4alGH
 LP8xYRefQXKMrkic03SK7kn4n+gDaRIWNrTQnRlYdYAoqnk2oHJtNV4KyxBGSt9ktbcoe9h6SHQ
 q4ZVASe3+WTiDEGmgCObAgrLKMA+PX+xCiRquipZz6Ios/SSXXGKAYISjnS7i2Y+yLGZsl2yhP3
 Dyf1039qpYVv5iM=
X-Google-Smtp-Source: AGHT+IE5wepCgQTzkmIJgnUAzVxu9eKX0B5opymT8XOerXgFl+r4BIXBkAa2TgLdgn9/wBm5C5RShw==
X-Received: by 2002:a17:907:9721:b0:ab7:a274:d3df with SMTP id
 a640c23a62f3a-abc09a5f3aemr1300676866b.20.1740425064010; 
 Mon, 24 Feb 2025 11:24:24 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7326e02b1a8sm16889738b3a.97.2025.02.24.11.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:24:23 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 24 Feb 2025 16:24:21 -0300
Message-Id: <D80X6ZHMZ1SX.1KAXYMYMDCHKO@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Linux Test
 Project" <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1
References: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
 <20250224-conversions-pause-v3-3-5e3989d37f1d@suse.com>
In-Reply-To: <20250224-conversions-pause-v3-3-5e3989d37f1d@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/5] syscalls/pause02: Delete duplicated test
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

T24gTW9uIEZlYiAyNCwgMjAyNSBhdCAzOjUzIFBNIC0wMywgUmljYXJkbyBCLiBNYXJsacOocmUg
d3JvdGU6Cj4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPgo+IFRo
aXMgdGVzdCBpcyB2ZXJ5IHNpbWlsYXIgdG8gcGF1c2UwMSwgdGhlcmVmb3JlIGRlbGV0ZSBpdC4K
Pgo+IFNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4g
LS0tCj4gIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxIC0K
PiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wYXVzZS9wYXVzZTAyLmMgfCAxNDcgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTQ4IGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL3J1bnRlc3Qvc3lzY2FsbHMgYi9ydW50ZXN0L3N5c2NhbGxz
Cj4gaW5kZXggNGFiODQzNmQzMGNhNWZmZWU1MmQ5Nzc3NzI5ZWMxZWMwOWQwYmYxZC4uNjZlYmYy
MGQyYWE5ZGZhMzZjYTliYzVlNTU1MzZmNWE5ZGMwZTgzZiAxMDA2NDQKPiAtLS0gYS9ydW50ZXN0
L3N5c2NhbGxzCj4gKysrIGIvcnVudGVzdC9zeXNjYWxscwo+IEBAIC0xMDEwLDcgKzEwMTAsNiBA
QCBwYXRoY29uZjAxIHBhdGhjb25mMDEKPiAgcGF0aGNvbmYwMiBwYXRoY29uZjAyCj4gIAo+ICBw
YXVzZTAxIHBhdXNlMDEKPiAtcGF1c2UwMiBwYXVzZTAyCj4gIHBhdXNlMDMgcGF1c2UwMwoKU2hv
dWxkIGFsc28gaGF2ZSByZW1vdmVkIGl0IGluIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1
c2UvLmdpdGlnbm9yZSAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
