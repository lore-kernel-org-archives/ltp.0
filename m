Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C64C5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 11:18:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 768B03CF658
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 12:18:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33C1E3CD548
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 18:27:13 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D233200902
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 18:27:12 +0100 (CET)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-60821136c5aso37864417b3.1
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 09:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708622831; x=1709227631; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuKAAfod1MzHS/3JdjwE+h9Jo38lBcZP+cEWXxDIKks=;
 b=ZF0S67VNVwawEJ5+Pp3DZ0MhRUoo6xUTjDu+tGtYt7JEo+3FI++9XH0YVa3zG3K7W9
 DEjgo4akx9Pjljc8+waspxfkOad3MBpkjk9Huj6gyfeOXTLd328LBqFaBqewfzUOXXi5
 N3+4Jk324jSHMzk/O8eyBw5SpOQkBv48l6tTaxdc5u7DQolf/uPipHuoSzsY9DS4psoG
 MRxidEraeBbcLRbVG40Eql85Yz8iZNkPgk8cbcuq5WwmBAlPFq4EuNq/fLwtoP+wH9T9
 7lJGVbEZq5Kag5dXW9epbiDOZy65//RM0DxkBV7l0HZChbNfWeIjKdMMHysL/KxN5u+3
 sXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708622831; x=1709227631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QuKAAfod1MzHS/3JdjwE+h9Jo38lBcZP+cEWXxDIKks=;
 b=ItiPI20MV5Pz2aQReBQyVvlTDaC6A+JJMc1rxqAkwjMdgcMhrb/oSc1oYJUDhNpWUi
 omtr8eQjMXBvRv2xKyPWbbNeooSHDu0/OAnxhJp+5GmcLJ5exyZ+Pv0auP14uTxj3sL8
 HAcjer9Ik2SrXfAgi0J3dQMeU9AwmObOabI0j9rkD5W08idEREL4fP5QbloPGmydtVqQ
 g2pSdP9jixu1iEQM9tB8y3pqMPihbYbl95gtuGIUUOgCf5K0GiKn9BxQsWFFEJNZpWwo
 YRy3hjhFIq+S/LAtICqeqqBTLukCYsqupvsL7WOFV3CVaq8fhuDVpcUM/354glIxVUNL
 ynFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmjkmYMLYG/PV7MGil5vmkY0mz2B+blKALUrzwcm6TE0vnK1zr36Kwslso9jGU6mOO7msN2WGnePcgROlwzBcH/jU=
X-Gm-Message-State: AOJu0YyttUerlhvn/KO4AXQBkhjYa4h1FXCKhzsdSGFstxvvHWRUy6na
 oI3pwJ03PiJGptRX/lzGPnGVyvdEjYKQx0ZdrmUHMSgUfwMdnY5BD8L7kt08Z1OswHLq6iLDXnX
 8uxnE8/Uc5QdDlh0nBGWU9tX9CYU=
X-Google-Smtp-Source: AGHT+IHO8x0tadUdaQBRIMWwUXYyEOVeTnOcoN6TwMUV/UtT8moscekER2ZVB4LuPbM93z+Fy+yJhn0cyDA7Zdk1jiY=
X-Received: by 2002:a0d:d984:0:b0:608:b193:5a3e with SMTP id
 b126-20020a0dd984000000b00608b1935a3emr555773ywe.32.1708622831338; Thu, 22
 Feb 2024 09:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20240221234732.187629-1-vishal.moola@gmail.com>
 <20240221234732.187629-6-vishal.moola@gmail.com>
 <ZdbFyC6HPr6oKrM-@casper.infradead.org>
