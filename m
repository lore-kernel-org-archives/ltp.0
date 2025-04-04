Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFAFC36010
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743771528; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Xkr8GLepRAfFGnXMckigzfBClr3NA72Dlm6vPiQMg4I=;
 b=qLHVlL0PMLctWlG9c+dABm6OqXHpbadW30QT7ayuDfOYqCZ6XHQFS83M5eNH8vQa+9pJT
 7wkA5iRfyCX8bogbfZNj9V+2DuOsfD+mNEPATlJ4gDtUn68d0JrO+sULroJv1AbLGW/ptGM
 +ppYRgkQMY/PB4YlQKhabTLX7izI0Bg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C797A3CB2FC
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 14:58:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE6683CA6BB
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 14:58:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6C54A1A00E19
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 14:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743771500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJ3YH7Q1nhm0iECSDG8Zmx2quxSdlzYgEyCDM89XaSQ=;
 b=OIW89WFpDH3U4rUfxar1C7y32zGqXI/r5um5ZlqcSTaRHORhKC6LcBBtsplrxbWhXmtnsz
 E7cdOHdMx9DsCwG+7bd6nDuM3qDmaIZRRDOZ+RrA5psB3RWCvZvabTH1/jJ/FAdTDueH6R
 chwo9KqRUagtEvU84jJjA+oaEq5whUY=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-zhWTG30QOIGE6LO5KeWWew-1; Fri, 04 Apr 2025 08:58:19 -0400
X-MC-Unique: zhWTG30QOIGE6LO5KeWWew-1
X-Mimecast-MFC-AGG-ID: zhWTG30QOIGE6LO5KeWWew_1743771498
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-86c428a6c64so2407737241.0
 for <ltp@lists.linux.it>; Fri, 04 Apr 2025 05:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743771498; x=1744376298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJ3YH7Q1nhm0iECSDG8Zmx2quxSdlzYgEyCDM89XaSQ=;
 b=ovAn4GX/65T7E0Xg50wla6gy2HHH31QQbmCSohh8uL3xgMrQsWwYat+c6XfMAd7zmn
 0xPMZomqVgevG8y9XU7MvOsLFGsKbioC3yqJfM9UdlgWYfBtu+3s9Ax+R3XTDjkS7Frq
 clIuIwADhlNSiIVc18QlDCdyht4EHQALmCs/3k29VgU2/BXoq5d5JCoV2j32OpeViDES
 hViZhybABnE6dEPAU9tMXAW8v9APS1hNE/26byMF6SUKPQvV+RYZjAhteRCw387lD20M
 mM5EzIgjIOrd+plm1VGp+7C3eG88W2cb3vc90FxlfQtS0i1YHoc5H5hV1f8g7K5fYIkE
 UBwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpUj9RVPECM/LmRwb4cmLIlJOHCnClCd3LHKJdGOI9ieReKc3D+derdwLjIERMfkH9dMA=@lists.linux.it
X-Gm-Message-State: AOJu0Yx/LkMTFctYTZztSBmbUY3mM2lPtXSD6js5C1KDa/xmSvtMf9N/
 oYcIo4nCoouN/98WUWdKairQSGEw2Fa/kSTdEe8KPRBFI9TLfcFRMXcukyFx1V3WKJTjd8FqT89
 fg7i5DY+AhSEn8N6TLY0Uh/ZIbum+xcG1Vj/dNKyRdj4HZJ89XOdz9We2qRE8Vs6NKOk3ltkQ9H
 tWmwG7esXafL7jizDJ8fMi8Gs=
X-Gm-Gg: ASbGnctRSeQQqxGKRYw1ZmCu4zttTbjLAvkPrR4gBlOEDhortSuoZX2Hj2Pwcyrd4Nf
 3V1mpVmDibSZhqAVZwBEx13IzGMIiXw6yseT4R7gRyCHMHdddRATnm7Jc7aJeiuEnuYLj/Np+
X-Received: by 2002:a05:6102:3ec2:b0:4c1:7be4:eb61 with SMTP id
 ada2fe7eead31-4c856a6df84mr1635098137.25.1743771498609; 
 Fri, 04 Apr 2025 05:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGSpHIK/dZ8tya/GDTQFeIh8HHmsgWH8iMcIGs+0k7rpaJluVmnjli91PQgHaSOSVBuOzSvDZ3y0PLGsrOJAA=
