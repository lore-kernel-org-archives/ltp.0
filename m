Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636A1C5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 06:28:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD6DE3E2C43
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 08:28:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 702993E2443
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 08:28:41 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ADBEC1A009A9
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 08:28:40 +0200 (CEST)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7eb64371a2aso2202824a34.0
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 23:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786084119; cv=none;
 d=google.com; s=arc-20260327;
 b=S+erwYPeKYlYF3UITv2Zcs3QHdMoXp7OoRtBGJoEQXHi/61tSam6voodDWJ8yxVD0P
 /LH5mGFIQAt/5BUgo3J2VLcm53x88kJbgewiJdwEKdd4qrvEIAT1Br9qmnenwNYbe0eH
 BjVtSm2GrbFobsUMkxmDadVCxNezssS3VNY+3PE5gK2y6ejjbQ98VBQAwlGb+CvqfpIU
 Luu+NuQ1rt1Ett1JbOc6QSoAlBS/pxMA2JVDf6Sexl3IXpEkZ/Q44i1pnP3en6owvvxq
 dnlAKUz99a2My0I0w8pEQ5ETE3qoK0k/smEY4+kIsKerShxOCfzZliGYPjZo+cclakHF
 jHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bPc06/0xU7ux6XJJUXQ1MzoQzoCswb0RN6NGIRPmYY0=;
 fh=DrcNDEnhPz2UT687gzGXvgpoIEp/vcPJRmtiXOQI7Es=;
 b=WHciU/I04ZZaYGFAo8gp/sYckgOe8FX0vTwiPPmDaS7tYXDENq/meiX4O31/I7x0cT
 DuVFfzvKSf9WFvD4WzR3SpWPpReyMIs5+i3ZUdabdxhvuQTpe4+EMT8oOoY2OnNpBCAt
 Pz+gKO/b9JT059h13O1AzttCzWzKId6DpJNg9A+kBFCPoJBSq0dwbZ7G6FHTelvmlVi5
 nvKDlElEoTGvcJV6yBTeVsrMw58HeUqT1xluo64XzRbM6Ku9x5z8zXZmSJYjYY/K9nh1
 iQSS06j4a+Ao10Bxu6KcIV18snd51sfHqR5YGNCtBsFVCnpoGc1Qp4KF9PQ6iwYSruLq
 Fscg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786084119; x=1786688919; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bPc06/0xU7ux6XJJUXQ1MzoQzoCswb0RN6NGIRPmYY0=;
 b=sNDD6fCoaP1o2wwMLAZATSXcU5nHOQubJX2kLuZ0ypO5XHzuHuP2Px+xi2wcU2dpg7
 jZ8oujtYzV8ASPcgyN5F3v94mhWSJVVWtFQlsKpLqHqI6/noBJfeRvxDo1/zg6M2vGa6
 56ttRr2LnPjrp6yC57UIdQbIm6nTbAZW6ahUrDC//8mHOk/ssTDZ2uPQIwZXpmj3UfRO
 TAOU2Gxe2NqIvoYWNPMQMgPNSnGm2ew82OVk6zg549fnzaNca0Ye7WelHIPQ1xoSe4fE
 Yt9XNfKkK+FMD560a9eulyw1A4gy1QmmGQ3o5VWN34/3doxPAFyTJIZdOcFUSSZQj0WN
 3zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786084119; x=1786688919;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bPc06/0xU7ux6XJJUXQ1MzoQzoCswb0RN6NGIRPmYY0=;
 b=gytH9+NBA1wlBO+GU1M7WyKgRt7zWIOezU2J/KUKIHbautFGLGbJfpZ8bUViMZq2fc
 XzJMXyvxltq4DhpKHExEkPvrVnKiAK6SHrfP3CexK41DDBh9bT7cMtgCS6qYrY262lGz
 90jnjpxiMRpecJ04jZze+hJh3UJmt/nRbyJ90FP9xkznIedWstGKLrzu5u1iwA7nZrYM
 fcjHuYPOnRg/Q7UDuMGHHKXBjzwgCzNySCx+CjnD7d152NxflAet6UN/NvXufVv1BH3u
 TH6bhC96Q1tOEC8JBmrZXIgkugJyM/UOegFqtxMKjX8WbhgpMG3cFrF3Ef+wONnMPuQ0
 SWSA==
