Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBF8C77B7F
	for <ltp@archiver.kernel.org>; Sat, 20 May 2023 03:59:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A4A43CDC0C
	for <ltp@archiver.kernel.org>; Sat, 20 May 2023 05:59:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA23B3CBAB1
 for <ltp@lists.linux.it>; Sat, 20 May 2023 05:58:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 519651000417
 for <ltp@lists.linux.it>; Sat, 20 May 2023 05:58:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684555132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FcdWfk7j0CnMm+mhmuPc9zi2fdrDJqKAbAUuDuYzhV8=;
 b=VbzJEMZgNU1q8FMIFBIIoQLkuU7hR6TGc/T9FaHLoXBVhoxgAyqE8Vq6MTfeMmRq9vNbay
 X8FDH+77EC90rCIEYXhvm7W9d3SPT4B+e5a+K77DsWEJTj+0tlENoQFu/QFUMJgG7Hztn0
 Qdz6ViGJDl7wEjXC/Q5tRenazxspTtE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-j7fqXC2nNx-w-uehVIle5w-1; Fri, 19 May 2023 23:58:48 -0400
X-MC-Unique: j7fqXC2nNx-w-uehVIle5w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af2f0b7331so100221fa.3
 for <ltp@lists.linux.it>; Fri, 19 May 2023 20:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684555127; x=1687147127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FcdWfk7j0CnMm+mhmuPc9zi2fdrDJqKAbAUuDuYzhV8=;
 b=Tywa/R0fdynH+Qcj8kwQohBNjQ+oH7bzJEyXMhFxqqxnbmJ6W+5DPXcTiiFQbOAXxv
 zuVKMhgRD0TUyEIIepsdxQTmyf9ljFB0GzCUWrHg1dny5++ErSz6LP+SVzD2lp6r2K5j
 0mxcMWSqTLOwKR+GzRfmkkWoCXM2xAoA7HHmPPeTJVXFXXbc2UsVzEYWE8PkdsLwkTF8
 SE6URabLbappE9B9AlcrCfV8ThGMG+KODrrNq7TcA1UUIa7wyrD/Ox0+1X1TE5qZ84gh
 C4WlB3VDmQQNjkCkG1kcFrRnUwhPuPpG25Ztza8DQFcmB1yYIueu3gv/3v9OP2jqK/8+
 p5HA==
X-Gm-Message-State: AC+VfDwQoJ04HVxCEkdPeNaPdUq26YPD2YSg7WCzTDJSbd3O/tT3xkPX
 BwyCNSLZAozwnMXhcH2SUj731qJI7rRYhS3e+iQwQisOCGs5H1zlO2o/9lAUsbH0zwG7JuR2kwN
 QiKD386E/39sjhZn4AG3fIBs2q50=
X-Received: by 2002:a05:651c:10d:b0:2af:1681:2993 with SMTP id
 a13-20020a05651c010d00b002af16812993mr1371316ljb.49.1684555127407; 
 Fri, 19 May 2023 20:58:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wK/SfL7I7gkMLQNSaP3c5ie5pnS0ZE59djpyK182wVmJvnFhLOs/9otrLxJD79MRSJo/cS6icS8YdMeRClyo=
X-Received: by 2002:a05:651c:10d:b0:2af:1681:2993 with SMTP id
 a13-20020a05651c010d00b002af16812993mr1371310ljb.49.1684555127041; Fri, 19
 May 2023 20:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuKehraq_kcHdVgqWnwQWHN2QiE7ze53mXJvtL0DLc0uQ@mail.gmail.com>
 <9677ced3-8386-47f0-a2d6-de27ec84207e@app.fastmail.com>
 <b3b0d222-b745-07bc-8dcd-38f762343c84@colorfullife.com>
In-Reply-To: <b3b0d222-b745-07bc-8dcd-38f762343c84@colorfullife.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 20 May 2023 11:58:35 +0800
Message-ID: <CAEemH2cKjmef+R=gF94J3VT8Kg0inQaWu93dybvPsJM+OM1fQA@mail.gmail.com>
To: Manfred Spraul <manfred@colorfullife.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP: shmget02 fails on compat mode - 64-bit kernel and
 32-bit userspace
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Davidlohr Bueso <dbueso@suse.de>, open list <linux-kernel@vger.kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, lkft-triage@lists.linaro.org,
 Ard Biesheuvel <ardb@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWFuZnJlZCwKCk9uIFNhdCwgTWF5IDIwLCAyMDIzIGF0IDE6NTXigK9BTSBNYW5mcmVkIFNw
