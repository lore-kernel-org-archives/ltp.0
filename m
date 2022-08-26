Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CF5ECAAD2
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 08:57:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D5D73CA4D7
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 10:57:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BF663CA03B
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 10:56:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8E50F200903
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 10:56:53 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id DDFC733735;
 Fri, 26 Aug 2022 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661504212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLw0B19JwMDOReoiGstN1phfcvCwfrZXrqgh2M2PcZQ=;
 b=NIAddBs1AuUxymSVWPhMEITEAHQ9rx6D8l5TMaYsjolkrFl04tmxQC992MJ/5uhS4SGzEO
 2CCufIisC/7kGloThWK5Ggp+xXuJU71o9L7ZwTT7SCxNdv4AzvTKufo59cP92cvPoO7oUj
 X9jOARCFZt3P+vOPJNFk/HBcL57ezRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661504212;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLw0B19JwMDOReoiGstN1phfcvCwfrZXrqgh2M2PcZQ=;
 b=y+JlBVSFZPwn2GmiHqEgYDD4YVdlrqj3pHS4I2zS9mGJrjkEozh9mp1uiJ+lMRtxeMFcMQ
 JkxPwEEU+UU35EBw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A844C2C141;
 Fri, 26 Aug 2022 08:56:52 +0000 (UTC)
References: <20220824124017.14286-1-andrea.cervesato@suse.com>
 <87bks71nwg.fsf@suse.de> <d64a2ccf-ee24-d4cf-17a7-bd32556a9570@suse.com>
 <a369a07d-9401-0437-2647-9a5f1737b732@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Fri, 26 Aug 2022 09:50:19 +0100
