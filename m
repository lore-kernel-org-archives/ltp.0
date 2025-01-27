Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64D2C0218A
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 15:36:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C615B3C2C82
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 16:36:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07F843C2BA9
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 16:35:47 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 14A82226C53
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 16:35:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 54F452110B;
 Mon, 27 Jan 2025 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737992144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EZFcEJ/NgtHymI9kGja7YpNQRIIVv1plS4PGohigdE=;
 b=Bdg5Tii/nMj22jqL0ibaIowCa8AdXa/pezIOAvdYbBAcPDPQ+IFiXMOeyJ3TYsCLd6Qf8Z
 uHxcPA3CX2+H+iIyvocszi5rLu2LvSwZ/v2i53LGcdovmD+LA3Xj6YrlsGVtN+i+4UrQVZ
 vFVsg5PfjPE4SpySijIyWIOqdvVvL+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737992144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EZFcEJ/NgtHymI9kGja7YpNQRIIVv1plS4PGohigdE=;
 b=zyHrxawM5LwnCeGjBBwlheSaDZk7qQW5Rvw+W0VSd6Q/rMjO1eyQON5QxA6chGLPh44dcb
 Rpvyw6hbbkT+sPDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Bdg5Tii/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zyHrxawM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737992144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EZFcEJ/NgtHymI9kGja7YpNQRIIVv1plS4PGohigdE=;
 b=Bdg5Tii/nMj22jqL0ibaIowCa8AdXa/pezIOAvdYbBAcPDPQ+IFiXMOeyJ3TYsCLd6Qf8Z
 uHxcPA3CX2+H+iIyvocszi5rLu2LvSwZ/v2i53LGcdovmD+LA3Xj6YrlsGVtN+i+4UrQVZ
 vFVsg5PfjPE4SpySijIyWIOqdvVvL+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737992144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EZFcEJ/NgtHymI9kGja7YpNQRIIVv1plS4PGohigdE=;
 b=zyHrxawM5LwnCeGjBBwlheSaDZk7qQW5Rvw+W0VSd6Q/rMjO1eyQON5QxA6chGLPh44dcb
 Rpvyw6hbbkT+sPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FE36137C0;
 Mon, 27 Jan 2025 15:35:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /KorAtCnl2drWQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 Jan 2025 15:35:44 +0000
Date: Mon, 27 Jan 2025 16:35:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Alessandro Carminati <acarmina@redhat.com>
Message-ID: <20250127153542.GE265345@pevik>
References: <20250120102831.63646-1-acarmina@redhat.com>
 <20250120142447.GA812655@pevik>
 <CAGegRW5N42bbnG519VRMiK0Xc-jMMDMWK3DAcQiZhgOv3TT3NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGegRW5N42bbnG519VRMiK0Xc-jMMDMWK3DAcQiZhgOv3TT3NQ@mail.gmail.com>
