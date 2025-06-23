Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77655C7115B
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750681480; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=PYVxaWK4TX/G373v6X7k82dkF+eX2d9qB2sHF/PB8NQ=;
 b=RyGRLPy4PV6xz9FRNt7oc/DSKKVWp0mCYTL90bATvpgorZGyukt4SOOX8VJ4+zX8aBqyq
 sJrcqE8BDst9ke4rC22YSH1a3ngGf/g7eOjNN9xYMoKOEpBiSArCFvALuA1/6FS2gZT2pto
 UFdwhlORS7X51nzxD9b/+v98LSy3Swg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 186ED3CC9E5
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 14:24:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46DD33CC52B
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 14:24:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5BF09140077B
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 14:24:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750681456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ASn3tpvBfWlkykwbf8HHCfsQUAWAxbQQKqlB5LljWb4=;
 b=CSDjBkSCOKz+6GHReDQam/KP8pNvqfC199Cfh2h5otuYFiG3Jf/2ikXs9eA7VCgkgIgmDe
 s0kkiCCU0mB+SLcc65II0XhUVcaEAcz2XIUpfcNfvQsJY0IS5DXwa9bEOv/IvzYIs9H8sK
 oePhW5YB9Bpf5LT69HHzysvl+f2tzSo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-XEwOVFM9NtG7wAbfOoIAaQ-1; Mon, 23 Jun 2025 08:24:15 -0400
X-MC-Unique: XEwOVFM9NtG7wAbfOoIAaQ-1
X-Mimecast-MFC-AGG-ID: XEwOVFM9NtG7wAbfOoIAaQ_1750681454
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-23632fd6248so37504205ad.3
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 05:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681453; x=1751286253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ASn3tpvBfWlkykwbf8HHCfsQUAWAxbQQKqlB5LljWb4=;
 b=eTEvb6zgIplb3JSguNMvyxo7ejUzekKToKqDKySeJ0LOGamK5nuufDigFknOjypU2n
 5MV8d8oxseJrJhRDg/XwmBOlO7qcL0e3O64DJSKZxWYoZvQWCLAUp7CR7rpoHzzfkQEg
 ImWdIToWTXMcvXkYQfOWo3tg2hhEB8AJm1CHaaDyZ659GWTalrzia9oZ4HjJRttPHR1D
 pAT2SSwg8jUcd8tbuA80wF+O/li9A4ZgKfe1NBpnIp5OIYgXZ+ki+3TRx5Ppv1B4ZuxR
 TDx7W0fHwvB7bggBBpaHMOaFTelmrdyD6EeX03HLxpNQ7PoOmEC/H72Xaf8QxnN0FY4Y
 6NTw==
X-Gm-Message-State: AOJu0Yzal532XCXR/rPS4WtEhVU/oPigOICddtVez7eWurr1ofFWzXhS
 MDmKQG650dxPI1TPrRClHZk4ftTysbHxdhUR5SxA6Rg9DWpP3u6myBqmIc1LasAkrxzNJXlD4s+
 on/T3j30LJwEPHcuHtgDt5Pj/cGv014Uw+Vgl+rvlmJq+BUrvVeMBlMVbw60W9kRRZVWhLeCBlD
 N/0VIGfu6M86yLDbAEHUyiIR28HAv+EjEh1jFENA==
X-Gm-Gg: ASbGncuSo4O8OtnF1fOUUzKFFyFypwXfg8LDJjzGXcEk6ClccqADWE/zIHBQ/gL2xoV
 f6LP/3jm6sNC4Imucvjal81r1OTfwKzduEZlV9gloxab8xlfALj/jCKUEGtH5SQM2iAM6/GwJVY
 2B2KxM
X-Received: by 2002:a17:902:d58c:b0:234:c5c1:9b7a with SMTP id
 d9443c01a7336-237d9779dedmr131719595ad.8.1750681452782; 
 Mon, 23 Jun 2025 05:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPHsKgo72FWRutidYfksWBgQRVyx6k5jzdPmEJU/x8/aPTUfPhMnVuh5UJGky8jFCy1SkHtj4VbC73XxnnWdc=