In-Reply-To: <ZdbFyC6HPr6oKrM-@casper.infradead.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 22 Feb 2024 09:27:00 -0800
Message-ID: <CAOzc2pyt=3UwRt6a8L-wJGAcQFJr_ZNeFEwiGapx9KktuYC+BQ@mail.gmail.com>
To: Matthew Wilcox <willy@infradead.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 23 Feb 2024 12:17:54 +0100
Subject: Re: [LTP] [PATCH v2 5/5] hugetlb: Allow faults to be handled under
 the VMA lock
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
Cc: muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBGZWIgMjEsIDIwMjQgYXQgNzo1NeKAr1BNIE1hdHRoZXcgV2lsY294IDx3aWxseUBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPgo+IE9uIFdlZCwgRmViIDIxLCAyMDI0IGF0IDAzOjQ3OjMy
UE0gLTA4MDAsIFZpc2hhbCBNb29sYSAoT3JhY2xlKSB3cm90ZToKPiA+IEh1Z2V0bGIgY2FuIG5v
dyBzYWZlbHkgaGFuZGxlIGZhdWx0cyB1bmRlciB0aGUgVk1BIGxvY2ssIHNvIGFsbG93IGl0IHRv
Cj4gPiBkbyBzby4KPiA+Cj4gPiBUaGlzIHBhdGNoIG1heSBjYXVzZSBsdHAgaHVnZW1tYXAxMCB0
byAiZmFpbCIuIEh1Z2VtbWFwMTAgdGVzdHMgaHVnZXRsYgo+ID4gY291bnRlcnMsIGFuZCBleHBl
Y3RzIHRoZSBjb3VudGVycyB0byByZW1haW4gdW5jaGFuZ2VkIG9uIGZhaWx1cmUgdG8KPiA+IGhh
bmRsZSBhIGZhdWx0Lgo+ID4KPiA+IEluIGh1Z2V0bGJfbm9fcGFnZSgpLCB2bWZfYW5vbl9wcmVw
YXJlKCkgbWF5IGJhaWxvdXQgd2l0aCBubyBhbm9uX3ZtYQo+ID4gdW5kZXIgdGhlIFZNQSBsb2Nr
IGFmdGVyIGFsbG9jYXRpbmcgYSBmb2xpbyBmb3IgdGhlIGh1Z2VwYWdlLiBJbgo+ID4gZnJlZV9o
dWdlX2ZvbGlvKCksIHRoaXMgZm9saW8gaXMgY29tcGxldGVseSBmcmVlZCBvbiBiYWlsb3V0IGlm
ZiB0aGVyZQo+ID4gaXMgYSBzdXJwbHVzIG9mIGh1Z2V0bGIgcGFnZXMuIFRoaXMgd2lsbCByZW1v
dmUgYSBmb2xpbyBvZmYgdGhlIGZyZWVsaXN0Cj4gPiBhbmQgZGVjcmVtZW50IHRoZSBudW1iZXIg
b2YgaHVnZXBhZ2VzIHdoaWxlIGx0cCBleHBlY3RzIHRoZXNlIGNvdW50ZXJzCj4gPiB0byByZW1h
aW4gdW5jaGFuZ2VkIG9uIGZhaWx1cmUuCj4gPgo+ID4gT3JpZ2luYWxseSB0aGlzIGNvdWxkIG9u
bHkgaGFwcGVuIGR1ZSB0byBPT00gZmFpbHVyZXMsIGJ1dCBub3cgaXQgbWF5Cj4gPiBhbHNvIG9j
Y3VyIGFmdGVyIHdlIGFsbG9jYXRlIGEgaHVnZXRsYiBmb2xpbyB3aXRob3V0IGEgc3VpdGFibGUg
YW5vbl92bWEKPiA+IHVuZGVyIHRoZSBWTUEgbG9jay4gVGhpcyBzaG91bGQgb25seSBoYXBwZW4g
Zm9yIHRoZSBmaXJzdCBmcmVzaGx5Cj4gPiBhbGxvY2F0ZWQgaHVnZXBhZ2UgaW4gdGhpcyB2bWEu
Cj4KPiBIbW0sIHNvIGl0J3MgYSBidWcgaW4gTFRQLiAgSGF2ZSB5b3UgdGFsa2VkIHRvIHRoZSBM
VFAgcGVvcGxlIGFib3V0IGl0Cj4gKGNjJ3MgYWRkZWQpPwo+Cj4gQWxzbywgZGlkIHlvdSB0cnkg
bW92aW5nIHRoZSBhbm9uX3ZtYSBjaGVjayBiZWZvciB0aGUgZm9saW8gYWxsb2NhdGlvbgo+IHNv
IHRoYXQgeW91IGNhbiBiYWlsIG91dCB3aXRob3V0IGRpc3R1cmJpbmcgdGhlIGNvdW50ZXJzPwoK
TW92aW5nIHRoZSBjaGVjayBiZWZvcmUgZm9saW8gYWxsb2NhdGlvbiBvY2N1cnMga2VlcHMgdGhl
IGZvbGlvcyBvbiB0aGUKZnJlZWxpc3Qgc28gdGhlIGNvdW50ZXJzIHJlbWFpbiBzdGF0aWMgYXMg
ZXhwZWN0ZWQuCgpJZiB3ZSBhcmUgbG9va2luZyBhdCBhIHNoYXJlYWJsZSB2bWEsIGh1Z2V0bGJf
bm9fcGFnZSgpIGRvZXMgbm90IG5lZWQKdGhpcyBjaGVjayBhdCBhbGwsIHNvIEkgbGVmdCB0aGUg
Y2hlY2sgd2hlcmUgaXQgaXMuIFdlIGNvdWxkIGRlZmluaXRlbHkgcGxhY2UKdGhlIGFub25fdm1h
IGNoZWNrIGFib3ZlIGFsbG9jYXRpb24sIGl0IHdvdWxkIGp1c3QgbWFrZSB0aGUgY29kZQpzbGln
aHRseSBtb3JlIGNvbXBsaWNhdGVkIC0gbmVlZGluZyBhbm90aGVyIHZhcmlhYmxlIChvciByZWFz
c2lnbmluZwpyZXQgaW4gdmFyaW91cyBwbGFjZXMpIGFzIHdlbGwgYXMgYWRkaW5nIGFub3RoZXIg
cG90ZW50aWFsbHkgdW5uZWNlc3NhcnkKdm1hIGZsYWcgY2hlY2suCgo+ID4gU2lnbmVkLW9mZi1i
eTogVmlzaGFsIE1vb2xhIChPcmFjbGUpIDx2aXNoYWwubW9vbGFAZ21haWwuY29tPgo+Cj4gUmV2
aWV3ZWQtYnk6IE1hdHRoZXcgV2lsY294IChPcmFjbGUpIDx3aWxseUBpbmZyYWRlYWQub3JnPgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
