Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490CBCFD364
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 09:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764064670; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Vl+W6iVyEdyQQyakbdQlXTB+VLMLlVGsyYUbDKBdI2k=;
 b=o8iMIKfxvSXbWoHuM34gNjdGmBNTWsqNYbdyhOyq3iTHNDYVwNCPR4+pG61EDxTj656t6
 qb3AdKqTapaht6hD5J/JbW2JW5hrb0zBXbv5XatxMxVAH4WCVtLGDJj2PW94a3rfhAjpgHn
 C7smsYk17tQ70lQC05Szm/bedI7yk+Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C42FF3CD3E5
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 10:57:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 976743CBEC7
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 10:57:30 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 534A21400BD5
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 10:57:29 +0100 (CET)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6431b0a1948so8568732a12.3
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 01:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1764064649; x=1764669449; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h0rocmVE+34XHlA0Bg6/uP+SfP+/FFvTK0076zR4O3I=;
 b=EpoNmXbwF5K6Gk7dGZh1R9wQ9ooVWmMN2Jb57PaHTt0FQ4WON3OyaTSZuaWClvkF01
 HZAZiYNKOJjLqdDolgsEd0F3y9E03bc75UW77hpx5MNgEnC9AyAt1ukKpR/AoWqAxKa9
 AvggBZ4YnQmFNdJMxwAxnjtDVipJ2xEd7k7mKnkGmUWR7LnS4RqbIkFhe6WNwIja/ZDV
 /COgtGZExyzdBgKD1r6Q3+u+N/Htp8Jsos+cjc+tDdJ2QqgCCPWpVG4yFLhSU/y25GGa
 QXepZRoFNQM0UZfRoUeAzgyX7+4n4zhJcsbQS8JEmEUrPKWVvL5YEQxQupJmvBEQoFlX
 Q4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764064649; x=1764669449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0rocmVE+34XHlA0Bg6/uP+SfP+/FFvTK0076zR4O3I=;
 b=cS5ore3lVzssf0QUunEdws40Ae+DbP3C14RKHczfUuFkq8urcIXWuufVWzx5bMT8a4
 zpBsyg6GvEw53YX/do51jGRmyWRmsf+YCD9rUiDulaBGpcY3jo/AJNWkzYm7EJC/RGZw
 glyL1cdGe3aan78+QG680EjRIor2Crw/hkMKh7qotWMogLaJaK+y4uCfw9uyMYLE3yZ6
 t71FERbf5GnAxeh0CXTxjZG0z3zByelmRyr/Q3b+q4KkJdxKALqJMmXhIzt/1SQboppz
 qwGA+KBel/pGU4piSGUGQwkWql1soPGB/wCB4TIiSP4qGVfIOcf6GWxz4tnyrfKzRujZ
 Ewag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmiZahb2VGAaxMs9KvH74ZMATH3pLF+6HXhJe8kyKhpuL1VEjdrUL/JuvOptUn8ijcpNk=@lists.linux.it
X-Gm-Message-State: AOJu0Yxo2apqFHj5q/lBCPyCJ1LFUVng0Uq0m9KSRUdR26Qq/td2HvBR
 bPQgBZBLmghh+BhDRpXZqpU4yBmTY9OBQEJkN7oPdYufjblvbKvGnrFo4ZW7tkG7wzob1cxMT9j
 /qZR7FrAy9pq3CjYMrKmJMItIXc7ryKc0LqXTJ5yYNlJYhpfp836MlQ==
X-Gm-Gg: ASbGncv3JNn9MO/ZulkXT6FHK5cKkU2d59+jtpTh3lkqWszLvxFnxXw87Sx/Sj6vyQk
 rf66UbWkW19D4gMkoPZHhK5DWd+ykKZnyHv9YkaK2TAWGGIRuJ9SYHdVqgUhaq6/0OgGo2+1r2E
 sbgkVi4v0AIfnCfqtGkpJMjWP3H5dtsY1B8Z3iW1Lyx3n5txcjeQjdEEGw0/YyFiA91CxQ3CEtM
 hwEdbs1p2xw+OpMjh6N1SHygAw3HAyGbgkZyHC3kqjIj7hTp5KmdNu8nyNCHGq0F7GRVwU=
