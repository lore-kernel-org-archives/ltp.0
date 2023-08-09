Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD5FC001B0
	for <ltp@archiver.kernel.org>; Wed,  9 Aug 2023 01:47:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 099A43CD1C2
	for <ltp@archiver.kernel.org>; Wed,  9 Aug 2023 03:47:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D09D3CB2BC
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 03:47:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A2604600A16
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 03:47:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691545630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JVNkJ6xIpLfjJttc1xSRmA0G6iFNoYLIK2pdcjRAv6g=;
 b=Z9GyOwSQqIkU9yKSQdgrYbR/t/LAJGMb70PoIq2CBc4HiJl+F3Ru76t0fB9c2VOKesKotF
 f5q63wWguvtealFFeepERsRA81xTYAgJcYinqTk4IHpYgV5yckrw3q04K8pbrQy761m6tm
 xlY+x+0XmXOV4relaQUal9GHKod/MyE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-y4HcLQ0cMs6ZIeZNRAVtuQ-1; Tue, 08 Aug 2023 21:47:07 -0400
X-MC-Unique: y4HcLQ0cMs6ZIeZNRAVtuQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9ab2dd649so2443691fa.0
 for <ltp@lists.linux.it>; Tue, 08 Aug 2023 18:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691545626; x=1692150426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JVNkJ6xIpLfjJttc1xSRmA0G6iFNoYLIK2pdcjRAv6g=;
 b=doS0L1KZjyvJvMXxPFvCO49SEMvXkf3DJICY4T9jeWv8zMpcmaE64fByeY4W4j7oMi
 Z9w2c1VnBhI1D8bUJh8SrdDHOuhoh5pKbg3tN9589oxaoMTFLukYl9w5RjjLXOblShjt
 TSU5X+hBN4V+kizEtJ3lKfn6/M0DvN8Go4GlBKUUCJRct8TPMXF3r/XMD2CpYebzAnb7
 3EM8ZB6chlh9L45BNbpqYUF07JhW764vXBpM2M7ChwtVBNs3J2mmaMXgndNko6ISK1Xm
 YHHpXP6J2jFM2R8AcPM77SPnCu928KJZyeqAc4ROAjd/sXppnf9kwNAKVMBL3U5/ApB/
 kVLA==
X-Gm-Message-State: AOJu0YwUzQIc+5XP7DiWH8699u4bMKr4g4FvHqO5KbCnuYrWpajlH1GH
 nxGjA2b3wTjDZZ4t3U0+SBe9YMIjeSdDdH5jT3aEv5v2cXFDdmQfpQ3GXjniW3zluZxl0wnWXb4
 NIu/BZIDUI8wr89JHncF3brq/BRk=
X-Received: by 2002:a2e:9516:0:b0:2b8:3a1e:eebd with SMTP id
 f22-20020a2e9516000000b002b83a1eeebdmr437890ljh.21.1691545626118; 
 Tue, 08 Aug 2023 18:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwPkUaInsvm+NZCdyARVvmSXN6bCesd70BaaAdbN9SJvMCdUiHDqh3kLXrHlZsKmtmkI62Et0zu6R7IbTlHQs=
X-Received: by 2002:a2e:9516:0:b0:2b8:3a1e:eebd with SMTP id
 f22-20020a2e9516000000b002b83a1eeebdmr437886ljh.21.1691545625729; Tue, 08 Aug
 2023 18:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230808124445.980419-1-liwang@redhat.com>
 <x49edkd4qia.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49edkd4qia.fsf@segfault.boston.devel.redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 9 Aug 2023 09:46:54 +0800
Message-ID: <CAEemH2dEQYSr2dF2XY4Njv37g6dyqxkFOmaY_bZZSKG1MeKsgg@mail.gmail.com>
To: Jeff Moyer <jmoyer@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] io_uring: enable I/O Uring before testing
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

