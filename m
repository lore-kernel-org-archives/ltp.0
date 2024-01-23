Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5C3C47DDB
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 07:31:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 681B73CE20A
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 08:31:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4CCE3CC32B
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 08:31:16 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ED90C60094E
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 08:31:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705995074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lcsUUih+L6G33qus3xoYdKRwsJspgFFzDpWtUEIVtAs=;
 b=Z61Vh1lCex8ygiI9bmy3a+BTnMnEtQD6rfb3iPU7uRiNfuhTVTvpqxtvQItubZKM6rSLOi
 fpTSMaKVyLWFrDAudP1plXO7h3VIwLyjZxdssMztgDFo14SAe6Q/8VDrVO4lkL6HGrCadB
 zJ9zpRWow+spjjykbyQh2YoUS5nIgA0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-e3AGO26ZNL-SDkjr687MBA-1; Tue, 23 Jan 2024 02:31:10 -0500
X-MC-Unique: e3AGO26ZNL-SDkjr687MBA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29072b2ac68so1003590a91.1
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 23:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705995069; x=1706599869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lcsUUih+L6G33qus3xoYdKRwsJspgFFzDpWtUEIVtAs=;
 b=oIlFVFfzm0NUkt94xQbtT84PI8vl8l7fwGwlyDBeaWgZDLp/IN3uDBD0yXF64zvqmC
 8rJoTcypcUJY36HSKMH4pnLBQA3lu9zYLmnVne/JrPs+w8leszymeOfv0zt5bHlaIjtZ
 B0R9AS+qS9r+hsnvGd74lRymngIzFmotrC9u9qo5q2IWC7LHmW0ZhbbjqGK9AoIWLr2b
 QyFAcfk2+P4WSgj41bxLLO6B/iNmReRBVzsdZEhNiAtIZRxthKzNvVVv46MFlv+cGCOJ
 PDjb9CV+iOg9+XS21PibAsOFlgk0aPzH0brCLBd9HNIGzm7hV5d4wAV4vGghTQI8LADU
 wG1g==
X-Gm-Message-State: AOJu0Yzwka6XqtfGebIm77FlihfR6uwPvitknwv/Lz47kbXeH9HQ8xz7
 VC6RcnQn55nS9eMJD97XWmyH4vHq4LvY/16At5lZMxLdZUlU/FO2QJlIn0UPwXa2Qm4TbYOc9dc
 oaVWBG3zusL/MlRy4K++HWftJJlXXGrd6Vjtc3wogkMfcKWo78sM9cTjY9kVqCNAbjhlCWb/PHU
 G4bw9ilaH/xD4tOPYurq3rza0=
X-Received: by 2002:a17:90a:fd84:b0:28b:e0e9:4816 with SMTP id
 cx4-20020a17090afd8400b0028be0e94816mr2532775pjb.65.1705995069108; 
 Mon, 22 Jan 2024 23:31:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEwmz1QawAcGT7v/lV6uZQUv8Qez7jzZkE+ujiu9nkVxdYUZzjPni52xc95WayIxV7wur/YPphYMDAX1s61kE=
X-Received: by 2002:a17:90a:fd84:b0:28b:e0e9:4816 with SMTP id
 cx4-20020a17090afd8400b0028be0e94816mr2532766pjb.65.1705995068752; Mon, 22
 Jan 2024 23:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122091356.GF76754@pevik>
 <CAEemH2dA6sjKz4LGUwYT3wr-4WRZ5H_usSptEG30HxVDVbWSWA@mail.gmail.com>
 <20240122110344.GB95077@pevik>
 <CAEemH2cNn1kyWrnqXHHeOteGT_FQ=PBVc55NFhkZbmkbMOoD=A@mail.gmail.com>
 <20240122202325.GA119341@pevik>
 <CAEemH2dTKjxuiMaHBh0Ky0VV+p2YmDQzH7nvZZjnOVop2E04jQ@mail.gmail.com>
In-Reply-To: <CAEemH2dTKjxuiMaHBh0Ky0VV+p2YmDQzH7nvZZjnOVop2E04jQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Jan 2024 15:30:56 +0800
Message-ID: <CAEemH2cEY=kiJe91Y_kZNefjbh+L-3rikcxErSqVwhQN7mQ=fA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

