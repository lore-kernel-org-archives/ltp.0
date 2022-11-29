Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C5EC4321E
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 11:01:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D29F63CC5EB
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 12:01:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 217203C3057
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:01:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DF2FE600728
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:01:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9629821B69;
 Tue, 29 Nov 2022 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669719703;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QX7a8UtQIjBiT5BucrabJQ5r8vvnLwScozN9vKJjBjE=;
 b=uH11uQ0sgwwcXgh9h4m3fKNwUKs5AeX4N2Ow/3zYl3MYA3jZumT4QgPH+ULuURmhBbTQQ7
 kmNprAUXtKZ8y/SeUK6xVANkiJyiMhN063s7tn/tmV7x+dv9MElIqSRzZPq+d/hg82pwQl
 ZNTfr543AkF4dSnDNbx2SWVTiYwvz8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669719703;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QX7a8UtQIjBiT5BucrabJQ5r8vvnLwScozN9vKJjBjE=;
 b=H5s/DIG7/QTqYw+SHnlthpI4n1N2vxUAk1I1bWhnHdGFrn892Z7TJHJlWviUweHyVqQuDf
 AA4J1qgHgwT/cDBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 456C713AF6;
 Tue, 29 Nov 2022 11:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DoozDpfmhWOjWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 29 Nov 2022 11:01:43 +0000
