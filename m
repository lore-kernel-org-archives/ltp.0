Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D950C3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 13:41:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 318963D1C59
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 15:41:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F0F93D1C2A
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:41:28 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8B736600E4F
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 15:41:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721828485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mhEFAi1d8WPXtb6KZrpB3YIl9Jeso6bMfBsvZM6IeAU=;
 b=i1ttKFfipgrNeio4spP2hVAPenH41Di3hJseVSrMirA1i52+kT7Ez+CBtkMU6VaX8hFpoF
 H1Glzt2wUoM9zB1iLBp8jri7inACUO87zr0Cwv/vG8hTY+3yJfF5iBvxvSJa48y/gPAimI
 +V3RVQr8KfkvM5rKHbu31HfBs1y1cKc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-l4fAya57NZm7uEk_QFXo1g-1; Wed, 24 Jul 2024 09:41:21 -0400
X-MC-Unique: l4fAya57NZm7uEk_QFXo1g-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7a2a04c79b6so960146a12.0
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 06:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721828480; x=1722433280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mhEFAi1d8WPXtb6KZrpB3YIl9Jeso6bMfBsvZM6IeAU=;
 b=jPhdZwfxfLUQdiUGp7HA8xHOrxhw5ECOseINgjn5B2Ehk1XAvG4O+BDs2a7hgdFU87
 Ut5FTpSErMh3EukKzULMxR63XNZZXsAvLPiS7dtkaoWdyT+INbU3aQmB6fVa3uzPozs6
 btioAhfo+NSQQ6DkgUyzfiGtSj62cvHMcQqkq3Pvetm/RazwGWEqs29dSyNz6U5wPPky
 MGZ5g4WqT1fufN123AwM4IScuHxAGpNT1FDGo+NiLL3Pat4d/a4SNLtlxv4a3gXEkbVv
 1fpD+v/3nU1qN0lWxHb6GiUW+y7JnPs627uwwlofp0tBO4wrnFV77wR0VQthxpRcpaIg
 JNLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/mxenJHswHf8HesjHBoErCV6VPBdtF4zquO1ulg105ViiwkXvq2Hl/Jk5e+ESumdRcwAa0SO0Glw6cq90dj6gXwA=
X-Gm-Message-State: AOJu0YwR1XFvw9UYgvD2vsEl5gP/HwhjTWxEfM+k5f967TOruKReOgCP
 pZnY8L1OzcnXqium9bPvbjnfOWbfS/+fUGz4E8S/ER5I4c3hkysudlYqj9R3o/wzLoUfIGvPnDr
 ux3v9bWwr8J8n7+HbPNUpWMRdcBVuXRd6zhXfeJkJX6vNvS2DjlXcZQLemzMpOtNN9SfayaC7HL
 kpcQTqlrrCojq5YSO6+fzpYgY=
X-Received: by 2002:a17:90a:8a10:b0:2ab:8324:1b47 with SMTP id
 98e67ed59e1d1-2cdb93f7cd0mr3198467a91.15.1721828480561; 
 Wed, 24 Jul 2024 06:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYol06KsB0JVQUs9BwESYW34Ze1qqE/MAg+5vRfMKE1aB9qE8WoaHyoKwCdJPoYDYtC7ES2Nw3lIFVV8LBYQY=
X-Received: by 2002:a17:90a:8a10:b0:2ab:8324:1b47 with SMTP id
 98e67ed59e1d1-2cdb93f7cd0mr3198436a91.15.1721828480148; Wed, 24 Jul 2024
 06:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-9-c7b0e9edf9b0@suse.com>
 <20240716172725.GC549165@pevik>
 <CAEemH2fP9eGdHs1Wb5JLhS-H-XXxKB=73n8WAXqj3ZNxw9xDVA@mail.gmail.com>
 <20240724133003.GB950793@pevik>
 <CAEemH2c5r=AaiSGPfdvXSZ9G=iTa2c2eSRHd-WLL9hL_wHvK7w@mail.gmail.com>
