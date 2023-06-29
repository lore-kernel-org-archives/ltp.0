Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8316FEB64D9
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 08:46:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16DD63CC594
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 10:45:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A99C23C99A5
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 10:45:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 78C1B600F0E
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 10:45:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA7321F892;
 Thu, 29 Jun 2023 08:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688028341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpp+eteAanAusl2RdhSlDfGKBCbUSpm0x04ccu9yCqA=;
 b=ttrFoC+STj0/u0pdDzeKR0HdhBNNRb0R4PhZUK+KKZNBXKjGQmARJstn6OyrNNVsFNQuFn
 RXdRYCtXMVVJO0xjqvE+Z1v4eLNrvVbRhsZatBbYST1Xju+8lEs2/fJ2SBiO7UlM8vNUVK
 BK/O52g5Mxk0B3jnxLR/uZMeKaHRDgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688028341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpp+eteAanAusl2RdhSlDfGKBCbUSpm0x04ccu9yCqA=;
 b=B1I5LC/MLGhf18IWYapbh45QWue5BQBWp1qN/0ebxZqKvTI3+PgyokeqQdNKTYSIj2dGyw
 yj08aLiWjjSZUnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99319139FF;
 Thu, 29 Jun 2023 08:45:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id l5deJbVEnWTAZwAAMHmgww
 (envelope-from <jack@suse.cz>); Thu, 29 Jun 2023 08:45:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 25F1CA0722; Thu, 29 Jun 2023 10:45:41 +0200 (CEST)
