Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8EED4415D
	for <ltp@archiver.kernel.org>; Tue, 19 Nov 2024 13:32:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D40E93D8919
	for <ltp@archiver.kernel.org>; Tue, 19 Nov 2024 14:32:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A7A33D8904
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 14:32:15 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2CAF160271E
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 14:32:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732023132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hi+eXocQP4/OWC3pKPIk66p9G7l7v4kYwMphtbBJ7fM=;
 b=bQ3H9d7eiGOfHRuCGrByrPOsNRIkerMUNTBkWR0Ne6dX8MbTUCaussz4JLFFk7JGes34L/
 WY6Zce9OnK4DLUdYy1rMZegH0UD9QCcLNdeRYN8tzrtVnTsaiu+VsYGEeyulOWbqidfUeu
 QZ6s76MnivSIyfKfgyHtReMphN86Go8=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-ECoEPOeyPpOwIv1Q6ayXdA-1; Tue, 19 Nov 2024 08:32:11 -0500
X-MC-Unique: ECoEPOeyPpOwIv1Q6ayXdA-1
X-Mimecast-MFC-AGG-ID: ECoEPOeyPpOwIv1Q6ayXdA
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-2964720a511so3425547fac.3
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 05:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732023130; x=1732627930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hi+eXocQP4/OWC3pKPIk66p9G7l7v4kYwMphtbBJ7fM=;
 b=AA/GqjCmOWBixfFyR8AxVvnc13FyMsAei+x/loce29TY0I05kpR4Ztw1gNomFmEKuE
 rWvn6j4CWV2U4GyfKf5hrnLwmiN1J4WrRq9vxw7izVVsJaAUkliJElW7ZZUEmSAt3JPh
 5zSkZsb7Owpeqya2R6WHfgIMESQ3r+T+DkcDWU2ES4wN+yXfQudvRXBdJAJML0cGJfkp
 8EgSEImb/chHMypzOFjxXbMolc6X3rHjc79N1GhT4RjtDeLFuEGU9fVQqg7mO6MH60e9
 IXoK9MCozFEqDZUh+lDjBjpVb3kGu65hA4OwSiYl0iqpmG8HORwGtWGOEljM15zAXTQQ
 T3iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgkr8Ifm6clB1tXpm8LfW3J5g+D6ATWi+rJdk7I0Sn57RNm090asAkYYHkF2YzZvY0yE0=@lists.linux.it
X-Gm-Message-State: AOJu0YyU/7hioVVXGc0CPgdrxdpxmTgea7dcJvLhh3fsWIWBJcbvvABz
 BZQKxIyP2xEM6QPPFjqRGGkZUuRIYDFqkoPoDfjR24regus0EyRMqs5wc2+EX5aKKqATeaq+jaD
 TJjVD/X6arvWUxEdOEupP3Is6gt742DOIJziglTCEJvsRT43fzyaT3dhYFMgjTBuVc8rhFVUvCo
 OqehT2fNPoRv03qVH0va88ZEWz41SCFjppKg==
X-Received: by 2002:a05:6870:56a0:b0:288:6ce7:6d6b with SMTP id
 586e51a60fabf-2962dd90693mr14996891fac.5.1732023130350; 
 Tue, 19 Nov 2024 05:32:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/eiblH790wvGD2JS1w+iJ4jA44xdeKRvTm63gRzbLQ1spTDoY9mXVqPLCZRTQz/DPVDLqfo8qVXtzveFsxbc=
X-Received: by 2002:a05:6870:56a0:b0:288:6ce7:6d6b with SMTP id
 586e51a60fabf-2962dd90693mr14996872fac.5.1732023130085; Tue, 19 Nov 2024
 05:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20241115154434.39461-1-mdoucha@suse.cz>
 <f92ebef0-5861-4a7c-8503-b4edbc18d7d7@suse.cz>
 <20241115185819.GA1754587@pevik>
 <CAASaF6zKhaK4SPxXR5eMgJoONZhi96LA9qv-DeQfr4MB6zs2sQ@mail.gmail.com>
In-Reply-To: <CAASaF6zKhaK4SPxXR5eMgJoONZhi96LA9qv-DeQfr4MB6zs2sQ@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Nov 2024 14:31:55 +0100
Message-ID: <CAASaF6yd+FHWf8urwFbk6U6oTNnXhdR+CbGhWqq6DT+eKjeVfQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KaUz7yNO7SySOmz7Jn5J-RnpkoP9O3L8R-DDtclFKi0_1732023130
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
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

