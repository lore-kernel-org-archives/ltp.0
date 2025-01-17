Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85697C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 07:03:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F1643C7C2A
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 08:03:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17E943C4B72
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 08:03:39 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 12B801032C13
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 08:03:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737097416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZJbOGq50y8QbFpNRKNlK2Yx/wU80TyoFrXzETIAqEM=;
 b=ffdavQCpoQu7gyf9Ha07Y3eS30gWbvEnzcAAMpXJYl0+Lqm8QRBMqOO/JpYvu3LJ6awAOp
 vymUv+HrCBFmrSvEHbovhrisPyeSkr03yTOrFJSfjJNr9jqSC1aJBFL1hR9rNfBVArZHgL
 2xnGZFnnhFsnaNWxBPOw2O1877SSIWY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-ZOaQ7rC5O0OPEMUI1lp8LQ-1; Fri, 17 Jan 2025 02:03:30 -0500
X-MC-Unique: ZOaQ7rC5O0OPEMUI1lp8LQ-1
X-Mimecast-MFC-AGG-ID: ZOaQ7rC5O0OPEMUI1lp8LQ
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2f550d28f7dso3582865a91.3
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 23:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737097410; x=1737702210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JZJbOGq50y8QbFpNRKNlK2Yx/wU80TyoFrXzETIAqEM=;
 b=rxNybMuYwWOqy7oWSBnuoHctotoG8HiPJxDUo4LB+0AfLRENfdPt2gynEZ99APgsiI
 1OBgWLtSxpQ5+/qI6Lo5I7C2wQIAitL6W3KaFF+4kFWJOYK6DGvV+Gzm/Aq1HpMECYwF
 2OoKMoey1mk6RggZkQfxPRIME6nl9XflQQehoS+eY/jJGwN8viqP3H92tifIovZ0Hu6E
 WAwdUzMPmU/iGkHDC5tpUmFNfbeIzUQukpvA5u0/zkDZGu9VBIchm+v4Q8rSAJs+0Fop
 mU/7Ss8LGfVc8LTq5OIB7ApSwyIOG6lJhz9cbZ27Qva+WGGs/6xUnFvYi6YL/PmC1iwz
 0Scw==
X-Gm-Message-State: AOJu0YxNnBgua94wO+X0e750/0pLcpITFptQfT18WLb5kNg3iF3WnA1l
 /2MKNDbS1dSX2WiS7CTb0LFmcbI0bELr3DBnJ2EzJ4MhyOMYDy+cxQewAUvjiE6vPkCsZdLaOvV
 a4/ubTSnPmHlGonhOcuzveHNoTe3RjgUSpo8xXJV9WuCmsw6qTD1saq216wKRC3uKYBKO5NMQs6
 K1KZmVK6SIte0zOpXHEITB7LA=
X-Gm-Gg: ASbGncu8HzlWFWEQuBR4LFPdW+UBc2vrJHnwOi5WCFLDtxTvJu8WN79reC0dAw/Z5OC
 FinlBvVg/Wj+1hxPDNjw4ly0mh+7d7vEwJcZVRXY=
X-Received: by 2002:a17:90b:3503:b0:2ee:9d65:65a7 with SMTP id
 98e67ed59e1d1-2f782d7ff77mr2139718a91.29.1737097409730; 
 Thu, 16 Jan 2025 23:03:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNtPNq0+kDbMiVuWlasusg4A5uJ+PuVPbkgIh2n8DZOb6hJM4cPw0BIrNDnwDaUuiFPX761bQHE2uChwbO3y8=
X-Received: by 2002:a17:90b:3503:b0:2ee:9d65:65a7 with SMTP id
 98e67ed59e1d1-2f782d7ff77mr2139685a91.29.1737097409297; Thu, 16 Jan 2025
 23:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20250116130936.700441-1-pvorel@suse.cz>
In-Reply-To: <20250116130936.700441-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Jan 2025 15:03:17 +0800
X-Gm-Features: AbW1kvaM3Q7ad8WPtGJ0dOeUx0oTnhDnZv_h0pjbuaEZug40AyHj-0AChKDtZrI
Message-ID: <CAEemH2duAZvjNn_7WdV-P4QbhDNEDez4OcPkLv3xsqFuzxe_-w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QJLh9-CHBnHTvX2Kb9ZiiZd6aJG5KgV_wrKHvHC5szw_1737097410
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] tst_net.sh: Filter out tst_ns_exec TINFO
 messages
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

