Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D958C87FCB
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753876117; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=iWYUhGhzoqRfxzm69n+Pkayv6v0G4JoDCaImn56qyQw=;
 b=o4Fj6P9ZVvKDQrnYYrAdcOsf7ll/jEl3kfOocnlrDoSjG48Hh9YlTJxgG1zMKz40w2x/o
 M/O4uaePTzXjQxriWmb+U6X2JGfDKvnpVlpLxn49bu05PI3ULEa6e9uY4mqJhECgkTLl/Uh
 QRO1wYcCrNdpZDy6DFZGjfpk3OHEDaE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B52E93CB19B
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 13:48:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A196F3C3270
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 13:48:16 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D3C42100040A
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 13:48:15 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4555f89b236so53525845e9.1
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 04:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753876095; x=1754480895; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oUOZv2k9kfy1V0LTEJTkfU07vb9a5lAasUsJ2UPuaQg=;
 b=Katfech+x726Q1XCWEJkZCA14yLuLOathUBVy/TwqiAncSm9MSZsnbWJLdVcBS1rCw
 GX9UJDw7zlygeoafLlfAcSdKFyINm0u0lNyN11bT5/Pfuo/2/WRuKUWOyajEcE1tgVQt
 oOgoOWlVuXGUCF5nr3P7EQGZ1p+i+HMpZg+l7184kq5/lHX7A4eoW+7PXgOBoUezlWQ+
 PT+D44MZ/AmgFuJ2n57J3VInYG34Xd2rCPNnTKi4eb0tbjfvaJAyf+kCZM6FmGuHft2m
 68c7piNK3WTiSWI+SiLIIHuOBmEmBOfE9xnrimFvIKDr2m0LynoFFomo0NOOjFpLdrin
 RC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753876095; x=1754480895;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oUOZv2k9kfy1V0LTEJTkfU07vb9a5lAasUsJ2UPuaQg=;
 b=BOQm8o5Xm7CP5HxeJqvukwruoWYtrYGRf/AGwHXJj2E81qyS2tiX6NSgVnJZSWdquW
 9Joy79pj38+q557oCOVz/2WZ0PgIJ6ZV0KxGwq7cZ0RWSM7g7hM3AuPZjP9b1gwXldEJ
 NB3FVoV2HxPw19xoIUiGwwJP1LRR4Ql4CwjkHmLudSCrqcIjEdny4QH24ucF3ACgDAv9
 8+1sHBbFsvRecNUdDPscC19vtB8dI0Er0xQxjJSU7W4CbYtZPgKBlST2NdufEpQb0LBr
 v/5JGIhILW/+x5qZa4ITMcJ2ctRG0598lm7XFh/h7q24c9yBQ6TS+PSDQIQ3MDGQ+OPA
 RFMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT71zugK1APw2j4a0DGjNLEsgXHG1IOVzJb6l/PKHqfFcAWp4UbDhYcIYo9l9dmV1jne4=@lists.linux.it
X-Gm-Message-State: AOJu0YxwDJ9d4UudbbY4+vxjf6Q0W5QkqyyxfRYSgZ9Jb8fRdPahYGAZ
 2f2ywW3w8fXmWyfrd0ar9i43pdnV7L/4UgSm7DyPCmOJBdjewi5WJHFZHBu/r+beFi8=
X-Gm-Gg: ASbGnctxvhY2g+wEvrdCZmpeSTthT55KGk4gSxEGyl4+tdXpSdhHg8wKQo75imax6oz
 VbEmEx9azrBt6n3Va7ddoXMrfNPmMyVhJR0aJAu51TkwcPAbcFAnHhoLsk6Qh5653Ctj7ZdM5w0
 Ohug8aUx3OiXlbXZEgWqZFRpu2waOR1sE7/i+wWAiDl0KfA71+KVLSuzs40+Hw/xRR9pNXOKoZx
 090sTOHxQQKREOtHguX8wah4UPIthnv8c12VSoV95N2HMXWOVfdGc1NpyUS2viEv5BQpvkjjXJr
 9FdweKqn+z4nIrLC3yU4xvZh3K1/Bk6POv89WYHhkc/8loymgDnOZSxw0YvL6R5YrCJn6Teor28
 3IEZgqpKkhE86vxijy8X4JiXhzCdNr2bRijs48yZj9Q==
X-Google-Smtp-Source: AGHT+IFF3OYlLSMDivNtKjvqIhMo9HHJ6X6nvu2Q39p0aEVs7r4dTrRgvT8lto1CavfbZl0SuFI5pA==
X-Received: by 2002:a05:600c:c4a2:b0:450:d4a6:799d with SMTP id
 5b1f17b1804b1-45892b90f65mr26622995e9.7.1753876095155; 
 Wed, 30 Jul 2025 04:48:15 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953f8e02sm23325585e9.32.2025.07.30.04.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 04:48:14 -0700 (PDT)
Date: Wed, 30 Jul 2025 13:48:13 +0200
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ztvo4o2hjism3e5sxgmjsqs4dtuxf3my73dzowdf3cnr67mxf5@qwpr5ct6boy4>
References: <20250710082000.11641-1-akumar@suse.de>
 <12708664.O9o76ZdvQC@thinkpad>
 <581805f2-0633-4e94-9252-b1be2bd47112@suse.com>
 <aG-BOM0OEKrp-GHm@yuki.lan>
 <2dbfe780-40b6-4b8a-9cb4-1517f3a8be7b@suse.com>
 <mqkxe24qlrcpb5jxgigbiarxxgemqjw3rmgnsprn55ubghrrda@etaozcz2nemy>
 <8810f8e2-af71-44f4-9163-3eb888a99f84@suse.com>
 <svs6pl6jmibp7uylvofkia5smvu2cuezfvnawlgkmjiulbrpfm@w7s7dlxxltap>
 <a019aba3-eaa1-4dd9-973b-c4bb8f3d4973@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a019aba3-eaa1-4dd9-973b-c4bb8f3d4973@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_regression_test: Use unique names for
 hierarchies in each test
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
From: =?utf-8?q?Michal_Koutn=C3=BD_via_ltp?= <ltp@lists.linux.it>
Reply-To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdWwgMTQsIDIwMjUgYXQgMDE6NTY6NTFQTSArMDIwMCwgQW5kcmVhIENlcnZlc2F0
byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4gd3JvdGU6Cj4gSSdtIHdvbmRlcmluZyBob3cg
dG8gcHJvY2VlZCwgc2luY2UgdGhpcyBpcyBhY3R1YWxseSBhIHNvZnQtZmFpbHVyZSBhbmQgYW55
Cj4gZml4IHRvIHRoZSB0ZXN0IG1pZ2h0IGhpZGUgZnV0dXJlIGJ1Z3MuCgpZb3UgY2FuIHRha2Ug
dGhlICh1bmlxdWUgbmFtZXMpIGZpeCBmcm9tIEF2aW5lc2ggYW5kIGFkZCBhIGRlZGljYXRlZAp0
ZXN0IGZvciB0aGUgdW5tb3VudGluZyAoYW5kIHNvbHZlIChzb2Z0KWZhaWx1cmUgb25seSBpbiB0
aGF0KS4KCjAuMDLigqwsCk1pY2hhbAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
