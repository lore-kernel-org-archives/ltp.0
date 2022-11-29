Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F010C4321E
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 13:04:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF65D3CC5C2
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 14:04:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22EAE3C714A
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 14:04:01 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id A8ACF600736
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 14:04:00 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D6B9D6E;
 Tue, 29 Nov 2022 05:04:05 -0800 (PST)
Received: from e129169.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C97E13F73D;
 Tue, 29 Nov 2022 05:03:57 -0800 (PST)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Tue, 29 Nov 2022 13:03:47 +0000
Message-Id: <20221129130350.219082-1-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] safe_macros: Fix undefined behaviour in vararg
 handling
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QWNjZXNzaW5nIGVsZW1lbnRzIGluIGFuIGVtcHR5IHZhX2xpc3QgcmVzdWx0cyBpbiB1bmRlZmlu
ZWQgYmVoYXZpb3VyWzBdCnRoYXQgY2FuIGluY2x1ZGUgYWNjZXNzaW5nIGFyYml0cmFyeSBzdGFj
ayBtZW1vcnkuIFdoaWxlIHR5cGljYWxseSB0aGlzCmRvZXNuJ3QgcmFpc2UgYSBmYXVsdCwgc29t
ZSBuZXcgbW9yZSBzZWN1cml0eS1vcmllbnRlZCBhcmNoaXRlY3R1cmVzCihlLmcuIENIRVJJWzFd
IG9yIE1vcmVsbG9bMl0pIGRvbid0IGFsbG93IGl0LgoKVGhlcmVmb3JlLCByZW1vdmUgdGhlIHZh
cmlhZGljbmVzcyBmcm9tIHNhZmVfKiB3cmFwcGVycyB0aGF0IGFsd2F5cyBjYWxsCnRoZSBmdW5j
dGlvbnMgd2l0aCB0aGUgb3B0aW9uYWwgYXJndW1lbnQgaW5jbHVkZWQuCgpBZGFwdCB0aGUgcmVz
cGVjdGl2ZSBTQUZFXyogbWFjcm9zIHRvIGhhbmRsZSB0aGUgY2hhbmdlIGJ5IHBhc3NpbmcgYQpk
ZWZhdWx0IGFyZ3VtZW50IGlmIHRoZXkncmUgb21pdHRlZC4KClswXTogW0lTTy9JRUMgOTg5OToy
MDExXSBQcm9ncmFtbWluZyBMYW5ndWFnZXPigJRDLCAzcmQgZWQsIHBhcmFncmFwaCA3LjE2LjEu
MQpbMV06IGh0dHBzOi8vd3d3LmNsLmNhbS5hYy51ay9yZXNlYXJjaC9zZWN1cml0eS9jdHNyZC9j
aGVyaS8KWzJdOiBodHRwczovL3d3dy5tb3JlbGxvLXByb2plY3Qub3JnLwoKdjIuLnYxOgogIC0g
UEFUQ0ggMTogUmVtb3ZlIHRoZSBOVUxMIGFyZ3VtZW50IGZvciBtb2RlIGZyb20gU0FGRV9PUEVO
IGluc3RhbmNlcwogICAgdG8gYXZvaWQgdGhlIHBvaW50ZXIgdG8gaW50IGNvbnZlcnNpb24uCgpU
dWRvciBDcmV0dSAoMyk6CiAgc2FmZV9vcGVuOiBGaXggdW5kZWZpbmVkIGJlaGF2aW91ciBpbiB2
YXJhcmcgaGFuZGxpbmcKICBzYWZlX29wZW5hdDogRml4IHVuZGVmaW5lZCBiZWhhdmlvdXIgaW4g
dmFyYXJnIGhhbmRsaW5nCiAgc2FmZV9zZW1jdGw6IEZpeCB1bmRlZmluZWQgYmVoYXZpb3VyIGlu
IHZhcmFyZyBoYW5kbGluZwoKIGluY2x1ZGUvb2xkL3NhZmVfbWFjcm9zLmggICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgNiArKysrLS0KIGluY2x1ZGUvc2FmZV9tYWNyb3NfZm4uaCAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMyArKy0KIGluY2x1ZGUvdHN0X3NhZmVfZmlsZV9hdC5oICAg
ICAgICAgICAgICAgICAgICAgICAgfCAxMCArKysrKystLS0tCiBpbmNsdWRlL3RzdF9zYWZlX21h
Y3Jvcy5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKy0tCiBpbmNsdWRlL3RzdF9z
YWZlX3N5c3ZfaXBjLmggICAgICAgICAgICAgICAgICAgICAgIHwgMTQgKysrKysrKysrLS0tLS0K
IGxpYi9zYWZlX21hY3Jvcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMyAr
LS0tLS0tLS0tLS0tCiBsaWIvdHN0X2Nncm91cC5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDIgKy0KIGxpYi90c3Rfc2FmZV9maWxlX2F0LmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAxMSArKystLS0tLS0tLQogbGliL3RzdF9zYWZlX3N5c3ZfaXBjLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDEwICstLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZmdldHhhdHRyL2ZnZXR4YXR0cjAxLmMgfCAgMiArLQogdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9mZ2V0eGF0dHIvZmdldHhhdHRyMDIuYyB8ICAyICstCiB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2ZnZXR4YXR0ci9mZ2V0eGF0dHIwMy5jIHwgIDIgKy0KIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZnNldHhhdHRyL2ZzZXR4YXR0cjAxLmMgfCAgMiArLQogdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9mc2V0eGF0dHIvZnNldHhhdHRyMDIuYyB8ICAyICstCiAxNCBmaWxlcyBj
aGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCA0OSBkZWxldGlvbnMoLSkKCi0tIAoyLjI1LjEKCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
