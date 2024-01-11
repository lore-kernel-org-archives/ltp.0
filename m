Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA67C47422
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 13:12:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 668AB3CE444
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 14:12:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B8243CB828
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 14:11:59 +0100 (CET)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3B50460094E
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 14:11:59 +0100 (CET)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-5eefd0da5c0so54092557b3.2
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 05:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704978718; x=1705583518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQ5ASUjPjhRUwAFEFid0Fjz0cuH2JwdEJzRuxsRLB6E=;
 b=Nu0NY+tt29Zgp6nYM7lgzinkqOZnTCWG0NLLAz/4QI0gu1Qxn03v4p7qDxA/uqU8Gz
 U4C98jei+iOWY4SWXUzXrSZA9+2kz2BehvB3mtddIOWqL0X/qTCJcX5RP/hWLS8qJTzy
 jUPXv18XtjBhlBX9V7JLR7Cq/+NO1hOfp49XK5lM8YWnGp2wOC6M5YRWaGvm8XGhbsxP
 h4uKKyp3ksYkjrFoMgKFEBmkq3OsRwswXLONCGK7PvpWwbSH0RwxAIYyscTKvCNX2BAs
 r6RzRsnLMAfm5yoJoMWHJjH830Wo61nshQjMW38WV+w36ajPFQXYF5x9wHoMBNzIdt9N
 mXBQ==
X-Gm-Message-State: AOJu0YwfUzndjF+1VMv8PLIVfHm2+feNK/v1kvIFbOfjlV3PkgufeoST
 G3iBRZwJEyWtVX6tD8GhI1I0AR8rJ6O2QA==
X-Google-Smtp-Source: AGHT+IH6o2tLMw1TmEuKGfHoApZBHjQYO91VkWmry8Sxd9TglDFP3IqnmqBzRmPpsq8fpVCFdpn70Q==
X-Received: by 2002:a81:b813:0:b0:5ef:317b:67ee with SMTP id
 v19-20020a81b813000000b005ef317b67eemr496921ywe.9.1704978717814; 
 Thu, 11 Jan 2024 05:11:57 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com.
 [209.85.219.170]) by smtp.gmail.com with ESMTPSA id
 i21-20020a0ddf15000000b005e739f09057sm384691ywe.121.2024.01.11.05.11.56
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 05:11:57 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id
 3f1490d57ef6-dbeff495c16so3868833276.3
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 05:11:56 -0800 (PST)
X-Received: by 2002:a25:41cf:0:b0:dbd:ab41:60d5 with SMTP id
 o198-20020a2541cf000000b00dbdab4160d5mr1033855yba.123.1704978716687; Thu, 11
 Jan 2024 05:11:56 -0800 (PST)
MIME-Version: 1.0
References: <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik> <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <20240110141455.GC1698252@pevik>
 <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
In-Reply-To: <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Jan 2024 14:11:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX5ACKVBQvEwMi7KHZkSVGZPJoocEC1wosfB7zc0u2mbA@mail.gmail.com>
Message-ID: <CAMuHMdX5ACKVBQvEwMi7KHZkSVGZPJoocEC1wosfB7zc0u2mbA@mail.gmail.com>
To: Rob Landley <rob@landley.net>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] Call for nommu LTP maintainer [was:
 Re: [PATCH 00/36] Remove UCLINUX from LTP]
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Niklas Cassel <niklas.cassel@wdc.com>, Jonathan Corbet <corbet@lwn.net>,
 Linux-sh list <linux-sh@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "buildroot@buildroot.org" <buildroot@buildroot.org>,
 Greg Ungerer <gerg@linux-m68k.org>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUm9iLAoKT24gV2VkLCBKYW4gMTAsIDIwMjQgYXQgODoxN+KAr1BNIFJvYiBMYW5kbGV5IDxy
