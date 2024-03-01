Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D3AC5475B
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 04:14:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94E4F3D2221
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 05:14:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D93933D2210
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 05:14:31 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C3955601223
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 05:14:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709266468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1E7CW+fcB23bbYiVxzcZd9V89fJ4QBnMhXG4O54p1F4=;
 b=RSvpHFgmCXa/koM/nFMe0G4513ZKZ8OmDpBsC6pc434A/VPnIuREnnV3hHGrJWTqCVaXuK
 A7c2HVq1BfixJbltoXXMN+8fe2gCubJE9c4IoTpAsvb76jurOmLR02hXtBSN3dFIG7P5w4
 LAfyb7n3OVH39um1Q4tADhpj6nkjNbQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-N20foFQYP3m7Azzq2B8DWA-1; Thu, 29 Feb 2024 23:14:26 -0500
X-MC-Unique: N20foFQYP3m7Azzq2B8DWA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5dc1548ac56so1268461a12.3
 for <ltp@lists.linux.it>; Thu, 29 Feb 2024 20:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709266464; x=1709871264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1E7CW+fcB23bbYiVxzcZd9V89fJ4QBnMhXG4O54p1F4=;
 b=nQJ58xr2gHJp/3feZbqW97eKEmydMSudjuJ9Za6iFgtK4RITmdTp0fLuDXLSna5bMp
 6IZfzjyhJ2iKsgRl3VUgpH3X97gPI8Q+tIRGC0fyPgR1kQWLYdlzSspcX7lbagL0aKAO
 wVv2EJOC6nxS4x/iYqZJgC0HZxsDYdxjoQAvi9DXM6dOP5tq7xafyySC8yjvwGWljGPQ
 L79wSszD7F27Mtv+4K1zPogFxGt0snf3ec5SapSWJkvs8ItBq9vA63VitqZ3GM578S+U
 UmXt2UtUcx6hYXj38on4HGyiCcf8EKTzbiCB4HkAAKLtkP40xJl3VmsJvay4qbadmJCw
 m8bQ==
X-Gm-Message-State: AOJu0Yyk76G7WeNSIMQn9cnZsx7SShxoIadn+cg2FphOnfMp2laVqc1r
 PSmydePQE9/RO4YxvV9YQd9t4j6ed0IXPac5mi8YVtcU/yYU6WDBqyoGpxE8Jij8jytKsBMkZSE
 wQqro9ikjgur+2+HIrG4chxjdDaFr9WA6nA2RPLpwLJBXodKk+j3T/Z2OnChFhMszMUBXusild1
 7RFSyWArce8LDXNqRux8YCohhcFtO9CVxRdKAn
X-Received: by 2002:a05:6a20:7f83:b0:1a0:cb49:60a0 with SMTP id
 d3-20020a056a207f8300b001a0cb4960a0mr299896pzj.36.1709266464580; 
 Thu, 29 Feb 2024 20:14:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5SvpY5LQRkrdZn2A61ZWMe8AGRcqbgX4TDnyfcGOIT75WFad/sQJl5r07UK+6dQzsanRZsPmecayacMeKHZM=
X-Received: by 2002:a05:6a20:7f83:b0:1a0:cb49:60a0 with SMTP id
 d3-20020a056a207f8300b001a0cb4960a0mr299889pzj.36.1709266464100; Thu, 29 Feb
 2024 20:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20240301015037.22061-1-wegao@suse.com>
In-Reply-To: <20240301015037.22061-1-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Mar 2024 12:14:12 +0800
Message-ID: <CAEemH2e_7sD==18K2174SnGcJWiA8B0Zco2GwHdavoBatXuAbQ@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] libswap.c: Check free space with correct mnt
 path
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

