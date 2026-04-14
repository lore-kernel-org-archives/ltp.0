Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531C5ED7B8B
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 09:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776158283; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=TXKwJ7MGxblPhlYaya43Ez7sduZoJM6RUHYyw3TuZmg=;
 b=DwRm3Vm5ZCtXeuWd+WZhmg7KLVA85xNxkFmxbgmJnv1k8PZCjT5ooZGgvOvKmnjJi3VSp
 meZ0kE8Tb3IfW++0KoJtFFN2vgQMhCv4ATV5+vM3wH+Fu2CAI/XbUmpFZGrwZbxR81htfTz
 w6n3ogtsOvLAOuqO5pciHPPxCxDEW08=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7C953E4AF4
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 11:18:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3527B3CEF96
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 11:17:39 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 418991A00891
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 11:17:38 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 37DBB41AFE;
 Tue, 14 Apr 2026 09:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C23C19425;
 Tue, 14 Apr 2026 09:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776158256;
 bh=Im93hMGzOEyfazCH17jiGCvum7o6LX/tIusdrDkKZ9k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HOSbjvsQZ2O7av5rPQBvKKjxgqhi8Pe9xnGh6UQoCqqHs/LKYcqWxhP7O2ZYReVCp
 YPd4jxY3Q/XVCAsztKMGvtqWiTt1vFatCdI/uLPCQrr7kCPMyG9+PN6XfTl1qVrhTt
 h0CEehodMWXkwrsl1mv0n49kLrOkk8M1Uuav1Ao7csKYhTkbsaCNXEs/846JWAzG9r
 uEel4Fm/k1uNApky5SH6FrxCP+NNl7sJ7VloacVpNwB2reZ8Jc5veHiDnPDtfVKGox
 1eeNrhaYovfDQckKBiq2S2T2AY7i2Or7E0IbjvaV4ULrOyfGImxKZ0QvIeKHIWWGVt
 OsNxzSAFA8cug==
Date: Tue, 14 Apr 2026 12:17:31 +0300
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20260414091731.GT21470@unreal>
References: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
 <20260325-infiniband_rdma-v1-2-9c1bd3e69d29@suse.com>
 <20260407132426.GC25645@pevik> <20260412141439.GD21470@unreal>
 <20260414073010.GB230573@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260414073010.GB230573@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] device-drivers/rdma: Add ucma_uaf01 test
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
From: Leon Romanovsky via ltp <ltp@lists.linux.it>
Reply-To: Leon Romanovsky <leon@kernel.org>
Cc: rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org,
 Eric Biggers <ebiggers3@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Doug Ledford <dledford@redhat.com>, Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBcHIgMTQsIDIwMjYgYXQgMDk6MzA6MTBBTSArMDIwMCwgUGV0ciBWb3JlbCB3cm90
