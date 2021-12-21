Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7818BC433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 01:58:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADCFD3C9239
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 02:58:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C8FB3C7F60
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 02:58:37 +0100 (CET)
Received: from smtpbg511.qq.com (smtpbg511.qq.com [203.205.250.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 20D2E200B28
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 02:58:34 +0100 (CET)
X-QQ-mid: bizesmtp49t1640051908tnqaozjg
Received: from [10.4.23.202] (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 21 Dec 2021 09:58:27 +0800 (CST)
X-QQ-SSF: 0040000000200070E000B00A0000000
X-QQ-FEAT: QR3/Kz8aADNh1P1JqpEHMmurYT+GFaftG/raARBiCZu01R9T11wzzCW/aoEv4
 vQtUMZOT0PHwilAME5fZC98SU8p1MWdiPkXpLssXtQu2vlYqHylBD42g17R1Fj1FSNGpXT+
 kCQbsS0apB3nxQxWNR0p0qaUf6TOtVmnMNaXqEMhGtRwz/z/by2Wth1KZvnDks6lIurV6i7
 qVG95bIlnhggB85uol3iGU/Q649d2rXQdiAtjw0TRl1upqMZNjxc2tX6bysKxDEyooxUppG
 Yq8QUnphpYVDTVW0mltADv+BXhEdMJooKaICDqpDikiP0n0kU96RusJ1l/zPdhJ4TEnkcJU
 1SBikxcgfYxhCeGbNw=
X-QQ-GoodBg: 2
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20211217062637.29720-1-sujiaxun@uniontech.com>
 <YbxUx8mz7ejCjp7W@pevik> <YcDffj8+zqY3SNCz@pevik>
From: sujiaxun <sujiaxun@uniontech.com>
Message-ID: <0bb516ab-5e9f-71f2-3e55-5e46c41aaee2@uniontech.com>+7612FA9223013B5F
Date: Tue, 21 Dec 2021 09:58:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YcDffj8+zqY3SNCz@pevik>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [v2,
 1/2] syscalls/sched_get_priority_max01: Convert to new
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

1NogMjAyMS8xMi8yMSDJz87nMzo1NCwgUGV0ciBWb3JlbCDQtLXAOgo+IEhpIHN1amlheHVuLAo+
IAo+IG1lcmdlZC4gVGhhbmtzIQo+IAo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4gCkknbSBzb3Jy
eSwgYnV0IEkgaGF2ZSBiZWVuIGRlYWxpbmcgd2l0aCBvdGhlciB0aGluZ3Mgc29tZSB0aW1lIGFn
byBhbmQgCmhhdmUgbm90IGJlZW4gYWJsZSB0byByZXBseSBpbiB0aW1lLiBUaGFuayB5b3UgZm9y
IGhlbHBpbmcgbW9kaWZ5IGFuZCBtZXJnZS4KCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
