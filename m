Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A15EE14D3
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 03:22:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F7D93CEA02
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 05:21:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 292AB3C89B6
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 05:21:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CBE2E60142A
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 05:21:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694056906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J9FsgLZmOrEKKCRJ8sZT2Y1r/PR1BgFYoQitewYL0zI=;
 b=SUqfBzJnd4YhSSgZZDLjyDTP+UgJI1zsiE6COet1mZ3QLcHkCbbMi2ygyNTG/jHBuk/Dyz
 MEW2Q2OiAiCCaV4S86H9p0F5Rpzm8HFQvng9ALqGPwPUv58Us7dOqvFqaa6clAcIU32N0h
 DCqGBMhD6grSmzHbtFoyd24PB8rRsfY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-JAndWa3nNuiUeVwYa2Qmqg-1; Wed, 06 Sep 2023 23:21:44 -0400
X-MC-Unique: JAndWa3nNuiUeVwYa2Qmqg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bcdd6ba578so6268001fa.3
 for <ltp@lists.linux.it>; Wed, 06 Sep 2023 20:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694056902; x=1694661702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9FsgLZmOrEKKCRJ8sZT2Y1r/PR1BgFYoQitewYL0zI=;
 b=BPWl1rWkv0xwN3/kdTbRvaGiEm4AylNKeWwqE8O+j2jngm8BzmKYZ9GWEmFkq7UdSc
 sTq10KqDFApENuPhloYZkGI50NeoH+oj9NyXqEI3t4bdFUbrACmwKSSU+UXMql2TK3fz
 WDnVp4xOiQVdRbaC4OxoQQuADAqqrohGzyH8BQ/H7nV1zsgPwMBMEyWi7yDJXxcQC4h8
 YBHwLw5kgPCd5UmRqYQiiNqcP4IICZQ5nDrsQ2Oae2RzykGK4Cf6pQvZOTeDCbTh5h/t
 Xb7pI2uQLSY0UhwPViwRHtVu7AvKhIISRPQWqRHWfgDtkFB3e/SxHAq3ZrWuZptOCxdQ
 WDPQ==
X-Gm-Message-State: AOJu0YwL4pwdbR/C0GSvDY9RLi6moeVZBeM/4dbHyX83g0qmXI5SBcEv
 zSmf/q751XrbSPO/7JeVkz35e7fD8fPkTutVJANkm2zbXI+cTE2MiUF3iBANHpXyhgnkB8Onm3H
 zqBCEFhxQfWxjMs8Kp3t2/qxyB+OQ7UT/AhoC4QwZ
X-Received: by 2002:a2e:b168:0:b0:2bd:d34:d98a with SMTP id
 a8-20020a2eb168000000b002bd0d34d98amr3491749ljm.44.1694056901853; 
 Wed, 06 Sep 2023 20:21:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi1XwMKppYQJHRfAglB7RtDtAFkt40gcZ8c5rtKt3Kprtq9D3cHOzNURxxDqhya7gxKQptjABN1JBDiRJ3a+Q=
X-Received: by 2002:a2e:b168:0:b0:2bd:d34:d98a with SMTP id
 a8-20020a2eb168000000b002bd0d34d98amr3491745ljm.44.1694056901386; Wed, 06 Sep
 2023 20:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <927B643AA2DE0DEB+2023083114093400166120@chinasupercloud.com>
 <CAEemH2d=nhMThDZH3PsBNE9toXPjr5eQ+q52Sd_1iM48KB3AOw@mail.gmail.com>
 <49DE213CC66246D3+202309071102186333789@chinasupercloud.com>
