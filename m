Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97CCEB64DA
	for <ltp@archiver.kernel.org>; Fri,  7 Jul 2023 13:17:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 175213CC21A
	for <ltp@archiver.kernel.org>; Fri,  7 Jul 2023 15:17:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3F203C6A9B
 for <ltp@lists.linux.it>; Fri,  7 Jul 2023 15:17:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4F7211000A6E
 for <ltp@lists.linux.it>; Fri,  7 Jul 2023 15:17:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1DABD220CC;
 Fri,  7 Jul 2023 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688735859;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0664bTK5nU+Z2lT5OoLONq5sYNl90tdYqK7nwJPgk4=;
 b=jNAG/ujC5erAY6PchsrgtvvTfyK5RvyY5EwEr+wUl2ahBt1caDCBL/yY7Nsu733fChLdYn
 ZEYwuaeVBxX7IOQcYrvFGbVUmC50A5irnedpVK3TwLmoePFI/BXhJeqxBWglsAGONkq2Ya
 SghOddR5N9QHLR8WiwICGrVWxMn+Qr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688735859;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0664bTK5nU+Z2lT5OoLONq5sYNl90tdYqK7nwJPgk4=;
 b=2zAFx50HbvX4nuX8b4f8E4e2CCNvnwSVP8CToqnMJZ9/P9VXyZem75PDASyRBK/EFspWA3
 3hLJkLB31JTYRKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 067551346D;
 Fri,  7 Jul 2023 13:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eQ1/AHMQqGTuUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jul 2023 13:17:39 +0000
