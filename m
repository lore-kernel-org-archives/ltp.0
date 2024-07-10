Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702A0C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 06:13:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85D393D382F
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 08:13:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A3C93D381A
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 08:13:23 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3F7471000DEA
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 08:13:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fy3YTGxJAlwVmn1ECLxQH+yZPpJKSx26CBuhFZSK44M=;
 b=BsaoOTHpirO2xUwFNTRgIjiwg9pgKKXdcLt69+mMw5kLOojGcJXrD+uV7zXYnwdnB8ohbE
 b8DEICahrao0XklPOl4PIdgHM/4u7ZIUsnPXcDJNcbka0aXRquxDyCuk+yozyQmDrcWq0P
 UnwVqHjnabrNbOWVmoGxTCrC9aV15tc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-hBKNUAPkOeOG_JlzXlCocA-1; Wed, 10 Jul 2024 02:13:18 -0400
X-MC-Unique: hBKNUAPkOeOG_JlzXlCocA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-778702b9f8fso310025a12.1
 for <ltp@lists.linux.it>; Tue, 09 Jul 2024 23:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720591997; x=1721196797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fy3YTGxJAlwVmn1ECLxQH+yZPpJKSx26CBuhFZSK44M=;
 b=tFv7OUYrb2/lKjMA//Zt2qa/ZtFmu8smF8Mhv7iNKL3v8cd9PIqfxgQFi+1WB2P3V8
 W7gafAOMWoY3SvVU8TdAfXvOnNZxZdFzHmyd6HcQ7ZZCgb2uTsS32Jwv4QEHYeVc6OZc
 n6qQtWjYb+vhS9LqeZvH2zjtKnk0FFrBKpd4BxujSFHFYozIBVX5L+SegFaQ5zkhvcT6
 vSM97XPI0xXB0J0HAF+hL3g4Fc4y6iyRGB9XXrHs+c0T8HCQ4WXI89ATvei7ooIowL3N
 1NtnuxyU78thA7F1T85JJTQttb6Aie6x+xi69FM5dfdQm/VoDHbaEB0BxYP23SQCLnLC
 j0zg==
X-Gm-Message-State: AOJu0YzlnM/sjILO9vxzdJS18ws2krzGzdLXs0vcZhYaq56h01hC8Z/B
 fwSFPbZnHiKEOxI55py6+fw5yM8CczOBSHg+/J7FyqsYslORJliS1I7MdS0YkBxEaeXtVMZnVH8
 DoS1i4eCmULipkOS/2pzY/Gt5JqYiBW5I31vQ46PdsDT3g46qJDgqtbEFdAAeZKj8mYcmtdDVZN
 7K3cvIZ2JcWvgr6WBcIjUP6Z4=
X-Received: by 2002:a17:90b:2392:b0:2c2:d590:808e with SMTP id
 98e67ed59e1d1-2ca3a7d3a50mr6336127a91.13.1720591997613; 
 Tue, 09 Jul 2024 23:13:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWajTvE242qAYr2+CJ17gVSmbkw6s2M+/VYePv7laviPECiEkplpLB6YQUrSD9ehvm3aC2h4H8mTlQXmhey+Q=
X-Received: by 2002:a17:90b:2392:b0:2c2:d590:808e with SMTP id
 98e67ed59e1d1-2ca3a7d3a50mr6336098a91.13.1720591997084; Tue, 09 Jul 2024
 23:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240710032434.123315-1-shichen@redhat.com>