In-Reply-To: <49DE213CC66246D3+202309071102186333789@chinasupercloud.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 7 Sep 2023 11:21:29 +0800
Message-ID: <CAEemH2e_DOOQ-BFFRqY_GmMzWHE-uay6TMBy0UPJXnqdW1TiZw@mail.gmail.com>
To: =?UTF-8?B?5p2O5Y2g5q2m?= <lizw@chinasupercloud.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Seeking help with LTP testing issues.
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
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T2theSwgZmVlbCBmcmVlIHRvIGF0dGFjaCB0aGUgZXJyb3IgbG9ncywgYW5kIGJldHRlciBkZXNj
cmliZSB0aGUNCnByb2JsZW0gKGUuZyB0ZXN0IEhXLCAgYXJjaCwga2VybmVsIHZlcnNpb24sIExU
UCB2ZXJzaW9uLCBldGMpIGluDQpFbmdsaXNoIHRvIGd1YXJhbnRlZSBldmVyeW9uZSBpbiBNTCBj
b3VsZCByZWFkLg0KDQpPbiBUaHUsIFNlcCA3LCAyMDIzIGF0IDExOjAz4oCvQU0g5p2O5Y2g5q2m
IDxsaXp3QGNoaW5hc3VwZXJjbG91ZC5jb20+IHdyb3RlOg0KDQo+IEhp77yMTGkgd2FuZw0KPg0K
PiDmiJHnmoRtZXNzYWdl5q+U6L6D5aSn77yM5aaC5p6c57qv5paH5pys5LiN5piv5b6I5aW95YiG
5p6QDQo+DQoNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICpLZW4gLkxpIOad
juWNoOatpiogfCDmmbrnrpfkuqflk4HkuovkuJrpg6gNCj4gKueUteivne+8mjE4NTE0NTI4ODU2
Kg0KPiAq6YKu566x77yaKmxpendAY2hpbmFzdXBlcmNsb3VkLmNvbQ0KPiAq5a6Y572R77yaKmh0
dHA6Ly93d3cuY2hpbmFzdXBlcmNsb3VkLmNvbQ0KPiDotoXkupHmgLvpg6jvvJrljJfkuqzluILm
mIzlubPljLrpsoHnloPot6815Y+3QeW6pzTlsYINCj4g56CU5Y+R5Lit5b+D77ya5YyX5Lqs5biC
5Lqm5bqE57uP5rWO5oqA5pyv5byA5Y+R5Yy656eR5Yib5Y2B5Zub6KGXNuWPt+mZojLlj7fmpbwz
5bGCDQo+DQo+DQo+ICpGcm9tOiogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+DQo+ICpEYXRl
OiogMjAyMy0wOS0wNSAwOTowOA0KPiAqVG86KiDmnY7ljaDmraYgPGxpendAY2hpbmFzdXBlcmNs
b3VkLmNvbT4NCj4gKkNDOiogbHRwIDxsdHBAbGlzdHMubGludXguaXQ+DQo+ICpTdWJqZWN0Oiog
UmU6IFtMVFBdIFNlZWtpbmcgaGVscCB3aXRoIExUUCB0ZXN0aW5nIGlzc3Vlcy4NCj4gSGkgWmhh
bnd1LA0KPg0KPiBJIGRpZG4ndCBmaW5kIGFueSBhdHRhY2htZW50cyBoZXJlLCBjYW4geW91IHBs
ZWFzZSByZWNoZWNrIGlmIHRoZSBlcnJvcg0KPiBsb2cgdXBsb2FkIHdhcyBzdWNjZXNzZnVsPw0K
PiBCVFcsIHdlIHR5cGljYWxseSByZWNvbW1lbmQgcG9zdGluZyB0aGUgZXJyb3JzIGluIHBsYWlu
IHRleHQuDQo+DQo+DQo+IE9uIE1vbiwgU2VwIDQsIDIwMjMgYXQgMTA6NDbigK9QTSDmnY7ljaDm
raYgPGxpendAY2hpbmFzdXBlcmNsb3VkLmNvbT4gd3JvdGU6DQo+DQo+PiBXZSBhcmUgYSBzZXJ2
ZXIgbWFudWZhY3R1cmVyIHVzaW5nIExUUCB0ZXN0aW5nLiBUaGUgYXR0YWNobWVudCBpcyBhbg0K
Pj4gZXJyb3IgbG9nLiBQbGVhc2UgaGVscCB1cy4NCj4+DQo+Pg0KPj4gS2VuIC5MaSDmnY7ljaDm
raYNCj4+DQo+Pg0KPj4gLS0NCj4+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cA0KPj4NCj4NCj4NCj4gLS0NCj4gUmVnYXJkcywNCj4gTGkgV2Fu
Zw0KPg0KPg0KDQotLSANClJlZ2FyZHMsDQpMaSBXYW5nDQoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
