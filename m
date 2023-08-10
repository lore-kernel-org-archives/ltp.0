Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DE2C04A6A
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 14:38:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56FF63CD3EB
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 16:38:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 819DB3C98D3
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 16:38:28 +0200 (CEST)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8F3311400F49
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 16:38:27 +0200 (CEST)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-48730d2ce5cso417234e0c.0
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 07:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691678306; x=1692283106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtKW3m6St/tCwi9EUh2wY2Fr06FdmNeB2PkpN9wNam4=;
 b=PzrOljJFgftVM6vygtxCH/O+Tllh7c3vrKQP1Oj0+FoznExZsxCUOUAQWB0dHUWGQU
 ZZnpxzXr4qPkllzSk0yz6GUBdJRcuFH1X6X4Pjw208/bIBEDBHiEut7ROmQAHzAMn6/u
 Uy+I7wUK5O83cP8vZ5ovAtP40DEC+YXG+QbRloOr3GCx3nWlTiH5pV2Yvf45RvO26MLS
 X4YtSm0W5rUcMp2Khh8Uasq9vYUVQGiK0eSsxCAFkRIOmeGQi0Vyv+CcK22FQ2QvKcwe
 y1BUJ1LFSM1fY86OrffaRkXR84UWz5VOl+heSqxO10ccswfXaUVCqEslFOcy2gJwbCNV
 yhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691678306; x=1692283106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtKW3m6St/tCwi9EUh2wY2Fr06FdmNeB2PkpN9wNam4=;
 b=aeLwb3v4IAdgYC58O7nZnw0grdmqr19a3RbSiECOgkp/YR02UrlTuNUazo3SfdZ0Cz
 uii8RxZYVCpG+M2Z3W+3V2R8A/Ssr5r01RBMltqc7Bv8cGqr39oXcrZLlg66Hwl2OIqm
 xzzKpMgu17Z0ylQFtIhCdiS/InECzR2yoz3+Olahqsmop9l5var63woJTE/dc72GUHIn
 kG71BQaMFow7lB86Z3tfuRXqplVicZLvhRC/2oDaS1pNm9hJjekiTmVKWViBmZhzGTmJ
 KoAEQQSni0AI7LZh5hNNIUgWihFWozQBWvgirJ8u8MLPpxqIHymB7+LE1WSIM6Q2EAPM
 F3LQ==
X-Gm-Message-State: AOJu0YxR/M7Tk6zZhT/azy11vwfl3huUp/epr76vf8AklcjpzPKIJk7r
 QtIS5sE3tQiMV0lgjKkA9pc+uusou5ZHLqzktj8=
X-Google-Smtp-Source: AGHT+IG93lFTJmW1PntJsuA5zAOoIy778v4IZWy0eXL6h0IMqd5oc+8Z4dLpTLTzMHf1KPnH2se4/okd8qYL7gswQKg=
X-Received: by 2002:a67:efcf:0:b0:444:3f96:ff70 with SMTP id
 s15-20020a67efcf000000b004443f96ff70mr1959645vsp.33.1691678306331; Thu, 10
 Aug 2023 07:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230810131012.13026-1-jack@suse.cz>
 <CAOQ4uxiY3Qajthb_kVhzGbuzqzJvUWXdF4HRW=YtaojQ1Ys3DA@mail.gmail.com>
 <20230810142524.xmrf4xfplxe7hv2e@quack3>
