Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A88C25B79
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 13:32:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 597D53CF8D6
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 15:32:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2009D3CDB83
 for <ltp@lists.linux.it>; Wed, 15 May 2024 15:22:08 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=lee@kernel.org;
 receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A8B37600743
 for <ltp@lists.linux.it>; Wed, 15 May 2024 15:22:06 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E47A1CE136C;
 Wed, 15 May 2024 13:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEEBC116B1;
 Wed, 15 May 2024 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715779314;
 bh=lXr/y9xDsNC4dk/9G+rOjHitHx6injR2gFHkh+OuI9A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uNhv+r2Raye6ICgXvIAQPVyZGwwA0J/Nhcl+CgKQ6u8ib5QvYH1XxL1Z185BlRjll
 FcL7I+zaAtpb2qush+8PL+7jG6EZX/TdlCsh8bBtwuGWn9eJWhBpAEEF64+wfyebqI
 fLK+utEMiG+5cipsMjSa9GFP6Kc91gsgLtdQkDRG1bt1zliR2NVmsboQm2/H+Zx1N4
 Fv3qCQVem1jE59tEFODK6Nz4z3DMgy4JYssDoJUG6BWMVn1jCwC70xWzEKcQdyzLf9
 rH3mtWHd4PyRPYiEOt/T4ep9IJPq4ZlmgI2noaUw6A7UxKLkptHrMwlV/F1xV1OSB4
 yhoK6jsH2FnQA==
Date: Wed, 15 May 2024 14:21:51 +0100
From: Lee Jones <lee@kernel.org>
To: Murphy Zhou <jencce.kernel@gmail.com>
Message-ID: <20240515132151.GA557949@google.com>
References: <20240423070643.38577-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240423070643.38577-1-jencce.kernel@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 15 May 2024 15:32:18 +0200
Subject: Re: [LTP] [PATCH] readahead01: pass on pidfd
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCAyMyBBcHIgMjAyNCwgTXVycGh5IFpob3Ugd3JvdGU6Cgo+IExpbnV4IGtlcm5lbCBh
ZGRlZCBwaWRmcyB2aWEgY29tbWl0IGI1NjgzYTM3Yzg4MSBpbiB2Ni45LXJjMQo+IHJlbGVhc2Uu
IFRoaXMgcGF0Y2hzZXQgaWdub3JlcyByZWFkYWhlYWQgcmVxdWVzdCBpbnN0ZWFkIG9mCj4gcmV0
dXJuaW5nIEVJTlZBTCwgc28gbWFyayB0aGUgdGVzdCBwYXNzLgo+IAo+IGh0dHBzOi8vbGttbC5p
dS5lZHUvaHlwZXJtYWlsL2xpbnV4L2tlcm5lbC8yNDAzLjIvMDA3NjIuaHRtbAo+IAo+IFNpZ25l
ZC1vZmYtYnk6IE11cnBoeSBaaG91IDxqZW5jY2Uua2VybmVsQGdtYWlsLmNvbT4KPiAtLS0KPiAg
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZWFkYWhlYWQvcmVhZGFoZWFkMDEuYyB8IDEgKwo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9yZWFkYWhlYWQvcmVhZGFoZWFkMDEuYyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvcmVhZGFoZWFkL3JlYWRhaGVhZDAxLmMKPiBpbmRleCBkNGIzZjMwNmYu
LmFlZDhlN2YzMSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3JlYWRh
aGVhZC9yZWFkYWhlYWQwMS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZWFk
YWhlYWQvcmVhZGFoZWFkMDEuYwo+IEBAIC01Myw2ICs1Myw3IEBAIHN0YXRpYyB2b2lkIHRlc3Rf
aW52YWxpZF9mZChzdHJ1Y3QgdHN0X2ZkICpmZCkKPiAgCWNhc2UgVFNUX0ZEX01FTUZEOgo+ICAJ
Y2FzZSBUU1RfRkRfTUVNRkRfU0VDUkVUOgo+ICAJY2FzZSBUU1RfRkRfUFJPQ19NQVBTOgo+ICsJ
Y2FzZSBUU1RfRkRfUElERkQ6Cj4gIAkJcmV0dXJuOwo+ICAJZGVmYXVsdDoKPiAgCQlicmVhazsK
CkFueSBtb3ZlbWVudCBvbiB0aGlzPwoKQW5kcm9pZCBwcmUtc3VibWl0IENJIHRlc3RpbmcgaXMg
ZmFpbGluZyBkdWUgdG8gdGhlIG5ldyB1bmNvbmRpdGlvbmFsCmVuYWJsZSBvZiBQSURGRC4gIEkg
YmVsaWV2ZSB0aGlzIHBhdGNoIGlzIHJlcXVpcmVkIGluIG9yZGVyIHRvIGJyaW5nIGl0CmJhY2sg
dG8gYSBwYXNzaW5nIHN0YXRlLgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
