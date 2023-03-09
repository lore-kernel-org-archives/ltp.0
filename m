Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB46CC64EC4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 09:17:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8BBB3CBA57
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 10:17:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE6033C2A67
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 10:17:35 +0100 (CET)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 99DEB14010D6
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 10:17:31 +0100 (CET)
X-UUID: 4a18580589384840a14c6a621c0e42bb-20230309
X-CPASD-INFO: 98f242d82a96424b92957b7a3e2e62d2@goigUmFkkmhegXuCg3V_nFljaWVnjle
 wdZ9SlWRikFKVhH5xTV5nX1V9gnNXZF5dXFV3dnBQYmBhXVJ3i3-XblBgXoZgUZB3iHqgUmRglA==
X-CLOUD-ID: 98f242d82a96424b92957b7a3e2e62d2
X-CPASD-SUMMARY: SIP:-1, APTIP:-2.0, KEY:0.0, FROMBLOCK:1, OB:0.0, URL:-5,
 TVAL:169.
 0, ESV:0.0, ECOM:-5.0, ML:0.0, FD:0.0, CUTS:168.0, IP:-2.0, MAL:-5.0, PHF:-5.0,
 PHC:-5
 .0, SPF:4.0, EDMS:-5, IPLABEL:4480.0, FROMTO:0, AD:0, FFOB:0.0, CFOB:0.0, SPC:0,
 SIG:-
 5, AUF:6, DUF:17674, ACD:256, DCD:256, SL:0, EISP:0, AG:0, CFC:0.296,
 CFSR:0.063, UAT:0
 , RAF:0, IMG:-5.0, DFA:0, DTA:0, IBL:-2.0, ADI:-5, SBL:0, REDM:0, REIP:0, ESB:0,
 ATTNUM: 0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 4a18580589384840a14c6a621c0e42bb-20230309
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 4a18580589384840a14c6a621c0e42bb-20230309
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
 (envelope-from <gehao@kylinos.cn>) (Generic MTA)
 with ESMTP id 673603044; Thu, 09 Mar 2023 17:17:28 +0800
From: Hao Ge <gehao@kylinos.cn>
To: ltp@lists.linux.it
Date: Thu,  9 Mar 2023 17:16:55 +0800
Message-Id: <20230309091655.225444-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309031517.198523-1-gehao@kylinos.cn>
References: <20230309031517.198523-1-gehao@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH V2] memcg_stress_test.sh: Fix reserved mem calculate
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
Cc: Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

V2hlbiBydW5uaW5nIHRoaXMgdGVzdCBjYXNlIG9uIGEgbWFjaGluZSB3aXRoIGxhcmdlIG1lbW9y
eSwKYW5kIHdpdGhvdXQgc3dhcCBvciBzd2FwIGlzIHRvbyBzbWFsbCxleGlzdGluZyByZXNlcnZl
ZAptZW1vcnkgaXMgdG9vIHNtYWxsIGZvciBhIG1hY2hpbmUgd2l0aCBsYXJnZSBtZW1vcnksYW5k
CndpbGwgY2F1c2UgZm9ya2luZyBhIHN1YnByb2Nlc3MgdG8gcnVuIGEgY29tbWFuZCB3aWxsIGZh
aWwKZHVlIHRvIG1lbW9yeSBpcyBleGhhdXN0ZWQsc28gb3B0aW1pemUgcmVzZXJ2ZWQgbWVtb3J5
CmNhbGN1bGF0ZSB0byB0ZW4gcGVyY2VudCBvZiBmcmVlIG1lbW9yeS4KCkhlcmUgaXMgYW4gZXhh
bXBsZToKCmZyZWUgLW0KICAgICAgICAgICAgICB0b3RhbCAgICAgICAgdXNlZCAgICAgICAgZnJl
ZSAgICAgIHNoYXJlZCAgYnVmZi9jYWNoZSAgIGF2YWlsYWJsZQpNZW06ICAgICAgICAgMjYwMTg0
ICAgICAgICAyOTU5ICAgICAgMjU1ODU0ICAgICAgICAgIDYyICAgICAgICAxMzcwICAgICAgMjM2
MzQ2ClN3YXA6ICAgICAgICAgIDQwOTUgICAgICAgICAgIDAgICAgICAgIDQwOTUKCndoZW4geW91
IHJ1biB0aGlzIHRlc3RjYXNlLGNvbnNvbGUgd2lsbCByZXBvcnQKZm9ya++8mkNhbm5vdCBhbGxv
Y2F0ZSBtZW1vcnkKClNpZ25lZC1vZmYtYnk6IEhhbyBHZSA8Z2VoYW9Aa3lsaW5vcy5jbj4KLS0t
CiAuLi4va2VybmVsL2NvbnRyb2xsZXJzL21lbWNnL3N0cmVzcy9tZW1jZ19zdHJlc3NfdGVzdC5z
aCAgICB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cv
c3RyZXNzL21lbWNnX3N0cmVzc190ZXN0LnNoIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVy
cy9tZW1jZy9zdHJlc3MvbWVtY2dfc3RyZXNzX3Rlc3Quc2gKaW5kZXggY2I1Mjg0MGQ3Li5mMjZh
OWY3MmEgMTAwNzU1Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvc3Ry
ZXNzL21lbWNnX3N0cmVzc190ZXN0LnNoCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxl
cnMvbWVtY2cvc3RyZXNzL21lbWNnX3N0cmVzc190ZXN0LnNoCkBAIC00MCw3ICs0MCw3IEBAIHNl
dHVwKCkKIAlNRU09JCgoICRtZW1fZnJlZSArICRzd2FwX2ZyZWUgLyAyICkpCiAJTUVNPSQoKCAk
TUVNIC8gMTAyNCApKQogCVJVTl9USU1FPSQoKCAxNSAqIDYwICkpCi0JWyAiJHBnc2l6ZSIgPSAi
NDA5NiIgXSAmJiBUSFJFQURfU1BBUkVfTUI9MSB8fCBUSFJFQURfU1BBUkVfTUI9OAorCVJFU0VS
VkVEX01FTU9SWT0kKCggJE1FTSAqIDEwLzEwMCApKQogCiAJdHN0X3JlcyBUSU5GTyAiQ2FsY3Vs
YXRlZCBhdmFpbGFibGUgbWVtb3J5ICRNRU0gTUIiCiB9CkBAIC05MywxMiArOTMsMTIgQEAgcnVu
X3N0cmVzcygpCiAKIHRlc3QxKCkKIHsKLQlydW5fc3RyZXNzIDE1MCAkKCggKCRNRU0gLSAxNTAg
KiAkVEhSRUFEX1NQQVJFX01CKSAvIDE1MCApKSA1ICRSVU5fVElNRQorCXJ1bl9zdHJlc3MgMTUw
ICQoKCAoJE1FTSAtICRSRVNFUlZFRF9NRU1PUlkpIC8gMTUwICkpIDUgJFJVTl9USU1FCiB9CiAK
IHRlc3QyKCkKIHsKLQlydW5fc3RyZXNzIDEgJCgoICRNRU0gLSAkVEhSRUFEX1NQQVJFX01CKSkg
NSAkUlVOX1RJTUUKKwlydW5fc3RyZXNzIDEgJCgoICRNRU0gLSAkUkVTRVJWRURfTUVNT1JZKSkg
NSAkUlVOX1RJTUUKIH0KIAogLiBjZ3JvdXBfbGliLnNoCi0tIAoyLjI1LjEKCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
