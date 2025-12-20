Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB73E668AF
	for <ltp@archiver.kernel.org>; Sat, 20 Dec 2025 04:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766204897; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dxZG/YWI7L4k67oHx5g6P6fWE47dWS2lMZAX8Dqf3Tk=;
 b=Sh4oF/a+0yV9DU0dCgz6Npq7A0wDnIAnULqsfnlKT4ybj9/8BA3XNlAlvxIijAAzW0gvm
 dEnN+OjjJiSMOnZUdEMCFpNIy2KFcrMOYQf4hyHjBJ5GgaBgHW5DIRGwGK4T7tRxCZto7iL
 NzohditaaOcnZdhQzGeNZXw3cGnq6Pc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68E533D0569
	for <ltp@archiver.kernel.org>; Sat, 20 Dec 2025 05:28:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A34F43CF07E
 for <ltp@lists.linux.it>; Sat, 20 Dec 2025 05:27:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1B79B10006D2
 for <ltp@lists.linux.it>; Sat, 20 Dec 2025 05:27:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766204867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JUAYtRuSZRSkY/FWT/TUfeOQxGHLer/DZtmY241CRI=;
 b=A1TldKbrhRPMAcoIG2xfB679MvajLqwPKEFIHIxy7vblCFW3vaBGqBoD6dbFj/+m7bjhX8
 CXaKqhyfUa8SXZJLqbu8z+Qcm7JWkQw/6x0qUgdLjHA1X68PwEXNPQs1me2SAlVfHdvkqY
 hoSRSb9SrpoOeNfUpVQC2sFrQMdo2Rk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-WqIW8fHSMQa_4WgR0Mg89w-1; Fri, 19 Dec 2025 23:27:45 -0500
X-MC-Unique: WqIW8fHSMQa_4WgR0Mg89w-1
X-Mimecast-MFC-AGG-ID: WqIW8fHSMQa_4WgR0Mg89w_1766204864
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b79e98a23c5so179280266b.3
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 20:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766204861; x=1766809661;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JUAYtRuSZRSkY/FWT/TUfeOQxGHLer/DZtmY241CRI=;
 b=uYe15fhVhVDYZl9FWz52VWglST7UbQhTdlmHOBhBrP2HosMwawEYT4DZq2awomW5Ib
 MCQdK40BXAxdfuOTcbK/uOnJYpKbaKPnuIjCmBF1Eg0njSZfDWlULztcqCEXggkJHRwI
 n2MAsknR1/BMGNSnX+Em9YGDwahZ+snxn11Bjp9u2bDi44KMi7QE2IdB9g3se5q8FaZl
 KrGnbr+m6gF2nKVDLXqn8FqKfl9uMw+oyUqEGDfR9KXCurlqjmzv451LOCtMDv8zoSyy
 30pH4OuAuoMYARRcosjv4zzfvbvcikoCBf+4gVFxRVplIF5vyrvKomz/cBrZrl6hTTLW
 olVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2cssJSQZdvCk5kL7eNutKSCloIRIhsAF3uUKB0pzyC+7KZ9Om6A8gQVaOh5eJrUF4pmQ=@lists.linux.it
X-Gm-Message-State: AOJu0YwwgjMP5kmbSK4XSd09wtnGh14cYdJwYJPgAWzhKiN0Af6XFoww
 Gh3VmlGEZ8crLnn/Wn3BOn7WGWgr1TcMgiG10XtWfF41Ig/khdSSv6wPyQxnz4uZbJRBA14D3fk
 3GMnXXdmrUfyRIOxBoaYJ7GUINx5aPQNVEOHXOTBumugo6lQ7PA1eV8qRekoOnDLIlSC1TLPIJi
 pgi+/dVFucGlLDnN6XcEtV3qR429OgqVfIdrrlIg==
X-Gm-Gg: AY/fxX5dTWD36BELuLFztFIVusTLmWQoNn4MVXmwlcD5Fg+K87rWZfpB7KDpCJSNcDQ
 /B0ZjhY5IR4v4K7kBginTVA2Jmz7dY1tQlt/FJXoDT7zqbToiXwhjkl0+Qg7N0EkNos/HASUfO6
 zWtKObLKo3iPcypLAK6KsKIsLCGhY6glPeA33fcmJK0FFb6P7r7+Earr8Ym6M5SvHZrUo=
