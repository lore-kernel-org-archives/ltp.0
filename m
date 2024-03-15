Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17024C54E60
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 03:17:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2DA83D0A3C
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 04:17:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0828B3CAEC7
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 04:17:20 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 21B136007A3
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 04:17:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710472638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N613njHNbW+9u9XX1kF/cCEQe9uDzM2hdCKO5kWECmw=;
 b=dxY2ZuA4T3ZGWdBNO93y7YoK0EGGPnFVZOBbRa05BdUO6HpibztFhC7xwwfs4ztEWSRr9K
 wm3ljyJTGYsPkMqUcEF+x2rEiK9zWkmaTA5TJgGp75T3Beq5hAVWZrkabuMAVPIEuofHhR
 pV7LZPgRZzOBEIQi+MGiGE+Bk/1359E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-uYmLJUoPM7CANDICmneKdQ-1; Thu, 14 Mar 2024 23:17:15 -0400
X-MC-Unique: uYmLJUoPM7CANDICmneKdQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-299c5a61099so1394439a91.0
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 20:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710472634; x=1711077434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N613njHNbW+9u9XX1kF/cCEQe9uDzM2hdCKO5kWECmw=;
 b=mF6tIw1gBIGZ9kQE2OyJTCh8iXa+epJ+VNWOeSD7CdxvjMm2h2ceQE1pKBZ596BZq2
 pMNgKcZ+BFxFO+ISKq69vbE3APdNaf3DG+ze/nEgw63tLzj9KDuE2Bm2bogVJzpfNiaB
 /lxukF/dIJIlNXlHVcAFnhkii9VgW2yt/aFwYAORFN4EmayJhBG0U7KQ9EqJo2401lav
 BZCoRwIi5lARApb2v+sO2hC8BA95i0JyHe14poCJ44yYqR2Zs3B2HtVUeg2FhHmsrXuj
 iE/Eghbabk1SRwVkf8+ocNXrvXpJXgXQwNkG4SUcPUhxLh4+1+rNGfEzDEgYEJdH/XNV
 whQg==
X-Gm-Message-State: AOJu0YzCbdqgnFnpn/Wr5oFAtEJ6l8xTWVu0NhvdM0VzRFVKQQ5mkoT9
 wbHmlNpXzoEnJkAyMqzWWH7JViP5cPXvKJwK1G/IEm/H12Ae5kqK5gfxw5JfAK3lXSzPwrlk+rZ
 M5tDd7hDKSe+Wwwt8cC+yg5Sfkc+Irvt2YB0fZtrlQV6GPPUbcnv99KEAz8xVgNFnQIW3bya3gf
 529nTSVt1SlMy5nx+kzrtSxP8=
X-Received: by 2002:a17:90b:218c:b0:29b:a292:6c44 with SMTP id
 ku12-20020a17090b218c00b0029ba2926c44mr3432386pjb.10.1710472634187; 
 Thu, 14 Mar 2024 20:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZROZn7jI2i9cp7Hcs7mRMZJ6Yxj+faCp4OJjaEDWuKn2TwWobzPoObvO1b6zDPga6eYZabqwrza7ZPrJT7vw=
X-Received: by 2002:a17:90b:218c:b0:29b:a292:6c44 with SMTP id
 ku12-20020a17090b218c00b0029ba2926c44mr3432370pjb.10.1710472633790; Thu, 14
 Mar 2024 20:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240314013320.5536-1-wegao@suse.com>
 <CAEemH2dn7zRijqq-ZmxsS7CSh2__dzVzpP9ZsPh3APmYWvu=mg@mail.gmail.com>
 <ZfOkrcg5Kt9l59Ss@wegao.68.199.193>
In-Reply-To: <ZfOkrcg5Kt9l59Ss@wegao.68.199.193>
From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Mar 2024 11:17:01 +0800
Message-ID: <CAEemH2dgxRPG1xRQRFdyFPjr+awKL33Fp5xgdMAA=3=t-K19VQ@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] swapon01.c: Apply a margin to avoid oom
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

