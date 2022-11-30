Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0AAC4332F
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 13:37:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB14C3CC535
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 14:37:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8FC73CC50C
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:37:05 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id EB5B8600915
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 14:37:04 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BF4AD6E;
 Wed, 30 Nov 2022 05:37:09 -0800 (PST)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 497D33F73D;
 Wed, 30 Nov 2022 05:37:01 -0800 (PST)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Wed, 30 Nov 2022 13:36:16 +0000
Message-Id: <20221130133619.632073-1-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] safe_macros: Fix undefined behaviour in vararg
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
LwpbMl06IGh0dHBzOi8vd3d3Lm1vcmVsbG8tcHJvamVjdC5vcmcvCgp2My4udjI6CiAgLSBTZXBh
cmF0ZSB0aGUgZntnZXQsc2V0fXhhdHRyIGNoYW5nZXMgaW50byBhIG5ldyBwYXRjaDogUEFUQ0gg
MS8zCiAgLSBEb24ndCByZW1vdmUgdGhlIHZhcmlhZGljbmVzcyBmcm9tIHNhZmVfKiB3cmFwcGVy
cyBhbnltb3JlLCBidXQgb25seQogICAgcmVhZCB0aGUgdmFyaWFkaWMgYXJndW1lbnRzIGluIHRo
ZSBjYXNlcyB3aGVyZSBpdCdzIGV4cGVjdGVkCiAgLSBSZW1vdmUgdGhlIGNoYW5nZXMgdG8gU0FG
RV8qIG1hY3JvcyBhcyB0aGV5J3JlIG5vdCBuZWVkZWQgYW55bW9yZQogIC0gQWRkIGluY2x1ZGUv
bGFwaS9pcGMuaCB0byBkZWZpbmUgSVBDX0lORk8KICAtIGRlZmluZSBfX09QRU5fTkVFRFNfTU9E
RSBzaW1pbGFyIHRvIHRoZSBjb25kaXRpb25zIHVzZWQgaW4gc3VwcG9ydGVkCiAgICBsaWJjcyAo
Z2xpYmMsIG11c2wsIHVjbGliYywgYW5kIEJpb25pYyksIHRvIGJlIHNoYXJlZCBieSBib3RoCiAg
ICBzYWZlX29wZW4gYW5kIHNhZmVfb3BlbmF0LgogIC0gVGhlIHN3aXRjaCBjYXNlIGluIHNhZmVf
c2VtY3RsIGlzIHRoZSBzYW1lIGFzIHRoZSBvbmUgdXNlZCBpbiBnbGliYywKICAgIGFuZCBmdW5j
dGlvbmFsbHkgc2ltaWxhciB0byB0aGUgb25lIHVzZWQgaW4gTXVzbC4gQmlvbmljIGFuZCB1Y2xp
YmMKICAgIGRvbid0IGhhdmUgYSBzaW1pbGFyIHN3aXRjaCBjYXNlLCB0aGV5IHJlYWQgdGhlIHVu
aW9uIHNlbXVuIHZhcmFyZwogICAgdW5jb25kaXRpb25hbGx5LgogIC0gVGVzdGVkIHdpdGggYm90
aCBnbGliYyBhbmQgTXVzbAoKdjIuLnYxOgogIC0gUEFUQ0ggMTogUmVtb3ZlIHRoZSBOVUxMIGFy
Z3VtZW50IGZvciBtb2RlIGZyb20gU0FGRV9PUEVOIGluc3RhbmNlcwogICAgdG8gYXZvaWQgdGhl
IHBvaW50ZXIgdG8gaW50IGNvbnZlcnNpb24uCgpUdWRvciBDcmV0dSAoMyk6CiAgc3lzY2FsbHMv
ZntnZXQsc2V0fXhhdHRyOiBEb24ndCBwYXNzIGEgcG9pbnRlciB0byBtb2RlIGFyZ3VtZW50IGlu
CiAgICBvcGVuCiAgc2FmZV9vcGVuLCBzYWZlX29wZW5hdDogRml4IHVuZGVmaW5lZCBiZWhhdmlv
dXIgaW4gdmFyYXJnIGhhbmRsaW5nCiAgc2FmZV9zZW1jdGw6IEZpeCB1bmRlZmluZWQgYmVoYXZp
b3VyIGluIHZhcmFyZyBoYW5kbGluZwoKIGluY2x1ZGUvbGFwaS9mY250bC5oICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICA1ICsrKysKIGluY2x1ZGUvbGFwaS9pcGMuaCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IDE0ICsrKysrKysrKysrCiBsaWIvc2FmZV9tYWNyb3MuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAyMSArKysrKysrKystLS0tLS0tLQogbGliL3RzdF9zYWZl
X2ZpbGVfYXQuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgMTMgKysrKysrKy0tLS0KIGxpYi90
c3Rfc2FmZV9zeXN2X2lwYy5jICAgICAgICAgICAgICAgICAgICAgICB8IDIzICsrKysrKysrKysr
KystLS0tLS0KIC4uLi9rZXJuZWwvc3lzY2FsbHMvZmdldHhhdHRyL2ZnZXR4YXR0cjAxLmMgICB8
ICAyICstCiAuLi4va2VybmVsL3N5c2NhbGxzL2ZnZXR4YXR0ci9mZ2V0eGF0dHIwMi5jICAgfCAg
MiArLQogLi4uL2tlcm5lbC9zeXNjYWxscy9mZ2V0eGF0dHIvZmdldHhhdHRyMDMuYyAgIHwgIDIg
Ky0KIC4uLi9rZXJuZWwvc3lzY2FsbHMvZnNldHhhdHRyL2ZzZXR4YXR0cjAxLmMgICB8ICAyICst
CiAuLi4va2VybmVsL3N5c2NhbGxzL2ZzZXR4YXR0ci9mc2V0eGF0dHIwMi5jICAgfCAgMiArLQog
MTAgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCiBjcmVh
dGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9sYXBpL2lwYy5oCgotLSAKMi4yNS4xCgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
