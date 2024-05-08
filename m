Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4137FC10F1A
	for <ltp@archiver.kernel.org>; Wed,  8 May 2024 02:29:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B2E83CDC2C
	for <ltp@archiver.kernel.org>; Wed,  8 May 2024 04:29:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 420EE3CD806
 for <ltp@lists.linux.it>; Wed,  8 May 2024 04:29:10 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=13.245.218.24; helo=smtpbg153.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 617D21A00EA5
 for <ltp@lists.linux.it>; Wed,  8 May 2024 04:29:07 +0200 (CEST)
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-FEAT: cIAm9Ti9Z0wwIqFVxQia/M0tAIjUQxfcFtHOTePdP0DyzqAyVDJ9nA5H4fioa
 UR9rK/Rejvv/5GP3olUKCnErx1+KphSEpWCMRUfX3ZW85kKjNAd4dnIJD3sRqn6QkxCYXtD
 Xwv2rqUpE/992Wnjprsquz8x72aXWhKryP7aZeYxmDvS1BLQ3kggtm171KB1JR0WoeP82pq
 tejAPohHvJoCo7kSYxgX5tC6h8CBsC3Gce25AQ3/lG7IVveWDHranLDAB1Ezy3Whi8KFTw2
 CEZU702RMMRwhvudNEP9UYtYHa7S95JSSm1uJiFLy3px/XFh+GZilMbcWv/+c04oUGkB9V5
 vVTJQ3/6Xr3QVqAxAC2wAOviLGFzK502+N1AzuyJ2fHNIzsWhzV4HX/mnlgUTKFBqJA7eVt
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: dgXQoQruKC5j057Wphi8dWquFMHY20TmhSWtXUDzkPU=
X-Originating-IP: 125.76.39.228
X-QQ-STYLE: 
X-QQ-mid: t5gz6a-3t1715135340t4009128
From: "=?utf-8?B?6Lev5paQ?=" <lufei@uniontech.com>
To: "=?utf-8?B?Q3lyaWwgSHJ1Ymlz?=" <chrubis@suse.cz>
Mime-Version: 1.0
Date: Wed, 8 May 2024 02:29:00 +0000
X-Priority: 3
Message-ID: <tencent_60EAD0C87B6992E152F29F11@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240506070336.2711930-2-lufei@uniontech.com>
 <20240507043235.1692-1-lufei@uniontech.com>
 <20240507043235.1692-2-lufei@uniontech.com> <ZjojkXpTTleALvrQ@yuki>
