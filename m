Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7328FC4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 10:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714127379; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=KpL7hqKmO+AZ2kr8+avnrDLwxJvbV0M9YY6DIlVeeLg=;
 b=IdmKA950KU1MGf2heF4uT7hHa8nl/XlQAz9UHKJ6CZqMGxF6ZqUZkbkL4tkvmpzfAr/gB
 4ottwMHregBe+G4o+B98XEuzJE5xcmgU3bsIbpJs0EAhgXaZdNDxjIoQLdN0Rrjx4nCkt7b
 PPAwT2D2M3ZZBsN4NunT5fhCes3r1h8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B0383D034B
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 12:29:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F04593CE531
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 12:29:18 +0200 (CEST)
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 70D5E10060B2
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 12:29:17 +0200 (CEST)
Received: by mail-lj1-x242.google.com with SMTP id
 38308e7fff4ca-2dac77cdf43so23754331fa.2
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1714127356; x=1714732156; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NyVh5z/w8+69WvGTsTryXBsY1Ek+WwIY4iXlnSHHq5A=;
 b=Iz3eq/eeJusekJDkuMMpWfq5L9rtfQZSyAocjXCyLvn4dGcPLcUVnRHnywRymR7gqJ
 cnaqlADeB0zpq6a9ZfyFQIAsPE9/GgckCDjY32VngkPHGJVhtGj9xAdxt7EEBobe7OyC
 FrwNtDps21T8MKauQu6RePhM2ceRfBjDNg8lXtU4GjwzwBjEfxhxBbi/hzUbZ1HFlUJG
 AMHkIEvTROXuzxOWGBuhN/UL0o4biU2O2DpXCqRTPMs04dY1W6uFRQp7w+oBeTo6JMAa
 optKFRgkvW/1v8YxTTP3B+fpwlbUzwQHzk8CKMH0mk15Vuxhc4sR/5IibQJZoA9TRP8d
 oGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714127357; x=1714732157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NyVh5z/w8+69WvGTsTryXBsY1Ek+WwIY4iXlnSHHq5A=;
 b=aezIfoBLJcke917V1Bf+lgwW/Sx/kR3GDh1m/hfBBy8O8J1xMhbqWfCydZzX8oQhyz
 EuIwFTnxGhvfYoXYVy2Pvc/FJj3OaKZj5rcgwrmUPiz1mgi2Y0RlVfM5e8Wmk4caFLyH
 mtZOhXUxGMmS4gn1KhB1KbKk9BaGxMZ/yYEbc8NYjP/n6KGgXuVyYjnU1Gl2n80Iaxfo
 LzSMwsxR0dxQYDA5bgAQNAwlKYeDq7MMYsOv/piNUJ7B62ZDA2ooVuJK5AURhPhrXSSI
 +hBKvq3hRosnNYEc4R8KCTL25Ha0r8rRsGd5g1J/HEddXDUf5J4NOpybUXqK69Lu+tsW
 fzbQ==
X-Gm-Message-State: AOJu0YzRBNS5RRc4VT4zUckBOVHDgQt7C/4qfuKl/YJXv05wGl/2gREA
 CKlXg/G2xOoPZj1OtWAjtukYQo1M87/ycuiDXJgFD9WxjxA7B6SFRyK5fmXod1s=
X-Google-Smtp-Source: AGHT+IHGUd9GhHbVgwm+k8/vnubLtIBI8Ra2SPjQDWI0G//C0u2NJivwaphLyZiCFFItPs3t2SUt3w==
X-Received: by 2002:ac2:4ec8:0:b0:516:c8e5:9647 with SMTP id
 p8-20020ac24ec8000000b00516c8e59647mr1355624lfr.19.1714127356598; 
 Fri, 26 Apr 2024 03:29:16 -0700 (PDT)
Received: from [10.232.133.119] ([88.128.88.8])
 by smtp.gmail.com with ESMTPSA id
 kx6-20020a170907774600b00a58a3238522sm2218591ejc.207.2024.04.26.03.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 03:29:16 -0700 (PDT)
Message-ID: <6b2dd151-c7cf-48b5-87f5-3c3efb425811@suse.com>
Date: Fri, 26 Apr 2024 12:29:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240423082119.16117-1-andrea.cervesato@suse.de>
 <20240425213749.GA304030@pevik>
