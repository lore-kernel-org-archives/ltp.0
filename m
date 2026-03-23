Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D0FEC01A2
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 08:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774252861; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=wBZnXcF+QeCjKqpR0DlZeFOgt6FCdnhm6VPG9KGHMKE=;
 b=gPvj/fmshqXDmXh8pKvNdpDgx+H8IcFXquSWVJhEjotmQC21eghLcK2E1JccJOSv5ZqbU
 bGkvbgrORVHmql5AJVPGiTY5txo6gT26PvsUPWb9ygi+i6Md3hDdz3Zk3VlN2fhESR41YC7
 U9quVaIFMqnCCE6/It8RNyUlVYTn7VM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39C333C6147
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 09:01:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC7D73C6147
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 09:00:34 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 237176008F1
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 09:00:33 +0100 (CET)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43b467dcf0bso2859371f8f.0
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774252832; x=1774857632; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1udyTz+lr3EM+9kL66AUH1UJWYwqZ6TCk9ms/XN8QG0=;
 b=X4QjtNUeu8k/Ck+eswsA80ko1GT0Tx6PPXJVQ+p25+Ugq20IQA/eo2TwUe4fteIZUf
 RaVAETC8X9G8gb+5RBDbLg9zPgGkRbDcLIL8WExMTpV679kPbW6cnbDVqOppGiIjLnDa
 UX2ZAvw6Fz5CU60w8ziSO7T4O024lCTt2A2j3Llvhd1K+/FopsTX09KmTREcwr6uAC9+
 Ui7J20oCk/X72dOI5OjCWOp6DAf2/TMOtNwrY26NAk8mI1J5PoAsXxMx2dJbgVw8Z4iI
 R+zBCKIdjrKlzSXJeVR/r0XeCMc2CqWj1Q38+v+4bJy//U2PiH0rAG6lHFrWOlhSBrpm
 vb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774252832; x=1774857632;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1udyTz+lr3EM+9kL66AUH1UJWYwqZ6TCk9ms/XN8QG0=;
 b=R7J8JHpmg88ZnhpsfuJ3jdRGKkkioxx81n78NS+B1PeuKxfkRhRlGEuTKqPOHSzrEm
 bWOpf7wTHWpn/RygttTDTOs412MVfm3sSn1maGFiYsMdzBKbzS83SR3SJDGljkQDPJHS
 rN0oMF9NIZCTmNK/2GnIRDh6gw+nBGjeBwt09iR/I78Ioy3NMBwRiB8xe/1vkcVK2HJJ
 41P0G+Z3yTaywla1NLAE84IUyIlnk4EFvaed9zRcZ6M0Y8OQJHxgyvQG1GXlti7c6ZL2
 NO0i8aJxXV5+GQNxxLO99RGfB03oBcDOM6HkMRjG/4aRVwWJdAY1kTXVNjIc2f1xFbSj
 cNjQ==
X-Gm-Message-State: AOJu0YxxZ9/ZZUtIsudHbejbE5TRz8ovsyv8MpJL+2R8ZshWL6iLvc/w
 R+KvnQHptCBeUvVS1y4CuM6jgDQftM6YijoHFQTSueD7LkERo5hZkjwet0yFoxE6/qjP5919BDl
 ozz3JGk8=
X-Gm-Gg: ATEYQzzygOwD43pKDCnzM6pUJvSWQhrgjl6NzAce4+ZeXgpVZwaTZIWEivZuDGUF1dp
 weLrH0V65JP8BWSxzQjjV6bGBchHnOLQdUK0zQBxpLb9Yb9TOTIwUu/bWI3UEUFmzeOcQGqaKb+
 +soRNGzHdq0XCgaVee6cWkvdeAS54dOpBkw8mf3uxYvKxUs41cHnSBl2vHyV/A9FHk5G06BaFcJ
 LjhbT29FBmrvykaPergYjKdKNfGQrCqxvGGc2nxJZB0vZQZ7BD7gGVxE87t7L0MFF9bSp02AAa+
 VWLWaQYY/Ta+S3VCPhpo0fNUYmFdKn09deJKaG2mhZDCOQ8KeLfc5N+WVwPon/uz1sjhkT1aZ+k
 bd/aquhBJtHHfcl+2J0F02L2GckOPeq+y7tcIhyCbNCzVA5FmmniE5hUI9D80FjaN35CLdPgq+H
 l7YUeHBUJtGonVFkdJYqzGtwgY6jCfs5yAHUJnTw75Fj0=
