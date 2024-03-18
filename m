Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195EFC54E58
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 07:26:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68C9A3CE734
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 08:26:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89DBB3CDC00
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 08:26:21 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 03DDB60085E
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 08:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710746778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vC3MiROmnS7rtZfUd+Ke4eetwUeUpwMN9DkkGod9+K4=;
 b=bQpbwha05rkc7KJFpw8caAlZh0paXlmBBHfKXQD6O/7sWvS5IuIzIy5cFaDWksu/NJwdfw
 B2OrlN2298cDGpCLOpgEPgHLBBwA+E4nBFJeR60T4VUKG94cS1Kkqkd0gOHXAQjxToM8Cx
 mZNJaBnhq5y18qtCzTWgEDGQIoC1R5w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-bQlK83RVOjmrPnUB-ZELgw-1; Mon, 18 Mar 2024 03:26:15 -0400
X-MC-Unique: bQlK83RVOjmrPnUB-ZELgw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29de8002b0bso2574827a91.3
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 00:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710746773; x=1711351573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vC3MiROmnS7rtZfUd+Ke4eetwUeUpwMN9DkkGod9+K4=;
 b=YSI5hz7lj+cHK37I9QfZxUWlJypejEaunDsfPVpXwpHFaesSR6qrjEK8OuYFSjlC7q
 t/UpXOyaHrFCm4dEnxc7b24vdgg2w/e7l90kWwROtzHcFvVEcCZkr+qOYS//dvEaJjQ1
 usBtxhhxcUqxHN1WFGtJa81YiTJxnZatjvwAqKlItSYpKEGlnZo7Wldt0lJtaJTah16t
 UitTMC15YjL0pj2uy2aZW3WNYYbLVcJWLIutyRW15gc1i4gupjmLbaxeyabu8s6RGXqi
 iHWtZBD2IAgR8pRMwUHNVB1pdKBH855keqe00wtmK6UUoDhFqL6dOzcXNKIa2EbnxqeJ
 EP4w==
X-Gm-Message-State: AOJu0YzFCkCxT9IkSXySLVLZuLYG2JkyLY5ybZ6ejvADdwrJKy1rv7J9
 yffg77nDXs7oxVjPF5QPBBRur2300SVEIMQHKJQDL1/49FLEY56YwxllBY5PBr5LHm9Gpo82ucQ
 bHvXD4BBgzm9c+eqvqqZO5zkX6WLbMzteLAKpal6/Y8KGT+J0s4raWBnDF4kVCkDTWxQDD7qv0/
 Ot7Jbwr0wwSO7hMZ8Bou0/G8tAbw3bv3ZQSA==
X-Received: by 2002:a17:90b:1bcc:b0:29f:9548:4932 with SMTP id
 oa12-20020a17090b1bcc00b0029f95484932mr1563720pjb.3.1710746773360; 
 Mon, 18 Mar 2024 00:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIq1gufiaBIxvwQZ8Lyjskgb2FFZqlJdFsL6nx7uV80WWCOAgs2uJeZ5ByC0FEwPfx8O1DyvoKAUhjHOO/znA=
X-Received: by 2002:a17:90b:1bcc:b0:29f:9548:4932 with SMTP id
 oa12-20020a17090b1bcc00b0029f95484932mr1563716pjb.3.1710746773081; Mon, 18
 Mar 2024 00:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2cTzLuJ1uTBNbUB-E7kJPeHjx3sPi1crkqTCJ6h4DgSbg@mail.gmail.com>
 <20240315062448.3181177-1-liwang@redhat.com>
 <ZfP8YEwKpLGweAe1@wegao.29.253.26>
 <CAEemH2e5BB=L6-uT25ppcjGnXqJu7U-MmTCNdFsu8FE3sGv=Lw@mail.gmail.com>
 <ZfQoVC7xBfGHNsgI@wegao.157.234.177>
 <CAEemH2d_DgJwFrnu2e91ip6FhdDPjYddCQNsqnf=dA5QjuW_qg@mail.gmail.com>
 <ZfezDUSKwUdoSamA@wegao.215.20.80>
 <CAEemH2cLfO9nMnOdB3wTuK6bmkfsPJp_fdQOXSFU-SfHfdQSZA@mail.gmail.com>
 <Zffm+yWYrGhyVTsf@wegao.213.190.243>
