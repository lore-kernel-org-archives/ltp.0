Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97349C369A1
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 18:51:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEE023CB3BD
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 20:51:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB36E3C0496
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 20:51:20 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=lists.linux.it)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BD5271400262
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 20:51:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=dGXZXPhKoociiuci5ixZu5eBgeCDmzv+oG1pcsW8GV4=; b=VFqLiaqTw8f6tco2SORsdJWtgu
 A5OH0bv6WxDDDP3nV1dDvIhWpx9JgDZGSCPJ5DOp2s5MjxFSDkdKlWcdSxg8tKcnnfXLewT4tgnF7
 vQTgFjBX0pb14srq9b5LjU58Bg8j1wjeSn8yQVmYllw8BjlCD3WxwLFtilsRhY2H6J9Bl6EY92Lbt
 U+B9S1JAE5I/7x/VR6SqkEbpveJ7T8zLVdQVapIVfSf0nmDs498RgINuPSAw+c53BapppK8eJJVbY
 SlUe9Y1Dgke/Ij8VjTeZqXLSYgy4GK2nipp8qUiC1QqJ/VgNm8qyJPvb3+3xWNXFfgCt0XXU5CE6y
 Ubsgg21Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1u2E2J-00000000LgK-45gI;
 Tue, 08 Apr 2025 18:51:04 +0000
Date: Tue, 8 Apr 2025 19:51:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <Z_VwF1MA-R7MgDVG@casper.infradead.org>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
 <20250408174855.GI6307@frogsfrogsfrogs>
 <Z_ViElxiCcDNpUW8@casper.infradead.org>
 <20250408180240.GM6266@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250408180240.GM6266@frogsfrogsfrogs>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, David Bueso <dave@stgolabs.net>, lkp@intel.com,
 gost.dev@samsung.com, Alistair Popple <apopple@nvidia.com>,
 Pankaj Raghav <p.raghav@samsung.com>, John Garry <john.g.garry@oracle.com>,
 Daniel Gomez <da.gomez@samsung.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>,
 ltp@lists.linux.it, linux-block@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Tso Ted <tytso@mit.edu>,
 Luis Chamberlain <mcgrof@kernel.org>, Oliver Sang <oliver.sang@intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBcHIgMDgsIDIwMjUgYXQgMTE6MDI6NDBBTSAtMDcwMCwgRGFycmljayBKLiBXb25n
