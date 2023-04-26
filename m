Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D44C7EE21
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 10:07:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EE023CBB85
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 12:07:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 366AA3CA1D6
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 12:07:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 412C11A00695
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 12:07:44 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D0DDC14;
 Wed, 26 Apr 2023 03:08:26 -0700 (PDT)
Received: from [10.1.27.36] (e126380.cambridge.arm.com [10.1.27.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04DF43F5A1;
 Wed, 26 Apr 2023 03:07:41 -0700 (PDT)
Message-ID: <34a61554-3d95-abd0-479f-25c86ac1c8ba@arm.com>
Date: Wed, 26 Apr 2023 11:07:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <ZEjsKC6ESB1+mM0H@rei>
Content-Language: en-US
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <ZEjsKC6ESB1+mM0H@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgpPbiAyNi8wNC8yMDIzIDEwOjE3LCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gSGkh
Cj4gSSB3b3VsZCBsaWtlIHRvIHN0YXJ0IHdpdGggTFRQIHByZS1yZWxlYXNlIHByZXBhcmF0aW9u
cyBhIGJpdCBzb29uZXIKPiB0aGFuIHVzdWFsbCwgc2luY2UgcXVpdGUgYSBsb3Qgb2YgdGhpbmdz
IGhhdmUgYWNjdW11bGF0ZWQgaW4gTWF5LCBlLmcuCj4gdGhlcmUgaXMgYSBTVVNFIExhYnMgY29u
ZmVyZW5jZSByaWdodCBpbiB0aGUgbWlkZGxlIG9mIHRoZSBtb250aC4KPgo+IEkgd291bGQgbGlr
ZSB0byBzdGFydCB3aXRoIHJldmlld2Ugb2YgcGF0Y2hlcyB0aGF0IHNob3VsZCBnbyBpbiBub3cs
Cj4gZnJlZXplIHRoZSBnaXQgc29tZXdoZXJlIGF0IHRoZSBlbmQgb2YgdGhlIGZpcnN0IHdlZWsg
b2YgTWF5IGFuZCBhaW0gZm9yCj4gYSByZWxlYXNlIHNvbWV3aGVyZSBpbiB0aGUgbWlkZGxlIG9m
IHRoZSBtb250aC4gRG9lcyB0aGF0IHNvdW5kIE9rIHRvCj4gZXZlcnlvbmU/Cj4KPiBFaXRoZXIg
d2F5IGlmIHlvdSBoYXZlIHBhdGNoZXMgdGhhdCBzaG91bGQgbGFuZCBpbiB0aGUgdXBjb21taW5n
Cj4gcmVsZWFzZSwgcGxlYXNlIHBvaW50IHRoZW0gb3V0IG5vdywgc28gdGhhdCB3ZSBoYXZlIGEg
Y2hhbmNlIHRvIHJldmlldwo+IHRoZW0uCj4KSXQncyBub3QgY3JpdGljYWwgaW4gdGhlIHNsaWdo
dGVzdCwgYnV0IHdlIHdvdWxkIGFwcHJlY2lhdGUgaWYgbXkKc2V0cGdpZCBzZXJpZXNbMF0gY291
bGQgbGFuZCBmb3IgdGhlIHJlbGVhc2UuCgpIYXBweSB0byBhbGxvY2F0ZSBhIGJpdCBtb3JlIHRp
bWUgZm9yIHF1aWNrbHkgdHVybmluZyBhcm91bmQKYWRkaXRpb25hbCB2ZXJzaW9ucyBpZiBuZWVk
ZWQuIEl0J3MgYSByYXRoZXIgc21hbGwgc2VyaWVzIGFueXdheS4KClRoYW5rcyB2ZXJ5IG11Y2gg
aW4gYWR2YW5jZSBmb3IgdGhlIHJlbGVhc2UgIQpCZXN0IHJlZ2FyZHMsClTDqW8KClswXTogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9waXBlcm1haWwvbHRwLzIwMjMtQXByaWwvMDMzNTc0Lmh0bWwK
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
