Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1851CE7A94
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 12:50:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 301DA3CDCEA
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 14:50:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C584E3CBDB4
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 14:50:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2B59F1000DD7
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 14:50:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 70F211F459;
 Mon, 25 Sep 2023 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695646239;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mX9l8/ilnwkV+NLNWh2Gmcnjbx8nFi8VQrX8aPIu1LQ=;
 b=n2hQOKVSiA3rjviKc4ubKnumT7xgNzhTcxxWA8h+vGdL6paq/Tqp2j4JkIHUXQkW3p3SMC
 RYfZhdgWO1q0e9LmwdpDQzDNJwYVRw6ICxKiHk2t5CNfEbWJ4QJXqZbf0jhCSVgV5hnf4J
 DUpGYsaEP0F5ZiK1jz6I8d6Vxx26siA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695646239;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mX9l8/ilnwkV+NLNWh2Gmcnjbx8nFi8VQrX8aPIu1LQ=;
 b=hO4VVu7WYP5ZN/Yn31QOFlpATtPnPiKIn7LKE0eQbC2rqAsnwrE8N24ti7NW76rd0kw5fb
 v63PIK17JVlwDADQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CC6313580;
 Mon, 25 Sep 2023 12:50:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qqCcDR+CEWVJeQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Sep 2023 12:50:39 +0000
