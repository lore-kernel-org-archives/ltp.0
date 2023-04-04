Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524E8C6FD1D
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 21:52:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBC2E3CA408
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 23:52:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A6063CA408
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 23:52:37 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A5F3C600457
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 23:52:36 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 37B176219F;
 Tue,  4 Apr 2023 21:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A141C433EF;
 Tue,  4 Apr 2023 21:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680645153;
 bh=OVMKANDblPgE7LeUWXS70K1L3kA2+daFAuRhbcJokkk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Mbt3Dyn87z5Z/CxP9AIR4/DoB8zMJVXwyPHA+GViOQtxj693BmdHzujodTdEwFNk6
 k751UzTXuPiyEmO5g6/pXJ64+UbU8U8IDExTFTQnALz04JU2+EgEfXn35g+rbWbNMQ
 KJs1QqXk6F2hZ5WRVReea4SU+cisBUscRMTJecnkMpKDDIP7BVxrunuSlBQpw0tKuR
 /fS65jMGSsOv8xy2Hqu53yR9PYHWNdzyDOKWNEn+2I/XEc8iYpaxrX9EEi2aHyi/+x
 LCdv0DG6Wv1TAptnepqUS5dKM6nC03V47pDIHNOh/EykLEywBqa0BWmhrJg+Lh5nEb
 bIG8pDIVWkGOQ==
Date: Tue, 4 Apr 2023 14:52:31 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230404215231.GA884@sol.localdomain>
References: <ZCsHKmFrUdBw3xEw@gmail.com>
 <1680593430-14728-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680593430-14728-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1680593430-14728-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
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

