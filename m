Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BACC87FCA
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 14:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753973125; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=iWnz+loNQTLTeoKtcJM8KLvgcfrM6o2Ht4qw9ryhUqw=;
 b=oVJLqbkmslBsCguAxOKnPuf8idq36H/qQBuNLz2m3N0NAyLKNsK2jx2h+Al4r+VZtNdvt
 cIgkfqv5t7WrA6C0KZtMCQ2VhDsNCQX2H1EbVu+5UpUItwQjboklA9rKVJRYgHIB5QMAVHh
 AGs349eScRm7jOWfzcpVDmsSAUtash0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B46EF3CC251
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 16:45:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0E4A3C9F61
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 16:45:03 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 966A610000D5
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 16:45:02 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso293594f8f.1
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753973102; x=1754577902; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmDscwi0IaxQUBgNaqYeXxpfR5j6GMHT/gC/y+xgEbY=;
 b=fAoZiikH0B1TvqnRliIdPv7eSdg/UfJ+9MPhmo274ppvf3jnsbIEDYfOSDpRG5CLrK
 Fe3za9/ee9xGemJPDD69Zw2U4SO5NvweCVIdYKkEjpu8UQ4944psrUnlj/TLje8vlJZ+
 c5RB1w7Gz28uHYzwDJnohGIMwDPRCYo/PySpaVRRRAaa2qkELe2J88hX0dXK+DHUoLVI
 brc7+93Cx2T0sU2rtORaW2/2/hi0RlY8+Ka6GJS6IRrnUELNyqKhDBdy4c/Xr82w79F6
 nIHYzja4vwDZoc+ubET08iA2wBvylQAXQQFpRbNmov9A8teBz+njmpN7W3uNN03gtZCG
 tZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753973102; x=1754577902;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VmDscwi0IaxQUBgNaqYeXxpfR5j6GMHT/gC/y+xgEbY=;
 b=ppSgfjPbIsS+NoxdYNDUjDgSYNsoK5ewZujCLjVIVWImyYRX/6VDkAUoq+rdNk9XrV
 M5TtGiMiKnPp4QECGRIV3d5nLIVnS0j3uHUMSEc6UW5/OnXWAQSiVYbDwsS6Gpm58mRm
 Ok47ru1KCFJJ73WuF/ceAEEmrUJkFZ32O8w9hD8qwUC/m3qNj2ToHBroCwI9KrFm/15w
 ruwXT3QYiwR4B50Fh7V1ZJokkqb6tQ2WpgadvaMj1SR9d18GGQ2faSubggdBHvOaKtys
 FWX9pTEYTqRjYcveL8QSnsichdPC+09ViiOceMLgLe/VxACyd7m/3330MbbqvyVByJYl
 UPig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKHExW5IKLS9AgibTTYdl4NVYq5ZhJFLY3c5oPeOQldGiePzqPEdteIyTWpKrX+RTNhwk=@lists.linux.it
X-Gm-Message-State: AOJu0YzuA0BceXp/tPjwPZ4hNeyxjxU+KEFOsl/VLFm2NvmYGnCPV1zi
 9vPhjREiFh+URfU4p8R47fA6Zg8mb0kvxwAUQWFrCTJIzKwirfCKSFd7EHEZrYe0CxZU4JBjVS/
 fkbmM
X-Gm-Gg: ASbGncteVyi9qpQ9+fQy5MSpWFTPsFMI5hIEVCPElIjXDZuXiAWkJtxfxtZay5bBTtW
 uRP+vE1eKpvPd7BL02nwS9BRkO9yUgPrP+WCpAFjd9rnim6lQuCd4cngk4G0M8AJ3Y47MTcMSjO
 vtl9RAQBX+mDAevdcQ0s8FCeotqJxP2Q2m0zL5aFGQbWuPd28eH6VnXoD30FFUVVD6/iPys2f2l
 IfE/8QZN91l5nGweiHfr1dLluX8qgCpMo3mUuqXw4FIQpmdLaPErfIihYyEjlIH+dDKnDp+JY8v
 MqkPcqUj4+rvgWi6x7MMMPDWXAIwOtXWL14ZIGl5cLE4NaPrArYv0x+TvIcQ39+M7Mpsa+oDmgT
 hcR24FPM1GA==