SGkgV2VpLAoKR29vZCBjYXRjaCEKClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4KCgpPbiBGcmksIE1hciAxLCAyMDI0IGF0IDk6NTHigK9BTSBXZWkgR2FvIHZpYSBsdHAg
PGx0cEBsaXN0cy5saW51eC5pdD4gd3JvdGU6Cgo+IFRoZSB0c3RfZnNfaGFzX2ZyZWUgc2hvdWxk
IGNoZWNrIGZzIHNpemUgb2YgbW50IHBvaW50Lgo+IEJ1dCBjdXJyZW50IGNvZGUgY2hlY2sgIi4i
LCB0aGF0IG1lYW5zIGNoZWNrIC90bXAvTFRQX3h4eAo+IGluc3RlYWQgb2YgL3RtcC9MVFBfeHh4
L21udHBvaW50Lgo+Cj4gQWxzbyB0c3RfZnNfaGFzX2ZyZWUncyAic2l6ZSIgcGFyYW1ldGVyJ3Mg
dHlwZSBpcyB1bnNpZ25lZCBpbnQsCj4gaXQgd2lsbCBvdmVyZmxvdyBpZiBlbmNvdW50ZXIgYmln
IGZpbGVzeXN0ZW0gYmxvY2sgc2l6ZShzdWNoIGFzIEJ0cmZzCj4gY2FuIHVzZSA2NGspLgo+Cj4g
U2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cj4gLS0tCj4gIGluY2x1ZGUv
dHN0X2ZzLmggICAgICAgICAgfCA2ICsrKy0tLQo+ICBsaWIvdHN0X2ZzX2hhc19mcmVlLmMgICAg
IHwgMiArLQo+ICBsaWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jIHwgNCArKystCj4gIDMgZmlsZXMg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvdHN0X2ZzLmggYi9pbmNsdWRlL3RzdF9mcy5oCj4gaW5kZXggMWRkN2QzMmZjLi45
OWRiYmE0ZDEgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS90c3RfZnMuaAo+ICsrKyBiL2luY2x1ZGUv
dHN0X2ZzLmgKPiBAQCAtNjAsNyArNjAsNyBAQCBlbnVtIHsKPiAgICogQG11bHQ6IG11bHQgc2hv
dWxkIGJlIFRTVF9LQiwgVFNUX01CIG9yIFRTVF9HQgo+ICAgKiB0aGUgcmVxdWlyZWQgZnJlZSBz
cGFjZSBpcyBjYWxjdWxhdGVkIGJ5IEBzaXplICogQG11bHQKPiAgICovCj4gLWludCB0c3RfZnNf
aGFzX2ZyZWVfKHZvaWQgKCpjbGVhbnVwKSh2b2lkKSwgY29uc3QgY2hhciAqcGF0aCwgdW5zaWdu
ZWQKPiBpbnQgc2l6ZSwKPiAraW50IHRzdF9mc19oYXNfZnJlZV8odm9pZCAoKmNsZWFudXApKHZv
aWQpLCBjb25zdCBjaGFyICpwYXRoLCB1aW50NjRfdAo+IHNpemUsCj4gICAgICAgICAgICAgICAg
ICAgICAgdW5zaWduZWQgaW50IG11bHQpOwo+Cj4gIC8qCj4gQEAgLTIyNSw3ICsyMjUsNyBAQCBz
dGF0aWMgaW5saW5lIGxvbmcgdHN0X2ZzX3R5cGUoY29uc3QgY2hhciAqcGF0aCkKPiAgICAgICAg
IHJldHVybiB0c3RfZnNfdHlwZV8oTlVMTCwgcGF0aCk7Cj4gIH0KPgo+IC1zdGF0aWMgaW5saW5l
IGludCB0c3RfZnNfaGFzX2ZyZWUoY29uc3QgY2hhciAqcGF0aCwgdW5zaWduZWQgaW50IHNpemUs
Cj4gK3N0YXRpYyBpbmxpbmUgaW50IHRzdF9mc19oYXNfZnJlZShjb25zdCBjaGFyICpwYXRoLCB1
aW50NjRfdCBzaXplLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25l
ZCBpbnQgbXVsdCkKPiAgewo+ICAgICAgICAgcmV0dXJuIHRzdF9mc19oYXNfZnJlZV8oTlVMTCwg
cGF0aCwgc2l6ZSwgbXVsdCk7Cj4gQEAgLTI1Miw3ICsyNTIsNyBAQCBzdGF0aWMgaW5saW5lIGxv
bmcgdHN0X2ZzX3R5cGUodm9pZCAoKmNsZWFudXApKHZvaWQpLAo+IGNvbnN0IGNoYXIgKnBhdGgp
Cj4gIH0KPgo+ICBzdGF0aWMgaW5saW5lIGludCB0c3RfZnNfaGFzX2ZyZWUodm9pZCAoKmNsZWFu
dXApKHZvaWQpLCBjb25zdCBjaGFyICpwYXRoLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1bnNpZ25lZCBpbnQgc2l6ZSwgdW5zaWduZWQgaW50IG11bHQpCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IHNpemUsIHVuc2lnbmVkIGludCBtdWx0
KQo+ICB7Cj4gICAgICAgICByZXR1cm4gdHN0X2ZzX2hhc19mcmVlXyhjbGVhbnVwLCBwYXRoLCBz
aXplLCBtdWx0KTsKPiAgfQo+IGRpZmYgLS1naXQgYS9saWIvdHN0X2ZzX2hhc19mcmVlLmMgYi9s
aWIvdHN0X2ZzX2hhc19mcmVlLmMKPiBpbmRleCBlODJkZmE4MzcuLjA4MGQ2OTNhYiAxMDA2NDQK
PiAtLS0gYS9saWIvdHN0X2ZzX2hhc19mcmVlLmMKPiArKysgYi9saWIvdHN0X2ZzX2hhc19mcmVl
LmMKPiBAQCAtMjcsNyArMjcsNyBAQAo+ICAjaW5jbHVkZSAidHN0X2ZzLmgiCj4KPiAgaW50IHRz
dF9mc19oYXNfZnJlZV8odm9pZCAoKmNsZWFudXApKHZvaWQpLCBjb25zdCBjaGFyICpwYXRoLAo+
IC0gICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBzaXplLCB1bnNpZ25lZCBpbnQgbXVs
dCkKPiArICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBzaXplLCB1bnNpZ25lZCBpbnQgbXVs
dCkKPiAgewo+ICAgICAgICAgc3RydWN0IHN0YXRmcyBzZjsKPgo+IGRpZmYgLS1naXQgYS9saWJz
L2xpYmx0cHN3YXAvbGlic3dhcC5jIGIvbGlicy9saWJsdHBzd2FwL2xpYnN3YXAuYwo+IGluZGV4
IGM4Y2JiOGVhMS4uNmM3NWQyMGZhIDEwMDY0NAo+IC0tLSBhL2xpYnMvbGlibHRwc3dhcC9saWJz
d2FwLmMKPiArKysgYi9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jCj4gQEAgLTEzNyw2ICsxMzcs
NyBAQCBpbnQgbWFrZV9zd2FwZmlsZShjb25zdCBjaGFyICpzd2FwZmlsZSwgaW50IGJsb2NrcywK
PiBpbnQgc2FmZSkKPiAgICAgICAgIHN0cnVjdCBzdGF0dmZzIGZzX2luZm87Cj4gICAgICAgICB1
bnNpZ25lZCBsb25nIGJsa19zaXplLCBiczsKPiAgICAgICAgIHNpemVfdCBwZ19zaXplID0gc3lz
Y29uZihfU0NfUEFHRVNJWkUpOwo+ICsgICAgICAgY2hhciBtbnRfcGF0aFsxMDBdOwo+Cj4gICAg
ICAgICBpZiAoc3RhdHZmcygiLiIsICZmc19pbmZvKSA9PSAtMSkKPiAgICAgICAgICAgICAgICAg
cmV0dXJuIC0xOwo+IEBAIC0xNDksNyArMTUwLDggQEAgaW50IG1ha2Vfc3dhcGZpbGUoY29uc3Qg
Y2hhciAqc3dhcGZpbGUsIGludCBibG9ja3MsCj4gaW50IHNhZmUpCj4gICAgICAgICBlbHNlCj4g
ICAgICAgICAgICAgICAgIGJzID0gYmxrX3NpemU7Cj4KPiAtICAgICAgIGlmICghdHN0X2ZzX2hh
c19mcmVlKCIuIiwgYnMgKiBibG9ja3MsIFRTVF9CWVRFUykpCj4gKyAgICAgICBzc2NhbmYoc3dh
cGZpbGUsICIlW14vXSIsIG1udF9wYXRoKTsKPiArICAgICAgIGlmICghdHN0X2ZzX2hhc19mcmVl
KG1udF9wYXRoLCBicyAqIGJsb2NrcywgVFNUX0JZVEVTKSkKPiAgICAgICAgICAgICAgICAgdHN0
X2JyayhUQ09ORiwgIkluc3VmZmljaWVudCBkaXNrIHNwYWNlIHRvIGNyZWF0ZSBzd2FwCj4gZmls
ZSIpOwo+Cj4gICAgICAgICAvKiBjcmVhdGUgZmlsZSAqLwo+IC0tCj4gMi4zNS4zCj4KPgo+IC0t
Cj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
