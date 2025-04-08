Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7341EC369A1
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744135629; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2MJFczpKVSMNYsRFAS6ioRD2Do+e/iPyq/ffTXMk5uc=;
 b=ItHXErkkPzSIjndT+c1omHVDcX9Dizj6RarYYgdJ7Dddls9wwA6Vr8C5v55G9IfXdsgkx
 DP5R7nXeL7VkSJ5IMryEl+uQK0wHtS3bSMPpdce0tCaureJX6bqi0TB62HU+CDoa7AzsbSb
 +SlAFEStmNOJR8GAAc5sT84RmjW2E6A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A9453CB3C9
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 20:07:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79DAD3C048F
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 20:06:46 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=mcgrof@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9DF01601025
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 20:06:44 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 206915C3AD7;
 Tue,  8 Apr 2025 18:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4529EC4CEE5;
 Tue,  8 Apr 2025 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744135602;
 bh=Tp1KLkGydqnHF26lk/Kt0Weyj/mcdsm8Zy6mmUhq+L8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qZTRLlZsgsR2ikOa/87ONS7coMzrc9mQFK88J/FCDu4fbyg4rMW9QHcYs0EyeojPA
 p8B9V7aznJ0rCr2wJXhiLnnxpcXNCwhAXxafIFjA3lRZCTjsDLD8nLDe5i+cfymVzC
 AbrGm890ErR1Jysv/8XD9PVOvKMjI4Uga2lTWuW08MoRdNofGbbSLpg6bstfH1ss1U
 9wtvy8mePK/+dINHjjT4qdRqwEJClrtoxctv4cAPzd3A4vt5K3OApxB1GLk1Uo62SB
 bhzDWg3AS7cyKAHBlYSWGtvy0smd656QjTCkiWR+n9s1wjoJ7UrRMLDNCP1H63vfrD
 Mh2rhPNo0BuOQ==
Date: Tue, 8 Apr 2025 11:06:40 -0700
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <Z_VlsLGTbx9Ub843@bombadil.infradead.org>
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
From: Luis Chamberlain via ltp <ltp@lists.linux.it>
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
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
cmUncwo+IGEgc2VwYXJhdGUgY3Jhc2ggcmVwb3J0IHRoYXQgSSdsbCBjYyB5b3Ugb24uCgpPSyBz
byBhcyB3aWxseSBwb2ludGVkIG91dCBJIGJ1eSB0aGF0IGZvciB4ODZfNjQgKmlmZiogd2UgZG8g
YWxyZWFkeQpoYXZlIG9wcG9ydHVuaXN0aWMgbGFyZ2UgZm9saW8gc3VwcG9ydCBmb3IgdGhlIGJ1
ZmZlci1oZWFkIHJlYWQvd3JpdGUKcGF0aC4gQnV0IGFsc28sIEkgZG9uJ3QgdGhpbmsgd2UgZW5h
YmxlIGxhcmdlIGZvbGlvcyB5ZXQgb24gdGhlIGJsb2NrCmRldmljZSBjYWNoZSBhb3BzIHVubGVz
cyB3ZSBoYXZlIGEgbWluIG9yZGVyIGJsb2NrIGRldmljZS4uLiBzbyB3aGF0CmdpdmVzPwoKICBM
dWlzCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
