Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DCFEE14D9
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 08:11:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CC623CC28B
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 10:11:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59B873C9F6B
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 05:03:44 +0200 (CEST)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E6AC12010F2
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 05:03:40 +0200 (CEST)
X-QQ-mid: bizesmtp89t1694055740t980m2vg
Received: from alvin ( [221.123.136.170]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 07 Sep 2023 11:02:18 +0800 (CST)
X-QQ-SSF: 00400000000000Z0Z000000A0000000
X-QQ-FEAT: 1IQQPTaFpROzBflLJvcbXcGAMXieq75J1f4WJFc/2pPDJ1FYQ1XLXZCWfAt6h
 xaD4oQEVnDykBOySJcJGXO5Lr3xB2Jep1K43gao2TRpSsSK5ZsVYk0uiRgDgH9OkMXdlRR1
 LxV2YT82ItyA+dGUmO2zX/CxGpctty1F5yD1+tMCvv0YbSmKJx2jORdHO5f1vbcxwxxhtE3
 GlM0572NZs3i44Uze8q9QNLxVZxvdaGvdqjQXMCH+a1xq2zeWk05NTB3W+tit1z3z7s2mSA
 djTqq58ypParaPmQaK6WL4iI8Brd8g4oKFJSM565hh4yOmsnhMMYIxaMRjvM2iWqoBbnzyu
 SAQ+5zu3Qc6kqcBeqkvygsH2xpVExAYq1+JwbBzJJCuAqE3kalBg4PTi9ptiQDk07dt1bkv
 lCBUWJfhw5uBTBTEjIDF1UAPgCjjhGwI
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11854986959529204909
Date: Thu, 7 Sep 2023 11:02:19 +0800
From: =?UTF-8?B?5p2O5Y2g5q2m?= <lizw@chinasupercloud.com>
To: "Li Wang" <liwang@redhat.com>
References: <927B643AA2DE0DEB+2023083114093400166120@chinasupercloud.com>, 
 <CAEemH2d=nhMThDZH3PsBNE9toXPjr5eQ+q52Sd_1iM48KB3AOw@mail.gmail.com>
X-Priority: 3
X-GUID: 3DCD9A53-9223-498B-8644-259408F7AEB7
X-Has-Attach: no
X-Mailer: Foxmail 7.2.23.121[cn]
Mime-Version: 1.0
Message-ID: <49DE213CC66246D3+202309071102186333789@chinasupercloud.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:chinasupercloud.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 07 Sep 2023 10:11:10 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] =?utf-8?b?5Zue5aSNOiBSZTogIFNlZWtpbmcgaGVscCB3aXRoIExUUCB0?=
 =?utf-8?q?esting_issues=2E?=
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

SGnvvIxMaSB3YW5nDQoNCuaIkeeahG1lc3NhZ2Xmr5TovoPlpKfvvIzlpoLmnpznuq/mlofmnKzk
uI3mmK/lvojlpb3liIbmnpANCg0KDQoNCktlbiAuTGkg5p2O5Y2g5q2mIHwg5pm6566X5Lqn5ZOB
5LqL5Lia6YOoDQrnlLXor53vvJoxODUxNDUyODg1Ng0K6YKu566x77yabGl6d0BjaGluYXN1cGVy
Y2xvdWQuY29tIA0K5a6Y572R77yaaHR0cDovL3d3dy5jaGluYXN1cGVyY2xvdWQuY29tDQrotoXk
upHmgLvpg6jvvJrljJfkuqzluILmmIzlubPljLrpsoHnloPot6815Y+3QeW6pzTlsYINCueglOWP
keS4reW/g++8muWMl+S6rOW4guS6puW6hOe7j+a1juaKgOacr+W8gOWPkeWMuuenkeWIm+WNgeWb
m+ihlzblj7fpmaIy5Y+35qW8M+Wxgg0KIA0KRnJvbTogTGkgV2FuZw0KRGF0ZTogMjAyMy0wOS0w
NSAwOTowOA0KVG86IOadjuWNoOatpg0KQ0M6IGx0cA0KU3ViamVjdDogUmU6IFtMVFBdIFNlZWtp
bmcgaGVscCB3aXRoIExUUCB0ZXN0aW5nIGlzc3Vlcy4NCkhpIFpoYW53dSwNCg0KSSBkaWRuJ3Qg
ZmluZCBhbnkgYXR0YWNobWVudHMgaGVyZSwgY2FuIHlvdSBwbGVhc2UgcmVjaGVjayBpZiB0aGUg
ZXJyb3IgbG9nIHVwbG9hZCB3YXMgc3VjY2Vzc2Z1bD8NCkJUVywgd2UgdHlwaWNhbGx5IHJlY29t
bWVuZCBwb3N0aW5nIHRoZSBlcnJvcnMgaW4gcGxhaW4gdGV4dC4NCg0KDQpPbiBNb24sIFNlcCA0
LCAyMDIzIGF0IDEwOjQ24oCvUE0g5p2O5Y2g5q2mIDxsaXp3QGNoaW5hc3VwZXJjbG91ZC5jb20+
IHdyb3RlOg0KV2UgYXJlIGEgc2VydmVyIG1hbnVmYWN0dXJlciB1c2luZyBMVFAgdGVzdGluZy4g
VGhlIGF0dGFjaG1lbnQgaXMgYW4gZXJyb3IgbG9nLiBQbGVhc2UgaGVscCB1cy4NCg0KDQpLZW4g
LkxpIOadjuWNoOatpiANCg0KDQotLSANCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cA0KDQoNCi0tIA0KUmVnYXJkcywNCkxpIFdhbmcNCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
