Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38845C25B76
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 01:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717637757; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cFfbB3CJVUkrZgistIAJtamvcvIi0SdSsKprhiq7jgI=;
 b=n+2bGA4NAUdiqSVBUfBfPafv2rh2b0pD4nq1PujfjR1RXDY3jm35BTlz+pNV3eR5LQsQc
 2OTxIihgmGgv+Z4IBKCcGlCPB4aW4xB8VsWIuelcIQvPTGWEDRaMe+ji3Z5h+nB7pHmWbSC
 gj+S/v/Addw4/X9t4+MgJFvCtoK4W9M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66B0B3D09D7
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 03:35:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8DA43CE360
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 03:35:32 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CDF2E20091A
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 03:35:31 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5750a8737e5so7456a12.0
 for <ltp@lists.linux.it>; Wed, 05 Jun 2024 18:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717637731; x=1718242531; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XstpBdCJB6rOv9xYviMeI7PhINZj1LInLJ567BIoXNA=;
 b=QO9lTe+8cafFzQH5Im6YhKi49JJOrQyDZZF+Hw/xlxkmORcnJ4/HUQkKax1KVlnimw
 eLT87kC0Z1aj39T4522HzHhR26rYVR7TO/CtVQL61aBqFMi6/SaIZuu2L3drehylPe0V
 283jyNKRmJKCMPdmmzGSMAgjnb6vDP3C4E9Q+eYeSR8RxTZjaqeaJtaNardC7lIJWfs1
 0PJ35emHK13Soy27Cuah6+nJ18s5h80hUn9spFYD0hcEb/ChqfdYFlE1AXNmg3lI5Pdw
 Nali2kon4wB8IfXXSlEo9RvCK8s21zOsJxw3T90M2osgpMyvbujOQxJOyt3hO7VgtAO6
 UIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717637731; x=1718242531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XstpBdCJB6rOv9xYviMeI7PhINZj1LInLJ567BIoXNA=;
 b=GHYAv1BPXsn1ZeVM3PVANXjusBqQmX/HNnM+x/PQOSh+5xpjpHN1han/T6WuyhlKTO
 A7Bk9mk6hQ5rofVjDPZIe+7HDFVDf/EFbPNZWfkAAVYSUNZBsjVYIEMFmg0XHhyHlZ7K
 hrPyD0m3g9zuHfNK88JHYCmLyYQ2lv4MeysOvHL9OgwqgfGj3BlaobJ2TKJAom6eIb9D
 4omhD4+zoT916l9ZGBmeJ4SozDQ0dKQX/7SaptjmUuIYHQpXdGCoR1sKbHNJ2vDZqOjh
 BbuIH2dIgHjsnqsm9sa5LqFp90ISjNAb2aqTpaQMjZ5T991jC2/QveeSpRV/Wr6Kzkxh
 MfHg==
X-Gm-Message-State: AOJu0Yxki2DAAPgExRt5QFaqyXCz437aCiDxgQyurZlebjNK7Ma5ZXv/
 Eq8PlRb9s0Nms7aGNK7FK8wVf29HYgiTF0g7zZjM3xDuOsoYIH3nwMYonBhkcOr7jy1TrVaW0bd
 SW6qgCskRMaPBUQ08r/tNTlnT/WajvBJuP+YS9BEjqrnZgK7pBQ==
X-Google-Smtp-Source: AGHT+IGJrCtvWkKaalNiNuxY+gahLbyfPRdOfGGm/d5xc0lBcGSXT4Ne1zIZP8eLNg05cXzN0vaVIdexbvHKrTcCAsE=
X-Received: by 2002:a50:fb96:0:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57aa6e8e2e9mr109137a12.6.1717637730849; Wed, 05 Jun 2024
 18:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240605180536.1288027-1-edliaw@google.com>
 <ZmD3MwUF0gckTlo8@wegao.102.90.21>
