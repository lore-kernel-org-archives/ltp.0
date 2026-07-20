Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB38C44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 07:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784532662; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=HK7oluOtNoORoKpxKD67p7+WLY6Pfys9IRAIP7jq3CM=;
 b=qkyqvKJZqK60fkAAMIh+2TP5hCdlLpLUadU9Mf/eqTdJ0Y10cb2Ob2odOPZnsW8D5PDhU
 Gd3VXsZ/FOdubQYneYhNl1NPjpLrzHu76Dwp1jlaAyyjWflSqGNSyTMxQBdD3hflxEcMZsO
 n3Bwpt9BYM6q3IAxrXjKjQPuJl+EnZA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC41C3E224E
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 09:31:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BD5C3C2696
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 09:30:40 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 48D7E1000920
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 09:30:37 +0200 (CEST)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cf452def93so11334325ad.1
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 00:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784532635; cv=none;
 d=google.com; s=arc-20260327;
 b=gvZdXRItoIl5YvzHc1Vmj21hNByv+kRk0HIpAV72rTSuozlHB+4F+KXuhKpKLgH7kd
 Wytgn+r+rlO/dbFsND60StaUtsTQT4Y6TGrLg0hophXYjLAGSJxcK7KF1lkegfNq7XGs
 2aNPvtm5iX3zJqjIXLKCbehyU5QW7C5Bt+qW9VaGBJVv5lMXqFVjwGxOrauhqepPoG5G
 BcxM5M9UICzIhrxWXSCGTPUDb/umolfRDMfRJ8E5og6m7cihPHxuAUnZUjREop/0Q9Bx
 CJlcw2twf2DS3Sk7qTvCQj8kuO58BzFVaYf0Yd5AQx4UWQzzyV5STJeXDWwrXp1IRdx/
 +BUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W7JEJ2/e3baTSv7LfmQA0Cqj7i2lXjoZyApKTYC6Gx8=;
 fh=1CWII9D4uihpMKGUwV/j/i87UXPD1tj+X3yprOf/CSw=;
 b=MmMMxRZVt3FVKpTWhTGg7LSABtSNuzBf1aYXHMSEu/ZwvXydGUAXtSKR3fmpJIrMIU
 3LwP1MuCpz/TUBya3Fu8SX2yxQJxpu7ab0UtCazrw4O0Fe49f4gQY8Y7QuhOehVI1AjK
 yNnWEKP/N6wyw5T7RJrDIzLSu8WqpoIxGZxo2AARCZuEGpaWaBk7R0JBb4UUw4Kj3cVA
 3BY1Fk++lpOcwpYWWbj5V74hP0RuwpTFujJkK37aJmsJRa8GoaHK2w/VJd+3gP8/l1pQ
 2o1gJiRTGjeBPidMB5xkeHqJuS3V0wFQJHKmeKdiK/i1uYh0MdduoLyE72XjWOoOBIFr
 I83w==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shopee.com; s=shopee.com; t=1784532635; x=1785137435; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W7JEJ2/e3baTSv7LfmQA0Cqj7i2lXjoZyApKTYC6Gx8=;
 b=EAd9qjd8SrWGqg89T47/+d+IBT5pU0nL/jnvm3ll63twFg60sJ4hvmioV8eNSiSTH6
 K++FM5sg7MZKV6Em36Htr11L9OJChIF7XDeryTy4r87aeT8VhtK7kSHOOOwa55woEF+X
 ++piqcdkguRN7TKaOX7vm5yX9FV2rKtqzvdxb9FOReztm8zaIxghWmybF8pNoWxdeqWG
 GswrmRhcqSGFYwJIOQSPPGBEgewRXZ261UrIP8rgNa0dZGAboxVWEILDKjEdRY9bORTT
 +VbeMkMtOzZNn+N1wA9v/9Wud1py0gJQA+n1Yk2QnH0OYuL5CtF/XhQL0GaljWR0di1L
 atCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784532635; x=1785137435;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W7JEJ2/e3baTSv7LfmQA0Cqj7i2lXjoZyApKTYC6Gx8=;
 b=RyV2JkCSmOnAshfhdcBzEDKMEzE7iUzI2a3MVN73VFzRxYzbp5wM4YX25ogZdYi8g6
 8B+TDzzVhN1WCh8wS/U9RoK4yDsadiyvDTMh/B3sqh9s+Hgi+52EX08zV7mTQl+rcUGe
 03p10tTQNWN00FE4juSeKZ8BHjuH4HezqwrL7U8+1KwMbCj0Qnic0gHa1H+2csTGG2f9
 p9RN4f4Kq7cBNdYJEE9nbqUwFEeenbm7sxJuUy4tiSzuNJ3bY9/Pn1nEXpO1OL0h3ou8
 BPOOGU1c7RsIdNJxSGGYwY/RaocYy3iZDOrk4Op0f+xMvEn76suiP+5mOVffiopgf/A+
 5ENw==
