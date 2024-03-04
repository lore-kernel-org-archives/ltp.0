Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9ABC48BF6
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 10:04:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93B6E3CCED6
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 11:04:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46F563CCBCF
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 11:04:28 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3DEAD601DBC
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 11:04:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709546665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BLsXw9+ozKoHNPAGeJ2IJHwZ7+7FhO2ws3cltUidmsg=;
 b=LnpC2/AyfOJwnp+9SW4i3CINzFnmEkXpX2D3ipbX8lVsp9ExKU1jusLa755ATPhcRg0NHd
 eWVYRZ6zsG/xjApmBNI4YEn86AonniLEPOEokG0hK0RBeJPkXtNKYBj1GbN+/++gaQCz3X
 WRWs7FxZLiW7gCwrpa0KvhuAHzKvsK8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-0_L4hieRPGmwt3pOEf3vvg-1; Mon, 04 Mar 2024 05:04:21 -0500
X-MC-Unique: 0_L4hieRPGmwt3pOEf3vvg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5c6245bc7caso3658655a12.3
 for <ltp@lists.linux.it>; Mon, 04 Mar 2024 02:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709546660; x=1710151460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BLsXw9+ozKoHNPAGeJ2IJHwZ7+7FhO2ws3cltUidmsg=;
 b=o5A8ZBa/WOl5OfyXQojsBHX/wI6lie8OWTzGJK90d8Nz+eBZ5zCVCTIXcP3ftaL8Rx
 7Sl1sf7+h7cZiwRkQfbRHBXGAqqAYyueQPrfcLQA6+jnKrGoZPQgCPenh/CtsPRWIg2g
 UeqHJBVzMx158PPFdJidSNEDZX2qG/R9FuTLOJucejn/oWp7so1Dkw9lsj4AlF83uRFk
 uyQBEzFd4g1nP8uC1pQ9YIpkVCzOuaxCRNHDZgtoqSojwz/UYCaRuLok+e6SW01QI02H
 wK6N4HjJ5EN08634EaynWEj985LijVwq/MObC7cN3l62gQSiH/uAbx5cdxLoXHsLCswj
 6xbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoj8o4e1nWK0I2W7uQYHIsQVvuo17IqqIwrAAcPCqsCI6Zw7dVQJ0vqjgnV0PWoWp0wcNdt8AVFozEKg9aPqZIK7Q=
X-Gm-Message-State: AOJu0Yxo72KwKC2z6TgKAmjB7I5UA+H8ZqwvqpOHQ8C9suTFf3MH0O+g
 OOy1H26yrpplHk5moEhorR62qwRRLH+DZPMubszlq6G5L5OCZtP6BU3mv+rRovVO2jZ/okdQ7Q/
 aqJRvQQkCRgOTpCxKhevTBsQfes97OW8Xe6CoNXW/GUPWi/wAeuiQdTQ6svRULxDililN6C2HO+
 4UHJhkCHd3F+nKmScI+LmNyIs=
X-Received: by 2002:a05:6a20:3c90:b0:1a0:ea67:ecb2 with SMTP id
 b16-20020a056a203c9000b001a0ea67ecb2mr6380411pzj.12.1709546660703; 
 Mon, 04 Mar 2024 02:04:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz1vtSLU2tCE1rDCgpDgmqNTDP+ch9kuT3NsZdDUfMyVtHmqxBtYM4nxUa5gxKt+JoVaicBindLnlS/UYko18=
X-Received: by 2002:a05:6a20:3c90:b0:1a0:ea67:ecb2 with SMTP id
 b16-20020a056a203c9000b001a0ea67ecb2mr6380402pzj.12.1709546660350; Mon, 04
 Mar 2024 02:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20240301062716.3023-1-wegao@suse.com>
 <5681819a-2a3a-4c47-a1f1-3f9f49c994d9@fujitsu.com>
 <20240303131402.GC1856074@pevik>
 <CAEemH2eKts8X+tj1keU4Vqp5LwKRa8V1w7QdzGOPmC95F9JK7Q@mail.gmail.com>
 <c7f1510a-adf5-49b8-9f0e-45ad259be38d@fujitsu.com>
