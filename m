Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA479FA3740
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 16:38:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EE3F3CA918
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 18:38:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A7623CA7E1
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 18:38:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 040DF1401106
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 18:38:18 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33AC623A
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 09:38:23 -0700 (PDT)
Received: from e126380.arm.com (unknown [10.57.4.207])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DC783F7B4
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 09:38:16 -0700 (PDT)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Thu, 27 Oct 2022 17:36:53 +0100
Message-Id: <20221027163654.414017-1-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 0/1] Change return type of tst_syscall
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

SGVsbG8gTFRQIG1haW50YWluZXJzLAoKVGhlIGdvYWwgb2YgdGhpcyBwYXRjaCBpcyB0byBjaGVj
ayB0aGF0IHRoZSBjaGFuZ2UgbWFrZXMgc2Vuc2UsIHRoYXQgSQpoYXZlbid0IG1pc3NlZCBhbnl0
aGluZyBpbiBteSB0ZXN0aW5nIGFuZCB0aGF0IGl0IGRvZXNuJ3QgYnJlYWsgc29tZQphc3N1bXB0
aW9ucyB0aGF0IExUUCBtaWdodCBtYWtlLgoKQ3VycmVudGx5LCB0c3Rfc3lzY2FsbCBzdG9yZXMg
dGhlIHJldHVybiB2YWx1ZSBvZiB0aGUgc3lzY2FsbCBpbiBhbiBpbnQsCndoaWNoIGlzIGZpbmUg
bW9zdCBvZiB0aGUgdGltZSBidXQgc29tZSBzeXNjYWxscyBjYW4gcmV0dXJuIHZhbHVlcyBsYXJn
ZXIKdGhhbiBhbiBpbnQuCkZvciBleGFtcGxlIGB3cml0ZWAgcmV0dXJucyBhIGxvbmcgYW5kIGBt
bWFwYCByZXR1cm5zIGEgcG9pbnRlci4gX01vc3RfIG9mCnRoZSB0aW1lIGl0IHdvdWxkIGJlIGZp
bmUsIGJ1dCBpdCBtZWFucyB0aGF0IGEgdGVzdCB1c2luZyBzdWNoIGEgc3lzY2FsbAp3cml0dGVu
IHdpdGggdHN0X3N5c2NhbGwgd291bGQgYmUgaW5jb3JyZWN0LCBhcyBpdHMgcmV0dXJuIHZhbHVl
IHdvdWxkIGJlCnRydW5jYXRlZC4KVGhpcyB3YXMgZGlzY292ZXJlZCB3aGlsZSB3b3JraW5nIG9u
IGEgcGF0Y2ggdGVzdGluZyBgYnJrYCBkaXJlY3RseSwKd2l0aG91dCBnb2luZyB0aHJvdWdoIHRo
ZSBsaWJjLCBhcyBgYnJrYCByZXR1cm5zIGFuIHVuc2lnbmVkIGxvbmcuCgpUaGlzIHBhdGNoZSBm
aXhlcyB0aGUgdHlwZSBieSB1c2luZyBgaW50cHRyX3RgIHRvIGtlZXAgaXQgc2lnbmVkLAphbmQg
YmVjYXVzZSBpdCBndWFyYW50ZWVzIHRoYXQgaXQgY2FuIGJlIGNhc3QgdG8gYW5kIGZyb20gYSBw
b2ludGVyIHR5cGUsCndoaWNoIGlzIG9uZSBvZiB0aGUgcHJpbWFyeSB1c2UgY2FzZXMgaGVyZS4K
QXMgc3VjaCwgaXQgYWxzbyB3b3VsZCB3b3JrIG9uIGFyY2hpdGVjdHVyZXMgdGhhdCBoYXZlIHBv
aW50ZXJzIGJpZ2dlcgp0aGFuIGxvbmcsIHN1Y2ggYXMgQ0hFUklbMF0gb3IgTW9yZWxsb1sxXS4K
ClRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBjaGFuZ2UgZGlkbid0IGltcGFjdCBhbHJlYWR5IHdyaXR0
ZW4gdGVzdHMsIEkKZ2VuZXJhdGVkIGEgbGlzdCBmcm9tIHRoZSBzb3VyY2UgZmlsZXMgdGhhdCB1
c2UgYHRzdF9zeXNjYWxsYCBhbmQgcmFuCnRoZW0gYWxsLgpIb3BlZnVsbHkgSSBkaWRuJ3QgbWlz
cyBhbnl0aGluZyBoZXJlOiB0aGUgbGlzdCBpcyBwcm92aWRlZCBpbiB0aGUKcGF0Y2ggZm9yIHlv
dXIgdGVzdGluZyBwdXJwb3NlcyBidXQgd291bGQgcHJvYmFibHkgbm90IG1ha2Ugc2Vuc2UKdG8g
bWVyZ2UuCkkgdGVzdGVkIHRoZSBwYXRjaCBvbiB4ODZfNjQtbXVzbCBhbmQgQWFyY2g2NC1tdXNs
IChRRU1VIGFuZCBBcm0gRlZQKQp3aXRoIHRoaXMgbGlzdCBvZiB0ZXN0cywgd2l0aG91dCByZWdy
ZXNzaW9ucy4KClRoZSBidWlsZCBDSSBvbiBHaXRodWIgaXMgYWxsIGdyZWVuIGFzIHdlbGwgOgpo
dHRwczovL2dpdGh1Yi5jb20vVGVvLUNEL2x0cC9hY3Rpb25zL3J1bnMvMzMzNzk1NzIwOQoKCkkg
aG9wZSB0aGF0IHRoaXMgYWxsIG1ha2VzIHNlbnNlIGFuZCBjYW4gYmUgdXNlZnVsIGZvciBMVFAu
IEkgd291bGQgYmUKZ2xhZCB0byBrbm93IGlmIHRoaXMgaGFzIGNvbnNlcXVlbmNlcyBJIGRvbid0
IHNlZSBvciBpZiBJJ20gd3JvbmcgaW4gbXkKcmVhc29uaW5nICEKCkJlc3QgcmVnYXJkcywKVMOp
byBDb3VwcmllIERpYXoKClswXTogaHR0cHM6Ly93d3cuY2wuY2FtLmFjLnVrL3Jlc2VhcmNoL3Nl
Y3VyaXR5L2N0c3JkL2NoZXJpLwpbMV06IGh0dHBzOi8vd3d3Lm1vcmVsbG8tcHJvamVjdC5vcmcv
CgpUZW8gQ291cHJpZSBEaWF6ICgxKToKICByZWdlbi5zaDogVXNlIGludHB0cl90IGZvciB0c3Rf
c3lzY2FsbCByZXR1cm4KCiBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvcmVnZW4uc2ggfCAgIDIgKy0K
IHJ1bnRlc3QvY2hlY2tfdHN0X3N5c2NhbGwgICAgICB8IDE5MCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTkxIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBydW50ZXN0L2NoZWNrX3RzdF9zeXNjYWxsCgoK
YmFzZS1jb21taXQ6IDhjZDNiZjMxNDljNGE4Y2I2ZjZjODVkYzc2YTM2ZDdmNmRkODdmNzYKLS0g
CjIuMjUuMQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
