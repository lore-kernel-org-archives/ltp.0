Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD04FC4332F
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 10:03:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54B7D3CBD1E
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 11:03:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDCE33CBCFE
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 11:03:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 76D0360045E
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 11:03:43 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EED9FEC;
 Wed, 14 Dec 2022 02:04:21 -0800 (PST)
Received: from [10.57.41.215] (unknown [10.57.41.215])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 204323F5A1;
 Wed, 14 Dec 2022 02:03:40 -0800 (PST)
Message-ID: <bcbe5dc0-c8e2-5849-15fc-226b5afe7ed0@arm.com>
Date: Wed, 14 Dec 2022 10:03:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To: Petr Vorel <pvorel@suse.cz>
References: <20221207092428.11798-1-teo.coupriediaz@arm.com>
 <871qp4u02j.fsf@suse.de> <Y5dHRcLD1359Rm3o@pevik>
 <4b38f13f-a8a1-bbde-9103-9900f0cf5a88@arm.com> <Y5eA7WeAV4b/Cp8d@pevik>
 <a2f0fa00-f14f-e394-c5cb-f2916cdc1271@arm.com> <Y5jLt3e3xODIcj8d@pevik>
Content-Language: en-US
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <Y5jLt3e3xODIcj8d@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/brk: add direct syscall tst_variant
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

SGkgUGV0ciwKCk9uIDEzLzEyLzIwMjIgMTk6MDAsIFBldHIgVm9yZWwgd3JvdGU6Cj4gSGkgVGVv
LAo+Cj4gLi4uCj4+PiBMb29raW5nIG9uIGV4dHJhIGJyaygpIHN1cHBvcnQgZGV0ZWN0aW9uLCB5
b3UgbXVzdCBoYXZlIHRlc3RlZCBpdCBvbiBBbHBpbmUuCj4+PiBXaGF0IGFtIEkgbWlzc2luZz8K
Pj4gVGhhdCBpcyBxdWl0ZSBzdHJhbmdlIGluZGVlZC4gQXMgUmljaGFyZCBwb2ludGVkIG91dCBp
biBoaXMgcmVwbHkgdG8gdGhpcwo+PiBtZXNzYWdlLCB0aG9zZSB3YXJuaW5ncyBzaG91bGQgbm90
IGhhcHBlbiBhbnltb3JlIHNpbmNlIG15IHBhdGNoIHRoYXQKPj4gY2hhbmdlZCB0c3Rfc3lzY2Fs
bCB0byB1c2UgaW50cHRyX3QuICggZTVkMmEwNWE5MGU1IDogcmVnZW4uc2g6IFVzZSBpbnRwdHJf
dAo+PiBmb3IgdHN0X3N5c2NhbGwgcmV0dXJuICkKPj4gSG93ZXZlciwgSSBiZWxpZXZlIHRoYXQg
dGhlIHJlbGV2YW50IGhlYWRlciBpcyBvbmx5IHJlZ2VuZXJhdGVkIHdoZW4gcnVubmluZwo+PiAu
L2NvbmZpZ3VyZSAsIG5vdCB3aGVuIGJ1aWxkaW5nIG5vcm1hbGx5LiBJIGtub3cgdGhhdCBJIGZv
cmdvdCB0byBkbyBpdCBhCj4+IGZldyB0aW1lcyBteXNlbGYgd2hpbGUgdGVzdGluZyB0aGUgY2hh
bmdlIHRvIHRzdF9zeXNjYWxsICEKPj4gVG8gYmUgc3VyZSB0aGF0IGl0IGlzIHN1cHBvc2VkIHRv
IHdvcmssIEkgZGlkIHRoZSBmb2xsb3dpbmcgb24gYW4gQWxwaW5lIFZNCj4+IEkgdXNlZCBmb3Ig
dGVzdGluZyA6Cj4+IG1ha2UgY2xlYW4KPj4gbWFrZSBhdXRvdG9vbHMKPj4gLi9jb25maWd1cmUK
PiBJJ20gc29ycnkgdG8gZm9yZ2V0IGJhc2ljIExUUCB0aGluZ3MuIFNldHVwIHdhcyByZWFsbHkg
b2xkLCB0aHVzIHJlcnVubmluZwo+IGNvbmZpZ3VyZSB3YXMgbmVlZGVkLgo+IE5vIG1vcmUgb2Jq
ZWN0aW9ucyBmcm9tIG15IHNpZGUsIG1lcmdlZCB3aXRoIGNoYW5nZXMgSSBwcmV2aW91c2x5IHBv
c3RlZAo+ICh0byBrZWVwIGNoZWNrcyBoYXBweSkuClRoYXQgbWFrZXMgc2Vuc2UsIG5vIHdvcnJp
ZXMgIQo+Cj4gVGhhbmsgeW91IQo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKVGhhbmtzIGZvciB0
aGUgdGhvcm91Z2ggcmV2aWV3IGFuZCB0ZXN0aW5nICEKS2luZCByZWdhcmRzLApUw6lvCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
