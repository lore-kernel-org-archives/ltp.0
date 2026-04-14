Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA2DED7B84
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 07:55:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93D1F3E2940
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 09:55:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D44003C9917
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 09:55:35 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BF8D4600BC5
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 09:55:32 +0200 (CEST)
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-50335b926c2so40886881cf.2
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 00:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776153331; cv=none;
 d=google.com; s=arc-20240605;
 b=fDtybQ1g1BZEcKYGeOanOaeobV5fbU5eRpG8sf/xAddFArEEg2cczTSH9hEIfCZidV
 Z0pm8nwjhD1RKwb6dJVyWfRYIu7rcnnr9DmNVLmp95lICQy5TNiIy8D+ugMIrrt5Y1cj
 LRdFCzQ0EQrIV2OqStAyG7SJLprq4ZjNTTtvMAstzQ6CbYiWe5XXpDKJwN0F4ddphTfV
 I4UP3wIBgi62Uh1WwFjUuL27C0SkqRruYYAWMB+8JLxE4IgQgNDg9syf7ls05Sy6v/C4
 M+XeZWUUkxWfrsuKcQJmLXUKvJskteTvX+SXuyx38B42bVlR9g0u5n+movNvDpBUvRpc
 bBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r3v1lbZR7B0T3CnTyAOj5AXcyFefKYKLS2mh7YhIzhI=;
 fh=aMPhV77tTa2z5uuKum8HpgPo3Z5oBthlq3E9SPtHWEg=;
 b=aZMS+SbA2PbLXPlYO24lDXpekFbdyo9O1J1KcaoO55jIzNQaCviP49YTYcGkn1a8+G
 1igwn/JBwOwzwSOlRvp9aLRidJUxFnwoCoO67WOF/2QcBd5LnZqzSl/Mr8f/1B05cD/Y
 J0vkO2vwxNUewasmzpAuX6AjV00NMWtK01FwKEt5ll6qSTdCoeIKfgPBjXjTP9U+hbHm
 y7mWqUMbU0yjnrDxY9c2zILKPVoxWn1cuqtlNnOet31P2BkquNIPupkoGLEOuReYVSuC
 mnEwxcYQ7kt1NHPT1vZjAd1kUBfRZM8bDWJHeSxaP35nvAz89ySK+pNc1EQjVR4Elh1r
 mh2w==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776153331; x=1776758131; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3v1lbZR7B0T3CnTyAOj5AXcyFefKYKLS2mh7YhIzhI=;
 b=axiNiAGL+KrffB0rpQDX6Rz4V2y6OS0/67DS98JNJqeb0C6lcqd9PzldIpRQGVDeN2
 nLiMHuj7/IqKJNyda7bF7A1OpdOF5Fw3hJg47st9jvRI0ru1hSWt9qd74x/ZH1/LwxmJ
 w3jbezgeKfzKzpRE7LCT5BpXlxPfdt4xVRhoTAIhC3hZLtNs3ibJBKTVWbOr7ka78Xxe
 laS3cWsAc584ATDZFvlhTidHGDFnBOKEfuWiB2DKQ4/mIuRCkd+8zqVPXNalZmAY0jgE
 cXwWfbl4xvQA+sDl7WM7ieWzRzp84iutBd/OdJ9WfRKTx9VrBnaf8q/9swkam9YSbRY+
 +Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776153331; x=1776758131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r3v1lbZR7B0T3CnTyAOj5AXcyFefKYKLS2mh7YhIzhI=;
 b=WywNYJVqGD6tGrnsAAi+QoxdBDUWbECscseHZ2+NFU0JJNItFkoSqb7HU+cAmWB9hA
 YRBo0vHO1DzQYuqoLLGyddGzgKQ3LzNYuVUiFoQyrnh2euT9n1ixwpFamPrQ6zpZOZZ3
 CZM4n6qpIvyX7glxMmspgQWhHpkyuACfeIbdpio0J7q29AWLrHNaKVSqBVjvK9eZ9KUZ
 kexnNfannt++LpYF6TDhZjsy7O8fSyRJTT359S0HZC02wTpGwtwShZdVT7/Lufi+OrN5
 x8UQLbdcU10YWL5u8cE6Vq1j3Cvr5DTw4KBrOYvyEdPYd/Q0Cwxj3VAkPmek01uNXpg+
 K2Bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ojp995plnQN7x5y2sLtEvTfZbi8Qu/rXQOwzJ4BVnGAvBK1Oe+m0oZZ0l5EjAUym3dPI=@lists.linux.it
