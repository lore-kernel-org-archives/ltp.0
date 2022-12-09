Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7BCC4332F
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 01:08:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C4823CC08C
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 02:08:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 832483C30A8
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 02:08:06 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0A35E600040
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 02:08:04 +0100 (CET)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NSt7m5PQ7zqSyh
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 09:03:48 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Dec 2022 09:08:00 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Fri, 9 Dec 2022 09:08:00 +0800
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] config.mk.in: build.sh: Add
 -Wno-missing-field-initializers to CFLAGS
Thread-Index: AdkLadQuwECPcMaNTVuIms+0YDQvZQ==
Date: Fri, 9 Dec 2022 01:08:00 +0000
Message-ID: <f276dc67c7234650835e3b859ec81204@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] config.mk.in: build.sh: Add
 -Wno-missing-field-initializers to CFLAGS
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
From: zhaogongyi via ltp <ltp@lists.linux.it>
Reply-To: zhaogongyi <zhaogongyi@huawei.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhDQoNCj4gDQo+IEhpIQ0KPiA+IEFkZCBDRkxBR1MgLVduby1taXNzaW5nLWZpZWxkLWluaXRp
YWxpemVycyB0byBzdXBwcmVzcyB0aGUgY29tcGlsYXRpb24NCj4gPiB3YXJuaW5ncyBsaWtlOg0K
PiA+DQo+ID4gYXV0b2dyb3VwMDEuYzo4NzoxOiB3YXJuaW5nOiBtaXNzaW5nIGluaXRpYWxpemVy
IGZvciBmaWVsZA0KPiA+IOKAmG5lZWRzX2NtZHPigJkgb2Yg4oCYc3RydWN0IHRzdF90ZXN04oCZ
IFstV21pc3NpbmctZmllbGQtaW5pdGlhbGl6ZXJzXSAgfTsNCj4gPiBeIEluIGZpbGUgaW5jbHVk
ZWQgZnJvbSBhdXRvZ3JvdXAwMS5jOjIxOjA6DQo+ID4gLi4vLi4vLi4vLi4vaW5jbHVkZS90c3Rf
dGVzdC5oOjMyNDoyMTogbm90ZTog4oCYbmVlZHNfY21kc+KAmSBkZWNsYXJlZCBoZXJlDQo+ID4g
ICBjb25zdCBjaGFyICpjb25zdCAqbmVlZHNfY21kczsNCj4gDQo+IFRoaXMgaXMgYWN0dWFsbHkg
Y2F1c2VkIGJ5IGEgZ2NjIGJ1ZyB0aGF0IGhhcyBiZWVuIGFscmVhZHkgZml4ZWQgc2VlOg0KPiAN
Cj4gaHR0cHM6Ly9nY2MuZ251Lm9yZy9idWd6aWxsYS9zaG93X2J1Zy5jZ2k/aWQ9ODQ2ODUNCg0K
VGhhbmsgeW91IGZvciB5b3VyIG5vdGljZS4NCg0KPiANCj4gQW5kIEkgZG8gbm90IHRoaW5rIHRo
YXQgaXQncyBhIGdvb2QgaWRlYSB0byB3b3JrIGFyb3VuZCBnY2Mgd2FybmluZ3MgaW4gb3VyDQo+
IGJ1aWxkIHN5c3RlbS4NCj4gDQoNCkkgaGF2ZW4ndCBwYWlkIGF0dGVudGlvbiB0byBvdGhlciB3
YXJuaW5nIG1lc3NhZ2VzIG5vdy4gTWF5YmUgdGhleSBzaG91bGQgYmUgaWdub3JlZCBhcyB3ZWxs
Lg0KDQoNClJlZ2FyZHMsDQpHb25neWkNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
