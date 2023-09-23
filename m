Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FFECE7A89
	for <ltp@archiver.kernel.org>; Sat, 23 Sep 2023 12:21:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AA343CBDEB
	for <ltp@archiver.kernel.org>; Sat, 23 Sep 2023 14:20:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E01753C9D2C
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 14:20:48 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E15F51A008A1
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 14:20:47 +0200 (CEST)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a707bc2397so533299b6e.0
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695471646; x=1696076446; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=um9xgbaHyySoRoseN+kz54B+q26/k91sykCvqW6PPjM=;
 b=I4CxftKPKUxePkAfiFdsL74lqmGRXfublu7ff0hawkv16T66+pkI/NvFZaCoJ0wkdQ
 R54ICPy+px041J+v8xPkFkcjsZ/FRLC/vDAcQ0/qvI6wuUJtN0Djsu/oZUmUX1OXkLiH
 E0EOsrFy9/HybfIqOmTABZWf9KC8GPmntiWSF1xGm1BsfWox/xFE3jcjniYRE91i2E3X
 hiXrbp8VZgWT4UHXpOXlWNKnbwZMf+RSlnD5wK2NiMqgAM1lhGgih/q/1RL0LgnjTXW+
 mscswTUcVtQlVyj4f4LdtuG1Dymd7hJ8Zc7r1Y+rrliD2WOvryu9lO1JCPXBe8QHPLoO
 YzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695471646; x=1696076446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=um9xgbaHyySoRoseN+kz54B+q26/k91sykCvqW6PPjM=;
 b=McAxpoGvZ5pe0RUY3/NXnn3BmZsGAUfGxlqf5WgUn7Knysi+sZ8w9f/GBXJ9slOm1C
 grxTF/k6uanJNC+K4E/kj2JCloCAGmmEoyJywASe1EpBJeWCz2J/Oe8PVsWpZmti5NjK
 IZRLCcWuAHpVn83LuQDTFtgDHA+YkvjFVydDzDIPuxn2XtEc4JvIOZ9jl+DmSJpsv8GM
 SJUWTi0Jj4V8jNx/huNpA3PRn4RobOuQ4QUm5Z3NHatG/IcH6cwjioV5SItuHHqSjVqR
 aymF+rC2rLZNom8yg/xSSEGcul9ca5OTeo1XeIVQEis8780ABEtKDszn73hcG+I9b1lD
 mqAA==
X-Gm-Message-State: AOJu0YyzDrTBrwVNVVggmiFGgFa/RUceE9NJKBfOuOJieb6avvXk31S1
 R/xybNEsmgmd+aooAjJyyUVUJu1VNt8rhtEF7LA=
X-Google-Smtp-Source: AGHT+IGCLxDCGrgbleZXK1TuvqPg0Z/i2Osx8Q9k/cOc6GKUx5zjtltLs9x/u8hJqNXA5P7NeAhvJRjmgbxDc5IjNWY=
X-Received: by 2002:a05:6808:14d4:b0:3ad:f535:7e9a with SMTP id
 f20-20020a05680814d400b003adf5357e9amr2294166oiw.5.1695471646615; Sat, 23 Sep
 2023 05:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
In-Reply-To: <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
From: Reuben Hawkins <reubenhwk@gmail.com>
Date: Sat, 23 Sep 2023 07:20:35 -0500
Message-ID: <CAD_8n+SDoqUhR1+Gx15vOB5OvUL3eT5-UJb7JXOuRxVdrid5qA@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com, willy@infradead.org,
 oe-lkp@lists.linux.dev, kernel test robot <oliver.sang@intel.com>,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU2F0LCBTZXAgMjMsIDIwMjMgYXQgMTI6NTbigK9BTSBBbWlyIEdvbGRzdGVpbiA8YW1pcjcz