X-Received: by 2002:a17:902:d58c:b0:234:c5c1:9b7a with SMTP id
 d9443c01a7336-237d9779dedmr131719315ad.8.1750681452411; Mon, 23 Jun 2025
 05:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250620073000.514444-1-liwang@redhat.com>
 <20250623091223.19583-1-liwang@redhat.com>
 <af88e5ca-5c77-49ad-8992-0a69ce36bf82@suse.cz>
 <CAEemH2fO5+Hyr=--6oVB0L0cX7tOd1yAJ62i1N7W8Wh7o_TRtA@mail.gmail.com>
In-Reply-To: <CAEemH2fO5+Hyr=--6oVB0L0cX7tOd1yAJ62i1N7W8Wh7o_TRtA@mail.gmail.com>
Date: Mon, 23 Jun 2025 20:23:59 +0800
X-Gm-Features: Ac12FXzEpSlh1vN1SfIO2Qn9N88BaVlNAf__dETcTD8-wi-ZnAtYNpu41Fj9gAc
Message-ID: <CAEemH2fyNfM3OyJYMOZdE6CVF0tTWSY6aBU+bQdgyevo7zKiMg@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BPUtzRVpDQwtLLHr_X2wumh6OjaG4AVYfAvLeNuz5tY_1750681454
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] tst_test: Add flags to control runtime
 scaling in timing sensitive tests
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