Date: Mon, 25 Sep 2023 14:50:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230925125037.GA60471@pevik>
References: <20230920095318.340582-1-pvorel@suse.cz>
 <20230920095318.340582-6-pvorel@suse.cz>
 <CAEemH2ektE-0Fdu49_4xN5wtq9=jPehHXDVrAPSG3FZ763rTDw@mail.gmail.com>
 <20230924211413.GA688740@pevik>
 <CAEemH2du9Or2y84qF8uHWAO8_+jLfvV+1b6iwBkBdd4abUiZ3A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2du9Or2y84qF8uHWAO8_+jLfvV+1b6iwBkBdd4abUiZ3A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] doc: Update release procedure
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBNb24sIFNlcCAyNSwgMjAyMyBhdCA1OjE04oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIExpLAoKPiA+ID4gSGkgUGV0ciwKCj4gPiAuLi4KPiA+ID4g
PiAtMS4gVGFnIHRoZSBnaXQKPiA+ID4gPiArMS4gUmVsZWFzZSBldmUgd29yawo+ID4gPiA+ICst
LS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+ID4gKwo+ID4gPiA+ICthLiBDb2xsZWN0aW5nIHRoZSAo
bXVzdCBoYXZlKSBwYXRjaCBsaXN0IGZvciBuZXcgcmVsZWFzZQo+ID4gPiA+ICtiLiBSZXZpZXdp
bmcgYW5kIG1lcmdpbmcgdGhlIHBhdGNoIGxpc3Qgb2YgKGEuKQo+ID4gPiA+ICtjLiBXaWRlbHkg
dGVzdGluZywgZXhwbGljaXRseSBwb3N0IHJlc3VsdHMKPiA+ID4gPiArZC4gVGlueSBmaXggYWNj
b3JkaW5nIHRvIHJlbGVhc2UgdGVzdGluZwo+ID4gPiA+ICtlLiBXcml0aW5nIHJlbGVhc2Ugbm90
ZQo+ID4gPiA+ICsKPiA+ID4gPiArMi4gVGFnIHRoZSBnaXQKPiA+ID4gPiAgLS0tLS0tLS0tLS0t
LS0KCj4gPiA+ID4gK1VzZSAnLi90b29scy90YWctcmVsZWFzZS5zaCcgc2NyaXB0LCB3aGljaCBj
cmVhdGVzIHRoZSB0YWcgYW5kIHB1c2gKPiA+IGl0IHRvCj4gPiA+ID4gZ2l0aHViLgo+ID4gPiA+
ICBbc291cmNlLHNoXQo+ID4gPiA+ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gPiA+IC1jZCBsdHAKPiA+ID4g
PiAtZWNobyBZWVlZTU1ERCA+IFZFUlNJT04KPiA+ID4gPiAtZ2l0IGNvbW1pdCAtcyAtbSAnTFRQ
IFlZWVlNTUREJyBWRVJTSU9OCj4gPiA+ID4gLWdpdCB0YWcgLWEgWVlZWU1NREQgLW0gJ0xUUCBZ
WVlZTU1ERCcKPiA+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCj4gPiA+IFdoYXQgYWJvdXQgYWRkaW5nIHRo
b3NlIG1hbnVhbCBzdGVwcyBpbnRvIHRhZy1yZWxlYXNlLnNoIGFzIGNvZGUKPiA+IGNvbW1lbnRz
Pwo+ID4gPiBUaGF0J2QgYmUgaGVscGZ1bCB0byBwZW9wbGUgd2hvIG5ldmVyIGRvIHJlbGVhc2Ug
d29yayB0byB0cnkgdGhhdCBmaXJzdAo+ID4gPiB0aW1lLgoKPiA+IEdvb2QgcG9pbnQsIG1ha2Vz
IHNlbnNlLgo+ID4gSSBzdXBwb3NlIHlvdSBtZWFuIHRvIGJwdXQgdGhlbSBhdCB0aGUgdG9wIGxp
a2UgdGhpczoKCgoKPiBZZXMsIGV2ZW4gbG9va3MgdmVyYm9zZSwgYnV0IHdpbGwgYmUgaGVscGZ1
bCB0byBwZW9wbGUgd2hvIG5ldmVyIGRvIHJlbGVhc2UKPiB3b3JrLgoKClN1cmUsIG5vIHByb2Js
ZW0uIEkgcHV0IGFsbCBjb21tYW5kcy4KCktpbmQgcmVnYXJkcywKUGV0cgoKCj4gPiAjIS9iaW4v
c2gKPiA+ICMgQ29weXJpZ2h0IChjKSAyMDIzIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+
ID4gIyBDcmVhdGUgdGFyYmFsbHMgYW5kIG1ldGFkYXRhIGZvciB1cGxvYWRpbmcgYWZ0ZXIgdGFn
Z2luZyByZWxlYXNlLgo+ID4gIyBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0
L2x0cC93aWtpL0xUUC1SZWxlYXNlLVByb2NlZHVyZQo+ID4gIyBlY2hvIFlZWVlNTUREID4gVkVS
U0lPTgo+ID4gIyBnaXQgY29tbWl0IC1zIC1tICdMVFAgWVlZWU1NREQnIFZFUlNJT04KPiA+ICMg
Z2l0IHRhZyAtYSBZWVlZTU1ERCAtbSAnTFRQIFlZWVlNTUREJwo+ID4gc2V0IC1lCj4gPiAuLi4K
PiA+IEJlY2F1c2UgdGhlcmUgYXJlIGNvbW1lbnRzIGF0IHRoZSB0b3Agb2YgZWFjaCAic2VjdGlv
biIgKGUuZy4gIyBnaXQgY2xvbmUKPiA+IChsb2NhbCkpCgo+ID4gLi4uCj4gPiA+ID4gLWNkIC4u
Cj4gPiA+ID4gLWdpdCBjbG9uZSBsdHAgbHRwLWZ1bGwtWVlZWU1NREQKPiA+ID4gPiAtY2QgbHRw
LWZ1bGwtWVlZWU1NREQKPiA+ID4gPiAtIyBVcGRhdGUgbWNlLWluamVjdCBzdWJtb2R1bGUKPiA+
ID4gPiAtZ2l0IHN1Ym1vZHVsZSBpbml0Cj4gPiA+ID4gLWdpdCBzdWJtb2R1bGUgdXBkYXRlCj4g
PiA+ID4gLSMgR2VuZXJhdGUgY29uZmlndXJlIHNjcmlwdAo+ID4gPiA+IC1tYWtlIGF1dG90b29s
cwo+ID4gPiA+IC0jIFByZXBhcmUgdGhlIGFyY2hpdmVzCj4gPiA+ID4gLWNkIC4uCj4gPiA+ID4g
LXRhciAtY2pmIGx0cC1mdWxsLVlZWVlNTURELnRhci5iejIgbHRwLWZ1bGwtWVlZWU1NREQgLS1l
eGNsdWRlIC5naXQKPiA+ID4gPiAtdGFyIC1jSmYgbHRwLWZ1bGwtWVlZWU1NREQudGFyLnh6IGx0
cC1mdWxsLVlZWVlNTUREIC0tZXhjbHVkZSAuZ2l0Cgo+ID4gPiBJIHN1Z2dlc3QgYWRkaW5nIHRo
ZXNlIGludG8gY3JlYXRlLXRhcmJhbGxzLW1ldGFkYXRhLnNoIGNvbW1lbnRzIGFzIHdlbGwuCgo+
ID4gIyBnaXQgY2xvbmUgbHRwIGx0cC1mdWxsLVlZWVlNTUREICYmIGNkIC0KPiA+ICMgZ2l0IHN1
Ym1vZHVsZSB1cGRhdGUgLS1pbml0Cj4gPiAjIG1ha2UgYXV0b3Rvb2xzCj4gPiAjIGNkIC4uCj4g
PiAjIHRhciAtY2pmIGx0cC1mdWxsLVlZWVlNTURELnRhci5iejIgbHRwLWZ1bGwtWVlZWU1NREQg
LS1leGNsdWRlIC5naXQKPiA+ICMgdGFyIC1jSmYgbHRwLWZ1bGwtWVlZWU1NREQudGFyLnh6IGx0
cC1mdWxsLVlZWVlNTUREIC0tZXhjbHVkZSAuZ2l0Cj4gPiAjIHNoYTI1NnN1bSBsdHAtZnVsbC1Z
WVlZTU1ERC50YXIueHogPiBsdHAtZnVsbC1ZWVlZTU1ERC50YXIueHouc2hhMjU2Cgo+ID4gKEFk
ZGluZyBhbGwgY2hlY2tzdW1zIHdvdWxkIGxvb2sgdG8gbWUgcXVpdGUgdmVyYm9zZSAoNiBsaW5l
cyksIGJ1dCBJIGNhbgo+ID4gYWRkCj4gPiB0aGVtLikKCj4gPiBLaW5kIHJlZ2FyZHMsCj4gPiBQ
ZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
