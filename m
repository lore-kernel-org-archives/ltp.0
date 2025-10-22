Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E13CCD1AB
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 09:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761124539; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=BMzNsxG2m3d3u/e0cnV/Y3QAZlxZ4iyL4Y0No9UHe90=;
 b=ZwpZvkMyOznUdyvZrnzraKQeN1hU8suO4nVYR5/I3tec6+MH/MR18Bla4ii8vrFX6dC9B
 FBgALq26ZnI7r0gT/Qx/435Da5JqQpnsYbhD/UhMn2urCVPfn5wIV0ieDD1f9DgSuXzJmve
 aFNlub70+S63lJ94T/FUyoVin8cnhRg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 790433CF0A3
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 11:15:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CED13CEDEE
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 11:15:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 38C25200A1B
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 11:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761124515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yoyoZjbRPVu74aK/UbADh63lJXLZrJHFneyyj3DOsWA=;
 b=CImtEOv7ZDDEXAorK2F8S8A6zpD0Pfc+3gaxX8il6QRu2ha1fQGE4j1Fmsojg3ciq28L/2
 UkqTr8NuWxrIkp+OkPIpSsPCrsEK3VOqx2a0/Men7/zghC/wzen5MsBOsxwVwiJ2za/lcH
 rMcH0jhaBrob0sbgzzp5wNIIZMvvtm4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-flXI09lCOlea5Xl-c1g9Ew-1; Wed, 22 Oct 2025 05:15:13 -0400
X-MC-Unique: flXI09lCOlea5Xl-c1g9Ew-1
X-Mimecast-MFC-AGG-ID: flXI09lCOlea5Xl-c1g9Ew_1761124512
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-290e4fade70so51563355ad.2
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 02:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761124512; x=1761729312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yoyoZjbRPVu74aK/UbADh63lJXLZrJHFneyyj3DOsWA=;
 b=XExT+ZwfSDk7Y95tgnFFh/VdrWHCCwXoyBGsvAC8uD858yZ0sEoWQWniOl9Lh4VBeI
 iiXOU3yfP4MWnqS72OUDvXL7t1W/B6GsoEfF/qIYlReVNLKBMNEbSd5Hl6uRg/4KuMoX
 FMAd0Ord7CH4aq/WGqcjhhz1I8KcO2Biqp4oKTvwJQGaDfUGwsJz34hX3Cl8TP1ZFPRU
 /By7CZlk8XD5MvGs/YeJYSeoQmX5LCROqMWtSkbbMP4tuqCIDOqOrhhHIrqhrLN5ANb5
 +owv28229YESFF7OE9JKwZkI3jf8vVNmmOwwPPT4bF0yTJaak4jRE92O9OPYKuyZUPEC
 zi6A==
X-Gm-Message-State: AOJu0YxMVVdnSzaHqq7JCRl3FwZxf3TRjjGfW9ioQ2XQdASJAli1YPwJ
 VcKghEjGRVd8i85Hw3xZxTJMvnnMFBRCHBHrc5PeYyKdKxO7NUBn1iyMJrxB2Lood9D0/qPeOdq
 x9kYZ2ffnK16Yvrbdib+pb9fpQEPswWBAAGdTwsSSl7ELUCiwsRH02AK6NnakAZv0QUDnDWa9Vm
 KSnvp6Bq1oNvQ+7U4VFcAc6H5ySgw=
X-Gm-Gg: ASbGnctNbke6UoyukNHic1e3aw8PESYaapF7xQEBnTx0HixPG4qOLcmGvyQ3GpplK+A
 6xDpBRUZ5HislYn3STPP7WIStPyR+Kv0T8yG5ctnHe/Peao11VVJXhWTZ8f/KwLqfwJfolwToUV
 tx5jD/4e6HTpesezEa4vB4BxrGhVr2HFHO3vXUOyt/4TMhZCA7FgJ9+dyw
