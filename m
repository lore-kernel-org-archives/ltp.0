Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8037CDC18E
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 12:46:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AD7E3C2204
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 13:46:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 355363C1DC8
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 13:46:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6A4676005C9
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 13:46:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 93A795BCCE;
 Tue,  6 Jan 2026 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767703593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFEdHur6G8BznzH4H2reLI+cQhBIEZydhXGF39WSv4E=;
 b=UTMPpA5bwSMj6zK34e/w6LUHTYrXhcOsvI/13FUECX2iC4Bc52Q2p0C0qmumCcLxcuZP8W
 OENwsp4vhj6ma0WjmsNJ/WpO1wQyU0rvXJS5BzgLqt2STSDVFGeEk+dEKLu1cRotzlO7i/
 gVLlAWYJRK0CnxdX5aIRAlGqmH6pUls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767703593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFEdHur6G8BznzH4H2reLI+cQhBIEZydhXGF39WSv4E=;
 b=NJT+YAOM2lNdbONIxdeGHHOC+NCxHHMb++3Dumk0LgL2s2vTXpt6l/xn2jdhS6UisDkKaw
 910NmLpVuOC/cSAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767703593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFEdHur6G8BznzH4H2reLI+cQhBIEZydhXGF39WSv4E=;
 b=UTMPpA5bwSMj6zK34e/w6LUHTYrXhcOsvI/13FUECX2iC4Bc52Q2p0C0qmumCcLxcuZP8W
 OENwsp4vhj6ma0WjmsNJ/WpO1wQyU0rvXJS5BzgLqt2STSDVFGeEk+dEKLu1cRotzlO7i/
 gVLlAWYJRK0CnxdX5aIRAlGqmH6pUls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767703593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFEdHur6G8BznzH4H2reLI+cQhBIEZydhXGF39WSv4E=;
 b=NJT+YAOM2lNdbONIxdeGHHOC+NCxHHMb++3Dumk0LgL2s2vTXpt6l/xn2jdhS6UisDkKaw
 910NmLpVuOC/cSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A40C3EA63;
 Tue,  6 Jan 2026 12:46:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i/kBHSkEXWmXGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 06 Jan 2026 12:46:33 +0000
