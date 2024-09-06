Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA25CD5BDD
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 11:06:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28BD23C272D
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 13:06:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EB4E3C1D48
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 13:06:36 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 30A40600D1C
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 13:06:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725620793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cUPrtLMH7BzDrUAPGxK0L/pZLd7rrP/u0wDbFZ4i77U=;
 b=g/C5l51Xj5/cl2daZvnjPcYfq0VdCWNs1kSmDTzen0xtEEcTD09FL37pyGiBXXTERQuVgN
 foPw3xX/vYLe8seZAN5LjmtIltYZS/JpK4IPpbSWeMLFRYjd/2X5xw9OVIT2ALOQcYEmHl
 v3RvzkjomVDfIMjk4Y1QT0uqW71gnPI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-GQg6VBHINnSCu7rXUQ4WOQ-1; Fri, 06 Sep 2024 07:06:32 -0400
X-MC-Unique: GQg6VBHINnSCu7rXUQ4WOQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2d889fde2aaso2367508a91.0
 for <ltp@lists.linux.it>; Fri, 06 Sep 2024 04:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725620791; x=1726225591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cUPrtLMH7BzDrUAPGxK0L/pZLd7rrP/u0wDbFZ4i77U=;
 b=omODNyux1f3VJFJMDzsjv+Sqf5Aezkal23LBzHoCMmf0756ToSvLo70roWxDEu1oiR
 waipie30iAMqfGzG0yNq4hP3ayt0CDVJMaHZiqVDIk5wLGXiAo2ztkHdMe/nBJrMnxqY
 homuM3qigTSyGtfiy2MaXV9gKowoJB+RQhnf/01foYPhm9c2GTUIv3hMRPuUx3PTav2D
 T0BTqKiXgkvgMewAQqOH/Vfogkk+E8gkuHi9o96nfgq9KTPV1MeEEYiUebGHLzuZAgcZ
 bkX2cj0fHtvUXUDiFPgSi4X6Epl9A+PW6+c2Fvn0cmKLS2rGatsfUJPjYrRjNone7jTb
 93lQ==
X-Gm-Message-State: AOJu0YxAS3WQCBlGh+wd+l2+NPGGX+7lR1aZBJULCYUsvYDPoN+SZC/i
 qE3T6fr+HrOl3MZ9N+Vgl//Lv+HEL/KhPzb8se6wN1Uxc5PhTcsKO3eQfrmYZVXbe4S/k7d3s6i
 UHM5v5+dWdKJApnn4tE7xeQ1tsMH1DCeT+t3AqPYYD2oxFo4t32x8k64m0jWOOM6nxhZ2eZCWou
 72yre+1RQwyaAHhK2lDSil+pw=
X-Received: by 2002:a17:90b:68e:b0:2d8:a344:900d with SMTP id
 98e67ed59e1d1-2dad4ef4a5fmr2522404a91.12.1725620791350; 
 Fri, 06 Sep 2024 04:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEun68m0khzH3vK+s/PDqSJS2gkQ7uO5i5F/tDCUW1MyqO5sSNVmqpItF7zgZWTCC3H1Poc4yPitYkFFsIeA5I=
X-Received: by 2002:a17:90b:68e:b0:2d8:a344:900d with SMTP id
 98e67ed59e1d1-2dad4ef4a5fmr2522381a91.12.1725620790911; Fri, 06 Sep 2024
 04:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-3-chrubis@suse.cz>
 <CAEemH2eQQfhTfVo5xrBHFjzuf4dn=VqK2M=9Y3+hy+r8yzMtAA@mail.gmail.com>
 <ZtrRCVxNKuu5ZdHN@yuki.lan>
 <CAEemH2d0h9t5iad82YSHu_yZto5ZXQ2TBF9Xs0Oq5jBrjTY5tg@mail.gmail.com>
