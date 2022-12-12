Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E1CC4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 18:28:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A63973CBE5B
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 19:28:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CA5B3C1BCA
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 19:28:20 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id C72781000601
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 19:28:18 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D06C1FB;
 Mon, 12 Dec 2022 10:28:56 -0800 (PST)
Received: from [10.57.42.36] (unknown [10.57.42.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC4323F73B;
 Mon, 12 Dec 2022 10:28:14 -0800 (PST)
Message-ID: <4b38f13f-a8a1-bbde-9103-9900f0cf5a88@arm.com>
Date: Mon, 12 Dec 2022 18:28:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20221207092428.11798-1-teo.coupriediaz@arm.com>
 <871qp4u02j.fsf@suse.de> <Y5dHRcLD1359Rm3o@pevik>
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <Y5dHRcLD1359Rm3o@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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

SGkgUGV0ciwKCk9uIDEyLzEyLzIwMjIgMTU6MjIsIFBldHIgVm9yZWwgd3JvdGU6Cj4gSGkgUmlj
aGllLAo+Cj4+IEN5cmlsLCBQZXRyLCBXb3VsZCB5b3UgbGlrZSB0byBhZGQgeW91ciByZXZpZXdl
ZCBieSB0YWdzPyBUaGVuIHdlIGNhbgo+PiBtZXJnZSB0aGlzLgo+IEJ5IGFjY2lkZW50IEkgcmVw
bHkgdG8gbXkgcG9pbnRzIHRvIHYxIFsxXS4KPiBUbyBjb3B5IGl0IGhlcmU6Cj4KPiAxKSBUaGVy
ZSBhcmUgd2FybmluZ3M6Cj4gYnJrMDIuYzogSW4gZnVuY3Rpb24g4oCYYnJrX3ZhcmlhbnRz4oCZ
Ogo+IGJyazAyLmM6MjY6Mjg6IHdhcm5pbmc6IGNhc3QgdG8gcG9pbnRlciBmcm9tIGludGVnZXIg
b2YgZGlmZmVyZW50IHNpemUKPiBbLVdpbnQtdG8tcG9pbnRlci1jYXN0XQo+ICAgICAyNiB8ICAg
ICAgICAgICAgICAgICBicmtfYWRkciA9ICh2b2lkICopYnJrKGFkZHIpOwo+ICAgICAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KPgo+IDIpIG1ha2UgY2hlY2sgcmVwb3J0cyBl
cnJvcnMgd2hpY2ggYXJlIGVhc2lseSBmaXhlZC4KPgo+IFRlbyByZXBsaWVkIFsyXSwgdGhhdCBo
ZSdzIGdvaW5nIHRvIGZpeCBpdC4gSSB0aG91Z2h0IEkgaGFkIHNldCBpdAo+ICJDaGFuZ2VzIHJl
cXVlc3RlZCIsIGJ1dCBub3cgSSBzZWUgIk5lZWRzIFJldmlldyAvIEFDSyIuIFNldHRpbmcgaXQg
dG8KPiAiQ2hhbmdlcyByZXF1ZXN0ZWQiLgoKSSBiZWxpZXZlIHRoZSBwb2ludHMgeW91IHJhaXNl
ZCBhcmUgZml4ZWQgaW4gdGhlIHYyLCBvbiB0b3Agb2YgdGhpcyB0aHJlYWQuClJlLWFwcGx5aW5n
IGl0IG9uIHRvcCBvZiBtYXN0ZXIgb24gbXkgc2lkZSBkb2Vzbid0IGdpdmUgbWUgYW55IHdhcm5p
bmdzIApmb3IgdGhlIGJyayB0ZXN0cywgYXMgSSBkbyBub3QgY2FzdCB0aGUgcmVzdWx0IGZyb20g
dGhlIGxpYmMgYnJrIAphbnltb3JlLCBhbmQgbWFrZSBjaGVjayByZXBvcnRzIGV4aXN0aW5nIGlz
c3VlcyB3aXRoIHRoZSBuYW1lIG9mIHRoZSAKZnVuY3Rpb24sIGJ1dCBubyBzdHlsZSBwcm9ibGVt
cyB0aGF0IGRpZCBleGlzdCBpbiB2MS4gKEkgZG9uJ3QgbWluZCAKY2hhbmdpbmcgdGhlbSBpZiB5
b3Ugd2FudCwgYnV0IHRoZXkgYXJlIHByZXNlbnQgb24gbWFzdGVyIGFzIHdlbGwpLgoKSWYgeW91
IGdpdmUgYSBxdWljayBsb29rIGF0IHRoZSBwYXRjaCB2MiB5b3UnbGwgc2VlIHRoYXQgaW5kZWVk
IHRoZXJlIGlzIApubyBtb3JlICh2b2lkICopYnJrKGFkZHIpIG9yIHN1Y2ggdGhhdCBnZW5lcmF0
ZWQgdGhlIHdhcm5pbmdzLCBmb3IgCmV4YW1wbGUuIChUaGUgc3lzY2FsbHMgc3RpbGwgbmVlZCBp
dCwgYXMgdGhleSByZXR1cm4gdGhlIGJyZWFrIGRpcmVjdGx5IApyYXRoZXIgdGhhbiBhbiBlcnJv
ciwgd2hpY2ggaXMgd2hhdCB0aGUgbGliYyB3cmFwcGVyIGRvZXMuKQoKSSBtaWdodCBiZSBtaXNz
aW5nIHNvbWV0aGluZywgcGxlYXNlIGRvIHRlbGwgbWUgaWYgdGhhdCdzIHRoZSBjYXNlICEgQnV0
IApJIGJlbGlldmUgdGhhdCB0aGUgdjIgX3Nob3VsZF8gYmUgZnJlZSBvZiB0aG9zZSBpc3N1ZXMu
Cgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bHRwLzIwMjIxMjA2MTQwNDIxLkdCMjE4MzlAcGV2aWsvCj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2x0cC9mZTFjNWJhYy0wZWQxLTkyZWYtM2MyOC1lMzc1OGRjMzQ2NWRAYXJtLmNvbS8K
VGhhbmtzIGZvciB0YWtpbmcgdGhlIHRpbWUuCkJlc3QgcmVnYXJkcywKVMOpbwoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