Date: Fri, 7 Jul 2023 15:17:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alexander Aring <aahringo@redhat.com>
Message-ID: <20230707131737.GA596010@pevik>
References: <20230530203707.2965684-1-aahringo@redhat.com>
 <20230530203707.2965684-2-aahringo@redhat.com>
 <20230621090331.GA365741@pevik>
 <CAK-6q+jVapf==Sg_BqWr0KTGA+uKgaaSZQwO=5tWzve9=Dok2Q@mail.gmail.com>
 <20230702191813.GB360317@pevik>
 <CAK-6q+hsZxurnnd2snKr12R5UwieCnWhvgr5_OoDKAXorHNhTA@mail.gmail.com>
 <20230707081404.GA571797@pevik>
 <CAK-6q+joXWdS5nP6A4dXThSAA99wPuZW0jVzGirZMDoUqzGPSA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK-6q+joXWdS5nP6A4dXThSAA99wPuZW0jVzGirZMDoUqzGPSA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fcntl40: test for owner values on classic
 posix lock
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSwKCj4gT24gRnJpLCBKdWwgNywgMjAyMyBhdCA0OjE04oCvQU0gUGV0ciBWb3JlbCA8cHZv
cmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+ID4gSGksCgo+ID4gPiBPbiBTdW4sIEp1bCAyLCAyMDIz
IGF0IDM6MTjigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gPiA+
IEhpIEFsZXgsCgo+ID4gPiA+IC4uLgo+ID4gPiA+ID4gPiA+ICsgKiBbRGVzY3JpcHRpb25dCj4g
PiA+ID4gPiA+ID4gKyAqIFRlc3RzIGdmczIgZGxtIHBvc2l4IG9wIHF1ZXVlIGhhbmRsaW5nIGlu
IHRoZSBrZXJuZWwuCj4gPiA+ID4gPiA+ID4gKyAqIEl0IGlzIHJlY29tbWVuZGVkIHRvIHJ1biB3
YXRjaCAtbiAwLjEgImRsbV90b29sIHBsb2NrcyAkTFMiCj4gPiA+ID4gPiA+ID4gKyAqIGFzaWRl
IHRvIG1vbml0b3IgZGxtIHBsb2NrIGhhbmRsaW5nLgo+ID4gPiA+ID4gPiA+ICsgKgo+ID4gPiA+
ID4gPiA+ICsgKiBbSG93IHRvIHVzZSBpdF0KPiA+ID4gPiA+ID4gPiArICogQ2FsbCBpdCB3aXRo
IFRNUERJUj0vbW50IC4vZmNudGw0MCB3aGVyZSBUTVBESVIgaXMgYSBnZnMyIG1vdW50cG9pbnQu
Cj4gPiA+ID4gPiA+IEkgd29uZGVyIGlmIHdlIGNvdWxkIGNoZWNrIGZvciBHRlMyX01BR0lDICh3
ZSdkIG5lZWQgdG8gYWRkIGl0IHRvCj4gPiA+ID4gPiA+IGluY2x1ZGUvdHN0X2ZzLmggPT4gMHgw
MTE2MTk3MCkgYW5kIHF1aXQgdGhlIHRlc3Qgd2l0aCB0c3RfYnJrKFRDT05GKSBpZiBUTVBESVIK
PiA+ID4gPiA+ID4gaXMgbm90IG9uIGdmczIuCgo+ID4gPiA+ID4gPiBBVE0gd2UgZG9uJ3QgaGF2
ZSBhbnkgaGVscGVyIGluIHN0cnVjdCB0c3RfdGVzdCwgd2hpY2ggd291bGQgZG8gaXQuCgoKPiA+
ID4gPiA+IEkgd2lsbCBtZW50aW9uIHRoYXQgZ2ZzMiBpcyBvbmx5IGFuIGV4YW1wbGUgaGVyZS4g
SXQgYmVjb21lcwo+ID4gPiA+ID4gaW50ZXJlc3Rpbmcgd2hlbiBhIGZpbGUgc3lzdGVtIGltcGxl
bWVudHMgaXRzIG93biAubG9jaygpIGNhbGxiYWNrIE9SCj4gPiA+ID4gPiBpZiBzb21lYm9keSB3
YW50cyB0byB0ZXN0IGZpbGUgc3lzdGVtIGNvcmUsIHdoZW4gYSBmaWxlc3lzdGVtIGRvZXMgbm90
Cj4gPiA+ID4gPiBpbXBsZW1lbnQgaXRzIG93biAubG9jaygpLgoKPiA+ID4gPiBJIHNlZSAubG9j
ayBpcyBpbXBsZW1lbnRlZCBpbiA5cCwgYWZzLCBjZXBoLCBjaWZzLCBvY2ZzMiwgb3JhbmdlZnMs
IGV2ZW4gTkZTLgo+ID4gPiA+ICJmaWxlIHN5c3RlbSBjb3JlIjogZG8geW91IG1lYW4gVkZTPyBC
ZWNhdXNlIHRoYXQgd291bGQgYmUgbW9yZSB1c2FibGUgdGhhbiB0aGUKPiA+ID4gPiBmaWxlc3lz
dGVtcyBhYm92ZSAod2hpY2ggYXJlIHF1aXRlIGV4b3RpYykuCgoKPiA+ID4gSXQgZGVwZW5kcyBo
ZXJlIHdoYXQgdGhleSBhcmUgZG9pbmcgaW4gLmxvY2soKSAtIElmIHRoZXkganVzdCBjYWxsCj4g
PiA+IGxvY2tzX2xvY2tfZmlsZV93YWl0KCkgb3Igc2ltaWxhciBoZWxwZXJzIGRlcGVuZGluZyBv
biB0aGUgY2FsbCwgdGhlbgo+ID4gPiB0aGV5IGRvbid0IGRvIG11Y2ggZGlmZmVyZW50IHRoYW4g
d2hhdCB2ZnMgaXMgZG9pbmcuCj4gPiA+IEluIGNhc2Ugb2YgZ2ZzMi9vY2ZzIGl0IGlzIHZlcnkg
c3BlY2lhbCwgaXQgcmVkaXJlY3RzIHRoZWlyIGNhbGxzIHRvCj4gPiA+IERMTSBhbmQgRExNIGhh
cyBpdHMgb3duIHdob2xlIHBvc2l4IGltcGxlbWVudGF0aW9uIGJlaGluZCBpdC4gV2Ugb25seQo+
ID4gPiBjYWxsIGxvY2tzX2xvY2tfZmlsZV93YWl0KCkgdG8ga2VlcCB0aGUgTGludXggYm9va2tl
ZXBpbmcgaW4KPiA+ID4gL3Byb2MvbG9ja3MuCgo+ID4gPiBXaGF0IEkgYW0gZG9pbmcgaGVyZSBp
cyBtb3N0bHkgdHJ1c3RpbmcgdGhlIExpbnV4IGltcGxlbWVudGF0aW9uIGFuZAo+ID4gPiBjb21w
YXJpbmcgcmVzdWx0cyBmcm9tIGUuZy4gdG1wZnMgd2l0aCBHRlMyIGFuZCBJIGZvdW5kIGlzc3Vl
cy4KCj4gPiA+IEZvciBub3cgSSB0cnVzdCB0aGUgTGludXggaW1wbGVtZW50YXRpb24gYW5kIGNo
ZWNrIGlmIHdlIGhhdmUgYQo+ID4gPiBkaWZmZXJlbnQgcmVzdWx0IGhlcmUuIEkgbmVlZCB0byBi
ZSB2ZXJ5IGNhcmVmdWwgaGVyZSBiZWNhdXNlCj4gPiA+IEdGUzIvT0NGUzIgYXJlIGNsdXN0ZXIg
ZmlsZXN5c3RlbXMgYW5kIHRoZSBmY250bCgpIGludGVyZmFjZSB3YXMgbmV2ZXIKPiA+ID4gbWFk
ZSBmb3IgY2x1c3RlciBmaWxlc3lzdGVtcy4gSG93ZXZlciBJIGN1cnJlbnRseSBvbmx5IHRlc3Qg
Im9uZSBub2RlIgo+ID4gPiBsb2NraW5nIGFuZCB0aGlzIHNob3VsZCBkZWxpdmVyIHRoZSBzYW1l
IHJlc3VsdHMgYXMgdG1wZnMsIGV0Yy4KCj4gPiBUaGFua3MgZm9yIGluZm8uICBJJ20gc3RpbGwg
bm90IHN1cmUgaWYgdGhpcyBpcyB1c2VmdWwgb25seSBmb3IgZ2ZzMi9vY2ZzCj4gPiBhbmQgd2Ug
c2hvdWxkIHByZXBhcmUgYmxvY2sgZGV2aWNlIHdpdGggZ2ZzMiBvciBvY2ZzIGFuZCB0ZXN0IGZp
bGVzeXN0ZW0gb24gaXQuCj4gPiBPciBpZiBpdCB3b3VsZCBiZSB1c2VmdWwgdG8gdGVzdCBvdGhl
ciBmaWxlc3lzdGVtIGltcGxlbWVudGF0aW9uLiBJbiB0aGlzIGxhdHRlcgo+ID4gY2FzZSB3ZSB1
c3VhbGx5IHVzZSAuYWxsX2ZpbGVzeXN0ZW1zICh3ZSBkb24ndCBoYXZlIHByb3BlciBkb2NzIGZv
cgo+ID4gLmFsbF9maWxlc3lzdGVtcywgdGhlIGNsb3Nlc3QgaXMgWzFdKSBhbmQgdGVzdCBpcyB0
aGVuIHJ1biBvbiB2YXJpb3VzIGNvbW1vbgo+ID4gZmlsZXN5c3RlbXMgKHNlZSBmc190eXBlX3do
aXRlbGlzdFtdIGluIGxpYi90c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmMpLCBidXQgaW4KPiA+IHRo
YXQgY2FzZSBnZnMyIHdvdWxkIGJlIHNraXBwZWQgKGl0J3Mgbm90IGEgY29tbW9uIGZpbGVzeXN0
ZW0pLgoKPiA+IEluIGNhc2UgcHJlcGFyaW5nIGJsb2NrIGRldmljZSB3aXRoIGdmczIgc29tZXRo
aW5nIGxpa2UgdGhpcyBtaWdodCB3b3JrOgoKPiA+IHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVz
dCA9IHsKPiA+ICAgICAgICAgLi4uCj4gPiAgICAgICAgIC5kZXZfZnNfdHlwZSA9ICJnZnMyIiwK
PiA+ICAgICAgICAgLmZvcm1hdF9kZXZpY2UgPSAxLAo+ID4gICAgICAgICAuZGV2X2ZzX29wdHMg
PSAoY29uc3QgY2hhciAqY29uc3QgW10peyAiLXQiLCAibXljbHVzdGVyOm15Z2ZzMiIsICItcCIs
ICJsb2NrX2RsbSIsICItaiIgLCAiMiIgLCBOVUxMfSwKCgo+IENhbiBJIG92ZXJyaWRlIHRoaXMg
c2V0dGluZyBieSBzb21lIEVOViBiZWNhdXNlIEkgYWN0dWFsbHkgd2FudCB0byBydW4KPiBpdCBv
biBhIGRpZmZlcmVudCBmaWxlc3lzdGVtIHdoaWNoIGlzIHVzaW5nIFZGUyBwb3NpeCBsb2NrCj4g
aW1wbGVtZW50YXRpb24sIGJlY2F1c2UgYXMgSSBzYWlkIEkgd2FudCB0byBjb21wYXJlIHRoZSBy
ZXN1bHRzLgoKU3VyZSwgdGhlcmUgaXMgTFRQX0RFVl9GU19UWVBFLiBCdXQgdGhlIHBvaW50IGlz
IHRvIHdyaXRlIHRlc3Qgd2hpY2ggd2lsbCBiZQp1c2VmdWwgZm9yIHRoZSBkZWZhdWx0IHNjZW5h
cmlvLgoKS2luZCByZWdhcmRzLApQZXRyCgo+IC0gQWxleAoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