X-Google-Smtp-Source: AGHT+IE+KLv6Il0yliE9Y92EDjOF+ojjJCHO/QakSnBY9MxKC+8a0fsy36PzvLSCZZEk1kSUgxHUh0XOUfAb5msoGgo=
X-Received: by 2002:a17:907:3ea3:b0:b73:9792:918b with SMTP id
 a640c23a62f3a-b76c5514ebcmr242386066b.27.1764064648600; Tue, 25 Nov 2025
 01:57:28 -0800 (PST)
MIME-Version: 1.0
References: <202511251629.ccc5680d-lkp@intel.com>
In-Reply-To: <202511251629.ccc5680d-lkp@intel.com>
Date: Tue, 25 Nov 2025 17:57:21 +0800
X-Gm-Features: AWmQ_blkbgg0K-sM1kYvj15gcQrxv6lVWt6Fy8EKo1BpWNkJi3BXmKFgaYuRfTw
Message-ID: <CAJs-1pWJRo5UfFehbeqjRckh3D3wrgQ++ggp+6JPBM8VdGvudg@mail.gmail.com>
To: kernel test robot <oliver.sang@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [linus:master] [fs/namespace] 78f0e33cd6:
 ltp.listmount04.fail
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 lkp@intel.com, linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev,
 Andrei Vagin <avagin@google.com>, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkKCkkgZ3Vlc3MgTFRQIGZhaWxlZCBtZXNzYWdlIGlzICJsaXN0bW91bnQwNC5jOjEyODogVEZB