b2JAbGFuZGxleS5uZXQ+IHdyb3RlOgo+IFlvdSBjYW4ndCBmb3JrKCkgb24gbm9tbXUgYmVjYXVz
ZSBjb3BpZXMgb2YgdGhlIG1hcHBpbmdzIGhhdmUgZGlmZmVyZW50Cj4gYWRkcmVzc2VzLCBtZWFu
aW5nIGFueSBwb2ludGVycyBpbiB0aGUgY29waWVkIG1hcHBpbmdzIHdvdWxkIHBvaW50IGludG8g
dGhlIE9MRAo+IG1hcHBpbmdzIChiZWxvbmdpbmcgdG8gdGhlIHBhcmVudCBwcm9jZXNzKSwgYW5k
IGZpeGluZyB0aGVtIHVwIGlzIDEwMCUKPiBlcXVpdmFsZW50IHRvIHRoZSAiZ2FyYmFnZSBjb2xs
ZWN0aW9uIGluIEMiIHByb2JsZW0uIChJdCdzIEFJLWNvbXBsZXRlLiBPZiB0aGUKPiBDM1BPIGtp
bmQsIG5vdCB0aGUgImF1dG9jb3JyZWN0IHdpdGggc3ludGF4IGNoZWNraW5nIiBraW5kLikgUGVv
cGxlIGdldCBodW5nIHVwCj4gb24gdGhlICJpdCB3b3VsZCBiZSB2ZXJ5IGluZWZmaWNpZW50IHRv
IGRvIHRoYXQgYmVjYXVzZSBubyBjb3B5LW9uLXdyaXRlIgo+IHByb2JsZW0gYW5kIG1pc3MgdGhl
ICJ0aGUgY2hpbGQgY291bGRuJ3QgRlVOQ1RJT04gYmVjYXVzZSBpdHMgcG9pbnRlciB2YXJpYWJs
ZXMKPiBhbGwgY29udGFpbiBwYXJlbnQgYWRkcmVzc2VzIiBwcm9ibGVtLgoKQWN0dWFsbHkgeW91
IGNhbiBpbXBsZW1lbnQgZm9yaygpLCBpZiB5b3UgdGVhY2ggdGhlIGNvbXBpbGVyIHRvIHVzZQpz
ZXBhcmF0ZSBzdGFja3MgZm9yIHJldHVybiBhZGRyZXNzZXMgYW5kIGRhdGE6CiAgLSBUaGUgZmly
c3Qgc3RhY2sgd291bGQgY29udGFpbiBvbmx5IGFic29sdXRlIGFkZHJlc3NlcywgdG8gYmUKICAg
IHJlbG9jYXRlZCBhZnRlciBjb3B5aW5nLAogIC0gVGhlIHNlY29uZCBzdGFjayB3b3VsZCBjb250
YWluIGludGVnZXJzIGFuZCByZWxhdGl2ZSBwb2ludGVycwogICAgKHNlZSBGRFBJQyBiZWxvdyks
IHdoaWNoIGRvIG5vdCBuZWVkIHJlbG9jYXRpb24gYWZ0ZXIgY29weWluZy4KCj4gVGhlIE9USEVS
IGZ1biB0aGluZyBhYm91dCBub21tdSBpcyB5b3UgY2FuJ3QgcnVuIGNvbnZlbnRpb25hbCBFTEYg
YmluYXJpZXMsCj4gYmVjYXVzZSBldmVyeXRoaW5nIGlzIGxpbmtlZCBhdCBmaXhlZCBhZGRyZXNz
LiBTbyB5b3UgbWlnaHQgYmUgYWJsZSB0byBydW4gT05FCj4gaW5zdGFuY2Ugb2YgdGhlIHByb2dy
YW0gYXMgeW91ciBpbml0IHRhc2ssIGFzc3VtaW5nIHRob3NlIGFkZHJlc3NlcyB3ZXJlCj4gYXZh
aWxhYmxlIGV2ZW4gdGhlbiwgYnV0IGFzIHNvb24gYXMgeW91IHRyeSB0byBydW4gYSBzZWNvbmQg
b25lIGl0J3MgYSBjb25mbGljdC4KPgo+IFRoZSBxdWljayBhbmQgZGlydHkgd29yayBhcm91bmQg
aXMgdG8gbWFrZSBQSUUgYmluYXJpZXMsIHdoaWNoIGNhbiByZWxvY2F0ZQo+IGV2ZXJ5dGhpbmcg
aW50byBhdmFpbGFibGUgc3BhY2UsIHdoaWNoIHdvcmtzIGJ1dCBkb2Vzbid0IHNjYWxlLiBUaGUg
cHJvYmxlbSB3aXRoCj4gRUxGIFBJRSBpcyB0aGF0IGV2ZXJ5dGhpbmcgaXMgbGlua2VkIGNvbnRp
Z3VvdXNseSBmcm9tIGEgc2luZ2xlIGJhc2UgcG9pbnRlciwKPiBtZWFuaW5nIHlvdXIgdGV4dCwg
cm9kYXRhLCBkYXRhLCBhbmQgYnNzIHNlZ21lbnRzIGFyZSBhbGwgb25lIGxpbmVhciBibG9iLiBT
byBpZgo+IHlvdSBydW4gdHdvIGluc3RhbmNlcyBvZiBiYXNoLCB5b3UndmUgbG9hZGVkIHR3byBj
b3BpZXMgb2YgdGhlIHRlc3QgYW5kIHRoZQo+IHJvZG9hdGEuIFRoaXMgZmlsbHMgdXAgeW91ciBt
ZW1vcnkgZmFzdC4KPgo+IEFORCBQSUUgcmVxdWlyZXMgY29udGlndW91cyBtZW1vcnksIHdoaWNo
IG5vbW11IGlzIGJhZCBhdCBwcm92aWRpbmcgYmVjYXVzZSBpdAo+IGhhcyBubyBwYWdlIHRhYmxl
cyB0byByZW1hcCBzdHVmZi4gV2l0aCBhbiBtbXUgaXQgY2FuIGNvYWxlc2NlIHNjYXR0ZXJlZAo+
IHBoeXNpY2FsIHBhZ2VzIGludG8gYSB2aXJ0dWFsbHkgY29udGlndW91cyByYW5nZSwgYnV0IHdp
dGhvdXQgYW4gbW11IHlvdSBjYW4KPiBoYXZlIHBsZW50eSBvZiBtZW1vcnkgZnJlZSBidXQgaW4g
dGlueSBjaHVua3MsIG5vbmUgYmlnIGVub3VnaCB0byBzYXRpc2Z5IGFuCj4gYWxsb2NhdGlvbiBy
ZXF1ZXN0Lgo+Cj4gU28gdGhleSBpbnZlbnRlZCBGRFBJQywgd2hpY2ggaXMgRUxGIHdpdGggRk9V
UiBiYXNlIHBvaW50ZXJzLiBFYWNoIG1ham9yIHNlY3Rpb24KPiAocm9kYXRhLCB0ZXh0LCBkYXRh
LCBhbmQgYnNzKSBoYXMgaXRzIG93biBiYXNlIHBvaW50ZXIsIHNvIHlvdSBuZWVkIHRvIGZpbmQK
PiBzbWFsbGVyIGNodW5rcyBvZiBtZW1vcnkgdG8gbG9hZCB0aGVtIGludG8gKGFuZCB0aHVzIGl0
IGNhbiB3b3JrIG9uIGEgbW9yZQo+IGZyYWdtZW50ZWQgc3lzdGVtKSwgQU5EIGl0IG1lYW5zIHRo
YXQgdHdvIGluc3RhbmNlcyBvZiB0aGUgc2FtZSBwcm9ncmFtIGNhbgo+IHNoYXJlIHRoZSByZWFk
LW9ubHkgc2VjdGlvbnMgKHJvZGF0YSBhbmQgdGV4dCkgc28geW91IG9ubHkgbmVlZCBuZXcgY29w
aWVzIG9mCj4gdGhlIHdyaXRlYWJsZSBzZWdtZW50cyAoZGF0YSBhbmQgYnNzLiBBbmQgdGhlIGhl
YXAuIEFuZCB0aGUgc3RhY2suKQoKT3IgQW1pZ2EgTG9hZFNlZygpIHJlbG9jYXRhYmxlIGJpbmFy
aWVzIGFuZCBzaGFyZWQgbGlicmFyaWVzIDstKQpBcyB0aGlzIHN1cHBvcnRlZCBzcGxpdHRpbmcg
Y29kZSwgZGF0YSwgYW5kIGJzcyBpbiBsb3RzIG9mIHNtYWxsZXIKaHVua3MsIGl0IGNvdWxkIGNv
dW50ZXIgZnJhZ21lbnRlZCBtZW1vcnkgcXVpdGUgd2VsbC4KCkJUVywgY2FuJ3QgeW91IHJ1biBh
bmQgdGh1cyB0ZXN0IG5vbW11LWJpbmFyaWVzIHVuZGVyIG5vcm1hbCBMaW51eCwgdG9vPwoKR3J7
b2V0amUsZWV0aW5nfXMsCgogICAgICAgICAgICAgICAgICAgICAgICBHZWVydAoKLS0gCkdlZXJ0
IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2Vl
cnRAbGludXgtbTY4ay5vcmcKCkluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmlj
YWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJJ20gdGFsa2luZyB0
byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0
aGF0LgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