X-Gm-Message-State: AOJu0YxWvFO80mSnuwRxaXQMeZ6gsieoeCaY4pVX4nLUDxglA/pwJHp2
 TAKXgHPeQWLZR+fSVmkUu6oKsg7yLR2PqGdI6pxbQLonveYkSVT6uyAI1I72XWrHrnVFwF5xxs9
 X+f7QSOVHG7VfVCHlNqoqaMvGzzWvAQ==
X-Gm-Gg: AeBDievWd9m2QOcyUs7UBmVfjsTV4NnzMaT8Ne/IP8P4/wnd1ShugGHImIHwSOueudg
 CNdOh0UXgUO7hm+mzld86EcRCSibJSpdyEsBmG2/emqdzpOwDHF4ddqFxMXAfGhGC4p6LrO0zwv
 BcQljObBCL+f7cdz3dEUhwmln+rwA+XM1e7qOJtsbb19tEfS6i/vjIMTuxkpmEy1Kn9jd4h6U4D
 S7ICwZQRe8P0lJZsub9Q0A+gWsAf8LFa/KL6ZdilP3x/q4i95vqpCXIEdyudrvf+aoT3jM3+vzS
 K0BIZtjsK6kpnQvr
X-Received: by 2002:a0c:f208:0:b0:899:e567:f04d with SMTP id
 6a1803df08f44-8ac8613a0c1mr253701266d6.11.1776153331340; Tue, 14 Apr 2026
 00:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260410175031.16921-1-always.starving0@gmail.com>
 <20260413212007.GA164377@pevik>
In-Reply-To: <20260413212007.GA164377@pevik>
From: Li Wang <wangli.ahau@gmail.com>
Date: Tue, 14 Apr 2026 15:55:20 +0800
X-Gm-Features: AQROBzC2lWy4W-kMitU_d-HHDV7WOJPZ4UOP1u3n19NQQejW9Xyr2UI1K-H3xzQ
Message-ID: <CANgNiRztOnor2mgLyfGxiCE01qyBwcsnZcrv1ZUi14KeFzctQw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include/lapi: add leaf Makefile
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

