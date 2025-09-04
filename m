Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0F3CA1010
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 03:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756955238; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ukbrM/E2pNyNQQUk3SCIxrc7INvqbBGCqE9bOQM/x2I=;
 b=QoDOes8qP/y6quo3Y8C963Jl3mTT/a8GIxvkM0qaZzsH0q/clQZdrt1cGpsubNba7pYWR
 QhmrRJ51bHll3Yh6X+OV9kBRf8Si2Hgpkx8HUnqsC9beDMNRn34AEyeMTcRutlyoucWy30H
 SDW6UWcrWUcTv/TKEOOe9gZ1MAuviwY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A99C23CD3F4
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 05:07:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E862C3CB864
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 05:06:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 356622000D0
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 05:06:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756955215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3K5jWXELl1qCjPpSMu339MLg5cjztqMBEy/gC9jfa6k=;
 b=V7Ry2s47EUsowAX5tlMz/HvU1SAl9j6EYkxUYKpn9eP8EYA3LHzbqYPCXr+i5Dl/oPDklB
 KsQtG8cSAikoHlTyfe1rAjszP7D3A0QqvSdiOHWfmd+OLpyJsPrM4LLUjB0jbZgi5S3RTs
 da3aSQVc1drDWH/xVvLU2v6obP8wWXk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-_Mj8Zqw4NR-1iIXuKHO74A-1; Wed, 03 Sep 2025 23:06:53 -0400
X-MC-Unique: _Mj8Zqw4NR-1iIXuKHO74A-1
X-Mimecast-MFC-AGG-ID: _Mj8Zqw4NR-1iIXuKHO74A_1756955212
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2445805d386so5456815ad.1
 for <ltp@lists.linux.it>; Wed, 03 Sep 2025 20:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756955212; x=1757560012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3K5jWXELl1qCjPpSMu339MLg5cjztqMBEy/gC9jfa6k=;
 b=MSqMHIUZQqbep/OaJ9YNul6CDvSqGiUbzSGutCBG+24kFmbbcT3evQixTkNiiBMt36
 +NpnSnxwzDY/P7QWj9samL/xhjXe9IcRtjqL+tNHZB8rRhN9fxjyuqKOHfY6QOzW3Tx4
 YdzKaFxUSSAcIyi8rYHN1sL2k6p/G4bmTUorptLVBt3iLzoEJ+a6IttpI+IibeOkiLwO
 Uwt6i/SiKIojx55A3l7ef+atDlOZ6pE1ybEsCIva1Nt9BYGsHYIcfrb8UX4OJ5v5hWlT
 Y7wJkVYAAWB8+WQGyXQ2o4FW0R94I7gwUGkNcX6W7PpuP5K0edSTjvc4C7meXlTVdD7L
 9FFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeps6prFiHMPw9D/pgYJYu9GkT6zk1eHByli7TuytWv+F2srsgyvQOWN3abN8LIBDs/U8=@lists.linux.it
X-Gm-Message-State: AOJu0YzrVb7nsUpfbns3KEvvt3Tt+KSXyPT0BJFaMLJ+G2GuchH4clAf
 9pRZsxbXZeTK3w7c6+WAaK07XUfscNISiz8y9E7G3Mr+qaou3yQVy5WR334QxxoBv4qwib/rwbo
 UYlUFeHWx6i1512yh1DyL95DpduqpWpMa2+TRvnMwSbAuIYT1mp3HSIFhMeBy4lFGFG7rlPlO9Y
 pNGwwQbDCJ2mNmtTrwq7Q+uNffWNI=
X-Gm-Gg: ASbGncu8MdFLDIuwQ4fRbbKs6xf0wRJbOusex6WCQ06t2r+bL2lNTwCdmWH6Bodb0HS
 9cC1TJM/kl+whzgViH+p9jS7EW17I5JhSXLhR34jm28nPNg0DwMAS/AJ2a6hqmQrP0+IsOeNrfK
 w7q5q9hJoRyNlff9QazGrIdw==
X-Received: by 2002:a17:902:da4b:b0:240:3c62:6194 with SMTP id
 d9443c01a7336-249448e484amr236122775ad.20.1756955212014; 
 Wed, 03 Sep 2025 20:06:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEukbo0iFpQ3hdudcg04w1a4rKyCjhJggPfFjmI4wAxtvHHcUiI2KMfvnMiL9hT06ibtqXer7Lz8D0fOmW5DXI=
