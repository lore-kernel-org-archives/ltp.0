Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8190D63936
	for <ltp@archiver.kernel.org>; Wed, 20 Nov 2024 12:58:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B01E63D8F87
	for <ltp@archiver.kernel.org>; Wed, 20 Nov 2024 13:58:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91C773D8E7B
 for <ltp@lists.linux.it>; Wed, 20 Nov 2024 13:57:54 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C83DC644B44
 for <ltp@lists.linux.it>; Wed, 20 Nov 2024 13:57:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732107471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7GmQPGGymCZNrGAo/UiFf0r1RKpBz5550IBNIVVXt6A=;
 b=BJdXL0Q5sgwhhgeSJvr49ZKDXGPsPnPJ5lw/dKnGoNDtzXYFNy950TZOAgYufMoqiJzRJ4
 yYGxmZaa8WrE5fIvPThbsHQ2ukOlTYRHxRKvwNxZqC5xunfU7Cbqh202/5SSWPNEE39rbO
 BuBRPubdppsZTARgTCIf/Yvdtqa4uXE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-kAY6CFKQPt-VeOrubncVhw-1; Wed, 20 Nov 2024 07:57:50 -0500
X-MC-Unique: kAY6CFKQPt-VeOrubncVhw-1
X-Mimecast-MFC-AGG-ID: kAY6CFKQPt-VeOrubncVhw
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7ea8baba4d5so2324785a12.2
 for <ltp@lists.linux.it>; Wed, 20 Nov 2024 04:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732107469; x=1732712269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7GmQPGGymCZNrGAo/UiFf0r1RKpBz5550IBNIVVXt6A=;
 b=m+Ars59QxnTJz/iFvxP71P4h4vwn1zPnckFraVJTatd9seDJ8y4240HcFMPUYrLKcD
 bGvyurCLJPJcG6eSPxeeT6OdyOnbT3tL6UH8ovz9EESk/iERigVMTAnPOrNcMQgu1p3t
 9OI3BLYCNzCOUk481EAkKdV4v04Y4sz/1dgcoKTobHvsgHDCzii0jg1/fs8T9pq2t0eL
 K8tIHSeoE1K6NfVI5hevggJKKjntsF11BZi3mvljbkZ2vJmbbfJ04EdLWCi5WLEyx/fk
 ZVdtr3sezkL3gqci9kOyuUgendzzWDYB4YglqJOG2eHbDMuHecFSQcuC1lEfFHyL5T0y
 WUWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX1fCA+l5gyMK0r82qs/slaW8ja1ppigKEhA6SaO+YiS2EeOtRy0YBWgIBs1bqCgCNKDM=@lists.linux.it
X-Gm-Message-State: AOJu0Yw/jVtoecwzQbDM17TXdb72IZs8Mt34i2HXdMf5EWZtse88JUmb
 wgox7Z9jiA6a3Vnf6+aL1gGE0I+hbo3r6yMWzt0gISBjjdNTpOeuiZf2YUrZ23yHIkAQwcE1l9S
 qYgzgunYL97AR9mV89jMbNR6LYctDjawqzHw4tP/gbf50gRiLSGySjmmesgHsldAmj78r3MdxsC
 Z5vxFNzymRiHEnFKpiZIC82C0=
X-Received: by 2002:a05:6a21:3992:b0:1cf:3c60:b8d3 with SMTP id
 adf61e73a8af0-1ddaead7b56mr3586782637.19.1732107469049; 
 Wed, 20 Nov 2024 04:57:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHszREgLNJdVMWsd472NFVvID6URi1lXblQN+NuWR4/Smwez88xKAqwSAcgztLn3H+UnXm7IyFtYsvqYehB5ok=
X-Received: by 2002:a05:6a21:3992:b0:1cf:3c60:b8d3 with SMTP id
 adf61e73a8af0-1ddaead7b56mr3586754637.19.1732107468603; Wed, 20 Nov 2024
 04:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20241115154434.39461-1-mdoucha@suse.cz>
 <f92ebef0-5861-4a7c-8503-b4edbc18d7d7@suse.cz>
 <20241115185819.GA1754587@pevik>
 <CAASaF6zKhaK4SPxXR5eMgJoONZhi96LA9qv-DeQfr4MB6zs2sQ@mail.gmail.com>
 <CAASaF6yd+FHWf8urwFbk6U6oTNnXhdR+CbGhWqq6DT+eKjeVfQ@mail.gmail.com>
In-Reply-To: <CAASaF6yd+FHWf8urwFbk6U6oTNnXhdR+CbGhWqq6DT+eKjeVfQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Nov 2024 20:57:36 +0800
Message-ID: <CAEemH2fhk4hYm0b1Nr2BQMc12zwWSZyUZA=r-dH5dws+KGzqDg@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PdfZc8li4bfMxEyLFS__rhnKc6L5P-cN96ODxlJf0-o_1732107469
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Revert "pkey01: Adding test for
 PKEY_DISABLE_EXECUTE"
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

