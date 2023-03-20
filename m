Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC252C76195
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 14:37:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 364AF3CD34C
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 15:37:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 963ED3C1014
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 15:37:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 89FC0100065B
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 15:37:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4FB1F1F86C;
 Mon, 20 Mar 2023 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679323059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0yl/gVrDiy9Jl7UcXkvf4BXikkx/kvwyMhGrhfZ3W8=;
 b=fWi9R64iDdNTfR7VjI9GzuWMX7MAQbAdsejfy7wCiUA27aesVK222bQDAizqJPZO1hHwC9
 ssJuG+3VTlAYfSotNZCsEjIRrv+a1PhNbc+EaJvTpYfM2ZMB8YgDI38eIsnWY4BmGpFrN3
 7CBPekcpdkix5Gmj3MKUVE3R3w3jpbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679323059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0yl/gVrDiy9Jl7UcXkvf4BXikkx/kvwyMhGrhfZ3W8=;
 b=Dy+fZCbdnI94rkRXddGN2z1EvJo1SSNZwCrqz7KFpbxEGjiliRaaHWrsGrk9Y1cH0YbNJ4
 w7a9A5+QDNnnu7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1482513A00;
 Mon, 20 Mar 2023 14:37:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pjyCA7NvGGQOKQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Mar 2023 14:37:39 +0000