In-Reply-To: <20230810142524.xmrf4xfplxe7hv2e@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 10 Aug 2023 17:38:15 +0300
Message-ID: <CAOQ4uxh85sm8nv6_Q2tH95Uwx2G8aZ0nhLPLhOMYeOC=mjbKqQ@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify23: Make evictable marks tests more
 reliable
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
Cc: ltp@lists.linux.it, petr.vorel@suse.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgNToyNeKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gT24gVGh1IDEwLTA4LTIzIDE2OjMwOjMyLCBBbWlyIEdvbGRzdGVpbiB3cm90
ZToKPiA+IE9uIFRodSwgQXVnIDEwLCAyMDIzIGF0IDQ6MTDigK9QTSBKYW4gS2FyYSA8amFja0Bz
dXNlLmN6PiB3cm90ZToKPiA+ID4KPiA+ID4gSXQgaGFzIGJlZW4gb2JzZXJ2ZWQgdGhhdCB3aGVu
IGZhbm90aWZ5MjMgdGVzdCBpcyBydW4gaW4gYSBsb29wLCBpdAo+ID4gPiBldmVudHVhbGx5IGZh
aWxzIGFzOgo+ID4gPgo+ID4gPiBmYW5vdGlmeTIzLmM6MTEyOiBUUEFTUzogRkFOX01BUktfQURE
IGZhaWxlZCB3aXRoIEVFWElTVCBhcyBleHBlY3RlZCB3aGVuIHRyeWluZyB0byBkb3duZ3JhZGUg
dG8gZXZpY3RhYmxlIG1hcmsKPiA+ID4gZmFub3RpZnkyMy5jOjc1OiBUUEFTUzogRkFOX01BUktf
UkVNT1ZFIGZhaWxlZCB3aXRoIEVOT0VOVCBhcyBleHBlY3RlZCBhZnRlciBlbXB0eSBtYXNrCj4g
PiA+IGZhbm90aWZ5MjMuYzoxNTY6IFRQQVNTOiBHb3Qgbm8gZXZlbnRzIGFzIGV4cGVjdGVkCj4g
PiA+IGZhbm90aWZ5MjMuYzo4MTogVEZBSUw6IEZBTl9NQVJLX1JFTU9WRSBkaWQgbm90IGZhaWwg
d2l0aCBFTk9FTlQgYXMgZXhwZWN0ZWQgYWZ0ZXIgZHJvcF9jYWNoZXM6IFNVQ0NFU1MgKDApCj4g
PiA+Cj4gPiA+IFRoaXMgaXMgYmVjYXVzZSByZXBlYXRlZCBldmljdGlvbnMgb2YgY2FjaGVzIGRv
bmUgYnkgdGhlIHRlc3QgcmVjbGFpbQo+ID4gPiBhbGwgZnJlZWFibGUgc2xhYiBvYmplY3RzIGlu
IHRoZSBzeXN0ZW0uIFNvIHdoZW4gdGhlIHRlc3QgY2FsbHMgZHJvcAo+ID4gPiBjYWNoZXMsIG9u
bHkgdGhlIGRlbnRyeSBhbmQgaW5vZGUgb2YgdGhlIHRlc3QgZmlsZSBhcmUgdGhlcmUgdG8gcmVj
bGFpbS4KPiA+ID4gQnV0IGZvciBpbm9kZSB0byBiZSByZWNsYWltZWQsIGRlbnRyeSAod2hpY2gg
aG9sZHMgaW5vZGUgcmVmZXJlbmNlKSBoYXMKPiA+ID4gdG8gYmUgZnJlZWQgZmlyc3QgYW5kIGZv
ciBkZW50cnkgdG8gYmUgZnJlZWQgaXQgaGFzIHRvIGZpcnN0IGN5Y2xlCj4gPiA+IHRocm91Z2gg
dGhlIExSVSB3aGljaCB0YWtlcyB0d28gc2xhYiByZWNsYWltIGNhbGxzLgo+ID4gPgo+ID4gPiBD
YWxsIGRyb3AgY2FjaGVzIHR3aWNlIHRvIG1ha2Ugc3VyZSBkZW50cnkgaGFzIGNoYW5jZSB0byBw
YXNzIHRocm91Z2gKPiA+ID4gdGhlIExSVSBhbmQgYmUgcmVjbGFpbWVkLgo+ID4gPgo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pgo+ID4gPiAtLS0KPiA+ID4gIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMy5jIHwgNyArKysrKyst
Cj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4g
PiA+Cj4gPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5
L2Zhbm90aWZ5MjMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3Rp
ZnkyMy5jCj4gPiA+IGluZGV4IDg5ZmQ0ZjM2YTA5Yi4uMmQ1MGY3MDU4NWI3IDEwMDY0NAo+ID4g
PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMuYwo+
ID4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMu
Ywo+ID4gPiBAQCAtMTYwLDEwICsxNjAsMTUgQEAgc3RhdGljIHZvaWQgdGVzdF9mYW5vdGlmeSh2
b2lkKQo+ID4gPiAgICAgICAgIH0KPiA+ID4KPiA+ID4gICAgICAgICAvKgo+ID4gPiAtICAgICAg
ICAqIGRyb3BfY2FjaGVzIHNob3VsZCBldmljdCBpbm9kZSBmcm9tIGNhY2hlIGFuZCByZW1vdmUg
ZXZpY3RhYmxlIG1hcmsKPiA+ID4gKyAgICAgICAgKiBkcm9wX2NhY2hlcyBzaG91bGQgZXZpY3Qg
aW5vZGUgZnJvbSBjYWNoZSBhbmQgcmVtb3ZlIGV2aWN0YWJsZSBtYXJrLgo+ID4gPiArICAgICAg
ICAqIFdlIGNhbGwgZHJvcF9jYWNoZXMgdHdpY2UgYXMgb25jZSB0aGUgZGVudHJpZXMgd2lsbCBq
dXN0IGN5Y2xlCj4gPiA+ICsgICAgICAgICogdGhyb3VnaCB0aGUgTFJVIHdpdGhvdXQgYmVpbmcg
cmVjbGFpbWVkIGFuZCBpZiB0aGVyZSBhcmUgbm8gb3RoZXIKPiA+ID4gKyAgICAgICAgKiBvYmpl
Y3RzIHRvIHJlY2xhaW0sIHRoZSBzbGFiIHJlY2xhaW0gd2lsbCBqdXN0IHN0b3AgaW5zdGVhZCBv
Zgo+ID4gPiArICAgICAgICAqIHJldHJ5aW5nLgo+ID4gPiAgICAgICAgICAqLwo+ID4gPiAgICAg
ICAgIGZzeW5jX2ZpbGUoVEVTVF9GSUxFKTsKPiA+ID4gICAgICAgICBTQUZFX0ZJTEVfUFJJTlRG
KERST1BfQ0FDSEVTX0ZJTEUsICIzIik7Cj4gPiA+ICsgICAgICAgU0FGRV9GSUxFX1BSSU5URihE
Uk9QX0NBQ0hFU19GSUxFLCAiMyIpOwo+ID4gPgo+ID4gPiAgICAgICAgIHZlcmlmeV9tYXJrX3Jl
bW92ZWQoVEVTVF9GSUxFLCAiYWZ0ZXIgZHJvcF9jYWNoZXMiKTsKPiA+Cj4gPiBJZiB0aGlzIGlt
cHJvdmVzIHRoZSByZWxpYWJpbGl0eSBvZiB0aGUgdGVzdCwgSSBoYXZlIG5vIHByb2JsZW0gd2l0
aAo+ID4gdGhlIHNvbHV0aW9uLAo+Cj4gWWVzLCBpdCBmaXhlcyB0aGUgcHJvYmxlbSBhdCBsZWFz
dCBmb3IgbWUgOikKPgo+ID4gYnV0IEkgYW0gYSBiaXQgdW5lYXN5IHdpdGggdGhlIGZhY3QgdGhh
dCBmYW5vdGl5MTAgYW5kIGZhbm90aWZ5MjMgaGF2ZSB0d28KPiA+IGRpZmZlcmVudCBtaXRpZ2F0
aW9ucy4KPgo+IEkga25vdyBhbmQgSSB3YXMgdGhpbmtpbmcgYWJvdXQgdGhhdCBhIGJpdC4gSSBj
b3VsZCBpbXBsZW1lbnQgc29tZXRoaW5nCj4gc2ltaWxhciBhcyBmYW5vdGlmeTEwIGRvZXMgZm9y
IGZhbm90aWZ5MjMgYnV0IGl0IHNlZW1lZCB0byBiZSBhIGJpdCBvZiBhbgo+IG92ZXJraWxsIHNv
IEkgd2VudCBmb3IgdGhlIG9uZS1saW5lci4KPgo+ID4gQW55d2F5LCBJIHRoaW5rIHRoYXQgdGhl
IGV4cGxhbmF0aW9uIGFib3ZlIGlzIHRydWUgZm9yIHNvbWUgZnMgYnV0IHhmcwo+ID4gaW5vZGUg
bGlmZXRpbWUgYW5kIHNocmlua2VycyBmb3IgZXhhbXBsZSBhbmQgbW9yZSBjb21wbGV4LCBzbyBp
dCBkb2VzCj4gPiBub3QgaG9sZC4gUmlnaHQ/Cj4KPiBTbyB0aGUgZXhwbGFuYXRpb24gaXMgdXNp
bmcgaW50ZXJuYWwga25vd2xlZGdlIG9mIHBydW5lX2ljYWNoZV9zYigpCj4gaW1wbGVtZW50YXRp
b24uIFhGUyBoYXMgaXRzIG93biBydWxlcyBmb3IgYWdpbmcgaW5vZGVzIHNvIGl0IHdpbGwKPiBu
b3QgaG9sZCB0aGVyZSAtIGl0IGhhcyB0aGlzICJpbmFjdGl2YXRpb24iIGFjdGlvbiB3aGljaCBy
ZWxlYXNlcyB0aGUgbGFzdAo+IGlub2RlIHJlZmVyZW5jZSBhbmQgQUZBSUNTIGRyb3BfY2FjaGVz
IHJlc3VsdHMgb25seSBpbiBwaW5naW5nIGJhY2tncm91bmQKPiB0aHJlYWRzIHRvIGRvIHdvcmsg
YnV0IGRvZXNuJ3QgcmVhbGx5IHdhaXQgZm9yIGlub2RlcyB0byBiZSBpbmFjdGl2YXRlZCwKPiBs
ZXQgYWxvbmUgZnJlZWQuCj4KPiA+IE1lYW5pbmcgdGhhdCB0aGUgZXhwbGFuYXRpb24gaXMgdHJ1
ZSBiZWNhdXNlIGZhbm90aWZ5MTAgaGFzOgo+ID4KPiA+ICAgICAgICAgLyogU2hyaW5rZXJzIG9u
IG90aGVyIGZzIGRvIG5vdCB3b3JrIHJlbGlhYmx5IGVub3VnaCB0bwo+ID4gZ3VhcmFudGVlIG1h
cmsgZXZpY3Rpb24gb24gZHJvcF9jYWNoZXMgKi8KPiA+ICAgICAgICAgLmRldl9mc190eXBlID0g
ImV4dDIiLAo+ID4KPiA+IE1heWJlIHRoYXQgc2hvdWxkIGJlIHNwZWxsZWQgb3V0Pwo+Cj4gSSBn
dWVzcyB5b3Ugc3BlYWsgYWJvdXQgZmFub3RpZnkyMyBub3cgYnV0IHllcywgdGhpcyBwYXRjaCBk
ZXBlbmRzIG9uIHRoZQo+IGZhY3QgdGhhdCB3ZSBhcmUgbGltaXRlZCB0byBleHQyLiBQZXJoYXBz
IEkgY2FuIGFkZCB0aGF0IHRvIHRoZSBjb21tZW50IGJ1dAo+IGl0IGFscmVhZHkgaXMgbWVudGlv
bmVkIGluIHRoZSB0ZXN0IGFzIHlvdSBzaG93IGFib3ZlLi4uCgpZZXMsIHRoYXQgaXMgYWxsIEkg
bWVhbnQsIHNvIGEgcmVhZGVyIHdvbid0IHNlZSB0aGlzIGV4cGxhbmF0aW9uIGFuZAp0cnkgdG8g
Y29weSB0aGUgc2FtZSBtaXRpZ2F0aW9uIHRvIG90aGVyIHRlc3RzIHRoYXQgZG8gbm90IGxpbWl0
CnRoZW1zZWx2ZXMgdG8gZXh0MiwgYmV0dGVyIG1ha2UgdGhhdCBmYWN0IGNsZWFyIGluIHRoZSBj
b21tZW50LgoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
