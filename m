Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784FFC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 02:19:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F15833C9402
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 03:19:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 092303C87B6
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 03:19:13 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E64AB6008F9
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 03:19:10 +0100 (CET)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JXvRl3nfRz1FCb0;
 Tue, 11 Jan 2022 10:15:31 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 10:19:05 +0800
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 10:19:05 +0800
Received: from kwepemm600017.china.huawei.com ([7.193.23.234]) by
 kwepemm600017.china.huawei.com ([7.193.23.234]) with mapi id 15.01.2308.020;
 Tue, 11 Jan 2022 10:19:05 +0800
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: =?gb2312?B?tPC4tDogW0xUUF0gW1BBVENIXSBhZGQgc2V2ZXJhbCBoYXNoIGFsZ29yaXRo?=
 =?gb2312?Q?ms_for_crypto/crypto=5Fuser02.c?=
Thread-Index: AQHYAkbUAbnBYvm/w0qKtx8VMJDdH6xboLvAgABn/oCAAQY6MA==
Date: Tue, 11 Jan 2022 02:19:05 +0000
Message-ID: <15b7314d82b547e997c0caca1ae1299c@huawei.com>
References: <1641287729-194863-1-git-send-email-wenyehai@huawei.com>
 <YdW1m4D2wLYQm1v/@sol.localdomain>
 <0035845766004452880d56963135c616@huawei.com>
 <Ydxwc65JO2C057hm@sol.localdomain>
In-Reply-To: <Ydxwc65JO2C057hm@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.108.250]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?gb2312?b?tPC4tDogtPC4tDogIFtQQVRDSF0gYWRkIHNldmVyYWwg?=
 =?gb2312?b?aGFzaCBhbGdvcml0aG1zIGZvciBjcnlwdG8vY3J5cHRvX3VzZXIwMi5j?=
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

