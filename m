Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DC8C27C79
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 08:05:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 902B23D0E00
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 10:05:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 184BE3CE037
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 10:05:34 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 582981BB8751
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 10:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718870731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ioCqA71m3A4KKI8Rqm/VXWGesJd809nUiXLzFzb46Q=;
 b=Aml9CR++XAcyesTnCE+DuaGmwB3UuGmUZwU6A6FsGBVG9gUUTUDKEqaPTvLQsJ5oyNOSUp
 +3rpjLHC0UvSTTTTLMhCPgEkJ/9yAxM2pUcpSvfH+LE6i86ZCn9qbSZnlp0mgDIe+UEnJC
 jvB4/+oCB4ilvtR+NGqKxXTt4LULbkw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-drkOGGxDMnKCemLbXOuoSQ-1; Thu, 20 Jun 2024 04:05:26 -0400
X-MC-Unique: drkOGGxDMnKCemLbXOuoSQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c7c3401dfdso725306a91.1
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 01:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718870725; x=1719475525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ioCqA71m3A4KKI8Rqm/VXWGesJd809nUiXLzFzb46Q=;
 b=vo36dDM4rLgv/sIR9H2NAywQFOLBGZgopyXRuHUvSCPS9aLY/eWgGj1TY1uzTy9Cqt
 xZKCUpjcyy8Pw/jsxvIa7TaYLkOUhUOQ8/68t5epsrIHpUr2b37CIg0D4pRohjTzbs4H
 gcOy/E70TRsqLrc4lkc463O5vjZWPZdvMEm9NllA3B2uO25Q580I0k3S5u1BvEgquK7s
 VTOOWsvJGaYrkoEO3w2bsy8ZBzV9XlXkB/433Ox1E9glgvPnITux8Yjj121T3oAWzEJl
 LJVlAcWo4036ZlefmgEaRWs83YjvCevDdvaqwM6WFbTi2TltarH9HCJ6/UKxDK4LtA4t
 c1NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBGoiWInvKIeFToz8OmsmpZ/rTEQlj8l0FQ+XonC2Sr09/zcmAsaNt+MMhPgNW+LUOsA49h/WuCFyHopLtRF5Qur8=
X-Gm-Message-State: AOJu0YytSkmjYVABMub+UfBjc7XGWKvHvMRDoH6kfxtKxFF4Yw32aNok
 KoDdr8lEbWkGbQX7YYzCApxuPsYvmGuOg6h5c0i/XoeD+4IiUX2alH+5M/N+l+ALMmtvn/pURXy
 ytcUp2up8SSW7Jy3+g9tNgLTrT8O5vc4/IyiUHxNaW72BlceaAkm+iEKoWPBAtGGBVTDk02GYtw
 dCES3XHEcewzD//Y+wy3EFOFY=
X-Received: by 2002:a17:90b:30c5:b0:2c2:d442:aa10 with SMTP id
 98e67ed59e1d1-2c7b5d936f3mr4168265a91.45.1718870725550; 
 Thu, 20 Jun 2024 01:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhPy2yaQ5MCSdvRpRxMlSh05XtCeBNFTdwNXLtedWlQI+fhLwAWL4vdemIEmhd8YOjnVOEtgoSJzrJBW8f23Y=
X-Received: by 2002:a17:90b:30c5:b0:2c2:d442:aa10 with SMTP id
 98e67ed59e1d1-2c7b5d936f3mr4168248a91.45.1718870725180; Thu, 20 Jun 2024
 01:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240527222947.374475-1-pvorel@suse.cz>
 <37603272-8ea2-4828-96df-4b6381cc26ad@suse.com>
 <ZldFa-3CXXbVKmVW@yuki> <20240620053618.GD537887@pevik>
In-Reply-To: <20240620053618.GD537887@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Jun 2024 16:05:13 +0800
Message-ID: <CAEemH2cnB0QAAz1CqZPdRWm5R8GP4sqqA9mw-owHkL1ASXTkMQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/2] lib: Add TINFO_WARN
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

