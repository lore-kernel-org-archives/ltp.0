Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EC2D1CDC6
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 13:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765286507; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Vj3pa6NOeY0EZ7OIhX4E6ijupONgNlvYHwUxJislCKc=;
 b=MMaWGXLuFIrT4RqjbpujlQP/3U1vxpV9D97Nm3td2cZMT/qof4UYbfheQEZQWhZ9IPI2W
 rb5kuJ2T/o8b75sN9yC1d6fkK6kJdJjCcE8zWvxDc7vRbiAFQbg85PpVmVuKYl0+nxcVqUB
 ys0rpXgfiLTKsACe1HBBV+NNM/Pc+8E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E412F3D0258
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 14:21:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 049FB3CF578
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 14:21:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6009C600636
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 14:21:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765286483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9221DXHRhGB7tnfhDi+Fak2xKlEXwOpQzO+hopMWHOw=;
 b=LA/wtdaj3YoXd8JyzKtqL+3A0fwKyjPAxJddYjG5BykIEixJcq2wupAd0m7tptnKPCab/N
 9L8WqJqjTEwX0oGAwONDMMKwePovcvSSXRuBohnVdIYU8tMtfARH9I/KvfkOPw7iycYqXt
 oF4WYXShsVn0kfrDC4QVKeB0r6TXd64=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-GDt_F1l5PKWvsGLzkpaZCA-1; Tue, 09 Dec 2025 08:21:22 -0500
X-MC-Unique: GDt_F1l5PKWvsGLzkpaZCA-1
X-Mimecast-MFC-AGG-ID: GDt_F1l5PKWvsGLzkpaZCA_1765286481
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b56125e77so2805959f8f.3
 for <ltp@lists.linux.it>; Tue, 09 Dec 2025 05:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765286481; x=1765891281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9221DXHRhGB7tnfhDi+Fak2xKlEXwOpQzO+hopMWHOw=;
 b=dWHGaOTcfhGRtkLZaOPJunDusGI3Q56inAg8NeJCq1U8d0j36kXeD9u8E3P6qqm1yn
 PxDzYUBzhqLFL4SJOlEkGXeNKBxXkEjzJM8jDRpIiVowLMX3ttQ2kAhAAailfem1sk0f
 KYYGOMMr1JDq2/U5/kLAQZIg/DNMdnhxsLdBvQ2gBLIUe5E8QTceoXmcGvAXpQ1i6nEg
 ZwZ79tXfh5rGYcxDwSqy8gO9i9YP9Tk44eZIZDR0esUAYvLj9SajImuaa3kWtHM2avfe
 Gtre7cEhrLVuTomdo9hwltep655DBdqk5Kq7S/l5g0vuasRI+eCBpfU+afNOOGZXSgzf
 4ZAw==
X-Gm-Message-State: AOJu0YyFHTxjA06bJTjZbsivOWwdyI18s8+c5cFnSLCYTldHSY1ptk8G
 VHcWvn2JQUCdKqSvby7Mqzz32WGKLiEauMp4KeoXYAXlvpf2TPxqjV7zsjNNajnxaLcXwJylewm
 A+HwPlzvOclQFCjw8YKzp1kmHYzNn4zM64dbVnIwTmeTUy7tEfVwL4EwfTKFwz86gQm8FQ6V8L9
 F3E94qzgnME9QU/hf0jxMsKPR67fX7JsiL+hLZcA==
X-Gm-Gg: AY/fxX79WAnTpG8/2xx14izPon4Xa/iSnelsl/To5YV3B2PX19vhAlv5aQSandDuPdp
 Oh6Rqpal6XofDzlXdc0TCrNtokWPjIx0TfGLOhhkWfsO7SdQa93PdvkMQrP5MS+LjW3K5rgHZPs
 KUv7eTGkSX0XbdwizhMRbRgbRE0KSnsJIKwzerm0h9OFv/vVkUQrKMmQuWNtlmr+UodQ==
