Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D3CC636D4
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 09:19:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D58C3CBE52
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 10:19:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A69DF3CB09F
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 10:19:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EAE011400DEF
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 10:19:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E9401FD6D;
 Fri, 17 Feb 2023 09:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676625559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4KqbwhGBJxYToGfyTfdL7RQ+af0fPRIyEJg77uxOmc=;
 b=eVUVDhPL+O+X0m8AREscz1YLOJ6RVyf2ODVE7hCkT5Oiqi1FcBKRcN8W+QOoHdknvLueNm
 7LzmfBfuI5xX7ikBllibzyyA4kxnkHDBia2HFiisLD3Ol/JFSd1E1GYEVGu+rx0A+JPr0h
 Bk01x2VQkDm7cDxRDKSY0jWkANEjRF4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19B11138E3;
 Fri, 17 Feb 2023 09:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5ADcOJVG72MzEgAAMHmgww
 (envelope-from <wegao@suse.com>); Fri, 17 Feb 2023 09:19:17 +0000
Date: Fri, 17 Feb 2023 04:19:14 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230217091914.GA14295@localhost>
References: <20230213010924.12352-1-wegao@suse.com>
 <20230216235218.25757-1-wegao@suse.com> <Y+8/CHVbHycW1+Gv@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+8/CHVbHycW1+Gv@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] fsconfig03: New test CVE-2022-0185
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it, rpalethorpe@suse.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBGZWIgMTcsIDIwMjMgYXQgMDk6NDc6MDRBTSArMDEwMCwgUGV0ciBWb3JlbCB3cm90
ZToKPiBIaSBhbGwsCj4gCj4gSSd2ZSB0ZXN0ZWQgdmFyaW91cyBrZXJuZWxzLCBpdCBsb29rcyBs
aWtlIHRlc3Qgd29ya3MgYXMgZXhwZWN0ZWQKPiAob2xkZXIgdW5wYXRjaGVkIGtlcm5lbCBmYWls
cywgbmV3ZXIgd29ya3MsIHZlcnkgb2xkIG9uZXMgVENPTkYpLgpUaGFua3MgZm9yIGdyZWF0IHdv
cmshCj4gCj4gPiBUaGVyZSBhcmUgcmVwcm9kdWNlcnMgYXZhaWxhYmxlIGZvciBDVkUtMjAyMi0w
MTg1Cj4gPiBodHRwczovL3d3dy5vcGVud2FsbC5jb20vbGlzdHMvb3NzLXNlY3VyaXR5LzIwMjIv
MDEvMjUvMTQKPiAKPiA+IEFsc28gd2l0aCBsaW5rcyBvciBldmVuIGEgemlwIGZpbGUgZm9yIGFu
IGV4cGxvaXQKPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9DcnVzYWRlcnMtb2YtUnVzdC9DVkUtMjAy
Mi0wMTg1Cj4gCj4gPiBUaGUgZXhwbG9pdHMgYXJlIGtpbmQgb2YgY29tcGxpY2F0ZWQgYXMgdGhl
eSB0cnkgdG8gYmUgY29tcGxldGUsCj4gPiBidXQgdGhlIGV4cGxvaXRhdGlvbiB2ZWN0b3IgaXMg
dGhlIGZzY29uZmlnKCkgc3lzY2FsbCwKPiA+IHRoaXMgY2FzZSB1c2VkIGZvciBhZGQgc29tZSBj
b3ZlcmFnZSB0byB0aGF0IHRvIGRldGVjdCBpdC4KPiAKPiA+IFdoZW4ga2VybmVsIDwgdjUuMTUu
MTYsIHlvdSBjYW4gZWFzaWx5IHJlcHJvZHVjZSBjcmFzaCB1c2UgdGVzdCBjYXNlCj4gPiB3aXRo
b3V0IGNoZWNrIGVycm9yIGFuZCByZXR1cm4gbG9naWMgaW4gbG9vcC4KPiAKPiA+IEkgaGF2ZSB1
c2VkIHRoaXMgdGVzdCBjYXNlIHRyaWdnZXIgNS4xNC4xIGtlcm5lbCBjcmFzaCB3aXRoIGV4dDIv
NC4KPiAKPiA+IEp1c3QgbWFrZSBzdXJlIHlvdXIga2VybmVsIGhhdmUgbm90IHBhdGNoZWQgYnkg
Zm9sbG93aW5nIHR3byBjb21taXRzOgo+ID4gZTE5MmNjYzE3ZWNmMyAtIGZpeCB1cCBwYXJhbSBs
ZW5ndGggcGFyc2luZyBpbiBsZWdhY3lfcGFyc2VfcGFyYW0KPiBGWUk6IGNvbW1pdCA3MjJkOTQ4
NDdkZTI5MzEwZThhYTAzZmNiZGI0MWZjOTJjNTIxNzU2IHVwc3RyZWFtLgo+ID0+IHRoYXQncyBh
IGJhY2twb3J0IG9mIDcyMmQ5NDg0N2RlMjkgd2UgaGF2ZSBpbiAudGFncyBpbiA1LjE1IHN0YWJs
ZSBicmFuY2guCj4gVGhpcyBpcyBub3Qgb2J2aW91cywgYmVjYXVzZSB0aGUgaGFzaCBpcyBkaWZm
ZXJlbnQ7IGFsc28gaGFzaCB3aWxsIGJlCj4gZGlmZmVyZW50IGZvciBmb3Igb3RoZXIga2VybmVs
IHN0YWJsZSBicmFuY2hlcywgZS5nLiBpbiA1LjEwIHN0YWJsZSBpdCdzCj4gYmFja3BvcnRlZCBp
bnRvIGVhZGRlMjg3YTYyZTY2YjJmOWU2MmQwMDdjNTlhOGY1MGQ0Yjg0MTMuCj4gCj4gVGhpcyBp
cyBtaXNsZWFkaW5nLCBJIGZpcnN0IHdvbmRlcmVkIGlmIGUxOTJjY2MxN2VjZjMgc2hvdWxkbid0
IGJlIGluIHRhZ3MKPiAoaXQgc2hvdWxkbid0IGJlY2F1c2UgaXQncyBhIGJhY2twb3J0IG9mIDcy
MmQ5NDg0N2RlMjkgPT4gd2UgZG9uJ3QgcHV0IGJhY2twb3J0cwo+IHRoZXJlOiAiV2UgZG9u4oCZ
dCB0cmFjayBhbGwgYmFja3BvcnRzIHRvIHN0YWJsZSBrZXJuZWwgYnV0IGp1c3QgdGhvc2Ugd2hp
Y2ggYXJlCj4gc3RhYmxlIGJyYW5jaCBzcGVjaWZpYyAodW5pcXVlKSwgaS5lLiBubyBjb21taXQg
aW4gbWFpbmxpbmUuIEV4YW1wbGUgb2YgY29tbWl0czoKPiBjNGEyM2M4NTJlODAsIGNhYzY4ZDEy
YzUzMS4iIFsxXSkuCj4gCj4gVGhlcmVmb3JlIEknZCByZW1vdmUgdGhpcyB3aG9sZSBzZWN0aW9u
ICgiSnVzdCBtYWtlIHN1cmUuLi4iKS4KPiAKCk5vIHByb2JsZW0gZm9yIG1lLgoKPiA+IGNlYmU4
NWQ1NzBjZjggLSBleHQ0OiBzd2l0Y2ggdG8gdGhlIG5ldyBtb3VudCBhcGkKPiAKPiBJIHN1cHBv
c2UgdGVzdCBpcyBub3cgd29ya2luZyBhcyBleHBlY3RlZCByZWdhcmRsZXNzIGtlcm5lbCB1c2Vz
Cj4gdGhlIG9sZCBtb3VudCBBUEkgb3IgdGhlIG5ldyBvbmUgKGZyb20gY2ViZTg1ZDU3MGNmOCks
IHJpZ2h0Pwo+IElzIHRoaXMgY29tbWVudCB1cCB0byBkYXRlPwpUaGlzIGNvbW1pdCBjYW4gaW1w
YWN0IHRlc3QgcmVzdWx0IGluIGEgdmVyeSBzbWFsbCB3aW5kb3csIGluIHRoZW9yeSBpZiB5b3Ug
dGVzdCBrZXJuZWwgdmVyc2lvbiAKYmV0d2VlbiB2NS4xNS4xNiB+IHY1LjE3LXJjMSBmb3IgZXh0
Mi8zLzQsIGZzY29uZmlnIHdpbGwgbm90IGdpdmUgZXJyb3IgdW50aWwgYnVmZmVyIHNpemUgcmVh
Y2ggCmEgcGFnZSBzaXplLiAKIApnaXQgZGVzY3JpYmUgLS1jb250YWlucyBlMTkyY2NjMTdlY2Yz
ICAgLy9maXggZm9yIGxlZ2FjeV9wYXJzZV9wYXJhbQp2NS4xNS4xNn4yNApnaXQgZGVzY3JpYmUg
LS1jb250YWlucyBjZWJlODVkNTcwY2Y4ICAvL2ZpeCBmb3Igc3dpdGNoIG5ldyBwYXJzZSBmdW5j
dGlvbgp2NS4xNy1yYzF+MTMxXjJ+MzYKCj4gCj4gQWxzbywgbml0OiBrZXJuZWwgY29tbWl0cyBh
cmUgdXN1YWxseSBwdXQgaW4gZm9ybSBvZiBoYXNoICgiLi4uIiksIGkuZS4KPiBlMTkyY2NjMTdl
Y2YgKCJ2ZnM6IGZzX2NvbnRleHQ6IGZpeCB1cCBwYXJhbSBsZW5ndGggcGFyc2luZyBpbiBsZWdh
Y3lfcGFyc2VfcGFyYW0iKQo+IAo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4gCj4gWzFdIGh0dHBz
Oi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL3dpa2kvQy1UZXN0LUFQSSMxMzgt
dGVzdC10YWdzCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