aWxAZ21haWwuY29tPiB3cm90ZToKCj4gT24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMTE6MjnigK9Q
TSBSZXViZW4gSGF3a2lucyA8cmV1YmVuaHdrQGdtYWlsLmNvbT4KPiB3cm90ZToKPiA+Cj4gPgo+
ID4KPiA+IE9uIEZyaSwgU2VwIDIyLCAyMDIzIGF0IDQ6MDnigK9BTSBDeXJpbCBIcnViaXMgPGNo
cnViaXNAc3VzZS5jej4gd3JvdGU6Cj4gPj4KPiA+PiBIaSEKPiA+PiA+IGFjay4gIFdpbGwgdHJ5
IHRvIHRlc3QuICBNeSBVYnVudHUgMjIuMDQgc3lzdGVtIHdhc24ndCBhYmxlIHRvIGZpbmQKPiA+
PiA+IHBhY2thZ2VzIGNhbGxlZAo+ID4+ID4gZm9yIGJ5IHRoZSB0ZXN0IGNhc2UsIHNvIGl0J2xs
IHRha2UgbWUgYSBsaXR0bGUgd2hpbGUgdG8gZmlndXJlIG91dAo+IGhvdyB0bwo+ID4+ID4gZ2V0
IHRoZQo+ID4+ID4gdGVzdCBjYXNlIHdvcmtpbmcuLi4KPiA+Pgo+ID4+IEh1aD8gVGhlIHRlc3Qg
aXMgYSBzaW1wbGUgQyBiaW5hcnkgeW91IHNob3VsZG4ndCBuZWVkIGFueXRoaW5nIG1vcmUKPiA+
PiB0aGFuOgo+ID4+Cj4gPj4gJCBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRl
c3QtcHJvamVjdC9sdHAuZ2l0Cj4gPj4gJCBjZCBsdHAKPiA+PiAkIG1ha2UgYXV0b3Rvb2xzCj4g
Pj4gJCAuL2NvbmZpZ3VyZQo+ID4+Cj4gPj4gJCBjZCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3JlYWRhaGVhZAo+ID4+ICQgbWFrZQo+ID4+ICQgLi9yZWFkYWhlYWQwMQo+ID4+Cj4gPj4gQW5k
IHRoaXMgaXMgd2VsbCBkZXNjcmliZWQgaW4gdGhlIHJlYWRtZSBhdDoKPiA+Pgo+ID4+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwLwo+ID4+Cj4gPj4gQW5kIHRoZSBw
YWNrYWdlcyByZXF1aXJlZCBmb3IgdGhlIGNvbXBpbGF0aW9uIGFyZSBtYWtlLCBDIGNvbXBpbGVy
IGFuZAo+ID4+IGF1dG90b29scyBub3RoaW5nIGV4dHJhb3JkaW5hcnkuCj4gPj4KPiA+IEF3ZXNv
bWUuICBUaGF0IHdhcyBzaW1wbGVyIHRoYW4gd2hhdGV2ZXIgaXQgd2FzIEkgd2FzIHRyeWluZy4g
IEkndmUKPiA+IHJlcHJvZHVjZWQgdGhlIGZhaWxlZCB0ZXN0IGFuZCB3aWxsIHRyeSBhIGZldyB2
YXJpYXRpb25zIG9uIHRoZSBwYXRjaC4KPgo+IENvb2wuCj4KPiBGb3IgcGVvcGxlIHRoYXQgd2Vy
ZSBub3QgZm9sbG93aW5nIHRoZSBwYXRjaCByZXZpZXcsCj4gdGhlIGdvYWwgaXMgbm90IHRvIHBh
c3MgdGhlIGV4aXN0aW5nIHRlc3QuCj4KPiBXZSBkZWNpZGVkIHRvIGRlbGliZXJhdGVseSB0cnkg
dGhlIGNoYW5nZSBvZiBiZWhhdmlvcgo+IGZyb20gRUlOVkFMIHRvIEVTUElQRSwgdG8gYWxpZ24g
d2l0aCBmYWR2aXNlIGJlaGF2aW9yLAo+IHNvIGV2ZW50dWFsbHkgdGhlIExUUCB0ZXN0IHNob3Vs
ZCBiZSBjaGFuZ2VkIHRvIGFsbG93IGJvdGguCj4KPiBJdCB3YXMgdGhlIHRlc3QgZmFpbHVyZSBv
biB0aGUgc29ja2V0IHRoYXQgYWxhcm1lZCBtZS4KPiBIb3dldmVyLCBpZiB3ZSB3aWxsIGhhdmUg
dG8gc3BlY2lhbCBjYXNlIHNvY2tldCBpbgo+IHJlYWRhaGVhZCgpIGFmdGVyIGFsbCwgd2UgbWF5
IGFzIHdlbGwgYWxzbyBzcGVjaWFsIGNhc2UKPiBwaXBlIHdpdGggaXQgYW5kIHJldGFpbiB0aGUg
RUlOVkFMIGJlaGF2aW9yIC0gbGV0J3Mgc2VlCj4gd2hhdCB5b3VyIGZpbmRpbmdzIGFyZSBhbmQg
ZGVjaWRlLgo+Cj4gVGhhbmtzLAo+IEFtaXIuCj4KCkkgZG9uJ3Qgd2FudCB0byBjaGFuZ2UgdGhl
IGJlaGF2aW9yIG90aGVyIHRoYW4gdG8gZml4IHJlYWRhaGVhZCBvbiBibG9jawpkZXZpY2VzLiAg
SWYgd2UgY2hhbmdlIHRoZSB0ZXN0IG5vdyB3ZSdyZSBsaWtlbHkgdG8gZmluZCBvdXQgdGhhdCB3
ZSBicm9rZQpzb21lYm9keSdzIGFwcGxpY2F0aW9uIHdobyBoYXJkY29kZWQgdGhlIHJldHVybiB2
YWx1ZSBoYW5kbGluZyBvZiByZWFkYWhlYWQKdG8gbG9vayBzcGVjaWZpY2FsbHkgZm9yIHJjICE9
IEVJTlZBTC4KCkkgdGhpbmsgbXkgdjEgcGF0Y2gsIGluIHRoaXMgcmVnYXJkLCBpcyBiZXR0ZXIg
dGhhbiB0aGUgdjIgcGF0Y2guICBJdApkb2Vzbid0CmJyZWFrIHRoZSB0ZXN0LiAgSXQgZG9lc24n
dCBtYWtlIHRoZSByZWFkYWhlYWQgbWFuIHBhZ2Ugd3JvbmcuICAgQW5kIGl0CmZpeGVzCnJlYWRh
aGVhZCBvbiBibG9jayBkZXZpY2VzLiAgIC4uLmhvd2V2ZXIgSSB0aGluayBJIGhhZCBhIHR5cG8g
aW4gdGhlIHYxCnBhdGNoLApzbyBJIHRoaW5rIHdoYXQgSSdsbCBkbyBpcyByZXN1Ym1pdCB0aGUg
djEgcGF0Y2ggYXMgdjMgd2l0aCB0aGUgdHlwb2VzCmZpeGVkLgpJIHRoaW5rIEkgaGFkIEZfSVNS
RUcgdnMgU19JU1JFRyBpbiBhIGNvdXBsZSBwbGFjZXMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLgoK
LVJldWJlbgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