In-Reply-To: <CAEemH2d0h9t5iad82YSHu_yZto5ZXQ2TBF9Xs0Oq5jBrjTY5tg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 6 Sep 2024 19:06:18 +0800
Message-ID: <CAEemH2ezY4WpbmV=YRAzWX5dfSqcn7U60a6Q1vQ5SXtcrMBjFQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/4] Add support for mixing C and shell code
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

T24gRnJpLCBTZXAgNiwgMjAyNCBhdCA2OjE54oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKPgo+Cj4gT24gRnJpLCBTZXAgNiwgMjAyNCBhdCA1OjU04oCvUE0gQ3lyaWwg
SHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgo+Cj4+IEhpIQo+PiA+IHRzdF90ZXN0LmM6
MTg2MDogVElORk86IExUUCB2ZXJzaW9uOiAyMDI0MDUyNAo+PiA+IHRzdF90ZXN0LmM6MTg2NDog
VElORk86IFRlc3RlZCBrZXJuZWw6IDYuOC4wLTEwMTAtcmFzcGkgIzExLVVidW50dSBTTVAKPj4g
PiBQUkVFTVBUX0RZTkFNSUMgVGh1IEF1ZyAgOCAyMzoyMjo0MSBVVEMgMjAyNCBhYXJjaDY0Cj4+
ID4gdHN0X3Rlc3QuYzoxNzAzOiBUSU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMHMK
Pj4gPiBzaGVsbF90ZXN0MDEuYzoxMTogVElORk86IEMgdGVzdCBleGl0cyBub3cKPj4gPiBVc2Fn
ZTogdHN0X3Jlc18gZmlsZW5hbWUgbGluZW5vIFtUUEFTU3xURkFJTHxUQ09ORnxUSU5GT3xUREVC
VUddICdBCj4+IHNob3J0Cj4+ID4gZGVzY3JpcHRpb24nCj4+ID4gdHN0X3Rlc3QuYzoxNTM1OiBU
QlJPSzogVGVzdCBoYXZlbid0IHJlcG9ydGVkIHJlc3VsdHMhCj4+ID4KPj4gPiBTdW1tYXJ5Ogo+
PiA+IHBhc3NlZCAgIDAKPj4gPiBmYWlsZWQgICAwCj4+ID4gYnJva2VuICAgMQo+PiA+IHNraXBw
ZWQgIDAKPj4gPiB3YXJuaW5ncyAwCj4+ID4KPj4gPgo+PiA+IEhlcmUgSSBnb3QgdGVzdCBmYWls
dXJlcyBvbiBteSBSUGk0IChiYXNoLTUuMi4yMSkgdGhhdCB0aGUgJExJTkVPTiBjYW4ndAo+PiA+
IGJlIHBhcnNlZCBjb3JyZWN0bHkuCj4+Cj4+IEFyZSB5b3Ugc3VyZSB0aGF0IHRoaXMgaXMgZHVl
IHRvIGJhc2g/IE15IGd1ZXNzIGlzIHRoYXQgb24gUlBpIHRoZQo+PiBkZWZhdWx0IHNoZWxsIGlz
IGRhc2ggYmVjYXVzZSBpdCdzIGRlYmlhbiBiYXNlZC4KPj4KPj4gSSB3aWxsIHRyeSB0byByZXBy
b2R1Y2UuCj4+Cj4+ID4gVGhlIHJlYXNvbiBwcm9iYWJseSBpcyBzb21lIHNoZWxscyBvciBzcGVj
aWZpYyB2ZXJzaW9ucyBtaWdodCBub3QgaGFuZGxlCj4+ID4gJExJTkVOTyBjb3JyZWN0bHkgd2l0
aGluIGFsaWFzZXMsIGVzcGVjaWFsbHkgd2hlbiB0aGUgbGluZSBudW1iZXIgbmVlZHMKPj4gPiB0
byBiZSBkeW5hbWljYWxseSBkZXRlcm1pbmVkLgo+PiA+Cj4+ID4gU28gSSBzdWdnZXN0IHVzaW5n
IGEgZnVuY3Rpb24gaW5zdGVhZCBvZiB0aGUgYWxpYXMuCj4+ID4KPj4gPgo+PiA+IC0tLSBhL3Rl
c3RjYXNlcy9saWIvdHN0X2Vudi5zaAo+PiA+ICsrKyBiL3Rlc3RjYXNlcy9saWIvdHN0X2Vudi5z
aAo+PiA+IEBAIC0yMSw1ICsyMSwxMiBAQCB0c3RfYnJrXygpCj4+ID4gICAgICAgICBlc2FjCj4+
ID4gIH0KPj4gPgo+PiA+IC1hbGlhcyB0c3RfcmVzPSJ0c3RfcmVzXyAkdHN0X3NjcmlwdF9uYW1l
IFwkTElORU5PIgo+PiA+IC1hbGlhcyB0c3RfYnJrPSJ0c3RfYnJrXyAkdHN0X3NjcmlwdF9uYW1l
IFwkTElORU5PIgo+PiA+ICt0c3RfcmVzKCkKPj4gPiArewo+PiA+ICsgICAgdHN0X3Jlc18gIiR0
c3Rfc2NyaXB0X25hbWUiICIkTElORU5PIiAiJEAiCj4+ID4gK30KPj4gPiArCj4+ID4gK3RzdF9i
cmsoKQo+PiA+ICt7Cj4+ID4gKyAgICB0c3RfYnJrXyAiJHRzdF9zY3JpcHRfbmFtZSIgIiRMSU5F
Tk8iICIkQCIKPj4gPiArfQo+Pgo+PiBUaGF0IGFjdHVhbGx5IGRvZXMgbm90IHdvcmsgYmVjYXVz
ZSB1bmxpa2UgdGhlIGFsaWFzIHRoZSAkTElORU5PIGlzCj4+IGV4cGFuZGVkIGluIHRoZSB3cm9u
ZyBwbGFjZSBhbmQgdGhlIGxpbmUgaXMgaW5jb3JyZWN0Lgo+Pgo+PiBUaGUgd2hvbGUgcmVhc29u
IGZvciB0aGlzIHRvIGJlIGFsaWFzIGlzIHRoYXQgaXQncyBleHBhbmRlZCBvbiB0aGUKPj4gY29y
cmVjdCBsaW5lIGluIHRoZSB0ZXN0IHNvdXJjZS4KPj4KPgo+IEFoLCB5b3UncmUgcmlnaHQsIEkg
d2Fzbid0IGF3YXJlIG9mIHRoYXQuCj4KPiBNYXliZSB3ZSBjYW4gdXNlIGEgdHJpY2sgd2l0aCBl
dmFsIHRvIGRlbGF5IHRoZSBleHBhbnNpb24KPiBvZiAkTElORU5PIHVudGlsIHRoZSBmdW5jdGlv
biBpcyBhY3R1YWxseSBjYWxsZWQ/Cj4KCkhtbSwgc2VlbXMgdGhpcyBpcyBhbHNvIG5vdCB3b3Jr
aW5nIGFzIGV4cGVjdGVkLiBQbGVhc2UgaWdub3JlLgoKJCBjYXQgbGl3YW5nLnNoCiMhL2Jpbi9i
YXNoCgpwcmludF9saW5lKCkgewogICAgZXZhbCAiZWNobyBcInRoaXMgaXMgbGluZTogXCRMSU5F
Tk9cIiIKfQoKZWNobyAiVGhpcyBpcyBsaW5lICRMSU5FTk8iCnByaW50X2xpbmUKCmxpd2FuZ0By
YXNwaTQ6fi9sdHAvdGVzdGNhc2VzL2xpYiQgLi9saXdhbmcuc2gKVGhpcyBpcyBsaW5lIDcKdGhp
cyBpcyBsaW5lOiA0Cgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