T24gVHVlLCBKYW4gMjMsIDIwMjQgYXQgMTo1NeKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gSGkgUGV0ciwKPgo+IE9uIFR1ZSwgSmFuIDIzLCAyMDI0IGF0IDQ6MjPi
gK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPj4gSGkgTGksCj4+Cj4+
ID4gR3JlYXQsIGFuZCBGWUkuCj4+Cj4+ID4gSSBqdXN0IHB1c2hlZCBhIG5ldyBjb21taXQgdG8g
cmVzb2x2ZSB0aGUgRklCTUFQICh1bnN1cHBvcnRlZCBvbiBCVFJGUykKPj4gPiBwcm9ibGVtIG9u
IG15IGx0cDpsaWJzd2FwIGJyYW5jaC4KPj4KPj4gPgo+PiBodHRwczovL2dpdGh1Yi5jb20vd2Fu
Z2xpNTY2NS9sdHAvY29tbWl0LzY5OTcxMWJmZThjOGRiYzM1OTdjNDY1ODczNDVmYTExOTdjMDU0
YzkKPj4KPj4gPiBIb3BlIHlvdSBjYW4gdHJ5IG9uIHlvdXIgc2lkZSBhbmQgZ2l2ZSBzb21lIGZl
ZWRiYWNrIDopLgo+Pgo+PiBVbmZvcnR1bmF0ZWx5IHJlZ2FyZGxlc3Mgb2Yga2VybmVsIHZlcnNp
b24gaXQgZmFpbHM6Cj4+Cj4+ICMgTFRQX1NJTkdMRV9GU19UWVBFPWJ0cmZzIC4vc3dhcG9uMDEK
Pj4gLi4uCj4+IHRzdF90ZXN0LmM6MTY2OTogVElORk86ID09PSBUZXN0aW5nIG9uIGJ0cmZzID09
PQo+PiB0c3RfdGVzdC5jOjExMTc6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDAgd2l0aCBi
dHJmcyBvcHRzPScnIGV4dHJhCj4+IG9wdHM9JycKPj4gdHN0X3Rlc3QuYzoxMTMxOiBUSU5GTzog
TW91bnRpbmcgL2Rldi9sb29wMCB0bwo+PiAvdG1wL0xUUF9zd2E0OTdBS3AvbW50cG9pbnQgZnN0
eXA9YnRyZnMgZmxhZ3M9MAo+PiB0c3RfaW9jdGwuYzoyMTogVElORk86IEZJQk1BUCBpb2N0bCBp
cyBOT1Qgc3VwcG9ydGVkOiBFSU5WQUwgKDIyKQo+PiBsaWJzd2FwLmM6OTM6IFRJTkZPOiBGaWxl
ICdtbnRwb2ludC9zd2FwZmlsZTAxJyBpcyBub3QgY29udGlndW91cwo+PiBsaWJzd2FwLmM6MzQ6
IFRJTkZPOiBGU19OT0NPV19GTCBhdHRyaWJ1dGUgc2V0IG9uIG1udHBvaW50L3N3YXBmaWxlMDEK
Pj4gbGlic3dhcC5jOjE2OTogVEZBSUw6IHN3YXBvbigpIG9uIGJ0cmZzIGZhaWxlZDogRUlOVkFM
ICgyMikKPj4KPgo+Cj4gVGhhbmtzIGZvciB0aGUgcXVpY2sgZmVlZGJhY2ssIHZlcnkgdXNlZnVs
Lgo+Cj4gQWZ0ZXIgbG9va2luZyBvdmVyIHRoZSBjb2RlLCBJIHRoaW5rIGl0J3MgYmVjYXVzZSB0
aGUgdHN0X2ZpbGxfZmlsZSBkaWRuJ3QKPiBjcmVhdGUgYSBjb250aWd1b3VzIGZpbGUgYXQgdGhl
IGJlZ2lubmluZywgc28gdGhlIHNvbHV0aW9uIGlzIHByb2JhYmx5Cj4gdG8gZGVmaW5lIGEgbmV3
IGZ1bmN0aW9uIGp1c3QgdXNlZCBieSBjcmVhdGluZyBhIGNvbnRpZ3VvdXMgZmlsZSBmb3IgYnRy
ZnMKPiBpbiB0aGUgbGlic3dhcC5jLgo+Cj4gQWZ0ZXIgYSB0aW55IGFtZW5kLCBpdCB3b3JrcyBv
biBhIGZlZG9yYTM4Lgo+CgpWMyBpcyBoZXJlOiBodHRwczovL2dpdGh1Yi5jb20vd2FuZ2xpNTY2
NS9sdHAvY29tbWl0cy9saWJzd2FwLXYzCgpJdCBnZXQgcGFzc2VkIG9uIG15IGZlZG9yYTM4KEJU
UkZTKSwgcmhlbDkoWEZTKSBwbGF0Zm9ybXMsIEkgd291bGQKcG9zdCBvdXQgaW4gTUwsIGp1c3Qg
biBjYXNlIHBlb3BsZSBjYW4gcmV2aWV3IHRoZSBsYXRlc3QgdmVyc2lvbi4KCihpdCBtYWRlIHF1
aXRlIGEgbG90IG9mIGNoYW5nZXMgdnMgdGhlIHYxLCBzbyBJIGRvbid0IHdhbnQgcGVvcGxlIHRv
IHNlZQp0aGUKYnVnZ3kgdmVyc2lvbiB0byBmYWxsIGludG8gY29uZnVzaW9uIDopCgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