X-Received: by 2002:a05:600c:1383:b0:486:fbc4:8fe2 with SMTP id
 5b1f17b1804b1-486fe8fb2b2mr165588945e9.15.1774252832310; 
 Mon, 23 Mar 2026 01:00:32 -0700 (PDT)
Received: from localhost.localdomain ([37.160.201.221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff19d445sm74932635e9.15.2026.03.23.01.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 01:00:31 -0700 (PDT)
Message-ID: <69c0f31f.050a0220.943db.4f2a@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260321083813.138283-2-piotr.kubaj@intel.com>
Date: Mon, 23 Mar 2026 08:00:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] high_freq_hwp_cap_cppc.c: new test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGlvdHIsCgpBIGZldyBpc3N1ZXMgYmVsb3cuCgo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ICsKPiArLyoKPiArICogQ29weXJpZ2h0IChDKSAyMDI2
IEludGVsIC0gaHR0cDovL3d3dy5pbnRlbC5jb20vCgpUaGUgYmxhbmsgbGluZSBiZXR3ZWVuIHRo
ZSBTUERYIGlkZW50aWZpZXIgYW5kIHRoZSBjb3B5cmlnaHQgYmxvY2sgaXMKbm9uLXN0YW5kYXJk
LiBUaGV5IHNob3VsZCBiZSBhZGphY2VudCAobm8gYmxhbmsgbGluZSBiZXR3ZWVuIHRoZW0pLgoK
PiArCW5wcm9jID0gdHN0X25jcHVzKCk7Cgp0c3RfbmNwdXMoKSByZXR1cm5zIF9TQ19OUFJPQ0VT
U09SU19PTkxOIOKAlCB0aGUgKmNvdW50KiBvZiBvbmxpbmUgQ1BVcywKbm90IHRoZSBoaWdoZXN0
IENQVSBudW1iZXIuIE9uIGEgc3lzdGVtIHdoZXJlIENQVXMgMCwgMSwgMyBhcmUgb25saW5lCmFu
ZCBDUFUgMiBpcyBvZmZsaW5lLCB0c3RfbmNwdXMoKSByZXR1cm5zIDMsIGFuZCB0aGUgbG9vcCBi
ZWxvdyBpdGVyYXRlcwpvdmVyIENQVXMgMCwgMSwgMiwgYWNjZXNzaW5nIHRoZSB3cm9uZyBzZXQg
b2Ygc3lzZnMgcGF0aHMuCgpVc2UgdHN0X25jcHVzX2NvbmYoKSBhcyB0aGUgdXBwZXIgYm91bmQg
YW5kIHNraXAgb2ZmbGluZSBDUFVzCmluZGl2aWR1YWxseSwgb3IgaXRlcmF0ZSBvdmVyIHRoZSBh
Y3R1YWwgb25saW5lIENQVSBudW1iZXJzIGZyb20KL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvb25s
aW5lLgoKPiArCQlzbnByaW50ZihwYXRoLCBzaXplb2YocGF0aCksICIvc3lzL2RldmljZXMvc3lz
dGVtL2NwdS9jcHUlZC9hY3BpX2NwcGMvaGlnaGVzdF9wZXJmIiwgaSk7Cj4gKwkJU0FGRV9GSUxF
X1NDQU5GKHBhdGgsICIlbGx1IiwgJnN5c2ZzX2hpZ2hlc3RfcGVyZik7CgpDT05GSUdfQUNQSV9D
UFBDX0xJQj15IGRvZXMgbm90IGd1YXJhbnRlZSB0aGUgYWNwaV9jcHBjLyBzeXNmcwpkaXJlY3Rv
cnkgZXhpc3RzIGF0IHJ1bnRpbWUg4oCUIGl0IG9ubHkgYXBwZWFycyB3aGVuIHRoZSBDUFUgZmly
bXdhcmUKZXhwb3NlcyB0aGUgQ1BQQyBfQ1BDIEFDUEkgbWV0aG9kLiBJZiB0aGUgcGF0aCBpcyBh
YnNlbnQsIFNBRkVfRklMRV9TQ0FORgphYm9ydHMgd2l0aCBUQlJPSy4gQ2hlY2sgZm9yIGV4aXN0
ZW5jZSBhbmQgcmV0dXJuIFRDT05GIGluc3RlYWQ6CgogIGlmIChhY2Nlc3MocGF0aCwgRl9PSykp
IHsKICAgICAgdHN0X3JlcyhUQ09ORiwgIkNQUEMgc3lzZnMgbm90IGF2YWlsYWJsZSwgc2tpcHBp
bmciKTsKICAgICAgcmV0dXJuOwogIH0KCj4gKwkJaW50IGZkID0gU0FGRV9PUEVOKHBhdGgsIE9f
UkRPTkxZKTsKPiArCj4gKwkJU0FGRV9QUkVBRCgxLCBmZCwgJm1zcl9oaWdoZXN0X3BlcmYsIHNp
emVvZihtc3JfaGlnaGVzdF9wZXJmKSwgMHg3NzEpOwo+ICsJCW1zcl9oaWdoZXN0X3BlcmYgJj0g
KDFVTEwgPDwgOCkgLSAxOwo+ICsJCXRzdF9yZXMoVERFQlVHLCAiJXM6ICVsbHUiLCBwYXRoLCBt
c3JfaGlnaGVzdF9wZXJmKTsKPiArCj4gKwkJaWYgKG1zcl9oaWdoZXN0X3BlcmYgIT0gc3lzZnNf
aGlnaGVzdF9wZXJmKQo+ICsJCQlzdGF0dXMgPSBmYWxzZTsKClR3byBpc3N1ZXM6CgoxLiBmZCBp
cyBuZXZlciBjbG9zZWQuIE9wZW5pbmcgaXQgb25jZSBwZXIgQ1BVIGl0ZXJhdGlvbiBsZWFrcyBv
bmUKICAgZmlsZSBkZXNjcmlwdG9yIHBlciBDUFUuIEFkZCBTQUZFX0NMT1NFKGZkKSBhdCB0aGUg
ZW5kIG9mIHRoZSBsb29wCiAgIGJvZHkuCgoyLiBXaGVuIHRoZSB2YWx1ZXMgZGlmZmVyLCBzdGF0
dXMgaXMgc2V0IHRvIGZhbHNlIGJ1dCB0aGVyZSBpcyBubwogICBwZXItQ1BVIG1lc3NhZ2UuIFRo
ZSBzaW5nbGUgVEZBSUwgYXQgdGhlIGVuZCBnaXZlcyBubyBpbmRpY2F0aW9uIG9mCiAgIHdoaWNo
IENQVSB0cmlnZ2VyZWQgdGhlIGZhaWx1cmUuIEFkZCBhIFRJTkZPIG9yIFRGQUlMIHBlciBDUFU6
CgogICAgIHRzdF9yZXMoVEZBSUwsICJjcHUlZDogc3lzZnM9JWxsdSBNU1I9JWxsdSIsCiAgICAg
ICAgICAgICBpLCBzeXNmc19oaWdoZXN0X3BlcmYsIG1zcl9oaWdoZXN0X3BlcmYpOwoKClJlZ2Fy
ZHMsCi0tCkFuZHJlYSBDZXJ2ZXNhdG8KU1VTRSBRRSBBdXRvbWF0aW9uIEVuZ2luZWVyIExpbnV4
CmFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
