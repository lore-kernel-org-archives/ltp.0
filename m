Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE68EE14D4
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 08:11:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAA1C3CB659
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 10:11:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDB113C89B6
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 05:09:24 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 931E91002035
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 05:09:16 +0200 (CEST)
X-QQ-mid: bizesmtp66t1694056067t68lbcgv
Received: from alvin ( [221.123.136.170]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 07 Sep 2023 11:06:43 +0800 (CST)
X-QQ-SSF: 00400000000000Z0Z000000A0000000
X-QQ-FEAT: g1rbK8vEaOppnOK4dQ1jjGB9s58dlZdQb65Q9ypan0GJEf0RFvZxDRqzm9Y++
 JhzULr12I+sqUvW9sejtzjD9/BPUq0k7RKfXst28UEXXM31a5oWVoijL+eqrLzQ9AiSiQv5
 MPbGCB82o6h/TLmV+dJRrQBvJWHD580BW/jb0JmFkTWaIWy09wwgW7Ljs2ghFHO207S0DKS
 HQUPWLszokbCXrByd3w4659M2VBU898GYeaTYMxR92l2uzsJea/JUNxdIybHM9IcKtmRIvq
 csM35kR0BVGlFAEWzMm4o4nNWaxJb6AWSTar3RH5M7wT3D6IyV1lezcFmfM5AMenRd2/XOS
 KaH0FuTDRL7LT86brLK6OqSG1BtilS7ANEpJ6FrYlnqTYLtXTC+F763SBvA1ulkeZGTlvou
 rtOPbJ+sL8W8fzSk+nchphGskOo4NVOOdlkllKCNdxsWUON2DJ5CQtJGyfM1RS4f
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 542788317696206224
Date: Thu, 7 Sep 2023 11:06:44 +0800
From: =?UTF-8?B?5p2O5Y2g5q2m?= <lizw@chinasupercloud.com>
To: "Li Wang" <liwang@redhat.com>
References: <927B643AA2DE0DEB+2023083114093400166120@chinasupercloud.com>, 
 <CAEemH2d=nhMThDZH3PsBNE9toXPjr5eQ+q52Sd_1iM48KB3AOw@mail.gmail.com>, 
 <202309071102186333789@chinasupercloud.com>
X-Priority: 3
X-GUID: 05B0D72A-C47A-4DF3-8D21-8C84481F177D
X-Has-Attach: yes
X-Mailer: Foxmail 7.2.23.121[cn]
Mime-Version: 1.0
Message-ID: <051BD971F24442CE+2023090711064291937510@chinasupercloud.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:chinasupercloud.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 07 Sep 2023 10:11:10 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] =?utf-8?b?5Zue5aSNOiDlm57lpI06ICBTZWVraW5nIGhlbHAgd2l0aCBM?=
 =?utf-8?q?TP_testing_issues=2E?=
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

SGnvvIxMaSBXYW5nDQoNCuWPr+S7peeci+eci+mZhOS7tuS/oeaBr+WQlw0KDQoNCg0KS2VuIC5M
aSDmnY7ljaDmraYgfCDmmbrnrpfkuqflk4HkuovkuJrpg6gNCueUteivne+8mjE4NTE0NTI4ODU2
DQrpgq7nrrHvvJpsaXp3QGNoaW5hc3VwZXJjbG91ZC5jb20gDQrlrpjnvZHvvJpodHRwOi8vd3d3
LmNoaW5hc3VwZXJjbG91ZC5jb20NCui2heS6keaAu+mDqO+8muWMl+S6rOW4guaYjOW5s+WMuumy
geeWg+i3rzXlj7dB5bqnNOWxgg0K56CU5Y+R5Lit5b+D77ya5YyX5Lqs5biC5Lqm5bqE57uP5rWO
5oqA5pyv5byA5Y+R5Yy656eR5Yib5Y2B5Zub6KGXNuWPt+mZojLlj7fmpbwz5bGCDQogDQrlj5Hk
u7bkurrvvJog5p2O5Y2g5q2mDQrlj5HpgIHml7bpl7TvvJogMjAyMy0wOS0wNyAxMTowMg0K5pS2
5Lu25Lq677yaIExpIFdhbmcNCuaKhOmAge+8miBsdHANCuS4u+mimO+8miDlm57lpI06IFJlOiBb
TFRQXSBTZWVraW5nIGhlbHAgd2l0aCBMVFAgdGVzdGluZyBpc3N1ZXMuDQpIae+8jExpIHdhbmcN
Cg0K5oiR55qEbWVzc2FnZeavlOi+g+Wkp++8jOWmguaenOe6r+aWh+acrOS4jeaYr+W+iOWlveWI
huaekA0KDQoNCg0KS2VuIC5MaSDmnY7ljaDmraYgfCDmmbrnrpfkuqflk4HkuovkuJrpg6gNCueU
teivne+8mjE4NTE0NTI4ODU2DQrpgq7nrrHvvJpsaXp3QGNoaW5hc3VwZXJjbG91ZC5jb20gDQrl
rpjnvZHvvJpodHRwOi8vd3d3LmNoaW5hc3VwZXJjbG91ZC5jb20NCui2heS6keaAu+mDqO+8muWM
l+S6rOW4guaYjOW5s+WMuumygeeWg+i3rzXlj7dB5bqnNOWxgg0K56CU5Y+R5Lit5b+D77ya5YyX
5Lqs5biC5Lqm5bqE57uP5rWO5oqA5pyv5byA5Y+R5Yy656eR5Yib5Y2B5Zub6KGXNuWPt+mZojLl
j7fmpbwz5bGCDQogDQpGcm9tOiBMaSBXYW5nDQpEYXRlOiAyMDIzLTA5LTA1IDA5OjA4DQpUbzog
5p2O5Y2g5q2mDQpDQzogbHRwDQpTdWJqZWN0OiBSZTogW0xUUF0gU2Vla2luZyBoZWxwIHdpdGgg
TFRQIHRlc3RpbmcgaXNzdWVzLg0KSGkgWmhhbnd1LA0KDQpJIGRpZG4ndCBmaW5kIGFueSBhdHRh
Y2htZW50cyBoZXJlLCBjYW4geW91IHBsZWFzZSByZWNoZWNrIGlmIHRoZSBlcnJvciBsb2cgdXBs
b2FkIHdhcyBzdWNjZXNzZnVsPw0KQlRXLCB3ZSB0eXBpY2FsbHkgcmVjb21tZW5kIHBvc3Rpbmcg
dGhlIGVycm9ycyBpbiBwbGFpbiB0ZXh0Lg0KDQoNCk9uIE1vbiwgU2VwIDQsIDIwMjMgYXQgMTA6
NDbigK9QTSDmnY7ljaDmraYgPGxpendAY2hpbmFzdXBlcmNsb3VkLmNvbT4gd3JvdGU6DQpXZSBh
cmUgYSBzZXJ2ZXIgbWFudWZhY3R1cmVyIHVzaW5nIExUUCB0ZXN0aW5nLiBUaGUgYXR0YWNobWVu
dCBpcyBhbiBlcnJvciBsb2cuIFBsZWFzZSBoZWxwIHVzLg0KDQoNCktlbiAuTGkg5p2O5Y2g5q2m
IA0KDQoNCi0tIA0KTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwDQoNCg0KLS0gDQpSZWdhcmRzLA0KTGkgV2FuZw0KCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