X-Google-Smtp-Source: AGHT+IE2KBpvFirLziStgKKQNREi3YcJhmeTdi8gOTtGC/D5qcQM1aQpu5UAT+FffppSp00jzYX9xA==
X-Received: by 2002:a05:6000:4310:b0:3b5:dafc:1525 with SMTP id
 ffacd0b85a97d-3b794ff16eemr6341582f8f.33.1753973101887; 
 Thu, 31 Jul 2025 07:45:01 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-241e8976a06sm20345825ad.81.2025.07.31.07.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 07:45:01 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 31 Jul 2025 11:44:56 -0300
Message-Id: <DBQBKKVD3C5A.2N3VLH1BY0W8P@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250731143550.777289-1-pvorel@suse.cz>
In-Reply-To: <20250731143550.777289-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] munmap04: Fix 'base' overflow
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
Cc: Andrea Cervesato <andrea.cervesato@mailbox.org>,
 =?utf-8?b?UmljYXJkbyBCIC4gTWFybGnDqHJl?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1IEp1bCAzMSwgMjAyNSBhdCAxMTozNSBBTSAtMDMsIFBldHIgVm9yZWwgd3JvdGU6Cj4g
TG93ZXIgZG93biBhIGJhc2UgdG8gZml4IG92ZXJmbG93IG9uIDMyIGJpdDoKPgo+IG11bm1hcDA0
LmM6MTg6MjU6IHdhcm5pbmc6IGNvbnZlcnNpb24gZnJvbSDigJhsb25nIGxvbmcgdW5zaWduZWQg
aW504oCZIHRvCj4g4oCYdWludHB0cl904oCZIHtha2Eg4oCYdW5zaWduZWQgaW504oCZfSBjaGFu
Z2VzIHZhbHVlIGZyb20g4oCYNDI5NDk2NzI5NuKAmSB0byDigJgw4oCZIFstV292ZXJmbG93XQo+
ICAgIDE4IHwgc3RhdGljIHVpbnRwdHJfdCBiYXNlID0gMHgxMDAwMDAwMDBVTDsKPiAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn4KPgo+IEZpeGVzOiAxZTJjOThl
M2FmICgiQWRkIG11bm1hcDA0IHRvIGNoZWNrIEVOT01FTSIpCj4gU2lnbmVkLW9mZi1ieTogUGV0
ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gLS0tCj4gSGksCj4KPiBJJ20gbm90IHN1cmUgaG93
IHRoaXMgaW5mbHVlbmNlcyByZWNlbnQgZml4ZXMuIEFuZCBob3cgdGhlIGJhc2UgYWRkcmVzcwo+
IHdhcyBhY3R1YWxseSBjaG9zZW4gKGp1c3QgcmFuZG9tIG1lbW9yeSBsb2NhdGlvbj8pLgoKUmFu
ZG9tLCB5ZXMhCgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+ICB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9tdW5tYXAvbXVubWFwMDQuYwo+IGluZGV4IDk4N2E3YzdlN2EuLmUxYjY3YWVlZTMgMTAwNjQ0
Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYwo+ICsr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMKPiBAQCAtMTUs
NyArMTUsNyBAQAo+ICAjZGVmaW5lIE1FTVNJWkUgMwo+ICAjZGVmaW5lIE1BUF9NQVhfQ09VTlQg
NjU1MzAKPiAgCj4gLXN0YXRpYyB1aW50cHRyX3QgYmFzZSA9IDB4MTAwMDAwMDAwVUw7Cj4gK3N0
YXRpYyB1aW50cHRyX3QgYmFzZSA9IDB4MTAwMDAwMDBVTDsKClRoYW5rIHlvdSwKClJldmlld2Vk
LWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKPiAgc3RhdGljIHNpemVf
dCBwYWdlX3N6Owo+ICBzdGF0aWMgdW5zaWduZWQgbG9uZyB2bWFfc2l6ZTsKPiAgc3RhdGljIGlu
dCBtYXBfY291bnQ7CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