T24gVHVlLCBBcHIgMDQsIDIwMjMgYXQgMDM6MzA6MjhQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToK
PiBPbiBleHQ0LCBmaWxlcyB0aGF0IHVzZSBjZXJ0YWluIGZpbGVzeXN0ZW0gZmVhdHVyZXMgKGRh
dGEgam91cm5hbGxpbmcsCj4gZW5jcnlwdGlvbiwgYW5kIHZlcml0eSkgZmFsbCBiYWNrIHRvIGJ1
ZmZlcmVkIEkvTy4gQnV0IGx0cCBkb2Vzbid0IHVzZQo+IHRoZXNlIGZlYXR1cmVzIGJ5IGRlZmF1
bHQsIFNvIEkgdGhpbmsgZGlvIHNob3VsZCBub3QgZmFsbCBiYWNrIHRvCj4gYnVmZmVyZWQgSS9P
LgoKUGxlYXNlIGRvY3VtZW50IHRoaXMgaW4gdGhlIGNvZGUgaXRzZWxmLgoKPiArc3RhdGljIHZv
aWQgdmVyaWZ5X3N0YXR4KHZvaWQpCj4gK3sKPiArCXN0cnVjdCBzdGF0eCBidWY7Cj4gKwo+ICsJ
bWVtc2V0KCZidWYsIDAsIHNpemVvZihidWYpKTsKClRoZXJlIGlzIG5vIG5lZWQgZm9yIHRoaXMg
bWVtc2V0IHRvIDAuCgo+ICsJaWYgKGJ1Zi5zdHhfZGlvX21lbV9hbGlnbiAhPSAwKQo+ICsJCXRz
dF9yZXMoVFBBU1MsICJzdHhfZGlvX21lbV9hbGlnbjoldSIsIGJ1Zi5zdHhfZGlvX21lbV9hbGln
bik7Cj4gKwllbHNlCj4gKwkJdHN0X3JlcyhURkFJTCwgImRvbid0IGdldCBzdHhfZGlvX21lbV9h
bGlnbiBvbiBzdXBwb3J0ZWQgZGlvIGZzIik7Cj4gKwo+ICsJaWYgKGJ1Zi5zdHhfZGlvX29mZnNl
dF9hbGlnbiAhPSAwKQo+ICsJCXRzdF9yZXMoVFBBU1MsICJzdHhfZGlvX29mZnNldF9hbGlnbjol
dSIsIGJ1Zi5zdHhfZGlvX29mZnNldF9hbGlnbik7Cj4gKwllbHNlCj4gKwkJdHN0X3JlcyhURkFJ
TCwgImRvbid0IGdldCBzdHhfZGlvX29mZnNldF9hbGlnbiBvbiBzdXBwb3J0ZWQgZGlvIGZzIik7
CgpQbGVhc2UgbGVhdmUgYSBzcGFjZSBiZXR3ZWVuIDogYW5kICV1LgoKPiArCWlmICgoYnVmLnN0
eF9tYXNrICYgU1RBVFhfRElPQUxJR04pKSB7CgpVbm5lY2Vzc2FyeSBwYXJlbnRoZXNlcwoKPiAr
CQl0c3RfcmVzKFRGQUlMLCAiU1RBVFhfRElPQUxJR04gbWFzayByZXR1cm4gZXZlbiBub3QgcmVx
dWVzdCIpOwo+ICsJCXJldHVybjsKPiArCX0KClRoaXMgcGFydCBpcyBub3QgYSB2YWxpZCB0ZXN0
LiAgUGxlYXNlIHNlZSB0aGUgc3RhdHgoMikgbWFudWFsIHBhZ2U6CgogICAgICAgIkl0IHNob3Vs
ZCBiZSBub3RlZCB0aGF0IHRoZSBrZXJuZWwgbWF5IHJldHVybiBmaWVsZHMgdGhhdCAgd2VyZW4n
dCAgcmXigJAKICAgICAgIHF1ZXN0ZWQgYW5kIG1heSBmYWlsIHRvIHJldHVybiBmaWVsZHMgdGhh
dCB3ZXJlIHJlcXVlc3RlZCwgZGVwZW5kaW5nIG9uCiAgICAgICB3aGF0IHRoZSBiYWNraW5nIGZp
bGVzeXN0ZW0gc3VwcG9ydHMuICAoRmllbGRzIHRoYXQgIGFyZSAgZ2l2ZW4gIHZhbHVlcwogICAg
ICAgZGVzcGl0ZSAgYmVpbmcgIHVucmVxdWVzdGVkICBjYW4gIGp1c3QgIGJlICBpZ25vcmVkLikg
ICBJbiBlaXRoZXIgY2FzZSwKICAgICAgIHN0eF9tYXNrIHdpbGwgbm90IGJlIGVxdWFsIG1hc2su
IgoKPiArc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiArewo+ICsJaWYgKHN0cmNtcCh0c3RfZGV2
aWNlLT5mc190eXBlLCAieGZzIikgJiYgc3RyY21wKHRzdF9kZXZpY2UtPmZzX3R5cGUsICJleHQ0
IikpCj4gKwkJdHN0X2JyayhUQ09ORiwgIlRoaXMgdGVzdCBvbmx5IHN1cHBvcnRzIGV4dDQgYW5k
IHhmcyIpOwo+ICsKPiArCVNBRkVfRklMRV9QUklOVEYoVEVTVEZJTEUsICJBQUFBIik7Cj4gKwlm
ZCA9IG9wZW4oVEVTVEZJTEUsIE9fUkRXUiB8IE9fRElSRUNUKTsKPiArCWlmIChmZCA9PSAtMSAm
JiBlcnJubyA9PSBFSU5WQUwpCj4gKwkJdHN0X2JyayhUQ09ORiwgIlRoZSByZWd1bGFyIGZpbGUg
aXMgbm90IG9uIGEgZmlsZXN5c3RlbSB0aGF0IHN1cHBvcnQgRElPIik7Cj4gK30KPiArCj4gK3N0
YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKPiArewo+ICsJaWYgKGZkID4gLTEpCj4gKwkJU0FGRV9D
TE9TRShmZCk7Cj4gK30KClNob3VsZG4ndCAnZmQnIGp1c3QgYmUgYSBsb2NhbCB2YXJpYWJsZSBp
biBzZXR1cCgpPwoKPiArI2Vsc2UKPiArVFNUX1RFU1RfVENPTkYoInRlc3QgcmVxdWlyZXMgc3Ry
dWN0IHN0YXR4IHRvIGhhdmUgdGhlIHN0eF9kaW9fbWVtX2FsaWduIGZpZWxkcyIpOwo+ICsjZW5k
aWYKCkxUUCBhbHJlYWR5IGhhcyBpdHMgb3duIGRlZmluaXRpb24gb2Ygc3RydWN0IHN0YXR4IGlu
IGluY2x1ZGUvbGFwaS9zdGF0LmguICBTbywKd2h5IGlzIGl0IG5lY2Vzc2FyeSB0byBza2lwIHRo
aXMgdGVzdCBpZiB0aGUgc3lzdGVtIGhlYWRlcnMgbGFjayBhbiB1cC10by1kYXRlCmRlZmluaXRp
b24gb2Ygc3RydWN0IHN0YXR4PwoKLSBFcmljCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
