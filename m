Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5FFC54E58
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 05:57:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B043F3CE745
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 06:57:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C40343CDE24
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 06:57:03 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BFF3D600A0F
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 06:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710482221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzHnXBzUd3ZMLr+8CofSY1FFoN31/Lxy5mVqUkmVDhM=;
 b=euvdv4Bq69tYOyVSMvhprZ1Q9XcXOowI96fjJNuUeg1B1ZSSbOmB52B5GeDBU704MuS/B1
 Iy/CuBlqKnOewbRjGtG9i8LFyz72RMvl/Jj3bX/XgoiLXDyns5G2bCJPsV95eomQkJoEcZ
 8xRlEekJRn43/Rtf6dP3nyQ0OV9wrZM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-C2AjG0dYMtWh2PUO8ymVSw-1; Fri, 15 Mar 2024 01:56:57 -0400
X-MC-Unique: C2AjG0dYMtWh2PUO8ymVSw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29bad31f920so1653707a91.0
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 22:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710482216; x=1711087016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lzHnXBzUd3ZMLr+8CofSY1FFoN31/Lxy5mVqUkmVDhM=;
 b=qBfFPNLQ0clzYytYrKKtF6AF3EaOfYhKqeRzA30gUU2kxobFLSIX8yJpbfVsnSQsRG
 vGEFvIEq1S5RbZStd9CBNS+Kz6XMMvS1fh2sZTArMrKV4y0xi980miV/jkPvRsrgHaqE
 +E4GmYoAez2NAGlAEyUAfVkFBCEV7Mfp+P8a+MBbrtI9eVXVYJSjh5EQDVN5R1U51CIP
 tyDY+PLC5OGqovFMRswflQWZnZtUsoB455oc1XUCE+mK8USJwg4DclDwhzqL6edETc2/
 iKO+ItW1GZDF4EOeC2PcyJdijca6+nfOro4gw+KbQXpiKcjJfwu0vwmDqQQ3VXeKDUVG
 ok/g==
X-Gm-Message-State: AOJu0Ywe1MH6A1qqbI0glVwophZzYQr9Cmu5kxxRK05m4Hz883aUi1Ax
 8bjJ9Y/55T2vnCWXxx0oNMrcgtB24XlVl0QgtNAXh1qJsQuKIBw6XYDgz70I+OixcVqrtpgxpum
 pm3v2+Nn+Q5vZ5govF02DqZRlxzPsMSlMD5+7E1hBZXMb9L9R4qyIj0POEL44gGmknPo+SJvbBI
 U+9ca9GYAHp0ay/YchUYBnX3w=
X-Received: by 2002:a17:90b:1196:b0:29b:aa4e:3b74 with SMTP id
 gk22-20020a17090b119600b0029baa4e3b74mr1905161pjb.17.1710482216158; 
 Thu, 14 Mar 2024 22:56:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExZNl/dMROS7bKKdCDG/+LZ6cCq6H8m5NyRUosH23+1BhURpPquq1IQcuvmWBXSoxdus67ZW4D824h3hKrbF8=
X-Received: by 2002:a17:90b:1196:b0:29b:aa4e:3b74 with SMTP id
 gk22-20020a17090b119600b0029baa4e3b74mr1905151pjb.17.1710482215858; Thu, 14
 Mar 2024 22:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240314013320.5536-1-wegao@suse.com>
 <CAEemH2dn7zRijqq-ZmxsS7CSh2__dzVzpP9ZsPh3APmYWvu=mg@mail.gmail.com>
 <ZfOkrcg5Kt9l59Ss@wegao.68.199.193>
 <CAEemH2dgxRPG1xRQRFdyFPjr+awKL33Fp5xgdMAA=3=t-K19VQ@mail.gmail.com>
 <ZfPEHJNRH16jRQAU@wegao.185.0.200>
 <CAEemH2erkkB5Mj_WiGjErK-Z5Dc7bY_2D7Lu-nBpsqyFeo=8sA@mail.gmail.com>
 <CAEemH2cmfS3US4ZCTeK2gGjHLm7LFgF+y9gwjcDEfEDfkRZykQ@mail.gmail.com>
 <ZfPbkYq5uvwW1kSk@wegao.14.93.120>
