Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4688CE7A81
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 12:40:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EE863CE21D
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 14:40:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A0BE3CB326
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 14:39:55 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 053811A00997
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 14:39:54 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 1F1B1B80D83;
 Mon, 25 Sep 2023 12:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1342BC433C8;
 Mon, 25 Sep 2023 12:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695645592;
 bh=5aN+37/37gh3gx5jsw17r7C+kMfBRl0h8pMLO3kka40=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gO201HxAgH3MHkf/tCnnUItOCqaQIkMbyjs99ieSgTaCw2pe7/5fQOGCy0xCiq+je
 C802H/DRSGF9/a9WDaweb/h0n8xF7T+Ma47mJaB7ecpOvLqsIRfVnMkWjFbvV0VWWS
 2b2zQd3OwTkHFuiSM3qteCzxegmsvkkTxC14093EB0lUB/i7t6VvbpVevjGr10/wo3
 bea+yzumrZrDOXnfjnPUthF/r6tOh1FqAm20+XORQRK6rdc5p/NPVL8zl84AcZ1Uex
 uAAwufY/dZWZJCMsf0W+CWhHevkMHZMtDKAnFZHLtbj0k2XjF/hd8OMEjpu2AfDFUs
 W744U7SRMnw9g==
Date: Mon, 25 Sep 2023 14:39:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230925-festbesuch-komplett-d8c4ae2e1066@brauner>
References: <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org>
 <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
 <ZRCwjGSF//WUPohL@casper.infradead.org>
 <CAD_8n+SBo4EaU4-u+DaEFq3Bgii+vX0JobsqJV-4m+JjY9wq8w@mail.gmail.com>
 <ZREr3M32aIPfdem7@casper.infradead.org>
 <CAOQ4uxgUC2KxO2fD-rSgVo3RyrrWbP-UHH+crG57uwXVn_sf2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgUC2KxO2fD-rSgVo3RyrrWbP-UHH+crG57uwXVn_sf2Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, Jan Kara <jack@suse.cz>, lkp@intel.com,
 Matthew Wilcox <willy@infradead.org>, oe-lkp@lists.linux.dev,
 kernel test robot <oliver.sang@intel.com>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Reuben Hawkins <reubenhwk@gmail.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMTI6NDM6NDJQTSArMDMwMCwgQW1pciBHb2xkc3RlaW4g
