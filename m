Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2EFC433EF
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 11:44:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6B7E3C902A
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 12:44:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AAB13C8FD8
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 12:43:58 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C8B4F1A01761
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 12:43:56 +0100 (CET)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J4Yxp6gn5zbj99;
 Thu,  2 Dec 2021 19:43:42 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 19:43:51 +0800
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 19:43:50 +0800
Received: from kwepemm600017.china.huawei.com ([7.193.23.234]) by
 kwepemm600017.china.huawei.com ([7.193.23.234]) with mapi id 15.01.2308.020;
 Thu, 2 Dec 2021 19:43:50 +0800
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Thread-Topic: [LTP] [PATCH] bugfix for vmsplice/vmsplice02.c
Thread-Index: AQHX5k/bAxJxWNLwK0SkcIcUQxLt5awfEPRg
Date: Thu, 2 Dec 2021 11:43:50 +0000
Message-ID: <d9027c09a742427fab990dd0156b5cf3@huawei.com>
References: <1637972238-105160-1-git-send-email-wenyehai@huawei.com>
 <61A6CAD9.8030102@fujitsu.com>
In-Reply-To: <61A6CAD9.8030102@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.108.250]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?gb2312?b?tPC4tDogIFtQQVRDSF0gYnVnZml4IGZvciB2bXNwbGlj?=
 =?gb2312?b?ZS92bXNwbGljZTAyLmM=?=
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
From: wenyehai via ltp <ltp@lists.linux.it>
Reply-To: wenyehai <wenyehai@huawei.com>
Cc: wenyehai via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgWWFuZyBYdToNCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBraW5kIHN1Z2dlc3Rp
b25zLg0KDQpJIGhhZCBjaGVjayB3aXRoIGNvbW1hbmQgImdpdCBncmVwICJmY250bC5oIiwgdGhl
IHJlc3VsdCBzaG93cyB0aGF0IHRoZXJlIGFyZSAxMDIwIGxpbmVzIHVzZWQgImZjbnRsLmgiLCBh
bmQgbW9kaWZpZWQgMzQgdGVzdGNhc2VzIGludm9sdmVkIHdpdGggdGhlIGZvbGxvd2luZyBwYXRj
aDoNCg0KMDAwMS1idWdmaXgtZm9yLXRlc3RjYXNlcy13aGljaC13aXRoLWR1cGxpY2F0ZS1oZWFk
ZXItZmlsLnBhdGNoDQoNClN1YmplY3Q6IFtMVFBdW1BBVENIIHYyXSBidWdmaXggZm9yIHRlc3Rj
YXNlcyB3aGljaCB3aXRoIGR1cGxpY2F0ZSBoZWFkZXIgZmlsZXMNCg0KDQpCZXN0IFJlZ2FyZHMN
ClllaGFpIFdlbg0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogeHV5YW5nMjAxOC5qeUBm
dWppdHN1LmNvbSBbbWFpbHRvOnh1eWFuZzIwMTguanlAZnVqaXRzdS5jb21dIA0Kt6LLzcqxvOQ6
IDIwMjHE6jEy1MIxyNUgOTowNw0KytW8/sjLOiB3ZW55ZWhhaSA8d2VueWVoYWlAaHVhd2VpLmNv
bT4NCrOty806IHdlbnllaGFpIHZpYSBsdHAgPGx0cEBsaXN0cy5saW51eC5pdD4NCtb3zOI6IFJl
OiBbTFRQXSBbUEFUQ0hdIGJ1Z2ZpeCBmb3Igdm1zcGxpY2Uvdm1zcGxpY2UwMi5jDQoNCkhpIHdl
bg0KPiB2bXNwbGljZS92bXNwbGljZTAyOiBSZW1vdmUgZHVwbGljYXRlIGhlYWRlciBmaWxlcyBm
Y250bC5oLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZZWhhaSBXZW48d2VueWVoYWlAaHVhd2VpLmNv
bT4NCj4gLS0tDQo+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy92bXNwbGljZS92bXNwbGlj
ZTAyLmMgfCAxIC0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy92bXNwbGljZS92bXNwbGljZTAyLmMg
DQo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy92bXNwbGljZS92bXNwbGljZTAyLmMNCj4g
aW5kZXggMzljNDA3Yy4uM2RjNjIzZiAxMDA2NDQNCj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy92bXNwbGljZS92bXNwbGljZTAyLmMNCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy92bXNwbGljZS92bXNwbGljZTAyLmMNCj4gQEAgLTIwLDcgKzIwLDYgQEANCj4gICAj
aW5jbHVkZTxzeXMvc3RhdC5oPg0KPiAgICNpbmNsdWRlPGZjbnRsLmg+DQo+ICAgI2luY2x1ZGU8
dW5pc3RkLmg+DQo+IC0jaW5jbHVkZTxmY250bC5oPg0KPiAgICNpbmNsdWRlPHN5cy91aW8uaD4N
Cj4gICAjaW5jbHVkZTxsaW1pdHMuaD4NCkFjdHVhbGx5LCBsYXBpL2ZjbnRsLmggaGFzIGluY2x1
ZGVkIGZjbnRsLmgsIHNvIHRoZSBsYXR0ZXIgZmNubHQuaCBhbHNvIGNhbiBiZSByZW1vdmVkLg0K
DQpJdCBsb29rcyBsdHAgb3RoZXIgcGxhY2VzIGFsc28gZXhpc3QgdGhpcyBkdXBsaWNhdGUgaGVh
ZGVyIGZpbGVzIGZjbnRsLmggYmVjYXVzZSBvZiBsYXBpL2ZjbnRsLmguIEkgdGhpbmsgd2Ugc2hv
dWxkIHJlbW92ZSBmY250bC5oIGZvciB0aGVzZSBjYXNlcyB3aGVuIHRoZW0gdXNlIGxhcGkvZmNu
dGwuaC4NCg0KWW91IGNhbiB1c2UgImdpdCBncmVwICJmY250bC5oIiAiIGNtZCB0byBzZWFyY2gg
dGhlbS4NCg0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUNCj4NCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