Content-Language: en-US
In-Reply-To: <20240425213749.GA304030@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] doc: update syscalls statistics
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiA0LzI1LzI0IDIzOjM3LCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhpIEFuZHJlYSwKPgo+
PiBUaGlzIHBhdGNoIGJsYWNrLWxpc3QgYSBmZXcgc3lzY2FsbHMgd2hpY2ggYXJlIG5vdCBpbXBs
ZW1lbnRlZCBpbiB0aGUKPj4ga2VybmVsLCB1bnRlc3RhYmxlIG9yIGVpdGhlciByZWFsbHkgb2xk
ICg9PCAyLjYga2VybmVsIHZlcnNpb24pLCBhcyB3ZWxsCj4+IGFzIGRlZmluaW5nIGFscmVhZHkg
dGVzdGVkIHN5c2NhbGxzLgo+PiBBbHNvIGZpeGVkIGFuIGluZGV4IGlzc3VlIHdpdGggdGFibGUg
Z2VuZXJhdGlvbi4KPiBUaGFua3MgYSBsb3QsIG9idmlvdXMgZml4LCB0aGVyZWZvcmUgbWVyZ2Vk
Lgo+Cj4gSSB3b3VsZCBzdGlsbCBjb25zaWRlcjoKPgo+IDEpIExpc3RpbmcgYWxzbyBtcV9nZXRz
ZXRhdHRyKCkuCiBGcm9tIG1hbnVhbDoKCkRFU0NSSVBUSU9OCiDCoMKgwqDCoMKgwqAgRG8gbm90
IHVzZSB0aGlzIHN5c3RlbSBjYWxsLgoKIMKgwqDCoMKgwqDCoCBUaGlzwqAgaXPCoCB0aGUgbG93
LWxldmVsIHN5c3RlbSBjYWxsIHVzZWQgdG8gaW1wbGVtZW50IAptcV9nZXRhdHRyKDMpIGFuZCBt
cV9zZXRhdHRyKDMpLsKgIEZvciBhbiBleHBsYW5hdGlvbiBvZiBob3cgdGhpcyBzeXN0ZW0gCmNh
bGwgb3BlcmF0ZXMsIHNlZSB0aGUgZGVzY3JpcHRpb24KIMKgwqDCoMKgwqDCoCBvZiBtcV9zZXRh
dHRyKDMpLgoKPiAyKSBUcnlpbmcgdG8gbGlua3Mgc3lzY2FsbHMgbmFtZXMgdG8gdGhlIHN5c2Nh
bGxzIGRpcmVjdG9yeQo+IChlLmcuIHJlYWQgPT4gcmVhZCBkaXJlY3RvcnkgaW4gTFRQIHRyZWVb
MV0pIHRoYXQgc2hvdWxkIG5vdCBiZSB0aGF0IGhhcmQuCkl0J3MgYWxyZWFkeSBsaWtlIHRoaXM6
IHdlIGNoZWNrIGZvciBzeXNjYWxscyBzdWJmb2xkZXJzIGFuZCBjb21wYXJlIAp0aGVtIHdpdGgg
c3lzY2FsbHMgZmlsZS4gSWYgc3ViZm9sZGVyIGV4aXN0cywgd2Ugc3VwcG9zZSB0byBoYXZlIHRl
c3RzIApmb3IgdGhlIHNwZWNpZmljIHN5c2NhbGwgKG9mIGNvdXJzZSwgdGhpcyBkb2Vzbid0IGlu
Y2x1ZGUgY292ZXJhZ2UpLgo+IDMpIFdyaXRlIGV4cGxhbmF0aW9uLCB0aGF0IHRoZXNlIHN5c2Nh
bGxzIGFyZSB0byAic29tZSBleHRlbmQgdGVzdGVkIi4KPiBJZGVhbGx5LCBJIHdvdWxkIHdpc2gg
d2Ugd291bGQgdHJhbnNmb3JtIG1ldGFkYXRhIG91dHB1dCBnZW5lcmF0aW9uIFsyXQo+IHRvIHRo
ZSBkb2NzIGhlcmUgYW5kIGVuYWJsZSBhbHNvIExUUCBsYXRlc3Qgc3RhYmxlIHZlcnNpb24gZG9j
cy4KUG9zc2libGUsIGJ1dCBpdCBtaWdodCBiZSBhIGJpdCBjaGFsbGVuZ2luZwo+Cj4gS2luZCBy
ZWdhcmRzLAo+IFBldHIKPgo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9q
ZWN0L2x0cC90cmVlL21hc3Rlci90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3JlYWQKPiBbMl0g
aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvcmVsZWFzZXMvZG93bmxv
YWQvMjAyMzA1MTYvbWV0YWRhdGEuMjAyMzA1MTYuaHRtbAoKQW5kcmVhCgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
