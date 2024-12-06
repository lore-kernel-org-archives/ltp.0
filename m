Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4027CE77173
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 10:55:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CBC03E6BF3
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 11:55:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6AE33E6249
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 11:55:38 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3BB7E101D8F6
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 11:55:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733482535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Th6XpgY/+4Bi9ZWRW4Yy+jc0MeWU868UM0mdzIgAQU=;
 b=BDb8WLgntgmj9t2RQTqD7NjHfF3kqAygEITvjPlJk9q5mMto2vLdbvORXW+I06Uj2EZYow
 z4P97kcYBS+gf6yyomz1suXpcAZpVOSdbKWZSeMlKkq5UUQ7OeqXkHyNC/Mn11EqGHvt5i
 0fg5Qna5pdRjbpRiQG4Lof1Lvkd0loo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-12jKFDwtMX2ERPE_CJuHBw-1; Fri, 06 Dec 2024 05:55:34 -0500
X-MC-Unique: 12jKFDwtMX2ERPE_CJuHBw-1
X-Mimecast-MFC-AGG-ID: 12jKFDwtMX2ERPE_CJuHBw
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-71d4e96eebfso1127712a34.3
 for <ltp@lists.linux.it>; Fri, 06 Dec 2024 02:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733482533; x=1734087333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Th6XpgY/+4Bi9ZWRW4Yy+jc0MeWU868UM0mdzIgAQU=;
 b=UTv7UnNkImYFlzP5tHXVjCV3FGnr+tKkq7Xbjyf6zdL4rVk2Cl6YCiKCtXkJ9ILCdl
 FKHn1KjFXMtt9GLDaOcivWHzBADR4GpGZ99IhlO9txYPFDRSJfCO3tuplUMVs0rePB2g
 WhQ/kkJJxLkp4hm8ZQZ1ZR4SC5axJSy9PcYF7CGUkKp2c1qVZi4K2ybddJaSNYIMNRZs
 5hJy97CBjdoMnBFZ9I/WC2ns20osw28z1UxaAx6GqctdP+C3VOdH0GZlzc5KW1yKc0RV
 V3+bQGP62hmo9sT+QG3vH0IGNVW7102dw2ioF8apdQKwKYPQXKjXsXt1+na1Bz4YjLYd
 +mVw==
X-Gm-Message-State: AOJu0YzUIpgE71ls+WEDC/Rcwonl936yySBPm3fUkSL7aiO4Whih3lX0
 Qxx44kvPhthhHfoIQ+NuTpi+U7LeFPXqTfIyrtSwIo9TQd4w9llbSpNs/WYd95VgTa4zZkMPk5e
 SdxmPQdIO3TE34DdKA65ukKEhNn/cYb1MVmgBDLINpiZLBAss/+4tRJfyXMdbQajXkLRnc1Cn63
 c8QDQuaWQSH30Sw0GkKmVA7us=
X-Gm-Gg: ASbGncvkY5SxqtNWM5F6hhplqqf/RxIqmP/Jhfo4sPlc8zYR6skHNOrETw6GbTLlyq3
 spsq1elWDFGeFdO8LxX7xxXvsw4QVgvM=
X-Received: by 2002:a05:6830:6014:b0:718:ab4:8b70 with SMTP id
 46e09a7af769-71dcf53d595mr1313355a34.22.1733482533368; 
 Fri, 06 Dec 2024 02:55:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEEEN/xNC58Zf18WkOj79GL0kA7VhAS5qTCkdsXt5tQaptXr/QScI9D8O8fnVmGI9M/vtfJt6WKZW1Lj0PkTM=
X-Received: by 2002:a05:6830:6014:b0:718:ab4:8b70 with SMTP id
 46e09a7af769-71dcf53d595mr1313343a34.22.1733482532920; Fri, 06 Dec 2024
 02:55:32 -0800 (PST)
MIME-Version: 1.0
References: <e1dc1e7f686bfed84f048294b3f3608e2f3e9491.1733321853.git.jstancek@redhat.com>
 <Z1LTvZEBUvK744Ye@yuki.lan>
