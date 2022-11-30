Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15C5C433FE
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 15:08:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E59C3CC524
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 16:08:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BCE43CC510
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 16:07:46 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id BC6981A0090B
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 16:07:45 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BADBD6E;
 Wed, 30 Nov 2022 07:07:50 -0800 (PST)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92BBB3F73D;
 Wed, 30 Nov 2022 07:07:42 -0800 (PST)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Wed, 30 Nov 2022 15:07:35 +0000
Message-Id: <20221130150738.745960-1-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/3] safe_macros: Fix undefined behaviour in vararg
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
IG9yIE1vcmVsbG9bMl0pIGRvbid0IGFsbG93IGl0LgoKWzBdOiBbSVNPL0lFQyA5ODk5OjIwMTFd
IFByb2dyYW1taW5nIExhbmd1YWdlc+KAlEMsIDNyZCBlZCwgcGFyYWdyYXBoIDcuMTYuMS4xClsx
XTogaHR0cHM6Ly93d3cuY2wuY2FtLmFjLnVrL3Jlc2VhcmNoL3NlY3VyaXR5L2N0c3JkL2NoZXJp
LwpbMl06IGh0dHBzOi8vd3d3Lm1vcmVsbG8tcHJvamVjdC5vcmcvCgp2NC4udjM6CiAgLSBSZW5h
bWVkIF9fT1BFTl9ORUVEU19NT0RFIHRvIFRTVF9PUEVOX05FRURTX01PREUKCnYzLi52MjoKICAt
IFNlcGFyYXRlIHRoZSBme2dldCxzZXR9eGF0dHIgY2hhbmdlcyBpbnRvIGEgbmV3IHBhdGNoOiBQ
QVRDSCAxLzMKICAtIERvbid0IHJlbW92ZSB0aGUgdmFyaWFkaWNuZXNzIGZyb20gc2FmZV8qIHdy
YXBwZXJzIGFueW1vcmUsIGJ1dCBvbmx5CiAgICByZWFkIHRoZSB2YXJpYWRpYyBhcmd1bWVudHMg
aW4gdGhlIGNhc2VzIHdoZXJlIGl0J3MgZXhwZWN0ZWQKICAtIFJlbW92ZSB0aGUgY2hhbmdlcyB0
byBTQUZFXyogbWFjcm9zIGFzIHRoZXkncmUgbm90IG5lZWRlZCBhbnltb3JlCiAgLSBBZGQgaW5j
bHVkZS9sYXBpL2lwYy5oIHRvIGRlZmluZSBJUENfSU5GTwogIC0gZGVmaW5lIF9fT1BFTl9ORUVE
U19NT0RFIHNpbWlsYXIgdG8gdGhlIGNvbmRpdGlvbnMgdXNlZCBpbiBzdXBwb3J0ZWQKICAgIGxp
YmNzIChnbGliYywgbXVzbCwgdWNsaWJjLCBhbmQgQmlvbmljKSwgdG8gYmUgc2hhcmVkIGJ5IGJv
dGgKICAgIHNhZmVfb3BlbiBhbmQgc2FmZV9vcGVuYXQuCiAgLSBUaGUgc3dpdGNoIGNhc2UgaW4g
c2FmZV9zZW1jdGwgaXMgdGhlIHNhbWUgYXMgdGhlIG9uZSB1c2VkIGluIGdsaWJjLAogICAgYW5k
IGZ1bmN0aW9uYWxseSBzaW1pbGFyIHRvIHRoZSBvbmUgdXNlZCBpbiBNdXNsLiBCaW9uaWMgYW5k
IHVjbGliYwogICAgZG9uJ3QgaGF2ZSBhIHNpbWlsYXIgc3dpdGNoIGNhc2UsIHRoZXkgcmVhZCB0
aGUgdW5pb24gc2VtdW4gdmFyYXJnCiAgICB1bmNvbmRpdGlvbmFsbHkuCiAgLSBUZXN0ZWQgd2l0
aCBib3RoIGdsaWJjIGFuZCBNdXNsCgp2Mi4udjE6CiAgLSBQQVRDSCAxOiBSZW1vdmUgdGhlIE5V
TEwgYXJndW1lbnQgZm9yIG1vZGUgZnJvbSBTQUZFX09QRU4gaW5zdGFuY2VzCiAgICB0byBhdm9p
ZCB0aGUgcG9pbnRlciB0byBpbnQgY29udmVyc2lvbi4KClR1ZG9yIENyZXR1ICgzKToKICBzeXNj
YWxscy9me2dldCxzZXR9eGF0dHI6IERvbid0IHBhc3MgYSBwb2ludGVyIHRvIG1vZGUgYXJndW1l
bnQgaW4KICAgIG9wZW4KICBzYWZlX29wZW4sIHNhZmVfb3BlbmF0OiBGaXggdW5kZWZpbmVkIGJl
aGF2aW91ciBpbiB2YXJhcmcgaGFuZGxpbmcKICBzYWZlX3NlbWN0bDogRml4IHVuZGVmaW5lZCBi
ZWhhdmlvdXIgaW4gdmFyYXJnIGhhbmRsaW5nCgogaW5jbHVkZS9sYXBpL2ZjbnRsLmggICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDMgKysrCiBpbmNsdWRlL2xhcGkvaXBjLmggICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAxNCArKysrKysrKysrKwogbGliL3NhZmVfbWFjcm9zLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjEgKysrKysrKysrLS0tLS0tLS0KIGxpYi90c3Rf
c2FmZV9maWxlX2F0LmMgICAgICAgICAgICAgICAgICAgICAgICB8IDEzICsrKysrKystLS0tCiBs
aWIvdHN0X3NhZmVfc3lzdl9pcGMuYyAgICAgICAgICAgICAgICAgICAgICAgfCAyMyArKysrKysr
KysrKysrLS0tLS0tCiAuLi4va2VybmVsL3N5c2NhbGxzL2ZnZXR4YXR0ci9mZ2V0eGF0dHIwMS5j
ICAgfCAgMiArLQogLi4uL2tlcm5lbC9zeXNjYWxscy9mZ2V0eGF0dHIvZmdldHhhdHRyMDIuYyAg
IHwgIDIgKy0KIC4uLi9rZXJuZWwvc3lzY2FsbHMvZmdldHhhdHRyL2ZnZXR4YXR0cjAzLmMgICB8
ICAyICstCiAuLi4va2VybmVsL3N5c2NhbGxzL2ZzZXR4YXR0ci9mc2V0eGF0dHIwMS5jICAgfCAg
MiArLQogLi4uL2tlcm5lbC9zeXNjYWxscy9mc2V0eGF0dHIvZnNldHhhdHRyMDIuYyAgIHwgIDIg
Ky0KIDEwIGZpbGVzIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGFwaS9pcGMuaAoKLS0gCjIuMjUuMQoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
