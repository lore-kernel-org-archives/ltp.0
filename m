Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E494FC3DA6D
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 06:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747980876; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/9ep6+hQrH5ziS227r9Hz7UJ3JZZAB1Orw/n4bo1UqQ=;
 b=o58VDdhRJIzpeCZAi4xk3XakAZJ5uYRLnyQyJDYJL1jG+Imx0NzcPFNXxv19kzJN6IRvg
 vlOr9wrGKIyDvbAYrqABkOSVqPW1WwISzLokUwRkG15z0Xn/EYIltvQVvUOuMi383+ojfre
 kIDeiSB4ookeVNspjN1XzTOgFaOA1oY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0149D3CC363
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 08:14:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E85A03C68A4
 for <ltp@lists.linux.it>; Fri, 23 May 2025 08:14:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D288F1400341
 for <ltp@lists.linux.it>; Fri, 23 May 2025 08:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747980851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGtde7VevSUG0nKmb7mtg/74h2tVqZGw4fueYRqGGvQ=;
 b=eptZ0kQvBAleIgEAg3wvQQqDnfpti5IJ+ONP+g031h43iKxFK5up1qkULQDeUwB7MOOHsI
 cR9wWQLkqqs5nG25zr63bNGIXQI4thljATHDb7xz01GWqRPktgdOYZu8vP+OXTeQXQ7Fly
 l+OvZxo2kLu5QsqmOKEBvzThmD78Q3A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-P24ecZZcMGyXfx8xuf48rA-1; Fri, 23 May 2025 02:14:09 -0400
X-MC-Unique: P24ecZZcMGyXfx8xuf48rA-1
X-Mimecast-MFC-AGG-ID: P24ecZZcMGyXfx8xuf48rA_1747980848
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a3684a5655so3168255f8f.0
 for <ltp@lists.linux.it>; Thu, 22 May 2025 23:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747980848; x=1748585648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGtde7VevSUG0nKmb7mtg/74h2tVqZGw4fueYRqGGvQ=;
 b=DRCAj1JRAUGCjvXnVY5q3U4GBNQlzv2HRNQ7NLvAcGJtGoApws8akszq6pJMjFtLNA
 tuxSw57W/yuKMqfI2L3nMnCjhOhFY129teoPLOPsuZVt2JSNJLzKqvpXHDVl60VLdHpQ
 UbhmG7KEO26O8nZlvPzMVYOJPB2QXSba9zzsZdWsF+WMKDgkYCxyN9ncBiUoPw1laB2y
 E71KvdMqOF7Sp8M1b/FJozMg9qDx52vuIjDSDYXKaJNbEbNtB/CN0kmzH0zP0klYBaHY
 DcCVBdNgaWJy0bDzjSokuz5o4dZa5MNJ2tVBm3uJR7/uuBk9a2PdnqMF0WuZA4Jj5jbt
 NrEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc6kOJyhIyhgoEaMuRrGOECp4UszyXMrbS2mC4A+adqZolI9OztybuTyWvly7+uPJIsyc=@lists.linux.it
X-Gm-Message-State: AOJu0Yz12J6o0qjU1Yq2b0MzAfPg2ovb2adoYLN4O3p4zi7eZwG6SNld
 2A8IK7pCc1AwE2xm7IAAI0zKvL2RFSwmYto22wbmmUPk91t5tPpj+gZRKzVi1o18t7huRSSy3G9
 oLZWbDZmqfz9IW1Ab8mMwKbC0sJl9ZQwLSTsuGAWcThKwQ3YIHUHp+rQUZlyv2qgwgkoiTRDH7X
 diiRMTXlsOHFT1l+ypZb4s6V5qLM0=
X-Gm-Gg: ASbGncu3fQPckUAOK8SImhygMmsD3/HrpfA9nnq/fnGMWK00u7iAS7oncbiA0t8g9Ix
 uSOy8+A3taKwOi52kLFX1+jklhSauRi1J2HtSnhUa6Vwv6FvbmHytbMudt3WCpP9epw==
