Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FCBC433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 03:11:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FFF93C93CE
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 04:11:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE2D43C937D
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 04:11:36 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E15C72009BF
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 04:11:34 +0100 (CET)
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JXwg30SCxz9s9D;
 Tue, 11 Jan 2022 11:10:23 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 11:11:29 +0800
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 11:11:29 +0800
Received: from kwepemm600017.china.huawei.com ([7.193.23.234]) by
 kwepemm600017.china.huawei.com ([7.193.23.234]) with mapi id 15.01.2308.020;
 Tue, 11 Jan 2022 11:11:29 +0800
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogW0xUUF0gW1BBVENIXSBhZGQgc2V2ZXJhbCBoYXNoIGFs?=
 =?gb2312?Q?gorithms_for_crypto/crypto=5Fuser02.c?=
Thread-Index: AQHYAkbUAbnBYvm/w0qKtx8VMJDdH6xboLvAgABn/oCAAQY6MP//le2AgACGzDA=
Date: Tue, 11 Jan 2022 03:11:29 +0000
Message-ID: <47cf20b2401542c58764858ff9763fc3@huawei.com>
References: <1641287729-194863-1-git-send-email-wenyehai@huawei.com>
 <YdW1m4D2wLYQm1v/@sol.localdomain>
 <0035845766004452880d56963135c616@huawei.com>
 <Ydxwc65JO2C057hm@sol.localdomain>
 <15b7314d82b547e997c0caca1ae1299c@huawei.com>
 <YdzzcTlQpn+BNRsi@sol.localdomain>
In-Reply-To: <YdzzcTlQpn+BNRsi@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.108.250]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?gb2312?b?tPC4tDogtPC4tDogtPC4tDogIFtQQVRDSF0gYWRkIHNl?=
 =?gb2312?b?dmVyYWwgaGFzaCBhbGdvcml0aG1zIGZvciBjcnlwdG8vY3J5cHRvX3VzZXIw?=
 =?gb2312?b?Mi5j?=
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQpIaSBFcmljOg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHByb21wdCByZXBseSBh
bmQgc3VnZ2VzdGlvbi4gSSB3aWxsIG1vZGlmeSBhbmQgZXhwbGFpbiB0aGlzIGluIG15IGNvbW1p
dCBtZXNzYWdlIGxhdGVyLg0KDQoNCkJlc3QgUmVnYXJkcw0KWWVoYWkgV2VuDQoNCi0tLS0t08q8
/tStvP4tLS0tLQ0Kt6K8/sjLOiBFcmljIEJpZ2dlcnMgW21haWx0bzplYmlnZ2Vyc0BrZXJuZWwu
b3JnXSANCreiy83KsbzkOiAyMDIyxOox1MIxMcjVIDExOjAzDQrK1bz+yMs6IHdlbnllaGFpIDx3
ZW55ZWhhaUBodWF3ZWkuY29tPg0Ks63LzTogbHRwQGxpc3RzLmxpbnV4Lml0DQrW98ziOiBSZTog
tPC4tDogtPC4tDogW0xUUF0gW1BBVENIXSBhZGQgc2V2ZXJhbCBoYXNoIGFsZ29yaXRobXMgZm9y
IGNyeXB0by9jcnlwdG9fdXNlcjAyLmMNCg0KT24gVHVlLCBKYW4gMTEsIDIwMjIgYXQgMDI6MTk6
MDVBTSArMDAwMCwgd2VueWVoYWkgd3JvdGU6DQo+IA0KPiBIaSBFcmljOg0KPiANCj4gVGhhbmsg
eW91IHZlcnkgbXVjaCBmb3IgeW91ciBraW5kIHJlcGx5LCBhbmQgYWxzbyBzb3JyeSBmb3IgY2F1
c2luZyB5b3UgY29uZnVzaW9uLiANCj4gQWN0dWFsbHksIEkgZG8gd2FudCB0byBnZXQgY3J5cHRv
X3VzZXIwMiB0byBydW4gaW4gbW9yZSBjYXNlcy4NCj4gDQo+IFRoZSBwcm9kdWN0IHdoaWNoIEkg
dGVzdGVkIGp1c3Qgb25seSBlbmFibGUgc2hhMyBhbGdvcml0aG0sIGJ1dCB3aGVuIEkgcnVuIGNy
eXRvX3VzZXIwMiwgaXQgdGVsbHMgIm5vIHZpYWJsZSBhbGdvcml0aG0gZm91bmQiLCBhcyBmb2xs
b3dzOg0KPiAuL2NyeXB0b191c2VyMDINCj4gdHN0X3Rlc3QuYzoxMzY1OiBUSU5GTzogVGltZW91
dCBwZXIgcnVuIGlzIDBoIDA1bSAwMHMNCj4gY3J5cHRvX3VzZXIwMi5jOjg0OiBUQ09ORjogTm8g
dmlhYmxlIGFsZ29yaXRobSBmb3VuZA0KPiANCj4gU3VtbWFyeToNCj4gcGFzc2VkICAgMA0KPiBm
YWlsZWQgICAwDQo+IGJyb2tlbiAgIDANCj4gc2tpcHBlZCAgMQ0KPiB3YXJuaW5ncyAwDQo+IA0K
PiANCj4gSSB3YW50IGNyeXB0b191c2VyMDIgdG8gc3VwcG9ydCBtb3JlIGNhc2VzKG5vdCBvbmx5
IHNoYTMpLCBidXQgSSBhbSANCj4gbm90IHN1cmUgd2hpY2ggYWxnb3JpdGhtcyBzaG91bGQgbGlz
dCwgc28gSSBjb21wYXJlIHdpdGggdGhlIGxhdGVzdCBsaW51eCBrZXJuZWwgZW5jcnlwdGlvbiBt
b2R1bGUsIGFkZCBzZXZlcmFsIGhhc2ggYWxnb3JpdGhtcyB3aGljaCBub3QgbGlzdCBpbiBjcnlw
dG9fdXNlcjAyLg0KDQpPa2F5LCBjYW4geW91IHBsZWFzZSBwcm9wZXJseSBleHBsYWluIHRoaXMg
aW4geW91ciBjb21taXQgbWVzc2FnZT8NCg0KVGhhbmtzIQ0KDQotIEVyaWMNCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