X-Gm-Message-State: AOJu0YxSpj+gmGxz43sRa+bwozTdHVf4dgU92EQC+NmvgSn61oti4ySI
 HxBdyn1nS1Y2raqxFQX+DTfm7TSNHI1d+eDs1rFgp5xDn9UQcuJ7Dm6sQD45OgbnwKWzEA8Y1+u
 3DJnFmn+fXPGBCULMcpHqmcd4W5an5YOkG3HbRQBoMmdmetGFOaMd1jk=
X-Gm-Gg: AfdE7cmEQ7Su5c1/K60McanTKtfa7ALsamhz3tE/DzI3l2ti2SGlLu5bcyDnsVslVc0
 1Yk4x2yO/+l+quO6wzndKbeGNifVMbRljJyPOriVNjMuupFEZnMmmVsCJ5e18rm3fZjoKuMvL5C
 Jl7kJ7TOB3Rt+SYIvaw9rjqH7WyMNqTzxycWQGyKyAyYaW8ngpReSJZxKn2FZmqCJj/LUXycmTv
 LGV1WEwlpqMv35adv0pzV0Fn8e+3kPdMrglN5iTZRxs7XvLBY90OfORfuUgLw==
X-Received: by 2002:a17:90b:1fc3:b0:387:d9cc:7dc3 with SMTP id
 98e67ed59e1d1-38e3d2b11dfmr19513137a91.21.1784532635016; Mon, 20 Jul 2026
 00:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260714031545.64932-1-mingyu.he@shopee.com>
