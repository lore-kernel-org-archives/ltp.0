Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D423D44157
	for <ltp@archiver.kernel.org>; Tue, 19 Nov 2024 13:12:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E9063D88FE
	for <ltp@archiver.kernel.org>; Tue, 19 Nov 2024 14:12:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 147D63D88D5
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 14:12:07 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4C9442264B5
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 14:12:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732021924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5PEjLjmvW8AuDBbdcf54vZoVcyHQ7i2Tbmxf9h7ttM=;
 b=E7ERLTskz/XjPKfDNNGiEVXp/nu5ftv0B6dyfLl4tfhR07UJZqMr2ZMATv69A+W0uzRW9d
 CnFGtSKvkN5Y/e+05xbBKX6RNprWThpTU/Y3ksldDNtKajGNeGdeti/YQZ9HULvPs8mdfo
 BhoStlHoP+dE7sYrAXMo1O9jd41NHN4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-F70nVSCrOgSFOm7l1vl5AA-1; Tue, 19 Nov 2024 08:12:03 -0500
X-MC-Unique: F70nVSCrOgSFOm7l1vl5AA-1
X-Mimecast-MFC-AGG-ID: F70nVSCrOgSFOm7l1vl5AA
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5eb5bbae71bso2553760eaf.2
 for <ltp@lists.linux.it>; Tue, 19 Nov 2024 05:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732021922; x=1732626722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5PEjLjmvW8AuDBbdcf54vZoVcyHQ7i2Tbmxf9h7ttM=;
 b=qPgyTpCE71gUk0a0k2SFK73Nzw1NKWu5RbEF3o6tqVhFz470Z7kUqUJp8geZM2B1B7
 n/Cf77t3bKqqTQIMJqRmtVMaj3BA0PG3VgZUmLeRCRRkI/iaC/l5mHG3ej9zziFr7Hes
 ucdUB1IcJfQL7sYltKQHOZ9p3bLjRw8RfSJtYj2up3gtyjUXkkgI+YvU6tGJNJnNTWCS
 TjV+w0EW6tkG6xXo7CeBoLrB9uHWC2zSqEY5ZaS1ffBKgjH/hCXgzRt0X9YVJgSlGT7f
 OdXHXoKLX6YzKPleF6SOzrWUD3iqcTAJHLyv3sxJE5KwTKstO30Cosqfo8/Nu/CVoaua
 BZ+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsdpEYNjhj7l4kB5rgKxNjBuKQFv5Gc36CrAQrFf7q+EebfBk/2MhonbSBX40DA8qTWEA=@lists.linux.it
X-Gm-Message-State: AOJu0YyiZeMryKM7UdsvMoEIhlVhr3E00gIOZVC1MHPFHXXI0nrC3wtE
 q353OrQzxdjGwtFdnGLAVLJq0jwfAORwnoir145YUT+Xirz+ppPOBgsRjx2165VPMkzyNiqmXKJ
 p5HsBCuPebBCUdMWMFZdkyGZ0kEjt4Svco4EBTJ5GjGNmA1ss5DJpdbyOLUc18ODv+u+Q5PixNP
 IbwML3PGpL8DtANi4n/1Eh3Ss=
X-Received: by 2002:a4a:c90e:0:b0:5ee:e029:f797 with SMTP id
 006d021491bc7-5eee029f8e4mr1241587eaf.6.1732021922570; 
 Tue, 19 Nov 2024 05:12:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKrgVjgg2jCTe40Di4ODwr5A0z/TV9aN+yeyX2aGB7ft9e5PWcvTmIJfLGOx5/+YXUbLeOX0uMEXB5+ad6tXo=
X-Received: by 2002:a4a:c90e:0:b0:5ee:e029:f797 with SMTP id
 006d021491bc7-5eee029f8e4mr1241566eaf.6.1732021922255; Tue, 19 Nov 2024
 05:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20241115154434.39461-1-mdoucha@suse.cz>
 <f92ebef0-5861-4a7c-8503-b4edbc18d7d7@suse.cz>
 <20241115185819.GA1754587@pevik>
