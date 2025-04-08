Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4D8C369A4
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 17:51:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01FF53CB3B3
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 19:51:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14F043CABDA
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 19:51:29 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=lists.linux.it)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2FE8B6011BD
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 19:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=LRoGsm36GWYvDS1XW5mGL/7sKrvWfbhdm+vbaWZ07xI=; b=oRpD+7Vp0e6qyj9DRDn2GCOlm3
 QtllRxj5NJ/kOR/p0aXCC/crlROlM3tpCnE2R9jbNekSugaTVJeIPnSACelAiyHiY6eWW7OiJ/ur/
 QMAM8mcWeNn88uJmLjz/63ZWtc1Gztmxkg2io6kDrtossNunvtlsw6kHzOqudKBBVzSqO5+iKhMK8
 euIj2dPnhebY2hqhmBXiIJ3VGAAKoDZCOPcJAulPYz0V1dtSqNxa/XYk0QPIopMuVprax9sVnU/6Z
 7G4L9yb9UvvMamiEpwksfST5cchHFB5oUJ5OaZ/o16Y241oWm/8SVoiAFs/nqeDzZHMJIJ1cY+9hI
 U2ezk9IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1u2D6Q-00000000JDI-1K6g;
 Tue, 08 Apr 2025 17:51:14 +0000
Date: Tue, 8 Apr 2025 18:51:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <Z_ViElxiCcDNpUW8@casper.infradead.org>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
 <20250408174855.GI6307@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250408174855.GI6307@frogsfrogsfrogs>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

T24gVHVlLCBBcHIgMDgsIDIwMjUgYXQgMTA6NDg6NTVBTSAtMDcwMCwgRGFycmljayBKLiBXb25n
IHdyb3RlOgo+IE9uIFR1ZSwgQXByIDA4LCAyMDI1IGF0IDEwOjI0OjQwQU0gLTA3MDAsIEx1aXMg
Q2hhbWJlcmxhaW4gd3JvdGU6Cj4gPiBPbiBUdWUsIEFwciA4LCAyMDI1IGF0IDEwOjA24oCvQU0g
THVpcyBDaGFtYmVybGFpbiA8bWNncm9mQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gPiBGdW4KPiA+
ID4gcHV6emxlIGZvciB0aGUgY29tbXVuaXR5IGlzIGZpZ3VyaW5nIG91dCAqd2h5KiBvaCB3aHkg
ZGlkIGEgbGFyZ2UgZm9saW8KPiA+ID4gZW5kIHVwIGJlaW5nIHVzZWQgb24gYnVmZmVyLWhlYWRz
IGZvciB5b3VyIHVzZSBjYXNlICp3aXRob3V0KiBhbiBMQlMKPiA+ID4gZGV2aWNlIChsb2dpY2Fs
IGJsb2NrIHNpemUpIGJlaW5nIHByZXNlbnQsIGFzIEkgYXNzdW1lIHlvdSBkaWRuJ3QgaGF2ZQo+
ID4gPiBvbmUsIGllIHNheSBhIG52bWUgb3IgdmlydGlvIGJsb2NrIGRldmljZSB3aXRoIGxvZ2lj
YWwgYmxvY2sgc2l6ZSAgPgo+ID4gPiBQQUdFX1NJWkUuIFRoZSBhcmVhIGluIHF1ZXN0aW9uIHdv
dWxkIHRyaWdnZXIgb24gZm9saW8gbWlncmF0aW9uICpvbmx5Kgo+ID4gPiBpZiB5b3UgYXJlIG1p
Z3JhdGluZyBsYXJnZSBidWZmZXItaGVhZCBmb2xpb3MuIFdlIG9ubHkgY3JlYXRlIHRob3NlCj4g
PiAKPiA+IFRvIGJlIGNsZWFyLCBsYXJnZSBmb2xpb3MgZm9yIGJ1ZmZlci1oZWFkcy4KPiA+ID4g
aWYKPiA+ID4geW91IGhhdmUgYW4gTEJTIGRldmljZSBhbmQgYXJlIGxldmVyYWdpbmcgdGhlIGJs
b2NrIGRldmljZSBjYWNoZSBvciBhCj4gPiA+IGZpbGVzeXN0ZW0gd2l0aCBidWZmZXItaGVhZHMg
d2l0aCBMQlMgKHRoZXkgZG9uJ3QgZXhpc3QgeWV0IG90aGVyIHRoYW4KPiA+ID4gdGhlIGJsb2Nr
IGRldmljZSBjYWNoZSkuCj4gCj4gTXkgZ3Vlc3MgaXMgdGhhdCB1ZGV2IG9yIHNvbWV0aGluZyB0
cmllcyB0byByZWFkIHRoZSBkaXNrIGxhYmVsIGluCj4gcmVzcG9uc2UgdG8gc29tZSB1ZXZlbnQg
KG1rZnMsIG1vdW50LCB1bm1vdW50LCBldGMpLCB3aGljaCBjcmVhdGVzIGEKPiBsYXJnZSBmb2xp
byBiZWNhdXNlIG1pbl9vcmRlciA+IDAsIGFuZCBhdHRhY2hlcyBhIGJ1ZmZlciBoZWFkLiAgVGhl
cmUncwo+IGEgc2VwYXJhdGUgY3Jhc2ggcmVwb3J0IHRoYXQgSSdsbCBjYyB5b3Ugb24uCgpCdXQg
eW91IHNhaWQ6Cgo+IHRoZSBtYWNoaW5lIGlzIGFybTY0IHdpdGggNjRrIGJhc2VwYWdlcyBhbmQg
NGsgZnNibG9jayBzaXplOgoKc28gdGhhdCBzaG91bGRuJ3QgYmUgdXNpbmcgbGFyZ2UgZm9saW9z
IGJlY2F1c2UgeW91IHNob3VsZCBoYXZlIHNldCB0aGUKb3JkZXIgdG8gMC4gIFJpZ2h0PyAgT3Ig
ZGlkIHlvdSBtaXMtc3BlYWsgYW5kIHVzZSBhIDRLIFBBR0VfU0laRSBrZXJuZWwKd2l0aCBhIDY0
ayBmc2Jsb2Nrc2l6ZT8KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
