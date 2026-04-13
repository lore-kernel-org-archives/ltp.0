Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D2BF34C4C
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 12:25:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A7B33E2E5F
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 14:25:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB1003E2699
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 14:22:46 +0200 (CEST)
Received: from mail-dl1-x1243.google.com (mail-dl1-x1243.google.com
 [IPv6:2607:f8b0:4864:20::1243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3C75B1400242
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 14:22:46 +0200 (CEST)
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-12c25b90264so4892971c88.1
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776082964; x=1776687764; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Czn86w69aVy5iDZJfT1rk1sGpTtUroxE/NfIBZxUWxE=;
 b=rSQeZ56l4sXjTgafVC1z15Wk2QLo9sDHN9HIalmGUMwlvyMnNtcUMF3qyWBUtxj+H+
 6tBCx8MXsO0NvXaDGu5xVzB1cdtQFyo21sM2hxXeRHbxzScUsU48rtRHvHqW3QTcZsbQ
 QlFIi+dCTOY/mEE67NOOp3NMbZ7A4lnoPnvNHLJCR0ggkCo0OalEnUtriw6osgbzwJoB
 n+pCj50D+Y1qr+OyddEdTwehe+lPTWV/I5O/ol678RcThsXq75NEOcLEB70wm1tpWzeL
 CW8+BpNm2Q2UH+rlnuzfCG1/VnmImwlza8G0Z3n75jgLhno8DcXyBu2udZsQVkDu7VY0
 s7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776082964; x=1776687764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Czn86w69aVy5iDZJfT1rk1sGpTtUroxE/NfIBZxUWxE=;
 b=TW7uyxSkqTWJHvS//Y69+plbgmzMAbc0MBzCzS8FsD56tZ379+zFRgmkzn51k+euzl
 fn7q29DcA9mWMeEJrP8eRDqHg4qhXukQil5jPQbrvN+PYyav+wWF9GPAtndNIXqJMEVA
 HAUUuqOhPGoVod+xbw3I5f3fVqZZF6/bHbGhFFZD7AUibLIs2ywHalOrAnpis4fSJubJ
 Tbtqf8nbDNQxRfyapMuc4mdhBy1t4dycmzS754j26kSWiIyyDccaXpOHMlbu9QQOBiGv
 wboC4XEFm1I3Q4Jh3yaEjxzMCh5voh1yF+JcetO0tOlIEnBhGtLJf6t6wYzwth1CXI3u
 9/BQ==
X-Gm-Message-State: AOJu0Yxy2pgLTsJj3i/kEjO7WqCf7xnfjzAyqb97h7LK+pTIz7/ya3o5
 xz771mpHRgzTAJjjXEzOxN5ohR6u3KmyvR9AYWD7Mp3hiSDGkOyNE8mU
X-Gm-Gg: AeBDiethD/8bBH+ZF+SUuErXYdqdqbhwkvPmKud9bw+j653rRiLfj8VWQ6Krfm+l/CX
 KF0LOk9/aPM9nZeVaoodhP6BexkI820SQ1OR9Ld+Bo69HDy300+Y0R2LwdIYLEBeoHhn4mIh7hp
 GAkTsYrtn/blmKsiVYi8JCl5O8gsvi7mGVGzlI0BAbH+3qi94aVxkeU+QUwop3L6t1AGK2RrVni
 77jF3W2WJDhtBe3kJZeGR2vo24H6GWqCehh9Kq8KOiy4vDB2RY9J9KB5vaVL1o9d215YwFEHGJy
 U5qJn5+xzisl7YIkcCvfzuU7guvOln/xleLsHS1b4x6qdW0inf7oIVUYjxVdYgMWYzlq9X40w4E
 O/C/dx7U3p5xkD/xxGUzDqv7lUCt4DwDQlo8qWH+kW79wDk59XZVCSNYuk0GMC0cAn1RNkznDu8
 AfRfpO/56/YDj2CfPqlsDGLkkXJEfu4XUNcx1DFL8+7ro1i5o5qy2lnV4u/vaVmXYvSSRYr23yW
 yNeXFBqFQz8t+oZTUaC2x+WOgIT
X-Received: by 2002:a05:7022:fd01:b0:128:d4be:7438 with SMTP id
 a92af1059eb24-12c34eeb7f3mr7891613c88.30.1776082964417; 
 Mon, 13 Apr 2026 05:22:44 -0700 (PDT)
Received: from
 runnervm35a4x.tl2v0rktc0guzlcbunsqswfqba.yx.internal.cloudapp.net
 ([128.24.161.84]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c345b6208sm14976854c88.8.2026.04.13.05.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 05:22:44 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Apr 2026 12:22:43 +0000
Message-ID: <20260413122243.3915-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413115129.30239-1-chrubis@suse.cz>
References: <20260413115129.30239-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 13 Apr 2026 14:24:41 +0200
Subject: Re: [LTP] lib: Treat kernel ntfs3 as a separate FS
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

SGkgQ3lyaWwsCgpvdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoLgoK
VGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2gg
b2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0
aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2Vz
dGlvbnMuCgpPbiBNb24sIDEzIEFwciAyMDI2LCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gbGliOiBU
cmVhdCBrZXJuZWwgbnRmczMgYXMgYSBzZXBhcmF0ZSBGUwoKPiBNZWFud2hpbGUgdGhpcyBldmVu
IGNhdXNlZCBmYWlsdXJlcywgd2hpY2ggaXMgaG93IHRoaXMgaXNzdWUgZmluYWx5Cj4gc3VyZmFj
ZWQgd2l0aCBhIGZ1c2UgYmFzZWQgTlRGUyBub3QgYmVpbmcgc2tpcHBlZCBwcm9wZXJseSBiZWNh
dXNlIHRoZQo+IHRlc3QgbGlicmFyeSBnb3QgY29uZnVzZWQgd2l0aCBoYXZpbmcgYm90aCBrZXJu
ZWwgYW5kIGZ1c2UgTlRGUwo+IGF2YWlsYWJsZS4KClR3byB0eXBvczogImZpbmFseSIgLT4gImZp
bmFsbHkiLCAiY2FsbGxlZCIgLT4gImNhbGxlZCIgKGEgZmV3IGxpbmVzCmJlbG93KS4KClNpbmNl
IHRoaXMgZml4ZXMgYSByZWFsIGZhaWx1cmUsIHBsZWFzZSBjb25zaWRlciBhZGRpbmcgYSBGaXhl
czogdGFnCnBvaW50aW5nIHRvIHRoZSBMVFAgY29tbWl0IHRoYXQgaW50cm9kdWNlZCB0aGUgYnJv
a2VuIG50ZnMgaGFuZGxpbmcuIElmCnRoZSBpc3N1ZSBwcmVkYXRlcyBhbnkgc2luZ2xlIGlkZW50
aWZpYWJsZSBjb21taXQsIGRyb3BwaW5nIHRoZSB0YWcgaXMKZmluZSDigJQganVzdCBjbGFyaWZ5
IGluIHRoZSByZXBseS4KClsuLi5dCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