X-Received: by 2002:a17:907:970a:b0:b79:e887:e1b3 with SMTP id
 a640c23a62f3a-b803727bec3mr551215466b.57.1766204861163; 
 Fri, 19 Dec 2025 20:27:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZpvg+Z0IqwebHLHaE/++ev7WpyTMajmmD6Ti39KdqzeMuUIaC7QhzmPBVR2kMqRYoTFfamFMgYWLVusE+er0=
X-Received: by 2002:a17:907:970a:b0:b79:e887:e1b3 with SMTP id
 a640c23a62f3a-b803727bec3mr551214466b.57.1766204860765; Fri, 19 Dec 2025
 20:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20251219094219.151887-1-pvorel@suse.cz>
 <aUUteQjVmMx1R_X9@yuki.lan>
 <20251219140216.GA247368@pevik> <20251219144102.GA325483@pevik>
In-Reply-To: <20251219144102.GA325483@pevik>
Date: Sat, 20 Dec 2025 12:27:25 +0800
X-Gm-Features: AQt7F2p7R5_PSKRB4f3FK7M6_bJbQWbkLD9yxYtk70D67BTfNEhvov7HjEMrLfA
Message-ID: <CAEemH2f2nhCBzxw-5u5qGnDS9BcogD-KWOd+mrOoLvmJ0XPR9w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: edPP-tx_d64vHu8J5RXe1_3T2HVkDUTje3x_--I_ixk_1766204864
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 1/1] swapon03: Try to swapon() as many files
 until it fails
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