X-Rspamd-Queue-Id: 54F452110B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,lists.linux.it,suse.com,suse.cz];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] sched/starvation: Add disclaimer for
 virtualized/emulated environments
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
Cc: ltp@lists.linux.it, Alessandro Carminati <alessandro.carminati@gmail.com>,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQWxlc3NhbmRybywKCj4gSGVsbG8gUGV0ciwKPiBUaGFua3MgYSBsb3QgZm9yIGhhdmluZyBz
aGFyZWQgeW91ciBwb3NpdGlvbiwgcGxlYXNlIHJlYWQgbWluZSBpbmxpbmUuCgo+IE9uIE1vbiwg
SmFuIDIwLCAyMDI1IGF0IDM6MjXigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3Jv
dGU6Cgo+ID4gSGkgQWxlc3NhbmRybywKCj4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIGRpc2NsYWlt
ZXIgbWVzc2FnZSB0byB0aGUgc3RhcnZhdGlvbiB0ZXN0IGNhc2UsIHdhcm5pbmcKPiA+ID4gdXNl
cnMgYWdhaW5zdCBydW5uaW5nIHRoZSB0ZXN0IGluIHZpcnR1YWxpemVkIG9yIGVtdWxhdGVkIGVu
dmlyb25tZW50cy4KPiA+ID4gVGhlIHRlc3QgcHJvZHVjZXMgZXhwZWN0ZWQgcmVzdWx0cyBvbmx5
IG9uIGJhcmUtbWV0YWwgc3lzdGVtcyBhbmQgaXMgcHJvbmUKPiA+ID4gdG8gZmFpbHVyZSB3aGVu
IGV4ZWN1dGVkIGluIG5vbi1iYXJlLW1ldGFsIHNldHVwcy4KCj4gPiA+IFdoaWxlIGRldGVjdGlu
ZyB2aXJ0dWFsaXphdGlvbiBvciBlbXVsYXRpb24gaXMgcG9zc2libGUgaW4gc29tZSBjYXNlcywK
PiA+ID4gdGhlIG1ldGhvZHMgYXJlIHVucmVsaWFibGUuCj4gPiA+IFJhdGhlciB0aGFuIGF0dGVt
cHRpbmcgdG8gcHJldmVudCB0aGUgdGVzdCBmcm9tIHJ1bm5pbmcgaW4gc3VjaAo+ID4gPiBlbnZp
cm9ubWVudHMsIHRoaXMgcGF0Y2ggcHJvdmlkZXMgYSB3YXJuaW5nIHRvIGluZm9ybSB1c2VycyBv
ZiB0aGUKPiA+ID4gbGltaXRhdGlvbnMuCgo+ID4gPiBDaGFuZ2U6Cj4gPiA+IC0gQWRkZWQgYSBU
SU5GTyBtZXNzYWdlIHRvIG5vdGlmeSB1c2VycyB0aGF0IHRoZSB0ZXN0IHNob3VsZCBiZSBydW4K
PiA+ID4gICBvbiBiYXJlLW1ldGFsIHN5c3RlbXMgZm9yIG1lYW5pbmdmdWwgcmVzdWx0cy4KCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IEFsZXNzYW5kcm8gQ2FybWluYXRpIDxhY2FybWluYUByZWRoYXQu
Y29tPgo+ID4gPiAtLS0KPiA+ID4gIHRlc3RjYXNlcy9rZXJuZWwvc2NoZWQvY2ZzLXNjaGVkdWxl
ci9zdGFydmF0aW9uLmMgfCAzICsrKwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKQoKPiA+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc2NoZWQvY2ZzLXNjaGVk
dWxlci9zdGFydmF0aW9uLmMgYi90ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2Nmcy1zY2hlZHVsZXIv
c3RhcnZhdGlvbi5jCj4gPiA+IGluZGV4IGM2MjBjOWMzZS4uYjc3OWE1ZjBhIDEwMDY0NAo+ID4g
PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2Nmcy1zY2hlZHVsZXIvc3RhcnZhdGlvbi5j
Cj4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2NoZWQvY2ZzLXNjaGVkdWxlci9zdGFydmF0
aW9uLmMKPiA+ID4gQEAgLTExNSw2ICsxMTUsOSBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+
ID4gPiAgICAgICBpZiAodHN0X2hhc19zbG93X2tjb25maWcoKSkKPiA+ID4gICAgICAgICAgICAg
ICB0c3RfYnJrKFRDT05GLCAiU2tpcCB0ZXN0IGR1ZSB0byBzbG93IGtlcm5lbCBjb25maWd1cmF0
aW9uIik7Cgo+ID4gPiArICAgICB0c3RfcmVzKFRJTkZPLCAiVGhpcyB0ZXN0IGlzIGRlc2lnbmVk
IHRvIHJ1biBvbiBiYXJlLW1ldGFsIHN5c3RlbXMuICIKPiA+ID4gKyAgICAgICAgICAgICAiUnVu
bmluZyBpdCBpbiBhIHZpcnR1YWxpemVkIG9yIGVtdWxhdGVkIGVudmlyb25tZW50IG1heSBwcm9k
dWNlIHVucmVsaWFibGUgcmVzdWx0cy4iKTsKCj4gPiBXZSBzaG91bGQgYXQgbGVhc3Qgd3JhcCBp
dCB3aXRoIHRzdF9pc192aXJ0KCksIG1ha2UgaXQgc2hvcnRlciBhbmQgYWRkIFdBUk5JTkc6Cgo+
ID4gICAgICAgICBpZiAodHN0X2lzX3ZpcnQoVklSVF9BTlkpKQo+ID4gICAgICAgICAgICAgICAg
IHRzdF9yZXMoVElORk8sICJXQVJOSU5HOiBSdW5uaW5nIG9uIGEgdmlydHVhbGl6ZWQgb3IgZW11
bGF0ZWQgZW52aXJvbm1lbnQgbWF5IHByb2R1Y2UgdW5yZWxpYWJsZSByZXN1bHRzIik7Cgo+ID4g
QnV0IE9UT0ggSSBoYXZlbid0IHNlZW4gYW55IHByb2JsZW0gd2l0aCBpdCBvbiB2YXJpb3VzIFNM
RVMgdmVyc2lvbnMgbm9yIGluCj4gPiBvcGVuU1VTRSBUdW1ibGV3ZWVkICh3aGljaCB1c2VzIGxh
dGVzdCBtYWlubGluZSBrZXJuZWwpLiBUaGVyZWZvcmUgSSB3b3VsZCBub3QKPiA+IHB1dCBUQ09O
RiwgYnV0IGp1c3QgVElORk8gYXMgeW91IHN1Z2dlc3RlZCAob3RoZXIgdGVzdHMgd2hpY2ggdXNl
IHRzdF9pc192aXJ0KCkKPiA+IGRldGVjdGlvbiB1c3VhbGx5IGRvIFRDT05GKS4KCj4gSSB1bmRl
cnN0YW5kIHRoZSBzdWdnZXN0aW9uIHRvIHdyYXAgdGhlIHRlc3Qgd2l0aCB0c3RfaXNfdmlydCgp
IGFuZCBpbmNsdWRlCj4gYSB3YXJuaW5nLCBidXQgSSBoYXZlIHNvbWUgcmVzZXJ2YXRpb25zIHJl
Z2FyZGluZyB0aGUgZWZmZWN0aXZlbmVzcyBvZiB0aGUKPiB2aXJ0dWFsaXphdGlvbiBjaGVjayBp
biBMVFAuIEhlcmUncyBteSBwZXJzcGVjdGl2ZToKCj4gMS4gRWZmZWN0aXZlbmVzcyBvZiB0aGUg
VmlydHVhbGl6YXRpb24gQ2hlY2s6IFdoaWxlIEkgYW0gYXdhcmUgb2YgdGhlCj4gICAgZXhpc3Rp
bmcgdmlydHVhbGl6YXRpb24gZGV0ZWN0aW9uIG1lY2hhbmlzbSBpbiBMVFAsIEkgYmVsaWV2ZSBp
dCBpcwo+ICAgIG5vdCBzdWZmaWNpZW50bHkgcm9idXN0IHRvIHJlbGlhYmx5IGlkZW50aWZ5IHZp
cnR1YWxpemVkIGVudmlyb25tZW50cwo+ICAgIGFjcm9zcyBhbGwgc2NlbmFyaW9zLgoKPiAyLiBT
eXN0ZW1kLWJhc2VkIERldGVjdGlvbjogVGhlIHN5c3RlbWQgaW1wbGVtZW50YXRpb24gdXNlZCBp
biBMVFAgaXMKPiAgICBpbXByZXNzaXZlbHkgYWNjdXJhdGUgYW5kIG9mdGVuIHN1Y2NlZWRzIGlu
IGRldGVjdGluZyB2aXJ0dWFsaXplZCBvcgo+ICAgIGVtdWxhdGVkIGVudmlyb25tZW50cy4gSG93
ZXZlciwgTFRQIGNhbm5vdCByZWFzb25hYmx5IGFzc3VtZSB0aGUKPiAgICBwcmVzZW5jZSBvZiBz
eXN0ZW1kIG9uIGV2ZXJ5IHN5c3RlbS4KCkkgd29uZGVyIHdoZXRoZXIgTGluYXJvIG9yIG90aGVy
IGVtYmVkZGVkIGZvbGtzIHVzZSBkaXN0cm9zIHdpdGhvdXQgc3lzdGVtZC4KU28gZmFyIG5vYm9k
eSBjb21wbGFpbmVkLiBGWUkgd2UgaGF2ZSBpbiBzaGVsbCBBUEkgbm9uLXN5c3RlbWQgY29kZSAo
aW4KdGVzdGNhc2VzL2xpYi9kYWVtb25saWIuc2gpIGJ1dCBJIGRvdWJ0IGFueWJvZHkgaXMgdXNp
bmcgaXQuCkJ1dCBpZiB5ZXMsIHRoZXJlIGFyZSA1IHRlc3RzIHdoaWNoIGRlcGVuZHMgb24gaXQg
d29ya2luZywgaXQgd291bGQgYmUgdGhlbgp3b3J0aCB0byBmaXggaXQuCgpJZiByZWFsbHkgbmVl
ZHMgdG8gYmUgZml4ZWQgdGhlcmUgY291bGQgYmUgd2F5czoKCnJlYWQgL3N5cy9kZXZpY2VzL3Zp
cnR1YWwvZG1pL2lkL3N5c192ZW5kb3IgY29udGVudCAocmVxdWlyZXMgQ09ORklHX0RNSUlEPXks
IEkKZ3Vlc3MgKS4KJCBjYXQgL3N5cy9kZXZpY2VzL3ZpcnR1YWwvZG1pL2lkL3N5c192ZW5kb3IK
Ck9yIHVzZSBzb21lIGNvZGUgZnJvbSBsc2NwdToKaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL3V0aWxzL3V0aWwtbGludXgvdXRpbC1saW51eC5naXQvdHJlZS9zeXMtdXRpbHMvbHNjcHUt
dmlydC5jCihjcHVpZCBvciBkbWkpCgpvciBzeXN0ZW1kIGNvZGU6Cmh0dHBzOi8vZ2l0aHViLmNv
bS9zeXN0ZW1kL3N5c3RlbWQvdHJlZS9tYWluL3NyYy9iYXNpYy92aXJ0LmMKCm9yIGZyb20gdmly
dC13aGF0OiBodHRwOi8vZ2l0LmFubmV4aWEub3JnLz9wPXZpcnQtd2hhdC5naXQ7YT1zdW1tYXJ5
CgpvciBqdXN0IGxvb2tpbmcgYXQgdmlydGlvIGRpc2MKJCBscyAtMSAvZGV2L2Rpc2svYnktcGF0
aC8gfGdyZXAgdmlydGlvCnZpcnRpby1wY2ktMDAwMDowNDowMC4wCnZpcnRpby1wY2ktMDAwMDow
NDowMC4wLXBhcnQxCnZpcnRpby1wY2ktMDAwMDowNDowMC4wLXBhcnQyCgpBbHNvIG91ciBtYWNo
aW5lcyBsb2FkcyBxZW11X2Z3X2NmZyBrZXJuZWwgbW9kdWxlLgoKPiAgICBGb3IgZXhhbXBsZSwg
ZW1iZWRkZWQgc3lzdGVtcyBzdWNoIGFzIE9wZW5XcnQgdHlwaWNhbGx5IG5vdCB1c2VzCj4gICAg
c3lzdGVtZCBmcm9tIHRoZWlyIGRpc3RyaWJ1dGlvbnMsIG1ha2luZyB0aGlzIGFwcHJvYWNoIGxl
c3MKPiAgICB1bml2ZXJzYWxseSBhcHBsaWNhYmxlLgoKSSB3b25kZXIgaWYgYW55Ym9keSBmcm9t
IE9wZW5XcnQgZm9sa3MgYWN0dWFsbHkgdGVzdHMgdGhlIGNvZGUuCgo+IDMuIExUUCdzIEJ1aWx0
LWluIEZ1bmN0aW9uczogVGhlIGZ1bmN0aW9ucyB3aXRoaW4gTFRQIGZvciBkZXRlY3RpbmcKPiAg
ICB2aXJ0dWFsaXphdGlvbiwgc3VjaCBhcyBpc19rdm0sIGFyZSBzaWduaWZpY2FudGx5IGxlc3Mg
cmVsaWFibGUuCj4gICAgRm9yIGluc3RhbmNlLCBpc19rdm0gcmVsaWVzIG9uIGRldGVjdGluZyAi
UUVNVSIgaW4gdGhlIGNwdWluZm8KPiAgICBzdHJpbmcsIHdoaWNoIGlzIG9mdGVuIG5vdCBwcmVz
ZW50IGluIG1hbnkgcHJhY3RpY2FsIHNjZW5hcmlvcy4KPiAgICBUaGlzIGxpbWl0YXRpb24gYmVj
b21lcyBwYXJ0aWN1bGFybHkgYXBwYXJlbnQgaW4gbXkgdHlwaWNhbCB1c2UKPiAgICBjYXNlLCB3
aGVyZSBJIHRlc3Qga2VybmVscyBpbiBhbiBlbXVsYXRlZCBBQXJjaDY0IFFFTVUgZW52aXJvbm1l
bnQuCgpZZXMsIHdlIGhhdmUgaW4gYWFyY2g2NCBvcGVuU1VTRQpCSU9TIFZlbmRvciBJRDogICAg
ICAgICAgICAgICAgICAgICAgIFFFTVUKCmJ1dCBub3QgaW4gcmlzY3Y2NC4KCj4gU3VnZ2VzdGlv
bnM6Cj4gVG8gbWluaW1pemUgY2hhbmdlcyB3aGlsZSBzdGlsbCBhZGRyZXNzaW5nIHRoaXMgaXNz
dWUsIEkgcHJvcG9zZSBhZGRpbmcKPiBhIGRpc2NsYWltZXIgaW4gdGhlIHRlc3Qgb3V0cHV0LCBy
ZWdhcmRsZXNzIG9mIGRldGVjdGlvbi4KPiBUaGlzIHdheSwgdXNlcnMgcmV2aWV3aW5nIHRoZSBy
ZXN1bHRzIGFyZSBhdCBsZWFzdCBpbmZvcm1lZCBhYm91dCB0aGUKPiBwb3RlbnRpYWwgaW1wYWN0
IG9mIHZpcnR1YWxpemF0aW9uIG9uIHRlc3QgcmVsaWFiaWxpdHkuCgo+IElmIG1vcmUgZXh0ZW5z
aXZlIGNoYW5nZXMgYXJlIGZlYXNpYmxlLCBJIHN1Z2dlc3QgaW1wcm92aW5nIHRoZSBMVFAKPiBk
ZXRlY3Rpb24gZnVuY3Rpb25zLgo+IFNwZWNpZmljYWxseToKPiAqIEZvciBub24teDg2IHN5c3Rl
bXMsIGludHJvZHVjZSBhIG1lY2hhbmlzbSBiYXNlZCBvbiBkZXZpY2UtdHJlZQo+ICAgZGV0ZWN0
aW9uLCBhcyB0aGlzIGNhbiBwcm92aWRlIG1vcmUgYWNjdXJhdGUgcmVzdWx0cyBmb3IgYXJjaGl0
ZWN0dXJlcwo+ICAgIGxpa2UgQUFyY2g2NC4KCkZlZWwgZnJlZSB0byBzZW5kIGEgcGF0Y2guIERl
dmljZSB0cmVlIGlzIHVzZWQgaW4gcXVpdGUgYSBsb3Qgb2YgYXJjaHMuCkkgd291bGQgYWN0dWFs
bHkgZ28gd2l0aCBkZXRlY3Rfdm1fZGV2aWNlX3RyZWUoKSBjb2RlIGZyb20gc3lzdGVtZC4KCj4g
KiBGb3IgeDg2IHN5c3RlbXMsIHV0aWxpemUgRE1JLWJhc2VkIGRldGVjdGlvbiwgYXMgdGhlIHN0
YW5kYXJkaXplZAo+ICAgZmlybXdhcmUgaW50ZXJmYWNlcyBpbiB4ODYgbWFrZSBETUkgYSByZWxp
YWJsZSBtZXRob2QuCgo+ID4gQW55IGlkZWEgd2hhdCBjYW4gY2F1c2UgaW5zdGFiaWxpdHkgb24g
dmlydHVhbGl6ZWQgZW52aXJvbm1lbnRzPyBXaGljaCBrZXJuZWwKPiA+IG9wdGlvbnMgY291bGQg
YmUgYWZmZWN0ZWQ/Cgo+IEFzIG1lbnRpb25lZCBlYXJsaWVyLCBJIGhhdmUgZW5jb3VudGVyZWQg
dGhpcyBpc3N1ZSBpbiBteSB0eXBpY2FsIHRlc3QKPiBlbnZpcm9ubWVudC4gSSBwcmltYXJpbHkg
d29yayB3aXRoIGFhcmNoNjQgcGxhdGZvcm1zLgo+IFdoaWxlIG15IGNvbXBhbnkgcHJvdmlkZXMg
YWNjZXNzIHRvIGxhcmdlIEFSTTY0IHNlcnZlcnMsIHRoZXNlIGFyZSBzaGFyZWQKPiByZXNvdXJj
ZXMuCj4gQ29uc2VxdWVudGx5LCBJIG5lZWQgdG8gcHJlcGFyZSB0aGUgc2VydmVycyBlYWNoIHRp
bWUgSSB1c2UgdGhlbS4KCj4gVG8gbWFrZSBteSB3b3JrZmxvdyBmYXN0ZXIsIG15IGluaXRpYWwg
dGFyZ2V0IGZvciB0ZXN0aW5nIGlzIGFuIGVtdWxhdGVkCj4gYWFyY2g2NCBlbnZpcm9ubWVudCBy
dW5uaW5nIG9uIHg4NiBtYWNoaW5lcy4gVGhpcyBpcyBmb2xsb3dlZCBieSB2YWxpZGF0aW9uCj4g
b24gYSBzbWFsbCBuYXRpdmUgQUFyY2g2NCBtYWNoaW5lIHNpdHRpbmcgaW4gbXkgbGFiLCB3aGlj
aCBpcyBiYXNlZCBvbiB0aGUKPiBpbmV4cGVuc2l2ZSBSSzM2ODguCgo+IFJlZ2FyZGluZyB0aGUg
aXNzdWUsIEkgaGF2ZSBvYnNlcnZlZCBjb25zaXN0ZW50IHRlc3QgZmFpbHVyZXMgb24gdGhlCj4g
ZW11bGF0ZWQgbWFjaGluZSwgd2hpbGUgb24gdGhlIG5hdGl2ZSBhYXJjaDY0IHZpcnR1YWxpemVk
IEtWTSBzZXR1cCwgdGhlCj4gZmFpbHVyZXMgb2NjdXIgYXBwcm94aW1hdGVseSAxIGluIDEwIHRp
bWVzLgo+IEltcG9ydGFudGx5LCBJIGhhdmUgbmV2ZXIgb2JzZXJ2ZWQgdGhpcyBpc3N1ZSBvbiBi
YXJlIG1ldGFsIHN5c3RlbXMuCgo+IEFsdGhvdWdoIEkgc3VzcGVjdCB0aGF0IHRoaXMgcHJvYmxl
bSBtaWdodCBiZSBsZXNzIHByb25vdW5jZWQgb24gbGFyZ2UKPiBhYXJjaDY0IHNlcnZlcnMgd2l0
aCBhIGhpZ2hlciBjb3JlIGNvdW50LCBJIGJlbGlldmUgdGhpcyBiZWhhdmlvciBpcwo+IHNpZ25p
ZmljYW50IGVub3VnaC4KClRoYW5rcyBmb3IgYSBkZXRhaWxlZCBleHBsYW5hdGlvbi4gSSB3b25k
ZXIgd2hhdCByZXNvdXJjZSBpcyBtaXNzaW5nIG9uIGFhcmNoNjQKb3Igd2hhdCBrZXJuZWwgY29u
ZmlnIGNhdXNlcyBpdCwgYmVjYXVzZSBpdCB3b3JrcyB3ZWxsIG9uIG91ciB2aXJ0dWFsaXplZAph
YXJjaDY0IChiZXR0ZXIgc2F5IHdvcmtlZCB3ZWxsLCBiZWNhdXNlIG5vdyBpdCdzIHNraXBwZWQg
YnkKQ09ORklHX0ZBVUxUX0lOSkVDVElPTiAtIElNSE8gdGhlcmUgc2hvdWxkIGJlIG1vcmUgcHJl
Y2lzZSBzbG93IGtlcm5lbCBkZXRlY3Rpb24pLgoKS2luZCByZWdhcmRzLApQZXRyCgo+ID4gQVRN
IHRlc3QgaXMgZGlzYWJsZWQgZHVlIHNsb3cga2VybmVsIGNvbmZpZyBkZXRlY3Rpb24KPiA+IG9u
IFNMRVMvVHVtYmxld2VlZCAobm9uLVJULCB0ZXN0ZWQgb24gcWVtdSkgd2hlcmUgaXQncyB3b3Jr
aW5nIGFuZCB0aGlzIGlzIG5vdAo+ID4gZW5vdWdoIHRvIGRldGVjdCB1bnN0YWJsZSByZXN1bHRz
IG9uIHRoZSBrZXJuZWxzIHlvdSB0ZXN0LgoKPiA+IEkgYWxzbyBzZW5kIGEgcGF0Y2ggdG8gcmVt
b3ZlIENPTkZJR19MQVRFTkNZVE9QIGFzIG9wdGlvbiBjYXVzaW5nIHNsb3cga2VybmVsLgoKPiA+
IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