In-Reply-To: <ZmD3MwUF0gckTlo8@wegao.102.90.21>
Date: Wed, 5 Jun 2024 18:35:04 -0700
Message-ID: <CAG4es9X1o+UCL_fD1M8=tNG=j-MO=5Npcexq8L=f_Jr7g97Y1A@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched/starvation: Choose from available cpus
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdW4gNSwgMjAyNCBhdCA0OjM54oCvUE0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+
IHdyb3RlOgo+Cj4gT24gV2VkLCBKdW4gMDUsIDIwMjQgYXQgMDY6MDU6MzZQTSArMDAwMCwgRWR3
YXJkIExpYXcgdmlhIGx0cCB3cm90ZToKPiA+IFVzZSB0aGUgZmlyc3QgYXZhaWxhYmxlIGNwdSBp
biB0aGUgc2NoZWRfZ2V0YWZmaW5pdHkgc2V0Lgo+ID4KPiA+IFRoaXMgdGVzdCB3YXMgZmFpbGlu
ZyBhcyBhIDMyYml0IHRlc3QgZm9yIHNvbWUgYXJtIGFyY2hpdGVjdHVyZXMgd2hlcmUKPiA+IGNw
dSAwIGRvZXMgbm90IHN1cHBvcnQgMzJiaXQgYXBwbGljYXRpb25zLgo+ID4KPiA+IFNpZ25lZC1v
ZmYtYnk6IEVkd2FyZCBMaWF3IDxlZGxpYXdAZ29vZ2xlLmNvbT4KPiA+IC0tLQo+ID4gIC4uLi9r
ZXJuZWwvc2NoZWQvY2ZzLXNjaGVkdWxlci9zdGFydmF0aW9uLmMgICAgIHwgMTcgKysrKysrKysr
KysrKysrKy0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2Nmcy1zY2hl
ZHVsZXIvc3RhcnZhdGlvbi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zY2hlZC9jZnMtc2NoZWR1bGVy
L3N0YXJ2YXRpb24uYwo+ID4gaW5kZXggZWI5ZmQ2ZmY1Li5lMGVhMzBkMTkgMTAwNjQ0Cj4gPiAt
LS0gYS90ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2Nmcy1zY2hlZHVsZXIvc3RhcnZhdGlvbi5jCj4g
PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2Nmcy1zY2hlZHVsZXIvc3RhcnZhdGlvbi5j
Cj4gPiBAQCAtNDksMTMgKzQ5LDI4IEBAIGFnYWluOgo+ID4gIHN0YXRpYyB2b2lkIHNldHVwKHZv
aWQpCj4gPiAgewo+ID4gICAgICAgY3B1X3NldF90IG1hc2s7Cj4gPiArICAgICBpbnQgY3B1ID0g
MDsKPiA+ICsgICAgIGxvbmcgbmNwdXMgPSB0c3RfbmNwdXNfY29uZigpOwo+ID4KPiA+ICAgICAg
IENQVV9aRVJPKCZtYXNrKTsKPiA+Cj4gPiAtICAgICBDUFVfU0VUKDAsICZtYXNrKTsKPiA+ICsg
ICAgIC8qIFJlc3RyaWN0IHRlc3QgdG8gYSBzaW5nbGUgY3B1ICovCj4gPiArICAgICBUU1RfRVhQ
X1BPU0lUSVZFKHNjaGVkX2dldGFmZmluaXR5KDAsIHNpemVvZihtYXNrKSwgJm1hc2spKTsKPiBz
L1RTVF9FWFBfUE9TSVRJVkUvVFNUX0VYUF9QQVNTCgpXaWxsIGRvLgoKPiA+ICsKPiA+ICsgICAg
IGlmIChDUFVfQ09VTlQoJm1hc2spID09IDApCj4gPiArICAgICAgICAgICAgIHRzdF9icmsoVENP
TkYsICJObyBjcHVzIGF2YWlsYWJsZSIpOwo+IEkgc3VwcG9zZSB0aGlzIHNob3VsZCBhIGJ1ZyBo
YXBwZW4gaWYgY3B1IGNvdW50IGlzIDAsIHNvIGkgc3VnZ2VzdAo+IHMvVENPTkYvVEJST0suIFdo
YXQgZG8geW91IHRoaW5rPwoKWWVhaCB0aGF0IG1ha2VzIG1vcmUgc2Vuc2UuICBXaWxsIHNlbmQg
YSB2Mi4KCj4KPiA+ICsKPiA+ICsgICAgIHdoaWxlIChDUFVfSVNTRVQoY3B1LCAmbWFzaykgPT0g
MCAmJiBjcHUgPCBuY3B1cykKPiA+ICsgICAgICAgICAgICAgY3B1Kys7Cj4gPiArCj4gPiArICAg
ICBDUFVfWkVSTygmbWFzayk7Cj4gPiArCj4gPiArICAgICBDUFVfU0VUKGNwdSwgJm1hc2spOwo+
ID4KPiA+ICAgICAgIFRTVF9FWFBfUE9TSVRJVkUoc2NoZWRfc2V0YWZmaW5pdHkoMCwgc2l6ZW9m
KG1hc2spLCAmbWFzaykpOwo+IHMvVFNUX0VYUF9QT1NJVElWRS9UU1RfRVhQX1BBU1MKPiA+Cj4g
PiArICAgICB0c3RfcmVzKFRJTkZPLCAiU2V0IGFmZmluaXR5IHRvIENQVSAlZCIsIGNwdSk7Cj4g
PiArCj4gPiAgICAgICBpZiAodHN0X3BhcnNlX2xvbmcoc3RyX2xvb3AsICZsb29wLCAxLCBMT05H
X01BWCkpCj4gPiAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0ssICJJbnZhbGlkIG51bWJlciBv
ZiBsb29wIG51bWJlciAnJXMnIiwgc3RyX2xvb3ApOwo+ID4KPiBPdGhlcnMgTEdUTS4gVGhhbmtz
IGZvciB5b3VyIG5pY2UgcGF0Y2ghCgpUaGFua3MhCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
