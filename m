Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAF2CD5BBF
	for <ltp@archiver.kernel.org>; Sat, 23 May 2026 13:31:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEA8E3E27C4
	for <ltp@archiver.kernel.org>; Sat, 23 May 2026 15:31:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1A2C3C7175
 for <ltp@lists.linux.it>; Sat, 23 May 2026 15:31:01 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 49EAB2001C8
 for <ltp@lists.linux.it>; Sat, 23 May 2026 15:31:01 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2ef8d6ba48bso4476890eec.1
 for <ltp@lists.linux.it>; Sat, 23 May 2026 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779543060; x=1780147860; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OvOfPRGPmpIoBQaMve8B6iWvPvYdppuwbRv7xrz1C+U=;
 b=BBi5qzMlz51ZrY6qwwnN/0JaLJnnLCfRNb87/BczR91ZaV4y4W0nmzPWizv0HgFYkY
 TjaM9bmwZpXRCrWNyWLCjOWs0KvoOb7KUkjXf/ZVbv/m53OYp+ACWgFhmqkqw5rJQxV0
 uBYXraO5lYaFO9BFbQFXvG7Jp0GoOOdLWVd/fBYD+JhOgY6hubXubLeCf82p9y2yQZaP
 +U7/cOxbfUQGNFSwu4vcCK0vVpWDeoKg/1m8Ngd5z+YIsjwIYWqdauurK/NRRMbbOv6/
 W5dmXzULnP1Vn+YMkaPJL90P45ZJHDWtxlYEIijCotXSrXn9Zi93zhRpq6cWVeKMS4AI
 HiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779543060; x=1780147860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OvOfPRGPmpIoBQaMve8B6iWvPvYdppuwbRv7xrz1C+U=;
 b=GuVxqjBZS//ijgqDKjRxoxINssiz3+sH3FMc0uDRBYVXnL9p/jq1pFvuTV8NZx9MQK
 fIkO2T2UkpwVNw2U8tu7WK2GDR+P9/zj6JFXUENBiknYL1i8at7mFc4AK/1iYgp5Hyfb
 l1c6XNDPg5ALzTsSMK7uHXYM0HeZy1hHfHY2gv7VTTn0YSCkFlxqFn0SAdd6YV/sTq02
 1I0STeuiJE5X0Ss2HtHVyiK55WmuELY/jssZYKibeONngs9j1QQpXJsIaziwTdhW8BTM
 FruAgBYUPQ7T0PTfCg7CcQUt9LrbwY0qp3H6nWHtGkqOERHqQtygwgXM7SSVZ+/SsXS1
 Oi2A==
X-Gm-Message-State: AOJu0Yz68C9wdipRkD0uT9y3CyDR/S56NXJkwOCJ+W4spnZokh0qgXgv
 imwowtXeuCHqlNkoyWnvwbAxbOlWOG3NqYBAAbCsYAMhlXuC7rSMsS8T
X-Gm-Gg: Acq92OFl/RGKhWjKvvdpPRgDVLg3xvGoDbwifn7ypv8mteDHIpwwh9cx2HlIjSyBsdg
 WP3yexgYnISU6hXXyLXEBIHXNNE5nH3UAceU1SuDe7IMtqEj1S8Im+my8DBMjzJgllHRymI4rHy
 rYtk41WB6oyDDO8kZFyN9Rh/AliXS2HLoU1XcOQzUIGAMfAiKCE8mT2+2h9D/5U0rzXYZlHfgc0
 k6xQHsBXCspuwhC02CMqk2TejlV4qq8kkoiMn5qDBneiEo+pYtNdPdK5BEXjAbCaFbeBQYPMqkH
 DuWBdjER0hls2H/qHQhXUGiwxYHaYB1uEBNJSfWtVe6FrIIo9xOpdDMYeSg+ERu5fc8ECqDQ3Ec
 NAuojePzjPiGligvjMF/88blkir0ISSDNeanXEjsmlCVjtkYB6m3POo//Bio2XeDe4VTRWjBlNi
 6HRmhKP8DziayGYcawrZodSsPrfHPdqQJ5STyy3YlW+xECNiWcsF2fsVqrVjKHcWr8IBGZqzCsU
 9CQG8QedYSjaua7otYFjklQE5CocqfDBdlWOg==
X-Received: by 2002:a05:7301:2284:b0:2d9:db50:c6ce with SMTP id
 5a478bee46e88-3044a3f96d9mr2902275eec.3.1779543059416; 
 Sat, 23 May 2026 06:30:59 -0700 (PDT)
