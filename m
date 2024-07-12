Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD3FC2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 09:22:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64ED33D1994
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 11:22:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEF523CB579
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 11:22:26 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D79DC1001126
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 11:22:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 80AB121A5C;
 Fri, 12 Jul 2024 09:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720776144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kP90YPsR62PT58PW4VXbKwa7h6P0DSDsZe2/FUKgJDw=;
 b=b0Rr8OzD/SVTKdOcGDlOmltEIROFRokXkoAA2ESQ/RaFd5P+IHwmUmnskI9N2qR3nApqJ5
 gPCALb4IeaZrup1y9pq2DXXeVEUUwF/N4Cp+uGmyZ8TWolUSmcB9ooT5tMa08LCpI0mQ3M
 zLzmy37yMpdHBC9VbiecuXlNifz2Uzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720776144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kP90YPsR62PT58PW4VXbKwa7h6P0DSDsZe2/FUKgJDw=;
 b=a1FWsvod3QQvgEPwu15Ttj+Ge0citb56TIql3tGp61l/EZ7Iq4QWUNAFTF9+Obn7ZLtQfh
 PvYAqj1qp7j9jiCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720776144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kP90YPsR62PT58PW4VXbKwa7h6P0DSDsZe2/FUKgJDw=;
 b=b0Rr8OzD/SVTKdOcGDlOmltEIROFRokXkoAA2ESQ/RaFd5P+IHwmUmnskI9N2qR3nApqJ5
 gPCALb4IeaZrup1y9pq2DXXeVEUUwF/N4Cp+uGmyZ8TWolUSmcB9ooT5tMa08LCpI0mQ3M
 zLzmy37yMpdHBC9VbiecuXlNifz2Uzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720776144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kP90YPsR62PT58PW4VXbKwa7h6P0DSDsZe2/FUKgJDw=;
 b=a1FWsvod3QQvgEPwu15Ttj+Ge0citb56TIql3tGp61l/EZ7Iq4QWUNAFTF9+Obn7ZLtQfh
 PvYAqj1qp7j9jiCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5395613686;
 Fri, 12 Jul 2024 09:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id beV5EtD1kGadFAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Jul 2024 09:22:24 +0000
Date: Fri, 12 Jul 2024 11:22:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240712092218.GA118354@pevik>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-5-c7b0e9edf9b0@suse.com>
 <20240711204007.GC85696@pevik>
 <CAEemH2fdFsQqN3a8sZ7+oeU7w3j+X7HdnGa=zC4H4+iXO9YUAw@mail.gmail.com>
 <CAEemH2eYZ05Fn0ZYhpG16UUzYo=F3GKBpYeRG_X2BUdrLbY8PA@mail.gmail.com>
 <20240712075758.GB103986@pevik>
 <CAEemH2dbmbFfxre-LbQ+ayf=dDbBD0sg1z4aec0oOu=Xnu9Enw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dbmbFfxre-LbQ+ayf=dDbBD0sg1z4aec0oOu=Xnu9Enw@mail.gmail.com>
X-Spamd-Result: default: False [0.50 / 50.00]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 05/11] Add landlock01 test
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

