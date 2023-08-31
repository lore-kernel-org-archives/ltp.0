Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1957C83F33
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 14:47:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C66283CEBFF
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 16:47:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 677C83C527F
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 08:18:45 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4878C605645
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 08:16:40 +0200 (CEST)
X-QQ-mid: bizesmtp85t1693462581tznllhgd
Received: from alvin ( [221.123.136.170])
 by bizesmtp.qq.com (ESMTP) with SMTP id 0
 for <ltp@lists.linux.it.>; Thu, 31 Aug 2023 14:15:37 +0800 (CST)
X-QQ-SSF: 00400000000000Z0Z000000A0000000
X-QQ-FEAT: FVl8EHhfVR4bo8bc1n3CQqyTLF1sc/Yh9wEBJTr/DFgj27J2Y9HDHDSU8v5DT
 j9HNvTmKAjK1RAfdSE8aADcVwz7gDhbtmXPNO8wOUaM22TSLoz4a5CgHhnW0f/cxPI3zDqu
 hL/B5KTOcA6LvXBr3qHfoLB31SjhIf0PYmG2sSPNby1T8VfTgSpOBuYALj8ZmduG+rGegvm
 dLtqDvTTinpZ0sPboSsrzphv14YZRYC0IyCbyEEGURGXRmyaZ4iY4Sa69VH+P1IF0k6eU9E
 XmDQrUC2Pzh9ZaHpAd0ISkgUnzJmxs3yfJiVgrXbPRqz/Yv+Plt9NQBx13CMylhn3UytFEC
 m2+10pNqqk9LHf9LHQaY+xh3F9leUClaOXd+FL8NP6bySrD184F3edH+LqEEbM7trob6gAF
 83ULCgTFgaJmo8AAf33G+4Xdvyre1JnAxxnwzoeesKE6BUrsS2nTvg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6929554269240748729
Date: Thu, 31 Aug 2023 14:15:38 +0800
From: =?GB2312?B?wO7VvM7k?= <lizw@chinasupercloud.com>
To: ltp <ltp@lists.linux.it>
X-Priority: 3
X-GUID: B82E7E55-6A20-48D8-AF29-F7B81F6DBF22
X-Has-Attach: yes
X-Mailer: Foxmail 7.2.23.121[cn]
Mime-Version: 1.0
Message-ID: <0F69C266D964FE62+2023083114153717245222@chinasupercloud.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:chinasupercloud.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 04 Sep 2023 16:46:38 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] =?gb2312?b?16q3ojogU2Vla2luZyBoZWxwIHdpdGggTFRQIHRlc3Rp?=
 =?gb2312?b?bmcgaXNzdWVzLg==?=
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
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

V2UgYXJlIGEgc2VydmVyIG1hbnVmYWN0dXJlciB1c2luZyBMVFAgdGVzdGluZy4gVGhlIGF0dGFj
aG1lbnQgaXMgYW4gZXJyb3IgbG9nLiBQbGVhc2UgaGVscCB1cw0KDQoNCg0KS2VuIC5MaSDA7tW8
zuQgfCDWx8vjsvrGt8rC0rWyvw0Ktee7sKO6MTg1MTQ1Mjg4NTYNCtPKz+SjumxpendAY2hpbmFz
dXBlcmNsb3VkLmNvbSANCrnZzfijumh0dHA6Ly93d3cuY2hpbmFzdXBlcmNsb3VkLmNvbQ0Ks6zU
xtfcsr+jurGxvqnK0LL9xr3H+MKz7rbCtzW6xUHX+TSy4w0K0dC3otbQ0MSjurGxvqnK0NLg16++
rbzDvLzK9b+qt6LH+L/GtLTKrsvEvdY2usXUujK6xcKlM7LjDQogDQq3orz+yMujuiDA7tW8zuQN
Creiy83Ksbzko7ogMjAyMy0wOC0zMSAxNDowOQ0KytW8/sjLo7ogbHRwDQrW98zio7ogU2Vla2lu
ZyBoZWxwIHdpdGggTFRQIHRlc3RpbmcgaXNzdWVzLg0KV2UgYXJlIGEgc2VydmVyIG1hbnVmYWN0
dXJlciB1c2luZyBMVFAgdGVzdGluZy4gVGhlIGF0dGFjaG1lbnQgaXMgYW4gZXJyb3IgbG9nLiBQ
bGVhc2UgaGVscCB1cy4NCg0KDQpLZW4gLkxpIMDu1bzO5CANCg0KCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
