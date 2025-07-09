Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453F4C83F09
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 02:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752026777; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=FkN+LbtzcY4V0bYXLS27nAukDJ8rLkrKW0c4vxb8FaQ=;
 b=fbIXHiE9pwG4gpWdIvvAdtEwks5hrKwld8rcWHHn73ttb/QKCTNxvRxWLoMa7xOISuDWT
 /DzMygErOj/L5WU4bBxjfFzUh+9TB2teEiW4vBlCav4yZ5EVSz+xUvHbqpLiUQQnbJqdFi+
 MKQ3NHvKKG0KfE7XZiPIDJDV0FNExnk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F81B3CA650
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 04:06:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01B9A3C627B
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 04:05:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1AD956010F6
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 04:05:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752026754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TYMxPj6nf2oG7DDfblyk1kxP6wzNma11pf8FLUiTio4=;
 b=dlO94lS72OA/03Fmo7od435eTZwr4gLYjLGkpNWJJIgZzRl17cMfhbGf6EZ15rF0QelgoO
 FdqfR5pM2x/vItzdz8LsQCAoZuoezQSD8VFcrRDFx2aVB3C2NZAxC8bKLGl86hkQIBeoBc
 zE4sivnyTtrgdQqJd06M8195YahczyQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-5M9iqu-2PUypzdSIpAH2yg-1; Tue, 08 Jul 2025 22:05:52 -0400
X-MC-Unique: 5M9iqu-2PUypzdSIpAH2yg-1
X-Mimecast-MFC-AGG-ID: 5M9iqu-2PUypzdSIpAH2yg_1752026751
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-311e7337f26so4073650a91.3
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 19:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752026751; x=1752631551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TYMxPj6nf2oG7DDfblyk1kxP6wzNma11pf8FLUiTio4=;
 b=b0glbkhMzDEQcg0aCjQQDcGaYcsaaO/iwJCvM3QDYzcMzCoITCzDBd5hKkfnGvdykY
 ZuDnDzx/zu5/q8f6adfU2teMIZiWwFq6XdxuxUGxHWrZ+ABcO7dh7+SnQ97qw9ztRPNC
 KKhJQWSVUHosMhMlXjb00kxX7dv/knBXZS/HuAOoI+h6biBPkqGfymqKTMU9hWr58g94
 yoAKZ96BQT03VQPSR9GPDo3g4wETgCaFhq8xqFolixcNwltsvXNlGJOW07715RRlrEAp
 Yw9CpZ1VRDVHpUv9yvb6mLDX4lA1reptqTnE/IKaJSNRQwzRAinYHnWqvGv+NrHGkkhQ
 4+xA==
X-Gm-Message-State: AOJu0YxeoU6SH+pZ7bb7lH2i0tCtQ+qrVXqAG/0v+bxDF6mqIGDsgB5K
 0Bsxn7VJ+sSllxHQGi/R51+obbq3Fb2TQzd4MRHzd1zevNwUfp736jM5wk1M5hV2CCxLuzO3DBC
 e0Ox5L5vfE+zW00F4WKZFVVoy2HlxgfoeABghXk83JMduhhjI2ehoZ5dq8+FtzvPaR0XUfK6QC4
 /d6nCBeX9bHA77W1cK84IFPyobIBFu9eta5+w=
X-Gm-Gg: ASbGncsFLjyUUJ6T6kTsZ6R9INx7AA2NjwQWymW+BcqQx5JhrbMow0J50a2uCIhTDG8
 XIcZ5JzThL1lCqSg+t69Gfv8rSP4Kk90EtjojVA/LLJhdf5uoZ0250787RXB+XZLTNoHkyNqs8Y
 nsaYyq
X-Received: by 2002:a17:90b:3dc6:b0:311:ea13:2e6a with SMTP id
 98e67ed59e1d1-31c2fd0c47bmr1274551a91.13.1752026750626; 
 Tue, 08 Jul 2025 19:05:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhk1GO11chh2L6+m1NLn4RFtI6LZyX5Hn7jglYut0mXrQ1XKaUZf/Pqy+kZS+DnMmr8lwrcuJ2My4iONiZ0So=