X-Forwarded-Encrypted: i=1;
 AHgh+RolKRk7p3BybtxzxGzXpRNoKbHwkkgJPVECr18kYhsz/o35Io6hs+uTAcFW9x1D187RnYA=@lists.linux.it
X-Gm-Message-State: AOJu0YwlS3NOMIbwiEpSZmh2IWqI212U7bz+Ruq48Q9ueWarmeqa/lJA
 VlLqw/H5BDWCHxiSqhCoJJz//vjerRf7rkacvj6v9EB3XtcoLleXUgjBe4OjDKQxIvt7YIuiMl9
 n1IBPelL9tCHAbPOxrbOQcxELdiNScqY=
X-Gm-Gg: AR+sD13IvCh1s1eAC75He1XW2DcikIa1gKOPCrc5s7NxuFD8XF1MctlPzY4scZe9Eyf
 6HGuR5EO2T7UfHIXhrVLjcU/yXCnltWnmW3Tj4HqMTVVs8W4vpO54S996gh6roz7UpRFY2GGaf7
 ymuveD/vqqARV89jGyqrb2TEMnaKO3pB4xxfk9r9QzwERGn+J1XCpVUQCVUJuLgQtiajAGHUhLZ
 INTxojjH252rnPmRN4AucGEESsQlz20f5bTrSWFAbo0Jry3rkrf+bD0bN4QTzAxLBRCtFTONWvV
 Dvo5ZYf5YbZTr66poWpXohi1kS9ZLNLUUg7IkxrqmtdWc7hpwg9RI7OO6Q==
X-Received: by 2002:a05:6808:13d0:b0:4a3:ec8e:2052 with SMTP id
 5614622812f47-4b1a0e43eb4mr642804b6e.8.1786084119101; Thu, 06 Aug 2026
 23:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <77cf7e28-c8a4-4017-9ca7-425739d7378f@gmail.com>
 <6a71e530.159d33f9.a396c.0aff@mx.google.com>
In-Reply-To: <6a71e530.159d33f9.a396c.0aff@mx.google.com>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Fri, 7 Aug 2026 14:28:25 +0800
X-Gm-Features: AUfX_mzT47Kctv30q2yHGF12GpB7b7ohkztcpPjjIp9QUK5Mq8h_Kqz06y6gxc0
Message-ID: <CAOB9oOZ4eGg6M-t4JoArwFEonzbdCV+Tkzu+7EdTh=2ciRPeVA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Revert "tpci: unbind driver in test_assign_resources()"
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
Cc: linuxtestproject.agent@gmail.com, ltp@lists.linux.it,
 Hongtao Zhang <zhanghongtao35@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBdWcgNCwgMjAyNiBhdCA5OjEy4oCvUE0gQW5kcmVhIENlcnZlc2F0bwo8YW5kcmVh
