Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA894C072A2
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 23:40:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90D053CE495
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 00:40:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2F123CC552
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 00:40:37 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F1C631401653
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 00:40:35 +0100 (CET)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-280cd4e6f47so31520a91.1
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 15:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1700091634;
 x=1700696434; darn=lists.linux.it; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cWg5Hn1E/609SGPlJy9KPsKFooS/sbFkbzTd17ebLc=;
 b=pPVH64JOwgdoAv98hhOSfYd7V2akl43k2XX/Y/03O0kia+vPVAzRJ3KhVDTDTzVrOg
 Bfia7e/wejoMic7IfD8pGZaM7zp4utwwOyQQalv3b4W+bVMNoqcn0siuVMmPgCoa7A2M
 MKmlwd6uKSkWbJFo7pIMoujkEdlqKkaXn0gBAqt2d6W4q7vj81EebkQpMdk4vzWYNFFQ
 weoScRExUJfCKxN80hXOH5z/kwvjhMuA5O6t9wbvxL9OiTd4Zn1Evx1dHybBZHO12wq0
 SVaqe5n013qk6K/SxXkZn1GkNJLUhQDaj6CSNQC9sldeP3/Cgor+ezSw+NBjCPgKDY0t
 bQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700091634; x=1700696434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6cWg5Hn1E/609SGPlJy9KPsKFooS/sbFkbzTd17ebLc=;
 b=M5uUmd/+DivZSzY63bkPA0UvdK4d5DQrIxr6x6bwjTPD/3doG2/CxDz+HB6VLs/YLJ
 iSFKXrA/0nt7JNsMgc3FQqyg9vylFG2J0zeGOpAGoOjdm+ApYmYgmpFHi4lKoj3DntPu
 3EGUi83qvRMb6GjXd4otwm8LD6S5ZMSV2XMg0BSynKpTHIx3LiN4mjIcmP7EXz2cuCwb
 JJWiTzAW6GQ+GdPfjzCVVE7ciRo46Ado3cewol04vdiFlRd/mtT94mh+3epeCuX5+XTH
 yJls0Kmj+0G1ZCHxNeCeK2nJTJn/Xk1idjyTP+0v1mGbaFrpTEnOL5/Dn9LK7duJ5yLb
 xpzg==
X-Gm-Message-State: AOJu0YwUFOZq8mTar5CLK+XK+/ICnVgio7yXzMVHgcwsAj0YJIkVKpxL
 xldcAx1ItPeqBNZBcXqmlua4zqjHB3j+pkvWmnNZEg==
X-Google-Smtp-Source: AGHT+IFbHk5XL+JV/m1pR5gXNPRBXaCOuOo40xrKMtyJp2F5eDXp2ffCTsyDKJU0dT++xmf4AA70ZlLfgLYE+zB2wF4=
X-Received: by 2002:a17:90b:d96:b0:280:a26f:5860 with SMTP id
 bg22-20020a17090b0d9600b00280a26f5860mr6933972pjb.1.1700091634069; Wed, 15
 Nov 2023 15:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20231114123140.1144-1-mdoucha@suse.cz>
 <20231114123140.1144-6-mdoucha@suse.cz>
 <20231114153907.GA2357693@pevik>
 <CAC+q_wXvSSgeXWQNk7pbmEU5SbmvBvKtumtFB9io1wwFnXjwHQ@mail.gmail.com>
 <42d14d08-84a7-4f0e-bad9-e3e54ff1858a@suse.cz>
In-Reply-To: <42d14d08-84a7-4f0e-bad9-e3e54ff1858a@suse.cz>
From: =?UTF-8?B?5rKz5Y6f6aKv5aSq?= <souta.kawahara@miraclelinux.com>
Date: Thu, 16 Nov 2023 08:39:57 +0900
Message-ID: <CAC+q_wVMUBBEiR1chR7qX6NCD4Mq_ftxbkUjA=jihogG9SqO+g@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] Add test for CVE 2023-31248
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