T24gVGh1LCBKYW4gMTYsIDIwMjUgYXQgOTowOeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gVGhpcyBpcyBhIHdvcmthcm91bmQgdG8gZmlsdGVyIG91dCB0c3RfbnNf
ZXhlYy5jIFRJTkZPIG1lc3NhZ2VzIHByaW50ZWQKPiBvbiBzdGRlcnIgYnkgdHN0X2hhc19zbG93
X2tjb25maWcoKS4gdHN0X25zX2V4ZWMuYyBpcyB1c2VkIGJ5IGRlZmF1bHQgYnkKPiAkTFRQX05F
VE5TIGluIHRzdF9yaG9zdF9ydW4oKS4KPgo+IFRoaXMgZml4ZXMgZXJyb3JzIG9uIHNoZWxsIHRl
c3RzIG9uIG5ldG5zIGJhY2tlbmQgKHRoZSBkZWZhdWx0KToKPgo+ICAgICAjIFBBVEg9Ii9vcHQv
bHRwL3Rlc3RjYXNlcy9iaW46JFBBVEgiIHBpbmcwMS5zaAo+ICAgICAuLi4KPiAgICAgcGluZzAx
IDEgVElORk86IGluaXRpYWxpemUgJ3Job3N0JyAnbHRwX25zX3ZldGgxJyBpbnRlcmZhY2UKPiAg
ICAgL29wdC9sdHAvdGVzdGNhc2VzL2Jpbi9waW5nMDEuc2g6IDE0MjogWzogdHN0X2tjb25maWcu
Yzo4ODo6Cj4gdW5leHBlY3RlZCBvcGVyYXRvcgo+ICAgICB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5G
TzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9jb25maWcuZ3onCj4gICAgIHRzdF9rY29u
ZmlnLmM6NjY3OiBUSU5GTzogQ09ORklHX0xBVEVOQ1lUT1Aga2VybmVsIG9wdGlvbiBkZXRlY3Rl
ZAo+IHdoaWNoIG1pZ2h0IHNsb3cgdGhlIGV4ZWN1dGlvbgo+ICAgICB0c3Rfa2NvbmZpZy5jOjg4
OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9jb25maWcuZ3onCj4gICAgIHRz
dF9rY29uZmlnLmM6NjY3OiBUSU5GTzogQ09ORklHX0xBVEVOQ1lUT1Aga2VybmVsIG9wdGlvbiBk
ZXRlY3RlZAo+IHdoaWNoIG1pZ2h0IHNsb3cgdGhlIGV4ZWN1dGlvbgo+ICAgICB0c3Rfa2NvbmZp
Zy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9jb25maWcuZ3onCj4g
ICAgIHRzdF9rY29uZmlnLmM6NjY3OiBUSU5GTzogQ09ORklHX0xBVEVOQ1lUT1Aga2VybmVsIG9w
dGlvbiBkZXRlY3RlZAo+IHdoaWNoIG1pZ2h0IHNsb3cgdGhlIGV4ZWN1dGlvbgo+ICAgICB0c3Rf
a2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9jb25maWcu
Z3onCj4gICAgIHRzdF9rY29uZmlnLmM6NjY3OiBUSU5GTzogQ09ORklHX0xBVEVOQ1lUT1Aga2Vy
bmVsIG9wdGlvbiBkZXRlY3RlZAo+IHdoaWNoIG1pZ2h0IHNsb3cgdGhlIGV4ZWN1dGlvbgo+ICAg
ICB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9j
b25maWcuZ3onCj4gICAgIHRzdF9rY29uZmlnLmM6NjY3OiBUSU5GTzogQ09ORklHX0xBVEVOQ1lU
T1Aga2VybmVsIG9wdGlvbiBkZXRlY3RlZAo+IHdoaWNoIG1pZ2h0IHNsb3cgdGhlIGV4ZWN1dGlv
bgo+ICAgICB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcv
cHJvYy9jb25maWcuZ3onCj4gICAgIHRzdF9rY29uZmlnLmM6NjY3OiBUSU5GTzogQ09ORklHX0xB
VEVOQ1lUT1Aga2VybmVsIG9wdGlvbiBkZXRlY3RlZAo+IHdoaWNoIG1pZ2h0IHNsb3cgdGhlIGV4
ZWN1dGlvbgo+ICAgICB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29u
ZmlnICcvcHJvYy9jb25maWcuZ3onCj4gICAgIHRzdF9rY29uZmlnLmM6NjY3OiBUSU5GTzogQ09O
RklHX0xBVEVOQ1lUT1Aga2VybmVsIG9wdGlvbiBkZXRlY3RlZAo+IHdoaWNoIG1pZ2h0IHNsb3cg
dGhlIGV4ZWN1dGlvbgo+ICAgICB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJu
ZWwgY29uZmlnICcvcHJvYy9jb25maWcuZ3onCj4gICAgIHRzdF9rY29uZmlnLmM6NjY3OiBUSU5G
TzogQ09ORklHX0xBVEVOQ1lUT1Aga2VybmVsIG9wdGlvbiBkZXRlY3RlZAo+IHdoaWNoIG1pZ2h0
IHNsb3cgdGhlIGV4ZWN1dGlvbgo+ICAgICAvb3B0L2x0cC90ZXN0Y2FzZXMvYmluL3BpbmcwMS5z
aDogMTQyOiBbOiB0c3Rfa2NvbmZpZy5jOjg4OjoKPiB1bmV4cGVjdGVkIG9wZXJhdG9yCj4gICAg
IHBpbmcwMSAxIFRJTkZPOiBhZGQgcmVtb3RlIGFkZHIgMTAuMC4wLjEvMjQKPiAgICAgdHN0X2tj
b25maWcuYzo4ODogVElORk86IFBhcnNpbmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6
Jwo+ICAgICB0c3Rfa2NvbmZpZy5jOjY2NzogVElORk86IENPTkZJR19MQVRFTkNZVE9QIGtlcm5l
bCBvcHRpb24gZGV0ZWN0ZWQKPiB3aGljaCBtaWdodCBzbG93IHRoZSBleGVjdXRpb24KPiAgICAg
L29wdC9sdHAvdGVzdGNhc2VzL2Jpbi9waW5nMDEuc2g6IDE0MjogWzogdHN0X2tjb25maWcuYzo4
ODo6Cj4gdW5leHBlY3RlZCBvcGVyYXRvcgo+ICAgICBwaW5nMDEgMSBUSU5GTzogYWRkIHJlbW90
ZSBhZGRyIGZkMDA6MToxOjE6OjEvNjQKPiAgICAgdHN0X2tjb25maWcuYzo4ODogVElORk86IFBh
cnNpbmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwo+ICAgICB0c3Rfa2NvbmZpZy5j
OjY2NzogVElORk86IENPTkZJR19MQVRFTkNZVE9QIGtlcm5lbCBvcHRpb24gZGV0ZWN0ZWQKPiB3
aGljaCBtaWdodCBzbG93IHRoZSBleGVjdXRpb24KPiAgICAgL29wdC9sdHAvdGVzdGNhc2VzL2Jp
bi9waW5nMDEuc2g6IDE6IGV2YWw6IHRzdF9rY29uZmlnLmM6ODg6OiBub3QgZm91bmQKPiAgICAg
L29wdC9sdHAvdGVzdGNhc2VzL2Jpbi9waW5nMDEuc2g6IDE6IGV2YWw6IDM0bVRJTkZPOjogbm90
IGZvdW5kCj4gICAgIC9vcHQvbHRwL3Rlc3RjYXNlcy9iaW4vcGluZzAxLnNoOiAxOiBldmFsOiAz
NG1USU5GTzo6IG5vdCBmb3VuZAo+ICAgICAvb3B0L2x0cC90ZXN0Y2FzZXMvYmluL3BpbmcwMS5z
aDogMTQyOiBbOiB0c3Rfa2NvbmZpZy5jOjg4OjoKPiB1bmV4cGVjdGVkIG9wZXJhdG9yCj4gICAg
IC9vcHQvbHRwL3Rlc3RjYXNlcy9iaW4vcGluZzAxLnNoOiAxOiBldmFsOiB0c3Rfa2NvbmZpZy5j
Ojg4Ojogbm90IGZvdW5kCj4gICAgIC9vcHQvbHRwL3Rlc3RjYXNlcy9iaW4vcGluZzAxLnNoOiAx
OiBldmFsOiAzNG1USU5GTzo6IG5vdCBmb3VuZAo+ICAgICAvb3B0L2x0cC90ZXN0Y2FzZXMvYmlu
L3BpbmcwMS5zaDogMTogZXZhbDogMzRtVElORk86OiBub3QgZm91bmQKPiAgICAgcGluZzAxIDEg
VElORk86IE5ldHdvcmsgY29uZmlnIChsb2NhbCAtLSByZW1vdGUpOgo+ICAgICBwaW5nMDEgMSBU
SU5GTzogbHRwX25zX3ZldGgyIC0tIGx0cF9uc192ZXRoMQo+ICAgICBwaW5nMDEgMSBUSU5GTzog
MTAuMC4wLjIvMjQgLS0gMTAuMC4wLjEvMjQKPgo+IEZpeGVzOiA4OTNjYTBhYmU3ICgibGliOiBt
dWx0aXBseSB0aGUgdGltZW91dCBpZiBkZXRlY3Qgc2xvdyBrY29uZmlncyIpCj4gU2lnbmVkLW9m
Zi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5n
IDxsaXdhbmdAcmVkaGF0LmNvbT4KCi0tLQo+IEhpLAo+Cj4gYWx0ZXJuYXRpdmUgdG8gTGkncyBU
U1RfTk9fU0xPV19LQ09ORklHX0NIRUNLIHN1Z2dlc3Rpb246Cj4KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sdHAvQ0FFZW1IMmQ2Uko4eWQ0VGNMdC16NDlmbU5LdDdlQUdnPVZoZEFTa050RT03
Y1I3YmdnQG1haWwuZ21haWwuY29tLwo+Cj4gTWF5YmUgZXZlbiBib3RoIGNvdWxkIGJlIGFwcGxp
ZWQuCj4gV0RZVD8KPgoKQWdyZWVkLCB0aGlzIGNvdWxkIGF2b2lkIHNvbWUgb3RoZXIgbmV3IFRJ
TkZPIGluIHRoZSBmdXR1cmUuCkFsc28sIEkgd2lsbCBwb3N0IHRoZSBUU1RfTk9fU0xPV19LQ09O
SUZHX0NIRUNLIHBhdGNoIHNvb24uCgoKCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gIHRl
c3RjYXNlcy9saWIvdHN0X25ldC5zaCB8IDIgKysKPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9saWIvdHN0X25ldC5zaCBiL3Rlc3Rj
YXNlcy9saWIvdHN0X25ldC5zaAo+IGluZGV4IGVlMGFlMWNhZDcuLjRlODc4NmI3MDQgMTAwNjQ0
Cj4gLS0tIGEvdGVzdGNhc2VzL2xpYi90c3RfbmV0LnNoCj4gKysrIGIvdGVzdGNhc2VzL2xpYi90
c3RfbmV0LnNoCj4gQEAgLTI2NSw2ICsyNjUsOCBAQCB0c3Rfcmhvc3RfcnVuKCkKPiAgICAgICAg
ICAgICAgICAgWyAiJHNhZmUiIF0gJiYgXAo+ICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9i
cmtfIFRCUk9LICInJGNtZCcgZmFpbGVkIG9uICckUkhPU1QnOgo+ICckb3V0cHV0JyIKPiAgICAg
ICAgIGZpCj4gKyAgICAgICAjIHN0cmlwIG91dCB0c3RfbnNfZXhlYyBUSU5GTyBtZXNzYWdlcwo+
ICsgICAgICAgb3V0cHV0PSQoZWNobyAiJG91dHB1dCIgfCBncmVwIC12ICdUSU5GTzonKQo+Cj4g
ICAgICAgICBbIC16ICIkb3V0IiAtYSAtbiAiJG91dHB1dCIgXSAmJiBlY2hvICIkb3V0cHV0Igo+
Cj4gLS0KPiAyLjQ3LjEKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