T24gVHVlLCBBcHIgMTQsIDIwMjYgYXQgNToyMOKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEppbnNlb2ssCj4KPiBUaGFua3MgZm9yIGZpeGluZyB0aGlzIQo+
Cj4gPiBGaXhlcyA6IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2lz
c3Vlcy8xMjYyCj4KPiBuaXQ6IFBsZWFzZSBuZXh0IHRpbWUgYXZvaWQgc3BhY2UgYmVmb3JlICc6
Jy4KPgo+IEZpeGVzOiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9p
c3N1ZXMvMTI2Mgo+Cj4gPiBpbmNsdWRlL2xhcGkgYW5kIGluY2x1ZGUvbGFwaS9zeXNjYWxscyBs
YWNrIE1ha2VmaWxlcywgc28gJ21ha2UgY2hlY2snCj4gPiBkb2VzIG5vdCB3b3JrIGluIHRoZXNl
IGRpcmVjdG9yaWVzLiBBZGQgbWluaW1hbCBsZWFmIE1ha2VmaWxlcy4KPgo+IG5pdDogQWxzbyBp
dCdkIGdvIGhlcmUuCj4KPiA+IFNpZ25lZC1vZmYtYnk6IEppbnNlb2sgS2ltIDxhbHdheXMuc3Rh
cnZpbmcwQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gIGluY2x1ZGUvbGFwaS9NYWtlZmlsZSAgICAg
ICAgICB8IDggKysrKysrKysKPiA+ICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvTWFrZWZpbGUgfCA4
ICsrKysrKysrCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCj4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGFwaS9NYWtlZmlsZQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvTWFrZWZpbGUKPgo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGFwaS9NYWtlZmlsZSBiL2luY2x1ZGUvbGFwaS9NYWtlZmlsZQo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQKPiA+IGluZGV4IDAwMDAwMDAwMC4uODNlZjg1Yzc3Cj4gPiAtLS0gL2Rldi9u
dWxsCj4gPiArKysgYi9pbmNsdWRlL2xhcGkvTWFrZWZpbGUKPiA+IEBAIC0wLDAgKzEsOCBAQAo+
ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiA+ICsjIENv
cHlyaWdodCAoQykgMjAyNiBKaW5zZW9rIEtpbSA8YWx3YXlzLnN0YXJ2aW5nMEBnbWFpbC5jb20+
Cj4gPiArCj4gPiArdG9wX3NyY2RpciAgICAgICAgICAgICAgPz0gLi4vLi4vCj4gPiArCj4gPiAr
aW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvZW52X3ByZS5tawo+ID4gKwo+ID4gK2lu
Y2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNfbGVhZl90YXJnZXQubWsKPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvc3lzY2FsbHMvTWFrZWZpbGUgYi9pbmNsdWRlL2xh
cGkvc3lzY2FsbHMvTWFrZWZpbGUKPgo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+IGluZGV4
IDAwMDAwMDAwMC4uZTQ2YzkwZWY1Cj4gPiAtLS0gL2Rldi9udWxsCj4gPiArKysgYi9pbmNsdWRl
L2xhcGkvc3lzY2FsbHMvTWFrZWZpbGUKPiA+IEBAIC0wLDAgKzEsOCBAQAo+ID4gKyMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiA+ICsjIENvcHlyaWdodCAoQykg
MjAyNiBKaW5zZW9rIEtpbSA8YWx3YXlzLnN0YXJ2aW5nMEBnbWFpbC5jb20+Cj4gPiArCj4gPiAr
dG9wX3NyY2RpciAgICAgICAgICAgICAgPz0gLi4vLi4vLi4vCj4gPiArCj4gPiAraW5jbHVkZSAk
KHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvZW52X3ByZS5tawo+ID4gKwo+ID4gK2luY2x1ZGUgJCh0
b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNfbGVhZl90YXJnZXQubWsKPgo+IFdoeSBkbyB3
ZSBuZWVkIHRoaXMgZmlsZT8gVGhpcyBvbmUgc2hvdWxkIGJlIGRlbGV0ZWQuIEFsc28sIGJlY2F1
c2UgbWFrZSBpbnN0YWxsCj4gd29ya3MgZm9yIGluY2x1ZGUgZGlyZWN0b3J5LCBpdCBzaG91bGQg
d29yayBoZXJlIGFzIHdlbGwuCj4gSSB3b3VsZCBqdXN0IGNvcHkgdGhhdCBoZWFkZXIsIHVwZGF0
ZSB0b3Bfc3JjZGlyIGxvY2F0aW9uIGFuZCBhbHNvIGluY2x1ZGUKPiBnZW5lcmljX3RydW5rX3Rh
cmdldC5tayB0byBpbmNsdWRlL01ha2VmaWxlLgo+Cj4gSSB0aGluayB0aGlzIGlzIGEgYmV0dGVy
IHZlcnNpb24uCgpZZXMsIHRoaXMgc29sdXRpb24gbG9va3Mgc21hcnRlciwgYnV0IHRpbnkgcXVl
cmllcyBiZWxvdy4KCj4gLi4uCj4gIGluY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2Vu
dl9wcmUubWsKPgo+ICtJTlNUQUxMX0RJUiAgICAgICAgICAgIDo9ICQoaW5jbHVkZWRpcikvbGFw
aQoKSSdtIGRvdWJ0aW5nIHNob3VsZCB3ZSBpbnN0YWxsIHRoZSBpbmNsdWRlL2xhcGkvIGxvY2Fs
IGhlYWRlciBmaWxlcyB0bwp0aGUgL29wdC9sdHAvaW5jbHVkZT8KCj4gLi4uCj4gLS0tIGluY2x1
ZGUvbGFwaS9zeXNjYWxscy9NYWtlZmlsZQo+ICsrKyAvZGV2L251bGwKCkRvZXMgdGhlIGBtYWtl
IGNoZWNrYCBzdGlsbCB3b3JrIChpbnNpZGUgaW5jbHVkZS9sYXBpL3N5c2NhbGxzLykKd2l0aG91
dCB0aGlzIE1ha2VmaWxlPwoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