X-Received: by 2002:a17:903:b8b:b0:26d:e984:8157 with SMTP id
 d9443c01a7336-290c9c89ca7mr208678095ad.8.1761124512280; 
 Wed, 22 Oct 2025 02:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENOj2s5cEF8wDwyST35U8y8i/x+2pFrI2x5A4riczNIm+HXUUxvJa/SuHd66txaAdYvi0kviYf4D6obGOQcRM=
X-Received: by 2002:a17:903:b8b:b0:26d:e984:8157 with SMTP id
 d9443c01a7336-290c9c89ca7mr208677765ad.8.1761124511776; Wed, 22 Oct 2025
 02:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251020142813.415231-1-pvorel@suse.cz>
In-Reply-To: <20251020142813.415231-1-pvorel@suse.cz>
Date: Wed, 22 Oct 2025 17:14:59 +0800
X-Gm-Features: AS18NWA6dS-p3Q8hOvy8O0YAL384LErL8pUU1fU6OkmFnZWDq6bBulGSH90Hw9U
Message-ID: <CAEemH2esCEGcA-cXXGyxHZHM49mhq0PJAcG7DCbgLF8=J_=QDQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JPJnlCUAv6wPeiWyvWBdoSPmi_c4p9WPwdfmvJ4kNsc_1761124512
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] tst_cmd: Change tst_check_cmd() return type
 to int
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