LmNlcnZlc2F0b0BzdXNlLmNvbT4gd3JvdGU6Cj4KPiBIaSBUYW5nLAo+Cj4gPiBPbiAzMC83LzI2
IDQ6NTMgcG0sIEN5cmlsIEhydWJpcyB3cm90ZToKPiA+ID4gSGkhCj4gPiA+Pj4gV2UgcmVjZW50
bHkgY29uZmlybWVkIHRoaXMgY29tbWl0IGRvZXMgY2F1c2UgYSBmbG9vZCBvZiBJL08gZXJyb3Jz
IG9uCj4gPiA+Pj4gdGhlIHJvb3QgZmlsZXN5c3RlbSBpbiBvdXIgdGVzdGluZywgbGVhdmluZyB0
aGUgbWFjaGluZSB1bnVzYWJsZSB1bnRpbAo+ID4gPj4+IHJlYm9vdC4KPiA+ID4+Pgo+ID4gPj4+
IEdpdmVuIHRoYXQsIHdlJ2QgYXBwcmVjaWF0ZSB0aGUgY29tbXVuaXR5IGhlbHBpbmcgdG8gZGVj
aWRlIHNvb24KPiA+ID4+PiB3aGV0aGVyIHRoZSByZXZlcnQgaXMgd2FycmFudGVkLgo+ID4gPj4K
PiA+ID4+IEFyZSB5b3UgMTAwJSBzdXJlIHRoYXQgaXMgY2F1c2VkIGJ5IHRoZSBwYXRjaCB5b3Ug
d2FudCB0byByZXZlcnQ/Cj4gPiA+PiBCZWNhdXNlIHRoZSBwYXRjaCBsb29rZWQgb2sgdG8gbWUg
d2hlbiBJIHJldmlld2VkLiBXZSBuZWVkIHRvIGhhdmUKPiA+ID4+IG1vcmUgY29udGV4dCBhbmQg
aW5mbyBhcm91bmQgdGhlIGlzc3VlIHdoaWNoIGhhcyBiZWVuIGdlbmVyYXRlZCBpbgo+ID4gPj4g
b3JkZXIgdG8gYXZvaWQgYW55IHdvcmthcm91bmQgZm9yIGEgc3lzdGVtL2tlcm5lbCBidWcuCj4g
PiA+Cj4gPiA+IEFGQUlLIHRoZSB0ZXN0aW5nIG1vZHVsZSBncmFicyBmaXJzdCBkZXZpY2UgYXZh
aWxhYmxlIG9uIHRoZSBzeXN0ZW0gYW5kCj4gPiA+IHVzZXMgaXQgZm9yIHRlc3RpbmcuIFdoaWNo
IG1lYW5zIHRoYXQgaWYgeW91IGFyZSB1bmx1Y2t5IGl0J3MgeW91cgo+ID4gPiBuZXR3b3JrIGNh
cmQsIG9yIGRpc2sgY29udHJvbGxlciBhbmQgeW91IGZvcmNlIHJlbG9hZCBpdCBvbiBhIGxpdmUK
PiA+ID4gc3lzdGVtLgo+ID4gPgo+ID4gPiBBbmQgaG9uZXN0bHkgdGhlIFBDSSB0ZXN0IHNob3Vs
ZCBiZSBlaXRoZXIgcmV3cml0dGVuIGFuZCBjbGVhbmVkIHVwIHRvCj4gPiA+IGRvIHNvbWV0aGlu
ZyBtb3JlIHNlbnNpYmxlIG9yIGp1c3QgcmVtb3ZlZC4gQXMgaXQgaXMgaXQncyB0b28gZnJhZ2ls
ZS4KPiA+ID4KPiA+Cj4gPiBUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2suIEl0IGlzIHZlcnkg
aGVscGZ1bCB0byB1cy4KPiA+Cj4gPiAtLQo+ID4gQmVzdCBSZWdhcmRzLAo+ID4gWWkKPiA+Cj4K
PiBBcmUgeW91IGdvaW5nIHRvIHdvcmsgb24gYSBuZXcgcGF0Y2g/IHdoYXQgd2UgZG8gd2l0aCB0
aGlzIG9uZT8KCkhpIEFuZHJlYSwKClNvcnJ5LCBJ4oCZbSBub3QgYSBQQ0kgZXhwZXJ0LCBzbyBm
b3Igbm93IEnigJl2ZSBvbmx5IHJldmVydGVkIHRoaXMgY29tbWl0CmluIG91ciBjb21wYW55IHRl
c3RpbmcuIEnigJlsbCBmb2xsb3cgeW91ciBuZXcgcGF0Y2hzZXQuCgpCZXN0IHJlZ2FyZHMsCllp
Cgo+Cj4gUmVnYXJkcywKPiAtLQo+IEFuZHJlYSBDZXJ2ZXNhdG8KPiBTVVNFIFFFIEF1dG9tYXRp
b24gRW5naW5lZXIgTGludXgKPiBhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
