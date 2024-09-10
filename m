Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A725CECE564
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 06:50:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5C563C1A86
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 08:50:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B91C03C0F5F
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 08:50:26 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9BC56600F1A
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 08:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725951023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IWXgKGHki+Am0L7+B2BJ90vbUuPhy4wpuaXd5qPorUc=;
 b=Q1ll2nKZJ3+uRJPDAqgMUX/kWLqbU7dmrjUmCmWZsBNwu06T1Wj5QI63GYQbSUw1wA5toG
 tViAV1SyW65arYXI0VGlNEeXKzko4eB7wuVfao1LYPXttNXrKMQS14f4OpNnsJD6XEQIq5
 XjHM2SpLsle10w0M6pt6kTZwJ2sOAUY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-o-F7GsYRNiqDCCKWpddpag-1; Tue, 10 Sep 2024 02:50:20 -0400
X-MC-Unique: o-F7GsYRNiqDCCKWpddpag-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7179469744dso769816b3a.2
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 23:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725951019; x=1726555819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IWXgKGHki+Am0L7+B2BJ90vbUuPhy4wpuaXd5qPorUc=;
 b=c5iH0hGsZSJS2Urt33xvdOPsl/nFfxu8hzGmQ70Ir7qdwVAUwBkmpq2Pp408BOTyyi
 s7L5DugA7s8LbuBiZsICIUyU2ToTJNq6YNgcTLgN0J3HNwJKZb55j3IZtrP+wD3taMlE
 pLw6PXKiRFacR/+Lo1KbNvgVhGevX01xW3sY4FycgEYsT1mmaCCcHEgz7LuWfxKxLYe/
 DTnuQ4wgLRrRK5QRP1FZ8J58DShG7+Bwfk5EG8ErfFBHBd0/3dShbuCYRoyR663mkujD
 tWLmuvnO0CNx0XVV0ZRfCrSlNLegGmxZAkpPojOB5jmnfzJmv3p42WJJ645uuA89+n4v
 6MmQ==
X-Gm-Message-State: AOJu0YweMyXL2rCtY3CnkDWuA6eGTXbElc12j8uJXTZlwJuuTrX5BCQz
 wLLelaGbBX8WnLdRCp1aiIMd0DEWL3WIemKcDRXRQgFD3GrKY9OxbjD9sEPb20uc8sJ6gL44ghz
 jg28wh+nbk9Wq9j7ckMpp3xRNVc/4YeXKWfPeY8X5BshLCjbptVRgTS51HHn50hoaBNd8NgGGMV
 dp3P5BICyRhOfcTgp1XXCWa+4ZTMxXU5xBt82+
X-Received: by 2002:a05:6a00:23d4:b0:70b:cf1:8dc9 with SMTP id
 d2e1a72fcca58-718e3491e3dmr13928310b3a.25.1725951018813; 
 Mon, 09 Sep 2024 23:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbQNl/3SqsynBJZhlbV36JMZLe3hteaKbRfuR7mhM0wJezZwdF/tNTPt4T4RHYdK6cbVEYcYt0PHf6KbQesq4=
X-Received: by 2002:a05:6a00:23d4:b0:70b:cf1:8dc9 with SMTP id
 d2e1a72fcca58-718e3491e3dmr13928287b3a.25.1725951018107; Mon, 09 Sep 2024
 23:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240801135023.22125-1-andrea.cervesato@suse.de>
In-Reply-To: <20240801135023.22125-1-andrea.cervesato@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 10 Sep 2024 14:50:05 +0800
Message-ID: <CAEemH2dFuA3WMrCSfADsfJjOTehJhcRn7CwkJoMzBvYeNHnkGQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] Add rename15 test
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