ZToKPiBIaSBMZW9uLCBhbGwsCj4gCj4gPiBPbiBUdWUsIEFwciAwNywgMjAyNiBhdCAwMzoyNDoy
NlBNICswMjAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4gPiBIaSBBbmRyZWEsCj4gCj4gPiA+IGl0
J3MgYmVlbiBsb25nIHRpbWUgc2luY2UgdGhpcyB1c2UtYWZ0ZXItZnJlZSB3YXMgZml4ZWQsIGJ1
dCBJTUhPIHN0aWxsIHVzZWZ1bAo+ID4gPiB0byBoYXZlIGEgdGVzdCAoaXQncyBhbHNvIGtpbmQg
b2Ygc21va2UgdGVzdCBmb3IgcmRtYV9jbSkuCj4gPiA+IEFueXdheSwgTEdUTSwgYnV0IGl0J2Qg
YmUgbmljZSB0byByZXByb2R1Y2UgdGhlIGJ1Zy4KPiAKPiA+ID4gUmV2aWV3ZWQtYnk6IFBldHIg
Vm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IAo+ID4gPiA+IFRlc3QgZm9yIHVzZS1hZnRlci1mcmVl
IGluIFJETUEgVUNNQSB0cmlnZ2VyZWQgYnkgcmFjaW5nIENSRUFURV9JRCwKPiA+ID4gPiBCSU5E
X0lQLCBhbmQgTElTVEVOIG9wZXJhdGlvbnMuIFRocmVlIHRocmVhZHMgY29uY3VycmVudGx5IGlz
c3VlCj4gPiA+ID4gdGhlc2UgY29tbWFuZHMgdG8gL2Rldi9pbmZpbmliYW5kL3JkbWFfY20gYW5k
IHRoZSB0ZXN0IGNoZWNrcyBmb3IKPiA+ID4gPiBrZXJuZWwgdGFpbnQgKEtBU0FOIHVzZS1hZnRl
ci1mcmVlIGRldGVjdGlvbikuCj4gCj4gPiA+ID4gVGhlIGJ1ZyB3YXMgZml4ZWQgYnkga2VybmVs
IGNvbW1pdCA1ZmUyM2YyNjJlMDUKPiA+ID4gPiAoInVjbWE6IGZpeCBhIHVzZS1hZnRlci1mcmVl
IGluIHVjbWFfcmVzb2x2ZV9pcCgpIikuCj4gCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmVh
IENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4g
PiAgcnVudGVzdC9rZXJuZWxfbWlzYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
MSArCj4gPiA+ID4gIHRlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvTWFrZWZpbGUgICAg
ICAgICAgfCAgIDEgKwo+ID4gPiA+ICB0ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL3Jk
bWEvLmdpdGlnbm9yZSAgIHwgICAxICsKPiA+ID4gPiAgdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2Ut
ZHJpdmVycy9yZG1hL01ha2VmaWxlICAgICB8ICAgNyArCj4gPiA+ID4gIHRlc3RjYXNlcy9rZXJu
ZWwvZGV2aWNlLWRyaXZlcnMvcmRtYS91Y21hX3VhZjAxLmMgfCAyMDggKysrKysrKysrKysrKysr
KysrKysrKwo+ID4gPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDIxOCBpbnNlcnRpb25zKCspCj4gCj4g
PiA8Li4uPgo+IAo+ID4gPiA+ICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gPiA+
ID4gKwkudGVzdF9hbGwgPSBydW4sCj4gPiA+ID4gKwkuc2V0dXAgPSBzZXR1cCwKPiA+ID4gPiAr
CS5jbGVhbnVwID0gY2xlYW51cCwKPiA+ID4gPiArCS5ydW50aW1lID0gMzAwLAo+ID4gPiA+ICsJ
Lm5lZWRzX3Jvb3QgPSAxLAo+ID4gPiA+ICsJLnRhaW50X2NoZWNrID0gVFNUX1RBSU5UX1cgfCBU
U1RfVEFJTlRfRCwKPiA+ID4gPiArCS5uZWVkc19rY29uZmlncyA9IChjb25zdCBjaGFyICpbXSkg
ewo+ID4gPiA+ICsJCSJDT05GSUdfSU5GSU5JQkFORCIsCj4gPiA+ID4gKwkJIkNPTkZJR19JTkZJ
TklCQU5EX1VTRVJfQUNDRVNTIiwKPiAKPiA+IEnigJltIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBM
VFAgdGVzdHMsIGJ1dCBJIHdhbnRlZCB0byBwb2ludCBvdXQgdGhhdCB0aGVzZQo+ID4gY29uZmln
IG9wdGlvbnMgYXJlIGluc3VmZmljaWVudC4gWW91IG5lZWQgYW4gYWN0dWFsIG9yIHZpcnR1YWwg
UkRNQSBkZXZpY2UKPiA+IGNvbm5lY3RlZCB0byByZG1hLWNtIGZvciB0aGUgdGVzdHMgdG8gd29y
ayBjb3JyZWN0bHkuCj4gCj4gTGVvbiwgdGhhbmtzIGZvciBsb29raW5nIGludG8gaXQuIEZZSSB0
aGVzZSBhcmUganVzdCBjb25maWcgb3B0aW9ucyB0byBza2lwCj4ga2VybmVscyB3aXRob3V0IHJl
cXVpcmVkIGtlcm5lbCBtb2R1bGVzLiAKPiAKPiBTbyB1c2luZyAvZGV2L2luZmluaWJhbmQvcmRt
YV9jbSAodmlhIFJETUFfQ01fREVWKSBpcyBub3QgZW5vdWdoLCB3ZSBuZWVkCj4gYW5vdGhlciBk
ZXZpY2U/CgpZZXMsIGByZG1hLWNtYCBwcm92aWRlcyBhbiBpbnRlcmZhY2UgZm9yIGFkZHJlc3Mg
cmVzb2x1dGlvbiBvbgpJQi9pV0FSUC9Sb0NFIG5ldHdvcmtzIHdpdGhvdXQgcmVxdWlyaW5nIGtu
b3dsZWRnZSBvZiB0aGUgdW5kZXJseWluZwpmYWJyaWMgZGV0YWlscy4KCldoZW4gYW4gSUIgZGV2
aWNlIGlzIHJlZ2lzdGVyZWQsIFJETUEvY29yZSBpbnZva2VzIGBjbV9hZGRfb25lKClgLCB3aGlj
aAphdHRhY2hlcyBgcmRtYS1jbWAgdG8gdGhhdCBkZXZpY2UuCmh0dHBzOi8vZWxpeGlyLmJvb3Rs
aW4uY29tL2xpbnV4L3Y3LjAvc291cmNlL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtLmMjTDQz
MzUKClRoYW5rcwoKPiAKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