Date: Tue, 29 Nov 2022 12:01:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tudor Cretu <tudor.cretu@arm.com>
Message-ID: <Y4XmlHZyi2DG9DRT@pevik>
References: <20221123144746.590890-1-tudor.cretu@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221123144746.590890-1-tudor.cretu@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] safe_macros: Fix undefined behaviour in
 vararg handling
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgVHVkb3IsCgo+IEFjY2Vzc2luZyBlbGVtZW50cyBpbiBhbiBlbXB0eSB2YV9saXN0IHJlc3Vs
dHMgaW4gdW5kZWZpbmVkIGJlaGF2aW91clswXQo+IHRoYXQgY2FuIGluY2x1ZGUgYWNjZXNzaW5n
IGFyYml0cmFyeSBzdGFjayBtZW1vcnkuIFdoaWxlIHR5cGljYWxseSB0aGlzCj4gZG9lc24ndCBy
YWlzZSBhIGZhdWx0LCBzb21lIG5ldyBtb3JlIHNlY3VyaXR5LW9yaWVudGVkIGFyY2hpdGVjdHVy
ZXMKPiAoZS5nLiBDSEVSSVsxXSBvciBNb3JlbGxvWzJdKSBkb24ndCBhbGxvdyBpdC4KCj4gVGhl
cmVmb3JlLCByZW1vdmUgdGhlIHZhcmlhZGljbmVzcyBmcm9tIHNhZmVfKiB3cmFwcGVycyB0aGF0
IGFsd2F5cyBjYWxsCj4gdGhlIGZ1bmN0aW9ucyB3aXRoIHRoZSBvcHRpb25hbCBhcmd1bWVudCBp
bmNsdWRlZC4KCj4gQWRhcHQgdGhlIHJlc3BlY3RpdmUgU0FGRV8qIG1hY3JvcyB0byBoYW5kbGUg
dGhlIGNoYW5nZSBieSBwYXNzaW5nIGEKPiBkZWZhdWx0IGFyZ3VtZW50IGlmIHRoZXkncmUgb21p
dHRlZC4KClRoYW5rcyBmb3IgYW4gaW50ZXJlc3RpbmcgcGF0Y2hzZXQhCgpJIHdvbmRlciBpZiBp
dCdzIGEgY29ycmVjdCBhcHByb2FjaCBhcyBDIEFQSSBhbGxvd3MKaW50IG9wZW4oY29uc3QgY2hh
ciAqcGF0aG5hbWUsIGludCBmbGFncyk7CndlIHdpbGwgcmVwbGFjZSBpdCAKaW50IG9wZW4oY29u
c3QgY2hhciAqcGF0aG5hbWUsIGludCBmbGFncywgbW9kZV90IG1vZGUpOwp3aGVyZSBtb2RlIGlz
IDAuCkJ1dCBhcyBpdCdzIG9ubHkgaW4gc2FmZV8qIGl0IHNob3VsZCBiZSBvay4KV2Ugc3RpbGwg
aGF2ZSBzb21lIG9wZW4oKSB0ZXN0cyB3aXRob3V0IG1vZGUsIGkuZS4KdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9vcGVuL29wZW4wNi5jCgpVbmZvcnR1bmF0ZWx5IHNvbWUgdGVzdHMgbmVlZCB0
byBiZSBhZGp1c3RlZCwgYXQgbGVhc3QgYWxsIHRlc3RzIGluCnRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZmdldHhhdHRyIHdpbGwgZmFpbCBkdWUgaW50LWNvbnZlcnNpb24sCmFzIHRoZXkgdXNl
IE5VTEwgYXMgdGhlIHRoaXJkIHBhcmFtZXRlcjoKCiQgZXhwb3J0IENGTEFHUz0iLVdlcnJvcj1j
b252ZXJzaW9uIgokIC4vY29uZmlndXJlCiQgY2QgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
Z2V0eGF0dHIKJCBtYWtlIGNsZWFuCiQgbWFrZSBWPTEKZ2NjIC1JLi4vLi4vLi4vLi4vaW5jbHVk
ZSAtSS4uLy4uLy4uLy4uL2luY2x1ZGUgLUkuLi8uLi8uLi8uLi9pbmNsdWRlL29sZC8gLVdlcnJv
cj1pbnQtY29udmVyc2lvbiAtZyAtTzIgLWZuby1zdHJpY3QtYWxpYXNpbmcgLXBpcGUgLVdhbGwg
LVcgLVdvbGQtc3R5bGUtZGVmaW5pdGlvbiAtc3RkPWdudTk5IC1MLi4vLi4vLi4vLi4vbGliIGZn
ZXR4YXR0cjAxLmMgIC1sbHRwIC1vIGZnZXR4YXR0cjAxCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAu
Li8uLi8uLi8uLi9pbmNsdWRlL3RzdF90ZXN0Lmg6OTgsCiAgICAgICAgICAgICAgICAgZnJvbSBm
Z2V0eGF0dHIwMS5jOjM0OgpmZ2V0eGF0dHIwMS5jOiBJbiBmdW5jdGlvbiDigJhzZXR1cOKAmToK
Li4vLi4vLi4vLi4vaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaDo5MDo2NzogZXJyb3I6IHBhc3Np
bmcgYXJndW1lbnQgNiBvZiDigJhzYWZlX29wZW7igJkgbWFrZXMgaW50ZWdlciBmcm9tIHBvaW50
ZXIgd2l0aG91dCBhIGNhc3QgWy1XZXJyb3I9aW50LWNvbnZlcnNpb25dCiAgIDkwIHwgICAgICAg
ICBzYWZlX29wZW4oX19GSUxFX18sIF9fTElORV9fLCBOVUxMLCAocGF0aG5hbWUpLCAob2ZsYWdz
KSwgKG1vZGUpKQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fgogICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwKICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2b2lkICoKLi4vLi4vLi4vLi4vaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3Mu
aDo5Mzo5OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYX19TQUZFX09QRU7igJkKICAg
OTMgfCAgICAgICAgIF9fU0FGRV9PUEVOKChwYXRobmFtZSksIChvZmxhZ3MpLCAjI19fVkFfQVJH
U19fLCAwKQogICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn4KZmdldHhhdHRyMDEuYzoxMTQ6MTQ6
IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhTQUZFX09QRU7igJkKICAxMTQgfCAgICAg
ICAgIGZkID0gU0FGRV9PUEVOKEZOQU1FLCBPX1JET05MWSwgTlVMTCk7CiAgICAgIHwgICAgICAg
ICAgICAgIF5+fn5+fn5+fgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4vLi4vLi4vLi4vaW5jbHVk
ZS90c3Rfc2FmZV9tYWNyb3MuaDoyNDoKLi4vLi4vLi4vLi4vaW5jbHVkZS9zYWZlX21hY3Jvc19m
bi5oOjc4OjIyOiBub3RlOiBleHBlY3RlZCDigJhtb2RlX3TigJkge2FrYSDigJh1bnNpZ25lZCBp
bnTigJl9IGJ1dCBhcmd1bWVudCBpcyBvZiB0eXBlIOKAmHZvaWQgKuKAmQogICA3OCB8ICAgICAg
ICAgICAgICAgbW9kZV90IG1vZGUpOwogICAgICB8ICAgICAgICAgICAgICAgfn5+fn5+fl5+fn4K
Y2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbLi4v
Li4vLi4vLi4vaW5jbHVkZS9tay9ydWxlcy5tazo0MzogZmdldHhhdHRyMDFdIEVycm9yIDEKCkZv
dW5kIG9uIHJlY2VudCBvcGVuU1VTRSBUdW1ibGV3ZWVkIHdoaWNoIGhhcyAyLjM2LiBBbHNvIG91
ciBDSSBoYXMgY2F1Z2h0IGl0IG9uCkZlZG9yYSAod2hpY2ggYWxzbyB1c2VzIDIuMzYpOgpodHRw
czovL2dpdGh1Yi5jb20vcGV2aWsvbHRwL2FjdGlvbnMvcnVucy8zNTczMjE1MzkwL2pvYnMvNjAw
NzAxNjU3MgoKS2luZCByZWdhcmRzLApQZXRyCgo+IFswXTogW0lTTy9JRUMgOTg5OToyMDExXSBQ
cm9ncmFtbWluZyBMYW5ndWFnZXPigJRDLCAzcmQgZWQsIHBhcmFncmFwaCA3LjE2LjEuMQo+IFsx
XTogaHR0cHM6Ly93d3cuY2wuY2FtLmFjLnVrL3Jlc2VhcmNoL3NlY3VyaXR5L2N0c3JkL2NoZXJp
Lwo+IFsyXTogaHR0cHM6Ly93d3cubW9yZWxsby1wcm9qZWN0Lm9yZy8KCj4gVHVkb3IgQ3JldHUg
KDMpOgo+ICAgc2FmZV9vcGVuOiBGaXggdW5kZWZpbmVkIGJlaGF2aW91ciBpbiB2YXJhcmcgaGFu
ZGxpbmcKPiAgIHNhZmVfb3BlbmF0OiBGaXggdW5kZWZpbmVkIGJlaGF2aW91ciBpbiB2YXJhcmcg
aGFuZGxpbmcKPiAgIHNhZmVfc2VtY3RsOiBGaXggdW5kZWZpbmVkIGJlaGF2aW91ciBpbiB2YXJh
cmcgaGFuZGxpbmcKCj4gIGluY2x1ZGUvb2xkL3NhZmVfbWFjcm9zLmggICB8ICA2ICsrKystLQo+
ICBpbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmggICAgfCAgMyArKy0KPiAgaW5jbHVkZS90c3Rfc2Fm
ZV9maWxlX2F0LmggIHwgMTAgKysrKysrLS0tLQo+ICBpbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5o
ICAgfCAgNiArKysrLS0KPiAgaW5jbHVkZS90c3Rfc2FmZV9zeXN2X2lwYy5oIHwgMTQgKysrKysr
KysrLS0tLS0KPiAgbGliL3NhZmVfbWFjcm9zLmMgICAgICAgICAgIHwgMTMgKy0tLS0tLS0tLS0t
LQo+ICBsaWIvdHN0X2Nncm91cC5jICAgICAgICAgICAgfCAgMiArLQo+ICBsaWIvdHN0X3NhZmVf
ZmlsZV9hdC5jICAgICAgfCAxMSArKystLS0tLS0tLQo+ICBsaWIvdHN0X3NhZmVfc3lzdl9pcGMu
YyAgICAgfCAxMCArLS0tLS0tLS0tCj4gIDkgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygr
KSwgNDQgZGVsZXRpb25zKC0pCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