In-Reply-To: <ZjojkXpTTleALvrQ@yuki>
X-QQ-ReplyHash: 2604727230
X-BIZMAIL-ID: 14731648227307992163
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Wed, 08 May 2024 10:29:02 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-1
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Add case about arch_prctl syscall.
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
Cc: =?utf-8?B?bHRw?= <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksIEN5cmlsLiZuYnNwOw0KVGhhbmtzIGFnYWluIHZlcnkgbXVjaC4NCg0KDQpBcyB3cml0dGVu
IGluIG1hbiBwYWdlLCZuYnNwO0VOT0RFViBzZWVtcyBvbmx5IGZvciBBUkNIX1NFVF9DUFVJRCwg
c28gSSBkaWRuJ3QgdXNlIFRTVF9FWFBfRkFJTCBpbiBBUkNIX0dFVF9DUFVJRCBjaGVjay4gQVJD
SF9HRVRfQ1BVSUQgYWx3YXlzIHN1Y2Nlc3Mgd2l0aCByZXR1cm5pbmcgY3B1aWQgc3RhdHVzLCBJ
J3ZlIHRlc3RlZCB0aGlzIG9uIGEgSW50ZWwmbmJzcDtKMTkwMCBtYWNoaW5lIHdpdGNoIGhhcyBu
byBjcHVpZF9mYXVsdCBmbGFnLiBJJ3ZlIHJlc2VudCB0aGUgcGF0Y2guDQoNCkx1IEZlaQ0Kc2l0
Ze+8mnd3dy51bmlvbnRlY2guY29tDQp0ZWzvvJooKzg2KTE4NTAxMDEyMzUyDQphZGRyOiBYaSdh
biwgQ2hpbmEmbmJzcDsNCg0KDQoNCiZuYnNwOw0KJm5ic3A7DQotLS0tLS0tLS0tLS0tLS0tLS0m
bmJzcDtPcmlnaW5hbCZuYnNwOy0tLS0tLS0tLS0tLS0tLS0tLQ0KRnJvbTogJm5ic3A7IkN5cmls
Jm5ic3A7SHJ1YmlzIjxjaHJ1YmlzQHN1c2UuY3omZ3Q7Ow0KRGF0ZTogJm5ic3A7VHVlLCBNYXkg
NywgMjAyNCAxMjo1MSBQTQ0KVG86ICZuYnNwOyJsdWZlaSI8bHVmZWlAdW5pb250ZWNoLmNvbSZn
dDs7IA0KQ2M6ICZuYnNwOyJsdHAiPGx0cEBsaXN0cy5saW51eC5pdCZndDs7ICJqc3RhbmNlayI8
anN0YW5jZWtAcmVkaGF0LmNvbSZndDs7IA0KU3ViamVjdDogJm5ic3A7UmU6IFtQQVRDSF0gQWRk
IGNhc2UgYWJvdXQgYXJjaF9wcmN0bCBzeXNjYWxsLg0KDQombmJzcDsNCg0KSGkhDQomZ3Q7ICtz
dGF0aWMgdm9pZCBydW4odW5zaWduZWQgaW50IGluZGV4KQ0KJmd0OyArew0KJmd0OyArCXN0cnVj
dCB0Y2FzZSB0YyA9IHRjYXNlc1tpbmRleF07DQomZ3Q7ICsNCiZndDsgKwlURVNUKGFyY2hfcHJj
dGxfc2V0KEFSQ0hfU0VUX0NQVUlELCB0Yy5pbnB1dCkpOw0KJmd0OyArDQomZ3Q7ICsJaWYgKFRT
VF9SRVQgPT0gdGMuc2V0X2V4cCkNCiZndDsgKwkJaWYgKHRjLnNldF9leHAgPT0gLTEpDQomZ3Q7
ICsJCQl0c3RfcmVzKChUU1RfRVJSID09IHRjLnRzdF9lcnJubyA/IFRQQVNTIDogVEZBSUwpLA0K
Jmd0OyArCQkJCSJzZXQgY3B1aWQsIGV4cGVjdDogJXMsIGdldDogJXMiLA0KJmd0OyArCQkJCXRz
dF9zdHJlcnJubyh0Yy50c3RfZXJybm8pLA0KJmd0OyArCQkJCXRzdF9zdHJlcnJubyhUU1RfRVJS
KSk7DQomZ3Q7ICsJCWVsc2UNCiZndDsgKwkJCXRzdF9yZXMoVFBBU1MsICJzZXQgY3B1aWQgc3Vj
Y2VlZC4iKTsNCiZndDsgKwllbHNlDQomZ3Q7ICsJCXRzdF9yZXMoVEZBSUwsICJzZXQgY3B1aWQg
ZmFpbGVkLiIpOw0KDQpUaGlzIGlzIGtpbmQgb2YgdWdseSwgd2h5IGNhbid0IHdlIGp1c3QgZG86
DQoNCglpZiAodGFnKQ0KCQlUU1RfRVhQX1BBU1MoYXJjaF9wcmN0bF9zZXQoQVJDSF9TRVRfQ1BV
SUQsIGluZGV4KSk7DQoJZWxzZQ0KCQlUU1RfRVhQX0ZBSUwoYXJjaF9wcmN0bF9zZXQoQVJDSF9T
RVRfQ1BVSUQsIGluZGV4KSwgRU5PREVWKTsNCg0KJmd0OyArCVRFU1QoYXJjaF9wcmN0bF9nZXQo
QVJDSF9HRVRfQ1BVSUQpKTsNCiZndDsgKw0KJmd0OyArCWlmIChUU1RfUkVUID09IHRjLmdldF9l
eHApDQomZ3Q7ICsJCXRzdF9yZXMoVFBBU1MsICJnZXQgY3B1aWQgc3VjY2VlZC4iKTsNCiZndDsg
KwllbHNlDQomZ3Q7ICsJCXRzdF9yZXMoVEZBSUwsICJnZXQgY3B1aWQgZmFpbGVkLiIpOw0KDQoN
CldlIGhhdmUgdG8gY2hlY2sgdGhlIGVycm5vIGhlcmUgYXMgd2VsbCwganVzdCBicmFuY2ggb24g
dGhlIHRhZyBhcyB3ZWxsOg0KDQoJaWYgKHRhZykgew0KCQlURVNUKGFyY2hfcHJjdGxfZ2V0KEFS
Q0hfR0VUX0NQVUlEKSk7DQoNCgkJaWYgKFRTVF9SRVQgPT0gaW5kZXgpDQoJCQl0c3RfcmVzKFRQ
QVNTLCAiLi4uIik7DQoJCWVsc2UNCgkJCXRzdF9yZXMoRkFJTCwgIi4uLiIpOw0KCX0gZWxzZSB7
DQoJCVRTVF9FWFBfRkFJTChhcmNoX3ByY3RsX2dldChBUkNIX0dFVF9DUFVJRCksIEVOT0RFVik7
DQoJfQ0KDQpHZW5lcmFsbHkgdGhlIHVzZSBvZiBUU1RfRVhQX0ZBSUwoKSBpcyBwcmVmZXJlZCB3
aGVuZXZlciBwb3NzaWJsZS4NCg0KJmd0OyArfQ0KJmd0OyArDQomZ3Q7ICtzdGF0aWMgc3RydWN0
IHRzdF90ZXN0IHRlc3QgPSB7DQomZ3Q7ICsJLnRlc3QgPSBydW4sDQomZ3Q7ICsJLnNldHVwID0g
c2V0dXAsDQomZ3Q7ICsJLnRjbnQgPSBBUlJBWV9TSVpFKHRjYXNlcyksDQomZ3Q7ICsJLm1pbl9r
dmVyID0gIjQuMTIiLA0KJmd0OyArCS5zdXBwb3J0ZWRfYXJjaHMgPSAoY29uc3QgY2hhciAqY29u
c3QgW10peyJ4ODZfNjQiLCAieDg2IiwgTlVMTH0NCiZndDsgK307DQomZ3Q7ICsNCiZndDsgKyNl
bHNlIC8qIEhBVkVfQVNNX1BSQ1RMX0ggKi8NCiZndDsgK1RTVF9URVNUX1RDT05GKCJtaXNzaW5n
IDxhc20vcHJjdGwuaCZndDsiKTsNCiZndDsgKyNlbmRpZg0KJmd0OyAtLSANCiZndDsgMi4zOS4z
DQomZ3Q7IA0KDQotLSANCkN5cmlsIEhydWJpcw0KY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