X-Received: by 2002:a05:6000:402b:b0:3a3:55e6:eac6 with SMTP id
 ffacd0b85a97d-3a35c8219e0mr24770712f8f.17.1747980847761; 
 Thu, 22 May 2025 23:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+xdIaqcGbS7+QyID+kQ08rWYKa4YGv5VHrQk9cqhQtA5D1RwZqJeSWkBS3EFbFakVNKquakPeA1mTHNR6j2U=
X-Received: by 2002:a05:6000:402b:b0:3a3:55e6:eac6 with SMTP id
 ffacd0b85a97d-3a35c8219e0mr24770678f8f.17.1747980847383; Thu, 22 May 2025
 23:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250520202429.577890-1-luizcap@redhat.com>
 <CAEemH2cdN6mcYJk06ksp7nyzz5qOmmRM=sR_SAqLtquD=8ya3g@mail.gmail.com>
 <ae7ee313-21f4-4f82-b522-4028947c8a1c@redhat.com>
 <CAEemH2dccNNvuEE_GNLxd3eR1_uiVX+UhmFBaNXTPU7sRYg29w@mail.gmail.com>
 <CAEemH2f33e0287pfngF+dczQ_AS0Yvt6YxNQOnrpSGHuqODRbQ@mail.gmail.com>
 <72dcba43-6d27-40e9-a110-3db7990e58d1@redhat.com>
 <CAEemH2dx1HFd1jxjtujA3JHAQBER4RrW_xiW0tS5xb5M2pkhiw@mail.gmail.com>