X-Received: by 2002:a17:902:da4b:b0:240:3c62:6194 with SMTP id
 d9443c01a7336-249448e484amr236122485ad.20.1756955211535; Wed, 03 Sep 2025
 20:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <aLVzVyaVhr4IHkyd@yuki.lan>
 <f014f48a-294c-4205-b147-e20074a8da48@suse.com>
 <aLgxmUJ7e05X1seP@yuki.lan> <aLhAj_-gzjmzvOoX@yuki.lan>
 <CAEemH2dzju5n1FZ8TyG0=YBJY-A80VD7Sv1PLJZuj_AYNERYvg@mail.gmail.com>
In-Reply-To: <CAEemH2dzju5n1FZ8TyG0=YBJY-A80VD7Sv1PLJZuj_AYNERYvg@mail.gmail.com>
Date: Thu, 4 Sep 2025 11:06:39 +0800
X-Gm-Features: Ac12FXzQXhqPVALR02WviR1GTeXcQKjm6RXoCaJsX4NUDvzm-390zXAGmCofO14
Message-ID: <CAEemH2dPTgYX3LZ4Ux6YUZ3vuddNsOSoGw=eN-dD=-qOodkLzg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CuTufFQhLy4SqmKu1ILP76P7g5d6XHOae02Fn09zfNM_1756955212
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP Release preparations
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

