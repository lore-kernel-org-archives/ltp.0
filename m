Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234E9C4345F
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 23:52:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BC883CFA70
	for <ltp@archiver.kernel.org>; Tue, 16 Apr 2024 01:52:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 076033CF9CF
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 01:52:19 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=neilb@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 466E9200133
 for <ltp@lists.linux.it>; Tue, 16 Apr 2024 01:52:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E40F05D517;
 Mon, 15 Apr 2024 23:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713225138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOIELrXN3Wn/JheA2YwA6RPiUkr2mKSP6eK2gsYvSCc=;
 b=S/WjInJqBv/gXswR5607BsAk/LqRfL+QfMz8UXRa01mYvplSCVwg9IYpNTAxLYMtZk2Fw5
 Vls4Xdi3KGsfDERC/4koB5HDtn0wu3u7odukvVYHhE+lL2O0nU8KRmHJx1s5SFwj1fghwf
 qR96oq77AwQrrVEABbvGbdbfmfJLhIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713225138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOIELrXN3Wn/JheA2YwA6RPiUkr2mKSP6eK2gsYvSCc=;
 b=r+XCgraG9jI8TPZz+9Q65m07l6jLHCE2P//69M72R94fQaQE1EmnE6Y/RpZz5z1Gwv9G0C
 rnGc3weK9GGpRAAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713225137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOIELrXN3Wn/JheA2YwA6RPiUkr2mKSP6eK2gsYvSCc=;
 b=WLQnfDWZgWaXfsBwRdCCvONHMC+H4u4ALdfhSlQYRRlD4rH4RPmRnrPPXMfGyNeFgFT0XX
 N/5K1dEa+WjKs7DUbdXFoGZty0RuQekRoS4E5PLVRNOiORTRrJxlxLHAYGo29PmFinT+3I
 /I7gHMdZInoNUEgUaZXJk8XGbaVBmgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713225137;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOIELrXN3Wn/JheA2YwA6RPiUkr2mKSP6eK2gsYvSCc=;
 b=GJv6TrdB826oOs+5Wgs2/j/XfWbnLEZXfMZUedIL/evz/c+pnHwZJcVXzZahKqu/GgWa3b
 sCbfrnSwRAITbeAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D9041368B;
 Mon, 15 Apr 2024 23:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nhYUOK69HWaaUQAAD6G6ig
 (envelope-from <neilb@suse.de>); Mon, 15 Apr 2024 23:52:14 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
