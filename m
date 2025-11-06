Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49148CCFA0D
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 03:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762400836; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=JKsk+UbKuMW/za07SJNvJyZPmnzYWnAh0V+/0nQZiSQ=;
 b=dUpZhwn22HY8uBVw0Omc3S5S6s0sMaun0FlDoA6qdscHY3KudW1MW8FSJOO4b2No6QBEs
 lU5gi/DAz7q63i4VbltkgR5TSDm4j14fLk0thFjWAjoGld5Dsc+lQ5SFMD2aBpOH72Z9dCm
 tCgR1FPSdO1yWPmDM41krLf0gQmCQ6Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9057A3CEB21
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 04:47:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14BDA3CDF20
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 04:46:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 236A8600BA2
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 04:46:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762400812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5y3DkrAW/arr/oPR4v87yxpIh0zhzh+mNlqZLRioYmE=;
 b=iNN0XpWBKmkn+SWsu2dVVdPho0P7mZE0hWe9h/vqWeiRGTjpB5KuWsGQni91vMTHcFtRJB
 BQZXUGxYPVijDZYMCwHcfo8o16TNiuP1U4WlNRGxzimJOhHg12B3u1Box7wgizdip0qPlk
 RfbD1cCli0CZSdPohhG3bEuJW2IgJBE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-AfpM_fmyME27qSz-tpYzoQ-1; Wed, 05 Nov 2025 22:46:50 -0500
X-MC-Unique: AfpM_fmyME27qSz-tpYzoQ-1
X-Mimecast-MFC-AGG-ID: AfpM_fmyME27qSz-tpYzoQ_1762400809
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b95d06db747so1390080a12.1
 for <ltp@lists.linux.it>; Wed, 05 Nov 2025 19:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762400809; x=1763005609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5y3DkrAW/arr/oPR4v87yxpIh0zhzh+mNlqZLRioYmE=;
 b=TuFI0pDvoi6TZryJbAmRY9dbvFK4tss1nsEcX4m+cuJraZD0fPbYhRTBN5HuStZU+r
 PXdPRf7X1C/ODqCRXB8ddDH44k9ysY6eWjsZ75pqHjaIKOw/XRUIZEZndYIcwewy4s4r
 VnwSrQCPKYEVlExPjGlLaIiK2LLa+MyRecPdE9LoPg5wyxUqKNABnvxRq77EEFV13/5R
 0mO7ooH3ySSB2y8kok0nzLIezvBYBar91kJygf13e31nkb9r0jh0Ec3kMVavW9cXiPVR
 tK/HTQ+CMrymbyBRrco+CMjffD11ZmA/mGat1iK1pqjRGnUf/r4t1oYX5jRne7IGdUV6
 dVbQ==
X-Gm-Message-State: AOJu0YyM/aIpfVBfx1UxJuWwL93pU3YQmG5Tf6iVdWi7X7ymcCgBbD27
 GQ2fhfRoB7wWeSfLADY4OD/uA207XLYEwTgKGzVRq5tj/VnLRJmBdp7bV8bMGBXlIr8dMPq36ni
 awN8WdbXdow0Bs5hvq0Kou1knUoxftmP5gawxdY1Oux7IkMLc85NXb1Yxlr2tvEkreLPLSobC+O
 r5TIEfxm6AjsplnVonES/varSj28o=
X-Gm-Gg: ASbGncsZyJVdIly3pfOk3zzKpopLr4NyGNMTQZnDT3he4FOiJPsuXe6ooX0YWz0sUFJ
 Vxuopjv0u/2jBUrTRa9M7mAZK8I2M0EfRDwJGiohn2Q5aVH6n66OLmgRp/J8aLEevs6uYAa1W7M
 0zBYo2HL4KY4tlXPrKF+wCVJBDw4MNYeuSZBucI6juKGPHjbx7gYjoFh8h
X-Received: by 2002:a05:6a21:6d9d:b0:32d:b741:a201 with SMTP id
 adf61e73a8af0-350debe9fdfmr2087313637.20.1762400809121; 
 Wed, 05 Nov 2025 19:46:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQOhWE8SoYJrHO0Vxo4DeuwNDoUrUGjduJ0HCxKvZeX0SbCvAEz1Dg+gomqZMDGveqQ0kAkiC3cNbKY29Fkog=
X-Received: by 2002:a05:6a21:6d9d:b0:32d:b741:a201 with SMTP id
 adf61e73a8af0-350debe9fdfmr2087286637.20.1762400808762; Wed, 05 Nov 2025
 19:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20251105154716.995786-1-pvorel@suse.cz>
 <20251105154716.995786-3-pvorel@suse.cz>