In-Reply-To: <c7f1510a-adf5-49b8-9f0e-45ad259be38d@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 4 Mar 2024 18:04:08 +0800
Message-ID: <CAEemH2e1yeu9yL2CbW3z0rVov67Oty_em0HmTrj86SUe0wMATw@mail.gmail.com>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] libswap.c: Improve caculate swap dev number
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgNCwgMjAyNCBhdCA1OjE54oCvUE0gWWFuZyBYdSAoRnVqaXRzdSkgPHh1eWFu
ZzIwMTguanlAZnVqaXRzdS5jb20+Cndyb3RlOgoKPiBIaSAgTGnvvIwKPgo+ID4KPiA+Cj4gPiBP
biBTdW4sIE1hciAzLCAyMDI0IGF0IDk6MTTigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5j
ego+ID4gPG1haWx0bzpwdm9yZWxAc3VzZS5jej4+IHdyb3RlOgo+ID4KPiA+ICAgICBIaSBXZWks
IFh1LAo+ID4KPiA+ICAgICAgPiBIaSAgV2VpCj4gPgo+ID4gICAgICA+ID4gSSBlbmNvdW50ZXIg
YSBkZWFkIGxvb3Agb24gZm9sbG93aW5nIGNvZGUgaW4gb3VyIHRlc3Qgb24gcHBjNjQKPiA+ICAg
ICBtYWNoaW5lOgo+ID4gICAgICA+ID4gd2hpbGUgKChjID0gZmdldGMoZnApKSAhPSBFT0YpCj4g
Pgo+ID4gICAgICA+ID4gSSB0aGluayAiL3Byb2Mvc3dhcHMiIGlzIG5vdCBub3JtYWwgZmlsZSBh
bmQgY2FuIG5vdCBnZXQgRU9GIGluCj4gPiAgICAgc29tZSBzaXR1YXRpb24sCj4gPiAgICAgID4g
PiBzbyBpIHVzZSBmZ2V0cyBhIGxpbmUgYW5kIGNhY3VsYXRlIHN3YXAgZGV2IG51bWJlci4KPiA+
Cj4gPiAgICAgSSBndWVzcyB0aGUgcHJvYmxlbSBoYXMgYmVlbiBmaXhlZCBieSBhbm90aGVyIHBh
dGNoIFsxXSwgdGh1cwo+ID4gICAgIGNsb3NpbmcgaXQgaW4KPiA+ICAgICBwYXRjaHdvcmsuIFBs
ZWFzZSBsZXQgbWUga25vdyBpZiBub3QuCj4gPgo+ID4KPiA+IFNlZW1zIG5vdCwgdGhlIHBhdGNo
IFsxXSBiZWxvdyBpcyBtYWlubHkgdG8gY291bnQgdGhlIGZyZWUgZGlzayBzaXplLgo+ID4KPiA+
IEJ1dCBXZWkncyB3b3JrIGhlcmUgaXMgdG8gY2FsY3VsYXRlIHN3YXAtZGV2IG51bWJlcnMgY29y
cmVjdGx5Cj4gPiAoZXNwZWNpYWxseSBnZXQgcmlkIG9mIEVPRiBhZmZlY3Rpb24gdG8gc29tZSBk
ZWdyZWUpLgo+ID4KPiA+IFh1IFlhbmcsIHdoYXQgZG8geW91IHRoaW5rPyBvciBkaWQgSSBtaXNz
IGFueXRoaW5nIGhlcmU/Cj4gPgo+ID4KPgo+IEkgc3RpbGwgdGhpbmsgd2UgY2FuIHVzZSB0aGUg
c2FtZSB3YXkgaW4gaXBjIGxpYnMgdG8gZ2V0IHJpZCBvZiB0aGUgRU9GCj4gcHJvYmxlbSBpbnN0
ZWFkIG9mCj4gc2VhcmNoaW5nICJkZXYiIGtleXdvcmQuIFdlIGp1c3QgZG9uJ3QgbmVlZCB0byAg
Y2FsY3VhbHRlICIvcHJvYy9zd2FwcyIKPiBoZWFkZXIuCj4KClNvdW5kcyBnb29kIHRvIG1lLiBB
dCBsZWFzdCBpdCBjb3VudHMgcmlnaHQgbGluZXMuCgpJdCdkIGJlIGdyZWF0IHRvIGhhdmUgYSBw
YXRjaCBieSB0aGF0IHdheS4KCgoKPgo+IGludCBnZXRfdXNlZF9zeXN2aXBjKGNvbnN0IGNoYXIg
KmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIGNvbnN0IGNoYXIKPiAqc3lzdmlwY19maWxlKQo+IHsK
PiAgICAgICAgIEZJTEUgKmZwOwo+ICAgICAgICAgaW50IHVzZWQgPSAtMTsKPiAgICAgICAgIGNo
YXIgYnVmW0JVRlNJWkVdOwo+Cj4gICAgICAgICBmcCA9IHNhZmVfZm9wZW4oZmlsZSwgbGluZW5v
LCBOVUxMLCBzeXN2aXBjX2ZpbGUsICJyIik7Cj4KPiAgICAgICAgIHdoaWxlIChmZ2V0cyhidWYs
IEJVRlNJWkUsIGZwKSAhPSBOVUxMKQo+ICAgICAgICAgICAgICAgICB1c2VkKys7Cj4KPiAgICAg
ICAgIGZjbG9zZShmcCk7Cj4KPiAgICAgICAgIGlmICh1c2VkIDwgMCkgewo+ICAgICAgICAgICAg
ICAgICB0c3RfYnJrKFRCUk9LLCAiY2FuJ3QgcmVhZCAlcyB0byBnZXQgdXNlZCBzeXN2aXBjIHJl
c291cmNlCj4gdG90YWwgYXQgIgo+ICAgICAgICAgICAgICAgICAgICAgICAgICIlczolZCIsIHN5
c3ZpcGNfZmlsZSwgZmlsZSwgbGluZW5vKTsKPiAgICAgICAgIH0KPgo+ICAgICAgICAgcmV0dXJu
IHVzZWQ7Cj4gfQo+Cj4gQnV0IHdlIGRvbid0IGdldCB0aGUgYWN0dWFsIHJlYXNvbiwgSSBzdGls
bCB3b25kZXIgd2h5IHRoaXMgZGVhZGxvb3AKPiBleGlzdHMgbyBwcGNjNjQgaW5zdGVhZCBvZgo+
IG90aGVyIGFyY2hpdGVjdHVyZShpZSB4ODZfNjQpLgo+CgpPaywgSSB0aGluayB3ZSBjYW4ganVz
dCBhcHBseSB5b3VyIHN1Z2dlc3RlZCBtZXRob2QgdG8gc2VlIGlmIHRoYXQgZGVhZGxvb3AKZGlz
YXBwZWFycy4KCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