DQpIaSBFcmljOg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIGtpbmQgcmVwbHksIGFu
ZCBhbHNvIHNvcnJ5IGZvciBjYXVzaW5nIHlvdSBjb25mdXNpb24uIA0KQWN0dWFsbHksIEkgZG8g
d2FudCB0byBnZXQgY3J5cHRvX3VzZXIwMiB0byBydW4gaW4gbW9yZSBjYXNlcy4NCg0KVGhlIHBy
b2R1Y3Qgd2hpY2ggSSB0ZXN0ZWQganVzdCBvbmx5IGVuYWJsZSBzaGEzIGFsZ29yaXRobSwgYnV0
IHdoZW4gSSBydW4gY3J5dG9fdXNlcjAyLCBpdCB0ZWxscyAibm8gdmlhYmxlIGFsZ29yaXRobSBm
b3VuZCIsIGFzIGZvbGxvd3M6DQouL2NyeXB0b191c2VyMDINCnRzdF90ZXN0LmM6MTM2NTogVElO
Rk86IFRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwNW0gMDBzDQpjcnlwdG9fdXNlcjAyLmM6ODQ6IFRD
T05GOiBObyB2aWFibGUgYWxnb3JpdGhtIGZvdW5kDQoNClN1bW1hcnk6DQpwYXNzZWQgICAwDQpm
YWlsZWQgICAwDQpicm9rZW4gICAwDQpza2lwcGVkICAxDQp3YXJuaW5ncyAwDQoNCg0KSSB3YW50
IGNyeXB0b191c2VyMDIgdG8gc3VwcG9ydCBtb3JlIGNhc2VzKG5vdCBvbmx5IHNoYTMpLCBidXQg
SSBhbSBub3Qgc3VyZSB3aGljaCBhbGdvcml0aG1zIHNob3VsZCBsaXN0LCANCnNvIEkgY29tcGFy
ZSB3aXRoIHRoZSBsYXRlc3QgbGludXgga2VybmVsIGVuY3J5cHRpb24gbW9kdWxlLCBhZGQgc2V2
ZXJhbCBoYXNoIGFsZ29yaXRobXMgd2hpY2ggbm90IGxpc3QgaW4gY3J5cHRvX3VzZXIwMi4NCg0K
DQoNCkJlc3QgUmVnYXJkcw0KWWVoYWkgV2VuDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjL
OiBFcmljIEJpZ2dlcnMgW21haWx0bzplYmlnZ2Vyc0BrZXJuZWwub3JnXSANCreiy83KsbzkOiAy
MDIyxOox1MIxMcjVIDE6NDQNCsrVvP7Iyzogd2VueWVoYWkgPHdlbnllaGFpQGh1YXdlaS5jb20+
DQqzrcvNOiBsdHBAbGlzdHMubGludXguaXQNCtb3zOI6IFJlOiC08Li0OiBbTFRQXSBbUEFUQ0hd
IGFkZCBzZXZlcmFsIGhhc2ggYWxnb3JpdGhtcyBmb3IgY3J5cHRvL2NyeXB0b191c2VyMDIuYw0K
DQpPbiBNb24sIEphbiAxMCwgMjAyMiBhdCAwMzo1OTozOUFNICswMDAwLCB3ZW55ZWhhaSB3cm90
ZToNCj4gSGkgRXJpYzoNCj4gDQo+IA0KPiANCj4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91
ciBraW5kIHJlcGx5LCBhbmQgSSBhbSB2ZXJ5IHNvcnJ5IGZvciBub3QgDQo+IGRlc2NyaWJpbmcg
dGhlIGJhY2tncm91bmQgY2xlYXJseS4NCj4gDQo+IA0KPiANCj4gQWN0dWFsbHksIEkgd2FudGVk
IHRvIHRlc3QgdGhlIHNoYTMgYWxnb3JpdGhtIGluIGtlcm5lbCA1LjEwLCBidXQgDQo+IGNyeXB0
b191c2VyMDIuYyByZXR1cm4gIm5vIHZpYWJsZSBhbGdvcml0aG0gZm91bmQiIGFzIGZvbGxvd3M6
DQo+IA0KPiANCj4gDQo+IFtjaWQ6aW1hZ2UwMDEucG5nQDAxRDgwNjE4LjE0MzA2RjkwXQ0KPiAN
Cj4gDQo+IA0KPiBTbyBJIGFkZCBzaGEzIHRvIGNyeXB0b191c2VyMDIuYyBhbmQgcnVuIGFnYWlu
LCBhdCB0aGUgc2FtZSB0aW1lLCANCj4gYWNjb3JkaW5nIHRvIHRoZSBsYXRlc3QgbGludXgga2Vy
bmVsIGVuY3J5cHRpb24gbW9kdWxlLCBhZGQgc2V2ZXJhbCANCj4gaGFzaCBhbGdvcml0aG1zLCBh
cw0KPiBmb2xsb3dzOg0KPiANCj4gDQo+IA0KPiBbY2lkOmltYWdlMDAyLnBuZ0AwMUQ4MDYxOC5G
NzAyRDc5MF0NCg0KW0ZvciBjb21wYXRpYmlsaXR5IHdpdGggdGhlIG1haWxpbmcgbGlzdCwgcGxl
YXNlIHVzZSBwbGFpbiB0ZXh0IGVtYWlsIHdpdGhvdXQgaW1hZ2VzIC0tIHRoYW5rcyFdDQoNCkkg
c3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCBleGFjdGx5IHdoYXQgeW91J3JlIHRyeWluZyB0byBkby4g
IElmIHlvdSdyZSBqdXN0IHRyeWluZyB0byBnZXQgY3J5cHRvX3VzZXIwMiB0byBydW4gaW4gbW9y
ZSBjYXNlcywgdGhlbiB5b3VyIHBhdGNoIG1ha2VzIHNlbnNlLg0KSWYgb24gdGhlIG90aGVyIGhh
bmQgeW91J3JlIGFjdHVhbGx5IHRyeWluZyB0byBnZXQgdGhlIGtlcm5lbCB0byBpbnN0YW50aWF0
ZSBtb3JlIGFsZ29yaXRobXMgc28gdGhhdCB0aGVpciBpbi1rZXJuZWwgc2VsZi10ZXN0cyBhcmUg
cnVuLCB0aGF0IGlzICpub3QqIHRoZSBwdXJwb3NlIG9mIGNyeXB0b191c2VyMDI7IGEgbmV3IHRl
c3Qgc2hvdWxkIGJlIHdyaXR0ZW4gZm9yIHRoYXQgcHVycG9zZS4gIFRoZSB0ZXN0IGNvdWxkIHRy
eSB0byBpbnN0YW50aWF0ZSBhbGwgYWxnb3JpdGhtcyB3aGljaCBoYXZlIGluLWtlcm5lbCBzZWxm
LXRlc3RzLg0KDQotIEVyaWMNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
