Return-Path: <SRS0=SdNH=PE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AFAC433EF
	for <ltp@archiver.kernel.org>; Sat, 16 Oct 2021 13:07:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4780960C4B
	for <ltp@archiver.kernel.org>; Sat, 16 Oct 2021 13:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4780960C4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09D4F3C1D85
	for <ltp@archiver.kernel.org>; Sat, 16 Oct 2021 15:07:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B4D43C0E8A
 for <ltp@lists.linux.it>; Sat, 16 Oct 2021 15:07:34 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 417961A00812
 for <ltp@lists.linux.it>; Sat, 16 Oct 2021 15:07:24 +0200 (CEST)
X-QQ-mid: bizesmtp36t1634389634tc8k9or7
Received: from [192.168.31.173] (unknown [49.77.231.226])
 by esmtp6.qq.com (ESMTP) with 
 id ; Sat, 16 Oct 2021 21:07:13 +0800 (CST)
X-QQ-SSF: 0040000000200040D000B00A0000000
X-QQ-FEAT: F3yR32iATbi4yci4WfEiVx5VsOOziKybaOrzJ5j31+urtt9WJ1n/NWUkwygfi
 dpdW1mD/jXUcC3LRqfBw3fYHcnKJ/9mGcLM4jPms+EQwn41eVwSTOSFlxkqxdF2FmgKJ8Ba
 xD2rUAC6I3sZVsSSPfPeksHZ3GPP2cRrIXSI4wKcPJyikCCeI9dbEb2BoNKtOzhAdWnxCkI
 YJjAs8yhfuWGV6Bj1YCWhkXKxh916gG09x1/s9KmeQCHa7lTTl//s8VmyiN9NU9xRHAF90A
 gjSqYAd8GT3tnhDVFlkV94nev2QLJarEmtKNsuguvJL4BrVBZLHKZfNZ2O9N3BIF61l03mK
 K8gckdHqiPh3/tky6k=
X-QQ-GoodBg: 2
To: Petr Vorel <pvorel@suse.cz>
References: <20211014012533.18205-1-zhanglianjie@uniontech.com>
 <YWlQlXfHu6FXQAx/@pevik>
From: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <dd19b9d7-ef55-ebe5-90d9-415bd35dc4f9@uniontech.com>+CC8CCA274EC792B4
Date: Sat, 16 Oct 2021 21:07:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YWlQlXfHu6FXQAx/@pevik>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/5] syscalls/clone02: Convert to new API
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksClRoaXMgaXMgZ3JlYXQsIHRoYW5rcy4KCtTaIDIwMjEvMTAvMTUgMTc6NTcsIFBldHIgVm9y
ZWwg0LS1wDoKPiBIaSwKPiAKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9u
ZS9jbG9uZTAyLmMKPiAuLi4KPj4gK3N0YXRpYyBjaGFyICpyZXNfbmFtZVtdID0gewo+PiArCVsx
XSA9ICJDTE9ORV9WTSIsCj4+ICsJWzJdID0gIkNMT05FX0ZTIiwKPj4gKwlbNF0gPSAiQ0xPTkVf
RklMRVMiLAo+PiArCVs4XSA9ICJDTE9ORV9TSUdIQU5EIiwKPj4gICB9Owo+IAo+IE5vdCByZWFs
bHkgdGhhdCBpbXBvcnRhbnQsIGJ1dCB5b3UgY291bGQKPiAxKSBJbnN0ZWFkIG9mIGhhcmR3aXJl
ZCBpbmRleGVzIHVzZSBjb25zdGFudHMgZnJvbSA8c2NoZWQuaD4uCj4gMikgVG8gZ2V0IHRoZWly
IHN0cmluZyB2YWx1ZXMgd2l0aCBtYWNybyBzdHJpbmdpZmljYXRpb24uCj4gCj4gI2RlZmluZSBD
TE9ORV9ERVNDKHgpIFt4XSA9ICN4Cj4gCj4gc3RhdGljIGNoYXIgKnJlc19uYW1lW10gPSB7Cj4g
CUNMT05FX0RFU0MoQ0xPTkVfVk0pLAo+IAlDTE9ORV9ERVNDKENMT05FX0ZTKSwKPiAJQ0xPTkVf
REVTQyhDTE9ORV9GSUxFUyksCj4gCUNMT05FX0RFU0MoQ0xPTkVfU0lHSEFORCksCj4gfTsKPiAK
PiBJZiB0aGlzIGlzIHRoZSBvbmx5IGNoYW5nZSwgaXQgY2FuIGJlIHJlcGxhY2VkIGR1cmluZyBt
ZXJnZS4KPiAKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+IAoKLS0gClJlZ2FyZHMsClpoYW5nIExp
YW5qaWUKCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