T24gRnJpLCBNYXIgMTUsIDIwMjQgYXQgOTozMOKAr0FNIFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29t
PiB3cm90ZToKCj4gT24gVGh1LCBNYXIgMTQsIDIwMjQgYXQgMDI6NDA6NDBQTSArMDgwMCwgTGkg
V2FuZyB3cm90ZToKPiA+IEhpIFdlaSwKPiA+Cj4gPiBPbiBUaHUsIE1hciAxNCwgMjAyNCBhdCA5
OjMz4oCvQU0gV2VpIEdhbyB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+Cj4gd3JvdGU6Cj4g
Pgo+ID4gPiBEdXJpbmcgb3VyIHRlc3QgaSBmaW5kIGEgb29tIGVycm9yIGR1cmluZyB0ZXN0IHdo
aWNoIHRyaWdnZXJlZCBieQo+ID4gPiB0c3RfcG9sbHV0ZV9tZW1vcnkuCj4gPiA+Cj4gPiA+IGtl
cm5lbDoKPiA+ID4KPiBvb20ta2lsbDpjb25zdHJhaW50PUNPTlNUUkFJTlRfTUVNQ0csbm9kZW1h
c2s9KG51bGwpLGNwdXNldD0vLG1lbXNfYWxsb3dlZD0wLTEsb29tX21lbWNnPS9sdHAvdGVzdC05
NTUyLHRhc2tfbWVtY2c9L2x0cC90ZXN0LTk1NTIwCj4gPiA+IGtlcm5lbDogTWVtb3J5IGNncm91
cCBvdXQgb2YgbWVtb3J5OiBLaWxsZWQgcHJvY2VzcyA5NTc1IChzd2Fwb24wMSkKPiA+ID4gdG90
YWwtdm06MTA1MTQ4NGtCLCBhbm9uLXJzczoxMDQ2NTcya0IsIGZpbGUtcnNzOjEyODBrQiwgc2ht
ZW0tcnNzOjBrMAo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNl
LmNvbT4KPiA+ID4gLS0tCj4gPiA+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9z
d2Fwb24wMS5jIHwgNCArKystCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4gPiA+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ID4gPiBpbmRleCBkNDA2ZTRiZDkuLjM1Nzk5MjUyNSAx
MDA2NDQKPiA+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9u
MDEuYwo+ID4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24w
MS5jCj4gPiA+IEBAIC00MSw3ICs0MSw5IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gPiA+
ICAgICAgICAgbWFrZV9zd2FwZmlsZShTV0FQX0ZJTEUsIDEwLCAwKTsKPiA+ID4KPiA+ID4gICAg
ICAgICBTQUZFX0NHX1BSSU5URih0c3RfY2csICJjZ3JvdXAucHJvY3MiLCAiJWQiLCBnZXRwaWQo
KSk7Cj4gPiA+IC0gICAgICAgU0FGRV9DR19QUklOVEYodHN0X2NnLCAibWVtb3J5Lm1heCIsICIl
bHUiLCBURVNUTUVNKTsKPiA+ID4gKwo+ID4gPiArICAgICAgIC8qIEFwcGx5IGEgbWFyZ2luIHRv
IGF2b2lkIG9vbSBkdXJpbmcgdHN0X3BvbGx1dGVfbWVtb3J5ICovCj4gPiA+ICsgICAgICAgU0FG
RV9DR19QUklOVEYodHN0X2NnLCAibWVtb3J5Lm1heCIsICIlbHUiLCBURVNUTUVNICsKPiBURVNU
TUVNLzEwMCk7Cj4gPiA+Cj4gPgo+ID4gRXZlbiB3aXRoIGEgYml0IG9mIG1hcmdpbiBhZGRlZCB0
aGVyZSBpcyBzdGlsbCBub3QgZ3VhcmFudGVlIHRvIGF2b2lkIE9PTQo+ID4gY29tcGxldGVseS4K
PiA+Cj4gPiBBcyB0aGUgQ2dyb3VwIFYxIGFuZCBWMiB0cmFjayBtZW1vcnkgYW5kIHN3YXAgaW4g
dHdvIHdheXMsIGlmIHRoZSBtYXJnaW4KPiBpcwo+ID4gdG9vIGxhcmdlIHRoYXQgbWlnaHQgbm90
IG1ha2UgdGhlIHN3YXAgaGFwcGVuIHdoaWNoIGlzIG5vdCBvdXIKPiBleHBlY3RhdGlvbi4KPiA+
Cj4gPiBTbyBvdGhlciBtZXRob2QgSSBjYW4gdGhpbmsgb2YgaXMgdG8gZGlzYWJsZSB0aGUgT09N
IGluIENnb3VwLAo+ID4gICAgIGVjaG8gMSA+IG1lbW9yeS5vb21fY29udHJvbAo+IFRoaXMgb3B0
aW9uIG5vdCBleGlzdCBpbiBjZ3JvdXB2MiwgaXQgc2VlbXMgbm8gZGlyZWN0IG9vbSBjb250cm9s
IGZvcgo+IGNncm91cHYyCj4KCk9rLCB3aGljaCB2ZXJzaW9uIChmb3VuZCB0aGUgT09NIGlzc3Vl
KSBkaWQgeW91IHRlc3Qgb24/Ck1heWJlIGhlcmUgd2UgaGF2ZSB0byBzcGxpdCB0aGUgY29udHJv
bCB3b3JrIGludG8gdHdvIHBhcnRzIChWMSBhbmQgVjIpLgoKCgo+ID4gb3IsIHNldCBgb3ZlcmNv
bW1pdF9tZW1vcnlgIHRvIDIgdG8gcHJldmVudCB0aGUgT09NIGZyb20gb2NjdXJyaW5nLgo+ID4g
ICAgIGVjaG8gMiA+IC9wcm9jL3N5cy92bS9vdmVyY29tbWl0X21lbW9yeQo+IEkgaGF2ZSB0cmll
ZCB0aGlzIG9wdGlvbiwgb29tIHN0aWxsIGhhcHBlbi4KPgoKV2VsbCwgaXQgbG9va3MgbGlrZSBv
dmVyY29tbWl0IGNvbnRyb2xsZWQgYnkgb3ZlcmNvbW1pdF9tZW1vcnkgaXMKYWxsb3dlZCBmb3Ig
dGhlIGVudGlyZSBzeXN0ZW0sIG5vdCBqdXN0IHRoZSBDZ3JvdXAuCgoKLS0gClJlZ2FyZHMsCkxp
IFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
