Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B5606A31A
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TE+KTUb5
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C0A23E9BD7
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 15:57:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 840AA3CFD24
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:57:20 +0200 (CEST)
Received: from mta0.migadu.com (out-36.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8287814060A3
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 15:57:17 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=wFbwdxPrVXVlIZIQ62YKRYfR/ouJmipcHDQwoB3a18g=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792763836; v=1; x=1793368636;
 b=TE+KTUb5b8hI5L+EQhQOVZfEzwsUF3B4uNUHc6/RkYE2xEzLbvWvJJdZLEOUXuaWvRZ27nvA
 N3hF8eoDNYZpVTdqAJ58v18a0mYQmRMNhEl/XwEYc4t3wVpil24MzYVHfRA/CWrVLBqRJKEeFYI
 PUvLQkFZoGjCJrnBDr9+4T9g=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 9905dbf4ec18c8df;
 Fri, 23 Oct 2026 13:57:16 +0000
X-Mizu-Trace-ID: 9905dbf4ec18c8df
X-Migadu-Flow: FLOW_OUT
From: Li Wang <li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 23 Oct 2026 21:57:04 +0800
Message-Id: <8FBE4389-E3C2-4BD3-843F-918B4C941996@linux.dev>
References: <bfJVtsQDsGAU5UmB2dnOuGX3884EEwLe1KUm@localhost.localdomain>
In-Reply-To: <bfJVtsQDsGAU5UmB2dnOuGX3884EEwLe1KUm@localhost.localdomain>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mailer: iPhone Mail (24A446)
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,UNWANTED_DEVICE_2 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cgo+IE9uIDIzIE9jdCAyMDI2LCBhdCAyMToyNiwgQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNl
cnZlc2F0b0BzdXNlLmNvbT4gd3JvdGU6Cj4gCj4g77u/Cj4+IAo+PiBIaSBMaSwKPj4gCj4+Pj4+
IFdlZG5lc2RheSAyOC4gT2N0IGlzIGJhbmsgaG9sbGlkYXkgaW4gQ3plY2ggcmVwdWJsaWMsIGFu
IGluZGVwZW5kZW5jZSBkYXkuCj4+Pj4gCj4+Pj4gKzEKPj4+PiAKPj4+PiBJZiBpdCBuZWVkcyB0
byBiZSBXZWRuZXNkYXksIHRoZW4gbmV4dCBvbmUgNHRoIE9jdCBmcm9tIDEwIHdvdWxkIHdvcmsg
Zm9yIG1lLgo+Pj4gCj4+PiBJIGd1ZXNzIHlvdSBtZWFuIDR0aCBOb3YuIE9mIGNvdXJzZSwgdGhh
dCdzIGZpbmUgd2l0aCBtZS4KPj4+IAo+Pj4+IE9yIHdlIGNhbiB0cnkgdG8gZmluZCBhbm90aGVy
IGRheSBuZXh0IHdlZWsgKDI2dGgtMzB0aCBTZXApLCBlLmcuIFR1ZSAyN3RoIGZyb20KPj4+PiAx
MS4wMCBhbSB3b3VsZCB3b3JrIGZvciBtZSAobWVldGluZyBmcm9tIDExLjAwIHNoaWZ0ZWQgdG8g
MTAuMDApLgo+Pj4gCj4+PiBJIHZvdGUgdG8gMTBhbSBDRVQuCj4+IAo+IAo+IFNvIGRlY2lkZWQg
dGhlIDR0aCBvZiBOb3ZlbWJlciBhdCAxMGFtPwoKeWVz77yBCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
