Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEE6C4332F
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 10:40:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81B953CE864
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 11:40:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A79053CC728
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 11:40:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 073521A00153
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 11:40:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 333D921855;
 Mon,  6 Nov 2023 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699267225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axaQs9RPxG23+OlfTAT04tPZsW0DMGDPereyk8rA6Vs=;
 b=yyck84Ci7ndDt2xinp5l5cgIbhuIrBPA3CurBHXZCuPL2bNkrsEzZYGdkH10FhF0arzJlv
 kjVpmKoA+ge/MdC6FWZLve6YB4FVPmLx4kDomtXG9oyKC3tZzCMDZ7oZ1Uq+ae3CO77Wpf
 vhqiKmBE6viOOTxX+TKzJIC9q2RL0tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699267225;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axaQs9RPxG23+OlfTAT04tPZsW0DMGDPereyk8rA6Vs=;
 b=6zRYOmP4JBTwS5+cs79HrSDTV5MbtrBYP+QTBo73uktUv7RskrJbaSJpPiVfG541LOjQvG
 Yk486Q6GtS+zBMDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02A8C138E5;
 Mon,  6 Nov 2023 10:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZpDQOpjCSGXvGQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Nov 2023 10:40:24 +0000
Date: Mon, 6 Nov 2023 11:40:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231106104023.GA1236692@pevik>
References: <20231102072030.1800796-1-liwang@redhat.com>
 <20231102092135.GA921952@pevik>
 <CAEemH2fWDQgPv+9TR9nb4rw5CsJx3uGKS+Yvb3YqgNEOUSVYmg@mail.gmail.com>
 <20231103091439.GA1026385@pevik>
 <CAEemH2ewUHBC17LL+4OXd8AZqciGrRqo4Ty+Hik2KcXP+t4fNA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ewUHBC17LL+4OXd8AZqciGrRqo4Ty+Hik2KcXP+t4fNA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: add centos stream support
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
Cc: Chao Ye <cye@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBQZXRyLAoKPiBPbiBGcmksIE5vdiAzLCAyMDIzIGF0IDU6MTTigK9QTSBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gPiBIaSBQZXRyLAoKPiA+ID4gT24gVGh1LCBO
b3YgMiwgMjAyMyBhdCA1OjIx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3Rl
OgoKPiA+ID4gPiBIaSBMaSwKCj4gPiA+ID4gPiBUaGlzIGlzIGJhc2Ugb24gUGV0ZXIncyBwYXRj
aDoKPiA+ID4gPiA+ICAgQ0k6IFJlQXBsYWNlIENlbnRPUyA3IHdpdGggb3BlblNVU0UgTGVhcCA0
Mi4yLCBVYnVudHUgeGVuaWFsCgo+ID4gPiA+ID4gQ2k6IGh0dHBzOi8vZ2l0aHViLmNvbS93YW5n
bGk1NjY1L2x0cC9hY3Rpb25zL3J1bnMvNjcyOTM3OTU2NQoKPiA+ID4gPiBSZXZpZXdlZC1ieTog
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgoKPiA+ID4gVGhhbmtzIQoKCj4gPiA+ID4gQVRN
IHdlIGhhdmUgMTggam9icywgSU1ITyB3ZSBzaG91bGQgbm90IGFkZCBtb3JlIHdpdGhvdXQgcmVt
b3ZpbmcKPiA+IG90aGVycwo+ID4gPiA+IGp1c3QgdG8KPiA+ID4gPiBoYXZlIHJlYXNvbmFibGUg
Q0kgcnVudGltZS4KCgo+ID4gPiBZb3VyIGNvbmNlcm4gbWFrZXMgc2Vuc2UsIGJ1dCBJIGhhdmUg
bm8gaWRlYSB3aGljaCBvbmUgY291bGQgYmUgcmVtb3ZlZC4KCj4gPiBJIHdvbmRlciBpZiBqdXN0
IGFkZGluZyBDZW50T1MgOSB3b3VsZCBiZSBlbm91Z2guIEJlY2F1c2UgaW4gQ0kgd2UgdGVzdAo+
ID4ganVzdAo+ID4gY29tcGlsYXRpb24uIFRoZSBwb2ludCBvZiB0aGUgcHVibGljIENJIGlzIHRv
IHRlc3QgdGhlIG9sZGVzdCBkaXN0cm9zLAo+ID4gbmV3ZXN0Cj4gPiBkaXN0cm9zIGFuZCBzb21l
dGhpbmcgaW4gYmV0d2VlbiwgdGhhdCBzaG91bGQgY292ZXIgdGhlIG1vc3Qgb2YgY29tcGlsYXRp
b24KPiA+IHByb2JsZW1zIChubyBuZWVkIHRvIHRlc3QgKmFsbCogdXNlZCBkaXN0cm9zIHRvIGJl
IHNhZmUpLgo+ID4gQnV0IHN1cmUsIGJvdGggY2FuIHN0YXkgaWYgeW91IHdhbnQuIFRoZSBydW50
aW1lIGlzIHN0aWxsIHJlYXNvbmFibGUuCj4gPiBOT1RFOiBJIGRpZCBub3QgY2FyZSBtdWNoIGlu
IGNhc2Ugb2YgaXB1dGlscywgd2hpY2ggaGF2ZSBtdWNoIGZhc3RlciBidWlsZAo+ID4gdGhhbgo+
ID4gTFRQLgoKPiA+IElmIHdlIHdhbnQgdG8gYWRkIGJvdGggQ2VudE9TIDggYW5kIDksIHdlIGNv
dWxkIHJlbW92ZSBzb21lIG9mCj4gPiBkZWJpYW46b2xkc3RhYmxlIChidWxsc2V5ZSkKPiA+IChz
aW1pbGFyIGtlcm5lbCkuCgo+ID4gQW5kLCB3ZSBjb3VsZCBhZGQganVzdCBvcGVuU1VTRSBMZWFw
IDQyLjIsIHdoaWNoIGhhcyBvbGRlciBnbGliYyBhbmQgZ2NjCj4gPiB0aGFuCj4gPiBVYnVudHUg
MTYuMDQgTFRTIHhlbmlhbC4gRm9yIHN1cmUgdGhlcmUgYXJlIG1vcmUgcGVvcGxlIHdoaWNoIHVz
ZSB4ZW5pYWwKPiA+IHRoYW4KPiA+IG9sZCBMZWFwIDQyLjIsIGJ1dCBhcyBJIHNhaWQsIHRoZSBn
b2FsIGlzIHRvIHRlc3QgdGhlIG9sZGVzdCBkaXN0cm8gd2UKPiA+IG1haW50YWluZXJzIHJlYWxs
eSBjYXJlIGFib3V0IChhbmQgZG8gbm90IGhhdmUgZXh0cmEgd29yayBmb3Igbm90aGluZywKPiA+
IHdoaWNoIGlzCj4gPiBJTUhPIGtlZXBpbmcgQ2VudE9TIDcgY29tcGlsYWJsZSkuCgo+ID4gV0RZ
VD8KCgo+IFlvdXIgZXhwbGFuYXRpb24gaXMgcXVpdGUgdXNlZnVsLCB0aGFua3MhCgo+IEknbSBm
aW5lIHRvIHJlbW92ZSB0aGUgQ2VudE9TOCBidWlsZCBpbiB0aGlzIHBhdGNoLAo+IHNob3VsZCBJ
IHJlc2VudCB0aGUgbmV3IHBhdGNoIG9yIHB1c2ggaXQgZGlyZWN0bHk/CgpZb3UgY2FuIHB1c2gg
aXQgZGlyZWN0bHkuIElmIGl0IGRvZXMgbm90IGFwcGx5LCBmZWVsIGZyZWUgdG8gcHVzaCBteSBj
aGFuZ2UKZmlyc3QuIEknbGwgcG9zdCBhIG5vdGUgYWJvdXQga2VlcGluZyBvbmx5IG9wZW5TVVNF
IExlYXAgNDIuMiBpbiB0aGUgcGF0Y2hzZXQuCgpBY2tlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+CgpLaW5kIHJlZ2FyZHMsClBldHIKCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