cmF1bCA8bWFuZnJlZEBjb2xvcmZ1bGxpZmUuY29tPgp3cm90ZToKCj4gSGkgYWxsLAo+Cj4gT24g
NS8xOS8yMyAxMjo1NywgQXJuZCBCZXJnbWFubiB3cm90ZToKPiA+IE9uIEZyaSwgTWF5IDE5LCAy
MDIzLCBhdCAxMToxNywgTmFyZXNoIEthbWJvanUgd3JvdGU6Cj4gPj4gTFRQIHJ1bm5pbmcgb24g
Y29tcGF0IG1vZGUgd2hlcmUgdGhlIHRlc3RzIHJ1biBvbgo+ID4+IDY0LWJpdCBrZXJuZWwgYW5k
IDMyLWJpdCB1c2Vyc3BhY2UgYXJlIG5vdGljZWQgb24gYSBsaXN0IG9mIGZhaWx1cmVzLgo+ID4+
Cj4gPj4gV2hhdCB3b3VsZCBiZSB0aGUgYmVzdCB3YXkgdG8gaGFuZGxlIHRoaXMgcmFyZSBjb21i
aW5hdGlvbiBvZiBmYWlsdXJlcyA/Cj4gPj4KPiA+PiAqIGFybTY0OiBqdW5vLXIyLWNvbXBhdCwg
cWVtdV9hcm02NC1jb21wYXQgYW5kIHFlbXVfeDg2XzY0LWNvbXBhdAo+ID4+ICAgICAgLSBzaG1n
ZXQwMgo+ID4+Cj4gPj4gUmVwb3J0ZWQtYnk6IExpbnV4IEtlcm5lbCBGdW5jdGlvbmFsIFRlc3Rp
bmcgPGxrZnRAbGluYXJvLm9yZz4KPiA+Pgo+ID4+IHRzdF9odWdlcGFnZS5jOjgzOiBUSU5GTzog
MCBodWdlcGFnZShzKSByZXNlcnZlZAo+ID4+IHRzdF90ZXN0LmM6MTU1ODogVElORk86IFRpbWVv
dXQgcGVyIHJ1biBpcyAwaCAwMm0gMzBzCj4gPj4gdHN0X2tjb25maWcuYzo4NzogVElORk86IFBh
cnNpbmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwo+ID4+IHNobWdldDAyLmM6OTU6
IFRQQVNTOiBzaG1nZXQoMTY0NDE5OTgyNiwgMjA0OCwgMTAyNCkgOiBFTk9FTlQgKDIpCj4gPj4g
c2htZ2V0MDIuYzo5NTogVFBBU1M6IHNobWdldCgxNjI3NDIyNjEwLCAyMDQ4LCAxNTM2KSA6IEVF
WElTVCAoMTcpCj4gPj4gPDQ+WyAgIDg0LjY3ODE1MF0gX192bV9lbm91Z2hfbWVtb3J5OiBwaWQ6
IDUxMywgY29tbTogc2htZ2V0MDIsIG5vdAo+ID4+IGVub3VnaCBtZW1vcnkgZm9yIHRoZSBhbGxv
Y2F0aW9uCj4gPj4gc2htZ2V0MDIuYzo5NTogVFBBU1M6IHNobWdldCgxNjQ0MTk5ODI2LCAwLCAx
NTM2KSA6IEVJTlZBTCAoMjIpCj4gPj4gc2htZ2V0MDIuYzo5NTogVEZBSUw6IHNobWdldCgxNjQ0
MTk5ODI2LCA0Mjc4MTkwMDgwLCAxNTM2KSBleHBlY3RlZAo+ID4+IEVJTlZBTDogRU5PTUVNICgx
MikKPiA+IEFkZGluZyBMaWFtIEhvd2xldHQsIERhdmlkbG9ociBCdWVzbyBhbmQgTWFuZnJlZCBT
cHJhdWwgdG8gQ2MsIHRoZXkKPiA+IGhhdmUgd29ya2VkIG9uIHRoZSBzaG0gY29kZSBpbiB0aGUg
cGFzdCBmZXcgeWVhcnMuCj4gPgo+ID4gVGhpcyBpcyB0aGUgbGluZQo+ID4KPiA+ICAgICAgIHsm
c2hta2V5MSwgU0hNTUFYICsgMSwgSVBDX0NSRUFUIHwgSVBDX0VYQ0wsIDAsIDAsIEVJTlZBTH0s
Cj4gPgo+ID4gZnJvbQo+ID4KPiA+Cj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJv
amVjdC9sdHAvYmxvYi8wNGU4ZjJmNGZkOTQ5L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBj
L3NobWdldC9zaG1nZXQwMi5jI0xMNTlDMS1MNTlDNjEKPiA+Cj4gPiByaWdodD8KPiA+Cj4gPiBJ
IHRoaW5rIHRoaXMgaXMgYSByZXN1bHQgb2YgU0hNTUFYIGJlaW5nIGRlZmluZWQgYXMKPiA+ICNk
ZWZpbmUgU0hNTUFYIChVTE9OR19NQVggLSAoMVVMIDw8IDI0KSksIHNvIHRoZSBrZXJuZWwgd291
bGQKPiA+IGxpa2VseSB1c2UgYSBsYXJnZSA2NC1iaXQgdmFsdWUgaGVyZSwgd2hpbGUgdGhlIDMy
LWJpdCB1c2VyCj4gPiBzcGFjZSB1c2VzIGEgbXVjaCBzbWFsbGVyIGxpbWl0Lgo+ID4KPiA+IFRo
ZSBleHBlY3RlZCByZXR1cm4gY29kZSBsaWtlbHkgY29tZXMgZnJvbQo+ID4KPiA+IHN0YXRpYyBp
bnQgbmV3c2VnKHN0cnVjdCBpcGNfbmFtZXNwYWNlICpucywgc3RydWN0IGlwY19wYXJhbXMgKnBh
cmFtcykKPiA+IHsKPiA+IC4uLgo+ID4gICAgICAgICAgaWYgKHNpemUgPCBTSE1NSU4gfHwgc2l6
ZSA+IG5zLT5zaG1fY3RsbWF4KQo+ID4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsK
PiA+Cj4gPiBidXQgaWYgbnMtPnNobV9jdGxtYXggaXMgcHJvYmFibHkgc2V0IHRvIHRoZSA2NC1i
aXQgdmFsdWUgaGVyZS4KPiA+IEl0IHdvdWxkIHRoZW4gdHJpZ2dlciB0aGUgYWNjb3VudGluZyBs
aW1pdCBpbiBfX3NobWVtX2ZpbGVfc2V0dXAoKToKPiA+Cj4gPiAgICAgICAgICBpZiAoc2htZW1f
YWNjdF9zaXplKGZsYWdzLCBzaXplKSkKPiA+ICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9Q
VFIoLUVOT01FTSk7Cj4gPgo+ID4gTXkgZmVlbGluZyBpcyB0aGF0IHRoZSBrZXJuZWwgaW4gdGhp
cyBjYXNlIHdvcmtzIGFzIGV4cGVjdGVkLAo+ID4gYW5kIEkgd291bGRuJ3Qgc2VlIHRoaXMgYXMg
YSBidWcuIE9uIHRoZSBvdGhlciBoYW5kLCB0aGlzCj4gPiBjYW4gcHJvYmFibHkgYmUgYWRkcmVz
c2VkIGluIHRoZSBrZXJuZWwgYnkgYWRkaW5nIGEgY2hlY2sgZm9yCj4gPiBjb21wYXQgdGFza3Mg
bGlrZQo+ID4KPiA+IC0tLSBhL2lwYy9zaG0uYwo+ID4gKysrIGIvaXBjL3NobS5jCj4gPiBAQCAt
NzE0LDcgKzcxNCw4IEBAIHN0YXRpYyBpbnQgbmV3c2VnKHN0cnVjdCBpcGNfbmFtZXNwYWNlICpu
cywgc3RydWN0Cj4gaXBjX3BhcmFtcyAqcGFyYW1zKQo+ID4gICAgICAgICAgY2hhciBuYW1lWzEz
XTsKPiA+ICAgICAgICAgIHZtX2ZsYWdzX3QgYWNjdGZsYWcgPSAwOwo+ID4KPiA+IC0gICAgICAg
aWYgKHNpemUgPCBTSE1NSU4gfHwgc2l6ZSA+IG5zLT5zaG1fY3RsbWF4KQo+ID4gKyAgICAgICBp
ZiAoc2l6ZSA8IFNITU1JTiB8fCBzaXplID4gbnMtPnNobV9jdGxtYXggfHwKPiA+ICsgICAgICAg
ICAgaW5fY29tcGF0X3N5c2NhbGwoKSAmJiBzaXplID4gQ09NUEFUX1NITU1BWCkpCj4gPiAgICAg
ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4KPiA+ICAgICAgICAgIGlmIChudW1wYWdl
cyA8PCBQQUdFX1NISUZUIDwgc2l6ZSkKPiA+Cj4gSSB3b3VsZCBjb25zaWRlciB0aGlzIGFzIHVn
bHk6IG5zLT5zaG1fY3RsbWF4IGNhbiBiZSBjb25maWd1cmVkIGJ5Cj4gd3JpdGluZyB0byAvcHJv
Yy9zeXMva2VybmVsL3NobW1heC4KPgo+IFlvdSBjYW4gYnJlYWsgdGhlIHRlc3QgY2FzZSBvbiA2
NC1iaXQgYXMgd2VsbCwganVzdCBieSB3cml0aW5nIFNITU1BWCsxCj4gdG8gL3Byb2Mvc3lzL2tl
cm5lbC9zaG1tYXgKPgo+IFRodXMgSSB0aGluayB0aGUgdGVzdCBjYXNlIGlzIGZsYXdlZDoKPgo+
IEl0IGlzIHRlc3RpbmcgdGhlIG92ZXJmbG93IGJlaGF2aW9yIGZvciBhIGNvbmZpZ3VyYWJsZSB2
YWx1ZSBieSB0ZXN0aW5nCj4gd2l0aCBkZWZhdWx0KzEuIEJ1dCBzb21ldGltZXMgdGhlIGFjdHVh
bCB2YWx1ZSBpcyBub3QgdGhlIGRlZmF1bHQuCj4KPiBBcmUgdGhlIHRlc3RzIHJ1bm5pbmcgYXMg
cm9vdD8KPgoKWWVzLgoKCgo+Cj4gV2hhdCBhYm91dCBpbnRlbnRpb25hbGx5IHNldHRpbmcgdGhl
IHZhbHVlIHRvIHNvbWV0aGluZyB1c2VmdWw/Cj4KCgpUaGlzIHN1Z2dlc3Qgc291bmRzIHJlYXNv
bmFibGUsIGJ1dCBJIGhhdmUgYSBxdWVzdGlvbjoKaXMgdGhlcmUgYW55IHVwcGVyIGxpbWl0IGZv
ciBzZXR0aW5nIHRoZSAvcHJvYy9zeXMva2VybmVsL3NobW1heD8KClRoZSB0ZXN0IHNlZW1zIHRv
IHRyeSB0byB0ZXN0IHRoZSBib3VuZGVyIGFuZCBhcyBhCmNvcm5lciBjYXNlIGZvciBjb3Zlcmlu
ZyB0aGF0IHNjZW5hcmlvLgoKCgo+Cj4gdG1wPSQoY2F0IC9wcm9jL3N5cy9rZXJuZWwvc2htbWF4
KQo+Cj4gZWNobyAiMTIzNCIgPiAvcHJvYy9zeXMva2VybmVsL3NobW1heAo+Cj4gc2VtZ2V0KCkg
YmFzZWQgb24geyZzaG1rZXkxLCAxMjM0ICsgMSwgSVBDX0NSRUFUIHwgSVBDX0VYQ0wsIDAsIDAs
IEVJTlZBTH0sCj4gZWNobyAkdG1wID4vcHJvYy9zeXMva2VybmVsL3NobW1heAo+Cj4gT3IsIGFs
dGVybmF0aXZlbHk6IHJlYWQgL3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXgsIGFuZCBza2lwIHRoZSB0
ZXN0IGlmCj4gdGhlIHZhbHVlIGlzIGxhcmdlciB0aGFuIFVMT05HX01BWC0xLgo+Cj4gLS0KPiAg
ICAgICAgIE1hbmZyZWQKPgo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
