Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD8CC83F3F
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 14:46:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69B523CBFC9
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 16:46:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78A133C62DB
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 08:11:24 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 67660605649
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 08:10:42 +0200 (CEST)
X-QQ-mid: bizesmtp75t1693462227tl23kkf4
Received: from alvin ( [221.123.136.170])
 by bizesmtp.qq.com (ESMTP) with SMTP id 0
 for <ltp@lists.linux.it.>; Thu, 31 Aug 2023 14:09:34 +0800 (CST)
X-QQ-SSF: 00400000000000Z0Z000000A0000000
X-QQ-FEAT: +ynUkgUhZJm4xz8GeQKCm0shyfN5rQNXmNRgHcRgaAROSnajGLkuPjw7EnKKq
 Cig67LKaz3bFaW2Z4kWYWqPdwUi17gBrTJXg5/o3Khy7XvXg2Wg0bMrShkryA3ju0JigzqX
 HBQwW/z/03McBZw5Or/ilQjb9S5Hr1cO8kBd7OunglQittE6qf8l7NWBW7NuUIJRfEBcHPn
 jBJzdOiEcx+x/Dc3wqthgKtaTq46aKbp7QLXihyFYvOylLMT6tARLekqukUu0DU/sdSQuPK
 2KarU3ePzgU3q1q89PClmnTtNLr0TlHURkZOk4BBmtpsMg5FgNaTuG4XfYZUuMkACAy62lZ
 eLyntJTi3yLmFGuJ81hA12vhRsusDWzRA+DDrqQay0AbbJO9M5nRleeW73/9JIKI0wjM1dZ
 BYz21Th1ODvrKAzSs/65jljKxMRviSSa
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1971478944658686317
Date: Thu, 31 Aug 2023 14:09:35 +0800
From: =?GB2312?B?wO7VvM7k?= <lizw@chinasupercloud.com>
To: ltp <ltp@lists.linux.it>
X-Priority: 3
X-GUID: 29D3E938-035E-4EB5-AB9D-1ECB6639D279
X-Has-Attach: yes
X-Mailer: Foxmail 7.2.23.121[cn]
Mime-Version: 1.0
Message-ID: <927B643AA2DE0DEB+2023083114093400166120@chinasupercloud.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:chinasupercloud.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 04 Sep 2023 16:46:38 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] Seeking help with LTP testing issues.
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
aG1lbnQgaXMgYW4gZXJyb3IgbG9nLiBQbGVhc2UgaGVscCB1cy4NCg0KDQpLZW4gLkxpIMDu1bzO
5CANCg0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