X-Received: by 2002:a05:6102:3ec2:b0:4c1:7be4:eb61 with SMTP id
 ada2fe7eead31-4c856a6df84mr1635088137.25.1743771498315; Fri, 04 Apr 2025
 05:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250403113053.20040-1-chrubis@suse.cz>
 <20250403123610.GA465253@pevik>
 <Z-6XSwc9Rbu2RIzm@yuki.lan> <Z-_K0zj30GOhxYS8@yuki.lan>
 <20250404125517.GA527835@pevik>
In-Reply-To: <20250404125517.GA527835@pevik>
Date: Fri, 4 Apr 2025 14:58:03 +0200
X-Gm-Features: ATxdqUFAC5oZKC3BS26mqMR1TnPtyIMxzu6edyidusHS5cJQu3MyLeoK9ilxM2o
Message-ID: <CAASaF6ws+pREnaTvq-VbMDwfBk_ba6=0SrxMQM_BeFBYRUb=1w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6rQ5lLpYbuecRKvUCMPpvDXU309sPhk8G1VF2dg5TS0_1743771498
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_test.c: Fix tst_brk() handling
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBcHIgNCwgMjAyNSBhdCAyOjU14oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+Cj4gPiBIaSEKPiA+ID4gZGlmZiAtLWdpdCBhL2xpYi90c3RfdGVzdC5jIGIv
bGliL3RzdF90ZXN0LmMKPiA+ID4gaW5kZXggYzYzOTVhNWViLi42YjExMDBiMDkgMTAwNjQ0Cj4g
PiA+IC0tLSBhL2xpYi90c3RfdGVzdC5jCj4gPiA+ICsrKyBiL2xpYi90c3RfdGVzdC5jCj4gPiA+
IEBAIC00MDcsNyArNDA3LDggQEAgdm9pZCB0c3RfdmJya18oY29uc3QgY2hhciAqZmlsZSwgY29u
c3QgaW50IGxpbmVubywgaW50IHR0eXBlLCBjb25zdCBjaGFyICpmbXQsCj4gPiA+ICAgICAgICAg
ICogY3VycmVudCBwcm9jZXNzLgo+ID4gPiAgICAgICAgICAqLwo+ID4gPiAgICAgICAgIGlmIChU
VFlQRV9SRVNVTFQodHR5cGUpID09IFRCUk9LKSB7Cj4gPiA+IC0gICAgICAgICAgICAgICB0c3Rf
YXRvbWljX2luYygmcmVzdWx0cy0+YWJvcnRfZmxhZyk7Cj4gPiA+ICsgICAgICAgICAgICAgICBp
ZiAocmVzdWx0cykKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdHN0X2F0b21pY19pbmMo
JnJlc3VsdHMtPmFib3J0X2ZsYWcpOwo+Cj4gPiA+ICAgICAgICAgICAgICAgICAvKgo+ID4gPiAg
ICAgICAgICAgICAgICAgICogSWYgVEJST0sgd2FzIGNhbGxlZCBmcm9tIG9uZSBvZiB0aGUgY2hp
bGQgcHJvY2Vzc2VzIHdlIGtpbGwKPgo+Cj4gPiBBbmQgaXQncyBhIGJpdCBtb3JlIGNvbXBsZXgg
d2UgYWxzbyBuZWVkIHRvIG1ha2Ugc3VyZSB0byBleGl0IHByb3Blcmx5Cj4gPiB3aGVuIHRzdF9i
cmsoKSB3YXMgY2FsbGVkIGJlZm9yZSB0aGUgbGlicmFyeSB3YXMgaW5pdGlhbGl6ZWQsIHNvIHdl
IGFsc28KPgo+ICsxCj4KPiA+IG5lZWQ6Cj4KPiA+IGRpZmYgLS1naXQgYS9saWIvdHN0X3Rlc3Qu
YyBiL2xpYi90c3RfdGVzdC5jCj4gPiBpbmRleCA3NThlNjI4MjMuLmQxOTkwOGQ5NCAxMDA2NDQK
PiA+IC0tLSBhL2xpYi90c3RfdGVzdC5jCj4gPiArKysgYi9saWIvdHN0X3Rlc3QuYwo+ID4gQEAg
LTM4Niw2ICszODYsMTQgQEAgdm9pZCB0c3RfdmJya18oY29uc3QgY2hhciAqZmlsZSwgY29uc3Qg
aW50IGxpbmVubywgaW50IHR0eXBlLCBjb25zdCBjaGFyICpmbXQsCj4gPiAgICAgICAgICAgICAg
ICB2YV9saXN0IHZhKQo+ID4gIHsKPiA+ICAgICAgICAgcHJpbnRfcmVzdWx0KGZpbGUsIGxpbmVu
bywgdHR5cGUsIGZtdCwgdmEpOwo+ID4gKwo+ID4gKyAgICAgICAvKgo+ID4gKyAgICAgICAgKiBJ
ZiB0c3RfYnJrKCkgaXMgY2FsbGVkIGZyb20gc29tZSBvZiB0aGUgQyBoZWxwZXJzIGV2ZW4gYmVm
b3JlIHRoZQo+ID4gKyAgICAgICAgKiBsaWJyYXJ5IHdhcyBpbml0aWFsaXplZCwganVzdCBleGl0
Lgo+ID4gKyAgICAgICAgKi8KPiA+ICsgICAgICAgaWYgKCFsaWJfcGlkKQo+ID4gKyAgICAgICAg
ICAgICAgIGV4aXQoVFRZUEVfUkVTVUxUKHR0eXBlKSk7Cj4KPiBJbnRlcmVzdGluZywgSSBuZXZl
ciBub3RpY2VkIGxpYl9waWQgOikuIEl0J3MgYXNzaWduZWQgaW4gdHN0X3J1bl90Y2FzZXMoKSAt
Cj4gbGlicmFyeSBnZXRzIGluaXRpYWxpemVkIHRoZXJlLiBBcyB0aGF0J3MgdGhlIHZlcnkgZmly
c3QgY2FsbCBpbiBtYWluKCksIHRoaXMKPiByZWFsbHkgYXBwbGllcyBmb3IgaGVscGVycyBpbiB0
ZXN0Y2FzZXMvbGliLyB3aGljaCBkZWZpbmUgVFNUX05PX0RFRkFVTFRfTUFJTi4KPgo+IEkgc3Vw
cG9zZSB0aGlzIGlzIHRoZSBwYXJ0IG9mIHRoZSBmaXggZm9yIGNvcmUgZHVtcGVkIGhlbHBlcnMu
Cj4KPiA+ICsKPiA+ICAgICAgICAgdXBkYXRlX3Jlc3VsdHMoVFRZUEVfUkVTVUxUKHR0eXBlKSk7
Cj4KPiA+ICAgICAgICAgLyoKPiA+IEBAIC00MTUsNyArNDIzLDcgQEAgdm9pZCB0c3RfdmJya18o
Y29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgaW50IHR0eXBlLCBjb25zdCBjaGFy
ICpmbXQsCj4gPiAgICAgICAgICAgICAgICAgICogdGhlIG1haW4gdGVzdCBwcm9jZXNzLiBUaGF0
IGluIHR1cm4gdHJpZ2dlcnMgdGhlIGNvZGUgdGhhdAo+ID4gICAgICAgICAgICAgICAgICAqIGtp
bGxzIGxlZnRvdmVyIGNoaWxkcmVuIG9uY2UgdGhlIG1haW4gdGVzdCBwcm9jZXNzIGRpZCBleGl0
Lgo+ID4gICAgICAgICAgICAgICAgICAqLwo+ID4gLSAgICAgICAgICAgICAgIGlmICh0c3RfZ2V0
cGlkKCkgIT0gbWFpbl9waWQpIHsKPiA+ICsgICAgICAgICAgICAgICBpZiAobWFpbl9waWQgJiYg
dHN0X2dldHBpZCgpICE9IG1haW5fcGlkKSB7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB0
c3RfcmVzKFRJTkZPLCAiQ2hpbGQgcHJvY2VzcyByZXBvcnRlZCBUQlJPSyBraWxsaW5nIHRoZSB0
ZXN0Iik7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBraWxsKG1haW5fcGlkLCBTSUdLSUxM
KTsKPiA+ICAgICAgICAgICAgICAgICB9Cj4KPgo+ID4gSSB3aWxsIHNlbmQgdjIgbGF0ZXIgb24u
Cj4KPiArMQoKKzEsIEkgd2FudGVkIHRvIGhhdmUgYSBsb29rIHRvbywgYW5kIGl0IHdpbGwgYmUg
ZWFzaWVyIHRvIGZvbGxvdwpoYXZpbmcgaXQgYWxsIGluIHRvZ2V0aGVyLgoKPgo+IEtpbmQgcmVn
YXJkcywKPiBQZXRyCj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