T24gVHVlLCBOb3YgMTksIDIwMjQgYXQgOTozMuKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gT24gVHVlLCBOb3YgMTksIDIwMjQgYXQgMjoxMeKAr1BNIEph
biBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBGcmksIE5v
diAxNSwgMjAyNCBhdCA3OjU44oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3Rl
Ogo+ID4gPgo+ID4gPiBIaSBMaSwgTWFydGluLAo+ID4gPgo+ID4gPiA+IFNvcnJ5LCBJIGZvcmdv
dCB0byBDQyBMaSBpbiB0aGUgcGF0Y2guCj4gPiA+Cj4gPiA+ID4gT24gMTUuIDExLiAyNCAxNjo0
NCwgTWFydGluIERvdWNoYSB3cm90ZToKPiA+ID4gPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgZDJi
OGE0NzZjMjlkNTJjNDg0YjM4NzQ1NDA4MmJiYzkwNmIwYjRmOC4KPiA+ID4KPiA+ID4gPiA+IFJl
bW92ZSB0aGUgUEtFWV9ESVNBQkxFX0VYRUNVVEUgc3VidGVzdC4gVGhlIGZ1bmN0aW9uX3NpemUo
KSBjb2RlCj4gPiA+ID4gPiBpcyBicm9rZW4gaW4gYSB3YXkgdGhhdCBJIGNhbm5vdCBlYXNpbHkg
Zml4LiBUaGUgZnVuY3Rpb24gdHJpZXMKPiA+ID4gPiA+IHRvIGNhbGN1bGF0ZSB0aGUgc2l6ZSBv
ZiBhIGZ1bmN0aW9uIGJ5IGZpbmRpbmcgdGhlIGZpcnN0IFJFVAo+ID4gPiA+ID4gaW5zdHJ1Y3Rp
b24uIEhvd2V2ZXIsIGluIDMyYml0IExUUCBidWlsZHMsIHRoZSBjb2RlIGdldHMgY29tcGlsZWQK
PiA+ID4gPiA+IHRvIHRoaXM6Cj4gPiA+Cj4gPiA+ID4gPiAwODA0YjY5MCA8ZnVuY3Rpb25fc2l6
ZT46Cj4gPiA+ID4gPiAgIDgwNGI2OTA6ICAgICAgIDhiIDRjIDI0IDA0ICAgICAgICAgICAgIG1v
diAgICAweDQoJWVzcCksJWVjeAo+ID4gPiA+ID4gICA4MDRiNjk0OiAgICAgICAwZiBiNiAwMSAg
ICAgICAgICAgICAgICBtb3Z6YmwgKCVlY3gpLCVlYXgKPiA+ID4gPiA+ICAgODA0YjY5NzogICAg
ICAgODMgYzAgM2UgICAgICAgICAgICAgICAgYWRkICAgICQweDNlLCVlYXgKPiA+ID4gPiA+ICAg
ODA0YjY5YTogICAgICAgM2MgMDEgICAgICAgICAgICAgICAgICAgY21wICAgICQweDEsJWFsCj4g
PiA+ID4gPiAgIDgwNGI2OWM6ICAgICAgIDc2IDFhICAgICAgICAgICAgICAgICAgIGpiZSAgICA4
MDRiNmI4Cj4gPGZ1bmN0aW9uX3NpemUrMHgyOD4KPiA+ID4gPiA+ICAgODA0YjY5ZTogICAgICAg
ODkgYzggICAgICAgICAgICAgICAgICAgbW92ICAgICVlY3gsJWVheAo+ID4gPiA+ID4gICA4MDRi
NmEwOiAgICAgICA4MyBjMCAwMSAgICAgICAgICAgICAgICBhZGQgICAgJDB4MSwlZWF4Cj4gPiA+
ID4gPiAgIDgwNGI2YTM6ICAgICAgIDBmIGI2IDEwICAgICAgICAgICAgICAgIG1vdnpibCAoJWVh
eCksJWVkeAo+ID4gPiA+ID4gICA4MDRiNmE2OiAgICAgICA4MyBjMiAzZSAgICAgICAgICAgICAg
ICBhZGQgICAgJDB4M2UsJWVkeAo+ID4gPiA+ID4gICA4MDRiNmE5OiAgICAgICA4MCBmYSAwMSAg
ICAgICAgICAgICAgICBjbXAgICAgJDB4MSwlZGwKPiA+ID4gPiA+ICAgODA0YjZhYzogICAgICAg
NzcgZjIgICAgICAgICAgICAgICAgICAgamEgICAgIDgwNGI2YTAKPiA8ZnVuY3Rpb25fc2l6ZSsw
eDEwPgo+ID4gPiA+ID4gICA4MDRiNmFlOiAgICAgICAyOSBjOCAgICAgICAgICAgICAgICAgICBz
dWIgICAgJWVjeCwlZWF4Cj4gPiA+ID4gPiAgIDgwNGI2YjA6ICAgICAgIDgzIGMwIDEwICAgICAg
ICAgICAgICAgIGFkZCAgICAkMHgxMCwlZWF4Cj4gPiA+ID4gPiAgIDgwNGI2YjM6ICAgICAgIGMz
ICAgICAgICAgICAgICAgICAgICAgIHJldAo+ID4gPiA+ID4gICA4MDRiNmI0OiAgICAgICA4ZCA3
NCAyNiAwMCAgICAgICAgICAgICBsZWEKPiAweDAoJWVzaSwlZWl6LDEpLCVlc2kKPiA+ID4gPiA+
ICAgODA0YjZiODogICAgICAgYjggMTAgMDAgMDAgMDAgICAgICAgICAgbW92ICAgICQweDEwLCVl
YXgKPiA+ID4gPiA+ICAgODA0YjZiZDogICAgICAgYzMgICAgICAgICAgICAgICAgICAgICAgcmV0
Cj4gPiA+ID4gPiAgIDgwNGI2YmU6ICAgICAgIDY2IDkwICAgICAgICAgICAgICAgICAgIHhjaGcg
ICAlYXgsJWF4Cj4gPiA+Cj4gPiA+ID4gPiBJZiB5b3UgbG9vayBjbG9zZWx5IGVub3VnaCwgeW91
J2xsIG5vdGljZSBhIEMyIGJ5dGUgaW4gYWRkCj4gJDB4M2UsJWVkeAo+ID4gPiA+ID4gaW5zdHJ1
Y3Rpb24gb24gYWRkcmVzcyA4MDRiNmE2LiBUaGUgZnVuY3Rpb24gd2lsbCBhc3N1bWUgdGhpcyBi
eXRlCj4gaXMKPiA+ID4gPiA+IGEgUkVUIGluc3RydWN0aW9uLCByZXR1cm4gYSBzaXplIHRoYXQn
cyAyMiBieXRlcyB0b28gc2hvcnQgYW5kIHRoZW4KPiA+ID4gPiA+IHRoZSBjb2RlIGV4ZWN1dGlv
biBpbnNpZGUgdGhlIGV4ZWN1dGFibGUgYnVmZmVyIHdpbGwgcnVuIHBhc3QgdGhlCj4gZW5kCj4g
PiA+ID4gPiBvZiBidWZmZXIsIHJlc3VsdGluZyBpbiBhIHNlZ2ZhdWx0Lgo+ID4gPgo+ID4gPiBN
YXJ0aW4sIHRoYW5rcyBhIGxvdCBmb3IgZGVidWdnaW5nIQo+ID4gPgo+ID4gPiBBY2tlZC1ieTog
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiA+Cj4gPiA+IE90aGVyIG9wdGlvbiB3b3Vs
ZCBiZSB0byBkaXNhYmxlIHRoaXMgdGVzdCBvbmx5IGZvciAzMmJpdCAoa2VlcCBpdCBmb3IKPiA2
NGJpdCkuCj4gPiA+IExpLCBhbnkgY2hhbmdlIHlvdSBjb3VsZCBoYXZlIGxvb2sgaW50byBpdD8K
PiA+Cj4gPiBJIHZhZ3VlbHkgcmVjYWxsIHdlIGFscmVhZHkgZGVhbHQgd2l0aCBzb21ldGhpbmcg
c2ltaWxhciBmb3IgYQo+ID4gZGlmZmVyZW50IHRlc3QsIHdoaWNoCj4gPiBjb3BpZWQgZnVuY3Rp
b24sIHRoZW4gY2hhbmdlZCBwcm90ZWN0aW9uIHRvIEVYRUMgYW5kIGZpbmFsbHkgcmFuIGl0Lgo+
ID4gSSdsbCBzZWUgaWYgSSBjYW4gZmluZCBpdC4KPgo+IERvIHdlIG5lZWQgZnVuY3Rpb25fc2l6
ZSgpIHRvIHJldHVybiBhY2N1cmF0ZSBudW1iZXI/IEluIG1wcm90ZWN0MDQKPgoKVGhhdCBpcyBh
IHNpbXBsZSBtZXRob2QgdG8gY2hlY2sgdGhhdCB0aGUgYnVmZmVyIGNhbiBiZSBleGVjdXRlZCBj
b3JyZWN0bHkuCgoKPiB3ZSBlbmRlZCB1cCB1c2luZyBDRkxBR1MgKz0gLWZhbGlnbi1mdW5jdGlv
bnM9NjQgYW5kIGNvcHlpbmcgZXZlcnl0aGluZwo+IHVudGlsIGVuZCBvZiBwYWdlLiBGdW5jdGlv
biB3YXMgZHVtbXksIHNvIGl0IGFsd2F5cyBmaXQgYW5kIGl0J3Mgbm90IGFuCj4gaXNzdWUgaWYg
d2UgY29waWVkIG1vcmUuCj4KClllcywgdGhpcyBjb3VsZCB3b3JrIGFzIHdlbGwsIHRoYW5rcyBm
b3IgaW1wcm92aW5nIGl0LgoKUC5zIEkgYW0gb24gdHJhdmVsaW5nIHRoaXMgd2Vlaywgc28gSSB3
b3VsZG4ndCBmaW5kIGEgbWFjaGluZSB0byB0ZXN0IHRoZQpwYXRjaC4KCgotLSAKUmVnYXJkcywK
TGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