T24gTW9uLCBKdW4gMjMsIDIwMjUgYXQgODoxMOKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4KPgo+IE9uIE1vbiwgSnVuIDIzLCAyMDI1IGF0IDc6NDPigK9QTSBNYXJ0
aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+IHdyb3RlOgo+Cj4+IE9uIDIzLiAwNi4gMjUgMTE6
MTIsIExpIFdhbmcgdmlhIGx0cCB3cm90ZToKPj4gPiBTb21lIHRlc3RzLCBzdWNoIGFzIHRob3Nl
IHVzaW5nIGZ1enp5IHN5bmNocm9uaXphdGlvbiBvciBwcm9iYWJpbGlzdGljCj4+IHRyaWdnZXJz
Cj4+ID4gKGUuZy4gcHJlYWR2MjAzKSwgcmVxdWlyZSBzdWZmaWNpZW50IHJ1bnRpbWUgdG8gY29s
bGVjdCBtZWFuaW5nZnVsCj4+IHJlc3VsdHMuCj4+ID4gVGhlc2UgdGVzdHMgb2Z0ZW4gcmVseSBv
biB0aHJlc2hvbGRzIGxpa2UgYGZ6c3luY19wYWlyLm1pbl9zYW1wbGVzYCwKPj4gd2hpY2ggbXVz
dAo+PiA+IGJlIG1ldCBkdXJpbmcgdGhlIHJ1bnRpbWUgd2luZG93Lgo+PiA+Cj4+ID4gV2hlbiBM
VFBfUlVOVElNRV9NVUwgaXMgc2V0IHRvIGEgdmFsdWUgPCAxLjAgKGNvbW1vbmx5IGluIENJCj4+
IGVudmlyb25tZW50cyksCj4+ID4gdGVzdHMgbWF5IHJ1biBmb3IgdG9vIHNob3J0IGEgdGltZSwg
ZmFpbGluZyB0byBnYXRoZXIgZW5vdWdoIHNhbXBsZXMgYW5kCj4+ID4gc2lsZW50bHkgcHJvZHVj
aW5nIGZhbHNlIG5lZ2F0aXZlcyBvciB1bnN0YWJsZSByZXN1bHRzLgo+PiA+Cj4+ID4gVGhpcyBw
YXRjaCBpbnRyb2R1Y2VzIHRoZSBmb2xsb3dpbmcgdGVzdCBmbGFncyBpbiBgZW51bSB0c3RfZmxh
Z2AgdG8KPj4gcHJvdmlkZQo+PiA+IGZpbmUtZ3JhaW5lZCBjb250cm9sIG92ZXIgcnVudGltZSBh
bmQgdGltZW91dCBzY2FsaW5nOgo+PiA+Cj4+ID4gICAgLSBUU1RfTk9fUlVOVElNRV9NVUw6Cj4+
ID4gICAgICAgIElnbm9yZSBMVFBfUlVOVElNRV9NVUwgYW5kIHVzZSB0aGUgb3JpZ2luYWwgLnJ1
bnRpbWUgdmFsdWUuCj4+ID4KPj4gPiAgICAtIFRTVF9OT19USU1FT1VUX01VTDoKPj4gPiAgICAg
ICAgSWdub3JlIExUUF9USU1FT1VUX01VTCBhbmQgdXNlIHRoZSBvcmlnaW5hbCAudGltZW91dCB2
YWx1ZS4KPj4gPgo+PiA+ICAgIC0gVFNUX05PX0ZSQUNUSU9OQUxfUlVOVElNRV9NVUw6Cj4+ID4g
ICAgICAgIElmIExUUF9SVU5USU1FX01VTCBpcyBsZXNzIHRoYW4gMS4wLCByb3VuZCBpdCB1cCB0
byAxLjAgdG8KPj4gcHJlc2VydmUKPj4gPiAgICAgICAgaW50ZW5kZWQgdGVzdCBkdXJhdGlvbi4K
Pj4KPj4gSSB0aGluayBpdCdkIG1ha2UgbW9yZSBzZW5zZSB0byBkZWZpbmUgYSBtaW5pbWFsIHJ1
bnRpbWUgaW4gdGhlIExUUAo+PiBsaWJyYXJ5IChlLmcuIDEgc2Vjb25kKSBhbmQgYWxsb3cgdGVz
dHMgdG8gb3ZlcnJpZGUgdGhlIHZhbHVlIHdpdGgKPj4gdHN0X3Rlc3QubWluX3J1bnRpbWUuIFRo
ZW4geW91IGNhbiBhcHBseSBmcmFjdGlvbmFsIExUUF9SVU5USU1FX01VTAo+PiBzYWZlbHkgdG8g
YW55IHRlc3QuCj4+Cj4KPiBUaGF0IGhhcyBiZWVuIGFjaGlldmVkIGluCj4gaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9waXBlcm1haWwvbHRwLzIwMjUtSnVuZS8wNDM5NjAuaHRtbC4KPiB3aGljaCBh
dm9pZHMgLnJ1bnRpbWUgYmVpbmcgcm91bmRlZCB0byB6ZXJvIHdpdGggZnJhY3Rpb25hbAo+IExU
UF9SVU5USU1FX01VTC4KPgo+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBUU1RfTk9fRlJBQ1RJT05B
TF9SVU5USU1FX01VTCwgbWFpbmx5IHRvCj4gc29sdmUgdGhlIHByb2JsZW0gdGhhdCBzb21lIHNw
ZWNpYWwgdGVzdHMgKGUuZy4gZnV6enktbGliLCBwcmVhZHYyMDMpCj4gc2hvdWxkCj4gbm90IHJl
ZHVjZSB0aGUgcnVudGltZSBkdXJpbmcgZXhlY3V0aW9uLiBTZXR0aW5nIGEgbWluaW11bSBydW50
aW1lIChlLmcuIDEKPiBzZWNvbmQpCj4gZG9lcyBub3QgbWVldCB0aGUgcmVxdWlyZW1lbnRzLgo+
CgpPaCwgaXQgc3VkZGVubHkgZGF3bmVkIG9uIG1lIHdoYXQgeW91IHdlcmUgcmVhbGx5IHN1Z2dl
c3RpbmcuCgpVc2UgdGhlIGRlZmF1bHQgbWluaW11bSBydW50aW1lIG9mIDEgc2Vjb25kLCBhbmQg
b3ZlcnJpZGUgaXQgd2l0aAphbiBhcmJpdHJhcmlseSBsYXJnZSB2YWx1ZSBpZiBuZWNlc3Nhcnks
IGFuZCBlbnN1cmUgdGhhdCB0aGUgcmVzdWx0IG9mCihydW50aW1lICogcnVubmluZ19tdWwpIGlz
IG5ldmVyIGxlc3MgdGhhbiB0aGUgbmV3IC5taW5fcnVudGltZSB2YWx1ZS4KClRoaXMgaXMgYW4g
ZWxlZ2FudCBhcHByb2FjaCwgdGhhbmtzIQoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