Received: from
 runnervmg397c.z3jxgq5ehwnebfxq4u2nylwtgb.dx.internal.cloudapp.net
 ([40.65.61.144]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452461cb5sm4590460eec.31.2026.05.23.06.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 06:30:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Sat, 23 May 2026 13:30:57 +0000
Message-ID: <20260523133057.4611-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523113909.6385-1-sebastian.chlad@suse.com>
References: <20260523113909.6385-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring/pintheft: Add CVE-2026-43494 regression test
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

SGkgU2ViYXN0aWFuLAoKT24gU2F0LCBNYXkgMjMsIDIwMjYsIFNlYmFzdGlhbiBDaGxhZCB3cm90
ZToKPiBpb191cmluZy9waW50aGVmdDogQWRkIENWRS0yMDI2LTQzNDk0IHJlZ3Jlc3Npb24gdGVz
dAoKWy4uLl0KCj4gKy8qIGlvX3VyaW5nIElPUklOR19SRUdJU1RFUl9DTE9ORV9CVUZGRVJTIGFy
Z3VtZW50LiAqLwo+ICtzdHJ1Y3QgY2xvbmVfYnVmZmVyc19hcmcgewo+ICsJdWludDMyX3Qgc3Jj
X2ZkOwo+ICsJdWludDMyX3QgZmxhZ3M7Cj4gKwl1aW50MzJfdCBwYWRbNl07Cj4gK307CgpUaGlz
IHN0cnVjdCBpcyBhIGtlcm5lbCBBUEkgdHlwZSBhbmQgYmVsb25ncyBpbiBgaW5jbHVkZS9sYXBp
L2lvX3VyaW5nLmhgCmFsb25nc2lkZSBgSU9SSU5HX1JFR0lTVEVSX0NMT05FX0JVRkZFUlNgLCBm
b2xsb3dpbmcgdGhlIGV4aXN0aW5nIHBhdHRlcm4Kb2YgYHN0cnVjdCBpb191cmluZ19maWxlc191
cGRhdGVgIGxpdmluZyBuZXh0IHRvIGBJT1JJTkdfUkVHSVNURVJfRklMRVNfVVBEQVRFYC4KCj4g
KyNpZm5kZWYgSU9SSU5HX1JFR0lTVEVSX0NMT05FX0JVRkZFUlMKPiArI2RlZmluZSBJT1JJTkdf
UkVHSVNURVJfQ0xPTkVfQlVGRkVSUyAgMzAKPiArI2VuZGlmCgpUaGUgdmFsdWUgMzAgbmVlZHMg
YSBjcm9zcy1yZWZlcmVuY2UgdG8gdGhlIHVwc3RyZWFtIGtlcm5lbCB1YXBpIGhlYWRlcgooYGlu
Y2x1ZGUvdWFwaS9saW51eC9pb191cmluZy5oYCkgaW4gYSBjb21tZW50IG9yIGF0IGxlYXN0IGEg
dmVyaWZpY2F0aW9uCm5vdGUuIFRoZSBsYXBpIGZpbGUgaGFzIG5vIG90aGVyIG51bWJlcmVkIHJl
Z2lzdGVyIG9wY29kZXMgYWJvdmUgMTAsIHNvCnRoZXJlIGlzIG5vdGhpbmcgaGVyZSB0byBjb3Jy
b2JvcmF0ZSB0aGUgdmFsdWUuIFBsZWFzZSBjb25maXJtIGFnYWluc3QgdGhlCmtlcm5lbCBzb3Vy
Y2Ug4oCUIHRoZSBsYXRlc3Qgc3RhYmxlICg3LjEpIGhhcyB0aGlzIGRlZmluZWQ7IGEgcXVpY2sg
Z3JlcCBvZgpgbGludXgvaW9fdXJpbmcuaGAgaXMgZW5vdWdoLgoKPiArCWlmIChpb191cmluZ19y
ZWdpc3RlcihyaW5nX2ZkMSwgSU9SSU5HX1JFR0lTVEVSX0JVRkZFUlMsICZmaXhlZF9pb3YsIDEp
KSB7Cj4gKwkJaWYgKGVycm5vID09IEVOT01FTSkKPiArCQkJdHN0X2JyayhUQ09ORiwgIk5vdCBl
bm91Z2ggbWVtb3J5IHRvIHJlZ2lzdGVyIGlvX3VyaW5nIGJ1ZmZlciIpOwoKRU5PTUVNIGlzIGEg
cmVzb3VyY2UgZXhoYXVzdGlvbiBlcnJvciwgbm90IGEgY29uZmlndXJhdGlvbiBvciBmZWF0dXJl
CmF2YWlsYWJpbGl0eSBpc3N1ZS4gVXNlIGBUQlJPSyB8IFRFUlJOT2AgaGVyZSAob3Igc2ltcGx5
IGRyb3AgdGhlIHNwZWNpYWwKY2FzZSBhbmQgbGV0IHRoZSBmYWxsdGhyb3VnaCBoYW5kbGUgaXQp
LCBub3QgYFRDT05GYC4KClsuLi5dCgo+ICsjZGVmaW5lIENMRUFOVVBfV0FJVF9TRUNTCTMwCgpU
aGUgdGVzdCB1bmNvbmRpdGlvbmFsbHkgc2xlZXBzIDMwIHMgb24gZXZlcnkgbm9uLXZ1bG5lcmFi
bGUgcGFzcy4gTm8KYC50aW1lb3V0YCBpcyBzZXQ7IHRoZSBkZWZhdWx0IDMwMCBzIHdpbmRvdyBp
cyBsYXJnZSBlbm91Z2gsIGJ1dCBhCmAudGltZW91dCA9IDYwYCAob3Igc2ltaWxhcikgd291bGQg
bWFrZSB0aGUgaW50ZW50IGV4cGxpY2l0IGFuZCBwcmV2ZW50CnJ1bnRlc3QgdGltZW91dHMgaWYg
c2V0dXAgb3ZlcmhlYWQgaXMgaGlnaGVyIHRoYW4gZXhwZWN0ZWQuCgotLS0KTm90ZToKCk91ciBh
Z2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBmdWxsIHJldmlldyBj
YW4gYmUKZm91bmQgYXQ6IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRw
L3B1bGwvMTcyNgoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2
ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBp
c3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9y
ZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
