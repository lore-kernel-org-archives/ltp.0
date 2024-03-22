Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121B0C47DD9
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 05:26:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73C673C0316
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 06:26:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CBAF3D0B00
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 06:26:36 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8348214004E1
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 06:26:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711085192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dm8rGubDhAwR854HE6jy75S0OIHkEXDN6wvMDXvWJyc=;
 b=c3N8LyQdZbCgBIs+uUm1aKiZDv06N9FNgTFSM/ZfWHAo+PfvZX8aF8DwqW1f+rINXBImKl
 8KXjyfWkQHv4n0DHt5YiiGIrcrFDinmohlXphl5pY8Equen5yHTw4kvWf85eG+nSb21hoD
 u4J6/gdYupN+m1njGCTTmyexfkdXnck=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-n0GASLtzM4qk-O4dElbOlw-1; Fri, 22 Mar 2024 01:26:25 -0400
X-MC-Unique: n0GASLtzM4qk-O4dElbOlw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29bf071cc04so1316826a91.0
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 22:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711085183; x=1711689983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dm8rGubDhAwR854HE6jy75S0OIHkEXDN6wvMDXvWJyc=;
 b=AUL3+vo6/IqDj7mz17ivAGF7iRgnrQfKFYacKsJ5SarTCmXYyrXv3n5Fa2yZikwk/w
 56b+/0Y7tjLizrJ/N3oRtrxIIh7yX7IZlX2XvSVLRrt2a3g2iHzA+2cOXDOi0LVpTG4F
 IrwG9d/3KLVpmat+3dnlvNhtWYfvzkixSoUYJ60R0lauLgjypU843A2Eh5BnxijGp9aE
 NbeW+KyNYr9XTo/ISlwD3O4lQcZZPEu91BdedBcgsf4sJUgosd8SQnDixoDRo5SLYBIg
 siDJ2hGePBjV11/DLfw9eJ5D/qWG64bu3JRUUvaRLhT6FBRd1IrhTVYbe5W1bcQBurgE
 gGhg==
X-Gm-Message-State: AOJu0Ywr/hJ91hA4cIeHat6ReoSh+dUPPWY//PLtoWzR54Ojn1ckNXnj
 31e9XgXDpviKyV3xxTZDKQuAIdIlnIrLbspcsEGSE6YkAeOThOR71XAYzJS5Qxi1pOBHZmUxFc3
 wnVbhNwCEXkeYJQj59gL1xS5bC+eC3YD2+X/+LtNwaYowPptPUpvLPnUG7HHwVidRlV5WzC2CTx
 rFQgE2le+Vn35R4PED0oasP0Q2zgPTybNY6U2D
X-Received: by 2002:a17:90a:fe8f:b0:29b:307a:d5ed with SMTP id
 co15-20020a17090afe8f00b0029b307ad5edmr1405392pjb.10.1711085183730; 
 Thu, 21 Mar 2024 22:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgNwpIwrLNUxM/mZ+1R5PtonUFEvOCaCHeHzrIPpjm9Gu7hqeppVUtuxXIez1m24DLSd4m0uRMjACt9a+OHN0=
X-Received: by 2002:a17:90a:fe8f:b0:29b:307a:d5ed with SMTP id
 co15-20020a17090afe8f00b0029b307ad5edmr1405388pjb.10.1711085183387; Thu, 21
 Mar 2024 22:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240322030208.3278120-1-liwang@redhat.com>
 <20240322050046.GA572447@pevik>
In-Reply-To: <20240322050046.GA572447@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 22 Mar 2024 13:26:11 +0800
Message-ID: <CAEemH2c3SNktFnPpsnbXvtTvfEv84byRrNmjcz3YyQHem9mcGg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/2] libswap: add two methods to create swapfile
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