In-Reply-To: <20260714031545.64932-1-mingyu.he@shopee.com>
Date: Mon, 20 Jul 2026 15:30:23 +0800
X-Gm-Features: AUfX_mwuYoY-887oN3fbQWGk-HXUTN_nvgXiLZCVkmM33wMQllENS8B8b4Rn48g
Message-ID: <CAAoBcuSFooX-5vrYB=bq2n=aT8iDkt-DmfQi2oFAZEVGgmah2Q@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] pty09: Cap RLIMIT_NOFILE-based slave PTY opens
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
From: Mingyu He via ltp <ltp@lists.linux.it>
Reply-To: Mingyu He <mingyu.he@shopee.com>
Cc: littleswimmingwhale@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpHZW50bGUgcGluZyBmb3IgdGhpcyBwYXRjaC4KClRoYW5rcywKUnVubGkKCk9uIFR1ZSwg
SnVsIDE0LCAyMDI2IGF0IDExOjE14oCvQU0gUnVubGkgPG1pbmd5dS5oZUBzaG9wZWUuY29tPiB3
cm90ZToKPgo+IHB0eTA5IGRlcml2ZXMgdGhlIG51bWJlciBvZiBzbGF2ZSBQVFkgb3BlbnMgZnJv
bSBSTElNSVRfTk9GSUxFLiBXaGVuIHRoZQo+IGxpbWl0IGlzIHZlcnkgbGFyZ2UsIGZvciBleGFt
cGxlIDEwNDg1NzYsIHRoZSB0ZXN0IHRyaWVzIHRvIG9wZW4gbmVhcmx5Cj4gb25lIG1pbGxpb24g
c2xhdmUgUFRZcyBvbiB0aGUgc2FtZSBtYXN0ZXIuIFRoYXQgbWFrZXMgdGhlIHdvcmtsb2FkIGRl
cGVuZAo+IG9uIHRoZSBjYWxsZXIncyBmaWxlIGRlc2NyaXB0b3IgbGltaXQgaW5zdGVhZCBvZiB0
aGUgUFRZIGJlaGF2aW9yIGJlaW5nCj4gdGVzdGVkLCBhbmQgY2FuIHR1cm4gYSB3b3JraW5nIFBU
WSBvcGVuIHBhdGggaW50byBhIHRpbWVvdXQtZHJpdmVuIFRCUk9LLgo+Cj4gVGhlIHRlc3Qgb25s
eSBuZWVkcyB0byB2ZXJpZnkgdGhhdCBhIHNsYXZlIHBzZXVkby10ZXJtaW5hbCBjYW4gYmUgb3Bl
bmVkCj4gbXVsdGlwbGUgdGltZXMgaW4gcGFyYWxsZWwuIENhcCB0aGUgbnVtYmVyIG9mIHNsYXZl
IG9wZW5zIGF0IDQwOTYgc28gdGhlCj4gdGVzdCByZW1haW5zIHJlcHJlc2VudGF0aXZlIGFuZCBk
ZXRlcm1pbmlzdGljIGV2ZW4gd2hlbiBSTElNSVRfTk9GSUxFIGlzCj4gc2V0IHVudXN1YWxseSBo
aWdoLgo+Cj4gRml4ZXM6IDIwYWExM2RiZDhhNjggKCJBZGQgcHR5MDkgdGVzdCIpCj4gU2lnbmVk
LW9mZi1ieTogUnVubGkgPG1pbmd5dS5oZUBzaG9wZWUuY29tPgo+IC0tLQo+IENoYW5nZXMgaW4g
djI6Cj4gLSBQcmludCB0aGUgdW5jYXBwZWQgYXZhaWxhYmxlIGNvdW50IGJlZm9yZSBhcHBseWlu
ZyB0aGUgY2FwLgo+IC0gQWRkIGEgc2VwYXJhdGUgVElORk8gbWVzc2FnZSB3aGVuIHRoZSBvcGVu
IGNvdW50IGlzIGNhcHBlZC4KPgo+ICB0ZXN0Y2FzZXMva2VybmVsL3B0eS9wdHkwOS5jIHwgOCAr
KysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9wdHkvcHR5MDkuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvcHR5L3B0
eTA5LmMKPiBpbmRleCBmM2FkZTIzODEuLjgwZGE0NzVlOSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL3B0eS9wdHkwOS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9wdHkvcHR5MDku
Ywo+IEBAIC0xNCw2ICsxNCw4IEBACj4KPiAgc3RhdGljIGludCBtYXN0ZXJmZCA9IC0xOwo+Cj4g
KyNkZWZpbmUgTUFYX1NMQVZFX09QRU5TIDQwOTYKPiArCj4gIHN0YXRpYyB1bnNpZ25lZCBpbnQg
Y291bnRfYXZhaWxfcGlkKHZvaWQpCj4gIHsKPiAgICAgICAgIERJUiAqZGlyOwo+IEBAIC0zNCw2
ICszNiwxMiBAQCBzdGF0aWMgdW5zaWduZWQgaW50IGNvdW50X2F2YWlsX3BpZCh2b2lkKQo+Cj4g
ICAgICAgICB0c3RfcmVzKFRJTkZPLCAiQXZhaWxhYmxlIG51bWJlciBvZiBwaWRzOiAldSIsIG1h
eF9waWRfbnVtKTsKPgo+ICsgICAgICAgaWYgKG1heF9waWRfbnVtID4gTUFYX1NMQVZFX09QRU5T
KSB7Cj4gKyAgICAgICAgICAgICAgIG1heF9waWRfbnVtID0gTUFYX1NMQVZFX09QRU5TOwo+ICsg
ICAgICAgICAgICAgICB0c3RfcmVzKFRJTkZPLCAiTnVtYmVyIG9mIHBpZHMgaXMgdG9vIGxhcmdl
LCBjYXBwZWQgYXQ6ICV1IiwKPiArICAgICAgICAgICAgICAgICAgICAgICBtYXhfcGlkX251bSk7
Cj4gKyAgICAgICB9Cj4gKwo+ICAgICAgICAgcmV0dXJuIG1heF9waWRfbnVtOwo+ICB9Cj4KPiAt
LQo+IDIuNDcuMAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