In-Reply-To: <20241115185819.GA1754587@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Nov 2024 14:11:47 +0100
Message-ID: <CAASaF6zKhaK4SPxXR5eMgJoONZhi96LA9qv-DeQfr4MB6zs2sQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qHE11P7hhhg7SXHO7bB8VPM96NBEL6NJELO05WIyQrk_1732021922
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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

T24gRnJpLCBOb3YgMTUsIDIwMjQgYXQgNzo1OOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIExpLCBNYXJ0aW4sCj4KPiA+IFNvcnJ5LCBJIGZvcmdvdCB0byBD
QyBMaSBpbiB0aGUgcGF0Y2guCj4KPiA+IE9uIDE1LiAxMS4gMjQgMTY6NDQsIE1hcnRpbiBEb3Vj
aGEgd3JvdGU6Cj4gPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgZDJiOGE0NzZjMjlkNTJjNDg0YjM4
NzQ1NDA4MmJiYzkwNmIwYjRmOC4KPgo+ID4gPiBSZW1vdmUgdGhlIFBLRVlfRElTQUJMRV9FWEVD
VVRFIHN1YnRlc3QuIFRoZSBmdW5jdGlvbl9zaXplKCkgY29kZQo+ID4gPiBpcyBicm9rZW4gaW4g
YSB3YXkgdGhhdCBJIGNhbm5vdCBlYXNpbHkgZml4LiBUaGUgZnVuY3Rpb24gdHJpZXMKPiA+ID4g
dG8gY2FsY3VsYXRlIHRoZSBzaXplIG9mIGEgZnVuY3Rpb24gYnkgZmluZGluZyB0aGUgZmlyc3Qg
UkVUCj4gPiA+IGluc3RydWN0aW9uLiBIb3dldmVyLCBpbiAzMmJpdCBMVFAgYnVpbGRzLCB0aGUg
Y29kZSBnZXRzIGNvbXBpbGVkCj4gPiA+IHRvIHRoaXM6Cj4KPiA+ID4gMDgwNGI2OTAgPGZ1bmN0
aW9uX3NpemU+Ogo+ID4gPiAgIDgwNGI2OTA6ICAgICAgIDhiIDRjIDI0IDA0ICAgICAgICAgICAg
IG1vdiAgICAweDQoJWVzcCksJWVjeAo+ID4gPiAgIDgwNGI2OTQ6ICAgICAgIDBmIGI2IDAxICAg
ICAgICAgICAgICAgIG1vdnpibCAoJWVjeCksJWVheAo+ID4gPiAgIDgwNGI2OTc6ICAgICAgIDgz
IGMwIDNlICAgICAgICAgICAgICAgIGFkZCAgICAkMHgzZSwlZWF4Cj4gPiA+ICAgODA0YjY5YTog
ICAgICAgM2MgMDEgICAgICAgICAgICAgICAgICAgY21wICAgICQweDEsJWFsCj4gPiA+ICAgODA0
YjY5YzogICAgICAgNzYgMWEgICAgICAgICAgICAgICAgICAgamJlICAgIDgwNGI2YjggPGZ1bmN0
aW9uX3NpemUrMHgyOD4KPiA+ID4gICA4MDRiNjllOiAgICAgICA4OSBjOCAgICAgICAgICAgICAg
ICAgICBtb3YgICAgJWVjeCwlZWF4Cj4gPiA+ICAgODA0YjZhMDogICAgICAgODMgYzAgMDEgICAg
ICAgICAgICAgICAgYWRkICAgICQweDEsJWVheAo+ID4gPiAgIDgwNGI2YTM6ICAgICAgIDBmIGI2
IDEwICAgICAgICAgICAgICAgIG1vdnpibCAoJWVheCksJWVkeAo+ID4gPiAgIDgwNGI2YTY6ICAg
ICAgIDgzIGMyIDNlICAgICAgICAgICAgICAgIGFkZCAgICAkMHgzZSwlZWR4Cj4gPiA+ICAgODA0
YjZhOTogICAgICAgODAgZmEgMDEgICAgICAgICAgICAgICAgY21wICAgICQweDEsJWRsCj4gPiA+
ICAgODA0YjZhYzogICAgICAgNzcgZjIgICAgICAgICAgICAgICAgICAgamEgICAgIDgwNGI2YTAg
PGZ1bmN0aW9uX3NpemUrMHgxMD4KPiA+ID4gICA4MDRiNmFlOiAgICAgICAyOSBjOCAgICAgICAg
ICAgICAgICAgICBzdWIgICAgJWVjeCwlZWF4Cj4gPiA+ICAgODA0YjZiMDogICAgICAgODMgYzAg
MTAgICAgICAgICAgICAgICAgYWRkICAgICQweDEwLCVlYXgKPiA+ID4gICA4MDRiNmIzOiAgICAg
ICBjMyAgICAgICAgICAgICAgICAgICAgICByZXQKPiA+ID4gICA4MDRiNmI0OiAgICAgICA4ZCA3
NCAyNiAwMCAgICAgICAgICAgICBsZWEgICAgMHgwKCVlc2ksJWVpeiwxKSwlZXNpCj4gPiA+ICAg
ODA0YjZiODogICAgICAgYjggMTAgMDAgMDAgMDAgICAgICAgICAgbW92ICAgICQweDEwLCVlYXgK
PiA+ID4gICA4MDRiNmJkOiAgICAgICBjMyAgICAgICAgICAgICAgICAgICAgICByZXQKPiA+ID4g
ICA4MDRiNmJlOiAgICAgICA2NiA5MCAgICAgICAgICAgICAgICAgICB4Y2hnICAgJWF4LCVheAo+
Cj4gPiA+IElmIHlvdSBsb29rIGNsb3NlbHkgZW5vdWdoLCB5b3UnbGwgbm90aWNlIGEgQzIgYnl0
ZSBpbiBhZGQgJDB4M2UsJWVkeAo+ID4gPiBpbnN0cnVjdGlvbiBvbiBhZGRyZXNzIDgwNGI2YTYu
IFRoZSBmdW5jdGlvbiB3aWxsIGFzc3VtZSB0aGlzIGJ5dGUgaXMKPiA+ID4gYSBSRVQgaW5zdHJ1
Y3Rpb24sIHJldHVybiBhIHNpemUgdGhhdCdzIDIyIGJ5dGVzIHRvbyBzaG9ydCBhbmQgdGhlbgo+
ID4gPiB0aGUgY29kZSBleGVjdXRpb24gaW5zaWRlIHRoZSBleGVjdXRhYmxlIGJ1ZmZlciB3aWxs
IHJ1biBwYXN0IHRoZSBlbmQKPiA+ID4gb2YgYnVmZmVyLCByZXN1bHRpbmcgaW4gYSBzZWdmYXVs
dC4KPgo+IE1hcnRpbiwgdGhhbmtzIGEgbG90IGZvciBkZWJ1Z2dpbmchCj4KPiBBY2tlZC1ieTog
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KPiBPdGhlciBvcHRpb24gd291bGQgYmUgdG8g
ZGlzYWJsZSB0aGlzIHRlc3Qgb25seSBmb3IgMzJiaXQgKGtlZXAgaXQgZm9yIDY0Yml0KS4KPiBM
aSwgYW55IGNoYW5nZSB5b3UgY291bGQgaGF2ZSBsb29rIGludG8gaXQ/CgpJIHZhZ3VlbHkgcmVj
YWxsIHdlIGFscmVhZHkgZGVhbHQgd2l0aCBzb21ldGhpbmcgc2ltaWxhciBmb3IgYQpkaWZmZXJl
bnQgdGVzdCwgd2hpY2gKY29waWVkIGZ1bmN0aW9uLCB0aGVuIGNoYW5nZWQgcHJvdGVjdGlvbiB0
byBFWEVDIGFuZCBmaW5hbGx5IHJhbiBpdC4KSSdsbCBzZWUgaWYgSSBjYW4gZmluZCBpdC4KCj4K
PiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
