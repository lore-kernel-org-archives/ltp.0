Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BD7CFA77A
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 13:28:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F5083C6364
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 15:28:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C1293C6127
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 15:28:26 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7E60814098D0
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 15:28:25 +0200 (CEST)
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7a99de9beb2so115841685a.3
 for <ltp@lists.linux.it>; Fri, 04 Oct 2024 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728048504; x=1728653304; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3D86/Xz7GWMcJfyoKry0xY7L2mFTRLNs/Qabyq5u3U=;
 b=EgImUW2jn65zeCYuVAr8Nfq9yMFGK7Padw5KOcclnYo2bRRGI6WYJ7DosFaQVnzH0d
 HOi0YrKO8C/QbA0u7LhU6kqn8Er1IL+WwzD2ZrTk++lk+U0bTQCDkwgYbGOzDwd4isUG
 uf5kwQgit/JX0TMyAetHs3A5NdQHBHiDS9ecgAb+nsJMsATAGDSAVH60eZjYsU5QWGK7
 cx09eks6uMkFvjMtmzv3vnmqjqIZlPQ6LAWJ/Lh80rJym00N539Tmad/vSixMQ5PYk15
 vkHbH9f7Whn63crfDkZMIhSbI+DsVT/zm3bSUD6iQKd2PvzjuPtXMjoB0UUktDpBNwlK
 gUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728048504; x=1728653304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p3D86/Xz7GWMcJfyoKry0xY7L2mFTRLNs/Qabyq5u3U=;
 b=UGAoX38KoKqLW/wm9KQAbNQLJzJheRo6LemiOkYekUi3TvWegvBGiqSzglXM5d6Cn8
 vfPX/+ZL8/PF5x5/eusE7m+9tzq/6IYpLKnklsNSywl9MbxcQAhpQBkuRqW8ycCxKNCD
 gueCAiCNKGoX5ItD5Y4fkrpexJYfPMG4Xcxvk4Xc3IpU+qETjnHqtHt3uNX/oXg0Odmk
 +5CVWyRX9D1EVahUAlkC1JW7qDsygfixyvrkg+PjMuHOfsAG+/S8Se2vgAuNJ8jJEmp8
 Tdsa3QqAcIwjpFMEGF20Xq11jTIwU+QkSrJEG5CaH0RbLdpzL4in4RCPC3Q0BbMEku/F
 twsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsUX35feDNhD5syLp4an64vjHOF6Q71xRDnL+ACglJyGYaJFb/I94cnt0oFHILq7bqlhQ=@lists.linux.it
X-Gm-Message-State: AOJu0YzUQk+8cpegS354ewbHt80vdIlQfFEt7+PEAv4XigvdSFH240Z+
 lZEqDwZKn27dBI5KBmidqzFoCPVFOnLAWsBWc8I2Ds9aHi+WRETXtkKHTGqm1b/plzu8Psu9Zpb
 HcQc9d0gA0bGW4i7WTtYHRuxLdzQ=
X-Google-Smtp-Source: AGHT+IFTuYdmM6+aufByiyaM0OZDHVhqwE7RcJfZ9RjNuzeqCS2P26MM8134E5yUf+F53VrT1DSjXIxIL2/tOnA+lxA=
X-Received: by 2002:a05:620a:31a5:b0:7a9:c129:297a with SMTP id
 af79cd13be357-7ae6f44cb1fmr465662585a.32.1728048504122; Fri, 04 Oct 2024
 06:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201241.27286-1-jack@suse.cz> <Zvp6L+oFnfASaoHl@t14s>
 <20240930113434.hhkro4bofhvapwm7@quack3>
 <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
 <CAASaF6yASRgEKfhAVktFit31Yw5e9gwMD0jupchD0gWK9EppTw@mail.gmail.com>