In-Reply-To: <CAEemH2c5r=AaiSGPfdvXSZ9G=iTa2c2eSRHd-WLL9hL_wHvK7w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Jul 2024 21:41:07 +0800
Message-ID: <CAEemH2eaUAKTpM_NTT_fk2Z0Bz+QPKO8F9v92zAgRr-F2Ggnfg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 09/11] Add landlock04 test
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
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdWwgMjQsIDIwMjQgYXQgOTozN+KAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4KPgo+IE9uIFdlZCwgSnVsIDI0LCAyMDI0IGF0IDk6MzDigK9QTSBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPj4gSGkgTGksIEFuZHJlYSwKPj4KPj4g
PiBIaSBQZXRyLCBBbmRyZWEsCj4+IC4uLgo+PiA+ID4gLi4uCj4+ID4gPiB0c3Rfc3VwcG9ydGVk
X2ZzX3R5cGVzLmM6OTc6IFRJTkZPOiBLZXJuZWwgc3VwcG9ydHMgdG1wZnMKPj4gPiA+IHRzdF9z
dXBwb3J0ZWRfZnNfdHlwZXMuYzo0OTogVElORk86IG1rZnMgaXMgbm90IG5lZWRlZCBmb3IgdG1w
ZnMKPj4gPiA+IHRzdF90ZXN0LmM6MTc0NjogVElORk86ID09PSBUZXN0aW5nIG9uIGV4dDIgPT09
Cj4+ID4gPiB0c3RfdGVzdC5jOjExMTE6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDEgd2l0
aCBleHQyIG9wdHM9JycgZXh0cmEKPj4gPiA+IG9wdHM9JycKPj4gPiA+IG1rZTJmcyAxLjQ3LjAg
KDUtRmViLTIwMjMpCj4+ID4gPiB0c3RfdGVzdC5jOjExMjM6IFRJTkZPOiBNb3VudGluZyAvZGV2
L2xvb3AxIHRvCj4+IC90bXAvTFRQX2xhbnQ2V2JLSi9zYW5kYm94Cj4+ID4gPiBmc3R5cD1leHQy
IGZsYWdzPTAKPj4gPiA+IGxhbmRsb2NrX2NvbW1vbi5oOjMwOiBUSU5GTzogTGFuZGxvY2sgQUJJ
IHYzCj4+ID4gPiBsYW5kbG9jazA0LmM6MTUxOiBUSU5GTzogVGVzdGluZyBMQU5ETE9DS19BQ0NF
U1NfRlNfRVhFQ1VURQo+PiA+ID4gbGFuZGxvY2swNC5jOjEyMzogVElORk86IEVuYWJsZSByZWFk
L2V4ZWMgcGVybWlzc2lvbnMgZm9yCj4+ID4gPiAvdXNyL2xpYi9pMzg2LWxpbnV4LWdudS9saWJj
LnNvLjYKPj4gPiA+IGxhbmRsb2NrMDQuYzoxMzE6IFRCUk9LOiBsYW5kbG9ja19hZGRfcnVsZSgz
LCAxLCAweGY3ZjEzZmY0LCAwKToKPj4gRUlOVkFMCj4+ID4gPiAoMjIpCj4+Cj4+Cj4+ID4gUG9z
c2libHkgdGhhdCdzIGJlY2F1c2UgdGhlICdMQU5ETE9DS19SVUxFX1BBVEhfQkVORUFUSCcgIHdh
cwo+PiA+IHJlZmFjdG9yZWQgZnJvbSB0aGUgdjYuNyBtYWlubGluZSBrZXJuZWwsIHNvIGl0IGNh
bid0IGFkZCB0aGUgcnVsZQo+PiBjb3JyZWN0bHkKPj4gPiB3aXRoIG9sZGVyIGtlcm5lbHMuCj4+
Cj4+ID4gY29tbWl0IDBlMGZjN2U4ZWI0YTExYmQ5Zjg5YTljNzRiYzdjMGUxNDRjNTYyMDMKPj4g
PiBBdXRob3I6IEtvbnN0YW50aW4gTWVza2hpZHplIDxrb25zdGFudGluLm1lc2toaWR6ZUBodWF3
ZWkuY29tPgo+PiA+IERhdGU6ICAgVGh1IE9jdCAyNiAwOTo0Nzo0NiAyMDIzICswODAwCj4+Cj4+
ID4gICAgIGxhbmRsb2NrOiBSZWZhY3RvciBsYW5kbG9ja19hZGRfcnVsZSgpIHN5c2NhbGwKPj4K
Pj4gPiBCdXQgdGhpcyBpcyBteSBndWVzcyAodGhyb3VnaCByZWFkaW5nIHRoZSBjb2RlKSwgSSBk
aWRuJ3QgZG8gbW9yZSB0bwo+PiA+IHZlcmlmeSB0aGF0IGJ5IGluc3RhbGxpbmcgc3VjaCBhIGtl
cm5lbC4KPj4KPj4gVGhhbmtzLCBMaSwgIGZvciBhIGhpbnQuIFF1aWNrIHRlc3Qgc2hvd3MgdGhh
dCBpdCdzIHdvcmtpbmcgb24gNi45LjksIGJ1dAo+PiBicm9rZW4KPj4gd2l0aCB3aXRoIDYuNi54
IG9yIDYuNS54LCBhbHNvIHJlcHJvZHVjZWQgb24gbW9yZSBkaXN0cm9zLiBJJ2xsIHZlcmlmeQo+
PiB0aGlzCj4+IHNwZWNpZmljIGNvbW1pdCwgSSBzdXBwb3NlIHdlIHNob3VsZCByZXF1aXJlIDYu
NywgcmlnaHQ/Cj4+Cj4KQW5kIEJUVywgdGhlIGJlbG93IGNvbW1pdCBpcyBhbm90aGVyIChvbiBt
eSBzdXNwaWNpb24gbGlzdCkgdGhhdCBuZWVkcwpjaGVjay4KCmNvbW1pdCAxM2ZjNjQ1NWZhMTli
MDg1OWUxYjk2NDBiZjA5OTAzYmVjOGRmNGY0CkF1dGhvcjogS29uc3RhbnRpbiBNZXNraGlkemUg
PGtvbnN0YW50aW4ubWVza2hpZHplQGh1YXdlaS5jb20+CkRhdGU6ICAgVGh1IE9jdCAyNiAwOTo0
Nzo0MCAyMDIzICswODAwCgogICAgbGFuZGxvY2s6IE1ha2UgcnVsZXNldCdzIGFjY2VzcyBtYXNr
cyBtb3JlIGdlbmVyaWMKCgo+IEkgdGhpbmsgWUVTLCA2LjcgaW5jbHVkZXMgc29tZSB2aXRhbCBp
bXByb3ZlbWVudCBvbiB0aGUgbGFuZGxvY2sgc3lzY2FsbC4KPgo+Cj4gLS0KPiBSZWdhcmRzLAo+
IExpIFdhbmcKPgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