In-reply-to: <Zh2XBV/sW67dx+wp@tissot.1015granger.net>
References: <>, <Zh2XBV/sW67dx+wp@tissot.1015granger.net>
Date: Tue, 16 Apr 2024 09:52:11 +1000
Message-id: <171322513118.17212.2981486436520645718@noble.neil.brown.name>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] proc01: Whitelist
 /proc/fs/nfsd/nfsv4recoverydir
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
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Jeff Layton <jlayton@kernel.org>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCAxNiBBcHIgMjAyNCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6Cj4gT24gTW9uLCBBcHIgMTUs
IDIwMjQgYXQgMDE6NDM6MzdQTSAtMDQwMCwgSmVmZiBMYXl0b24gd3JvdGU6Cj4gPiBPbiBNb24s
IDIwMjQtMDQtMTUgYXQgMTc6MzcgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToKPiA+ID4g
Cj4gPiA+ID4gT24gQXByIDE1LCAyMDI0LCBhdCAxOjM14oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5
dG9uQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gPiA+IAo+ID4gPiA+IE9uIE1vbiwgMjAyNC0wNC0x
NSBhdCAxNzoyNyArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOgo+ID4gPiA+ID4gCj4gPiA+
ID4gPiA+IE9uIEFwciAxNSwgMjAyNCwgYXQgMToyMeKAr1BNLCBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4gd3JvdGU6Cj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAvcHJvYy9mcy9uZnNkL25m
c3Y0cmVjb3ZlcnlkaXIgc3RhcnRlZCBmcm9tIGtlcm5lbCA2LjggcmVwb3J0IEVJTlZBTC4KPiA+
ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6Pgo+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gSGksCj4gPiA+ID4gPiA+IAo+ID4g
PiA+ID4gPiBAIEplZmYsIENodWNrLCBOZWlsLCBORlMgZGV2czogVGhlIHBhdGNoIGl0c2VsZiB3
aGl0ZWxpc3QgcmVhZGluZwo+ID4gPiA+ID4gPiAvcHJvYy9mcy9uZnNkL25mc3Y0cmVjb3Zlcnlk
aXIgaW4gTFRQIHRlc3QuIEkgc3VzcGVjdCByZWFkaW5nIGZhaWxlZAo+ID4gPiA+ID4gPiB3aXRo
IEVJTlZBTCBpbiA2Ljggd2FzIGEgZGVsaWJlcmF0ZSBjaGFuZ2UgYW5kIGV4cGVjdGVkIGJlaGF2
aW9yIHdoZW4KPiA+ID4gPiA+ID4gQ09ORklHX05GU0RfTEVHQUNZX0NMSUVOVF9UUkFDS0lORyBp
cyBub3Qgc2V0Ogo+ID4gPiA+ID4gCj4gPiA+ID4gPiBJJ20gbm90IHN1cmUgaXQgd2FzIGRlbGli
ZXJhdGUuIFRoaXMgc2VlbXMgbGlrZSBhIGJlaGF2aW9yCj4gPiA+ID4gPiByZWdyZXNzaW9uLiBK
ZWZmPwo+ID4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gSSBkb24ndCB0aGluayBJIGludGVuZGVk
IHRvIG1ha2UgaXQgcmV0dXJuIC1FSU5WQUwuIEkgZ3Vlc3MgdGhhdCdzIHdoYXQKPiA+ID4gPiBo
YXBwZW5zIHdoZW4gdGhlcmUgaXMgbm8gZW50cnkgZm9yIGl0IGluIHRoZSB3cml0ZV9vcCBhcnJh
eS4KPiA+ID4gPiAKPiA+ID4gPiBXaXRoIENPTkZJR19ORlNEX0xFR0FDWV9DTElFTlRfVFJBQ0tJ
TkcgZGlzYWJsZWQsIHRoYXQgZmlsZSBoYXMgbm8KPiA+ID4gPiBtZWFuaW5nIG9yIHZhbHVlIGF0
IGFsbCBhbnltb3JlLiBNYXliZSB3ZSBzaG91bGQganVzdCByZW1vdmUgdGhlIGRlbnRyeQo+ID4g
PiA+IGFsdG9nZXRoZXIgd2hlbiBDT05GSUdfTkZTRF9MRUdBQ1lfQ0xJRU5UX1RSQUNLSU5HIGlz
IGRpc2FibGVkPwo+ID4gPiAKPiA+ID4gTXkgdW5kZXJzdGFuZGluZyBvZiB0aGUgcnVsZXMgYWJv
dXQgbW9kaWZ5aW5nIHRoaXMgcGFydCBvZgo+ID4gPiB0aGUga2VybmVsLXVzZXIgaW50ZXJmYWNl
IGlzIHRoYXQgdGhlIGZpbGUgaGFzIHRvIHN0YXksIGV2ZW4KPiA+ID4gdGhvdWdoIGl0J3Mgbm93
IGEgbm8tb3AuCj4gPiA+IAo+ID4gCj4gPiBEb2VzIGl0PyAgV2hlcmUgYXJlIHRoZXNlIHJ1bGVz
IHdyaXR0ZW4/IAo+ID4gCj4gPiBXaGF0IHNob3VsZCB3ZSBoYXZlIGl0IGRvIG5vdyB3aGVuIHJl
YWQgYW5kIHdyaXR0ZW4/IE1heWJlIEVPUE5PVFNVUFAKPiA+IHdvdWxkIGJlIGJldHRlciwgaWYg
d2UgY2FuIG1ha2UgaXQganVzdCByZXR1cm4gYW4gZXJyb3I/Cj4gPiAKPiA+IFdlIGNvdWxkIGFs
c28gbWFrZSBpdCBqdXN0IGRpc2NhcmQgd3JpdHRlbiBkYXRhLCBhbmQgcHJlc2VudCBhIGJsYW5r
Cj4gPiBzdHJpbmcgd2hlbiByZWFkLiBXaGF0IGRvIHRoZSBydWxlcyBzYXkgd2UgYXJlIHJlcXVp
cmVkIHRvIGRvIGhlcmU/Cj4gCj4gVGhlIGJlc3QgSSBjb3VsZCBmaW5kIHdhcyBEb2N1bWVudGF0
aW9uL3Byb2Nlc3Mvc3RhYmxlLWFwaS1ub25zZW5zZS5yc3QuCj4gCj4gVGVsbCB5b3Ugd2hhdCwg
eW91IGFuZCBQZXRyIHdvcmsgb3V0IHdoYXQgeW91J2QgbGlrZSB0byBkbywgbGV0J3MKPiBmaWd1
cmUgb3V0IHRoZSByaWdodCBzZXQgb2YgZm9sa3MgdG8gcmV2aWV3IGNoYW5nZXMgaW4gL3Byb2Ms
IGFuZAo+IHdlJ2xsIGdvIGZyb20gdGhlcmUuIElmIG5vLW9uZSBoYXMgYSBwcm9ibGVtIHJlbW92
aW5nIHRoZSBmaWxlLCBJJ20KPiBub3QgZ29pbmcgdG8gc3RhbmQgaW4gdGhlIHdheS4KCkkgZG9u
J3QgdGhpbmsgd2UgbmVlZCBhbnkgZXh0ZXJuYWwgcmV2aWV3IGZvciB0aGlzLiAgV2hpbGUgdGhl
IGZpbGUgaXMKaW4gL3Byb2MsIGl0IGlzIG5vdCBpbiBwcm9jZnMgYnV0IGluIG5mc2Rmcy4gIFNv
IHBlb3BsZSBvdXQgc2lkZSB0aGUKbmZzZCBjb21tdW5pdHkgYXJlIHVubGlrZWx5IHRvIGNhcmUu
ICBBbmQgdGhpcyBpc24ndCBhIGhhcmQgcmVtb3ZhbC4gIEl0CmlzIGp1c3QgYSBuZXcgY29uZmln
IG9wdGlvbiB0aGF0IGFsbG93cyBhIGZpbGUgdG8gYmUgcmVtb3ZlZC4KCkkgdGhpbmsgd2UgZG8g
d2FudCB0byBjb21wbGV0ZWx5IHJlbW92ZSB0aGUgZmlsZSwgbm90IGp1c3QgbGV0IGl0IHJldHVy
bgphbiBlcnJvcjoKLS0tIGEvZnMvbmZzZC9uZnNjdGwuYworKysgYi9mcy9uZnNkL25mc2N0bC5j
CkBAIC01MSw3ICs1MSw5IEBAIGVudW0gewogI2lmZGVmIENPTkZJR19ORlNEX1Y0CiAJTkZTRF9M
ZWFzZXRpbWUsCiAJTkZTRF9HcmFjZXRpbWUsCisjaWZkZWYgQ09ORklHX05GU0RfTEVHQUNZX0NM
SUVOVF9UUkFDS0lORwogCU5GU0RfUmVjb3ZlcnlEaXIsCisjZW5kaWYKIAlORlNEX1Y0RW5kR3Jh
Y2UsCiAjZW5kaWYKIAlORlNEX01heFJlc2VydmVkCkBAIC0xMzYwLDcgKzEzNjIsOSBAQCBzdGF0
aWMgaW50IG5mc2RfZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZnNf
Y29udGV4dCAqZmMpCiAjaWZkZWYgQ09ORklHX05GU0RfVjQKIAkJW05GU0RfTGVhc2V0aW1lXSA9
IHsibmZzdjRsZWFzZXRpbWUiLCAmdHJhbnNhY3Rpb25fb3BzLCBTX0lXVVNSfFNfSVJVU1J9LAog
CQlbTkZTRF9HcmFjZXRpbWVdID0geyJuZnN2NGdyYWNldGltZSIsICZ0cmFuc2FjdGlvbl9vcHMs
IFNfSVdVU1J8U19JUlVTUn0sCisjaWZkZWYgQ09ORklHX05GU0RfTEVHQUNZX0NMSUVOVF9UUkFD
S0lORwogCQlbTkZTRF9SZWNvdmVyeURpcl0gPSB7Im5mc3Y0cmVjb3ZlcnlkaXIiLCAmdHJhbnNh
Y3Rpb25fb3BzLCBTX0lXVVNSfFNfSVJVU1J9LAorI2VuZGlmCiAJCVtORlNEX1Y0RW5kR3JhY2Vd
ID0geyJ2NF9lbmRfZ3JhY2UiLCAmdHJhbnNhY3Rpb25fb3BzLCBTX0lXVVNSfFNfSVJVR099LAog
I2VuZGlmCiAJCS8qIGxhc3Qgb25lICovIHsiIn0KCgpNeSB1bmRlcnN0YW5kIG9mIHRoZSBzdGFi
aWxpdHkgcnVsZSBpcyAiaWYgTGludXMgZG9lc24ndCBoZWFyIGFib3V0IGl0LAp0aGVuIGl0IGlz
bid0IGEgcmVncmVzc2lvbiIuICBBbHNvIGtub3duIGFzICJubyBoYXJtLCBubyBmb3VsIi4KClNv
IGlmIHdlIG1hbmFnZSB0aGUgY2hhbmdlIHRvIGV2ZXJ5b25lJ3Mgc2F0aXNmYWN0aW9uLCB0aGVu
IGl0IGlzCnBlcmZlY3RseSBPSyB0byBtYWtlIHRoZSBjaGFuZ2UuICBuZnMtdXRpbHMgYWxyZWFk
eSBoYW5kbGVzIGEgbWlzc2luZwpmaWxlIGZhaXJseSB3ZWxsIC0geW91IGdldCBhIERfR0VORVJB
TCBsb2cgbWVzc2FnZSwgYnV0IHRoYXQgaXMgYWxsLgpQZXRyJ3MgZml4IGZvciBsdHAgc2hvdWxk
IGFsbG93IGl0IHRvIHdvcmsuICBJIHdvdWxkIGJlIGdyZWF0bHkKc3VycHJpc2VkIGlmIGFueXRo
aW5nIGVsc2UgKGV4Y2VwdCBwb3NzaWJseSBvdGhlciB0ZXN0aW5nIGNvZGUpIHdvdWxkCmNhcmUu
CgpOZWlsQnJvd24KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