In-Reply-To: <CAASaF6yASRgEKfhAVktFit31Yw5e9gwMD0jupchD0gWK9EppTw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Oct 2024 15:28:12 +0200
Message-ID: <CAOQ4uxjmtv88xoH0-s6D9WzRXv_stMsWB5+x2FMbdjCHyy1rmA@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
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
Cc: Christian Brauner <brauner@kernel.org>, Ted Tso <tytso@mit.edu>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBPY3QgNCwgMjAyNCBhdCAyOjUw4oCvUE0gSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gRnJpLCBPY3QgNCwgMjAyNCBhdCAyOjMy4oCvUE0gQW1p
ciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gTW9uLCBT
ZXAgMzAsIDIwMjQgYXQgMTozNOKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+IHdyb3RlOgo+
ID4gPgo+ID4gPiBPbiBNb24gMzAtMDktMjQgMTI6MTU6MTEsIEphbiBTdGFuY2VrIHdyb3RlOgo+
ID4gPiA+IE9uIE1vbiwgQXVnIDA1LCAyMDI0IGF0IDEwOjEyOjQxUE0gKzAyMDAsIEphbiBLYXJh
IHdyb3RlOgo+ID4gPiA+ID4gV2hlbiB0aGUgZmlsZXN5c3RlbSBpcyBtb3VudGVkIHdpdGggZXJy
b3JzPXJlbW91bnQtcm8sIHdlIHdlcmUgc2V0dGluZwo+ID4gPiA+ID4gU0JfUkRPTkxZIGZsYWcg
dG8gc3RvcCBhbGwgZmlsZXN5c3RlbSBtb2RpZmljYXRpb25zLiBXZSBrbmV3IHRoaXMgbWlzc2Vz
Cj4gPiA+ID4gPiBwcm9wZXIgbG9ja2luZyAoc2ItPnNfdW1vdW50KSBhbmQgZG9lcyBub3QgZ28g
dGhyb3VnaCBwcm9wZXIgZmlsZXN5c3RlbQo+ID4gPiA+ID4gcmVtb3VudCBwcm9jZWR1cmUgYnV0
IGl0IGhhcyBiZWVuIHRoZSB3YXkgdGhpcyB3b3JrZWQgc2luY2UgZWFybHkgZXh0Mgo+ID4gPiA+
ID4gZGF5cyBhbmQgaXQgd2FzIGdvb2QgZW5vdWdoIGZvciBjYXRhc3Ryb3BoaWMgc2l0dWF0aW9u
IGRhbWFnZQo+ID4gPiA+ID4gbWl0aWdhdGlvbi4gUmVjZW50bHksIHN5emJvdCBoYXMgZm91bmQg
YSB3YXkgKHNlZSBsaW5rKSB0byB0cmlnZ2VyCj4gPiA+ID4gPiB3YXJuaW5ncyBpbiBmaWxlc3lz
dGVtIGZyZWV6aW5nIGJlY2F1c2UgdGhlIGNvZGUgZ290IGNvbmZ1c2VkIGJ5Cj4gPiA+ID4gPiBT
Ql9SRE9OTFkgY2hhbmdpbmcgdW5kZXIgaXRzIGhhbmRzLiBTaW5jZSB0aGVzZSBkYXlzIHdlIHNl
dAo+ID4gPiA+ID4gRVhUNF9GTEFHU19TSFVURE9XTiBvbiB0aGUgc3VwZXJibG9jayB3aGljaCBp
cyBlbm91Z2ggdG8gc3RvcCBhbGwKPiA+ID4gPiA+IGZpbGVzeXN0ZW0gbW9kaWZpY2F0aW9ucywg
bW9kaWZ5aW5nIFNCX1JET05MWSBzaG91bGRuJ3QgYmUgbmVlZGVkLiBTbwo+ID4gPiA+ID4gc3Rv
cCBkb2luZyB0aGF0Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8wMDAwMDAwMDAwMDBiOTBhOGUwNjFlMjFkMTJmQGdvb2dsZS5jb20KPiA+ID4g
PiA+IFJlcG9ydGVkLWJ5OiBDaHJpc3RpYW4gQnJhdW5lciA8YnJhdW5lckBrZXJuZWwub3JnPgo+
ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KPiA+ID4gPiA+
IC0tLQo+ID4gPiA+ID4gZnMvZXh0NC9zdXBlci5jIHwgOSArKysrKy0tLS0KPiA+ID4gPiA+IDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPiA+ID4gPgo+
ID4gPiA+ID4gTm90ZSB0aGF0IHRoaXMgcGF0Y2ggaW50cm9kdWNlcyBmc3Rlc3RzIGZhaWx1cmUg
d2l0aCBnZW5lcmljLzQ1OSB0ZXN0IGJlY2F1c2UKPiA+ID4gPiA+IGl0IGFzc3VtZXMgdGhhdCBl
aXRoZXIgZnJlZXppbmcgc3VjY2VlZHMgb3IgJ3JvJyBpcyBhbW9uZyBtb3VudCBvcHRpb25zLiBC
dXQKPiA+ID4gPiA+IHdlIGZhaWwgdGhlIGZyZWV6ZSB3aXRoIEVGU0NPUlJVUFRFRC4gVGhpcyBu
ZWVkcyBmaXhpbmcgaW4gdGhlIHRlc3QgYnV0IGF0IHRoaXMKPiA+ID4gPiA+IHBvaW50IEknbSBu
b3Qgc3VyZSBob3cgZXhhY3RseS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMv
ZXh0NC9zdXBlci5jIGIvZnMvZXh0NC9zdXBlci5jCj4gPiA+ID4gPiBpbmRleCBlNzIxNDVjNGFl
NWEuLjkzYzAxNmIxODZjMCAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2ZzL2V4dDQvc3VwZXIuYwo+
ID4gPiA+ID4gKysrIGIvZnMvZXh0NC9zdXBlci5jCj4gPiA+ID4gPiBAQCAtNzM1LDExICs3MzUs
MTIgQEAgc3RhdGljIHZvaWQgZXh0NF9oYW5kbGVfZXJyb3Ioc3RydWN0IHN1cGVyX2Jsb2NrICpz
YiwgYm9vbCBmb3JjZV9ybywgaW50IGVycm9yLAo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgICBleHQ0
X21zZyhzYiwgS0VSTl9DUklULCAiUmVtb3VudGluZyBmaWxlc3lzdGVtIHJlYWQtb25seSIpOwo+
ID4gPiA+ID4gICAgIC8qCj4gPiA+ID4gPiAtICAgICogTWFrZSBzdXJlIHVwZGF0ZWQgdmFsdWUg
b2YgLT5zX21vdW50X2ZsYWdzIHdpbGwgYmUgdmlzaWJsZSBiZWZvcmUKPiA+ID4gPiA+IC0gICAg
KiAtPnNfZmxhZ3MgdXBkYXRlCj4gPiA+ID4gPiArICAgICogRVhUNF9GTEFHU19TSFVURE9XTiB3
YXMgc2V0IHdoaWNoIHN0b3BzIGFsbCBmaWxlc3lzdGVtCj4gPiA+ID4gPiArICAgICogbW9kaWZp
Y2F0aW9ucy4gV2UgZG9uJ3Qgc2V0IFNCX1JET05MWSBiZWNhdXNlIHRoYXQgcmVxdWlyZXMKPiA+
ID4gPiA+ICsgICAgKiBzYi0+c191bW91bnQgc2VtYXBob3JlIGFuZCBzZXR0aW5nIGl0IHdpdGhv
dXQgcHJvcGVyIHJlbW91bnQKPiA+ID4gPiA+ICsgICAgKiBwcm9jZWR1cmUgaXMgY29uZnVzaW5n
IGNvZGUgc3VjaCBhcyBmcmVlemVfc3VwZXIoKSBsZWFkaW5nIHRvCj4gPiA+ID4gPiArICAgICog
ZGVhZGxvY2tzIGFuZCBvdGhlciBwcm9ibGVtcy4KPiA+ID4gPiA+ICAgICAgKi8KPiA+ID4gPiA+
IC0gICBzbXBfd21iKCk7Cj4gPiA+ID4gPiAtICAgc2ItPnNfZmxhZ3MgfD0gU0JfUkRPTkxZOwo+
ID4gPiA+Cj4gPiA+ID4gSGksCj4gPiA+ID4KPiA+ID4gPiBzaG91bGRuJ3QgdGhlIFNCX1JET05M
WSBzdGlsbCBiZSBzZXQgKGluIF9fZXh0NF9yZW1vdW50KCkpIGZvciB0aGUgY2FzZQo+ID4gPiA+
IHdoZW4gdXNlciB0cmlnZ2VycyB0aGUgYWJvcnQgd2l0aCBtb3VudCguLiwgImFib3J0Iik/IEJl
Y2F1c2Ugbm93IHdlIHNlZW0KPiA+ID4gPiB0byBhbHdheXMgaGl0IHRoZSBjb25kaXRpb24gdGhh
dCByZXR1cm5zIEVST0ZTIHRvIHVzZXItc3BhY2UuCj4gPiA+Cj4gPiA+IFRoYW5rcyBmb3IgcmVw
b3J0ISBJIGFncmVlIHJldHVybmluZyBFUk9GUyBmcm9tIHRoZSBtb3VudCBhbHRob3VnaAo+ID4g
PiAnYWJvcnRpbmcnIHN1Y2NlZWRlZCBpcyBjb25mdXNpbmcgYW5kIGlzIG1vc3RseSBhbiB1bmlu
dGVuZGVkIHNpZGUgZWZmZWN0Cj4gPiA+IHRoYXQgYWZ0ZXIgYWJvcnRpbmcgdGhlIGZzIGZ1cnRo
ZXIgY2hhbmdlcyB0byBtb3VudCBzdGF0ZSBhcmUgZm9yYmlkZGVuIGJ1dAo+ID4gPiB0aGUgdGVz
dGNhc2UgYWRkaXRpb25hbGx5IHdhbnRzIHRvIHJlbW91bnQgdGhlIGZzIHJlYWQtb25seS4KPiA+
Cj4gPiBSZWdhcmRsZXNzIG9mIHdoYXQgaXMgcmlnaHQgb3Igd3JvbmcgdG8gZG8gaW4gZXh0NCwg
SSBkb24ndCB0aGluayB0aGF0IHRoZSB0ZXN0Cj4gPiByZWFsbHkgY2FyZXMgYWJvdXQgcmVtb3Vu
dCByZWFkLW9ubHkuCj4gPiBJIGRvbid0IHNlZSBhbnl0aGluZyBpbiB0aGUgdGVzdCB0aGF0IHJl
cXVpcmVzIGl0LiBHYWJyaWVsPwo+ID4gSWYgSSByZW1vdmUgTVNfUkRPTkxZIGZyb20gdGhlIHRl
c3QgaXQgd29ya3MganVzdCBmaW5lLgo+ID4KPiA+IEFueSBvYmplY3Rpb24gZm9yIExUUCBtYWlu
dGFpbmVycyB0byBhcHBseSB0aGlzIHNpbXBsZSB0ZXN0IGZpeD8KPgo+IERvZXMgdGhhdCBjaGFu
Z2Ugd29yayBmb3IgeW91IG9uIG9sZGVyIGtlcm5lbHM/IE9uIDYuMTEgSSBnZXQgRVJPRlM6Cj4K
PiBmYW5vdGlmeTIyLmM6NTk6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRvCj4gL3RtcC9M
VFBfZmFuZ2I1d3VPL3Rlc3RfbW50IGZzdHlwPWV4dDQgZmxhZ3M9MjAKPiBmYW5vdGlmeTIyLmM6
NTk6IFRCUk9LOiBtb3VudCgvZGV2L2xvb3AwLCB0ZXN0X21udCwgZXh0NCwgMzIsCj4gMHg0MjEx
ZWQpIGZhaWxlZDogRVJPRlMgKDMwKQo+CgpZZWggbWUgdG9vLCBidXQgaWYgeW91IGNoYW5nZSBz
L1NBRkVfTU9VTlQvbW91bnQKdGhlIHRlc3Qgd29ya3MganVzdCBmaW5lIG9uIDYuMTEgYW5kIDYu
MTItcmMxIHdpdGggb3Igd2l0aG91dCBNU19SRE9OTFkuClRoZSBwb2ludCBvZiB0cmlnZ2VyX2Zz
X2Fib3J0KCkgaXMgdG8gdHJpZ2dlciB0aGUgRlNfRVJST1IgZXZlbnQgYW5kIGl0CmRvZXMgbm90
IG1hdHRlciB3aGV0aGVyIHJlbW91bnQgc3VjY2VlZHMgb3Igbm90IGZvciB0aGF0IG1hdHRlciBh
dCBhbGwuCgpTbyB5b3UgY2FuIGVpdGhlciBpZ25vcmUgdGhlIHJldHVybiB2YWx1ZSBvZiBtb3Vu
dCgpIG9yIGFzc2VydCB0aGF0IGl0CmNhbiBlaXRoZXIgc3VjY2VlZCBvciBnZXQgRVJPRlMgZm9y
IGNhdGNoaW5nIHVuZXhwZWN0ZWQgZXJyb3JzLgoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