In-Reply-To: <Zffm+yWYrGhyVTsf@wegao.213.190.243>
From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Mar 2024 15:26:00 +0800
Message-ID: <CAEemH2e4iC1+dViTu4WgNz4-BOTg+f9+9sggy+WKhK+ZsCQmvQ@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] swapon01: swapon01: prevent OOM happening in swap
 process
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

T24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgMzowMuKAr1BNIFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29t
PiB3cm90ZToKCj4gT24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgMDI6MzI6NDFQTSArMDgwMCwgTGkg
V2FuZyB3cm90ZToKPiA+IE9uIE1vbiwgTWFyIDE4LCAyMDI0IGF0IDExOjIw4oCvQU0gV2VpIEdh
byA8d2VnYW9Ac3VzZS5jb20+IHdyb3RlOgo+ID4KPiA+ID4gT24gU3VuLCBNYXIgMTcsIDIwMjQg
YXQgMDU6NTI6MDFQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToKPiA+ID4gPiBIaSBXZWksCj4gPiA+
ID4KPiA+ID4gPiBDYW4geW91IHRyeSB0aGlzIG9uZSBhbmQgcG9zdCB0aGUgdGVzdCBsb2cgaGVy
ZT8KPiA+ID4gPgo+ID4gPiA+IEFuZCBhZ2FpbiwgaXQnZCBiZSBoZWxwZnVsIHRvIGtub3cgdGhl
IGNvbmZpZyBvZiB5b3VyIFNVVC4KPiA+ID4gPiBlLmcuIGBmcmVlIC1oYCAgYGxzY3B1YCAgYHVu
YW1lIC1yYCAgaW5mb2Zvcm1hdGlvbgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiAtLS0gYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4gPiA+ID4gKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ID4gPiA+IEBAIC0zNywx
MSArMzcsMjAgQEAgc3RhdGljIHZvaWQgdmVyaWZ5X3N3YXBvbih2b2lkKQo+ID4gPiA+Cj4gPiA+
ID4gIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gPiA+ID4gIHsKPiA+ID4gPiArICAgICAgIHRz
dF9lbmFibGVfb29tX3Byb3RlY3Rpb24oMCk7Cj4gPiA+ID4gICAgICAgICBpc19zd2FwX3N1cHBv
cnRlZChTV0FQX0ZJTEUpOwo+ID4gPiA+IC0gICAgICAgbWFrZV9zd2FwZmlsZShTV0FQX0ZJTEUs
IDEwLCAwKTsKPiA+ID4gPiArICAgICAgIG1ha2Vfc3dhcGZpbGUoU1dBUF9GSUxFLCAxMDI0LCAw
KTsKPiA+ID4gPgo+ID4gPiA+ICAgICAgICAgU0FGRV9DR19QUklOVEYodHN0X2NnLCAiY2dyb3Vw
LnByb2NzIiwgIiVkIiwgZ2V0cGlkKCkpOwo+ID4gPiA+ICAgICAgICAgU0FGRV9DR19QUklOVEYo
dHN0X2NnLCAibWVtb3J5Lm1heCIsICIlbHUiLCBURVNUTUVNKTsKPiA+ID4gPiArCj4gPiA+ID4g
KyAgICAgICBpZiAoU0FGRV9DR19IQVModHN0X2NnLCAibWVtb3J5LnN3YXAubWF4IikpCj4gPiA+
ID4gKyAgICAgICAgICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgIm1lbW9yeS5zd2FwLm1h
eCIsICIlbGQiLAo+IFRFU1RNRU0KPiA+ID4gKgo+ID4gPiA+IDIpOwo+ID4gPiA+ICt9Cj4gPiA+
ID4gKwo+ID4gPiA+ICtzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gPiA+ID4gK3sKPiA+ID4g
PiArICAgICAgIHRzdF9kaXNhYmxlX29vbV9wcm90ZWN0aW9uKDApOwo+ID4gPiA+ICB9Cj4gPiA+
ID4KPiA+ID4gPiAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ID4gPiA+IEBAIC01
MSw1ICs2MCw2IEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+ID4gPiAgICAg
ICAgIC5hbGxfZmlsZXN5c3RlbXMgPSAxLAo+ID4gPiA+ICAgICAgICAgLm5lZWRzX2Nncm91cF9j
dHJscyA9IChjb25zdCBjaGFyICpjb25zdCBbXSl7ICJtZW1vcnkiLCBOVUxMCj4gfSwKPiA+ID4g
PiAgICAgICAgIC50ZXN0X2FsbCA9IHZlcmlmeV9zd2Fwb24sCj4gPiA+ID4gLSAgICAgICAuc2V0
dXAgPSBzZXR1cAo+ID4gPiA+ICsgICAgICAgLnNldHVwID0gc2V0dXAsCj4gPiA+ID4gKyAgICAg
ICAuY2xlYW51cCA9IGNsZWFudXAKPiA+ID4gPiAgfTsKPiA+ID4gPgo+ID4gPiA+Cj4gPgo+ID4K
PiA+Cj4gPiA+Cj4gPiA+IGxvY2FsaG9zdDp+ICMgZnJlZSAtaCA8PDw8IGJlZm9yZSBydW5uaW5n
IGNhc2UKPiA+ID4gICAgICAgICAgICAgICAgdG90YWwgICAgICAgIHVzZWQgICAgICAgIGZyZWUg
ICAgICBzaGFyZWQgIGJ1ZmYvY2FjaGUKPiA+ID4gIGF2YWlsYWJsZQo+ID4gPiBNZW06ICAgICAg
ICAgICAzLjhHaSAgICAgICA0NzhNaSAgICAgICAzLjNHaSAgICAgICA5LjBNaSAgICAgICAzNDZN
aQo+ID4gPiAgMy40R2kKPiA+ID4gU3dhcDogICAgICAgICAgICAgMEIgICAgICAgICAgMEIgICAg
ICAgICAgMEIKPiA+ID4KPiA+Cj4gPiBJIHNlZSwgaXQgaXMgdmVyeSBsaWtlbHkgdGhhdCB5b3Vy
IHN5c3RlbSBoYXMgbm8gc3dhcCBzcGFjZQo+ID4gc28gdGhhdCB0aGUgVEVTVE1FTSgxR0IpIGNh
biBub3QgYmUgc3dhcHBlZCBvdXQsIHRoZW4KPiA+IE9PTSBraWxsZXIgaGFzIHRvIGJlIGNhbGxl
ZCBvdXQuCj4gPgo+ID4gSSBjYW4gcmVwcm9kdWNlIHlvdXIgcHJvYmxlbSBieSBkaXNhYmxpbmcg
YWxsIHN3YXAgZmlsZXMgb24gbXkgc3lzdGVtLgo+ID4KPiA+IFNvIHRoZSBwb3NzaWJsZSBmaXgg
d2F5IGlzIHRvIHJlZHVjZSB0aGUgVEVTVE1FTSBzaXplIGFuZCBpbmNyZWFzZQo+ID4gdGhlIHRl
c3RlZCBzd2FwZmlsZS4KPiA+Cj4gPiBJIGd1ZXNzIHRoaXMgcGF0Y2ggY2FuIHdvcmsgZm9yIHlv
dSwgaGF2ZSBhIHRyeT8KPgo+IE5vIG9vbSwgYnV0IFN3YXBDYWNoZWQgc2l6ZSBpcyB1bnN0YWJs
ZSwgbW9zdCBvZiB0aW1lIGlzIHN0aWxsIDAKPgoKClRoYXQncyBiZWNhdXNlIHRoZSBhdmFpbGFi
bGUgc3dhcGZpbGUgb24geW91ciBTVVQgaXMgdG9vIHNtYWxsLAp5b3UgY2FuIGFkanVzdCBpdCAo
dGhlbiByZXRlc3QgaXQpIGJ5IHlvdXJzZWxmIHRvIGZpbmQgYSBwcm9wZXIgc2l6ZS4KClRoaXMg
aXMgZmluZSBhcyBsb25nIGFzIHRoZSBzd2FwZmlsZSBzaXplIGlzIGxlc3MgdGhhbiAzMDBNQiwK
b3RoZXJ3aXNlIHdlIG5lZWQgdG8gc2V0IC5kZXZfbWluX3NpemUgbGlrZSB3aGF0IHdlIGRpZApm
b3Igc3dhcG9mZjAxLmMuCgpBbmQsIG9uIHRoZSBvdGhlciBzaWRlLCB3ZSBjYW4ndCBndWFyYW50
ZWUgdGhlIHN5c3RlbSBTd2FwQ2FjaGVkCmhhcHBlbmVkIGV2ZXJ5IHRpbWUsIGl0IGRlcGVuZHMg
b24gdGhlIHN5c3RlbSdzIGNvbmZpZ3VyYXRpb24uCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