In-reply-to: <a369a07d-9401-0437-2647-9a5f1737b732@suse.com>
Message-ID: <8735dj1iy3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite process_vm01 test using new LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sDQoNCkFuZHJlYSBDZXJ2ZXNhdG8gdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3
cml0ZXM6DQoNCj4gT24gOC8yNi8yMiAxMDo0MCwgQW5kcmVhIENlcnZlc2F0byB2aWEgbHRwIHdy
b3RlOg0KPj4gSGkhDQo+Pg0KPj4gT24gOC8yNi8yMiAwOTowNCwgUmljaGFyZCBQYWxldGhvcnBl
IHdyb3RlOg0KPj4+IEhlbGxvLA0KPj4+DQo+Pj4gQW5kcmVhIENlcnZlc2F0byB2aWEgbHRwIDxs
dHBAbGlzdHMubGludXguaXQ+IHdyaXRlczoNCj4+Pg0KPj4+PiAtc3RhdGljIHZvaWQgY21hX3Rl
c3RfaW52YWxpZF9wZXJtKHZvaWQpDQo+Pj4+ICtzdGF0aWMgdm9pZCB0ZXN0X2ludmFsaWRfcGVy
bSh2b2lkKQ0KPj4+PiDCoCB7DQo+Pj4+IMKgwqDCoMKgwqAgY2hhciBub2JvZHlfdWlkW10gPSAi
bm9ib2R5IjsNCj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcGFzc3dkICpsdHB1c2VyOw0KPj4+PiAt
wqDCoMKgIGludCBzdGF0dXM7DQo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IHByb2Nlc3Nfdm1fcGFy
YW1zICpwYXJhbXM7DQo+Pj4+IMKgwqDCoMKgwqAgcGlkX3QgY2hpbGRfcGlkOw0KPj4+PiDCoMKg
wqDCoMKgIHBpZF90IHBhcmVudF9waWQ7DQo+Pj4+IC3CoMKgwqAgaW50IHJldCA9IDA7DQo+Pj4+
ICvCoMKgwqAgaW50IHN0YXR1czsNCj4+Pj4gKw0KPj4+PiArwqDCoMKgIHRzdF9yZXMoVElORk8s
ICJUZXN0aW5nIGludmFsaWQgcGVybWlzc2lvbnMgb24gZ2l2ZW4gUElEIik7DQo+Pj4+IMKgIC3C
oMKgwqAgdHN0X3Jlc20oVElORk8sICJ0ZXN0X2ludmFsaWRfcGVybSIpOw0KPj4+PiDCoMKgwqDC
oMKgIHBhcmVudF9waWQgPSBnZXRwaWQoKTsNCj4+Pj4gLcKgwqDCoCBjaGlsZF9waWQgPSBmb3Jr
KCk7DQo+Pj4+IC3CoMKgwqAgc3dpdGNoIChjaGlsZF9waWQpIHsNCj4+Pj4gLcKgwqDCoCBjYXNl
IC0xOg0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgdHN0X2Jya20oVEJST0sgfCBURVJSTk8sIGNsZWFu
dXAsICJmb3JrIik7DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBicmVhazsNCj4+Pj4gLcKgwqDCoCBj
YXNlIDA6DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBsdHB1c2VyID0gZ2V0cHduYW0obm9ib2R5X3Vp
ZCk7DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAobHRwdXNlciA9PSBOVUxMKQ0KPj4+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB0c3RfYnJrbShUQlJPSyB8IFRFUlJOTywgTlVMTCwgImdldHB3
bmFtIGZhaWxlZCIpOw0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgU0FGRV9TRVRVSUQoTlVMTCwgbHRw
dXNlci0+cHdfdWlkKTsNCj4+Pj4gLQ0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgcGFyYW1zID0gY21h
X2FsbG9jX3NhbmVfcGFyYW1zKCk7DQo+Pj4+ICvCoMKgwqAgY2hpbGRfcGlkID0gU0FGRV9GT1JL
KCk7DQo+Pj4+ICvCoMKgwqAgaWYgKCFjaGlsZF9waWQpIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IGx0cHVzZXIgPSBTQUZFX0dFVFBXTkFNKG5vYm9keV91aWQpOw0KPj4+PiArwqDCoMKgwqDCoMKg
wqAgU0FGRV9TRVRVSUQobHRwdXNlci0+cHdfdWlkKTsNCj4+Pj4gKw0KPj4+PiArwqDCoMKgwqDC
oMKgwqAgcGFyYW1zID0gYWxsb2NfcGFyYW1zKCk7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBw
YXJhbXMtPnBpZCA9IHBhcmVudF9waWQ7DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBjbWFfdGVzdF9w
YXJhbXMocGFyYW1zKTsNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldCB8PSBjbWFfY2hlY2tfcmV0
KC0xLCBURVNUX1JFVFVSTik7DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXQgfD0gY21hX2NoZWNr
X2Vycm5vKEVQRVJNKTsNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGNtYV9mcmVlX3BhcmFtcyhwYXJh
bXMpOw0KPj4+PiAtwqDCoMKgwqDCoMKgwqAgZXhpdChyZXQpOw0KPj4+PiAtwqDCoMKgIGRlZmF1
bHQ6DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBTQUZFX1dBSVRQSUQoY2xlYW51cCwgY2hpbGRfcGlk
LCAmc3RhdHVzLCAwKTsNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmICghV0lGRVhJVEVEKHN0YXR1
cykgfHwgV0VYSVRTVEFUVVMoc3RhdHVzKSAhPSAwKQ0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB0c3RfcmVzbShURkFJTCwgImNoaWxkIHJldHVybnMgJWQiLCBzdGF0dXMpOw0KPj4+PiAr
wqDCoMKgwqDCoMKgwqAgdGVzdF9wYXJhbXMocGFyYW1zKTsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IFRTVF9FWFBfRVFfTEkoVFNUX1JFVCwgLTEpOw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgY2hlY2tf
ZXJybm8oRVBFUk0pOw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgZnJlZV9wYXJhbXMocGFyYW1zKTsN
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4+Pj4gwqDCoMKgwqDCoCB9DQo+Pj4+ICsN
Cj4+Pj4gK8KgwqDCoCBTQUZFX1dBSVRQSUQoY2hpbGRfcGlkLCAmc3RhdHVzLCAwKTsNCj4+PiBX
ZSB3YW50IHRvIHVzZSB0c3RfcmVhcF9jaGlsZHJlbigpIGhlcmUgd2hpY2ggd2lsbCBjaGVjayB0
aGUgZXhpdA0KPj4+IHN0YXR1cy4NCj4+Pg0KPj4+IEluIGZhY3QsIGlmIFNBRkVfV0FJVFBJRCBp
cyByZW1vdmVkIGFsdG9nZXRoZXIgdGhlbiB0aGUgZXhpdCBzdGF0dXMgd2lsbA0KPj4+IGJlIGNo
ZWNrZWQgYXV0b21hdGljYWxseSBhdCB0aGUgZW5kIG9mIHRoZSB0ZXN0IHdoZW4gdGhlIGxpYiBj
YWxscw0KPj4+IHJlYXBfY2hpbGRyZW4uDQo+Pj4NCj4+PiBPdGhlcndpc2UgTEdUTSENCj4+Pg0K
Pj4gSXNuJ3QgdHN0X3JlYXBfY2hpbGRyZWFkKCkgYWxyZWFkeSBjYWxsZWQgYXQgdGhlIGVuZCBv
ZiB0aGUgdGVzdF9hbGwNCj4+IGZ1bmN0aW9uPyAodHN0X3Rlc3QuYzoxMzU0KQ0KPj4NCj4+IEFu
ZHJlYQ0KPj4NCj4+DQo+IFRoZSByZWFzb24gd2h5IEknbSB1c2luZyBTQUZFX1dBSVRQSUQgaGVy
ZSBpcyB0aGF0IHRoZXJlIGFyZSBtYW55DQo+IG90aGVyIHRlc3QgZnVuY3Rpb25zIGFuZCB3aGVu
IHRlc3RfaW52YWxpZF9wZXJtIGlzIGNhbGxlZCB3aXRob3V0IGl0LA0KPiB0aGUgdHN0X3JlcyBt
ZXNzYWdlcyBtaWdodCBjb21lIG91dCBhc3luY2hyb25vdXNseSB3aXRoIHRoZSBvdGhlcg0KPiB0
ZXN0cyBtZXNzYWdlcy4NCg0KSWYgYXN5bmNocm9ub3VzIG1lc3NhZ2VzIGFyZSBhIHByb2JsZW0g
dGhlbiB5b3UgY2FuIGV4cGxpY2l0bHkgY2FsbA0KdHN0X3JlYXBfY2hpbGRyZW4oKSBhZnRlciBm
b3JrLiBJZiB5b3UgdXNlIFNBRkVfV0FJVFBJRCB0aGVuIHlvdSBuZWVkIHRvDQpjaGVjayB0aGUg
ZXhpdCBzdGF0dXMgbWFudWFsbHksIGl0IHdvbid0IGdldCBjaGVja2VkIGxhdGVyIGJ5IHRoZSBj
YWxsDQp0byB0c3RfcmVhcF9jaGlsZHJlbiBpbiB0c3RfdGVzdC5jLiBCZWNhdXNlIHRoZSBjaGls
ZCBwcm9jZXNzIGhhcw0KYWxyZWFkeSBiZWVuIHJlYXBlZCBieSB3YWl0cGlkLg0KDQpJIGRvbid0
IGhhdmUgYSBzdHJvbmcgb3BpbmlvbiBvbiB3aGV0aGVyIGFzeW5jaHJvbm91cyBtZXNzYWdlcyBh
cmUgYQ0KcHJvYmxlbS4NCg0KLS0gDQpUaGFuayB5b3UsDQpSaWNoYXJkLg0KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