T24gRnJpLCBNYXIgMjIsIDIwMjQgYXQgMTowMOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiAuLi4KPiA+IFNpZ25lZC1vZmYtYnk6IExpIFdhbmcg
PGxpd2FuZ0ByZWRoYXQuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3Vz
ZS5jb20+Cj4gPiAtLS0KPiAuLi4KPiAtaW50IG1ha2Vfc3dhcGZpbGUoY29uc3QgY2hhciAqc3dh
cGZpbGUsIGludCBibG9ja3MsIGludCBzYWZlKQo+ICtpbnQgbWFrZV9zd2FwZmlsZV8oY29uc3Qg
Y2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiArICAgICAgICAgICAgICAgICAgICAgICBj
b25zdCBjaGFyICpzd2FwZmlsZSwgdW5zaWduZWQgaW50IG51bSwKPiArICAgICAgICAgICAgICAg
ICAgICAgICBpbnQgc2FmZSwgZW51bSBzd2FwZmlsZV9tZXRob2QgbWV0aG9kKQo+ICB7Cj4gICAg
ICAgICBzdHJ1Y3Qgc3RhdHZmcyBmc19pbmZvOwo+IC0gICAgICAgdW5zaWduZWQgbG9uZyBibGtf
c2l6ZSwgYnM7Cj4gKyAgICAgICB1bnNpZ25lZCBsb25nIGJsa19zaXplOwo+ICsgICAgICAgdW5z
aWduZWQgaW50IGJsb2NrcyA9IDA7Cj4gICAgICAgICBzaXplX3QgcGdfc2l6ZSA9IHN5c2NvbmYo
X1NDX1BBR0VTSVpFKTsKPiAtICAgICAgIGNoYXIgbW50X3BhdGhbMTAwXTsKPiArICAgICAgIGNo
YXIgbW50X3BhdGhbMTI4XTsKPgo+IG5pdDogd2h5IHRoaXMgaW5jcmVhc2UgdG8gMTI4PyBXaHkg
bm90IFBBVEhfTUFYPwo+CgoKTm8gc3BlY2lhbCBtZWFuaW5nLCBJIGp1c3QgdGhvdWdodCBvZiB1
c2luZyAyIHJhaXNlZCB0byB0aGUgbnRoIHBvd2VyLgpCdXQgeW91J3JlIHJpZ2h0LCBQQVRDSF9N
QVggd2lsbCBiZSBzYWZlci4KCgoKPgo+ID4gICAgICAgLyogVG8gZ3VhcmFudGVlIGF0IGxlYXN0
IG9uZSBwYWdlIGNhbiBiZSBzd2FwcGVkIG91dCAqLwo+ID4gLSAgICAgaWYgKGJsa19zaXplICog
YmxvY2tzIDwgcGdfc2l6ZSkKPiA+IC0gICAgICAgICAgICAgYnMgPSBwZ19zaXplOwo+ID4gLSAg
ICAgZWxzZQo+ID4gLSAgICAgICAgICAgICBicyA9IGJsa19zaXplOwo+ID4gKyAgICAgaWYgKGJs
a19zaXplICogYmxvY2tzIDwgcGdfc2l6ZSkgewo+ID4gKyAgICAgICAgICAgICB0c3RfcmVzKFRX
QVJOLCAiU3dhcGZpbGUgc2l6ZSBpcyBsZXNzIHRoYW4gdGhlIHN5c3RlbSBwYWdlCj4gc2l6ZS4g
XAo+ID4gKyAgICAgICAgICAgICAgICAgICAgIFVzaW5nIHBhZ2Ugc2l6ZSAoJWx1IGJ5dGVzKSBp
bnN0ZWFkIG9mIGJsb2NrIHNpemUKPiAoJWx1IGJ5dGVzKS4iLAo+Cj4gbGlic3dhcC5jOjE2Mzog
V0FSTklORzogQXZvaWQgbGluZSBjb250aW51YXRpb25zIGluIHF1b3RlZCBzdHJpbmdzCj4KPiBU
aGlzIHdpbGwgZml4IGl0Ogo+Cj4gICAgICAgICAgICAgICAgIHRzdF9yZXMoVFdBUk4sICJTd2Fw
ZmlsZSBzaXplIGlzIGxlc3MgdGhhbiB0aGUgc3lzdGVtIHBhZ2UKPiBzaXplLiAiCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgIlVzaW5nIHBhZ2Ugc2l6ZSAoJWx1IGJ5dGVzKSBpbnN0ZWFkIG9m
IGJsb2NrIHNpemUKPiAoJWx1IGJ5dGVzKS4iLAo+CgorMQoKCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgKHVuc2lnbmVkIGxvbmcpcGdfc2l6ZSwgYmxrX3NpemUpOwo+ID4gKyAgICAgICAgICAg
ICBibGtfc2l6ZSA9IHBnX3NpemU7Cj4gPiArICAgICB9Cj4KPiA+ICAgICAgIGlmIChzc2NhbmYo
c3dhcGZpbGUsICIlW14vXSIsIG1udF9wYXRoKSAhPSAxKQo+ID4gLSAgICAgICAgICAgICB0c3Rf
YnJrKFRCUk9LLCAic3NjYW5mIGZhaWxlZCIpOwo+ID4gKyAgICAgICAgICAgICB0c3RfYnJrXyhm
aWxlLCBsaW5lbm8sIFRCUk9LLCAic3NjYW5mIGZhaWxlZCIpOwo+Cj4gPiAtICAgICBpZiAoIXRz
dF9mc19oYXNfZnJlZShtbnRfcGF0aCwgYnMgKiBibG9ja3MsIFRTVF9CWVRFUykpCj4gPiAtICAg
ICAgICAgICAgIHRzdF9icmsoVENPTkYsICJJbnN1ZmZpY2llbnQgZGlzayBzcGFjZSB0byBjcmVh
dGUgc3dhcAo+IGZpbGUiKTsKPiA+ICsgICAgIGlmICghdHN0X2ZzX2hhc19mcmVlKG1udF9wYXRo
LCBibGtfc2l6ZSAqIGJsb2NrcywgVFNUX0JZVEVTKSkKPiA+ICsgICAgICAgICAgICAgdHN0X2Jy
a18oZmlsZSwgbGluZW5vLCBUQ09ORiwgIkluc3VmZmljaWVudCBkaXNrIHNwYWNlIHRvCj4gY3Jl
YXRlIHN3YXAgZmlsZSIpOwo+Cj4gPiAgICAgICAvKiBjcmVhdGUgZmlsZSAqLwo+ID4gLSAgICAg
aWYgKHByZWFsbG9jX2NvbnRpZ3VvdXNfZmlsZShzd2FwZmlsZSwgYnMsIGJsb2NrcykgIT0gMCkK
PiA+IC0gICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgIkZhaWxlZCB0byBjcmVhdGUgc3dhcGZp
bGUiKTsKPiA+ICsgICAgIGlmIChwcmVhbGxvY19jb250aWd1b3VzX2ZpbGUoc3dhcGZpbGUsIGJs
a19zaXplLCBibG9ja3MpICE9IDApCj4gPiArICAgICAgICAgICAgIHRzdF9icmtfKGZpbGUsIGxp
bmVubywgVEJST0ssICJGYWlsZWQgdG8gY3JlYXRlIHN3YXBmaWxlIik7Cj4KPiA+ICAgICAgIC8q
IEZpbGwgdGhlIGZpbGUgaWYgbmVlZGVkIChzcGVjaWZpYyB0byBvbGQgeGZzIGZpbGVzeXN0ZW1z
KSAqLwo+ID4gICAgICAgaWYgKHRzdF9mc190eXBlKHN3YXBmaWxlKSA9PSBUU1RfWEZTX01BR0lD
KSB7Cj4gPiAtICAgICAgICAgICAgIGlmICh0c3RfZmlsbF9maWxlKHN3YXBmaWxlLCAwLCBicywg
YmxvY2tzKSAhPSAwKQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0ssICJG
YWlsZWQgdG8gZmlsbCBzd2FwZmlsZSIpOwo+ID4gKyAgICAgICAgICAgICBpZiAodHN0X2ZpbGxf
ZmlsZShzd2FwZmlsZSwgMCwgYmxrX3NpemUsIGJsb2NrcykgIT0gMCkKPiA+ICsgICAgICAgICAg
ICAgICAgICAgICB0c3RfYnJrXyhmaWxlLCBsaW5lbm8sIFRCUk9LLCAiRmFpbGVkIHRvIGZpbGwK
PiBzd2FwZmlsZSIpOwo+ID4gICAgICAgfQo+Cj4gPiAgICAgICAvKiBtYWtlIHRoZSBmaWxlIHN3
YXBmaWxlICovCj4gPiAtICAgICBjb25zdCBjaGFyICphcmd2WzIgKyAxXTsKPiA+IC0KPiA+IC0g
ICAgIGFyZ3ZbMF0gPSAibWtzd2FwIjsKPiA+IC0gICAgIGFyZ3ZbMV0gPSBzd2FwZmlsZTsKPiA+
IC0gICAgIGFyZ3ZbMl0gPSBOVUxMOwo+ID4gKyAgICAgY29uc3QgY2hhciAqYXJndltdID0geyJt
a3N3YXAiLCBzd2FwZmlsZSwgTlVMTH07Cj4KPiBsaWJzd2FwLmM6MTg2OiBXQVJOSU5HOiBjaGFy
ICogYXJyYXkgZGVjbGFyYXRpb24gbWlnaHQgYmUgYmV0dGVyIGFzIHN0YXRpYwo+IGNvbnN0Cj4K
PiBUaGlzIHdpbGwgZml4IGl0Ogo+Cj4gICAgICAgICBjb25zdCBjaGFyICpjb25zdCBhcmd2W10g
PSB7Im1rc3dhcCIsIHN3YXBmaWxlLCBOVUxMfTsKPgoKKzEKCgo+ID4gICAgICAgcmV0dXJuIHRz
dF9jbWQoYXJndiwgIi9kZXYvbnVsbCIsICIvZGV2L251bGwiLCBzYWZlID8KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFRTVF9DTURfUEFTU19SRVRWQUwgfAo+IFRTVF9DTURf
VENPTkZfT05fTUlTU0lORyA6IDApOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIFRTVF9DTURf
UEFTU19SRVRWQUwgfCBUU1RfQ01EX1RDT05GX09OX01JU1NJTkcgOgo+IDApOwo+Cj4gVGhlIHJl
c3QgTEdUTS4KPgoKClRoYW5rcywgSSB3b3VsZCBnaXZlIHRoZSBwYXRjaCBzZXQgbW9yZSB0aW1l
IGluIGNhc2Ugb3RoZXJzIGhhdmUgY29tbWVudHMuCgoKCj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9y
ZWwgPHB2b3JlbEBzdXNlLmN6Pgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+CgotLSAKUmVn
YXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