In-Reply-To: <20251105154716.995786-3-pvorel@suse.cz>
Date: Thu, 6 Nov 2025 11:46:35 +0800
X-Gm-Features: AWmQ_bmvrdLlWKZnWI5cLAAIBMwAVrAMU7w9JRUKtgTVqZZrqezncu__tvF4UTg
Message-ID: <CAEemH2fogMWAawF4eqWrLhJphMMq=V8GrO2DFuGxMKEp+zqZ_A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hnZV1hs0ng0nVAj5BptIxk86jxriT_cBCI1lYNlzmvc_1762400809
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/3] swapon03: Try to swapon() as many files until
 it fails
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
Cc: Michal Hocko <mhocko@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBOb3YgNSwgMjAyNSBhdCAxMTo0OOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gUHJldmlvdXNseSB0c3RfbWF4X3N3YXBmaWxlcygpIGhhZCBmaW5lIHR1
bmluZyBmb3IgYSBzcGVjaWZpYyBrZXJuZWwKPiB2ZXJzaW9uIHdoaWNoIHdhcyBmcmFnaWxlIGR1
ZSB2YXJpb3VzIGJhY2twb3J0cyBpbiBlbnRlcnByaXNlIGtlcm5lbHMuCj4KPiBMZXQncyB0cnkg
dG8gY3JlYXRlIGFuZCB1c2UgYXMgbWFueSBzd2FwIGZpbGVzIHVudGlsIHN3YXBvbigpIGZhaWxz
Lgo+IFRoZW4gY2hlY2sgZm9yIGV4cGVjdGVkIEVQRVJNLgo+Cj4gU3VnZ2VzdGVkLWJ5OiBNaWNo
YWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24v
c3dhcG9uMDMuYyB8IDYzICsrKysrKysrKysrKystLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwg
NDAgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDMuYwo+IGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDMuYwo+IGluZGV4IGI4OWQ4NTMxODguLjAwMjdmODc0
YmUgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9u
MDMuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAzLmMK
PiBAQCAtMSwxNCArMSwxOCBAQAo+ICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vci1sYXRlcgo+ICAvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwg
MjAwOS0yMDI1Cj4gICAqIENvcHlyaWdodCAoYykgSW50ZXJuYXRpb25hbCBCdXNpbmVzcyBNYWNo
aW5lcyBDb3JwLiwgMjAwNwo+ICAgKiBDcmVhdGVkIGJ5IDxyc2FsdmV0aUBsaW51eC52bmV0Lmli
bS5jb20+Cj4gLSAqCj4gICAqLwo+Cj4gIC8qXAo+IC0gKiBUaGlzIHRlc3QgY2FzZSBjaGVja3Mg
d2hldGhlciBzd2Fwb24oMikgc3lzdGVtIGNhbGwgcmV0dXJuczoKPiArICogVGVzdCBjaGVja3Mg
d2hldGhlciA6bWFuMjpgc3dhcG9uYCBzeXN0ZW0gY2FsbCByZXR1cm5zIEVQRVJNIHdoZW4gdGhl
Cj4gbWF4aW11bQo+ICsgKiBudW1iZXIgb2Ygc3dhcCBmaWxlcyBhcmUgYWxyZWFkeSBpbiB1c2Uu
Cj4gICAqCj4gLSAqICAtIEVQRVJNIHdoZW4gdGhlcmUgYXJlIG1vcmUgdGhhbiBNQVhfU1dBUEZJ
TEVTIGFscmVhZHkgaW4gdXNlLgo+ICsgKiBOT1RFOiB0ZXN0IGRvZXMgbm90IHRyeSB0byBjYWxj
dWxhdGUgTUFYX1NXQVBGSUxFUyBmcm9tIHRoZSBpbnRlcm5hbAo+ICsgKiBrZXJuZWwgaW1wbGVt
ZW50YXRpb24gKHdoaWNoIGlzIGN1cnJlbnRseSA8MjMsIDI5PiBkZXBlbmRpbmcgb24ga2VybmVs
Cj4gKyAqIGNvbmZpZ3VyYXRpb24pLiBJbnN0ZWFkIHRlc3QgZXhwdGVjdCB0aGF0IGF0IGxlYXN0
IDE1IHN3YXAgZmlsZXMgbWludXMKPiArICogY3VycmVudGx5IHVzZWQgc3dhcCBjYW4gYmUgY3Jl
YXRlZC4KPiAgICovCj4KPiAgI2luY2x1ZGUgPHN0ZGlvLmg+Cj4gQEAgLTIwLDQ5ICsyNCw1NCBA
QAo+ICAjaW5jbHVkZSAibGFwaS9zeXNjYWxscy5oIgo+ICAjaW5jbHVkZSAibGlic3dhcC5oIgo+
Cj4gKyNkZWZpbmUgTlVNX1NXQVBfRklMRVMgMTUKPgoKRG9lcyB0aGUgbnVtYmVyIDE1IGhhdmUg
YSBzcGVjaWZpYyBtZWFuaW5nPwoKQW55d2F5LCB0aGUgd2hvbGUgcGF0Y2ggc2V0IGxvb2tzIGdv
b2QgdG8gbWU6ClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
