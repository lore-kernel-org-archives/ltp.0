Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0723CA0EF3
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 20:58:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B4913D28B2
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 22:58:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63DCD3D282B
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 22:58:19 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0556B140004A
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 22:58:19 +0200 (CEST)
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a8130906faso67879685a.0
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725051498; x=1725656298; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7ff8p9xU4QXvucg6bcEqRKGOIWomlpUl1WTjQq5ox/k=;
 b=OkIckpCj2oEkQ3kSGGr3YQ1A3Bb+EG0wUAD/ulwYeZH2wbQJCteebOHaWnbN+7K5L1
 888NKyELGxcnuuc8P5t7YOG30CW2G1bWj7tlxUcMSlbz+qV4NSH/macukZ+7m8wFpFuH
 P2ZVm39h+GgQV7koaYbeu92u8isx/GdYLk10Ita6THwWi56u3ZZvcAbRSrZqlGEt9fmV
 AGp4ApzPMB69pbt5ZJtjwG06VO0Qk6oUeOlBs7DNczrZ4tCacC/GWfzxwPVfLLAmu27b
 R6grp1nRKAGPo/NKXrMeXSvGkeexTCx8BPHNry2Hhbn27Vn/9FPtmy8FZAQec35Li9t5
 Upgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725051498; x=1725656298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ff8p9xU4QXvucg6bcEqRKGOIWomlpUl1WTjQq5ox/k=;
 b=eTd0pHWfctEEMWMJbPUf5ojZFlhNGL4OOMLFrhEI4xHv4nr/G1hRHyeCUxO9Zrh+6e
 zlde0YJH+rz/+RNZqryU+Yen7Zen6oSxeWeOUZWnxb1GDBiLD6cmNTNUvMrIrvZlR5fj
 LG8gVAiDPFD9JXq1dF7ocYBUvf94MQ2hSnSEtD/6GTno2m9G+eeEX69gPAK5JURYQRka
 tyiLji/oyMWIZo8Ckm1y+d+2HEQ8Tntj8wVL1Fl3vhTfGamp1L7cSihsTdbwiSpmqpfF
 EaR8DcO1UBS/kX+ARI/NvpC4pTMLw9s3bJVNVk4gJr01hU9XahZQ9kcd5oYNyRB9YjH6
 FdDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQzLZKV20EApRWSzAttW3/aY6JP7/aZCzCYuqi19WdWb/PutFWcVvb1o01RPZjceCbyaw=@lists.linux.it
X-Gm-Message-State: AOJu0Ywc3aQhlT/h2eqwG8WRHL4GiOpvN3i1FSpOY5QXRIO/4y0gMxFJ
 HTseD7txQSrs1kL2/EmYzS1/tgkmIfyMgWPOh1en2P+KPawSk+2ZB6pUOAcsEIiK5llALK25EHB
 34cOz8uxzs8UNTNWE5K0ayjjOdhw=
X-Google-Smtp-Source: AGHT+IHmhWcZNACAFpZFslCTpCM/Y9q9JuYEz/RZPse3zrj0OkDfONw7KS4L7WmvIGHA3vjjQxtnOFPHayDu1JSf4r8=
X-Received: by 2002:a05:620a:1914:b0:79f:66f:9daf with SMTP id
 af79cd13be357-7a8ac3ba814mr76995785a.47.1725051497514; Fri, 30 Aug 2024
 13:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240318231603.2221376-1-sashal@kernel.org>
 <CAOQ4uxjxSQESOZVCV_yL=uwG5+Y89sYRozVSgHPpaudG4CwZqw@mail.gmail.com>
 <ACB7BCB8-E6EA-41DC-8228-881081AA0596@oracle.com>
 <20240830203501.GA94648@pevik>
In-Reply-To: <20240830203501.GA94648@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Aug 2024 22:58:08 +0200
Message-ID: <CAOQ4uxiUwSiRQ9tLPw6FPDB05rRLFdjxruFM4Lk=HcZfP2tfqA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Patch "fsnotify: consistent behavior for parent not
 watching children" has been added to the 5.15-stable tree
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
Cc: Sasha Levin <sashal@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Bobrowski <repnop@google.com>,
 Chuck Lever III <chuck.lever@oracle.com>, stable-commits@vger.kernel.org,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMzAsIDIwMjQsIDEwOjM14oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBDaHVjaywKPgo+ID4gSGkgQW1pci0KPgo+ID4gPiBPbiBNYXIgMjAs