SUw6IGludmFsaWQKbW50X2lkX3JlcS5zcGFyZSBleHBlY3RlZCBFSU5WQUw6IEVCQURGICg5KSAi
ID8gIFNpbmNlIGkgaGF2ZSBub3QgZmluZCBMVFAKZmFpbHVyZSBsb2cgaW4gdGhpcyBlbWFpbCB0
aHJlYWQuCgpCYXNlIG9uIGtlcm5lbCBjaGFuZ2UgcmVtb3ZlIHNwYXJlIGFuZCBhZGQgbmV3IG1u
dF9uc19mZCogYnV0IExUUApsaXN0bW91bnQwNCBzdGlsbCBzZXQgc3BhcmUuKgoqSSBzdXBwb3Nl
IExUUCBjYXNlIG5lZWQgdXBkYXRlIGJhc2UgbGF0ZXN0IGNoYW5nZSBvZiBrZXJuZWw/KgoKKktl
cm5lbDoqCiAgKi8KIHN0cnVjdCBtbnRfaWRfcmVxIHsKICBfX3UzMiBzaXplOwotIF9fdTMyIHNw
YXJlOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDw8PDw8PDwKKyBfX3UzMiBt
bnRfbnNfZmQ7ICAgICAgICAgICAgICAgICAgICAgICAgICA8PDw8PDw8PAogIF9fdTY0IG1udF9p
ZDsKICBfX3U2NCBwYXJhbTsKICBfX3U2NCBtbnRfbnNfaWQ7CgpMVFAgY2FzZToKIHsKLnJlcV91
c2FnZSA9IDEsCi5zaXplID0gTU5UX0lEX1JFUV9TSVpFX1ZFUjAsCi5zcGFyZSA9IC0xLCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8PDw8PDw8Ci5tbnRfaWQg
PSBMU01UX1JPT1QsCi5tbnRfaWRzID0gbW50X2lkcywKLm5yX21udF9pZHMgPSBNTlRfU0laRSwK
LmV4cF9lcnJubyA9IEVJTlZBTCwKLm1zZyA9ICJpbnZhbGlkIG1udF9pZF9yZXEuc3BhcmUiLAp9
LAoKVGhhbmtzLgpSZWdhcmRzCkdhbyBXZWkKCk9uIFR1ZSwgTm92IDI1LCAyMDI1IGF0IDQ6MzTi
gK9QTSBrZXJuZWwgdGVzdCByb2JvdCA8b2xpdmVyLnNhbmdAaW50ZWwuY29tPgp3cm90ZToKCj4K
Pgo+IEhlbGxvLAo+Cj4ga2VybmVsIHRlc3Qgcm9ib3Qgbm90aWNlZCAibHRwLmxpc3Rtb3VudDA0
LmZhaWwiIG9uOgo+Cj4gY29tbWl0OiA3OGYwZTMzY2Q2YzkzOWE1NTVhYTgwZGJlZDJmZWM2YjMz
M2E3NjYwICgiZnMvbmFtZXNwYWNlOiBjb3JyZWN0bHkKPiBoYW5kbGUgZXJyb3JzIHJldHVybmVk
IGJ5IGdyYWJfcmVxdWVzdGVkX21udF9ucyIpCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9jZ2l0
L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0IG1hc3Rlcgo+Cj4gW3Rlc3QgZmFp
bGVkIG9uICAgICAgbGludXMvbWFzdGVyIGZkOTUzNTdmZDhjNjc3OGFjN2RlYTZjNTdhMTliOGIx
ODJiNmU5MWZdCj4gW3Rlc3QgZmFpbGVkIG9uIGxpbnV4LW5leHQvbWFzdGVyIGQ3MjRjNmY4NWU4
MGEyM2VkNDZiN2ViYzZlMzhiNTI3YzA5ZDY0ZjVdCj4KPiBpbiB0ZXN0Y2FzZTogbHRwCj4gdmVy
c2lvbjoKPiB3aXRoIGZvbGxvd2luZyBwYXJhbWV0ZXJzOgo+Cj4gICAgICAgICBkaXNrOiAxU1NE
Cj4gICAgICAgICBmczogYnRyZnMKPiAgICAgICAgIHRlc3Q6IHN5c2NhbGxzLTA2L2xpc3Rtb3Vu
dDA0Cj4KPgo+Cj4gY29uZmlnOiB4ODZfNjQtcmhlbC05LjQtbHRwCj4gY29tcGlsZXI6IGdjYy0x
NAo+IHRlc3QgbWFjaGluZTogNCB0aHJlYWRzIDEgc29ja2V0cyBJbnRlbChSKSBDb3JlKFRNKSBp
My0zMjIwIENQVSBAIDMuMzBHSHoKPiAoSXZ5IEJyaWRnZSkgd2l0aCA4RyBtZW1vcnkKPgo+IChw
bGVhc2UgcmVmZXIgdG8gYXR0YWNoZWQgZG1lc2cva21zZyBmb3IgZW50aXJlIGxvZy9iYWNrdHJh
Y2UpCj4KPgo+Cj4gSWYgeW91IGZpeCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21t
aXQgKGkuZS4gbm90IGp1c3QgYSBuZXcKPiB2ZXJzaW9uIG9mCj4gdGhlIHNhbWUgcGF0Y2gvY29t
bWl0KSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFncwo+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0
ZXN0IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRlbC5jb20+Cj4gfCBDbG9zZXM6Cj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvb2UtbGtwLzIwMjUxMTI1MTYyOS5jY2M1NjgwZC1sa3BAaW50ZWwuY29t
Cj4KPiAyMDI1LTExLTIwIDIxOjM1OjA5IGV4cG9ydCBMVFBfUlVOVElNRV9NVUw9Mgo+IDIwMjUt
MTEtMjAgMjE6MzU6MDkgZXhwb3J0IExUUFJPT1Q9L2xrcC9iZW5jaG1hcmtzL2x0cAo+IDIwMjUt
MTEtMjAgMjE6MzU6MDkga2lyayAtVSBsdHAgLWYgdGVtcF9zaW5nbGVfdGVzdCAtZCAvZnMvc2Ri
MS90bXBkaXIKPiBIb3N0IGluZm9ybWF0aW9uCj4KPiAgICAgICAgIEhvc3RuYW1lOiAgIGxrcC1p
dmItZDA0Cj4gICAgICAgICBQeXRob246ICAgICAzLjEzLjUgKG1haW4sIEp1biAyNSAyMDI1LCAx
ODo1NToyMikgW0dDQyAxNC4yLjBdCj4gICAgICAgICBEaXJlY3Rvcnk6ICAvZnMvc2RiMS90bXBk
aXIva2lyay5yb290L3RtcDlrOHJmd3IyCj4KPiBDb25uZWN0aW5nIHRvIFNVVDogZGVmYXVsdAo+
Cj4gU3RhcnRpbmcgc3VpdGU6IHRlbXBfc2luZ2xlX3Rlc3QKPiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KPiAgWzE7MzdtbGlzdG1vdW50MDQ6ICBbMG0gWzE7MzFtZmFpbCBbMG0g
ICgwLjAxNnMpCj4KPiBFeGVjdXRpb24gdGltZTogMC4wODVzCj4KPiAgICAgICAgIFN1aXRlOiAg
ICAgICB0ZW1wX3NpbmdsZV90ZXN0Cj4gICAgICAgICBUb3RhbCBydW5zOiAgMQo+ICAgICAgICAg
UnVudGltZTogICAgIDAuMDE2cwo+ICAgICAgICAgUGFzc2VkOiAgICAgIDcKPiAgICAgICAgIEZh
aWxlZDogICAgICAxCj4gICAgICAgICBTa2lwcGVkOiAgICAgMAo+ICAgICAgICAgQnJva2VuOiAg
ICAgIDAKPiAgICAgICAgIFdhcm5pbmdzOiAgICAwCj4gICAgICAgICBLZXJuZWw6ICAgICAgTGlu
dXggNi4xOC4wLXJjMS0wMDExOS1nNzhmMGUzM2NkNmM5ICMxIFNNUAo+IFBSRUVNUFRfRFlOQU1J
QyBGcmkgTm92IDIxIDA0OjU5OjM2IENTVCAyMDI1Cj4gICAgICAgICBNYWNoaW5lOiAgICAgdW5r
bm93bgo+ICAgICAgICAgQXJjaDogICAgICAgIHg4Nl82NAo+ICAgICAgICAgUkFNOiAgICAgICAg
IDY5MDA2NjAga0IKPiAgICAgICAgIFN3YXA6ICAgICAgICAwIGtCCj4gICAgICAgICBEaXN0cm86
ICAgICAgZGViaWFuIDEzCj4KPiBEaXNjb25uZWN0aW5nIGZyb20gU1VUOiBkZWZhdWx0Cj4gU2Vz
c2lvbiBzdG9wcGVkCj4KPgo+Cj4gVGhlIGtlcm5lbCBjb25maWcgYW5kIG1hdGVyaWFscyB0byBy
ZXByb2R1Y2UgYXJlIGF2YWlsYWJsZSBhdDoKPgo+IGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBk
YXktY2kvYXJjaGl2ZS8yMDI1MTEyNS8yMDI1MTEyNTE2MjkuY2NjNTY4MGQtbGtwQGludGVsLmNv
bQo+Cj4KPgo+IC0tCj4gMC1EQVkgQ0kgS2VybmVsIFRlc3QgU2VydmljZQo+IGh0dHBzOi8vZ2l0
aHViLmNvbS9pbnRlbC9sa3AtdGVzdHMvd2lraQo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+CgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