Date: Mon, 20 Mar 2023 15:37:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230320143737.GA215496@pevik>
References: <20230314114037.25581-1-rpalethorpe@suse.com>
 <20230314175438.GB79562@pevik> <20230320080415.GA179863@pevik>
 <20230320082336.GA182681@pevik>
 <CAEemH2dHeOweGRaeQAx9DuE936=DMycqJNt_ymJ9GqSZ2ES8PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dHeOweGRaeQAx9DuE936=DMycqJNt_ymJ9GqSZ2ES8PQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add goals of patch review and tips
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBNb24sIE1hciAyMCwgMjAyMyBhdCA0OjIz4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIGFsbCwKCj4gPiA+ICsgYWxzbyBhZGQgVGVzdGVkOiBsaW5r
LXRvLWdpdGh1Yi1hY3Rpb25zLXJ1biBiZWxvdyAtLS0gaW4gcGF0Y2ggd291bGQKPiA+IGhlbHAK
PiA+ID4gKGl0J3MgdGhhbiBvYnZpb3VzIHRoYXQgbWFpbnRhaW5lciBkb2VzIG5vdCBoYXZlIHRv
IGJvdGhlciB3aXRoIGRvaW5nIGl0Cj4gPiBvcgo+ID4gPiBub3QgaG9wZSB0aGF0IGl0IGZhaWxz
IG9uIENlbnRPUyA3IG9sZCBjb21waWxlciBvciB2ZXJ5IG5ldyBGZWRvcmEKPiA+IGNvbXBpbGVy
KS4KCj4gPiA+IE1heWJlIGFsc28gZW5jb3VyYWdlIHBlb3BsZSB0byBjcmVhdGUgYWNjb3VudCBp
biB0aGUgcGF0Y2h3b3JrIGFuZAo+ID4gbWFpbnRhaW4KPiA+ID4gc3RhdHVzIHRoZWlyIHBhdGNo
ZXMgd291bGQgaGVscCAoc2V0ICJTdXBlcnNlZGVkIiBpZiB0aGV5IHNlbnQgbmV3IHBhdGNoCj4g
PiB2ZXJzaW9uLAoKCj4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgYnJpbmdzIGFkdmFudGFnZXMgbW9y
ZSB0aGFuIGRpc2FkdmFudGFnZXMKPiBNeSBjb25jZXJuIGlzIHRoYXQgcHJvYmFibHkgY2F1c2Vk
IHRoZSB3cm9uZyBvcGVyYXRpb24gaWYgbW9yZQo+IGdyZWVuIGhhbmRzIGNhbiB1cGRhdGUgdGhl
IHBhdGNoIHN0YXR1cyBpbiB0aGUgcGF0Y2h3b3JrLiBUaGF0Cj4gZWFzaWx5IGxldCB1cyBjb25m
dXNlZCBhYm91dCB3aGVyZSB0aGUgcGF0Y2ggaGFzIGdvbmU6KS4KCj4gVW5sZXNzIHdlIGhhdmUg
YSB3YXkgdG8gZ3JhbnQgbGltaXRlZCBwZXJtaXNzaW9ucyB0byBhY2NvdW50LgoKT3JkaW5hcnkg
dXNlcnMgKG5vbi1hZG1pbnMpIGhhdmUgcGVybWlzc2lvbnMgdG8gdGhlaXIgcGF0Y2hlcyAocGF0
Y2hlcyB3aGljaAp0aGV5IHNlbnQpLiBCdXQgYW55IHN0YXR1cyBjYW4gYmUgc2V0LiAgT0ssIGxl
dCdzIG5vdCBhc2sgZm9yIGl0LgoKCj4gPiBvdGhlciBzdGF0dXNlcyBsaWtlICJBY2NlcHRlZCIg
b3IgIkNoYW5nZXMgcmVxdWVzdGVkIiBhcmUgYWxzbyBzb21ldGltZXMKPiA+ID4gZm9yZ290dGVu
IGJ5IHRoZSBtYWludGFpbmVyIHdobyBwb3N0IGNvbW1lbnRzIG9yIG1lcmdlIHRoZSBwYXRjaCku
Cj4gPiBFeGFtcGxlIHdoeSBoZWxwaW5nIHRvIG1haW50YWluIHRoZSBwYXRjaGVzIGJ5IHN1Ym1p
dHRlciB3b3VsZCBoZWxwOgo+ID4gbWtub2QwMTogUmV3cml0ZSB0aGUgdGVzdCB1c2luZyBuZXcg
TFRQIEFQSSBbMV0gZm9sbG93ZWQgYnkgW3YyLDEvMV0KPiA+IG1rbm9kMDE6Cj4gPiBSZXdyaXRl
IHRoZSB0ZXN0IHVzaW5nIG5ldyBMVFAgQVBJIFsyXS4KCj4gPiBMaSByZXZpZXdlZCB2MiwgYnV0
IGxhdGVyIEN5cmlsIHB1c2hlZCB2MSAobWFudWFsbHkgdXBkYXRpbmcgcGF0Y2gpIHdpdGhvdXQK
PiA+IHVwZGF0ZSBwYXRjaHdvcmsuIChMaSByZXZpZXcgd2FzIGlnbm9yZWQsIEkgdHJpZWQgdG8g
YXBwbHkgdjIgdG8gbWVyZ2UgaXQKPiA+IGJlY2F1c2Ugc3RhdHVzIHdhcyBub3QgdXBkYXRlZC4p
CgoKCj4gSSdkIG1ha2UgYSBjbGFyaWZpY2F0aW9uIGZvciB0aGF0IG1rbm9kMDEgcGF0Y2ggcmV2
aWV3LAo+IHRoZSByZWFzb24gd2h5IEN5cmlsIG1lcmdlIFYxIG1hbnVhbGx5IGlzIHRoYXQgVjIK
PiBpbnZvbHZlcyBuZXcgY2hhbmdlIChJIG5lZ2xlY3RlZCkgaW4gbWtub2QwMiwgd2hpY2gKPiBz
aG91bGQgYmUgc2VwYXJhdGVkIGluIGFub3RoZXIgcGF0Y2guCgo+IEN5cmlsIGRpZCB0aGUgcmln
aHQgdGhpbmcgdGhlcmUuIEJ1dCBoZSBkaWRuJ3QgZXhwbGFpbiB0aGF0LgoKVGhhbmtzIGZvciBk
ZXRhaWxlZCBpbmZvLiBZZXMsIEkgZGlkbid0IHRoaW5rIEN5cmlsIGFueXRoaW5nIHdyb25nLCBJ
IHdhbnRlZCB0bwpkb2N1bWVudCB0aGF0IG1vcmUgcGF0Y2ggdmVyc2lvbnMgKyBub3QgdXBkYXRp
bmcgdGhlbSBjYW4gbGVhZCB0byBjb25mdXNpb24uCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gPiBQ
ZXRyCgo+ID4gWzFdCj4gPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbHRw
L3BhdGNoLzIwMjMwMjIyMDM0NTAxLjExODAwLTEtYWt1bWFyQHN1c2UuZGUvCj4gPiBbMl0KPiA+
IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAvcGF0Y2gvMjAyMzAyMjgx
NTQyMDMuMjc4My0xLWFrdW1hckBzdXNlLmRlLwoKPiA+ID4gQm90aCBvZiB0aGVzZSBhcmUgc21h
bGwgaGVscHMsIGJ1dCB0aGV5IHN0aWxsIGhlbHAgTFRQIG1haW50YWluZXJzIHRvCj4gPiBoYXZl
IG1vcmUKPiA+ID4gdGltZSBmb3IgdGhlIHJldmlldyBvciBmb3Igd3JpdGluZyBvd24gcGF0Y2hl
cy4KCj4gPiA+IEJ1dCBJIGNhbiBwb3N0IGEgZm9sbG93LXVwIHBhdGNoIHdpdGggdGhlc2UgYWZ0
ZXIgeW91ciBwYXRjaCBpcyBtZXJnZWQKPiA+IGlmIHlvdQo+ID4gPiBkb24ndCB3YW50IHRvIGZv
cm11bGF0ZSB0aGVtLgoKPiA+ID4gS2luZCByZWdhcmRzLAo+ID4gPiBQZXRyCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
