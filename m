Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5FDC369A4
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 17:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744134560; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=yMdlZbnyVsyZ/VnEg99Q0M+qlAmGulmxGbWKrFiSACI=;
 b=J3SHmLKFRngYzANALdM0sSbdmngAHcZn0xgwujutB4ka7sRub4fNXHqzASDZEeyACZrvC
 hAJVhb4O0ccq95Usg0ca3Du13HQYAtZ5lFGO+J9jGbiotqQLciix/0EYsBfcSKAJkODPATg
 m9JVFfo2PIhGeg+CfEd9+IFaruaFkQw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45A313CB3BF
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 19:49:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAE523CABDA
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 19:48:58 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org;
 envelope-from=djwong@kernel.org; receiver=lists.linux.it)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E0551600C94
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 19:48:57 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 044B344B5A;
 Tue,  8 Apr 2025 17:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F30C4CEE5;
 Tue,  8 Apr 2025 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744134535;
 bh=TdcykO/mghNf7CApPAPiGbc4Ap+76aFjaQ1G0ZF/1Fw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r011JZJ1Bwu5Q3CTglhODEsz9xvCkNNFznG4hJq0zj2FGM9UvvS6i18OLvLwe9EIW
 wbciFnly4IhqfzgqcxVGhGbTXEPXWtX2tSZsbyJQCDrZj0lsAvc1ctVYf4zeFktpIZ
 3vZm/cpmUHcjicVH0gPjtT+TAKnAPx/IS2GpFhx4eiyBRRwaYtosGcFp+8vzy3Bw+N
 XTN8eS0glsG4Jmqi5/T5CorQajBJXZ0O9B3f/BZ4GGrHHd3u+4exvp31qgZ7FBuoU8
 kzzNFYOm4wswHtUy1uL8Clg7ln3OgJeic63egQay8Be9BmABHamxhE98z7PlVQxf2P
 JtSj3XxUtX+og==
Date: Tue, 8 Apr 2025 10:48:55 -0700
To: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20250408174855.GI6307@frogsfrogsfrogs>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
 Matthew Wilcox <willy@infradead.org>, Pankaj Raghav <p.raghav@samsung.com>,
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

T24gVHVlLCBBcHIgMDgsIDIwMjUgYXQgMTA6MjQ6NDBBTSAtMDcwMCwgTHVpcyBDaGFtYmVybGFp
biB3cm90ZToKPiBPbiBUdWUsIEFwciA4LCAyMDI1IGF0IDEwOjA24oCvQU0gTHVpcyBDaGFtYmVy
bGFpbiA8bWNncm9mQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gRnVuCj4gPiBwdXp6bGUgZm9yIHRo
ZSBjb21tdW5pdHkgaXMgZmlndXJpbmcgb3V0ICp3aHkqIG9oIHdoeSBkaWQgYSBsYXJnZSBmb2xp
bwo+ID4gZW5kIHVwIGJlaW5nIHVzZWQgb24gYnVmZmVyLWhlYWRzIGZvciB5b3VyIHVzZSBjYXNl
ICp3aXRob3V0KiBhbiBMQlMKPiA+IGRldmljZSAobG9naWNhbCBibG9jayBzaXplKSBiZWluZyBw
cmVzZW50LCBhcyBJIGFzc3VtZSB5b3UgZGlkbid0IGhhdmUKPiA+IG9uZSwgaWUgc2F5IGEgbnZt
ZSBvciB2aXJ0aW8gYmxvY2sgZGV2aWNlIHdpdGggbG9naWNhbCBibG9jayBzaXplICA+Cj4gPiBQ
QUdFX1NJWkUuIFRoZSBhcmVhIGluIHF1ZXN0aW9uIHdvdWxkIHRyaWdnZXIgb24gZm9saW8gbWln
cmF0aW9uICpvbmx5Kgo+ID4gaWYgeW91IGFyZSBtaWdyYXRpbmcgbGFyZ2UgYnVmZmVyLWhlYWQg
Zm9saW9zLiBXZSBvbmx5IGNyZWF0ZSB0aG9zZQo+IAo+IFRvIGJlIGNsZWFyLCBsYXJnZSBmb2xp
b3MgZm9yIGJ1ZmZlci1oZWFkcy4KPiA+IGlmCj4gPiB5b3UgaGF2ZSBhbiBMQlMgZGV2aWNlIGFu
ZCBhcmUgbGV2ZXJhZ2luZyB0aGUgYmxvY2sgZGV2aWNlIGNhY2hlIG9yIGEKPiA+IGZpbGVzeXN0
ZW0gd2l0aCBidWZmZXItaGVhZHMgd2l0aCBMQlMgKHRoZXkgZG9uJ3QgZXhpc3QgeWV0IG90aGVy
IHRoYW4KPiA+IHRoZSBibG9jayBkZXZpY2UgY2FjaGUpLgoKTXkgZ3Vlc3MgaXMgdGhhdCB1ZGV2
IG9yIHNvbWV0aGluZyB0cmllcyB0byByZWFkIHRoZSBkaXNrIGxhYmVsIGluCnJlc3BvbnNlIHRv
IHNvbWUgdWV2ZW50IChta2ZzLCBtb3VudCwgdW5tb3VudCwgZXRjKSwgd2hpY2ggY3JlYXRlcyBh
CmxhcmdlIGZvbGlvIGJlY2F1c2UgbWluX29yZGVyID4gMCwgYW5kIGF0dGFjaGVzIGEgYnVmZmVy
IGhlYWQuICBUaGVyZSdzCmEgc2VwYXJhdGUgY3Jhc2ggcmVwb3J0IHRoYXQgSSdsbCBjYyB5b3Ug
b24uCgotLUQKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
