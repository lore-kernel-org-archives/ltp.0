Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3218DC36010
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744139615; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nCF6g2ny0U+vEyQp74yfWJEtOg6xlGbMh3hMQ1V+isM=;
 b=kk6piIgWVUq0UxzNoqr5/OiJ5g0EPkZ1BvEwXMUEDOYpUxIJQiSoSKFTRNvE8YVJ5PzrV
 2TSAivv1URFBbmRCcxphShpKXe8S+oEdi8sAkivExJX6d0Zh3eQEzZFImM7ILK+G7P+4/bi
 JwsPkKFV45H46u3AaP5jQa+tykTbu7I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95E8D3CB3BC
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 21:13:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1099B3C048F
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 21:13:11 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org;
 envelope-from=mcgrof@kernel.org; receiver=lists.linux.it)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DE8EE1400F21
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 21:13:10 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5ADF461166;
 Tue,  8 Apr 2025 19:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B25C4CEE5;
 Tue,  8 Apr 2025 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744139588;
 bh=epQh/gaUaDDW5jnc7/qOqV5jwYTP+Jz/mj3glQvJiQg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ghNAaHlG7bqqdTxG3szwAUndPLZmKSaKqmZSGG4kJL/NidXNlCj+Y1zKbb1AfYUZh
 u3l6Ml0jksUXqEqFqVVlIVrdweI9ZKdypmpH5OEuIqw74C2giSqyp8L1wZ3MDUfVu4
 lPXocc1BiOdbt77c5T7nHbZ4ctkLeYmyZmhQ+1GIx93+91m7HQSr5vmSEJJMz6Tftr
 7vzlMGvyrH3zlAQdsqgPCuYf97ErAmCjzFBVEtK5SYzpYTSzCfxIpNm+WdYf1Tl/E8
 oennVE7UltJetxq322Q45lj2emq2/buAZozulh4s7ml32uOAqTV+Bj5p6KSo1dPjT3
 ZWQEFmVjdTaXQ==
Date: Tue, 8 Apr 2025 12:13:06 -0700
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <Z_V1QiXTCYQk9sfZ@bombadil.infradead.org>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
 <20250408174855.GI6307@frogsfrogsfrogs>
 <Z_ViElxiCcDNpUW8@casper.infradead.org>
 <20250408180240.GM6266@frogsfrogsfrogs>
 <Z_VwF1MA-R7MgDVG@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z_VwF1MA-R7MgDVG@casper.infradead.org>
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
From: Luis Chamberlain via ltp <ltp@lists.linux.it>
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
 David Bueso <dave@stgolabs.net>, lkp@intel.com, gost.dev@samsung.com,
 Alistair Popple <apopple@nvidia.com>, Pankaj Raghav <p.raghav@samsung.com>,
 John Garry <john.g.garry@oracle.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>,
 ltp@lists.linux.it, linux-block@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Tso Ted <tytso@mit.edu>,
 Oliver Sang <oliver.sang@intel.com>, Johannes Weiner <hannes@cmpxchg.org>,
 oe-lkp@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBcHIgMDgsIDIwMjUgYXQgMDc6NTE6MDNQTSArMDEwMCwgTWF0dGhldyBXaWxjb3gg