T24gVHVlLCBOb3YgMTksIDIwMjQgYXQgMjoxMeKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgTm92IDE1LCAyMDI0IGF0IDc6NTjigK9QTSBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4gPgo+ID4gSGkgTGksIE1hcnRpbiwK
PiA+Cj4gPiA+IFNvcnJ5LCBJIGZvcmdvdCB0byBDQyBMaSBpbiB0aGUgcGF0Y2guCj4gPgo+ID4g
PiBPbiAxNS4gMTEuIDI0IDE2OjQ0LCBNYXJ0aW4gRG91Y2hhIHdyb3RlOgo+ID4gPiA+IFRoaXMg
cmV2ZXJ0cyBjb21taXQgZDJiOGE0NzZjMjlkNTJjNDg0YjM4NzQ1NDA4MmJiYzkwNmIwYjRmOC4K
PiA+Cj4gPiA+ID4gUmVtb3ZlIHRoZSBQS0VZX0RJU0FCTEVfRVhFQ1VURSBzdWJ0ZXN0LiBUaGUg
ZnVuY3Rpb25fc2l6ZSgpIGNvZGUKPiA+ID4gPiBpcyBicm9rZW4gaW4gYSB3YXkgdGhhdCBJIGNh
bm5vdCBlYXNpbHkgZml4LiBUaGUgZnVuY3Rpb24gdHJpZXMKPiA+ID4gPiB0byBjYWxjdWxhdGUg
dGhlIHNpemUgb2YgYSBmdW5jdGlvbiBieSBmaW5kaW5nIHRoZSBmaXJzdCBSRVQKPiA+ID4gPiBp
bnN0cnVjdGlvbi4gSG93ZXZlciwgaW4gMzJiaXQgTFRQIGJ1aWxkcywgdGhlIGNvZGUgZ2V0cyBj
b21waWxlZAo+ID4gPiA+IHRvIHRoaXM6Cj4gPgo+ID4gPiA+IDA4MDRiNjkwIDxmdW5jdGlvbl9z
aXplPjoKPiA+ID4gPiAgIDgwNGI2OTA6ICAgICAgIDhiIDRjIDI0IDA0ICAgICAgICAgICAgIG1v
diAgICAweDQoJWVzcCksJWVjeAo+ID4gPiA+ICAgODA0YjY5NDogICAgICAgMGYgYjYgMDEgICAg
ICAgICAgICAgICAgbW92emJsICglZWN4KSwlZWF4Cj4gPiA+ID4gICA4MDRiNjk3OiAgICAgICA4
MyBjMCAzZSAgICAgICAgICAgICAgICBhZGQgICAgJDB4M2UsJWVheAo+ID4gPiA+ICAgODA0YjY5
YTogICAgICAgM2MgMDEgICAgICAgICAgICAgICAgICAgY21wICAgICQweDEsJWFsCj4gPiA+ID4g
ICA4MDRiNjljOiAgICAgICA3NiAxYSAgICAgICAgICAgICAgICAgICBqYmUgICAgODA0YjZiOCA8
ZnVuY3Rpb25fc2l6ZSsweDI4Pgo+ID4gPiA+ICAgODA0YjY5ZTogICAgICAgODkgYzggICAgICAg
ICAgICAgICAgICAgbW92ICAgICVlY3gsJWVheAo+ID4gPiA+ICAgODA0YjZhMDogICAgICAgODMg
YzAgMDEgICAgICAgICAgICAgICAgYWRkICAgICQweDEsJWVheAo+ID4gPiA+ICAgODA0YjZhMzog
ICAgICAgMGYgYjYgMTAgICAgICAgICAgICAgICAgbW92emJsICglZWF4KSwlZWR4Cj4gPiA+ID4g
ICA4MDRiNmE2OiAgICAgICA4MyBjMiAzZSAgICAgICAgICAgICAgICBhZGQgICAgJDB4M2UsJWVk
eAo+ID4gPiA+ICAgODA0YjZhOTogICAgICAgODAgZmEgMDEgICAgICAgICAgICAgICAgY21wICAg
ICQweDEsJWRsCj4gPiA+ID4gICA4MDRiNmFjOiAgICAgICA3NyBmMiAgICAgICAgICAgICAgICAg
ICBqYSAgICAgODA0YjZhMCA8ZnVuY3Rpb25fc2l6ZSsweDEwPgo+ID4gPiA+ICAgODA0YjZhZTog
ICAgICAgMjkgYzggICAgICAgICAgICAgICAgICAgc3ViICAgICVlY3gsJWVheAo+ID4gPiA+ICAg
ODA0YjZiMDogICAgICAgODMgYzAgMTAgICAgICAgICAgICAgICAgYWRkICAgICQweDEwLCVlYXgK
PiA+ID4gPiAgIDgwNGI2YjM6ICAgICAgIGMzICAgICAgICAgICAgICAgICAgICAgIHJldAo+ID4g
PiA+ICAgODA0YjZiNDogICAgICAgOGQgNzQgMjYgMDAgICAgICAgICAgICAgbGVhICAgIDB4MCgl
ZXNpLCVlaXosMSksJWVzaQo+ID4gPiA+ICAgODA0YjZiODogICAgICAgYjggMTAgMDAgMDAgMDAg
ICAgICAgICAgbW92ICAgICQweDEwLCVlYXgKPiA+ID4gPiAgIDgwNGI2YmQ6ICAgICAgIGMzICAg
ICAgICAgICAgICAgICAgICAgIHJldAo+ID4gPiA+ICAgODA0YjZiZTogICAgICAgNjYgOTAgICAg
ICAgICAgICAgICAgICAgeGNoZyAgICVheCwlYXgKPiA+Cj4gPiA+ID4gSWYgeW91IGxvb2sgY2xv
c2VseSBlbm91Z2gsIHlvdSdsbCBub3RpY2UgYSBDMiBieXRlIGluIGFkZCAkMHgzZSwlZWR4Cj4g
PiA+ID4gaW5zdHJ1Y3Rpb24gb24gYWRkcmVzcyA4MDRiNmE2LiBUaGUgZnVuY3Rpb24gd2lsbCBh
c3N1bWUgdGhpcyBieXRlIGlzCj4gPiA+ID4gYSBSRVQgaW5zdHJ1Y3Rpb24sIHJldHVybiBhIHNp
emUgdGhhdCdzIDIyIGJ5dGVzIHRvbyBzaG9ydCBhbmQgdGhlbgo+ID4gPiA+IHRoZSBjb2RlIGV4
ZWN1dGlvbiBpbnNpZGUgdGhlIGV4ZWN1dGFibGUgYnVmZmVyIHdpbGwgcnVuIHBhc3QgdGhlIGVu
ZAo+ID4gPiA+IG9mIGJ1ZmZlciwgcmVzdWx0aW5nIGluIGEgc2VnZmF1bHQuCj4gPgo+ID4gTWFy
dGluLCB0aGFua3MgYSBsb3QgZm9yIGRlYnVnZ2luZyEKPiA+Cj4gPiBBY2tlZC1ieTogUGV0ciBW
b3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPgo+ID4gT3RoZXIgb3B0aW9uIHdvdWxkIGJlIHRvIGRp
c2FibGUgdGhpcyB0ZXN0IG9ubHkgZm9yIDMyYml0IChrZWVwIGl0IGZvciA2NGJpdCkuCj4gPiBM
aSwgYW55IGNoYW5nZSB5b3UgY291bGQgaGF2ZSBsb29rIGludG8gaXQ/Cj4KPiBJIHZhZ3VlbHkg
cmVjYWxsIHdlIGFscmVhZHkgZGVhbHQgd2l0aCBzb21ldGhpbmcgc2ltaWxhciBmb3IgYQo+IGRp
ZmZlcmVudCB0ZXN0LCB3aGljaAo+IGNvcGllZCBmdW5jdGlvbiwgdGhlbiBjaGFuZ2VkIHByb3Rl
Y3Rpb24gdG8gRVhFQyBhbmQgZmluYWxseSByYW4gaXQuCj4gSSdsbCBzZWUgaWYgSSBjYW4gZmlu
ZCBpdC4KCkRvIHdlIG5lZWQgZnVuY3Rpb25fc2l6ZSgpIHRvIHJldHVybiBhY2N1cmF0ZSBudW1i
ZXI/IEluIG1wcm90ZWN0MDQKd2UgZW5kZWQgdXAgdXNpbmcgQ0ZMQUdTICs9IC1mYWxpZ24tZnVu
Y3Rpb25zPTY0IGFuZCBjb3B5aW5nIGV2ZXJ5dGhpbmcKdW50aWwgZW5kIG9mIHBhZ2UuIEZ1bmN0
aW9uIHdhcyBkdW1teSwgc28gaXQgYWx3YXlzIGZpdCBhbmQgaXQncyBub3QgYW4KaXNzdWUgaWYg
d2UgY29waWVkIG1vcmUuCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