Date: Tue, 6 Jan 2026 13:47:44 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aV0EcJ7TjsgULZKl@yuki.lan>
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251216112709.GC307257@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251216112709.GC307257@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] doc: Document process_state
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gPiBTaWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiA+
IC0tLQo+ID4gIGRvYy9kZXZlbG9wZXJzL2FwaV9jX3Rlc3RzLnJzdCB8ICA1ICsrKysKPiA+ICBp
bmNsdWRlL3RzdF9wcm9jZXNzX3N0YXRlLmggICAgfCA1NSArKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCAyMCBk
ZWxldGlvbnMoLSkKPiAKPiA+IE5ldyBpbiB2Mi4KPiAKPiA+IGRpZmYgLS1naXQgYS9kb2MvZGV2
ZWxvcGVycy9hcGlfY190ZXN0cy5yc3QgYi9kb2MvZGV2ZWxvcGVycy9hcGlfY190ZXN0cy5yc3QK
PiA+IGluZGV4IDJjYTBmMDQ2NC4uMTNmYzg2NTFiIDEwMDY0NAo+ID4gLS0tIGEvZG9jL2RldmVs
b3BlcnMvYXBpX2NfdGVzdHMucnN0Cj4gPiArKysgYi9kb2MvZGV2ZWxvcGVycy9hcGlfY190ZXN0
cy5yc3QKPiA+IEBAIC00Myw2ICs0MywxMSBAQCBLZXJuZWwKPiA+ICAuLiBrZXJuZWwtZG9jOjog
Li4vLi4vaW5jbHVkZS90c3Rfa2VybmVsLmgKPiA+ICAuLiBrZXJuZWwtZG9jOjogLi4vLi4vaW5j
bHVkZS90c3Rfa3ZlcmNtcC5oCj4gCj4gPiArUHJvY2VzcyBzdGF0ZQo+ID4gKy0tLS0tLS0tLS0t
LS0KPiA+ICsKPiA+ICsuLiBrZXJuZWwtZG9jOjogLi4vLi4vaW5jbHVkZS90c3RfcHJvY2Vzc19z
dGF0ZS5oCj4gPiArCj4gPiAgTlVNQQo+ID4gIC0tLS0KPiA+ICAuLiBrZXJuZWwtZG9jOjogLi4v
Li4vaW5jbHVkZS90c3RfbnVtYS5oCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90c3RfcHJvY2Vz
c19zdGF0ZS5oIGIvaW5jbHVkZS90c3RfcHJvY2Vzc19zdGF0ZS5oCj4gPiBpbmRleCBiMWQ4M2Ux
MDkuLjM2OTFiYmE3YSAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvdHN0X3Byb2Nlc3Nfc3RhdGUu
aAo+ID4gKysrIGIvaW5jbHVkZS90c3RfcHJvY2Vzc19zdGF0ZS5oCj4gPiBAQCAtMTUsMzkgKzE1
LDU0IEBACj4gCj4gPiAgI2lmZGVmIFRTVF9URVNUX0hfXwo+IAo+ID4gLS8qCj4gPiAtICogV2Fp
dHMgZm9yIHByb2Nlc3Mgc3RhdGUgY2hhbmdlLgo+ID4gKy8qKgo+ID4gKyAqIFRTVF9QUk9DRVNT
X1NUQVRFX1dBSVQoKSAtIFdhaXRzIGZvciBhIHByb2Nlc3Mgc3RhdGUgY2hhbmdlLgo+ID4gKyAq
Cj4gPiArICogUG9sbHMgYC9wcm9jLyRQSUQvc3RhdGVgIGZvciBhIHByb2Nlc3Mgc3RhdGUgY2hh
bmdlcy4KPiA+ICAgKgo+ID4gLSAqIFRoZSBzdGF0ZSBpcyBvbmUgb2YgdGhlIGZvbGxvd2luZzoK
PiA+ICsgKiBAcGlkOiBBIHByb2Nlc3MgcGlkLgo+ID4gKyAqIEBzdGF0ZTogQSBzdGF0ZSB0byB3
YWl0IGZvci4KPiA+ICsgKiBAbXNlY190aW1lb3V0OiBBIHRpbWVvdXQgZm9yIHRoZSB3YWl0Lgo+
ID4gICAqCj4gPiAtICogUiAtIHByb2Nlc3MgaXMgcnVubmluZwo+ID4gLSAqIFMgLSBwcm9jZXNz
IGlzIHNsZWVwaW5nCj4gPiAtICogRCAtIHByb2Nlc3Mgc2xlZXBpbmcgdW5pbnRlcnJ1cHRpYmx5
Cj4gPiAtICogWiAtIHpvbWJpZSBwcm9jZXNzCj4gPiAtICogVCAtIHByb2Nlc3MgaXMgdHJhY2Vk
Cj4gPiArICogUG9zc2libGUgcHJvY2VzcyBzdGF0ZXM6Cj4gTWF5YmU6IHVzZSBsaW5rIHRvIGh0
dHBzOi8vbWFuNy5vcmcvbGludXgvbWFuLXBhZ2VzL21hbjEvcHMuMS5odG1sID8KPiAKPiAtKiBQ
b3NzaWJsZSBwcm9jZXNzIHN0YXRlczoKPiArKiBQb3NzaWJsZSBwcm9jZXNzIHN0YXRlcyAoc2Vl
IDptYW4xOmBwc2ApOgoKMS4gV2UgZG8gbm90IGhhdmUgbWFuMSBkZWZpbmVkIGluIGV4bGlua3Mg
aW4gY29uZi5weQoKMi4gRXZlbiBpZiBhZGRlZCB0aGVyZSBleGxpbmtzIGRvZXMgbm90IHNlZW0g
d29yayBmcm9tIGRvY3VtZW50YXRpb24KICAgZ2VuZXJhdGVkIGZyb20gaGVhZGVycwoKPiA+ICsg
Kgo+ID4gKyAqIC0gKipSKiogUHJvY2VzcyBpcyBydW5uaW5nLgo+ID4gKyAqIC0gKipTKiogUHJv
Y2VzcyBpcyBzbGVlcGluZy4KPiA+ICsgKiAtICoqRCoqIFByb2Nlc3Mgc2xlZXBpbmcgdW5pbnRl
cnJ1cHRpYmx5Lgo+ID4gKyAqIC0gKipaKiogWm9tYmllIHByb2Nlc3MuCj4gPiArICogLSAqKlQq
KiBQcm9jZXNzIGlzIHRyYWNlZC4KPiA+ICsgKiAtICoqdCoqIFRyYWNpbmcgc3RvcHBlZC4KPiA+
ICsgKiAtICoqWCoqIFByb2Nlc3MgaWQgZGVhZC4KPiAKPiBQcm9jZXNzIHN0YXRlIGlzIG91dGRh
dGVkLCBtYW4gcHMoMSkgbGlzdHM6Cj4gCj4gICAgICAgICAgICAgICAgRCAgICB1bmludGVycnVw
dGlibGUgc2xlZXAgKHVzdWFsbHkgSS9PKQo+ICAgICAgICAgICAgICAgIEkgICAgaWRsZSBrZXJu
ZWwgdGhyZWFkCj4gICAgICAgICAgICAgICAgUiAgICBydW5uaW5nIG9yIHJ1bm5hYmxlIChvbiBy
dW4gcXVldWUpCj4gICAgICAgICAgICAgICAgUyAgICBpbnRlcnJ1cHRpYmxlIHNsZWVwICh3YWl0
aW5nIGZvciBhbgo+ICAgICAgICAgICAgICAgICAgICAgZXZlbnQgdG8gY29tcGxldGUpCj4gICAg
ICAgICAgICAgICAgVCAgICBzdG9wcGVkIGJ5IGpvYiBjb250cm9sIHNpZ25hbAo+ICAgICAgICAg
ICAgICAgIHQgICAgc3RvcHBlZCBieSBkZWJ1Z2dlciBkdXJpbmcgdGhlIHRyYWNpbmcKPiAgICAg
ICAgICAgICAgICBXICAgIHBhZ2luZyAobm90IHZhbGlkIHNpbmNlIExpbnV4IDIuNikKPiAgICAg
ICAgICAgICAgICBYICAgIGRlYWQgKHNob3VsZCBuZXZlciBiZSBzZWVuKQo+ICAgICAgICAgICAg
ICAgIFogICAgZGVmdW5jdCAo4oCcem9tYmll4oCdKSBwcm9jZXNzLCB0ZXJtaW5hdGVkCj4gICAg
ICAgICAgICAgICAgICAgICBidXQgbm90IHJlYXBlZCBieSBpdHMgcGFyZW50Cj4gCj4gV2UgbWlz
czoKPiAqIEkgKGZyb20ga2VybmVsIDQuMiwgbWF5YmUgbm90IHJlbGV2YW50IHdoZW4gd2UgdXNl
IGl0IGZvciBhIGNoaWxkIHdoaWNoCj4gaXMgdXNlcnNwYWNlKQo+ICogVyAoaXJyZWxldmFudCBh
cyBpdCBpcyBub3QgdmFsaWQpCgpJbmRlZWQgdGhlc2UgYXJlIG5vdCByZWxldmVudCBmb3IgdXMu
Cgo+ICogWgoKWm9tYmllIHByb2Nlc3MgaXMgZGVzY3JpYmVkIGluIHRoZSBsaXN0LgoKPiBBbHNv
LCBkbyB3ZSB3YW50IHNwZWNpZnkgdGhlIHByb2Nlc3Mgc3RhdGVzIGluIGJvdGggVFNUX1BST0NF
U1NfU1RBVEVfV0FJVCgpIGFuZAo+IFRTVF9USFJFQURfU1RBVEVfV0FJVCgpLCBvciBqdXN0IHNw
ZWNpZnkgaXQgaW4gb25lIGFuZCBtZW50aW9uIGluIHRoZSBvdGhlciB0aGF0Cj4gdGhleSBzcGVj
aWZ5IGl0PyAodmlhIDpyZWY6IG9yIGM6ZnVuYzopLgoKQWdhaW4sIG5vbmUgb2YgdGhlIDpyZWY6
IG9yIGM6ZnVuYzogaXMgd29ya2luZyBpbiBkb2NzIGdlbmVyYXRlIGZyb20KaGVhZGVycy4KCi0t
IApDeXJpbCBIcnViaXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