T24gVGh1LCBBdWcgMSwgMjAyNCBhdCA5OjUw4oCvUE0gQW5kcmVhIENlcnZlc2F0byA8YW5kcmVh
LmNlcnZlc2F0b0BzdXNlLmRlPgp3cm90ZToKCj4gRnJvbTogQW5kcmVhIENlcnZlc2F0byA8YW5k
cmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0By
ZWRoYXQuY29tPgoKCj4gVGhpcyB0ZXN0IGhhcyBiZWVuIGV4dHJhY3RlZCBmcm9tIHN5bWxpbmsw
MSBhbmQgaXQgdmVyaWZpZXMgdGhhdAo+IHJlbmFtZSgpIGlzIHdvcmtpbmcgY29ycmVjdGx5IG9u
IHN5bWxpbmsoKSBnZW5lcmF0ZWQgZmlsZXMsIHJlbmFtaW5nCj4gc3ltYm9saWMgbGluayBhbmQg
Y2hlY2tpbmcgaWYgc3RhdCgpIGluZm9ybWF0aW9uIGFyZSBwcmVzZXJ2ZWQuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+IC0t
LQo+IC0gdHN0X3RtcGRpcl9wYXRoL3RzdF90bXBkaXJfbWtwYXRoIHVzYWdlCj4gLSB1c2UgYWJz
b2x1dGUgcGF0aHMKPiAtIGFkZCBhbGxfZmlsZXN5c3RlbXMgPSAxCj4KPiAgcnVudGVzdC9zeXNj
YWxscyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQo+ICB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3JlbmFtZS8uZ2l0aWdub3JlIHwgICAxICsKPiAgdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9yZW5hbWUvcmVuYW1lMTUuYyB8IDEwOSArKysrKysrKysrKysrKysrKysrKwo+
ICAzIGZpbGVzIGNoYW5nZWQsIDExMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3JlbmFtZS9yZW5hbWUx
NS5jCj4KPiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxscyBiL3J1bnRlc3Qvc3lzY2FsbHMK
PiBpbmRleCA5YjNjYmE2NjcuLjYwMjhjNTdjMyAxMDA2NDQKPiAtLS0gYS9ydW50ZXN0L3N5c2Nh
bGxzCj4gKysrIGIvcnVudGVzdC9zeXNjYWxscwo+IEBAIC0xMTczLDcgKzExNzMsNiBAQCByZW1v
dmV4YXR0cjAxIHJlbW92ZXhhdHRyMDEKPiAgcmVtb3ZleGF0dHIwMiByZW1vdmV4YXR0cjAyCj4K
PiAgcmVuYW1lMDEgcmVuYW1lMDEKPiAtcmVuYW1lMDFBIHN5bWxpbmswMSAtVCByZW5hbWUwMQo+
ICByZW5hbWUwMyByZW5hbWUwMwo+ICByZW5hbWUwNCByZW5hbWUwNAo+ICByZW5hbWUwNSByZW5h
bWUwNQo+IEBAIC0xMTg2LDYgKzExODUsNyBAQCByZW5hbWUxMSByZW5hbWUxMQo+ICByZW5hbWUx
MiByZW5hbWUxMgo+ICByZW5hbWUxMyByZW5hbWUxMwo+ICByZW5hbWUxNCByZW5hbWUxNAo+ICty
ZW5hbWUxNSByZW5hbWUxNQo+Cj4gICNyZW5hbWVhdCB0ZXN0IGNhc2VzCj4gIHJlbmFtZWF0MDEg
cmVuYW1lYXQwMQo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3JlbmFt
ZS8uZ2l0aWdub3JlCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3JlbmFtZS8uZ2l0aWdu
b3JlCj4gaW5kZXggZjk1Y2Y3ZDIxLi5kMTdiODBmMDkgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9yZW5hbWUvLmdpdGlnbm9yZQo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvcmVuYW1lLy5naXRpZ25vcmUKPiBAQCAtMTEsMyArMTEsNCBAQAo+ICAvcmVu
YW1lMTIKPiAgL3JlbmFtZTEzCj4gIC9yZW5hbWUxNAo+ICsvcmVuYW1lMTUKPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZW5hbWUvcmVuYW1lMTUuYwo+IGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9yZW5hbWUvcmVuYW1lMTUuYwo+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0Cj4gaW5kZXggMDAwMDAwMDAwLi4yMzQ2MzI4NzkKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZW5hbWUvcmVuYW1lMTUuYwo+IEBAIC0wLDAgKzEs
MTA5IEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4g
Ky8qCj4gKyAqIENvcHlyaWdodCAoYykgMjAwMCBTaWxpY29uIEdyYXBoaWNzLCBJbmMuICBBbGwg
UmlnaHRzIFJlc2VydmVkLgo+ICsgKiAgICBBdXRob3JzOiBEYXZpZCBGZW5uZXIsIEpvbiBIZW5k
cmlja3Nvbgo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgQW5kcmVhIENlcnZlc2F0byBhbmRyZWEu
Y2VydmVzYXRvQHN1c2UuY29tCj4gKyAqLwo+ICsKPiArLypcCj4gKyAqIFtEZXNjcmlwdGlvbl0K
PiArICoKPiArICogVGhpcyB0ZXN0IHZlcmlmaWVzIHRoYXQgcmVuYW1lKCkgaXMgd29ya2luZyBj
b3JyZWN0bHkgb24gc3ltbGluaygpCj4gKyAqIGdlbmVyYXRlZCBmaWxlcy4KPiArICovCj4gKwo+
ICsjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiArI2luY2x1ZGUgInRzdF90bXBkaXIuaCIKPiArCj4g
KyNkZWZpbmUgTU5UUE9JTlQgIm1udCIKPiArI2RlZmluZSBPTEROQU1FIE1OVFBPSU5UIi9tc3lt
bGluazAiCj4gKyNkZWZpbmUgTkVXTkFNRSBNTlRQT0lOVCIvYXN5bWxpbmswIgo+ICsjZGVmaW5l
IE9CSk5BTUUgTU5UUE9JTlQiL29iamVjdCIKPiArCj4gK3N0YXRpYyBjaGFyICp0bXBkaXI7Cj4g
K3N0YXRpYyBjaGFyICpvbGRuYW1lOwo+ICtzdGF0aWMgY2hhciAqbmV3bmFtZTsKPiArc3RhdGlj
IGNoYXIgKm9iam5hbWU7Cj4gKwo+ICtzdGF0aWMgdm9pZCB0ZXN0X2V4aXN0aW5nKHZvaWQpCj4g
K3sKPiArICAgICAgIHRzdF9yZXMoVElORk8sICJUZXN0IHJlbmFtZSgpIG9uIHN5bWxpbmsgcG9p
bnRpbmcgdG8gYW4gZXhpc3RlbnQKPiBwYXRoIik7Cj4gKwo+ICsgICAgICAgc3RydWN0IHN0YXQg
b2xkc3ltX3N0YXQ7Cj4gKyAgICAgICBzdHJ1Y3Qgc3RhdCBuZXdzeW1fc3RhdDsKPiArCj4gKyAg
ICAgICBTQUZFX1NZTUxJTksodG1wZGlyLCBvbGRuYW1lKTsKPiArICAgICAgIFNBRkVfU1RBVChv
bGRuYW1lLCAmb2xkc3ltX3N0YXQpOwo+ICsKPiArICAgICAgIFNBRkVfUkVOQU1FKG9sZG5hbWUs
IG5ld25hbWUpOwo+ICsgICAgICAgU0FGRV9TVEFUKG5ld25hbWUsICZuZXdzeW1fc3RhdCk7Cj4g
Kwo+ICsgICAgICAgVFNUX0VYUF9FUV9MSShvbGRzeW1fc3RhdC5zdF9pbm8sIG5ld3N5bV9zdGF0
LnN0X2lubyk7Cj4gKyAgICAgICBUU1RfRVhQX0VRX0xJKG9sZHN5bV9zdGF0LnN0X2RldiwgbmV3
c3ltX3N0YXQuc3RfZGV2KTsKPiArCj4gKyAgICAgICBTQUZFX1VOTElOSyhuZXduYW1lKTsKPiAr
fQo+ICsKPiArc3RhdGljIHZvaWQgdGVzdF9ub25fZXhpc3Rpbmcodm9pZCkKPiArewo+ICsgICAg
ICAgdHN0X3JlcyhUSU5GTywgIlRlc3QgcmVuYW1lKCkgb24gc3ltbGluayBwb2ludGluZyB0byBh
Cj4gbm9uLWV4aXN0ZW50IHBhdGgiKTsKPiArCj4gKyAgICAgICBzdHJ1Y3Qgc3RhdCBwYXRoX3N0
YXQ7Cj4gKwo+ICsgICAgICAgU0FGRV9TWU1MSU5LKCJ0aGlzX3BhdGhfZG9lc250X2V4aXN0Iiwg
b2xkbmFtZSk7Cj4gKyAgICAgICBUU1RfRVhQX0ZBSUwoc3RhdChvbGRuYW1lLCAmcGF0aF9zdGF0
KSwgRU5PRU5UKTsKPiArCj4gKyAgICAgICBTQUZFX1JFTkFNRShvbGRuYW1lLCBuZXduYW1lKTsK
PiArICAgICAgIFRTVF9FWFBfRkFJTChzdGF0KG5ld25hbWUsICZwYXRoX3N0YXQpLCBFTk9FTlQp
Owo+ICsKPiArICAgICAgIFNBRkVfVU5MSU5LKG5ld25hbWUpOwo+ICt9Cj4gKwo+ICtzdGF0aWMg
dm9pZCB0ZXN0X2NyZWF0KHZvaWQpCj4gK3sKPiArCj4gKyAgICAgICB0c3RfcmVzKFRJTkZPLCAi
VGVzdCByZW5hbWUoKSBvbiBzeW1saW5rIHBvaW50aW5nIHRvIGEgcGF0aAo+IGNyZWF0ZWQgbGF0
ZWx5Iik7Cj4gKwo+ICsgICAgICAgc3RydWN0IHN0YXQgcGF0aF9zdGF0Owo+ICsKPiArICAgICAg
IFNBRkVfU1lNTElOSyhvYmpuYW1lLCBvbGRuYW1lKTsKPiArICAgICAgIFRTVF9FWFBfRkFJTChz
dGF0KG9sZG5hbWUsICZwYXRoX3N0YXQpLCBFTk9FTlQpOwo+ICsKPiArICAgICAgIHRzdF9yZXMo
VElORk8sICJDcmVhdGUgb2JqZWN0IGZpbGUiKTsKPiArCj4gKyAgICAgICBpbnQgZmQ7Cj4gKwo+
ICsgICAgICAgZmQgPSBTQUZFX0NSRUFUKG9iam5hbWUsIDA3MDApOwo+ICsgICAgICAgaWYgKGZk
ID49IDApCj4gKyAgICAgICAgICAgICAgIFNBRkVfQ0xPU0UoZmQpOwo+ICsKPiArICAgICAgIFNB
RkVfUkVOQU1FKG9sZG5hbWUsIG5ld25hbWUpOwo+ICsgICAgICAgVFNUX0VYUF9QQVNTKHN0YXQo
bmV3bmFtZSwgJnBhdGhfc3RhdCkpOwo+ICsKPiArICAgICAgIFNBRkVfVU5MSU5LKG9iam5hbWUp
Owo+ICsgICAgICAgU0FGRV9VTkxJTksobmV3bmFtZSk7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lk
IHJ1bih2b2lkKQo+ICt7Cj4gKyAgICAgICB0ZXN0X2V4aXN0aW5nKCk7Cj4gKyAgICAgICB0ZXN0
X2NyZWF0KCk7Cj4gKyAgICAgICB0ZXN0X25vbl9leGlzdGluZygpOwo+ICt9Cj4gKwo+ICtzdGF0
aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICt7Cj4gKyAgICAgICB0bXBkaXIgPSB0c3RfdG1wZGlyX3Bh
dGgoKTsKPiArICAgICAgIG9sZG5hbWUgPSB0c3RfdG1wZGlyX21rcGF0aChPTEROQU1FKTsKPiAr
ICAgICAgIG5ld25hbWUgPSB0c3RfdG1wZGlyX21rcGF0aChORVdOQU1FKTsKPiArICAgICAgIG9i
am5hbWUgPSB0c3RfdG1wZGlyX21rcGF0aChPQkpOQU1FKTsKPiArfQo+ICsKPiArc3RhdGljIHN0
cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICsgICAgICAgLnNldHVwID0gc2V0dXAsCj4gKyAgICAg
ICAudGVzdF9hbGwgPSBydW4sCj4gKyAgICAgICAuYWxsX2ZpbGVzeXN0ZW1zID0gMSwKPiArICAg
ICAgIC5tbnRwb2ludCA9IE1OVFBPSU5ULAo+ICsgICAgICAgLmZvcm1hdF9kZXZpY2UgPSAxLAo+
ICsgICAgICAgLm5lZWRzX3Jvb3QgPSAxLAo+ICt9Owo+IC0tCj4gMi40My4wCj4KPgo+IC0tCj4g
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4K
PgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