In-Reply-To: <ZfPbkYq5uvwW1kSk@wegao.14.93.120>
From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Mar 2024 13:56:43 +0800
Message-ID: <CAEemH2cTzLuJ1uTBNbUB-E7kJPeHjx3sPi1crkqTCJ6h4DgSbg@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

T24gRnJpLCBNYXIgMTUsIDIwMjQgYXQgMToyNOKAr1BNIFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29t
PiB3cm90ZToKCgo+ID4gPj4gSG93IHRvIGRpc2FibGUgT09NIGFuZCBhbHNvIGxldCBzd2FwIGFj
dGlvbiBoYXBwZW4gYXQgdGhlIHNhbWUgdGltZQo+IGZvcgo+ID4gPj4gY2dyb3VwIFYyPwo+ID4g
Pj4KPiA+ID4KPiA+ID4gVGhlIENncm91cCB2MiBkb2VzIG5vdCBwcm92aWRlIGEgd2F5IHRvIGRp
c2FibGUgT09NIGluc2lkZSBkaXJlY3RseS4KPiA+ID4KPiA+ID4gSWYgd2Ugd2FudCB0byBhdm9p
ZCBPT00gaGFwcGVuaW5nLCBqdXN0IGhhdmUgdG8gbWFuYWdlIE9PTSBiZWhhdmlvcgo+ID4gPiBp
biBjZ3JvdXAgdjIgYnkgc2V0dGluZyBhcHByb3ByaWF0ZSB2YWx1ZXMgZm9yICdtZW1vcnkubWF4
JywKPiAnbWVtb3J5LmhpZ2gnLAo+ID4gPiBhbmQgdXNpbmcgJ21lbW9yeS5vb20uZ3JvdXAnIHRv
IGRldGVybWluZSB3aGV0aGVyIHRoZSBPT00ga2lsbGVyIHNob3VsZAo+ID4gPiB0YXJnZXQgaW5k
aXZpZHVhbCBwcm9jZXNzZXMgb3IgdGhlIHdob2xlIENncm91cC4KPiA+ID4KPiA+ID4gQWZ0ZXIg
bG9va2luZyBiYWNrIGF0IHRoaXMgY2FzZSBhZ2FpbiwgSSBndWVzcyB0aGUgbWFpbiByZWFzb24g
aXMgdGhhdAo+IHRoZQo+ID4gPiBzd2FwZmlsZSBpcyB0b28gc21hbGwgdG8gYmVhciB0aGUgbWVt
b3J5IGxvYWQsIG9uZSBkaXJlY3QgbWV0aG9kIGlzCj4gbGlrZQo+ID4gPiB5b3UgdG8gZW5sYXJn
ZSB0aGUgJ21lbW9yeS5tYXgnIHZhbHVlLCBidXQgdGhhdCBzdGlsbCBkb2VzIG5vdCByZXNvbHZl
Cj4gPiA+IHByb2JsZW1zIGV2ZW50dWFsbHkuCj4gPiA+Cj4gPiA+IE9uZSBwb3NzaWJsZSBzb2x1
dGlvbiBpcyBjcmF0ZSBhIGJpdCBsYXJnZXIgc3dhcGZpbGUgZm9yIHRoZSB0ZXN0LCBhbmQKPiA+
ID4gdW5saW1pdGVkCj4gPiA+IHRoZSBzd2FwIG91dCBzaXplLiBDYW4geW91IHRyeSB0aGlzIHBh
dGNoIG9uIHlvdXIgc3lzdGVtPwo+IFRoaXMgbm90IHdvcmsuCj4KCkludGVyZXN0aW5nLCBob3cg
YWJvdXQgcmVzaXppbmcgdGhlIHN3YXBmaWxlIHNpemUgdG8gbGFyZ2VyPwpjYW4geW91IHRyeSB0
aGF0LgoKCgo+ID4gPgo+ID4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBv
bi9zd2Fwb24wMS5jCj4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9u
L3N3YXBvbjAxLmMKPiA+ID4gQEAgLTM4LDEwICszOCwxNCBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlf
c3dhcG9uKHZvaWQpCj4gPiA+ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4gPiAgewo+ID4g
PiAgICAgICAgIGlzX3N3YXBfc3VwcG9ydGVkKFNXQVBfRklMRSk7Cj4gPiA+IC0gICAgICAgbWFr
ZV9zd2FwZmlsZShTV0FQX0ZJTEUsIDEwLCAwKTsKPiA+ID4gKyAgICAgICBtYWtlX3N3YXBmaWxl
KFNXQVBfRklMRSwgMTAyNCwgMCk7Cj4gPiA+Cj4gPiA+ICAgICAgICAgU0FGRV9DR19QUklOVEYo
dHN0X2NnLCAiY2dyb3VwLnByb2NzIiwgIiVkIiwgZ2V0cGlkKCkpOwo+ID4gPiAgICAgICAgIFNB
RkVfQ0dfUFJJTlRGKHRzdF9jZywgIm1lbW9yeS5tYXgiLCAiJWx1IiwgVEVTVE1FTSk7Cj4gPiA+
ICsgICAgICAgaWYgKFRTVF9DR19WRVJfSVNfVjEodHN0X2NnLCAibWVtb3J5IikpCj4gPiA+ICsg
ICAgICAgICAgICAgICBTQUZFX0NHX1BSSU5URih0c3RfY2csICJtZW1vcnkuc3dhcC5tYXgiLCAi
JWx1IiwgfjBVTCk7Cj4gPiA+ICsgICAgICAgZWxzZQo+ID4gPiArICAgICAgICAgICAgICAgU0FG
RV9DR19QUklOVCh0c3RfY2csICJtZW1vcnkuc3dhcC5tYXgiLCAibWF4Iik7Cj4gPiA+ICB9Cj4g
PiA+Cj4gPiA+ICBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gPiA+Cj4gPgo+ID4g
SWYgdGhpcyBzdGlsbCBkb2VzIG5vdCB3b3JrIGFzIGV4cGVjdGVkLCB0aGVuIHdlIG5lZWQgcGx1
cyBhZGRpdGlvbmFsCj4gPiBwb2xpY3kgdG8gc2hyaW5rIHRoZSBwb2xsdXRlIG1lbW9yeSBzaXpl
Lgo+ID4KPiA+IC0gICAgICAgdHN0X3BvbGx1dGVfbWVtb3J5KFRFU1RNRU0sIDB4NDEpOwo+ID4g
KyAgICAgICB0c3RfcG9sbHV0ZV9tZW1vcnkoVEVTVE1FTSAqIDkvMTAsIDB4NDEpOwo+IFRoaXMg
d29ya3MuCj4KCkNhbiB5b3UgcG9zdCBtb3JlIGluZm8gYWJvdXQgdGhlIHRlc3Qgb3V0cHV0PwoK
T25lIGNvbmNlcm4gSSBoYXZlIGlzIHRoYXQgdGhlIHN3YXAgaXMgbm90IGJlaW5nIHRyaWdnZXJl
ZAp3aXRoIHNocmlua2luZyB0aGUgcG9sbHV0ZSBtZW1vcnkuCgpBbmQgYWxzbyBpdCdkIGJlIGdy
ZWF0IHRvIGhhdmUgYGZyZWUgLWhgIGBjYXQgL3Byb2MvbWVtaW5mb2AgYGxzY3B1YCBgdW5hbWUK
LXJgIGluZm8uCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