X-Received: by 2002:a17:90b:3dc6:b0:311:ea13:2e6a with SMTP id
 98e67ed59e1d1-31c2fd0c47bmr1274499a91.13.1752026750026; Tue, 08 Jul 2025
 19:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250708112810.3298-1-yangtiezhu@loongson.cn>
 <CAEemH2ejmvUVrYTgeCM-i=GAZLZ4aDStLWtGKTor2sFKgXq7mQ@mail.gmail.com>
 <e136794c-086d-ea25-9dac-e523c8455279@loongson.cn>
In-Reply-To: <e136794c-086d-ea25-9dac-e523c8455279@loongson.cn>
Date: Wed, 9 Jul 2025 10:05:36 +0800
X-Gm-Features: Ac12FXzkgi3dnnEiXMXMuaLlXlZjOVBZ-1S0cU6SK_98eCLUk7msB86KMFw8vHY
Message-ID: <CAEemH2dZkRFwV=SZ1=hup=c3fo_-MKWCT2G8OGCi4S4FvX_WGg@mail.gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qeet3TBmC_47BE9n5HIEcty_zkFnE8-mLZ9_GROcTFo_1752026751
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] getrlimit/getrlimit03: Skip test if
 __NR_getrlimit_ulong not implemented
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdWwgOSwgMjAyNSBhdCA5OjQz4oCvQU0gVGllemh1IFlhbmcgPHlhbmd0aWV6aHVA
bG9vbmdzb24uY24+IHdyb3RlOgoKPiBPbiAyMDI1LzcvOCDkuIvljYg5OjEwLCBMaSBXYW5nIHdy
b3RlOgo+ID4KPiA+Cj4gPiBPbiBUdWUsIEp1bCA4LCAyMDI1IGF0IDc6MjjigK9QTSBUaWV6aHUg
WWFuZyA8eWFuZ3RpZXpodUBsb29uZ3Nvbi5jbgo+ID4gPG1haWx0bzp5YW5ndGllemh1QGxvb25n
c29uLmNuPj4gd3JvdGU6Cj4gPgo+ID4gICAgIEluIHRoZSBMVFAgY29kZSwgX19OUl9nZXRybGlt
aXRfdWxvbmcgaXMgZGVmaW5lZCBhcyBfX05SX3VnZXRybGltaXQKPiA+ICAgICBvciBfX05SX2dl
dHJsaW1pdC4KPiA+Cj4gPiAgICAgSW4gdGhlIExpbnV4IGtlcm5lbCwgTG9vbmdBcmNoIHVzZXMg
dGhlIGdlbmVyaWMgc3lzY2FsbCB0YWJsZQo+ID4gICAgIHdoaWNoIGlzIGRlZmluZWQgaW4gaW5j
bHVkZS91YXBpL2FzbS1nZW5lcmljL3VuaXN0ZC5oLiBXZSBjYW4KPiA+ICAgICBzZWUgdGhhdCBf
X05SX3VnZXRybGltaXQgaXMgbm90IGRlZmluZWQgaW4gdGhlIGdlbmVyaWMgaGVhZGVyLAo+ID4g
ICAgIGFuZCBhbHNvIHRoZXJlIGlzIG5vIF9fQVJDSF9XQU5UX1NFVF9HRVRfUkxJTUlUIGRlZmlu
aXRpb24gaW4KPiA+ICAgICB0aGUgYXJjaCBzcGVjaWZpYyBoZWFkZXIgYXJjaC9sb29uZ2FyY2gv
aW5jbHVkZS9hc20vdW5pc3RkLmgsCj4gPiAgICAgc28gYm90aCBfX05SX3VnZXRybGltaXQgYW5k
IF9fTlJfZ2V0cmxpbWl0IGFyZSBub3QgaW1wbGVtZW50ZWQKPiA+ICAgICBvbiBMb29uZ0FyY2gu
Cj4gPgo+ID4gICAgIFRoYXQgaXMgdG8gc2F5LCBubyBuZWVkIHRvIGNvbXBhcmUgdGhlIHJldHVy
biB2YWx1ZSBhbmQgZXJybm8KPiA+ICAgICBhYm91dCB0aGUgc3lzY2FsbCBudW1iZXJzIF9fTlJf
cHJsaW1pdDY0IGFuZCBfX05SX3t1fWdldHJsaW1pdCwKPiA+ICAgICBqdXN0IGNoZWNrIHRoaXMg
Y2FzZSBhbmQgdGhlbiBza2lwIHRoZSB0ZXN0Lgo+ID4KPiA+ICAgICBXaGlsZSBhdCBpdCwgbW9k
aWZ5IHRoZSB2YWx1ZSBvZiB0ZXN0LnRjbnQgYXMgMSB0byBza2lwIG9ubHkKPiA+ICAgICBvbmNl
IGlmIHRoZSBlcnJubyBvZiBnZXRybGltaXRfdWxvbmcoKSBvciBnZXRybGltaXRfbG9uZygpIGlz
Cj4gPiAgICAgRU5PU1lTLgo+Cj4gLi4uCj4KPiA+ICAgICBAQCAtMTgxLDYgKzE4Nyw3IEBAIHN0
YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgcmVzb3VyY2UpCj4gPiAgICAgICAgICAgICAgaWYg
KGVycm5vX2wgPT0gRU5PU1lTKSB7Cj4gPiAgICAgICAgICAgICAgICAgICAgICB0c3RfcmVzKFRD
T05GIHwgVEVSUk5PLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiX19OUl9nZXRy
bGltaXQoJWQpIG5vdCBpbXBsZW1lbnRlZCIsCj4gPiAgICAgX19OUl9nZXRybGltaXQpOwo+ID4K
PiA+ICAgICArICAgICAgICAgICAgICAgdGVzdC50Y250ID0gMTsKPiA+Cj4gPgo+ID4gVGhpcyBz
ZWNvbmQgdGVzdC50Y250IHJlc2V0dGluZyBpcyByZWR1bmRhbnQsIGlmIHRoZSBTSUdORURfR0VU
UkxJTUlUCj4gPiBnZXQgZGVmaW5lZCwgdGhhdCBtZWFucyBib3RoIF9fTlJfZ2V0cmxpbWl0IGFu
ZCBfX05SX3VnZXRybGltaXQgYXJlCj4gPiBkZXRlY3RlZCwKPiA+IGFuZCB0aGUgb25seSBuZWdh
dGl2ZSBzaXR1YXRpb24gaXMgZ2V0cmxpbWl0X3Vsb25nKHJlc291cmNlLCAmcmxpbV91bCk7Cj4g
PiB3b3JrcyB3ZWxsLCBidXQgZ2V0cmxpbWl0X2xvbmcocmVzb3VyY2UsICZybGltX2wpOyByZXR1
cm4gRU5PU1lTLCB0bwo+ID4gbWFrZSB0aGUKPiA+IHRlc3QgY2FuIGJlIGludGVyYWN0aW9uIHRo
ZSBzZWNvbmQgc2hvdWxkIG5vIHRlc3QudGNudCA9IDEuCj4gPgo+ID4gU2VlOgo+ID4KPiBodHRw
czovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9jb21taXQvZmFjNzgzYjVkNjYz
MWVmYTcwZDJlYTMyNTcxNDI3NjNkOTQ0YmEzMgo+ID4KPiA+IEFueXdheSwgSSBtb2RpZmllZCB0
aGUgcGF0Y2ggYW5kIG1lcmdlZCEKPgo+IFRoYW5rIHlvdS4gSWYgc28sIGl0IGlzIGJldHRlciB0
byByZW1vdmUgIm9yIGdldHJsaW1pdF9sb25nKCkiIGluIHRoZQo+IGNvbW1pdCBtZXNzYWdlIHRv
IHJlZmxlY3QgdGhlIHJlYWxpdHksIGxpa2UgdGhpczoKPgo+ICJXaGlsZSBhdCBpdCwgbW9kaWZ5
IHRoZSB2YWx1ZSBvZiB0ZXN0LnRjbnQgYXMgMSB0byBza2lwIG9ubHkKPiBvbmNlIGlmIHRoZSBl
cnJubyBvZiBnZXRybGltaXRfdWxvbmcoKSBpcyBFTk9TWVMuIgo+CgpJbmRlZWQsIGZpeGVkIGl0
LgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