SGkgUGV0ciwgQWxsLAoKT24gVGh1LCBKdW4gMjAsIDIwMjQgYXQgMTozNuKAr1BNIFBldHIgVm9y
ZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPiBIaSEKPiA+ID4gSSdtIG5vdCBzdXJlIGFi
b3V0IHRoaXMuIFdoeSBub3QgZW5hYmxpbmcgVElORk8gKyBUV0FSTiBjb21iaW5hdGlvbgo+IGlu
c3RlYWQ/Cj4KPiA+ID4gdHN0X3JlcyhUSU5GTyB8IFRXQVJOLCAibXkgbWVzc2FnZSIpOwo+Cj4g
PiBUaGF0J3MgZXZlbiBtb3JlIGNvbmZ1c2luZy4gRG9lcyB0aGF0IHByb3BhZ2F0ZSBpbnRvIHJl
c3VsdHMgb3Igbm90Pwo+Cj4gPiBUbyBiZSBob25lc3Qgd2UgZXZlbiBoYXZlIHByb2JsZW0gZGVj
aWRpbmcgaWYgd2Ugc2hvdWxkIHVzZSBUSU5GTyBvcgo+ID4gVFdBUk4gaW4gc29tZSBjYXNlcyBh
bmQgYWRkaW5nIHRoaXJkIHZhcmlhbnQgd291bGQgbWFrZSB0aGluZ3MgZXZlbgo+ID4gd29yc2Us
IHNpY25lIHdlIHdvdWxkIGhhdmUgdGhyZWUgb3B0aW9ucy4KPgo+ID4gU28gSSB3b3VsZCByZWFs
bHkga2VlcCBqdXN0IFRJTkZPIHdoaWNoIGlzIHNvbWV0aGluZyB0aGF0IGlzIHByaW50ZWQgYnkK
PiA+IGRlZmF1bHQgYnV0IGRvZXMgbm90IHByb3BhZ2F0ZSBpbnRvIHJlc3VsdHMgYW5kIFRXQVJO
IHRoYXQgaXMgcHJpbnRlZCBhcwo+ID4gd2VsbCBidXQgcHJvcGFnYXRlcyBpbnRvIHJlc3VsdHMu
Cj4KPiA+IE1heWJlIGl0IHdvdWxkIGJlIGV2ZW4gYmV0dGVyIHRvIGFjdHVhbGx5IHJlbW92ZSBU
V0FSTi4gVGhhdCB3YXkgd2UKPiA+IHdvdWxkIGhhdmUgb25seSBURkFJTCBhbmQgVEJST0sgdGhh
dCBwcm9wYWdhdGUgaW50byByZXN1bHRzIHNpbmNlIFRXQVJOCj4gPiBpcyBraW5kIG9mIGxlc3Nl
ciBUQlJPSyBhbnl3YXlzLi4uCj4KPiBVbmRlcnN0YW5kIHRvIHlvdXIgcG9pbnRzLiBCdXQgdHN0
X3JlcyBUV0FSTiBpcyBxdWl0ZSB1bmRlcnN0YW5kYWJsZQo+IChzaW1wbGUgd2FybmluZywgd2hp
Y2ggcHJvcGFnYXRlcyksIElNSE8gYmV0dGVyIHRvIHVzZSB0aGFuCj4gdHN0X3JlcyBUQlJPSy4g
QnV0IHN1cmUsIGZlZWwgZnJlZSB0byBnbyBhaGVhZCBhbmQgc2VuZCBhIHBhdGNoIHRvIHJlbW92
ZQo+IFRXQVJOLgo+CgorMSB0byByZW1vdmUgVFdBUk4uCgoKPiBCVFcgSSB3YXMgYWxzbyBzdXJw
cmlzZWQgaG93IG1hbnkgdGVzdHMgdXNlIHRzdF9yZXNtIFRCUk9LIC4uLiAvCj4gdHN0X3Jlc20o
VEJST0ssCj4gLi4uKSBmb2xsb3dlZCBieSBleGl0IDEgLyBleGl0KDEpLiBUaGVzZSBzaG91bGQg
YmUgY29udmVydGVkIHRvIHRzdF9icmttCj4gVEJST0sgLwo+IHRzdF9yZXNtKFRCUk9LLCAuLi4p
Lgo+Cj4gT3RoZXIgdGhpbmcgaXMsIHRoYXQgSSB3b3VsZCBwcmVmZXIgdG8gaGF2ZSBtYWNybyBm
b3IgdHN0X3JlcyhUSU5GTywKPiAiV0FSTklORzogLi4uIikKPiBlLmcuIFdBUk5JTkcoLi4uKSB3
b3VsZCBwcm9kdWNlIHRzdF9yZXMoVElORk8sICJXQVJOSU5HOiAuLi4iKSBmcm9tIHNpbXBsZQo+
IHBvaW50IEkKPiBkb24ndCBsaWtlIHRvIGhhcmR3aXJlIHRleHQgKHRoZXJlIGNhbiBiZSB0eXBv
cykuIEJUVyBtb3JlIHRoYW4gZm9yIHRoaXMKPiByYXJlCj4gY2FzZSBJIHdvdWxkIHByZWZlciB0
byBoYXZlIG1hY3JvcyBmb3IgLnRhZ3MsIGUuZy4gTElOVVhfR0lUKDQzYTY2ODQ1MTlhYikKPiB3
b3VsZAo+IHByb2R1Y2UgeyJsaW51eC1naXQiLCAiNDNhNjY4NDUxOWFiIn0gQ1ZFKDIwMTctMjY3
MSkgd291bGQgcHJvZHVjZSB7IkNWRSIsCj4gIjIwMTctMjY3MSJ9Cj4gKGFnYWluLCB0eXBvcyku
Cj4KCldoYXQgYWJvdXQgZGVmaW5pbmcgbmV3IExUUCBtYWNyb3MgbGlrZQogIFRTVF9SRVNfVElO
Rk8oKSwKICBUU1RfUkVTX1RGQUlMKCksCiAgLi4uCiAgVFNUX1JFU19XQVJOSU5HKCksCnNvIHRo
YXQgd2UgY2FuIHNhdmUgdGltZSBvbiBpbnB1dHRpbmcgdGhlIFRGQUlML1RJTkZPIGtleXdvcmRz
IGV2ZXJ5IHRpbWXvvJ8KCmFsc28gVFNUX0xJTlVYX0dJVCgpLCBUU1RfQ1ZFKCkgPwoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