T24gTW9uLCBPY3QgMjAsIDIwMjUgYXQgMTA6MjjigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+IEZ1bmN0aW9uIHVzZSBqdXN0IGJvb2wgdmFsdWUsIG5vIG5lZWQgZm9y
IGludCAocmVhZGFiaWxpdHkpLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCi0t
LQo+ICBpbmNsdWRlL3RzdF9wcml2YXRlLmggfCAyICstCj4gIGxpYi90c3RfY21kLmMgICAgICAg
ICB8IDkgKysrKystLS0tCj4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0X3ByaXZhdGUuaCBiL2luY2x1
ZGUvdHN0X3ByaXZhdGUuaAo+IGluZGV4IDI5MmY3ZTkzNjYuLjg3ZWM4ODI5YTEgMTAwNjQ0Cj4g
LS0tIGEvaW5jbHVkZS90c3RfcHJpdmF0ZS5oCj4gKysrIGIvaW5jbHVkZS90c3RfcHJpdmF0ZS5o
Cj4gQEAgLTQ1LDcgKzQ1LDcgQEAgY2hhciB0c3Rfa2NvbmZpZ19nZXQoY29uc3QgY2hhciAqY29u
Zm5hbWUpOwo+ICAgKiBmdW5jdGlvbiBjaGVja3MgY29tbWFuZCB2ZXJzaW9uIHdoZXRoZXIgbWVl
dHMgdGhpcyByZXF1aXJlbWVudC4KPiAgICogSWYgbm90LCBjYXNlIGJyZWFrcyBpZiBicmtfbm9z
dXBwIGlzIGRlZmluZWQuCj4gICAqLwo+IC1pbnQgdHN0X2NoZWNrX2NtZChjb25zdCBjaGFyICpj
bWQsIGNvbnN0IGludCBicmtfbm9zdXBwKTsKPiArYm9vbCB0c3RfY2hlY2tfY21kKGNvbnN0IGNo
YXIgKmNtZCwgY29uc3QgaW50IGJya19ub3N1cHApOwo+Cj4gIC8qCj4gICAqIFJldHVybnMgTlVM
TC10ZXJtaW5hdGVkIGFycmF5IG9mIGtlcm5lbC1zdXBwb3J0ZWQgZmlsZXN5c3RlbXMuCj4gZGlm
ZiAtLWdpdCBhL2xpYi90c3RfY21kLmMgYi9saWIvdHN0X2NtZC5jCj4gaW5kZXggODJkNjA0OTdh
OC4uMmZhZjdjNzQzMCAxMDA2NDQKPiAtLS0gYS9saWIvdHN0X2NtZC5jCj4gKysrIGIvbGliL3Rz
dF9jbWQuYwo+IEBAIC0yNyw2ICsyNyw3IEBACj4gICNpbmNsdWRlIDxmY250bC5oPgo+ICAjaW5j
bHVkZSA8dW5pc3RkLmg+Cj4gICNpbmNsdWRlIDxzaWduYWwuaD4KPiArI2luY2x1ZGUgPHN0ZGJv
b2wuaD4KPiAgI2luY2x1ZGUgInRlc3QuaCIKPiAgI2luY2x1ZGUgInRzdF9jbWQuaCIKPiAgI2lu
Y2x1ZGUgInRzdF9wcml2YXRlLmgiCj4gQEAgLTI0OSw3ICsyNTAsNyBAQCBzdGF0aWMgc3RydWN0
IHZlcnNpb25fcGFyc2VyIHsKPiAgICAgICAgIHt9LAo+ICB9Owo+Cj4gLWludCB0c3RfY2hlY2tf
Y21kKGNvbnN0IGNoYXIgKmNtZCwgY29uc3QgaW50IGJya19ub3N1cHApCj4gK2Jvb2wgdHN0X2No
ZWNrX2NtZChjb25zdCBjaGFyICpjbWQsIGNvbnN0IGludCBicmtfbm9zdXBwKQo+ICB7Cj4gICAg
ICAgICBzdHJ1Y3QgdmVyc2lvbl9wYXJzZXIgKnA7Cj4gICAgICAgICBjaGFyICpjbWRfdG9rZW4s
ICpvcF90b2tlbiwgKnZlcnNpb25fdG9rZW4sICpuZXh0LCAqc3RyOwo+IEBAIC0yNjgsNyArMjY5
LDcgQEAgaW50IHRzdF9jaGVja19jbWQoY29uc3QgY2hhciAqY21kLCBjb25zdCBpbnQKPiBicmtf
bm9zdXBwKQo+ICAgICAgICAgICAgICAgICB0c3RfYnJrbShUQ09ORiwgTlVMTCwgIkNvdWxkbid0
IGZpbmQgJyVzJyBpbiAkUEFUSCIsCj4gY21kX3Rva2VuKTsKPgo+ICAgICAgICAgaWYgKCFvcF90
b2tlbikKPiAtICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gKyAgICAgICAgICAgICAgIHJldHVy
biB0cnVlOwo+Cj4gICAgICAgICBpZiAoIXZlcnNpb25fdG9rZW4gfHwgc3RyKSB7Cj4gICAgICAg
ICAgICAgICAgIHRzdF9icmttKFRDT05GLCBOVUxMLAo+IEBAIC0zMTgsNyArMzE5LDcgQEAgaW50
IHRzdF9jaGVja19jbWQoY29uc3QgY2hhciAqY21kLCBjb25zdCBpbnQKPiBicmtfbm9zdXBwKQo+
ICAgICAgICAgICAgICAgICB0c3RfYnJrbShUQ09ORiwgTlVMTCwgIkludmFsaWQgb3AoJXMpIiwg
b3BfdG9rZW4pOwo+ICAgICAgICAgfQo+Cj4gLSAgICAgICByZXR1cm4gMDsKPiArICAgICAgIHJl
dHVybiB0cnVlOwo+ICBlcnJvcjoKPiAgICAgICAgIGlmIChicmtfbm9zdXBwKSB7Cj4gICAgICAg
ICAgICAgICAgIHRzdF9icmttKFRDT05GLCBOVUxMLCAiJXMgcmVxdWlyZXMgJXMgJWQsIGJ1dCBn
b3QgJWQiLAo+IEBAIC0zMjgsNSArMzI5LDUgQEAgZXJyb3I6Cj4gICAgICAgICAgICAgICAgICAg
ICAgICAgY21kLCBvcF90b2tlbiwgdmVyX2dldCwgdmVyX3BhcnNlcik7Cj4gICAgICAgICB9Cj4K
PiAtICAgICAgIHJldHVybiAxOwo+ICsgICAgICAgcmV0dXJuIGZhbHNlOwo+ICB9Cj4gLS0KPiAy
LjUxLjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