SGkgSmVmZiwKClRoYW5rcyBmb3IgY29tbWVudHMuCgpPbiBUdWUsIEF1ZyA4LCAyMDIzIGF0IDk6
MTfigK9QTSBKZWZmIE1veWVyIDxqbW95ZXJAcmVkaGF0LmNvbT4gd3JvdGU6Cgo+IExpIFdhbmcg
PGxpd2FuZ0ByZWRoYXQuY29tPiB3cml0ZXM6Cj4KPiA+IEdpdmVuIHRoYXQgdGhlIHVwc3RyZWFt
IGtlcm5lbCBpcyBnb2luZyB0byBpbnRyb2R1Y2UgaW9fdXJpbmdfZGlzYWJsZWQKPiA+IGtub2Ig
d2hpY2ggZGlzYWJsZXMgdGhlIGNyZWF0aW9uIG9mIG5ldyBpb191cmluZyBpbnN0YW5jZXMgc3lz
dGVtLXdpZGUuCj4gPgo+ID4gVGhlIG5ldyBzeXNjdGwgaXMgZGVzaWduZWQgdG8gbGV0IGEgdXNl
ciB3aXRoIHJvb3Qgb24gdGhlIG1hY2hpbmUKPiA+IGVuYWJsZSBhbmQgZGlzYWJsZSBpb191cmlu
ZyBzeXN0ZW0td2lkZSBhdCBydW50aW1lIHdpdGhvdXQgcmVxdWlyaW5nCj4gPiBhIGtlcm5lbCBy
ZWNvbXBpbGF0aW9uIG9yIGEgcmVib290Lgo+ID4KPiA+IFNlZToKPiBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvaW8tdXJpbmcvcGF0Y2gvMjAyMzA2MzAxNTEwMDMuMzYyMjc4
Ni0yLW1hdHRlb3JpenpvQGdvb2dsZS5jb20vCj4gPgo+ID4gV2l0aG91dCB0aGlzIHBhdGNoLCBM
VFAvaW9fdXJpbmcgdGVzdCBjb21wbGFpbnM6Cj4gPgo+ID4gICBpb191cmluZzAxLmM6ODI6IFRG
QUlMOiBpb191cmluZ19zZXR1cCgpIGZhaWxlZDogRVBFUk0gKDEpCj4gPiAgIGlvX3VyaW5nMDIu
YzoyMTM6IFRCUk9LOiBpb191cmluZ19zZXR1cCgpIGZhaWxlZDogRVBFUk0gKDEpCj4KPiBKdXN0
IHRvIGJlIGNsZWFyLCB3aXRoIHRoZSBhYm92ZSBrZXJuZWwgcGF0Y2ggYXBwbGllZCBpb191cmlu
ZyBpcwo+IGVuYWJsZWQgYnkgZGVmYXVsdC4gIFlvdSBzaG91bGRuJ3QgbmVlZCB0byBzZXQgdGhl
IHN5c2N0bCBwYXJhbWV0ZXIKPiB1bmxlc3MgaW9fdXJpbmcgaXMgZXhwbGljaXRseSBkaXNhYmxl
ZCBieSB0aGUgYWRtaW5pc3RyYXRvciAodGhhdCBjYW4gYmUKPiBhY2NvbXBsaXNoZWQgdmlhIHRo
ZSBrZXJuZWwgY29tbWFuZCBsaW5lLCBzeXNmcywgb3IgdmlhIHN5c2N0bC5jb25mKS4KPgoKWWVz
LCBidXQgaXQgd29uJ3QgYmUgaGFybWZ1bCB0byBzZXQgdGhlIHBhcmFtZXRlciBldmVuIGlmIGl0
J3MgZW5hYmxlZCBieQpkZWZhdWx0LApMVFAgdXNlcyBzYXZlX3Jlc3RvcmUgZmllbGQgdG8gbWFu
YWdlIHN5c2ZzIGtub2IgdW5pZmllZCwgaXQgZ3VhcmFudGVlcyB0aGUKdGVzdHMgY2FuIHJlYWxs
eSBnZXQgcGVyZm9ybWVkIHdoYXRldmVyIGlvX3VyaW5nIGlzIGVuYWJsZWQgb3IgZGlzYWJsZWQu
CgpJIHdvdWxkIGtlZXAgdGhlIHBhdGNoIGFzIGl0IGlzIHVubGVzcyB5b3UgaW5zaXN0IG9yIG90
aGVycyBoYXZlIGFuCm9iamVjdGlvbi4KCgoKPgo+IENoZWVycywKPiBKZWZmCj4KPiA+Cj4gPiBS
ZXByb3RlZC1ieTogSmVmZiBNb3llciA8am1veWVyQHJlZGhhdC5jb20+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvaW9fdXJpbmcvaW9fdXJpbmcwMS5jIHwgNSArKysrKwo+ID4gIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fdXJpbmcvaW9fdXJpbmcwMi5jIHwgNSArKysrKwo+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvX3VyaW5nL2lvX3VyaW5nMDEuYwo+IGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9pb191cmluZy9pb191cmluZzAxLmMKPiA+IGluZGV4IDcwMTUx
YmI4NS4uYWIxZWMwMGQ2IDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9pb191cmluZy9pb191cmluZzAxLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvaW9fdXJpbmcvaW9fdXJpbmcwMS5jCj4gPiBAQCAtMjY0LDUgKzI2NCwxMCBAQCBzdGF0aWMg
c3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gPiAgICAgICAuYnVmcyA9IChzdHJ1Y3QgdHN0X2J1
ZmZlcnMgW10pIHsKPiA+ICAgICAgICAgICAgICAgeyZpb3YsIC5pb3Zfc2l6ZXMgPSAoaW50W10p
e0JMT0NLX1NaLCAtMX19LAo+ID4gICAgICAgICAgICAgICB7fQo+ID4gKyAgICAgfSwKPiA+ICsg
ICAgIC5zYXZlX3Jlc3RvcmUgPSAoY29uc3Qgc3RydWN0IHRzdF9wYXRoX3ZhbFtdKSB7Cj4gPiAr
ICAgICAgICAgICAgIHsiL3Byb2Mvc3lzL2tlcm5lbC9pb191cmluZ19kaXNhYmxlZCIsICIwIiwK
PiA+ICsgICAgICAgICAgICAgICAgICAgICBUU1RfU1JfU0tJUF9NSVNTSU5HIHwgVFNUX1NSX1RD
T05GX1JPfSwKPiA+ICsgICAgICAgICAgICAge30KPiA+ICAgICAgIH0KPiA+ICB9Owo+ID4gZGlm
ZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9fdXJpbmcvaW9fdXJpbmcwMi5j
Cj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvX3VyaW5nL2lvX3VyaW5nMDIuYwo+ID4g
aW5kZXggYzVjNzcwMDc0Li5jOWQ0YmJjYjEgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2lvX3VyaW5nL2lvX3VyaW5nMDIuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9pb191cmluZy9pb191cmluZzAyLmMKPiA+IEBAIC0yNTUsNiArMjU1LDEx
IEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+ICAgICAgICAgICAgICAgVFNU
X0NBUChUU1RfQ0FQX1JFUSwgQ0FQX1NZU19DSFJPT1QpLAo+ID4gICAgICAgICAgICAgICB7fQo+
ID4gICAgICAgfSwKPiA+ICsgICAgIC5zYXZlX3Jlc3RvcmUgPSAoY29uc3Qgc3RydWN0IHRzdF9w
YXRoX3ZhbFtdKSB7Cj4gPiArICAgICAgICAgICAgIHsiL3Byb2Mvc3lzL2tlcm5lbC9pb191cmlu
Z19kaXNhYmxlZCIsICIwIiwKPiA+ICsgICAgICAgICAgICAgICAgICAgICBUU1RfU1JfU0tJUF9N
SVNTSU5HIHwgVFNUX1NSX1RDT05GX1JPfSwKPiA+ICsgICAgICAgICAgICAge30KPiA+ICsgICAg
IH0sCj4gPiAgICAgICAudGFncyA9IChjb25zdCBzdHJ1Y3QgdHN0X3RhZ1tdKSB7Cj4gPiAgICAg
ICAgICAgICAgIHsibGludXgtZ2l0IiwgIjkzOTJhMjdkODhiOSJ9LAo+ID4gICAgICAgICAgICAg
ICB7ImxpbnV4LWdpdCIsICJmZjAwMmIzMDE4MWQifSwKPgo+CgotLSAKUmVnYXJkcywKTGkgV2Fu
ZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