d3JvdGU6Cj4gT24gVHVlLCBBcHIgMDgsIDIwMjUgYXQgMTE6MDI6NDBBTSAtMDcwMCwgRGFycmlj
ayBKLiBXb25nIHdyb3RlOgo+ID4gT24gVHVlLCBBcHIgMDgsIDIwMjUgYXQgMDY6NTE6MTRQTSAr
MDEwMCwgTWF0dGhldyBXaWxjb3ggd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgQXByIDA4LCAyMDI1IGF0
IDEwOjQ4OjU1QU0gLTA3MDAsIERhcnJpY2sgSi4gV29uZyB3cm90ZToKPiA+ID4gPiBPbiBUdWUs
IEFwciAwOCwgMjAyNSBhdCAxMDoyNDo0MEFNIC0wNzAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3Rl
Ogo+ID4gPiA+ID4gT24gVHVlLCBBcHIgOCwgMjAyNSBhdCAxMDowNuKAr0FNIEx1aXMgQ2hhbWJl
cmxhaW4gPG1jZ3JvZkBrZXJuZWwub3JnPiB3cm90ZToKPiA+ID4gPiA+ID4gRnVuCj4gPiA+ID4g
PiA+IHB1enpsZSBmb3IgdGhlIGNvbW11bml0eSBpcyBmaWd1cmluZyBvdXQgKndoeSogb2ggd2h5
IGRpZCBhIGxhcmdlIGZvbGlvCj4gPiA+ID4gPiA+IGVuZCB1cCBiZWluZyB1c2VkIG9uIGJ1ZmZl
ci1oZWFkcyBmb3IgeW91ciB1c2UgY2FzZSAqd2l0aG91dCogYW4gTEJTCj4gPiA+ID4gPiA+IGRl
dmljZSAobG9naWNhbCBibG9jayBzaXplKSBiZWluZyBwcmVzZW50LCBhcyBJIGFzc3VtZSB5b3Ug
ZGlkbid0IGhhdmUKPiA+ID4gPiA+ID4gb25lLCBpZSBzYXkgYSBudm1lIG9yIHZpcnRpbyBibG9j
ayBkZXZpY2Ugd2l0aCBsb2dpY2FsIGJsb2NrIHNpemUgID4KPiA+ID4gPiA+ID4gUEFHRV9TSVpF
LiBUaGUgYXJlYSBpbiBxdWVzdGlvbiB3b3VsZCB0cmlnZ2VyIG9uIGZvbGlvIG1pZ3JhdGlvbiAq
b25seSoKPiA+ID4gPiA+ID4gaWYgeW91IGFyZSBtaWdyYXRpbmcgbGFyZ2UgYnVmZmVyLWhlYWQg
Zm9saW9zLiBXZSBvbmx5IGNyZWF0ZSB0aG9zZQo+ID4gPiA+ID4gCj4gPiA+ID4gPiBUbyBiZSBj
bGVhciwgbGFyZ2UgZm9saW9zIGZvciBidWZmZXItaGVhZHMuCj4gPiA+ID4gPiA+IGlmCj4gPiA+
ID4gPiA+IHlvdSBoYXZlIGFuIExCUyBkZXZpY2UgYW5kIGFyZSBsZXZlcmFnaW5nIHRoZSBibG9j
ayBkZXZpY2UgY2FjaGUgb3IgYQo+ID4gPiA+ID4gPiBmaWxlc3lzdGVtIHdpdGggYnVmZmVyLWhl
YWRzIHdpdGggTEJTICh0aGV5IGRvbid0IGV4aXN0IHlldCBvdGhlciB0aGFuCj4gPiA+ID4gPiA+
IHRoZSBibG9jayBkZXZpY2UgY2FjaGUpLgo+ID4gPiA+IAo+ID4gPiA+IE15IGd1ZXNzIGlzIHRo
YXQgdWRldiBvciBzb21ldGhpbmcgdHJpZXMgdG8gcmVhZCB0aGUgZGlzayBsYWJlbCBpbgo+ID4g
PiA+IHJlc3BvbnNlIHRvIHNvbWUgdWV2ZW50IChta2ZzLCBtb3VudCwgdW5tb3VudCwgZXRjKSwg
d2hpY2ggY3JlYXRlcyBhCj4gPiA+ID4gbGFyZ2UgZm9saW8gYmVjYXVzZSBtaW5fb3JkZXIgPiAw
LCBhbmQgYXR0YWNoZXMgYSBidWZmZXIgaGVhZC4gIFRoZXJlJ3MKPiA+ID4gPiBhIHNlcGFyYXRl
IGNyYXNoIHJlcG9ydCB0aGF0IEknbGwgY2MgeW91IG9uLgo+ID4gPiAKPiA+ID4gQnV0IHlvdSBz
YWlkOgo+ID4gPiAKPiA+ID4gPiB0aGUgbWFjaGluZSBpcyBhcm02NCB3aXRoIDY0ayBiYXNlcGFn
ZXMgYW5kIDRrIGZzYmxvY2sgc2l6ZToKPiA+ID4gCj4gPiA+IHNvIHRoYXQgc2hvdWxkbid0IGJl
IHVzaW5nIGxhcmdlIGZvbGlvcyBiZWNhdXNlIHlvdSBzaG91bGQgaGF2ZSBzZXQgdGhlCj4gPiA+
IG9yZGVyIHRvIDAuICBSaWdodD8gIE9yIGRpZCB5b3UgbWlzLXNwZWFrIGFuZCB1c2UgYSA0SyBQ
QUdFX1NJWkUga2VybmVsCj4gPiA+IHdpdGggYSA2NGsgZnNibG9ja3NpemU/Cj4gPiAKPiA+IFRo
aXMgcGFydGljdWxhciBrZXJuZWwgd2FybmluZyBpcyBhcm02NCB3aXRoIDY0ayBiYXNlIHBhZ2Vz
IGFuZCBhIDRrCj4gPiBmc2Jsb2NrIHNpemUsIGFuZCBteSBzdXNwaWNpb24gaXMgdGhhdCB1ZGV2
L2xpYmJsa2lkIGFyZSBjcmVhdGluZyB0aGUKPiA+IGJ1ZmZlciBoZWFkcyBvciBzb21ldGhpbmcg
d2VpcmQgbGlrZSB0aGF0Lgo+ID4gCj4gPiBPbiB4NjQgd2l0aCA0ayBiYXNlIHBhZ2VzLCB4ZnMv
MDMyIGNyZWF0ZXMgYSBmaWxlc3lzdGVtIHdpdGggNjRrIHNlY3Rvcgo+ID4gc2l6ZSBhbmQgdGhl
cmUncyBhbiBhY3R1YWwga2VybmVsIGNyYXNoIHJlc3VsdGluZyBmcm9tIGEgdWRldiB3b3JrZXI6
Cj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjUwNDA4MTc1MTI1
LkdMNjI2NkBmcm9nc2Zyb2dzZnJvZ3MvVC8jdQo+ID4gCj4gPiBTbyBJIGRpZG4ndCBtaXNzcGVh
aywgSSBqdXN0IGhhdmUgdHdvIHByb2JsZW1zLiAgSSBhY3R1YWxseSBoYXZlIGZvdXIKPiA+IHBy
b2JsZW1zLCBidXQgdGhlIG90aGVycyBhcmUgbG9vcCBkZXZpY2UgYmVoYXZpb3IgY2hhbmdlcy4K
PiAKPiBSaWdodCwgYnV0IHRoaXMgd2FybmluZyBvbmx5IHRyaWdnZXJzIGZvciBsYXJnZSBmb2xp
b3MuICBTbyBzb21laG93Cj4gd2UndmUgZ290IGEgbXVsdGktcGFnZSBmb2xpbyBpbiB0aGUgYmRl
didzIHBhZ2UgY2FjaGUuCj4gCj4gQWguICBJIHNlZS4KPiAKPiBibG9jay9iZGV2LmM6ICAgbWFw
cGluZ19zZXRfZm9saW9fbWluX29yZGVyKEJEX0lOT0RFKGJkZXYpLT5pX21hcHBpbmcsCj4gCj4g
c28gd2UncmUgdGVsbGluZyB0aGUgYmRldiB0aGF0IGl0IGNhbiBnbyB1cCB0byBNQVhfUEFHRUNB
Q0hFX09SREVSLgoKQWggeWVzIHNpbGx5IG1lIHRoYXQgd291bGQgZXhwbGFpbiB0aGUgbGFyZ2Ug
Zm9saW9zIHdpdGhvdXQgTEJTIGRldmljZXMuCgo+IEFuZCB0aGVuIHdlIGNhbGwgcmVhZGFoZWFk
LCB3aGljaCB3aWxsIGhhcHBpbHkgcHV0IG9yZGVyLTIgZm9saW9zCj4gaW4gdGhlIHBhZ2VjYWNo
ZSBiZWNhdXNlIG9mIG15IGJ1ZyB0aGF0IHdlJ3ZlIG5ldmVyIGJvdGhlcmVkIGZpeGluZy4KPiAK
PiBXZSBzaG91bGQgcHJvYmFibHkgZml4IHRoYXQgbm93LCBidXQgYXMgYSB0ZW1wb3JhcnkgbWVh
c3VyZSBpZgo+IHlvdSdkIGxpa2UgdG8gcHV0Ogo+IAo+IG1hcHBpbmdfc2V0X2ZvbGlvX29yZGVy
X3JhbmdlKEJEX0lOT0RFKGJkZXYpLT5pX21hcHBpbmcsIG1pbiwgbWluKQo+IAo+IGluc3RlYWQg
b2YgdGhlIG1hcHBpbmdfc2V0X2ZvbGlvX21pbl9vcmRlcigpLCB0aGF0IHdvdWxkIG1ha2UgdGhl
IGJ1Zwo+IG5vIGxvbmdlciBhcHBlYXIgZm9yIHlvdS4KCkFncmVlZC4KCiAgTHVpcwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