Date: Thu, 29 Jun 2023 10:45:41 +0200
From: Jan Kara <jack@suse.cz>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Message-ID: <20230629084541.5hjyskliqntcr5y4@quack3>
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <20230628113853.2b67fic5nvlisx3r@quack3>
 <ns6dcoilztzcutuduujfnbz5eggy3fk7z4t2bajy545zbay5d7@4bodludrpxe6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ns6dcoilztzcutuduujfnbz5eggy3fk7z4t2bajy545zbay5d7@4bodludrpxe6>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/3] fanotify accounting for fs/splice.c
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Chung-Chiang Cheng <cccheng@synology.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiBXZWQgMjgtMDYtMjMgMjA6NTQ6MjgsIEFoZWxlbmlhIFppZW1pYcWEc2thIHdyb3Rl
Ogo+IE9uIFdlZCwgSnVuIDI4LCAyMDIzIGF0IDAxOjM4OjUzUE0gKzAyMDAsIEphbiBLYXJhIHdy
b3RlOgo+ID4gT24gVHVlIDI3LTA2LTIzIDIyOjUwOjQ2LCBBaGVsZW5pYSBaaWVtaWHFhHNrYSB3
cm90ZToKPiA+ID4gQWx3YXlzIGdlbmVyYXRlIG1vZGlmeSBvdXQsIGFjY2VzcyBpbiBmb3Igc3Bs
aWNlOwo+ID4gPiB0aGlzIGdldHMgYXV0b21hdGljYWxseSBtZXJnZWQgd2l0aCBubyB1Z2x5IHNw
ZWNpYWwgY2FzZXMuCj4gPiA+IAo+ID4gPiBObyBjaGFuZ2VzIHRvIDIvMyBvciAzLzMuCj4gPiBU
aGFua3MgZm9yIHRoZSBwYXRjaGVzIEFoZWxlbmEhIFRoZSBjb2RlIGxvb2tzIGZpbmUgdG8gbWUg
YnV0IHRvIGJlIGhvbmVzdAo+ID4gSSBzdGlsbCBoYXZlIG9uZSB1bnJlc29sdmVkIHF1ZXN0aW9u
IHNvIGxldCBtZSB0aGluayBhYm91dCBpdCBsb3VkIGhlcmUgZm9yCj4gPiBkb2N1bWVudGF0aW9u
IHB1cnBvc2VzIDopLiBEbyB3ZSB3YW50IGZzbm90aWZ5IChhbnkgZmlsZXN5c3RlbQo+ID4gbm90
aWZpY2F0aW9uIGZyYW1ld29yayBsaWtlIGlub3RpZnkgb3IgZmFub3RpZnkpIHRvIGFjdHVhbGx5
IGdlbmVyYXRlCj4gPiBldmVudHMgb24gRklGT3M/IEZJRk9zIGFyZSB2aXJ0dWFsIG9iamVjdHMg
YW5kIGFyZSBub3QgcGFydCBvZiB0aGUKPiA+IGZpbGVzeXN0ZW0gYXMgc3VjaCAod2VsbCwgdGhl
IGlub2RlIGl0c2VsZiBhbmQgdGhlIG5hbWUgaXMpLCBoZW5jZQo+ID4gKmZpbGVzeXN0ZW0qIG5v
dGlmaWNhdGlvbiBmcmFtZXdvcmsgZG9lcyBub3Qgc2VlbSBsaWtlIGEgZ3JlYXQgZml0IHRvIHdh
dGNoCj4gPiBmb3IgY2hhbmdlcyBvciBhY2Nlc3NlcyB0aGVyZS4gQW5kIGlmIHdlIHNheSAieWVz
IiBmb3IgRklGT3MsIHRoZW4gd2h5IG5vdAo+ID4gQUZfVU5JWCBzb2NrZXRzPyBXaGVyZSBkbyB3
ZSBkcmF3IHRoZSBsaW5lPyBBbmQgaXMgaXQgYWxsIHdvcnRoIHRoZQo+ID4gdHJvdWJsZT8KPiBB
cyBhIHJlbGF0aXZlIG91dHNpZGVyIChJIGhhdmVuJ3QgdXNlZCBpbm90aWZ5IGJlZm9yZSB0aGlz
LCBhbmQgaGF2ZSBub3QKPiAgYmVlbiBzdWJqZWN0ZWQgdG8gaXQgb3IgaXRzIHBlcmlwaGVyaWVz
IGJlZm9yZSksCj4gSSBpbnRlcnByZXRlZCBpbm90aWZ5IGFzIGJlaW5nIHRoZSBDb3JyZWN0IHNv
bHV0aW9uIGZvcjoKPiAgIDEuIHN0dWZmIHlvdSBjYW4gZmluZCBpbiBhIG5vcm1hbAo+ICAgICAg
KG5vbi0vZGV2LCB5b3UgZG9uJ3Qgd2FudCB0byB0b3VjaCBkZXZpY2VzKQo+ICAgICAgZmlsZXN5
c3RlbSB0cmF2ZXJzYWwKPiAgIDIuIHN0dWZmIHlvdSBjYW4gb3Blbgo+IHdoZXJlLCBnb2luZyBk
b3duIHRoZSBsaXN0IGluIGlub2RlKDcpOgo+ICAgU19JRlNPQ0sgICBjYW4ndCBvcGVuCj4gICBT
X0lGTE5LICAgIGNhbid0IG9wZW4KPiAgIFNfSUZSRUcgICAgeWVzIQo+ICAgU19JRkJMSyAgICBp
dCdzIGEgZGV2aWNlCj4gICBTX0lGRElSICAgIHllcyEKPiAgIFNfSUZDSFIgICAgaXQncyBhIGRl
dmljZQo+ICAgU19JRklGTyAgICB5ZXMhCj4gCj4gSXQgYXBwZWFycyB0aGF0IEknbSBub3QgdGhl
IG9ubHkgb25lIHdobydzIGludGVycHJldGVkIGl0IHRoYXQgd2F5LAo+IGVzcGVjaWFsbHkgc2lu
Y2UgbmVpdGhlciByZWd1bGFyIGZpbGVzIG5vciBwaXBlcyBhcmUgcG9sbGFibGUuCj4gKFRob3Vn
aCwgdW5kZXIgdGhhdCBzYW1lIGNhdGVnb3Jpc2F0aW9uLCBJIHdvdWxkbid0IGJlIHN1cnByaXNl
ZAo+ICBpZiBhbm9ueW1vdXMgcGlwZXMgaGFkIGJlZW4gcmVmdXNlZCwgZm9yIGV4YW1wbGUsIHNp
bmNlIHRob3NlIGFyZQo+ICBjb252ZW50aW9uYWxseSB1bm5hbWVhYmxlLikKPiAKPiBUbyB0aGlz
IGVuZCwgSSdkIHNheSB3ZSdyZSBsZWF2aW5nIHRoZSBsaW5lIHByZWNpc2VseSB3aGVyZSBpdCB3
YXMgZHJhd24KPiBiZWZvcmUsIGV2ZW4gaWYgYnkgYWNjaWRlbnQuCgpJIGFncmVlLCBhbHRob3Vn
aCBJJ2Qgbm90ZSB0aGF0IHRoZXJlIGFyZSBTX0lGUkVHIGlub2RlcyB1bmRlciAvc3lzIG9yCi9w
cm9jIHdoZXJlIGl0IHdvdWxkIGJlIHRvbyBkaWZmaWN1bHQgdG8gcHJvdmlkZSBmc25vdGlmeSBl
dmVudHMgKGV4YWN0bHkKYmVjYXVzZSB0aGUgZmlsZSBjb250ZW50cyBpcyBub3QgImRhdGEgc3Rv
cmVkIHNvbWV3aGVyZSIgYnV0IHJhdGhlcgpzb21ldGhpbmcgImdlbmVyYXRlZCBvbiB0aGUgZmx5
Iikgc28gdGhlIGlsbHVzaW9uIGlzIG5vdCBwZXJmZWN0IGFscmVhZHkuCgo+ID4gSSB1bmRlcnN0
YW5kIHRoZSBjb252ZW5pZW5jZSBvZiBpbm90aWZ5IHdvcmtpbmcgb24gRklGT3MgZm9yIHRoZSAi
dGFpbCAtZiIKPiA+IHVzZWNhc2UgYnV0IHRoZW4gd291bGRuJ3QgdGhpcyBiZXR0ZXIgYmUgZml4
ZWQgaW4gdGFpbCgxKSBpdHNlbGYgYnkgdXNpbmcKPiA+IGVwb2xsKDcpIGZvciBGSUZPcyB3aGlj
aCwgYXMgSSd2ZSBub3RlZCBpbiBteSBvdGhlciByZXBseSwgZG9lcyBub3QgaGF2ZQo+ID4gdGhl
IHByb2JsZW0gdGhhdCBwb2xsKDIpIGhhcyB3aGVuIHRoZXJlIGFyZSBubyB3cml0ZXJzPwo+IFll
cywgZXBvbGwgaW4gRVQgbW9kZSByZXR1cm5zIFBPTExIVVAgb25seSBvbmNlLCBidXQgeW91IC9h
bHNvLyBuZWVkIHRoZQo+IGlub3RpZnkgYW55d2F5IGZvciByZWd1bGFyIGZpbGVzLCB3aGljaCBl
cG9sbCByZWZ1c2VzCj4gKGFuZCwgd2l0aCAtRiwgeW91IG1heSB3YW50IGJvdGggZXBvbGwgZm9y
IGEgcGlwZSBhbmQgaW5vdGlmeSBmb3IgdGhlCj4gIGRpcmVjdG9yeSBpdCdzIGNvbnRhaW5lZCBp
bikuCj4gSXMgaXQgcG9zc2libGUgdG8gZG8/IHllcy4gSXMgaXQgbW9yZSBhbm5veWluZyB0aGFu
IGp1c3QgaGF2aW5nIHBpcGVzCj4gcmVwb3J0IHdoZW4gdGhleSB3ZXJlIHdyaXR0ZW4gdG8/IHZl
cnkgbXVjaCBzby4KPiAKPiBpbm90aWZ5IGFjdHVhbGx5IHdvcmtpbmcoKikgaXMgcHJlc3VtYWJs
eSB3aHkgY29yZXV0aWxzIHRhaWwgZG9lc24ndCB1c2UKPiBlcG9sbCDigJIgaW5vdGlmeSBhbHJl
YWR5IHByb3ZpZGVzIGFsbCByZXF1aXJlZCBldmVudHMoKiksIHlvdSBjYW4gdXNlIHRoZQo+IHNh
bWUgY29kZSBmb3IgcmVndWxhciBmaWxlcyBhbmQgZmlmb3MsIGFuZCB3aXRoIG9uZSBmZXdlciBs
ZXZlbCBvZgo+IGluZGlyZWN0aW9uOiB0aGVyZSdzIGp1c3Qgbm8gbmVlZCgqKS4KPiAKPiAoKjog
ZXhjZXB0IHdpdGggYSBtYWdpYyBzeXNjYWxsIG9ubHkgSSB1c2UgYXBwYXJlbnRseSkKClllYWgs
IEkndmUgc2xlcHQgdG8gdGhpcyBhbmQgSSBzdGlsbCB0aGluayBhZGRpbmcgZnNub3RpZnkgZXZl
bnRzIHRvIHNwbGljZQppcyBhIG5pY2VyIG9wdGlvbiBzbyBmZWVsIGZyZWUgdG8gYWRkOgoKQWNr
ZWQtYnk6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+Cgp0byBhbGwga2VybmVsIHBhdGNoZXMgaW4g
eW91ciBzZXJpZXMuIFNpbmNlIHRoZSBjaGFuZ2VzIGFyZSBpbiBzcGxpY2UgY29kZSwKQ2hyaXN0
aWFuIG9yIEFsIFZpcm8gKHdobyB5b3UgYWxyZWFkeSBoYXZlIG9uIENDIGxpc3QpIHNob3VsZCBi
ZSBtZXJnaW5nCnRoaXMgc28gcGxlYXNlIG1ha2Ugc3VyZSB0byBhbHNvIGluY2x1ZGUgdGhlbSBp
biB0aGUgdjUgc3VibWlzc2lvbi4KCgkJCQkJCQkJSG9uemEKLS0gCkphbiBLYXJhIDxqYWNrQHN1
c2UuY29tPgpTVVNFIExhYnMsIENSCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