T24gVGh1LCBTZXAgNCwgMjAyNSBhdCAxMDozOeKAr0FNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gSGkgQ3lyaWwsIEFuZHJlYSwKPgo+IE9uIFdlZCwgU2VwIDMsIDIwMjUg
YXQgOToyMOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKPgo+PiBI
aSEKPj4gPiA+IEFmdGVyIGFuIGFuYWx5c2lzIHdlIGFyZSBub3cgc3VyZSB0aGF0IGl0J3Mgbm90
IGEgcHJvZHVjdCBidWcgYnV0IGEKPj4gdGVzdAo+PiA+ID4gaXNzdWUuIFRoZXJlIG1pZ2h0IGJl
IGEgbmVlZCB0byBmYWxsYmFjayB0aGUgcGF0Y2ggaWYgd2UgY2FuJ3QgZml4Cj4+IHRoZQo+PiA+
ID4gdGVzdCBiZWZvcmUgcmVsZWFzZS4gQExpIFdEWVQ/Cj4KPiA+Cj4+ID4gVHJ5IHRoaXM6Cj4+
ID4KPj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL3JlYWx0aW1lL2Z1bmMvc2NoZWRfZm9vdGJh
bGwvc2NoZWRfZm9vdGJhbGwuYwo+PiBiL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3NjaGVkX2Zv
b3RiYWxsL3NjaGVkX2Zvb3RiYWxsLmMKPj4gPiBpbmRleCAwNjE3YmRiODcuLjBkNjQyMTBiMCAx
MDA2NDQKPj4gPiAtLS0gYS90ZXN0Y2FzZXMvcmVhbHRpbWUvZnVuYy9zY2hlZF9mb290YmFsbC9z
Y2hlZF9mb290YmFsbC5jCj4+ID4gKysrIGIvdGVzdGNhc2VzL3JlYWx0aW1lL2Z1bmMvc2NoZWRf
Zm9vdGJhbGwvc2NoZWRfZm9vdGJhbGwuYwo+PiA+IEBAIC0xMTUsOCArMTE1LDggQEAgdm9pZCBy
ZWZlcmVlKGludCBnYW1lX2xlbmd0aCkKPj4gPiAgICAgICAgIG5vdyA9IHN0YXJ0Owo+PiA+Cj4+
ID4gICAgICAgICAvKiBTdGFydCB0aGUgZ2FtZSEgKi8KPj4gPiAtICAgICAgIHRzdF9hdG9taWNf
c3RvcmUoMCwgJnRoZV9iYWxsKTsKPj4gPiAgICAgICAgIHB0aHJlYWRfYmFycmllcl93YWl0KCZz
dGFydF9iYXJyaWVyKTsKPj4gPiArICAgICAgIHRzdF9hdG9taWNfc3RvcmUoMCwgJnRoZV9iYWxs
KTsKPj4gPiAgICAgICAgIGF0cmFjZV9tYXJrZXJfd3JpdGUoInNjaGVkX2Zvb3RiYWxsIiwgIkdh
bWVfc3RhcnRlZCEiKTsKPj4gPgo+PiA+Cj4+ID4gV2UgaGF2ZSB0byBiZSBzdXJlIHRoYXQgdGhl
IGRlZmVuc2UgaGFzIHN0YXJ0ZWQgYmVmb3JlIHdlIGNsZWFyIHRoZQo+PiA+IGJhbGwuIFByZXZp
b3VzbHkgd2UgaGFkIHRoZSBsb29wIHRoYXQgd2FpdGVkIGZvciB0aGUgcGxheWVycyB0byBiZSBy
ZWFkeQo+PiA+IGJlZm9yZSB3ZSBjYWxsZWQgcmVmZXJlZSgpIGZ1bmN0aW9uIHNvIGFsbCB0aGUg
cGxheWVycyB3ZXJlIHJlYWR5IHdoZW4KPj4gPiB3ZSBjbGVhcmVkIGl0Lgo+Pgo+PiBVZmYgYW5k
IHdlIGhhdmUgdG8gZ2V0IHRoZSBmaW5hbCBiYWxsIHBvc2l0aW9uIGJlZm9yZSB3ZSBzdG9wIHRo
ZQo+PiB0aHJlYWRzIGFzIHdlbGwsIG90aGVyd2lzZSB0aGVyZSBpcyBhbHdheXMgY2hhbmNlLCB0
aGF0IHdlIG1heSBlbmQgdXAKPj4gbW92aW5nIHRoZSBiYWxsIHJpZ2h0IGFmdGVyIHRoZSBoaWdo
IHByaW9yaXR5IGRlZmVuY2UgdGhyZWFkcyBoYXMgYmVlbgo+PiBzdG9wcGVkOgo+Pgo+Cj4gVGhp
cyBtYWtlcyBzZW5zZSEgSG93ZXZlciwgZnJvbSBteSBleHRlbnNpdmUgdGVzdGluZywgSSBzdGls
bCBzZWUKPiBvY2Nhc2lvbmFsIGZhaWxzIG9uIEtWTS9EZWJ1ZyBwbGF0Zm9ybXMuCj4KPiBJIHN1
c3BlY3QgdGhlIGV4aXN0aW5nIGJhcnJpZXJzIGVuc3VyZSBhbGwgdGhyZWFkcyBhcmUgY3JlYXRl
ZCBiZWZvcmUKPiB0aGUgZ2FtZSBzdGFydHMsIGJ1dCBzbWFsbCBzY2hlZHVsZXIgc2tld3MgY2Fu
IHN0aWxsIGFsbG93IHRoZSBhdHRhY2tpbmcKPiB0aHJlYWQgdG8gcnVuIGZvciBhIGZldyBjeWNs
ZXMgYmVmb3JlIHRoZSBkZWZlbmRpbmcgdGhyZWFkIG1pZ3JhdGVzLAo+IGVzcGVjaWFsbHkgb24g
ZGVidWcvUlQga2VybmVscy4KPgoKU29ycnkgdHlwbywgUlQgLS0+IG5vbi1SVCBrZXJuZWxzLgoK
U2luY2UgcmVndWxhciBrZXJuZWxzIHVzZSB0aGUgQ0ZTIHNjaGVkdWxlciwgd2hpY2ggaXMgbW9y
ZSBsaWtlbHkgdG8KaGF2ZSBzdWNoIGRldmlhdGlvbnMsIEkgdGhvdWdodCBpdCB3b3VsZCBiZSBi
ZXR0ZXIgdG8gcnVuIHRoaXMgdGVzdCB1c2luZwp0aGUgUlQga2VybmVsLgoKQWZ0ZXIgbG9va2lu
ZyB5b3VyIHRlc3Qgam9iLCBpdCBhcHBlYXJzIHRoYXQgNi4xNi4zLTEtZGVmYXVsdCBpcyBhIHN0
b2NrCmtlcm5lbCwKc28gSSdtIG5vdCBzdXJwcmlzZWQgYnkgdGhlIGZhaWx1cmUuCgotLSAKUmVn
YXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