IDIwMjQsIGF0IDI6NTfigK9BTSwgQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4K
PiB3cm90ZToKPgo+ID4gPiBQbGVhc2UgZm9sbG93IHVwIGluIGFkanVzdGluZyB0aGUgTFRQIHRl
c3QgZmFub3RpZnkwOSB0byB1cGRhdGUgdGhpcwo+ID4gPiBjb21tZW50IHdpdGggdGhlIGFwcHJv
cHJpYXRlIDUuMTUueSB2ZXJzaW9uOgo+Cj4gPiA+ICogVGVzdCBjYXNlcyAjNi0jNyBhcmUgcmVn
cmVzc2lvbiB0ZXN0cyBmb3IgY29tbWl0Ogo+ID4gPiAqIChmcm9tIHY1LjE5LCB1bmxpa2VseSB0
byBiZSBiYWNrcG9ydGVkIHRodXMgbm90IGluIC50YWdzKToKPiA+ID4gKgo+ID4gPiAqICAgICAg
ZTczMDU1OGFkZmZiIGZhbm90aWZ5OiBjb25zaXN0ZW50IGJlaGF2aW9yIGZvciBwYXJlbnQgbm90
Cj4gPiA+IHdhdGNoaW5nIGNoaWxkcmVuCj4KPiA+ID4gQXMgd2VsbCBhcyB0aGlzIGhhY2tpc2gg
dGVzdCBjb25kaXRpb246Cj4KPiA+ID4gICAgICAgIGlmICh0Yy0+aWdub3JlICYmIHRzdF9rdmVy
Y21wKDUsIDE5LCAwKSA8IDApIHsKPiA+ID4gICAgICAgICAgICAgICAgdHN0X3JlcyhUQ09ORiwg
Imlnbm9yZWQgbWFzayBvbiBwYXJlbnQgZGlyIGhhcwo+IHVuZGVmaW5lZCAiCj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAiYmVoYXZpb3Igb24ga2VybmVsIDwgNS4xOSIpOwo+
ID4gPiAgICAgICAgICAgICAgICByZXR1cm47Cj4gPiA+ICAgICAgICB9Cj4KPiA+IEknbSBub3Qg
c3VyZSBob3cgdGhpcyBjaGVjayBzaG91bGQgYmUgYWx0ZXJlZC4KPgo+ID4gVGhlIGZpeCBpbiBx
dWVzdGlvbiBub3cgYXBwZWFycyBpbiBib3RoIDUuMTAuMjIwIGFuZAo+ID4gNS4xNS4xNTQuIFdo
aWNoIG1lYW5zIHRoZSBjb21taXQgaXMgaW4sIGZvciBpbnN0YW5jZSwKPiA+IDUuMTAuMjIyIGFu
ZCA1LjE1LjE2MCwgYnV0IG5vdCBpbiA1LjEzLjAgb3IgNS4xNy4wLgo+Cj4gVGhhbmsgeW91IGZv
ciBub3RpY2luZyB0aGF0LiBUaGUgY29tbWVudCBvbiB0aGUgdGVzdCBwYXRjaCBbMV0gd2FzOgo+
Cj4gICogVGVzdCBjYXNlcyAjNi0jNyBhcmUgcmVncmVzc2lvbiB0ZXN0cyBmb3IgY29tbWl0Ogo+
ICAqIChmcm9tIHY1LjE5LCB1bmxpa2VseSB0byBiZSBiYWNrcG9ydGVkIHRodXMgbm90IGluIC50
YWdzKToKPgoKSSBzdWdnZXN0IHRvIGFkZCB0aGUgZml4IGNvbW1pdCB0byAudGFncyBhbmQgY2hh
bmdlIHRoZSBtaW5pbWFsIGtlcm5lbCBmb3IKdGVzdGluZyB0Yy0+aWdub3JlIHRvIHY1LjEwLjAK
ClRlc3Rpbmcgb24gdjUuMTMgdjUuMTcgb3Igb2xkZXIgdjUuMTAgYW5kIHY1LjE1IHdpbGwganVz
dCBzZWUgdGhlIGJ1ZyBhcwpQZXRyIHNhaWQgYW5kIGNvdWxkIGRlY2lkZSB0byB1cGdyYWRlIHRv
IG5ld2VyIExUUy4KClN0aWxsIEkgcHJlZmVyIG5vdCB0byBhZGQgdW5uZWVkZWQgbm9pc2Ugd2hl
biB0ZXN0aW5nIGtlcm5lbHMgb2xkZXIgdGhhdAp2NS4xMCBidXQgSW0gZmluZSB3aXRoIHdoYXRl
dmVyIHlvdSBjaG9zZSB0byBkby4KClRoYW5rcywKQW1pci4KCgoKPiBJIHNlZSBpbiB0aGUgZW5k
IGl0IGdvdCBiYWNrcG9ydGVkLiBOb3cgd2UgaGF2ZSB0byBkZWNpZGUgd2hldGhlciBpdCdzCj4g
aW1wb3J0YW50Cj4gZW5vdWdoIHRoYXQgd2Ugc2hvdWxkIHB1dCBjb21taXQgaW4gdGhlIHRhZyBh
bmQgcnVuIGl0IHVuY29uZGl0aW9uYWxseQo+IChwcmVmZXJyZWQgd2F5IGZvciBmaXhlcykgb3Ig
ZnJvbSB0aGUgbGF0ZXN0IHN0YWJsZSBrZXJuZWwgdmVyc2lvbiB3aGljaAo+IGdvdCB0aGUKPiBi
YWNrcG9ydC4KPgo+IEFGQUlLIExUUCBzaG91bGQgbm90IHRyeSB0byBoaWRlIGJ1Z3MsIHJlcG9y
dCBtaXNzaW5nIGZpeC4gQW5kIGl0J3MgdXAgdG8KPiB0ZXN0ZXJzIGFuZCB0aGUgcHJvamVjdHMg
aWYgdGhleSBjb25zaWRlciB0aGUgcHJvYmxlbSBhcyBXT05URklYIG9yIHRoZQo+IGtlcm5lbAo+
IHRoZXkgdGVzdCB3aWxsIGJhY2twb3J0IHRoZSBmaXguCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0
cgo+Cj4gWzFdCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjIwNjIwMTMyNzM3LjIw
MTUwNzMtNS1hbWlyNzNpbEBnbWFpbC5jb20vCj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
