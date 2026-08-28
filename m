Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F91C61DC6
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 08:47:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 854013E2FC4
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 10:47:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F244E3CE420
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 10:47:12 +0200 (CEST)
Received: from mta0.migadu.com (out-246.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::f6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2D3101A007E3
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 10:47:11 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=nR7uerFT5pcxZUztxXzPECOS1QMJpfqoWI8i+6Q9NJ8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787906830; v=1; x=1788511630;
 b=JUbSbW5o55yWu3V1XaBEy3+2VaQ4NVGtjEUUD1TiLlooPZpuZa/Wyx6BNyeoERHz5Bw9K3Ev
 mY+fonv0NNpl/5XRY3Ux20lxsJwNvXLh/+b6PrRPqgnNtjjXMWLzwxtzYM2peE7c+A6DN8nat9R
 4kyYnt9vLS3xML7f90EUImYg=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 23e77d896fcf4b3c;
 Fri, 28 Aug 2026 08:47:10 +0000
X-Mizu-Trace-ID: 23e77d896fcf4b3c
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 16:47:03 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <apFLB-NEelwmFXfW@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <apEHQxmBxBG4Vm7w@linux.dev>
 <6a91470b.7557dadb.15e29c.77e9@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a91470b.7557dadb.15e29c.77e9@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] swapon04: Add test for discard flags
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKPiA+IEkgZW5jb3VudGVyZWQgYW4gaW50ZXJtaXR0ZW50IGZhaWx1cmUgb24g
bXkgeDg2XzY0IHBsYXRmb3JtIHJ1bm5pbmcga2VybmVsIDYuNi4KPiA+IFRoaXMgbmVlZHMgZnVy
dGhlciBpbnZlc3RpZ2F0aW9uLgo+ID4gCj4gPiB0c3RfdGVzdC5jOjE5ODY6IFRJTkZPOiA9PT0g
VGVzdGluZyBvbiB4ZnMgPT09Cj4gPiB0c3RfdGVzdC5jOjEyOTE6IFRJTkZPOiBGb3JtYXR0aW5n
IC9kZXYvbG9vcDAgd2l0aCB4ZnMgb3B0cz0nJyBleHRyYSBvcHRzPScnCj4gPiB0c3RfdGVzdC5j
OjEzMDM6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRvIC90bXAvTFRQX3N3YTREejZhUC9t
bnRwb2ludCBmc3R5cD14ZnMgZmxhZ3M9MAo+ID4gdHN0X2RldmljZS5jOjEwMzogVElORk86IEZv
dW5kIGZyZWUgZGV2aWNlIDEgJy9kZXYvbG9vcDEnCj4gPiBzd2Fwb24wNC5jOjE3MDogVFBBU1M6
IGJsb2Nrc19hZnRlciA9PSBibG9ja3NfYmVmb3JlICgzMjc2OCkKPiA+IHN3YXBvbjA0LmM6MTY4
OiBUUEFTUzogYmxvY2tzX2FmdGVyIDw9IG1heF9oZWFkZXJfYmxvY2tzICg4IDw9IDE2KQo+ID4g
c3dhcG9uMDQuYzoxNjg6IFRGQUlMOiBibG9ja3NfYWZ0ZXIgKDMyNjQ4KSA+IG1heF9oZWFkZXJf
YmxvY2tzICgxNikKPiA+IHN3YXBvbjA0LmM6MTcwOiBUUEFTUzogYmxvY2tzX2FmdGVyID09IGJs
b2Nrc19iZWZvcmUgKDMyNzY4KQo+ID4gc3dhcG9uMDQuYzoxNjg6IFRQQVNTOiBibG9ja3NfYWZ0
ZXIgPD0gbWF4X2hlYWRlcl9ibG9ja3MgKDggPD0gMTYpCj4gPiBzd2Fwb24wNC5jOjE3MDogVFBB
U1M6IGJsb2Nrc19hZnRlciA9PSBibG9ja3NfYmVmb3JlICgzMjc2OCkKPiA+IHN3YXBvbjA0LmM6
MTcwOiBUUEFTUzogYmxvY2tzX2FmdGVyID09IGJsb2Nrc19iZWZvcmUgKDMyNzY4KQo+IAoKPiB0
aGlzIGlzIGludGVyZXN0aW5nLiBBbHNvIEkgbm90aWNlIGhvdyBpdCdzIGhhcmQgdG8gcmVhZCB0
aGUgbG9ncywgc28KPiBJIG5lZWQgYSBUSU5GTyBiZWZvcmUgdGhlIGNoZWNrcy4gQnV0IHRlY2hu
aWNhbGx5LCB0aGlzIGNvdWxkIGJlIGEga2VybmVsCj4gYnVnOiBjYW4geW91IHBsZWFzZSBhZGQg
YSBzeW5jKCkgYmVmb3JlIHN0YXQoKSB3aGlsZSB3ZSBhcmUgZ2V0dGluZyB0aGUKPiBibG9ja3Nf
YWZ0ZXI/IFdlIG1pZ2h0IG5lZWQgdG8gZmx1c2ggdGhlIGNhY2hlIGJlZm9yZSByZWFkaW5nIHRo
ZSBibG9ja3MuCj4gCj4gCWZkID0gU0FGRV9PUEVOKEJBQ0tJTkdfRklMRSwgT19SRE9OTFkpOwo+
IAlTQUZFX0ZTWU5DKGZkKTsKPiAJU0FGRV9DTE9TRShmZCk7Cj4gCgpJdCBkb2Vzbid0IHdvcmsg
4oCUIGV2ZW4gd2l0aCB0aGUgZnN5bmMoKSBhZGRlZCBhYm92ZSwgdGhlIHByb2JsZW0gaXMKc3Rp
bGwgcmVwcm9kdWNpYmxlLiBJIGFncmVlIGl0J3MgbGlrZWx5IGEga2VybmVsIGJ1ZywgYmVjYXVz
ZSBJIHRyaWVkCm9uIGMxMHMgKDYuMTIpIGFuZCBjOXMgKDUuMTQpIGFuZCBjb3VsZG4ndCByZXBy
b2R1Y2UgdGhlIGlzc3VlIHRoZXJlLgoKT25seSBvbiBrZXJuZWwtdjYuNi0qIGZhaWw6CgojIExU
UF9TSU5HTEVfRlNfVFlQRT14ZnMgLi9zd2Fwb24wNCAtaSAxMDAKCnN3YXBvbjA0LmM6MTc0OiBU
UEFTUzogYmxvY2tzX2FmdGVyID09IGJsb2Nrc19iZWZvcmUgKDMyNzY4KQpzd2Fwb24wNC5jOjE3
MjogVFBBU1M6IGJsb2Nrc19hZnRlciA8PSBtYXhfaGVhZGVyX2Jsb2NrcyAoOCA8PSAxNikKc3dh
cG9uMDQuYzoxNzQ6IFRQQVNTOiBibG9ja3NfYWZ0ZXIgPT0gYmxvY2tzX2JlZm9yZSAoMzI3Njgp
CnN3YXBvbjA0LmM6MTc0OiBUUEFTUzogYmxvY2tzX2FmdGVyID09IGJsb2Nrc19iZWZvcmUgKDMy
NzY4KQpzd2Fwb24wNC5jOjE3NDogVEZBSUw6IGJsb2Nrc19hZnRlciAoMzI3NjgpICE9IGJsb2Nr
c19iZWZvcmUgKDY1NDA4KQpzd2Fwb24wNC5jOjE3MjogVEZBSUw6IGJsb2Nrc19hZnRlciAoMzI2
NDgpID4gbWF4X2hlYWRlcl9ibG9ja3MgKDE2KQouLi4KCnN3YXBvbjA0LmM6MTc0OiBUUEFTUzog
YmxvY2tzX2FmdGVyID09IGJsb2Nrc19iZWZvcmUgKDMyNzY4KQpzd2Fwb24wNC5jOjE3NDogVFBB
U1M6IGJsb2Nrc19hZnRlciA9PSBibG9ja3NfYmVmb3JlICgzMjc2OCkKClN1bW1hcnk6CnBhc3Nl
ZCAgIDY3MApmYWlsZWQgICAzMApicm9rZW4gICAwCnNraXBwZWQgIDAKd2FybmluZ3MgMAoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
