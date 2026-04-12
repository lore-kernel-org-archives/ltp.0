Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20466F34C58
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776090867; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=T5xDgS2+9S6c1JVUSocab/uTKQnrzHHMu3ghzqNHqc4=;
 b=UCvKyI6RwAlJhhH54YEHC+0CnQ7DnsqR3eLyUZCrfm8eXpqlQhgQg33Agupju/f9afVRK
 8dRq3iQQrn7CXCAJb7BOxiwcmNdgh9pbimZwOt7yEzWq8s+yzFywALBe5m0A1Bq29cl0ext
 FcxL0RHayZVpyxjJrWr7pJrdS7m1Epo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D370F3E2F04
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 16:34:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94DBE3D024C
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 16:14:48 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D045D1000186
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 16:14:47 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 407884360D;
 Sun, 12 Apr 2026 14:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53E4C19424;
 Sun, 12 Apr 2026 14:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776003285;
 bh=Xe13EkcrIIFL3m0G8drldzooM0xthoen4TETUIqWIlI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NsH4CD7wOXM9MhKdouVA2zUzSluH8llhxPoR+21cU0/1BDO43j7rlFeq+QPiC0dPd
 OEMKBuJ8RAN3y0uyNsMn+/OmFY39gNd0/gTnwiQjeU5AVpNBVUCreDdPWhDJ8CatcN
 ZaZUrKFVPJ+hGegxTl0EEWnlkp3mItur6jByUZaIgXkSTM5ioA9jvwAyZaM7SGTyTw
 6khsUfOKFhOmHvU8BQ16vdhTSYDWUIEQwoDYLR5kwxuqjwGqMLXILzRSneGJWtaIfd
 g83+3uCQDdsp1xAbsjkaQNLUrk5+lg7dzQLSdKUq54VU50CSrIGnAtBBmuo3RPJ9Y7
 RT8npAS5HzwWw==
Date: Sun, 12 Apr 2026 17:14:39 +0300
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20260412141439.GD21470@unreal>
References: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
 <20260325-infiniband_rdma-v1-2-9c1bd3e69d29@suse.com>
 <20260407132426.GC25645@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260407132426.GC25645@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 13 Apr 2026 16:34:04 +0200
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

T24gVHVlLCBBcHIgMDcsIDIwMjYgYXQgMDM6MjQ6MjZQTSArMDIwMCwgUGV0ciBWb3JlbCB3cm90
ZToKPiBIaSBBbmRyZWEsCj4gCj4gaXQncyBiZWVuIGxvbmcgdGltZSBzaW5jZSB0aGlzIHVzZS1h
ZnRlci1mcmVlIHdhcyBmaXhlZCwgYnV0IElNSE8gc3RpbGwgdXNlZnVsCj4gdG8gaGF2ZSBhIHRl
c3QgKGl0J3MgYWxzbyBraW5kIG9mIHNtb2tlIHRlc3QgZm9yIHJkbWFfY20pLgo+IEFueXdheSwg
TEdUTSwgYnV0IGl0J2QgYmUgbmljZSB0byByZXByb2R1Y2UgdGhlIGJ1Zy4KPiAKPiBSZXZpZXdl
ZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gCj4gPiBUZXN0IGZvciB1c2UtYWZ0
ZXItZnJlZSBpbiBSRE1BIFVDTUEgdHJpZ2dlcmVkIGJ5IHJhY2luZyBDUkVBVEVfSUQsCj4gPiBC
SU5EX0lQLCBhbmQgTElTVEVOIG9wZXJhdGlvbnMuIFRocmVlIHRocmVhZHMgY29uY3VycmVudGx5
IGlzc3VlCj4gPiB0aGVzZSBjb21tYW5kcyB0byAvZGV2L2luZmluaWJhbmQvcmRtYV9jbSBhbmQg
dGhlIHRlc3QgY2hlY2tzIGZvcgo+ID4ga2VybmVsIHRhaW50IChLQVNBTiB1c2UtYWZ0ZXItZnJl
ZSBkZXRlY3Rpb24pLgo+IAo+ID4gVGhlIGJ1ZyB3YXMgZml4ZWQgYnkga2VybmVsIGNvbW1pdCA1
ZmUyM2YyNjJlMDUKPiA+ICgidWNtYTogZml4IGEgdXNlLWFmdGVyLWZyZWUgaW4gdWNtYV9yZXNv
bHZlX2lwKCkiKS4KPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4gPiAtLS0KPiA+ICBydW50ZXN0L2tlcm5lbF9taXNjICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKPiA+ICB0ZXN0Y2FzZXMva2VybmVs
L2RldmljZS1kcml2ZXJzL01ha2VmaWxlICAgICAgICAgIHwgICAxICsKPiA+ICB0ZXN0Y2FzZXMv
a2VybmVsL2RldmljZS1kcml2ZXJzL3JkbWEvLmdpdGlnbm9yZSAgIHwgICAxICsKPiA+ICB0ZXN0
Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL3JkbWEvTWFrZWZpbGUgICAgIHwgICA3ICsKPiA+
ICB0ZXN0Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL3JkbWEvdWNtYV91YWYwMS5jIHwgMjA4
ICsrKysrKysrKysrKysrKysrKysrKysKPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDIxOCBpbnNlcnRp
b25zKCspCgo8Li4uPgoKPiA+ICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gPiAr
CS50ZXN0X2FsbCA9IHJ1biwKPiA+ICsJLnNldHVwID0gc2V0dXAsCj4gPiArCS5jbGVhbnVwID0g
Y2xlYW51cCwKPiA+ICsJLnJ1bnRpbWUgPSAzMDAsCj4gPiArCS5uZWVkc19yb290ID0gMSwKPiA+
ICsJLnRhaW50X2NoZWNrID0gVFNUX1RBSU5UX1cgfCBUU1RfVEFJTlRfRCwKPiA+ICsJLm5lZWRz
X2tjb25maWdzID0gKGNvbnN0IGNoYXIgKltdKSB7Cj4gPiArCQkiQ09ORklHX0lORklOSUJBTkQi
LAo+ID4gKwkJIkNPTkZJR19JTkZJTklCQU5EX1VTRVJfQUNDRVNTIiwKCknigJltIG5vdCBmYW1p
bGlhciB3aXRoIHRoZSBMVFAgdGVzdHMsIGJ1dCBJIHdhbnRlZCB0byBwb2ludCBvdXQgdGhhdCB0
aGVzZQpjb25maWcgb3B0aW9ucyBhcmUgaW5zdWZmaWNpZW50LiBZb3UgbmVlZCBhbiBhY3R1YWwg
b3IgdmlydHVhbCBSRE1BIGRldmljZQpjb25uZWN0ZWQgdG8gcmRtYS1jbSBmb3IgdGhlIHRlc3Rz
IHRvIHdvcmsgY29ycmVjdGx5LgoKVGhhbmtzCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