PiBIaSBQZXRyLAoKPiBPbiBGcmksIEp1bCAxMiwgMjAyNCBhdCAzOjU44oCvUE0gUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIEFuZHJlYSwgTGksCgo+ID4gLi4uCj4g
PiA+ID4+IEZpcnN0LCB0aGlzIGZhaWxzIGF0IGxlYXN0IG9uIHZhcmlvdXMga2VybmVsIHZlcnNp
b25zICh0ZXN0ZWQ6Cj4gPiBUdW1ibGV3ZWVkCj4gPiA+ID4+IDYuMTAuMC1yYzctMy5nOTJhYmMx
MC1kZWZhdWx0LCBhbmQgU0xFMTUtU1A0IDUuMTQuMjEgd2l0aAo+ID4gbHNtPWxhbmRsb2NrIGFu
ZAo+ID4gPiA+PiBEZWJpYW4gNi42LjE1LWFtZDY0KToKCj4gPiA+ID4+IGxhbmRsb2NrMDEuYzo0
OTogVEZBSUw6IFNpemUgaXMgdG9vIHNtYWxsIGV4cGVjdGVkIEVJTlZBTDogRU5PTVNHICg0MikK
Cj4gPiA+ID4+IElzIGl0IGEga2VybmVsIGJ1ZyBvciBhIHRlc3QgYnVnPwoKCj4gPiA+ID4gWW91
IHByb2JhYmx5IG5lZWQgdG8gY2hlY2sgdGhlIGAvdXNyL2luY2x1ZGUvbGludXgvbGFuZGxvY2su
aGAgaGVhZGVyCj4gPiBmaWxlCj4gPiA+ID4gZXhpc3QsCj4gPiA+ID4gYW5kIHRvIHNlZSBpZiAn
c3RydWN0IGxhbmRsb2NrX3J1bGVzZXRfYXR0cicgY29udGFpbnMgdGhlIG5ldyBmaWVsZAo+ID4g
PiA+ICdoYW5kbGVkX2FjY2Vzc19uZXQnLgoKPiA+ID4gPiBJZiBub3QgZXhpc3Qgb3IgZG9lcyBu
b3QgY29udGFpbiB0aGF0LCB0aGUgdGVzdCBkZWZpbmVzICdzdHJ1Y3QKPiA+ID4gPiBsYW5kbG9j
a19ydWxlc2V0X2F0dHInCj4gPiA+ID4gaW4gbGFwaS9sYW5kbG9jay5oIHdoaWNoIGNvbnRhaW5z
IGhhbmRsZWRfYWNjZXNzX25ldCBkaXJlY3RseSwgdGhpcyBpcwo+ID4gPiA+IGxpa2VseSB0aGUK
PiA+ID4gPiByb290IGNhdXNlIGxlYWQgdGVzdCBmYWlsZWQgb24geW91ciBib3guCgo+ID4gPiBB
bmQsIGlmIHRoZSBoZWFkZXIgZmlsZSBkb2VzIG5vdCBleGlzdCwgdGhlIG1hY3JvIGNvbmRpdGlv
biB3aWxsIGNob29zZQo+ID4gdG8KPiA+ID4gdXNlICdydWxlX3NpemUgLSAxJywKPiA+ID4gYW5k
IHRoYXQgY2F1c2VkIHRoZSBFTk9NU0cgZXJyb3IgZHVyaW5nIHRlc3Qgb24gdGhlIG5ld2VyIGtl
cm5lbC4KCj4gPiA+ICNpZmRlZiBIQVZFX1NUUlVDVF9MQU5ETE9DS19SVUxFU0VUX0FUVFJfSEFO
RExFRF9BQ0NFU1NfTkVUCj4gPiA+ICAgICBydWxlX3NtYWxsX3NpemUgPSBydWxlX3NpemUgLSBz
aXplb2YodWludDY0X3QpIC0gMTsKPiA+ID4gI2Vsc2UKPiA+ID4gICAgIHJ1bGVfc21hbGxfc2l6
ZSA9IHJ1bGVfc2l6ZSAtIDE7Cj4gPiA+ICNlbmRpZgoKPiA+ID4gU28gdG8ga2VlcCB0aGUga2Vy
bmVsLWhlYWRlcnMgYW5kIHJ1bm5pbmcga2VybmVsIHZlcnNpb24gY29uc2lzdGVudAo+ID4gc2hv
dWxkCj4gPiA+IGJlIHJlcXVpcmVkCj4gPiA+IGZvciB0aGUgbGFuZGxvY2swMSB0ZXN0LiBPdGhl
cndpc2UgdGhlICNpZmRlZiBwb3NzaWJseSB3b24ndCB3b3JrCj4gPiBjb3JyZWN0bHkuCgo+ID4g
RllJIEhhdmluZyBpbmNvbnNpc3RlbnQga2VybmVsIGhlYWRlcnMgYW5kIHJ1bm5pbmcga2VybmVs
IHdvdWxkIGJlIGEKPiA+IHByb2JsZW0gZm9yCj4gPiBtb3JlIExUUCB0ZXN0cyB0aGFuIGp1c3Qg
bGFuZGxvY2swMSAoYmFzaWNhbGx5IG1hbnkgdGVzdHMgd2hpY2ggaGF2ZQo+ID4gYXV0b3Rvb2xz
Cj4gPiBjaGVjaykuIEJ1dCB0aGlzIGNhbiBiZSBwcm9ibGVtYXRpYyBmb3Igc29tZSBkZXZlbG9w
bWVudCAoZS5nLiBsaW51eC1uZXh0KS4KPiA+IFRoZXJlZm9yZSB3ZSBhdCBsZWFzdCBhc3N1bWUg
VUFQSSBoZWFkZXJzIHNob3VsZG4ndCBiZSBuZXdlciB0aGFuIHJ1bm5pbmcKPiA+IGtlcm5lbCwg
c2VlIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC9aSlBfcVBlSjM3SDRxaEVOQHl1a2kvLgoK
Cj4gWWVzLCBJIGFncmVlIG9uIHRoaXMuCgo+IEFzIGxhbmRsb2NrMDEgdXNlcyB0aGUgbWFjcm8g
SSBwb2ludGVkIG91dCBpbiB0aGUgbGFzdCBlbWFpbCwKPiBpdCBpcyBhbG1vc3QgdW5hYmxlIHRv
IHNldCBhIGNvcnJlY3QgcnVsZV9zbWFsbF9zaXplIHcvbwo+IHZhcmlhbnRzIG9mIGtlcm5lbC1o
ZWFkZXJzLgoKPiBTbyBJIHN0aWxsIHRoaW5rIGp1c3Qgc2ltcGx5IHNldCB0aGUgJ3J1bGVfc21h
bGxfc2l6ZScgdG8gJ3NpemVvZihfX3U2NCkgLQo+IDE7Jwo+IHdpbGwgbWFrZSBsaWZlIGVhc2ll
ciBidXQgQW5kcmVhIGhhcyBhIGRpZmZlcmVudCBwZXJzcGVjdGl2ZSBvbiB0aGF0LgoKSXQgbG9v
a3MgdG8gbWUgYWxzbyBiZXR0ZXIsIGJ1dCBsZXQncyBhc2sgb3RoZXJzIDopLgpASmFuLCBAQ3ly
aWwgV0RZVD8KCj4gQW55d2F5LCBJIHdvdWxkIGxlYXZlIHRoaXMgdG8gQW5kcmVhIChhbiBleGNl
bGxlbnQgYmxhY2stYm94IHRlc3RlcikKPiBmb3IgbW9yZSBzdHJ1Z2dsaW5nLiBsb2x+CgpMb2wg
OikuCkkgc3VwcG9zZSB1c2Vyc3BhY2UgZGV2ZWxvcGVycyB3aGljaCB1c2UgcmF3IHN5c2NhbGxz
IGFyZSBvZnRlbiBmb3JjZWQgdG8KbG9vayBpbnRvIGtlcm5lbCBzb3VyY2VzIChtYW4gcGFnZXMg
YXJlIHNwYXJzZSkuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gPiA+IEkgZ3Vlc3Mgd2UgbWlnaHQg
aGF2ZSB0byByZXNvbHZlIHRoaXMgb24gdGhlIHRlc3Qgc2lkZS4KCj4gPiBUcnlpbmcgdG8gY29t
cGFyZSB2ZXJzaW9ucyA8bGludXgvdmVyc2lvbi5oPiBjb3VsZCBiZSB1c2VkOgoKPiA+ICNkZWZp
bmUgTElOVVhfVkVSU0lPTl9DT0RFIDM5NTAwOAo+ID4gI2RlZmluZSBLRVJORUxfVkVSU0lPTihh
LGIsYykgKCgoYSkgPDwgMTYpICsgKChiKSA8PCA4KSArICgoYykgPiAyNTUgPyAyNTUKPiA+IDog
KGMpKSkKPiA+ICNkZWZpbmUgTElOVVhfVkVSU0lPTl9NQUpPUiA2Cj4gPiAjZGVmaW5lIExJTlVY
X1ZFUlNJT05fUEFUQ0hMRVZFTCA3Cj4gPiAjZGVmaW5lIExJTlVYX1ZFUlNJT05fU1VCTEVWRUwg
MAoKPiA+IFdlIGFscmVhZHkgdXNlIEtFUk5FTF9WRVJTSU9OKCkgaW4ga2R1bXAgYW5kIGRldmlj
ZS1kcml2ZXJzIHRlc3RzLgoKCj4gSXQgY291bGQgd29yayBieSBhZGRpbmcgbW9yZSBrZXJuZWwg
anVkZ21lbnQgZm9yIHRoZSBtYWNybyBkZWZpbml0aW9uLAo+IGJ1dCBhIGxpdHRsZSBiaXQgb2Yg
YSBtZXNzIElNSE8uCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