In-Reply-To: <CAEemH2dx1HFd1jxjtujA3JHAQBER4RrW_xiW0tS5xb5M2pkhiw@mail.gmail.com>
Date: Fri, 23 May 2025 08:13:50 +0200
X-Gm-Features: AX0GCFtgj-hUCB1CFiOuz1JhnG0jhADdNq7zRq9NaeP20RirKH9QXRtg__mYM_8
Message-ID: <CAASaF6zn_tRbh0Fz++R9qAShUTxdHdZYeU7pH8SR4AAy1QzkPw@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qR2ZuczOWbyCi9nCoFNzzMDajUO2Jnv6kVFMhsfl1Mo_1747980848
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ksm: fix segfault on s390
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
Cc: ltp@lists.linux.it, Luiz Capitulino <luizcap@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXkgMjIsIDIwMjUgYXQgNDozNuKAr1BNIExpIFdhbmcgdmlhIGx0cCA8bHRwQGxp
c3RzLmxpbnV4Lml0PiB3cm90ZToKPgo+IEx1aXogQ2FwaXR1bGlubyA8bHVpemNhcEByZWRoYXQu
Y29tPiB3cm90ZToKPgo+ID4gPiBJIG1pZ2h0IGJlIGEgYml0IHRvbyBwaWNreTopLiBTbyBJIGNv
bXBhcmVkIHRoZSB0d28gYXBwcm9hY2hlcyBvbiBhCj4gPiA+IDIgQ1BVcywgS1ZNLCB4ODZfNjQg
c3lzdGVtOgo+ID4gPgo+ID4gPiBQZXItYmxvY2sgY2hlY2tpbmcgY29zdCB0aW1lOgo+ID4gPiAg
ICAgcmVhbCAwbTUuODYycwo+ID4gPiAgICAgdXNlciAwbTEuMDk4cwo+ID4gPiAgICAgc3lzIDBt
MS41MDVzCj4gPiA+Cj4gPiA+IFBlci1ieXRlIGNoZWNraW5nIGNvc3QgdGltZToKPiA+ID4gICAg
cmVhbCAgICAwbTYuODE5cwo+ID4gPiAgICB1c2VyICAgIDBtMi40OThzCj4gPiA+ICAgIHN5cyAg
ICAgMG0xLjQ5NXMKPiA+ID4KPiA+ID4gIEZyb20gdGhlIGRhdGEsIGJsb2NrLWJ5LWJsb2NrIGNo
ZWNraW5nIGNhbiByZWR1Y2UgdGhlIHRvdGFsIGV4ZWN1dGlvbgo+ID4gPiB0aW1lIGJ5IGFib3V0
IDE0JSBhbmQgcmVkdWNlIENQVSB1c2FnZSBieSBtb3JlIHRoYW4gMzUlLCBlc3BlY2lhbGx5Cj4g
PiA+IGluIHVzZXItc3BhY2UgY2FsY3VsYXRpb25zLiBUaGlzIG51bWJlciBtYXkgbm90IGJlIGxh
cmdlLCBidXQgY29uc2lkZXJpbmcKPiA+ID4gdGhhdCB0ZXN0cyBhcmUgZnJlcXVlbnRseSBydW4g
aW4gQ0ksIEkgdGhpbmsgaXQgd291bGQgYmUgYSBnb29kIHRoaW5nIGlmIHdlIGNhbgo+ID4gPiBy
ZWR1Y2UgMSBzZWNvbmQgZWFjaCB0aW1lIDopLgo+ID4KPiA+IEp1c3QgdG8gbWFrZSBzdXJlIEkg
dW5kZXJzdGFuZDogeW91IG1lYXN1cmVkIHRvdGFsIHRlc3QgcnVuLXRpbWUsIGNvcnJlY3Q/Cj4g
PiBIb3cgbWFueSB0aW1lcyBkaWQgeW91IHJ1biBpdD8KPiA+Cj4gPiBJbiBhbnkgY2FzZSwgSSdt
IG5vdCBzdXJlIGEgMSBzZWNvbmQgcnVuLXRpbWUgKG9yIGV2ZW4gQ1BVIHV0aWxpemF0aW9uKSBt
YXR0ZXJzCj4gPiB0aGF0IG11Y2guIFlvdSdyZSBydW5uaW5nIHRlc3QgY29kZSwgeW91IHNob3Vs
ZG4ndCBleHBlY3Qgb3RoZXJ3aXNlIHVubGVzcyB5b3UKPiA+IGhpdCBhIHZlcnkgYmFkIGNhc2Ug
KHNheSBzb21ldGhpbmcgdGFraW5nIHNldmVyYWwgaG91cnMgdG8gY29tcGxldGUpLgo+ID4KPiA+
IFRoZSB0cmFkZSBvZmYgaXMgbW9yZSBjb21wbGV4IGNvZGUgd2l0aCBidWdzIHRoYXQgY2FuIGhp
ZGUgZm9yIDEwKyB5ZWFycyBhbmQKPiA+IHRha2UgZGV2ZWxvcGVyIHRpbWUgdG8gZGVidWcuIEFs
c28sIGhpZ2hlciBtZW1vcnkgdXRpbGl6YXRpb246ICdzJyBkb3VibGVzCj4gPiBtZW1vcnkgdXRp
bGl6YXRpb24gcGVyIGNoaWxkIG9ubHkgdG8gZG8gdGhhdCBjaGVjay4KPgo+IFR1cmUsIHRoYXQn
cyB3aHkgdGhlIHByb2JsZW0gbm90IGJlZW4gZmluZCBzbyBtYW55IHllYXJzIQo+Cj4gPgo+ID4g
U28sIEkgc3VnZ2VzdCB3ZSBzdGljayB0byB0aGUgc2ltcGxlciBjb2RlLiBPciwgZ2V0IGl0IG1l
cmdlZCBub3cgKHNpbmNlIGl0J3MKPiA+IGZpeGluZyBhIGJ1ZyBhbmQgcG9zc2libHkgbWFraW5n
IHRoZSBjb2RlIF9mYXN0ZXJfKSBhbmQgdGhlbiB5b3UgY2FuIG9wdGltaXplCj4gPiBvbiB0b3Ag
bGF0ZXIgaWYgeW91IGxpa2UuCj4KPiBPaywgc291bmRzIHJlYXNvbmFibGUuCj4KPiBSZXZpZXdl
ZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4KPiBAQ3lyaWwsIEBQZXRyLCBJIHZv
dGUgdG8gbWVyZ2UgdGhpcyBvbmUgKGFzIGl0IGlzKSBiZWZvcmUgb3VyIE1heSByZWxlYXNlLgoK
QWNrZWQtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoKPgo+IC0tCj4gUmVn
YXJkcywKPiBMaSBXYW5nCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