In-Reply-To: <20240710032434.123315-1-shichen@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 10 Jul 2024 14:13:04 +0800
Message-ID: <CAEemH2dKQGDst4074Pzz6b2aQDP4qdeuyVOnwY+ZYMh0BrDD=w@mail.gmail.com>
To: Shizhao Chen <shichen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] realtime/prio-preempt: take cpu isolation into
 consideration
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
Cc: Eder Zulian <ezulian@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgU2hpemhhbywKCk9uIFdlZCwgSnVsIDEwLCAyMDI0IGF0IDExOjI04oCvQU0gU2hpemhhbyBD
aGVuIDxzaGljaGVuQHJlZGhhdC5jb20+IHdyb3RlOgoKPiBCeSBkZWZhdWx0IHRoZSB0ZXN0IHN0
YXJ0cyBOLTEgYnVzeSB0aHJlYWRzIHRvIG1vbm9wb2xpemUgTi0xIGF2YWlsYWJsZQo+IENQVXMs
Cj4gd2hlcmUgTiBpcyB0aGUgbnVtYmVyIG9mIGFsbCBhdmFpbGFibGUgQ1BVcy4gSG93ZXZlciwg
d2hlbiBDUFUgaXNvbGF0aW9uIGlzCj4gYXBwbGllZCwgdGhpcyB3aWxsIGxlYWQgdG8gYSBoYW5n
IHNjZW5hcmlvIHdoZXJlIGFsbCBob3VzZWtlZXBpbmcgQ1BVcyBhcmUKPiBob2dnZWQgYXMgaXNv
bGF0ZWQgQ1BVcyBkbyBub3Qgc2hhcmUgdGhlIE4tMSBidXN5IHRocmVhZHMuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBTaGl6aGFvIENoZW4gPHNoaWNoZW5AcmVkaGF0LmNvbT4KPiAtLS0KPiAgLi4uL3Jl
YWx0aW1lL2Z1bmMvcHJpby1wcmVlbXB0L3ByaW8tcHJlZW1wdC5jICB8IDE4ICsrKysrKysrKysr
KysrKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvcmVhbHRpbWUvZnVuYy9wcmlvLXByZWVtcHQv
cHJpby1wcmVlbXB0LmMKPiBiL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3ByaW8tcHJlZW1wdC9w
cmlvLXByZWVtcHQuYwo+IGluZGV4IDliZDVlN2FkOC4uNzlkMjExNWE3IDEwMDY0NAo+IC0tLSBh
L3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3ByaW8tcHJlZW1wdC9wcmlvLXByZWVtcHQuYwo+ICsr
KyBiL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3ByaW8tcHJlZW1wdC9wcmlvLXByZWVtcHQuYwo+
IEBAIC01OSw2ICs1OSw3IEBACj4gICAqCj4KPiAqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KPgo+ICsj
ZGVmaW5lIF9HTlVfU09VUkNFCj4gICNpbmNsdWRlIDxzdGRpby5oPgo+ICAjaW5jbHVkZSA8c3Rk
bGliLmg+Cj4gICNpbmNsdWRlIDxzaWduYWwuaD4KPiBAQCAtMjg3LDYgKzI4OCwxNyBAQCB2b2lk
ICptYXN0ZXJfdGhyZWFkKHZvaWQgKmFyZykKPiAgICAgICAgIHJldHVybiBOVUxMOwo+ICB9Cj4K
PiAraW50IGdldF9udW1jcHVzKHZvaWQpCj4gK3sKPiArICAgICAgIGNwdV9zZXRfdCBtYXNrOwo+
ICsgICAgICAgQ1BVX1pFUk8oJm1hc2spOwo+ICsKPiArICAgICAgIC8qIEdldCB0aGUgbnVtYmVy
IG9mIGNwdXMgYWNjZXNzaWJsZSB0byB0aGUgY3VycmVudCBwcm9jZXNzICovCj4gKyAgICAgICBz
Y2hlZF9nZXRhZmZpbml0eShnZXRwaWQoKSwgc2l6ZW9mKG1hc2spLCAmbWFzayk7Cj4gKwo+ICsg
ICAgICAgcmV0dXJuIENQVV9DT1VOVCgmbWFzayk7Cj4gK30KCisKPiAgaW50IG1haW4oaW50IGFy
Z2MsIGNoYXIgKmFyZ3ZbXSkKPiAgewo+ICAgICAgICAgaW50IHByaV9ib29zdCwgbnVtY3B1czsK
PiBAQCAtMjk1LDEwICszMDcsMTAgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkK
PiAgICAgICAgIHBhc3NfY3JpdGVyaWEgPSBDSEVDS19MSU1JVDsKPiAgICAgICAgIHJ0X2luaXQo
ImhpbjoiLCBwYXJzZV9hcmdzLCBhcmdjLCBhcmd2KTsKPgo+IC0gICAgICAgbnVtY3B1cyA9IHN5
c2NvbmYoX1NDX05QUk9DRVNTT1JTX09OTE4pOwo+ICsgICAgICAgbnVtY3B1cyA9IGdldF9udW1j
cHVzKCk7Cj4KCk1heWJlIHdlIGNvdWxkIG1ha2UgdXNlIG9mIExUUCBsaWIgZnVuY3Rpb24gdHN0
X25jcHVzX2F2YWlsYWJsZSBkaXJlY3RseT8KU2VlbXMgdGhlIG5ldyBnZXRfbnVtY3B1cygpIGRp
ZCBhIGR1cCB3b3JrIG9uIHRoYXQuCgpPdGhlcndpc2UsIGxvb2tzIGdvb2QgdG8gbWUuCgoKPiAt
ICAgICAgIC8qIE1heCBuby4gb2YgYnVzeSB0aHJlYWRzIHNob3VsZCBhbHdheXMgYmUgbGVzcyB0
aGFuL2VxdWFsIHRoZQo+IG5vLiBvZiBjcHVzCj4gLSAgICAgICAgICBPdGhlcndpc2UsIHRoZSBi
b3ggd2lsbCBoYW5nICovCj4gKyAgICAgICAvKiBNYXggbm8uIG9mIGJ1c3kgdGhyZWFkcyBzaG91
bGQgYWx3YXlzIGJlIGxlc3MgdGhhbi9lcXVhbCB0aGUKPiBuby4gb2YKPiArICAgICAgICAgIGhv
dXNla2VlcGluZyBjcHVzLiBPdGhlcndpc2UsIHRoZSBib3ggd2lsbCBoYW5nICovCj4KPiAgICAg
ICAgIGlmIChydF90aHJlYWRzID09IC0xIHx8IHJ0X3RocmVhZHMgPiBudW1jcHVzKSB7Cj4gICAg
ICAgICAgICAgICAgIHJ0X3RocmVhZHMgPSBudW1jcHVzOwo+IC0tCj4gMi40NS4yCj4KPgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
