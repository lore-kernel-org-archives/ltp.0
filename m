Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC29C4332F
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 14:22:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C3253CC541
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 15:22:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE1253CA96F
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 15:22:37 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id D21A62009C5
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 15:22:35 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52546D6E;
 Wed, 30 Nov 2022 06:22:40 -0800 (PST)
Received: from [10.57.37.211] (unknown [10.57.37.211])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B5253F73D;
 Wed, 30 Nov 2022 06:22:33 -0800 (PST)
Message-ID: <3511407c-df92-7097-2193-e2ee82b02350@arm.com>
Date: Wed, 30 Nov 2022 14:22:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20221128091508.75414-1-teo.coupriediaz@arm.com>
 <Y4UMUqkLijWXOWu6@pevik> <Y4YEnmDLD7AEMHrr@yuki> <Y4YK6uhK94C0vrVR@pevik>
 <Y4YLvhQfIW1SW1XB@yuki> <448cb776-770d-3235-c0d9-3c9005663790@arm.com>
 <Y4dXWopbsqbyDZMF@yuki>
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <Y4dXWopbsqbyDZMF@yuki>
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

SGksCgpPbiAzMC8xMS8yMDIyIDEzOjE1LCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gSGkhCj4+Pj4g
V0RZVCBhYm91dCAudGVzdF92YXJpYW50cz8gSW4gdGhhdCBjYXNlIGl0J2QgYmUgdGVzdGVkIGFs
c28gb24gbXVzbAo+Pj4+IG9yIGFueSBwbGF0Zm9ybSB3aGVyZSBpdCdzIGltcGxlbWVudGVkLgo+
Pj4gSSB3b3VsZCBnb3QgZm9yIGl0LCB0aGF0IHdheSB3ZSB3b3VsZCB0ZXN0IGJvdGggdGhlIGtl
cm5lbCBpbXBsZW1udGF0aW9uCj4+PiBhbmQgdGhhdCBsaWJjIGRvZXMgc29tZXRoaW5nIHNlbnNp
YmxlLCBlLmcuIHJldHVybnMgZXJyb3IuCj4+Pgo+PiBJJ20gc3RpbGwgcXVpdGUgbmV3IHRvIExU
UCwgc28gSSBtaWdodCBiZSB1bmRlcnN0YW5kaW5nIHRoaW5ncyB3cm9uZy4KPj4KPj4gTXkgdW5k
ZXJzdGFuZGluZyBvZiB5b3VyIGNvbnZlcnNhdGlvbiBpcyB0aGF0IHlvdSdyZSBzdWdnZXN0aW5n
IHVzaW5nCj4+IHRoZSAudGVzdF92YXJpYW50cyB0byBoYXZlIG9uZSB2ZXJzaW9uIG9mIHRoZSB0
ZXN0cyBnb2luZyB0aHJvdWdoIHRoZQo+PiBsaWJjIHdyYXBwZXJzIGFzIHVzdWFsLCBldmVudHVh
bGx5IHNraXBwaW5nIHRoZSB0ZXN0IHdpdGggVENPTkYgaWYgdGhlCj4+IGxpYmMgd3JhcHBlciBk
b2VzIG5vdCBpbXBsZW1lbnQgdGhlIHN5c2NhbGwsIGFuZCBvbmUgdmVyc2lvbiB3aGljaCB3b3Vs
ZAo+PiBiZSB0aGUgdGhlIGRpcmVjdCBzeXNjYWxsIEkgYW0gc3VnZ2VzdGluZyBpbiB0aGlzIHBh
dGNoLgo+Pgo+PiBXb3VsZCB0aGF0IGJlIGNvcnJlY3QgPyBJZiBzbyBpdCBkb2VzIG1ha2Ugc2Vu
c2UgdG8gbWUsIEkgY291bGQgdHJ5Cj4+IGltcGxlbWVudGluZyB0aGF0Lgo+IFllcywgZXhhY3Rs
eSB0aGlzLgoKR3JlYXQsIHRoYW5rcyA6IEkgd2lsbCBpbXBsZW1lbnQgdGhpcyBhbmQgc2VuZCBh
IHJldmlzaW9uIHdoZW4gaXQncyBkb25lICEKCkJlc3QgcmVnYXJkcywKVMOpbwoKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
