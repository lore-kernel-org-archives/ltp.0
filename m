Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CD8C369A2
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744135386; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GcgFgbdNYD+7QsYojcju7yNDxOASibfvHBf3oFpR4e8=;
 b=pdhO0TAZdoZrzLXF+ed0js5txIMtClK/06O4ZXJo/c654YKubp3dnXDreqJYoXYvez5fT
 brftJha/o4tydsWeRZjmDI/TK9vUdn9gOUTKfCJt2cgfzBlcqZcpxBixE7mGUwIk5NWnscW
 wNkyedA3XcAL3qnK7/r4Aj3WRXTX9Ik=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C4A83CB3C9
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 20:03:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 371F53C048F
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 20:02:44 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=djwong@kernel.org; receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4EDCF1A00FA0
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 20:02:42 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2CD685C3F98;
 Tue,  8 Apr 2025 18:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA02C4CEEA;
 Tue,  8 Apr 2025 18:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744135360;
 bh=07hatUbfr/QmTsLAp8mRuajmYal+iTkS5lG3koX3sYk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gJ9isBnvY2+6BFEV76kbWaDeok+wm2ofnWbwGUqwgTl2wxqX/BGlrvL8ULraweZPl
 i+MMspSS9DWV2ks9l5Lx4C4O6Fm33t0cuJzO++P3z49w3gD56+lZKZQpx8luT04Cp2
 RcWRuhE9VVXE9uoGUhApmz3SqvwdHQuY8ERxxU8UTlG/5vEutUmxTYTaSyowy+pYlj
 MWR21BXSD6n575rQfnQwae8Gft+3db/7XU/qN+ijRWyt99Cq87tUn4FdaMAehgVQik
 SWAEtv4mGHyRc7RmQ4gFag7HX/oxBn6eZ8ckFaSZW6q0ii7xTZX3KOn60C9v8CrDLI
 CgZWrYs4A6XYA==
Date: Tue, 8 Apr 2025 11:02:40 -0700
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20250408180240.GM6266@frogsfrogsfrogs>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
 <20250408174855.GI6307@frogsfrogsfrogs>
 <Z_ViElxiCcDNpUW8@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z_ViElxiCcDNpUW8@casper.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
From: "Darrick J. Wong via ltp" <ltp@lists.linux.it>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
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