d3JvdGU6Cj4gT24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgOTo0MuKAr0FNIE1hdHRoZXcgV2lsY294
IDx3aWxseUBpbmZyYWRlYWQub3JnPiB3cm90ZToKPiA+Cj4gPiBPbiBTdW4sIFNlcCAyNCwgMjAy
MyBhdCAxMTozNTo0OFBNIC0wNTAwLCBSZXViZW4gSGF3a2lucyB3cm90ZToKPiA+ID4gVGhlIHYy
IHBhdGNoIGRvZXMgTk9UIHJldHVybiBFU1BJUEUgb24gYSBzb2NrZXQuICBJdCBzdWNjZWVkcy4K
PiA+ID4KPiA+ID4gcmVhZGFoZWFkMDEuYzo1NDogVElORk86IHRlc3RfaW52YWxpZF9mZCBwaXBl
Cj4gPiA+IHJlYWRhaGVhZDAxLmM6NTY6IFRGQUlMOiByZWFkYWhlYWQoZmRbMF0sIDAsIGdldHBh
Z2VzaXplKCkpIGV4cGVjdGVkCj4gPiA+IEVJTlZBTDogRVNQSVBFICgyOSkKPiA+ID4gcmVhZGFo
ZWFkMDEuYzo2MDogVElORk86IHRlc3RfaW52YWxpZF9mZCBzb2NrZXQKPiA+ID4gcmVhZGFoZWFk
MDEuYzo2MjogVEZBSUw6IHJlYWRhaGVhZChmZFswXSwgMCwgZ2V0cGFnZXNpemUoKSkgc3VjY2Vl
ZGVkCj4gPiA+IDwtLS0tLS0taGVyZQo+ID4KPiA+IFRoYW5rcyEgIEkgYW0gb2YgdGhlIHZpZXcg
dGhhdCB0aGlzIGlzIHdyb25nIChhbHRob3VnaCBwcm9iYWJseQo+ID4gaGFybWxlc3MpLiAgSSBz
dXNwZWN0IHdoYXQgaGFwcGVucyBpcyB0aGF0IHdlIHRha2UgdGhlCj4gPiAnYmRpID09ICZub29w
X2JhY2tpbmdfZGV2X2luZm8nIGNvbmRpdGlvbiBpbiBnZW5lcmljX2ZhZHZpc2UoKQo+ID4gKHNp
bmNlIEkgZG9uJ3Qgc2VlIGFueXdoZXJlIGluIG5ldC8gc2V0dGluZyBmX29wLT5mYWR2aXNlKSBh
bmQgc28KPiA+IHJldHVybiAwIHdpdGhvdXQgZG9pbmcgYW55IHdvcmsuCj4gPgo+ID4gVGhlIGNv
cnJlY3Qgc29sdXRpb24gaXMgcHJvYmFibHkgeW91ciB2MiwgY29tYmluZWQgd2l0aDoKPiA+Cj4g
PiAgICAgICAgIGlub2RlID0gZmlsZV9pbm9kZShmaWxlKTsKPiA+IC0gICAgICAgaWYgKFNfSVNG
SUZPKGlub2RlLT5pX21vZGUpKQo+ID4gKyAgICAgICBpZiAoU19JU0ZJRk8oaW5vZGUtPmlfbW9k
ZSkgfHwgU19JU1NPQ0soaW5vZGUtPmlfbW9kZSkpCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJu
IC1FU1BJUEU7Cj4gPgo+ID4gaW4gZ2VuZXJpY19mYWR2aXNlKCksIGJ1dCB0aGF0IHRoZW4gY2hh
bmdlcyB0aGUgcmV0dXJuIHZhbHVlIGZyb20KPiA+IHBvc2l4X2ZhZHZpc2UoKSwgYXMgSSBvdXRs
aW5lZCBpbiBteSBwcmV2aW91cyBlbWFpbC4gIEFuZCBJJ20gT0sgd2l0aAo+ID4gdGhhdCwgYmVj
YXVzZSBJIHRoaW5rIGl0J3Mgd2hhdCBQT1NJWCBpbnRlbmRlZC4gIEFtaXIgbWF5IHdlbGwgZGlz
YWdyZWUKPiA+IDstKQo+IAo+IEkgcmVhbGx5IGhhdmUgbm8gcHJvYmxlbSB3aXRoIHRoYXQgY2hh
bmdlIHRvIHBvc2l4X2ZhZHZpc2UoKS4KPiBJIG9ubHkgbWVhbnQgdG8gc2F5IHRoYXQgd2UgYXJl
IG5vdCBnb2luZyB0byBhc2sgUmV1YmVuIHRvIHRhbGsgdG8KPiB0aGUgc3RhbmRhcmQgY29tbWl0
dGVlLCBidXQgdGhhdCdzIG9idmlvdXMgOy0pCj4gQSBwYXRjaCB0byBtYW4tcGFnZXMsIHRoYXQg
SSB3b3VsZCByZWNvbW1lbmQgYXMgYSBmb2xsb3cgdXAuCj4gCj4gRldJVywgSSBjaGVja2VkIGFu
ZCB0aGVyZSBpcyBjdXJyZW50bHkgbm8gdGVzdCBmb3IKPiBwb3NpeF9mYWR2aXNlKCkgb24gc29j
a2V0IGluIExUUCBBRkFJSy4KPiBNYXliZSBDeXJpbCB3aWxsIGZvbGxvdyB5b3VyIHN1Z2dlc3Rp
b24gYW5kIHRoaXMgd2lsbCBhZGQgdGVzdAo+IGNvdmVyYWdlIGZvciBzb2NrZXQgaW4gcG9zaXhf
ZmFkdmlzZSgpLgo+IAo+IFJldWJlbiwKPiAKPiBUaGUgYWN0aW9uYWJsZSBpdGVtLCBpZiBhbGwg
YWdyZWUgd2l0aCBNYXR0aGV3J3MgcHJvcG9zYWwsIGlzCj4gbm90IHRvIGNoYW5nZSB0aGUgdjIg
cGF0Y2ggdG8gcmVhZGFoZWFkKCksIGJ1dCB0byBzZW5kIGEgbmV3Cj4gcGF0Y2ggZm9yIGdlbmVy
aWNfZmFkdmlzZSgpLgo+IAo+IFdoZW4geW91IHNlbmQgdGhlIHBhdGNoIHRvIENocmlzdGlhbiwg
eW91IHNob3VsZCBzcGVjaWZ5Cj4gdGhlIGRlcGVuZGVuY3kgLSBpdCBuZWVkcyB0byBiZSBhcHBs
aWVkIGJlZm9yZSB0aGUgcmVhZGFoZWFkCj4gcGF0Y2guCj4gCj4gSWYgdGhlIHJlYWRhaGVhZCBw
YXRjaCB3YXMgbm90IGFscmVhZHkgaW4gdGhlIHZmcyB0cmVlLCB5b3UKPiB3b3VsZCBoYXZlIG5l
ZWRlZCB0byBzZW5kIGEgcGF0Y2ggc2VyaWVzIHdpdGggYSBjb3ZlciBsZXR0ZXIsCj4gd2hlcmUg
eW91IHdvdWxkIGxlYXZlIHRoZSBSZXZpZXdlZC1ieSBvbiB0aGUgdW5jaGFuZ2VkCj4gWzIvMl0g
cmVhZGFoZWFkIHBhdGNoLgo+IAo+IFNlbmRpbmcgYSBwYXRjaCBzZXJpZXMgaXMgYSBnb29kIHRo
aW5nIHRvIHByYWN0aWNlLCBidXQgaXQgaXMKPiBub3Qgc3RyaWN0bHkgbmVlZGVkIGluIHRoaXMg
Y2FzZSwgc28gSSdsbCBsZWF2ZSBpdCB1cCB0byB5b3UgdG8gZGVjaWRlLgoKTXkgbGV2ZWwgb2Yg
Y29uZnVzaW9uIGlzIHJhdGhlciBoaWdoIGF0IHRoZSBtb21lbnQuCkknbGwgbGVhdmUgdGhlIHJl
YWRhaGVhZCBmaXggaW4gdmZzLm1pc2MgKEluIGZhY3QsIEkganVzdCByZWJhc2VkIGl0IG9uCnRv
cCBldmVyeXRpbWUgSSBwaWNrZWQgdXAgYSBwYXRjaCBzbyBhcyB0byBub3QgaW52YWxpZGF0ZSB0
aGUgd2hvbGUgdHJlZQp3aGVuIGl0IGNoYW5nZXMuKSBhbmQgdGhlbiBwbGVhc2Ugc2VuZCB0aGUg
cHJlcGFyYXRvcnkgZml4LiBEb24ndCByZXNlbmQKdGhlIHJlYWRhaGVhZCBmaXggaWYgbm90aGlu
ZyBoYXMgY2hhbmdlZC4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
