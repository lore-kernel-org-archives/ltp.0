Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF361C636B7
	for <ltp@archiver.kernel.org>; Sun, 22 Feb 2026 20:27:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FDD73D03A4
	for <ltp@archiver.kernel.org>; Sun, 22 Feb 2026 21:27:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 631A53CAEC3
 for <ltp@lists.linux.it>; Sun, 22 Feb 2026 21:26:59 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 46DDA600640
 for <ltp@lists.linux.it>; Sun, 22 Feb 2026 21:26:59 +0100 (CET)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-354b20c1112so2200722a91.3
 for <ltp@lists.linux.it>; Sun, 22 Feb 2026 12:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771792017; x=1772396817; darn=lists.linux.it;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCdrZ0PSIEO80EcdFAXf1bTPmSSWpvpRzWRTjY0jaY0=;
 b=KrhMwDWNQbokNuMvyPCcyFp/x8G6mpJ7PU/UIOJe1bMl81c3JkpWyf2MyUJKgaf4rP
 5lOmTDyij9PoMmpopK8JcwufFomjk4gKXCsz41ktP2z3Hr5JPEFx84F2nrdpKncvVz/U
 rFvZ1gmS8QsER97kxvvLlDuBJjmM/Z5xZSGP6GJRrbu1esMq6C5RlOyppqTmXIgpuudV
 IRnDQZ51Y1zQhEd28fv4myCVGo8LvrvyNzw1uDu2dskYjNpmGd1aEz1jgImqfCvze3i5
 Imp4ujeFw+AxgnET2tfEyTkokgYKavpS0CERKtrqsxeRFD+2mXaA8c3Xz/YXnyhX5bV/
 wveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771792017; x=1772396817;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zCdrZ0PSIEO80EcdFAXf1bTPmSSWpvpRzWRTjY0jaY0=;
 b=nITcNm8NcCxFBQ5plibs6cqYMZpnhl0ojuwkZpnIHgHnDGJqOFji8Dc/jgTyPnrDtQ
 ogWkciONLencpPfJnijG3CaNUDrbVMA1nNgX2KntydYtZllH3fZcGt9H+0hWWm5gT8p4
 0180xVVMMsT+Y9mRpOkb4zZ++cFs+bapNz4n9YXGZPf1QTLPWE9yh86WSMGy1C2yublq
 0l7sMuoONqug5pYQouX9dpEN6BeMxdd847M23dvcL7+ZrTtylCXLOgc/TZjOUQUxbCzF
 0Pls55BzyyqBYRqIN/BMKX+NrbR15WEWkHzYBDxj1a5j1U/32dFa1mulUivW5ZbNxfgM
 wV1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFy61D4zQJDjKPEqOW18BgN6HLGh7+F0qOLZSlQeGxm2zexfEUxE9Za11DDp7N09tfAVY=@lists.linux.it
X-Gm-Message-State: AOJu0Yxp/vXdJ4Ias1tBm9kh5x0nPuLVKL0V81cRAIr3rUXQHiwPuXwC
 tN0qviKzLP2en8t4kLFLpy/PJk2XYI3ZgJ9y/IRf2asntDiJQcDQkJr9
X-Gm-Gg: AZuq6aIwA2jLo3xMFcHiYlSZLp2CV+gnLCFzlKmc34y9zsGFMJUYO1tzYfF0a9u26F9
 1DeVaf01EBmhOj2F0za3ODuSDfeH/uWXdWboI4MJnPDqAk5XROmZjdwIZxc6hPAE8mvDWDQmkeg
 2lexBKC5NSeC7rxvAAk3W7wHYm3zBAYK6j4LwjS+Biy0B24GUA/NFgHPJGE1FTjo6ewVfnbeud/
 qTAQPyjsJ5BYpi3PXvpwDae9LjhRfiRfxQ0GSwE0PK5zG0pQBu4kN7NTyY+HsXzEsuzy8wiOu/G
 2kLpIW58VW5kUnNgcmUt7qc98DYxwHQc/pd625XzyhcbhIvxyISOElDI3j+TdphobNLFY7yiW5Y
 EGoz1FIsny3VWKdmifNH8xY4cYsTqqoXG1cDp7h4+qOxOV+GzC4DG7o9F/GcsW3r7+LuYXOqVB+
 +sL2o3lsbOwRo1rJXRbts3ObpbMF4k2ZmBB0+4MF/8WSsxsq8n0mM=
X-Received: by 2002:a17:90b:5150:b0:340:ff7d:c26 with SMTP id
 98e67ed59e1d1-358ae8c24eamr5649301a91.16.1771792017453; 
 Sun, 22 Feb 2026 12:26:57 -0800 (PST)