X-Received: by 2002:a05:6000:2884:b0:429:f14a:9807 with SMTP id
 ffacd0b85a97d-42f89f6348amr10923296f8f.40.1765286480725; 
 Tue, 09 Dec 2025 05:21:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEypoPctfetyaFDUjG4qXAtQCardO4o2sDqXs1wbHEOHEec2a3JPvGzPuhLuSVY7Kj8BWczjtA88zJ75icnZH0=
X-Received: by 2002:a05:6000:2884:b0:429:f14a:9807 with SMTP id
 ffacd0b85a97d-42f89f6348amr10923269f8f.40.1765286480268; Tue, 09 Dec 2025
 05:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20251209120246.18435-1-chrubis@suse.cz>
In-Reply-To: <20251209120246.18435-1-chrubis@suse.cz>
Date: Tue, 9 Dec 2025 14:21:03 +0100
X-Gm-Features: AQt7F2oEC87q6U4MePRjIofgwawCpQ-FznZekidokMOSsYEOxnx4WNIrfKGNT6k
Message-ID: <CAASaF6yCjh6i9bm5WU4p7TmW4xNSD9+QkB=BfMWSbm_4Hvgptw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MXAbZ_9tW9ksZgJv51BiFvM-egYBkfwePX4UtCyjrXw_1765286481
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: Add ground rules page
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBEZWMgOSwgMjAyNSBhdCAxOjAy4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gVGhpcyBpcyBhIGNvbnRpbnVlZCBlZmZvcnQgdG8gd3JpdGUgZG93
biB0aGUgdW53cml0dGVuIHJ1bGVzIHdlIGhhdmUgaW4KPiB0aGUgcHJvamVjdC4gRmVlbCBmcmVl
IHRvIHN1Z2dlc3QgbW9yZSB0b3BpY3MgZm9yIHRoZSBwYWdlLgo+Cj4gU2lnbmVkLW9mZi1ieTog
Q3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+CgpBY2tlZC1ieTogSmFuIFN0YW5jZWsgPGpz
dGFuY2VrQHJlZGhhdC5jb20+CgpJIGRvbid0IHJlY2FsbCBpZiB3ZSBoYXZlIGl0IG1lbnRpb25l
ZCBhbHJlYWR5LCBidXQgd2UgYWxzbyB1c2VkIHRvIHNheSB0aGF0CmNoYW5nZXMgaW50cm9kdWNl
ZCBpbiBlYXJseSBrZXJuZWwgLXJjICBidWlsZHMgd2VyZSBsb3cgcHJpb3JpdHkgZm9yIGFjY2Vw
dGFuY2UKYW5kIHdlIGZhdm9yZWQgYmVoYXZpb3IgdGhhdCBpcyBpbiBhIHJlbGVhc2VkIGtlcm5l
bCAob3IgYXQgbGVhc3QgaW4gbGFzdCAtcmNzKS4KCj4gLS0tCj4gIGRvYy9kZXZlbG9wZXJzL2dy
b3VuZF9ydWxlcy5yc3QgfCA2OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAg
ZG9jL2luZGV4LnJzdCAgICAgICAgICAgICAgICAgICB8ICAxICsKPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA2OSBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2MvZGV2ZWxvcGVycy9n
cm91bmRfcnVsZXMucnN0Cj4KPiBkaWZmIC0tZ2l0IGEvZG9jL2RldmVsb3BlcnMvZ3JvdW5kX3J1
bGVzLnJzdCBiL2RvYy9kZXZlbG9wZXJzL2dyb3VuZF9ydWxlcy5yc3QKPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMC4uNzAxZGNkMDlhCj4gLS0tIC9kZXYvbnVsbAo+ICsr
KyBiL2RvYy9kZXZlbG9wZXJzL2dyb3VuZF9ydWxlcy5yc3QKPiBAQCAtMCwwICsxLDY4IEBACj4g
Ky4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gKwo+ICtHcm91
bmQgUnVsZXMKPiArPT09PT09PT09PT09Cj4gKwo+ICtEbyBub3Qgd29yayBhcm91bmQga2VybmVs
IGJ1Z3MKPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gKwo+ICtXZSBoYXZlIGRl
Y2lkZWQgd2hhdCB3ZSB3aWxsIG5vdCB3b3JrIGFyb3VuZCBidWdzIGluIHVwc3RyZWFtIExUUCBz
b3VyY2VzLiBJZiBhCj4gK3Rlc3QgZmFpbHMgb24geW91ciBzeXN0ZW0gZm9yIGEgZ29vZCByZWFz
b24sIGUuZy4gcGF0Y2ggd2Fzbid0IGJhY2twb3J0ZWQgYW5kCj4gK3RoZSBidWcgaXMgcHJlc2Vu
dCwgd29yayBhcm91bmQgZm9yIHRoaXMgd2lsbCBub3QgYmUgYWNjZXB0ZWQgdXBzdHJlYW0uIFRo
ZQo+ICttYWluIHJlYXNvbiBmb3IgdGhpcyBkZWNpc2lvbiBpcyB0aGF0IHRoaXMgbWFza3MgdGhl
IGZhaWx1cmUgZm9yIGV2ZXJ5b25lIGVsc2UuCj4gKwo+ICsKPiArRG8gbm90IHN5bmNocm9uaXpl
IGJ5IHNsZWVwCj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICsKPiArV2h5IGlzIHNs
ZWVwIGluIHRlc3RzIGJhZCB0aGVuPwo+ICtgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBgYGBg
Cj4gKwo+ICtUaGUgZmlyc3QgcHJvYmxlbSBpcyB0aGF0IGl0IG1heSBhbmQgd2lsbCBpbnRyb2R1
Y2UgdmVyeSByYXJlIHRlc3QgZmFpbHVyZXMsCj4gK3RoYXQgbWVhbnMgc29tZWJvZHkgaGFzIHRv
IHNwZW5kIHRpbWUgbG9va2luZyBpbnRvIHRoZXNlLCB3aGljaCBpcyBhIHdhc3RlZAo+ICtlZmZv
cnQuIEFsc28gSSdtIHByZXR0eSBzdXJlIHRoYXQgbm9ib2R5IGxpa2VzIHRlc3RzIHRoYXQgd2ls
bCBmYWlsIHJhcmVseSBmb3IKPiArbm8gZ29vZCByZWFzb24uIEV2ZW4gbW9yZSBzbyB5b3UgY2Fu
bm90IHJ1biBzdWNoIHRlc3RzIHdpdGggYSBiYWNrZ3JvdW5kIGxvYWQKPiArdG8gZW5zdXJlIHRo
YXQgZXZlcnl0aGluZyB3b3JrcyBjb3JyZWN0bHkgb24gYSBidXNzeSBzeXN0ZW0sIGJlY2F1c2Ug
dGhhdCB3aWxsCj4gK2luY3JlYXNlIHRoZSBsaWtlaG9vZCBvZiBhIGZhaWx1cmUuCj4gKwo+ICtU
aGUgc2Vjb25kIHByb2JsZW0gaXMgdGhhdCB0aGlzIHdhc3RlcyByZXNvdXJjZXMgYW5kIHNsb3du
cyBkb3duIGEgdGVzdCBydW4uIElmCj4gK3lvdSB0aGluayB0aGF0IGFkZGluZyBhIHNsZWVwIHRv
IGEgdGVzdCBpcyBub3QgYSBiaWcgZGVhbCwgbGV0IG1lIHB1dCB0aGluZ3MKPiAraW50byBhIHBl
cnNwZWN0aXZlLiBUaGVyZSBpcyBhYm91dCAxNjAwIHN5c2NhbGwgdGVzdHMgaW4gTGludXggVGVz
dCBQcm9qZWN0Cj4gKyhMVFApLCBpZiA3LjUlIG9mIHRoZW0gd291bGQgc2xlZXAganVzdCBmb3Ig
b25lIHNlY29uZCwgd2Ugd291bGQgZW5kIHVwIHdpdGgKPiArdHdvIG1pbnV0ZXMgb2Ygd2FzdGVk
IHRpbWUgcGVyIHRlc3RydW4uIEluIHByYWN0aWNlIG1vc3Qgb2YgdGhlIHRlc3QgSSd2ZSBzZWVu
Cj4gK3dhaXRlZCBmb3IgbXVjaCBsb25nZXIganVzdCB0byBiZSBzdXJlIHRoYXQgdGhpbmdzIHdp
bGwgd29ya3MgZXZlbiBvbiBzbG93ZXIKPiAraGFyZHdhcmUuIFdpdGggc2xlZXBzIGJldHdlZW4g
MiBhbmQgNSBzZWNvbmRzIHRoYXQgcHV0cyB1cyBzb21ld2hlcmUgYmV0d2VlbiA0Cj4gK2FuZCAx
MCBtaW51dGVzIHdoaWNoIGlzIGJldHdlZW4gMTMlIGFuZCAzMyUgb2YgdGhlIHN5c2NhbGwgcnVu
dGltZSBvbiBteSBkYXRlZAo+ICt0aGlua3BhZCwgd2hlcmUgdGhlIHJ1biBmaW5pc2hlcyBpbiBh
IGJpdCBsZXNzIHRoYW4gaGFsZiBhbiBob3VyLiBJdCdzIGV2ZW4KPiArd29yc2Ugb24gbmV3ZXIg
aGFyZHdhcmUsIGJlY2F1c2UgdGhpcyBzbG93ZG93biB3aWxsIG5vdCBjaGFuZ2Ugbm8gbWF0dGVy
IGhvdwo+ICtmYXN0IHlvdXIgbWFjaGluZSBpcywgd2hpY2ggaXMgbWF5YmUgdGhlIHJlYXNvbiB3
aHkgdGhpcyB3YXMgYWNjZXB0YWJsZSB0d2VudHkKPiAreWVhcnMgYWdvIGJ1dCBpdCdzIG5vdCBu
b3cuCj4gKwo+ICsKPiArV2hhdCB0byBkbyBpbnN0ZWFkPwo+ICtgYGBgYGBgYGBgYGBgYGBgYGBg
Cj4gKwo+ICtVc2UgcHJvcGVyIHN5bmNocm9uaXphdGlvbi4KPiArCj4gK1RoZXJlIGFyZSBkaWZm
ZXJlbnQgcHJvYmxlbXMgYW5kIGRpZmZlcmVudCBzb2x1dGlvbnMuCj4gKwo+ICtNb3N0IG9mdGVu
IHRlc3RzIG5lZWRzIHRvIHN5bmNocm9uaXplIGJldHdlZW4gY2hpbGQgYW5kIHBhcmVudCBwcm9j
ZXMuCj4gKwo+ICtUaGUgZWFzaWVzdCBjYXNlIGlzIHRoYXQgcGFyZW50IG5lZWRzIHRvIHdhaXQg
Zm9yIGEgY2hpbGQgdG8gZmluaXNoLCB0aGF0IGNhbgo+ICtiZSBmaXhlZCBqdXN0IGJlIGFkZGlu
ZyBhIHdhaXRwaWQoKSBpbiB0aGUgcGFyZW50IHdoaWNoIGVuc3VyZXMgdGhhdCBjaGlsZCBpcwo+
ICtmaW5pc2hlZCBiZWZvcmUgcGFyZW50IHJ1bnMuCj4gKwo+ICtDb21tb25seSBjaGlsZCBoYXMg
dG8gZXhlY3V0ZSBjZXJ0YWluIHBpZWNlIG9mIGNvZGUgYmVmb3JlIHBhcmVudCBjYW4gY29udGlu
dWUuCj4gK0ZvciB0aGF0IExUUCBsaWJyYXJ5IGltcGxlbWVudHMgY2hlY2twb2ludHMgd2l0aCBz
aW1wbGUgd2FpdCBhbmQgd2FrZSBmdW5jdGlvbnMKPiArYmFzZWQgb24gZnV0ZXhlcyBvbiBhIHBp
ZWNlIG9mIHNoYXJlZCBtZW1vcnkgc2V0IHVwIGJ5IHRoZSB0ZXN0IGxpYnJhcnkuCj4gKwo+ICtB
bm90aGVyIGNvbW1vbiBjYXNlIGlzIHdoZXJlIGNoaWxkIG11c3Qgc2xlZXAgaW4gYSBzeXNjYWxs
IGJlZm9yZSBwYXJlbnQgY2FuCj4gK2NvbnRpbnVlLCBmb3Igd2hpY2ggd2UgaGF2ZSBhIGhlbHBl
ciB0aGF0IHBvbGxzIC9wcm9jLyRQSUQvc3RhdC4KPiArCj4gK0xlc3Mgb2Z0ZW4gdGVzdHMgbmVl
ZHMgdG8gd2FpdCBmb3IgYW4gYWN0aW9uIHRoYXQgaXMgZG9uZSBhc3luY2hyb25vdXNseSwgb3Ig
YQo+ICtrZXJuZWwgcmVzb3VyY2UgZGVhbGxvY2F0aW9uIGlzIGRlZmZlcmVkIHRvIGEgbGF0ZXIg
dGltZS4gSW4gc3VjaCBjYXNlcyB0aGUKPiArYmVzdCB3ZSBjYW4gZG8gaXMgdG8gcG9sbC4gSW4g
TFRQIHdlIGVuZGVkIHVwIHdpdGggYSBtYWNybyB0aGF0IHBvbGxzIGJ5Cj4gK2NhbGxpbmcgYSBw
aWVjZSBvZiBjb2RlIGluIGEgbG9vcCB3aXRoIGV4cG9uZW50aWFsbHkgaW5jcmVhc2luZyBzbGVl
cHMgYmV0d2Vlbgo+ICtyZXRyaWVzIHVudGlsIGl0IHN1Y2NlZWVkcy4gV2hpY2ggbWVhbnMgdGhh
dCBpbnN0ZWFkIG9mIHNsZWVwaW5nIGZvciBhIG1heGltYWwKPiArdGltZSBldmVudCBjYW4gcG9z
c2libHkgdGFrZSB0aGUgc2xlZXAgaXMgY2FwcGVkIGJ5IHR3aWNlIG9mIHRoZSBvcHRpbWFsCj4g
K3NsZWVwaW5nIHRpbWUgd2hpbGUgd2UgYXZvaWQgcG9sbGluZyB0b28gYWdncmVzc2l2ZWx5Lgo+
IGRpZmYgLS1naXQgYS9kb2MvaW5kZXgucnN0IGIvZG9jL2luZGV4LnJzdAo+IGluZGV4IDA2Yjc1
NjE2Zi4uNjU5NTQ5Y2MzIDEwMDY0NAo+IC0tLSBhL2RvYy9pbmRleC5yc3QKPiArKysgYi9kb2Mv
aW5kZXgucnN0Cj4gQEAgLTE5LDYgKzE5LDcgQEAKPiAgICAgOmhpZGRlbjoKPiAgICAgOmNhcHRp
b246IEZvciBkZXZlbG9wZXJzCj4KPiArICAgZGV2ZWxvcGVycy9ncm91bmRfcnVsZXMKPiAgICAg
ZGV2ZWxvcGVycy9zZXR1cF9tYWlsaW5nbGlzdAo+ICAgICBkZXZlbG9wZXJzL3dyaXRpbmdfdGVz
dHMKPiAgICAgZGV2ZWxvcGVycy90ZXN0X2Nhc2VfdHV0b3JpYWwKPiAtLQo+IDIuNTEuMgo+Cj4K
PiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