IHdyb3RlOgo+IE9uIFR1ZSwgQXByIDA4LCAyMDI1IGF0IDA2OjUxOjE0UE0gKzAxMDAsIE1hdHRo
ZXcgV2lsY294IHdyb3RlOgo+ID4gT24gVHVlLCBBcHIgMDgsIDIwMjUgYXQgMTA6NDg6NTVBTSAt
MDcwMCwgRGFycmljayBKLiBXb25nIHdyb3RlOgo+ID4gPiBPbiBUdWUsIEFwciAwOCwgMjAyNSBh
dCAxMDoyNDo0MEFNIC0wNzAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3RlOgo+ID4gPiA+IE9uIFR1
ZSwgQXByIDgsIDIwMjUgYXQgMTA6MDbigK9BTSBMdWlzIENoYW1iZXJsYWluIDxtY2dyb2ZAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4gPiA+ID4gPiBGdW4KPiA+ID4gPiA+IHB1enpsZSBmb3IgdGhlIGNv
bW11bml0eSBpcyBmaWd1cmluZyBvdXQgKndoeSogb2ggd2h5IGRpZCBhIGxhcmdlIGZvbGlvCj4g
PiA+ID4gPiBlbmQgdXAgYmVpbmcgdXNlZCBvbiBidWZmZXItaGVhZHMgZm9yIHlvdXIgdXNlIGNh
c2UgKndpdGhvdXQqIGFuIExCUwo+ID4gPiA+ID4gZGV2aWNlIChsb2dpY2FsIGJsb2NrIHNpemUp
IGJlaW5nIHByZXNlbnQsIGFzIEkgYXNzdW1lIHlvdSBkaWRuJ3QgaGF2ZQo+ID4gPiA+ID4gb25l
LCBpZSBzYXkgYSBudm1lIG9yIHZpcnRpbyBibG9jayBkZXZpY2Ugd2l0aCBsb2dpY2FsIGJsb2Nr
IHNpemUgID4KPiA+ID4gPiA+IFBBR0VfU0laRS4gVGhlIGFyZWEgaW4gcXVlc3Rpb24gd291bGQg
dHJpZ2dlciBvbiBmb2xpbyBtaWdyYXRpb24gKm9ubHkqCj4gPiA+ID4gPiBpZiB5b3UgYXJlIG1p
Z3JhdGluZyBsYXJnZSBidWZmZXItaGVhZCBmb2xpb3MuIFdlIG9ubHkgY3JlYXRlIHRob3NlCj4g
PiA+ID4gCj4gPiA+ID4gVG8gYmUgY2xlYXIsIGxhcmdlIGZvbGlvcyBmb3IgYnVmZmVyLWhlYWRz
Lgo+ID4gPiA+ID4gaWYKPiA+ID4gPiA+IHlvdSBoYXZlIGFuIExCUyBkZXZpY2UgYW5kIGFyZSBs
ZXZlcmFnaW5nIHRoZSBibG9jayBkZXZpY2UgY2FjaGUgb3IgYQo+ID4gPiA+ID4gZmlsZXN5c3Rl
bSB3aXRoIGJ1ZmZlci1oZWFkcyB3aXRoIExCUyAodGhleSBkb24ndCBleGlzdCB5ZXQgb3RoZXIg
dGhhbgo+ID4gPiA+ID4gdGhlIGJsb2NrIGRldmljZSBjYWNoZSkuCj4gPiA+IAo+ID4gPiBNeSBn
dWVzcyBpcyB0aGF0IHVkZXYgb3Igc29tZXRoaW5nIHRyaWVzIHRvIHJlYWQgdGhlIGRpc2sgbGFi
ZWwgaW4KPiA+ID4gcmVzcG9uc2UgdG8gc29tZSB1ZXZlbnQgKG1rZnMsIG1vdW50LCB1bm1vdW50
LCBldGMpLCB3aGljaCBjcmVhdGVzIGEKPiA+ID4gbGFyZ2UgZm9saW8gYmVjYXVzZSBtaW5fb3Jk
ZXIgPiAwLCBhbmQgYXR0YWNoZXMgYSBidWZmZXIgaGVhZC4gIFRoZXJlJ3MKPiA+ID4gYSBzZXBh
cmF0ZSBjcmFzaCByZXBvcnQgdGhhdCBJJ2xsIGNjIHlvdSBvbi4KPiA+IAo+ID4gQnV0IHlvdSBz
YWlkOgo+ID4gCj4gPiA+IHRoZSBtYWNoaW5lIGlzIGFybTY0IHdpdGggNjRrIGJhc2VwYWdlcyBh
bmQgNGsgZnNibG9jayBzaXplOgo+ID4gCj4gPiBzbyB0aGF0IHNob3VsZG4ndCBiZSB1c2luZyBs
YXJnZSBmb2xpb3MgYmVjYXVzZSB5b3Ugc2hvdWxkIGhhdmUgc2V0IHRoZQo+ID4gb3JkZXIgdG8g
MC4gIFJpZ2h0PyAgT3IgZGlkIHlvdSBtaXMtc3BlYWsgYW5kIHVzZSBhIDRLIFBBR0VfU0laRSBr
ZXJuZWwKPiA+IHdpdGggYSA2NGsgZnNibG9ja3NpemU/Cj4gCj4gVGhpcyBwYXJ0aWN1bGFyIGtl
cm5lbCB3YXJuaW5nIGlzIGFybTY0IHdpdGggNjRrIGJhc2UgcGFnZXMgYW5kIGEgNGsKPiBmc2Js
b2NrIHNpemUsIGFuZCBteSBzdXNwaWNpb24gaXMgdGhhdCB1ZGV2L2xpYmJsa2lkIGFyZSBjcmVh
dGluZyB0aGUKPiBidWZmZXIgaGVhZHMgb3Igc29tZXRoaW5nIHdlaXJkIGxpa2UgdGhhdC4KPiAK
PiBPbiB4NjQgd2l0aCA0ayBiYXNlIHBhZ2VzLCB4ZnMvMDMyIGNyZWF0ZXMgYSBmaWxlc3lzdGVt
IHdpdGggNjRrIHNlY3Rvcgo+IHNpemUgYW5kIHRoZXJlJ3MgYW4gYWN0dWFsIGtlcm5lbCBjcmFz
aCByZXN1bHRpbmcgZnJvbSBhIHVkZXYgd29ya2VyOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWZzZGV2ZWwvMjAyNTA0MDgxNzUxMjUuR0w2MjY2QGZyb2dzZnJvZ3Nmcm9ncy9ULyN1
Cj4gCj4gU28gSSBkaWRuJ3QgbWlzc3BlYWssIEkganVzdCBoYXZlIHR3byBwcm9ibGVtcy4gIEkg
YWN0dWFsbHkgaGF2ZSBmb3VyCj4gcHJvYmxlbXMsIGJ1dCB0aGUgb3RoZXJzIGFyZSBsb29wIGRl
dmljZSBiZWhhdmlvciBjaGFuZ2VzLgoKUmlnaHQsIGJ1dCB0aGlzIHdhcm5pbmcgb25seSB0cmln
Z2VycyBmb3IgbGFyZ2UgZm9saW9zLiAgU28gc29tZWhvdwp3ZSd2ZSBnb3QgYSBtdWx0aS1wYWdl
IGZvbGlvIGluIHRoZSBiZGV2J3MgcGFnZSBjYWNoZS4KCkFoLiAgSSBzZWUuCgpibG9jay9iZGV2
LmM6ICAgbWFwcGluZ19zZXRfZm9saW9fbWluX29yZGVyKEJEX0lOT0RFKGJkZXYpLT5pX21hcHBp
bmcsCgpzbyB3ZSdyZSB0ZWxsaW5nIHRoZSBiZGV2IHRoYXQgaXQgY2FuIGdvIHVwIHRvIE1BWF9Q
QUdFQ0FDSEVfT1JERVIuCkFuZCB0aGVuIHdlIGNhbGwgcmVhZGFoZWFkLCB3aGljaCB3aWxsIGhh
cHBpbHkgcHV0IG9yZGVyLTIgZm9saW9zCmluIHRoZSBwYWdlY2FjaGUgYmVjYXVzZSBvZiBteSBi
dWcgdGhhdCB3ZSd2ZSBuZXZlciBib3RoZXJlZCBmaXhpbmcuCgpXZSBzaG91bGQgcHJvYmFibHkg
Zml4IHRoYXQgbm93LCBidXQgYXMgYSB0ZW1wb3JhcnkgbWVhc3VyZSBpZgp5b3UnZCBsaWtlIHRv
IHB1dDoKCm1hcHBpbmdfc2V0X2ZvbGlvX29yZGVyX3JhbmdlKEJEX0lOT0RFKGJkZXYpLT5pX21h
cHBpbmcsIG1pbiwgbWluKQoKaW5zdGVhZCBvZiB0aGUgbWFwcGluZ19zZXRfZm9saW9fbWluX29y
ZGVyKCksIHRoYXQgd291bGQgbWFrZSB0aGUgYnVnCm5vIGxvbmdlciBhcHBlYXIgZm9yIHlvdS4K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
