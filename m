Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C18C4332F
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 13:04:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E49E3CC54B
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 14:04:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AB033CC504
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:03:57 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 376F5200B73
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:03:55 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6640D6E;
 Wed, 30 Nov 2022 05:04:00 -0800 (PST)
Received: from [10.57.37.211] (unknown [10.57.37.211])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 976AB3F73D;
 Wed, 30 Nov 2022 05:03:53 -0800 (PST)
Message-ID: <448cb776-770d-3235-c0d9-3c9005663790@arm.com>
Date: Wed, 30 Nov 2022 13:03:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20221128091508.75414-1-teo.coupriediaz@arm.com>
 <Y4UMUqkLijWXOWu6@pevik> <Y4YEnmDLD7AEMHrr@yuki> <Y4YK6uhK94C0vrVR@pevik>
 <Y4YLvhQfIW1SW1XB@yuki>
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <Y4YLvhQfIW1SW1XB@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/1] brk: use direct syscalls
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwgYW5kIFBldHIsIHRoYW5rcyBmb3IgaGF2aW5nIGEgbG9vayBhbmQgdGhlIGRpc2N1
c3Npb24gIQoKT24gMjkvMTEvMjAyMiAxMzo0MCwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+IEhpIQo+
PiBXRFlUIGFib3V0IC50ZXN0X3ZhcmlhbnRzPyBJbiB0aGF0IGNhc2UgaXQnZCBiZSB0ZXN0ZWQg
YWxzbyBvbiBtdXNsCj4+IG9yIGFueSBwbGF0Zm9ybSB3aGVyZSBpdCdzIGltcGxlbWVudGVkLgo+
IEkgd291bGQgZ290IGZvciBpdCwgdGhhdCB3YXkgd2Ugd291bGQgdGVzdCBib3RoIHRoZSBrZXJu
ZWwgaW1wbGVtbnRhdGlvbgo+IGFuZCB0aGF0IGxpYmMgZG9lcyBzb21ldGhpbmcgc2Vuc2libGUs
IGUuZy4gcmV0dXJucyBlcnJvci4KPgpJJ20gc3RpbGwgcXVpdGUgbmV3IHRvIExUUCwgc28gSSBt
aWdodCBiZSB1bmRlcnN0YW5kaW5nIHRoaW5ncyB3cm9uZy4KCk15IHVuZGVyc3RhbmRpbmcgb2Yg
eW91ciBjb252ZXJzYXRpb24gaXMgdGhhdCB5b3UncmUgc3VnZ2VzdGluZyB1c2luZyAKdGhlIC50
ZXN0X3ZhcmlhbnRzIHRvIGhhdmUgb25lIHZlcnNpb24gb2YgdGhlIHRlc3RzIGdvaW5nIHRocm91
Z2ggdGhlIApsaWJjIHdyYXBwZXJzIGFzIHVzdWFsLCBldmVudHVhbGx5IHNraXBwaW5nIHRoZSB0
ZXN0IHdpdGggVENPTkYgaWYgdGhlIApsaWJjIHdyYXBwZXIgZG9lcyBub3QgaW1wbGVtZW50IHRo
ZSBzeXNjYWxsLCBhbmQgb25lIHZlcnNpb24gd2hpY2ggd291bGQgCmJlIHRoZSB0aGUgZGlyZWN0
IHN5c2NhbGwgSSBhbSBzdWdnZXN0aW5nIGluIHRoaXMgcGF0Y2guCgpXb3VsZCB0aGF0IGJlIGNv
cnJlY3QgPyBJZiBzbyBpdCBkb2VzIG1ha2Ugc2Vuc2UgdG8gbWUsIEkgY291bGQgdHJ5IAppbXBs
ZW1lbnRpbmcgdGhhdC4KCgpCZXN0IHJlZ2FyZHMsClTDqW8KCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