In-Reply-To: <Z1LTvZEBUvK744Ye@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 6 Dec 2024 11:55:17 +0100
Message-ID: <CAASaF6zaAZ4cdRs1V9cumnHShubKKXvU=spT4+jOKgdX1jGTNg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tspt49mNFtA4N02hIrpyp8OgSnCi6cePBjyGNg1G-BI_1733482533
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/getrandom05: use tst_syscall
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBEZWMgNiwgMjAyNCBhdCAxMTozNuKAr0FNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gV2l0aCBnbGliYy0yLjQwIGFuZCByZWNlbnQga2Vy
bmVsICg2LjEyKSB0aGUgdGVzdCB1c2VzCj4gPiB2ZHNvIGltcGxlbWVudGF0aW9uIHdoaWNoIHJ1
bnMgaW50byBTSUdTRUdWIGZvciBFRkFVTFQgdGVzdDoKPiA+Cj4gPiAgICMwICBfX2FyY2hfY2hh
Y2hhMjBfYmxvY2tzX25vc3RhY2sgKCkgYXQgYXJjaC94ODYvZW50cnkvdmRzby92Z2V0cmFuZG9t
LWNoYWNoYS5TOjE0Ngo+ID4gICAxNDYgICAgICAgICAgICAgbW92dXBzICAgICAgICAgIHN0YXRl
MCwweDAwKG91dHB1dCkKPiA+Cj4gPiAgIChnZGIpIGJ0Cj4gPiAgICMwICBfX2FyY2hfY2hhY2hh
MjBfYmxvY2tzX25vc3RhY2sgKCkgYXQgYXJjaC94ODYvZW50cnkvdmRzby92Z2V0cmFuZG9tLWNo
YWNoYS5TOjE0Ngo+ID4gICAjMSAgMHgwMDAwN2ZjZDNjZTY0MTdhIGluIF9fY3Zkc29fZ2V0cmFu
ZG9tX2RhdGEgKHJuZ19pbmZvPTB4N2ZjZDNjZTVmMjgwLCBidWZmZXI9MHhmZmZmZmZmZmZmZmZm
ZmZmLCBsZW49NjQsIGZsYWdzPTEsIG9wYXF1ZV9zdGF0ZT0weDdmY2QzY2U1ZGYwMCwKPiA+ICAg
ICAgIG9wYXF1ZV9sZW49PG9wdGltaXplZCBvdXQ+KSBhdCBhcmNoL3g4Ni9lbnRyeS92ZHNvLy4u
Ly4uLy4uLy4uL2xpYi92ZHNvL2dldHJhbmRvbS5jOjIzNwo+ID4gICAjMiAgX19jdmRzb19nZXRy
YW5kb20gKGJ1ZmZlcj08b3B0aW1pemVkIG91dD4sIGxlbj02NCwgZmxhZ3M9MSwgb3BhcXVlX3N0
YXRlPTB4N2ZjZDNjZTVkZjAwLCBvcGFxdWVfbGVuPTxvcHRpbWl6ZWQgb3V0PikKPiA+ICAgICAg
IGF0IGFyY2gveDg2L2VudHJ5L3Zkc28vLi4vLi4vLi4vLi4vbGliL3Zkc28vZ2V0cmFuZG9tLmM6
MjU5Cj4gPiAgICMzICBfX3Zkc29fZ2V0cmFuZG9tIChidWZmZXI9MHhmZmZmZmZmZmZmZmZmZmZm
LCBsZW49NjQsIGZsYWdzPTEsIG9wYXF1ZV9zdGF0ZT0weDdmY2QzY2U1ZGYwMCwgb3BhcXVlX2xl
bj08b3B0aW1pemVkIG91dD4pCj4gPiAgICAgICBhdCBhcmNoL3g4Ni9lbnRyeS92ZHNvL3ZnZXRy
YW5kb20uYzoxMQo+ID4gICAjNCAgMHgwMDAwN2ZjZDNjYzdmYWYzIGluIGdldHJhbmRvbV92ZHNv
IChidWZmZXI9MHhmZmZmZmZmZmZmZmZmZmZmLCBsZW5ndGg9NjQsIGZsYWdzPTAsIGNhbmNlbD08
b3B0aW1pemVkIG91dD4pCj4gPiAgICAgICBhdCAuLi9zeXNkZXBzL3VuaXgvc3lzdi9saW51eC9n
ZXRyYW5kb20uYzoyMDQKPiA+ICAgIzUgIDB4MDAwMDAwMDAwMDQwMWZmNyBpbiB2ZXJpZnlfZ2V0
cmFuZG9tIChpPTApIGF0IGdldHJhbmRvbTA1LmM6NDAKPiA+Cj4gPiBDaGFuZ2UgdGhlIHRlc3Qg
dG8gdXNlIHN5c2NhbGwgaW1wbGVtZW50YXRpb24gb2YgZ2V0cmFuZG9tKCkuCj4gPgo+ID4gU2ln
bmVkLW9mZi1ieTogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+
ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJhbmRvbS9nZXRyYW5kb20wNS5jIHwgMyAr
Ky0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4g
Pgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cmFuZG9tL2dl
dHJhbmRvbTA1LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJhbmRvbS9nZXRyYW5k
b20wNS5jCj4gPiBpbmRleCA5MjA5OGRlYjcyM2QuLjhmN2NlNDU3ODVjNSAxMDA2NDQKPiA+IC0t
LSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cmFuZG9tL2dldHJhbmRvbTA1LmMKPiA+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cmFuZG9tL2dldHJhbmRvbTA1LmMK
PiA+IEBAIC0xNiw2ICsxNiw3IEBACj4gPgo+ID4gICNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ID4g
ICNpbmNsdWRlICJsYXBpL2dldHJhbmRvbS5oIgo+ID4gKyNpbmNsdWRlICJsYXBpL3N5c2NhbGxz
LmgiCj4gPgo+ID4gIHN0YXRpYyBjaGFyIGJ1ZmZfZWZhdWx0WzY0XTsKPiA+ICBzdGF0aWMgY2hh
ciBidWZmX2VpbnZhbFs2NF07Cj4gPiBAQCAtMzYsNyArMzcsNyBAQCBzdGF0aWMgdm9pZCB2ZXJp
ZnlfZ2V0cmFuZG9tKHVuc2lnbmVkIGludCBpKQo+ID4gIHsKPiA+ICAgICAgIHN0cnVjdCB0ZXN0
X2Nhc2VfdCAqdGMgPSAmdGNhc2VzW2ldOwo+ID4KPiA+IC0gICAgIFRTVF9FWFBfRkFJTDIoZ2V0
cmFuZG9tKHRjLT5idWZmLCB0Yy0+c2l6ZSwgdGMtPmZsYWcpLAo+ID4gKyAgICAgVFNUX0VYUF9G
QUlMMih0c3Rfc3lzY2FsbChfX05SX2dldHJhbmRvbSwgdGMtPmJ1ZmYsIHRjLT5zaXplLCB0Yy0+
ZmxhZyksCj4gPiAgICAgICAgICAgICAgIHRjLT5leHBlY3RlZF9lcnJubywgIiVzIiwgdGMtPmRl
c2MpOwo+Cj4gVGhpcyBtZWFucyB0aGF0IHdlIHdpbGwgbm90IGNvdmVyIHRoZSBFSU5WQUwgZXJy
b3IgZm9yIFZEU08gYW55bW9yZS4KPgo+IEFsc28gdGhlIHJlc3Qgb2YgdGhlIHRlc3RzIHNlZW1z
IHRvIHVzZSBzeXNjYWxsIG9ubHksIHdoaWNoIG1lYW5zIHRoYXQKPiB3ZSB3aWxsIG5vdCB0ZXN0
IHRoZSBWRFNPIHRoYXQgaXMgZ29pbmcgdG8gYmUgdXNlZCBieSBkZWZhdWx0LiBJIHN1cHBvc2UK
PiB0aGF0IHdlIHNob3VsZCBhZGQgdGVzdCB2YXJpYW50cyB0byB0aGVzZSB0ZXN0Y2FzZXMgYW5k
IHJ1biB0aGVtIGJvdGgKPiBmb3IgbGliYyBnZXRyYW5kb20oKSBhbmQgdGhlIHN5c2NhbGwgYW5k
IGp1c3Qgc2tpcCB0aGUgRUZBVUxUIGhlcmUgb24KPiBnbGliYy4KClllcywgdGhhdCB3b3VsZCBi
ZSBwcmVmZXJhYmxlIC0ganVzdCB3YW50ZWQgdG8gYWRkcmVzcyB0aGlzIGZhaWx1cmUgcXVpY2ts
eS4KSSdsbCBsb29rIGF0IGFkZGluZyB0aGUgdmFyaWFudHMgdG8gdGhlIHRlc3QuCgo+Cj4gLS0K
PiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