Received: from smtpclient.apple ([176.100.43.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-358af7209dasm5204091a91.8.2026.02.22.12.26.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 22 Feb 2026 12:26:56 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
From: "Enji Cooper (yaneurabeya)" <yaneurabeya@gmail.com>
In-Reply-To: <20260222202158.GA417048@pevik>
Date: Sun, 22 Feb 2026 12:26:45 -0800
Message-Id: <C2672F75-E168-4039-B13C-4E9456E96FFD@gmail.com>
References: <20260205121540.329921-1-pvorel@suse.cz>
 <20260205121540.329921-2-pvorel@suse.cz> <aZQytH7k6pVXqdsz@yuki.lan>
 <20260219202051.GB341772@pevik> <aZhJ7h0toQVUzHnf@yuki.lan>
 <20260220153410.GA392516@pevik> <aZiNbmssVOrwSsiV@yuki.lan>
 <20260222202158.GA417048@pevik>
To: Petr Vorel <pvorel@suse.cz>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/6] doc: INSTALL: dma_thread_diotest.c: Remove
 runltp from doc
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cj4gT24gRmViIDIyLCAyMDI2LCBhdCAxMjoyMeKAr1BNLCBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4gCj4+IEhpIQo+Pj4+Pj4+IEBAIC0xMDUsOSArMTA1LDkgQEAgUXVpY2sg
U3RhcnQKPj4+Pj4+PiAJJCAuL2NvbmZpZ3VyZQo+Pj4+Pj4+IAkkIG1ha2UgYWxsCj4+Pj4+Pj4g
CSMgbWFrZSBpbnN0YWxsCj4+Pj4+PiAgICAgICAgXgo+Pj4+Pj4gCVRoaXMgc2hvdWxkIGJlICQg
KG5vdCBjYXVzZWQgYnkgdGhpcyBwYXRjaCBidXQgd29ydGggZml4aW5nKQo+IAo+Pj4+PiBJIGNh
biBjaGFuZ2UgaXQsIGJ1dCBJTUhPIGZvciBjcmVhdGluZyAvb3B0L2x0cCBpcyBuZWVkZWQgdG8g
cnVuIGl0IGFzIHJvb3QKPj4+Pj4gZm9yIGEgZmlyc3QgdGltZS4gT3Igb25lIG11c3QgY2htb2Qv
Y2hvd24gL29wdC9sdHAgdW5kZXIgcm9vdC4KPiAKPj4+PiBIdWg/IFRoZSBtYWtlIGluc3RhbGwg
c2hvdWxkIGp1c3Qgd29yayBmaW5lLiBJJ20ganVzdCBwb2ludGluZyBvdXQgdGhlCj4+Pj4gdHlw
byAjIHZzICQuIE9yIGRpZCBJIG1pc3Mgc29tZXRoaW5nPwo+IAo+Pj4gWWVhaCwgSSB1bmRlcnN0
YW5kIGl0IGFuZCBwbGFuIHRvIGNoYW5nZSAjID0+ICQuIEkgdGFsa2VkIGFib3V0IC9vcHQgKG91
cgo+Pj4gZGVmYXVsdCBwcmVmaXgpIHVzdWFsbHkgbm90IGJlaW5nIHdyaXRhYmxlIGJ5IHJlZ3Vs
YXIgdXNlcnMgKGluc3RhbGxpbmcgYW55Cj4+PiBzb2Z0d2FyZSB1c2luZyBzdGFuZGFyZCBzeXN0
ZW0gcHJlZml4IHdpbGwgaGF2ZSB0aGlzIHByb2JsZW0pLiBSb290IGlzIG5lZWRlZAo+Pj4gb25s
eSBmb3IgY3JlYXRpbmcgL29wdC9sdHAuIFRoYXQgd2FzIHRoZSByZWFzb24gZm9yIHRoZSBvcmln
aW5hbCB1c2VyIHRvIHVzZSAnIycuCj4+PiBCdXQgYXMgSSB3cm90ZSwgSSdtIG9rIHRvIGNoYW5n
ZSB0aGUgcHJvbXB0Lgo+IAo+PiBBaCwgdGhhdCdzIGEgYml0IGNvbmZ1c2luZyB0aGVuIGJlY2F1
c2UgaW4gc2hlbGwgc2NyaXB0ICMgaXMgYSBjb21tZW50Lgo+PiBJIHVzdWFsbHkgcHJlZml4IGNv
bW1hbmRzIHRoYXQgbmVlZHMgcm9vdCB3aXRoIHN1ZG8gaW5zdGVhZC4gU28gd2hhdAo+PiBhYm91
dCAiJCBzdWRvIG1ha2UgaW5zdGFsbCIgPwo+IAo+ICsxLCBnb29kIHBvaW50Lgo+IEknbGwgbWVy
Z2Ugd2hvbGUgcGF0Y2hzZXQgd2l0aCB0aGlzIGNoYW5nZSB0b21vcnJvdy4KClVzaW5nIG1hcmtk
b3duIGFuZCBzdWRvIHdvdWxkIG1ha2UgaXQgdW5hbWJpZ3VvdXMuIEnigJltIG5vdCBzdXJlIGlm
IG1hcmtkb3duIG1ha2VzIHNlbnNlIGhlcmUsIGJ1dCBhdCB0aGUgdmVyeSBsZWFzdCBJIHdvdWxk
IHJlZmVyZW5jZSBzdWRvIG9yIG1hZGUgdGhlIGRpcmVjdGlvbnMgZXhwbGljaXRseSBzdGF0ZSB0
aGF0IHRoZSBjb21tYW5kIG11c3QgYmUgcnVuIGFzIHJvb3QuCgpKdXN0IG15IDIgY2VudHMuLi4K
LUVuamkKCkV4YW1wbGU6CgpgYGBiYXNoCiQgLi9jb25maWd1cmUKJCBtYWtlIGFsbAokIHN1ZG8g
bWFrZSBpbnN0YWxsCmBgYAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