T24gRnJpLCBEZWMgMTksIDIwMjUgYXQgMTA6NDjigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+ID4gWyBSZW1vdmluZyBNaWNoYWwgdG8gbm90IGJvdGhlciBoaW0gd2l0
aCBMVFAgaW50ZXJuYWxzIF0KPgo+ID4gPiBIaSEKPiA+ID4gPiAgIHRzdF9yZXMoVElORk8sICJT
dWNjZXNzZnVsbHkgY3JlYXRlZCAlZCBzd2FwIGZpbGVzIiwgc3dhcGZpbGVzKTsKPiA+ID4gPiAt
IE1BS0VfU01BTExfU1dBUEZJTEUoVEVTVF9GSUxFKTsKPgo+ID4gPiBUaGlzIHNob3VsZCBzdGF5
IGhlcmUsIHJpZ2h0PyBJIHN1cHBvc2UgdGhhdCB0aGUgdGVzdCB3b3JrcyBldmVuIHdoZW4KPiB3
ZQo+ID4gPiBwYXNzIG5vbi1leGlzdGluZyBmaWxlIGluIHRoZSB2ZXJpZnlfc3dhcG9uKCkgYnV0
IHdlIHNob3VsZG4ndCBiZXQgb24KPiA+ID4gdGhhdC4KPgo+ID4gRllJIHN3YXAgZmlsZSBpcyBj
cmVhdGVkIGJ5IGlzX3N3YXBfc3VwcG9ydGVkKFRFU1RfRklMRSkuIEJ1dCBzdXJlLCBJIGNhbgo+
ID4gYWxzbyBrZWVwIE1BS0VfU01BTExfU1dBUEZJTEUoVEVTVF9GSUxFKSB0byBtYWtlIHN1cmUg
ZmlsZSBpcyBhbHNvCj4gY3JlYXRlZC4KPiA+IFdlIHRhbGtlZCBhYm91dCByZWxhdGVkIGNsZWFu
dXAsIHdoaWNoIEkgd2FudGVkIHRvIHBvc3Rwb25lLCBidXQgc2hvdWxkIEkKPiA+IHJlZmFjdG9y
IGlzX3N3YXBfc3VwcG9ydGVkKCkgdG8gbm90IGluY2x1ZGUgc3dhcG9uKCkgY2FsbC4gQmVjYXVz
ZSB3aGVuCj4gdGhlcmUKPiA+IGFyZSB0b28gbWFueSBzd2FwIGZpbGVzIGFscmVhZHkgbW91bnRl
ZCwgdGVzdHMgaXMgc2tpcHBlZCB3aXRoOgo+Cj4gPiBsaWJzd2FwLmM6MjI0OiBUQ09ORjogUGVy
bWlzc2lvbiBkZW5pZWQgZm9yIHN3YXBvbigpCj4gPiBkdWUgRVBFUk0sIHdoaWNoIGlzIGFjdHVh
bGx5IHN1YmplY3Qgb2YgdGVzdGluZyBmb3Igc3dhcG9uMDMuYwo+Cj4gQW5kLCBhcyBJIHBvc3Rl
ZCBpbiB2MyBbMV0sIHdlIGNhbiBhdm9pZCB0aGlzIHdvcmssIGlmIHdlIHJlcXVpcmUgYXQgbGVh
c3QKPiBzaW5nbGUgc3dhcCBjcmVhdGVkIGJ5IHRoZSB0ZXN0LiBPciwgYWxsb3cgYSBjb3JuZXIg
Y2FzZSBhbGwgc3dhcHMgYXJlCj4gdXNlZCwKPiBidXQganVzdCB2ZXJpZnkgdGhhdCBieSBjb3Vu
dGluZyBzd2FwIGluIC9wcm9jL3N3YXBzLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+IFsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNTEyMTkxNDI1MTIuR0MyNDczNjhAcGV2
aWsvCj4KPiA+IEknbSBub3Qgc3VyZSBhYm91dCBuYW1pbmcuIE1heWJlIGhhdmUgaXNfc3dhcF9z
dXBwb3J0ZWQoKSB3aXRob3V0Cj4gc3dhcG9uKCkgY2FsbAo+ID4gKGZvciBzd2Fwb24wMy5jKSBh
bmQgY3JlYXRlIG5ldyBmdW5jdGlvbiBpc19zd2Fwb25fc3VwcG9ydGVkKCksIHdoaWNoCj4gd291
bGQgY2FsbAo+ID4gaXNfc3dhcF9zdXBwb3J0ZWQoKSArIHN3YXBvbigpIGFuZCBzd2Fwb2ZmKCkg
KGZvciBhbGwgb3RoZXIgdGVzdHMpLgo+CgpJIHRoaW5rIHlvdXIgaWRlYSBpcyBjb3JyZWN0LCBj
dXJyZW50IGlzX3N3YXBfc3VwcG9ydGVkKCkgYXBwZWFycyB0byBjb250YWluCnR3byBkaWZmZXJl
bnQgcXVlc3Rpb25zOgoxLiBEb2VzIHRoZSBrZXJuZWwvZmlsZXN5c3RlbSBzdXBwb3J0IHN3YXAg
ZmlsZXMgYXQgYWxsIC8gY2FuIHdlIGNyZWF0ZSBhCnN3YXBmaWxlPwoyLiBDYW4gd2Ugc3VjY2Vz
c2Z1bGx5IHN3YXBvbigpIGEgc3dhcGZpbGUgcmlnaHQgbm93PwoKRm9yIG1vc3QgdGVzdHMsICgy
KSBpcyBhIHJlYXNvbmFibGUgcHJlcmVxdWlzaXRlOyBmb3Igc3dhcG9uMDMgaXQgaXMgbm90LApi
ZWNhdXNlCnRoZSB0ZXN0IGlzIHNwZWNpZmljYWxseSBhYm91dCBzd2Fwb24oKSBmYWlsaW5nIHdp
dGggRVBFUk0gd2hlbiB5b3UgaGl0IHRoZQpzd2FwZmlsZSBsaW1pdC4KClRvIHN1bW1hcml6ZSB0
aGUgZGlzY3Vzc2lvbiwgdGhlIGFwcHJvYWNoIG1pZ2h0IGJlOgoKaXNfc3dhcF9zdXBwb3J0ZWQo
KToKICAtIHN3YXAgc3lzY2FsbHMgcHJlc2VudCAoL3Byb2Mvc3dhcHMgZXhpc3RzKQogIC0gZmls
ZXN5c3RlbSBhbGxvd3MgY3JlYXRpbmcgZmlsZXMgKGhhcyBlbm91Z2ggc3BhY2UpCiAgLSBjYW4g
bWtzd2FwIChvciB3aGF0ZXZlciBNQUtFX1NNQUxMX1NXQVBGSUxFIGRvZXMpIHN1Y2Nlc3NmdWxs
eQogIC0gcG9zc2libHkgc2FuaXR5LWNoZWNrIHRoYXQgc3dhcGZpbGVzIGFyZSBzdXBwb3J0ZWQg
b24gdGhpcyBGUwoKaXNfc3dhcG9uX3N1cHBvcnRlZCgpOgogIC0gY2FsbCBpc19zd2FwX3N1cHBv
cnRlZCgpCiAgLSBjcmVhdGUgYSB0ZW1wb3Jhcnkgc3dhcGZpbGUKICAtIHN3YXBvbigpIC8gc3dh
cG9mZigpIGl0CiAgLSBjbGVhbiB1cAoKT2YgY291cnNlLCB0aGUgcmVmYWN0b3Igd29yayBjYW4g
YmUgYWNoaWV2ZWQgaW4gc2VwYXJhdGUgcGF0Y2ggc2V0LgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
