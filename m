Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D59C4345F
	for <ltp@archiver.kernel.org>; Sun, 28 Apr 2024 07:16:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F0943D03AD
	for <ltp@archiver.kernel.org>; Sun, 28 Apr 2024 09:16:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AF853C0343
 for <ltp@lists.linux.it>; Sun, 28 Apr 2024 09:16:31 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=18.194.254.142; helo=smtpbgeu2.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 624291000998
 for <ltp@lists.linux.it>; Sun, 28 Apr 2024 09:16:19 +0200 (CEST)
X-QQ-FEAT: WrHAvg6vvPLBXliPgUK6/jbjfod+8UQSydVyzkqoVOb4F8vrh55RAsv03F2Go
 ksPGC+jXFFG4o/oqEuB0eMq5ytDuq1hhE1W8yyp8iJzbcbkkhecJz4QmJEQGoVx+Y2bRlPl
 c4fj9jUiOaRs8k5yIwPqpW/EoQLWEb50TXoe+AfFSyaXQUVQQOy8T/7o/Ud7aLh3kpq9NQu
 lvq1v+fN1ff/YCl6nE1GapUnc+v2m+SOO+suk5DEcwVc63IhDGLyqnJIcG3Dhvcn+T7de8B
 oOGRBgcoyzQRTo6k6b7fTjcPjNf7EkaE6ru754D3X/uApcbnZdPbKrbJUcvm4ZVQJqvhtsW
 d7TC2kNVd6ac2GkxJH+Bmequl1HHB5CtvaHfxMSPxy7SWfRaJqkVULd9FrGfw==
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-WAPMAIL: 1
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 3AFDznxqsFIqdj518BKXTqRsb29mhYrkDDstidY2Cx0=
X-Originating-IP: 223.104.44.240
References: <tencent_048887541FB562D43FE2D104@qq.com>
X-QQ-STYLE: 
X-QQ-mid: cset2gz6a-0t1714288570t71f34d
From: "=?gb18030?B?wrfssw==?=" <lufei@uniontech.com>
To: "=?gb18030?B?Q3lyaWwgSHJ1Ymlz?=" <chrubis@suse.cz>
Mime-Version: 1.0
Date: Sun, 28 Apr 2024 15:16:09 +0800
X-Priority: 3
Message-ID: <tencent_2EA161BC4D09C87A5126A494@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 348657175
X-BIZMAIL-ID: 15521827400658996240
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Sun, 28 Apr 2024 15:16:12 +0800 (CST)
Feedback-ID: cset:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] (no subject)
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
Cc: =?gb18030?B?bHRw?= <ltp@lists.linux.it>
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SXShr3MgZmF1bHQgaW4gbXkgY29kZS4gc3VwcG9ydGVkX2FyY2hzIGp1c3Qgd29ya3MgZmluZS4N
Cg0KDQpTb3JyeS4NCiANCg0KIAktLS0tLS0tLS0tUmVwbHkgdG8gTWVzc2FnZS0tLS0tLS0tLS0N
CiAJT24gRnJpLCBBcHIgMjYsIDIwMjQgNjozMCBQTSBDeXJpbCBIcnViaXMgPGNocnViaXNAc3Vz
ZS5jeiZndDsgd3JvdGU6DQogICAgICAJCUhpIQ0KJmd0OyBJIHRyaWVkIHVzaW5nIE5VTEwsIGJ1
dCBtZXQgYFRCUk9LOiBUZXN0IGtpbGxlZCBieSBTSUdTRUdWIWAuJmFtcDtuYnNwOw0KDQpUaGF0
IG1lYW5zIHRoYXQgdGhlIG1hbnVhbCBwYWdlIGlzIHdyb25nIGFuZCB0aGUgYWRkcmVzcyBpcyBu
b3QgaWdub3JlZC4NCg0KJmd0OyBBbmQgdGhlIGxhc3QgdGltZSB5b3UgbWVudGlvbmVkIGluIHJl
c3BvbnNlIHRvIHVzaW5nDQomZ3Q7IGBzdXBwb3J0ZWRfYXJjaHNgLCB0aGlzIHNlZW1zIG5vdCB3
b3JrIHByb3Blcmx5IGJ5IG5vdywgdGhlIGx0cA0KJmd0OyBkb2N1bWVudChzZWN0aW9uIG9mIHdy
aXRpbmdfdGVzdHMpIHNheXMgIm5vdCBhcHBsaWNhYmxlIi4NCg0KVGhlIHN1cHBvcnRlZF9hcmNo
cyBpcyBzdXBwb3NlZCB0byB3b3JrLiBIb3cgZGlkIHlvdSBzZXQgaXQgKHRoZSB2YWx1ZSkNCmFu
ZCB3aGF0IGhhcHBlbmVkPw0KDQotLSANCkN5cmlsIEhydWJpcw0KY2hydWJpc0BzdXNlLmN6Cgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