SGkgTWFydGluLAoKMjAyM+W5tDEx5pyIMTbml6Uo5pyoKSAyOjM0IE1hcnRpbiBEb3VjaGEgPG1k
b3VjaGFAc3VzZS5jej46Cj4KPiBIaSwKPgo+IE9uIDE1LiAxMS4gMjMgODo0Mywg5rKz5Y6f6aKv
5aSqIHdyb3RlOgo+ID4gSGkgTWFydGluLCBQZXRyLgo+ID4KPiA+Cj4gPiAyMDIz5bm0MTHmnIgx
NeaXpSjmsLQpIDA6MzkgUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Ogo+ID4+Cj4gPj4gSGkg
TWFydGluLAo+ID4+Cj4gPj4gLi4uCj4gPj4+ICsrKyBiL3Rlc3RjYXNlcy9uZXR3b3JrL2lwdGFi
bGVzL25mdDAyLmMKPiA+PiAuLi4KPiA+Pj4gKy8qIENoYWluIGNyZWF0aW9uIGFuZCBkZWxldGlv
biBjb25maWcgKi8KPiA+Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgdHN0X25ldGxpbmtfYXR0cl9s
aXN0IG5ld2NoYWluX2NvbmZpZ1tdID0gewo+ID4+PiArICAgICB7TkZUQV9UQUJMRV9OQU1FLCBU
QUJOQU1FLCBzdHJsZW4oVEFCTkFNRSkgKyAxLCBOVUxMfSwKPiA+Pj4gKyAgICAge05GVEFfQ0hB
SU5fTkFNRSwgQ0hBSU5OQU1FLCBzdHJsZW4oQ0hBSU5OQU1FKSArIDEsIE5VTEx9LAo+ID4+PiAr
ICAgICB7TkZUQV9DSEFJTl9JRCwgJmNoYWluX2lkLCBzaXplb2YoY2hhaW5faWQpLCBOVUxMfSwK
PiA+Pgo+ID4+IFVuZm9ydHVuYXRlbHkgdGhlIGN1cnJlbnQgb2xkZXN0IGRpc3Ryb3MgKExlYXAg
NDIgYW5kIFVidW50dSBCaW9uaWMpIGFyZSB0b28gb2xkCj4gPj4gZm9yIE5GVEFfQ0hBSU5fSUQs
IE5GVEFfUlVMRV9DSEFJTl9JRCwgY291bGQgeW91IHBsZWFzZSBhZGQgdGhlbSB0byBMQVBJPwo+
ID4KPiA+IEl0IHdhcyB0aGUgc2FtZSBvbiBSSEVMOCAoYW5kL29yIG90aGVyIGNsb25lIE9TKS4K
PiA+Cj4gPiBBbmQsIEkgd291bGQgbGlrZSB0byBzZWUgdGhpcyB0ZXN0IGFkZGVkIHRvIHJ1bnRl
c3QvY3ZlIGFuZCAuZ2l0aWdub3JlLgo+Cj4gWWVzLCBzb3JyeSwgSSByZWFsaXplZCB0aGF0IHNo
b3J0bHkgYWZ0ZXIgc3VibWlzc2lvbiBhbmQgd2lsbCBmaXggaXQgaW4KPiB0aGUgbmV4dCB2ZXJz
aW9uLgo+Cj4gPiBJbiBteSBwYXRjaCB2MSBhYm91dCBDVkUtMjAyMy0zMTI0OCBjaGVjayBlcnJv
ciA9PSBFTk9FTlQuIEluIHRoaXMKPiA+IGNhc2UsIHRlc3QgcmVwb3J0cyBjb3JyZWN0IHJlc3Vs
dC4KPiA+IEl0IG1heSBiZSBkaWZmaWN1bHQgdG8gaW1wbGVtZW50IHRlc3QgbGlrZSBwYXRjaCB2
MSB1c2luZyB0aGUgaW50ZXJuYWwKPiA+IHRzdF9uZXRsaW5rIEFQSSwgYnV0IHdlIHNob3VsZCBi
ZSBhd2FyZSBvZiB0aGlzIGlzc3VlLgo+Cj4gSSd2ZSByZXdyaXR0ZW4gdGhlIHRlc3QgdG8gdXNl
IEVOT0VOVCBjaGVjayB3aXRoIHRoZSB0c3RfbmV0bGluayBBUEkuCj4gTWF5IEkgY3JlZGl0IHlv
dSB3aXRoIENvLURldmVsb3BlZC1ieSBvciBTdWdnZXN0ZWQtYnkgKGNob29zZSBvbmUpPwoKR29v
ZCEgVGhhbmsgWW91IHNvIG11Y2guCkNvLURldmVsb3BlZC1ieSBpcyBiZXR0ZXIgZm9yIG1lIDop
CgpCZXN0IHJlZ2FyZHMsClNvdXRhIEthd2FoYXJhIDxzb3V0YS5rYXdhaGFyYUBtaXJhY2xlbGlu
dXguY29tPgoKCj4KPiAtLQo+IE1hcnRpbiBEb3VjaGEgICBtZG91Y2hhQHN1c2UuY3oKPiBTVyBR
dWFsaXR5IEVuZ2luZWVyCj4gU1VTRSBMSU5VWCwgcy5yLm8uCj4gQ09SU08gSUlhCj4gS3Jpemlr
b3ZhIDE0OC8zNAo+IDE4NiAwMCBQcmFndWUgOAo+IEN6ZWNoIFJlcHVibGljCj4KCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