T24gVHVlLCBBcHIgMDgsIDIwMjUgYXQgMDY6NTE6MTRQTSArMDEwMCwgTWF0dGhldyBXaWxjb3gg
d3JvdGU6Cj4gT24gVHVlLCBBcHIgMDgsIDIwMjUgYXQgMTA6NDg6NTVBTSAtMDcwMCwgRGFycmlj
ayBKLiBXb25nIHdyb3RlOgo+ID4gT24gVHVlLCBBcHIgMDgsIDIwMjUgYXQgMTA6MjQ6NDBBTSAt
MDcwMCwgTHVpcyBDaGFtYmVybGFpbiB3cm90ZToKPiA+ID4gT24gVHVlLCBBcHIgOCwgMjAyNSBh
dCAxMDowNuKAr0FNIEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3JvZkBrZXJuZWwub3JnPiB3cm90ZToK
PiA+ID4gPiBGdW4KPiA+ID4gPiBwdXp6bGUgZm9yIHRoZSBjb21tdW5pdHkgaXMgZmlndXJpbmcg
b3V0ICp3aHkqIG9oIHdoeSBkaWQgYSBsYXJnZSBmb2xpbwo+ID4gPiA+IGVuZCB1cCBiZWluZyB1
c2VkIG9uIGJ1ZmZlci1oZWFkcyBmb3IgeW91ciB1c2UgY2FzZSAqd2l0aG91dCogYW4gTEJTCj4g
PiA+ID4gZGV2aWNlIChsb2dpY2FsIGJsb2NrIHNpemUpIGJlaW5nIHByZXNlbnQsIGFzIEkgYXNz
dW1lIHlvdSBkaWRuJ3QgaGF2ZQo+ID4gPiA+IG9uZSwgaWUgc2F5IGEgbnZtZSBvciB2aXJ0aW8g
YmxvY2sgZGV2aWNlIHdpdGggbG9naWNhbCBibG9jayBzaXplICA+Cj4gPiA+ID4gUEFHRV9TSVpF
LiBUaGUgYXJlYSBpbiBxdWVzdGlvbiB3b3VsZCB0cmlnZ2VyIG9uIGZvbGlvIG1pZ3JhdGlvbiAq
b25seSoKPiA+ID4gPiBpZiB5b3UgYXJlIG1pZ3JhdGluZyBsYXJnZSBidWZmZXItaGVhZCBmb2xp
b3MuIFdlIG9ubHkgY3JlYXRlIHRob3NlCj4gPiA+IAo+ID4gPiBUbyBiZSBjbGVhciwgbGFyZ2Ug
Zm9saW9zIGZvciBidWZmZXItaGVhZHMuCj4gPiA+ID4gaWYKPiA+ID4gPiB5b3UgaGF2ZSBhbiBM
QlMgZGV2aWNlIGFuZCBhcmUgbGV2ZXJhZ2luZyB0aGUgYmxvY2sgZGV2aWNlIGNhY2hlIG9yIGEK
PiA+ID4gPiBmaWxlc3lzdGVtIHdpdGggYnVmZmVyLWhlYWRzIHdpdGggTEJTICh0aGV5IGRvbid0
IGV4aXN0IHlldCBvdGhlciB0aGFuCj4gPiA+ID4gdGhlIGJsb2NrIGRldmljZSBjYWNoZSkuCj4g
PiAKPiA+IE15IGd1ZXNzIGlzIHRoYXQgdWRldiBvciBzb21ldGhpbmcgdHJpZXMgdG8gcmVhZCB0
aGUgZGlzayBsYWJlbCBpbgo+ID4gcmVzcG9uc2UgdG8gc29tZSB1ZXZlbnQgKG1rZnMsIG1vdW50
LCB1bm1vdW50LCBldGMpLCB3aGljaCBjcmVhdGVzIGEKPiA+IGxhcmdlIGZvbGlvIGJlY2F1c2Ug
bWluX29yZGVyID4gMCwgYW5kIGF0dGFjaGVzIGEgYnVmZmVyIGhlYWQuICBUaGVyZSdzCj4gPiBh
IHNlcGFyYXRlIGNyYXNoIHJlcG9ydCB0aGF0IEknbGwgY2MgeW91IG9uLgo+IAo+IEJ1dCB5b3Ug
c2FpZDoKPiAKPiA+IHRoZSBtYWNoaW5lIGlzIGFybTY0IHdpdGggNjRrIGJhc2VwYWdlcyBhbmQg
NGsgZnNibG9jayBzaXplOgo+IAo+IHNvIHRoYXQgc2hvdWxkbid0IGJlIHVzaW5nIGxhcmdlIGZv
bGlvcyBiZWNhdXNlIHlvdSBzaG91bGQgaGF2ZSBzZXQgdGhlCj4gb3JkZXIgdG8gMC4gIFJpZ2h0
PyAgT3IgZGlkIHlvdSBtaXMtc3BlYWsgYW5kIHVzZSBhIDRLIFBBR0VfU0laRSBrZXJuZWwKPiB3
aXRoIGEgNjRrIGZzYmxvY2tzaXplPwoKVGhpcyBwYXJ0aWN1bGFyIGtlcm5lbCB3YXJuaW5nIGlz
IGFybTY0IHdpdGggNjRrIGJhc2UgcGFnZXMgYW5kIGEgNGsKZnNibG9jayBzaXplLCBhbmQgbXkg
c3VzcGljaW9uIGlzIHRoYXQgdWRldi9saWJibGtpZCBhcmUgY3JlYXRpbmcgdGhlCmJ1ZmZlciBo
ZWFkcyBvciBzb21ldGhpbmcgd2VpcmQgbGlrZSB0aGF0LgoKT24geDY0IHdpdGggNGsgYmFzZSBw
YWdlcywgeGZzLzAzMiBjcmVhdGVzIGEgZmlsZXN5c3RlbSB3aXRoIDY0ayBzZWN0b3IKc2l6ZSBh
bmQgdGhlcmUncyBhbiBhY3R1YWwga2VybmVsIGNyYXNoIHJlc3VsdGluZyBmcm9tIGEgdWRldiB3
b3JrZXI6Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWZzZGV2ZWwvMjAyNTA0MDgxNzUx
MjUuR0w2MjY2QGZyb2dzZnJvZ3Nmcm9ncy9ULyN1CgpTbyBJIGRpZG4ndCBtaXNzcGVhaywgSSBq
dXN0IGhhdmUgdHdvIHByb2JsZW1zLiAgSSBhY3R1YWxseSBoYXZlIGZvdXIKcHJvYmxlbXMsIGJ1
dCB0aGUgb3RoZXJzIGFyZSBsb29wIGRldmljZSBiZWhhdmlvciBjaGFuZ2VzLgoKLS1ECgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
