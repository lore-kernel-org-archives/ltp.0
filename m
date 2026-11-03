Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E9606A32C
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GY6QbAtO;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GDIhg+Fl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=pc021PE1;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JugSFCPy
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EA8B3CA2C1
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 20:44:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E005C3C8315
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 20:44:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E511A60069D
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 20:44:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 051FF221E6;
 Tue,  3 Nov 2026 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793735056;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWeycMWKZzCjcs6k7qwUpq9mnoE4seXnwQZ/y+oThaA=;
 b=GY6QbAtOYPCikbYiGUcGo593ZxB7uQ29zHwHbXawmTn6l4nkt+h8VLUot2m/7YlT/QMx00
 tW3Au2H+nAQbY90J+c0hGyOwgkgMbg0Kgm8oBXOsNP6Qt31XwOMb1I9qF1XK07f3YkbiAi
 WAAf5lt3usR2PxyUw0yfGTuTIMbtROs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793735056;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWeycMWKZzCjcs6k7qwUpq9mnoE4seXnwQZ/y+oThaA=;
 b=GDIhg+FlkGsNzlhr6plPjdXPPnNbxJt/i9LZw/nLgdB9QzDQDKadExFv0eVnbG8uXjmtmh
 i1qLz0T/CULQE+BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793735055;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWeycMWKZzCjcs6k7qwUpq9mnoE4seXnwQZ/y+oThaA=;
 b=pc021PE1a0SID1GBuA0qlvSUGAKCL3mNwLveExAK24MkeP/pPhz7QgSFMtaz6v5byQmwCs
 DXhhd+plzvSt8lldV6Yu9f55UxxYXXjHxhF1ysGR36CGinRax/Twx2SbskRnSLSMtrI+1s
 s9r8SFGCjJZgLTFQNa5AgmZAlN2aUJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793735055;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWeycMWKZzCjcs6k7qwUpq9mnoE4seXnwQZ/y+oThaA=;
 b=JugSFCPypQyU8eqHtu1SAGwDRGDvG71cS2jOmikj+DkIotmiDmDB3tD9V2afth6FUn9B4Y
 /6cJpSvNLs5iBDBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAE4F1350A;
 Tue,  3 Nov 2026 19:44:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IdRsH4456mqjSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Nov 2026 19:44:14 +0000
Date: Tue, 3 Nov 2026 20:44:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20261103194409.GB119931@pevik>
References: <P5WKBbq--F-9@tuta.io>
 <CAOQ4uxiDYt9HtpZ7XDHdYJZKfPo0ACT4bOXKfGTwPe0WXsmNLQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiDYt9HtpZ7XDHdYJZKfPo0ACT4bOXKfGTwPe0WXsmNLQ@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-16.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[tuta.io:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -16.50
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify26: Add cases that list the
 directory
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Edvard Conrad <edvard@tuta.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgRWR2YXJkLCBBbWlyLAoKVEw7RFI6IG1lcmdlZCwgdGhhbmsgeW91LiBGZXcgbm90ZXMgYmVs
b3cuCgo+IE9uIFR1ZSwgTm92IDMsIDIwMjYgYXQgMToxNOKAr1BNIEVkdmFyZCBDb25yYWQgPGVk
dmFyZEB0dXRhLmlvPiB3cm90ZToKCj4gPiBMaXN0aW5nIGEgZGlyZWN0b3J5IHRocm91Z2ggdGhl
IGV2ZW50IGZpbGUgZGVzY3JpcHRvciBtYWtlcyBvdmVybGF5ZnMKPiA+IG9wZW4gaXRzIGxheWVy
cyBhZ2FpbiwgYWZ0ZXIgdGhlIGV2ZW50IGZkIGV4aXN0czogZXZlcnkgbGF5ZXIgb2YgYQo+ID4g
bWVyZ2VkIGRpcmVjdG9yeSBpbiBvdmxfZGlyX3JlYWRfbWVyZ2VkKCksIGFuZCB0aGUgdXBwZXIg
ZGlyZWN0b3J5IG9mCj4gPiBhbiBpbXB1cmUgb25lIGluIG92bF9kaXJfcmVhZF9pbXB1cmUoKS4g
VW5sZXNzIHRob3NlIG9wZW5zIGluaGVyaXQKPiA+IEZNT0RFX05PTk9USUZZIGZyb20gdGhlIGV2
ZW50IGZkLCBhIGxpc3RlbmVyIHRoYXQgbWFya3MgdGhlIGJhY2tpbmcKPiA+IGZpbGVzeXN0ZW0g
YW5kIGxpc3RzIHRoZSBkaXJlY3RvcnkgYmVmb3JlIGl0IGFuc3dlcnMgaXMgc2VudCBhIG5lc3Rl
ZAo+ID4gcGVybWlzc2lvbiBldmVudCBhbmQgYmxvY2tzIGluIGdldGRlbnRzNjQoKS4KCj4gPiBB
ZGQgYSBjYXNlIGZvciBlYWNoLiBUaGUgaW1wdXJlIGRpcmVjdG9yeSBpcyBtYWRlIGJ5IHJlbmFt
aW5nIGEgbG93ZXIKPiA+IGZpbGUgaW50byBhIGRpcmVjdG9yeSBjcmVhdGVkIG9uIHRoZSBvdmVy
bGF5LiBUaGUgY2FzZSByZXBvcnRzIFRDT05GCj4gPiB3aGVuIHRoZSBvdmVybGF5IGNhbm5vdCBy
ZWNvcmQgdGhlIGZpbGUncyBvcmlnaW4gYW5kIHNvIGRvZXMgbm90IG1hcmsKInRoZSBvdmVybGF5
IGNhbm5vdCByZWNvcmQgdGhlIGZpbGUncyBvcmlnaW4iOiBJJ20ganVzdCBjdXJpb3VzIGhvdyB0
aGlzIGNhbgpoYXBwZW4uIE9idmlvdXNseSBpdCdzIG5vdCBhIG1pc3Rha2Ugd2hlbiB5b3UgY2hv
c2UgVENPTkYuCgo+ID4gdGhlIGRpcmVjdG9yeSBpbXB1cmUuIFRoZSBpbXB1cmUgbGlzdGluZyBp
cyBjYWNoZWQgd2l0aCB0aGUgaW5vZGUsIHNvCgo+ID4gdGhlIGNhc2UgbW92ZXMgdGhlIGVudHJ5
IG91dCBhbmQgYmFjayBmaXJzdDsgb3RoZXJ3aXNlIGEgbGF0ZXIKPiA+IGl0ZXJhdGlvbiB3b3Vs
ZCByZWFkIHRoZSBjYWNoZSBpbnN0ZWFkIG9mIHRoZSBsYXllci4KCj4gPiBCb3RoIGNhc2VzIGZh
aWwgb24gYSBrZXJuZWwgd2l0aG91dCB0aGUgcGVuZGluZyBvdmVybGF5ZnMgZml4IGZvcgo+ID4g
ZGlyZWN0b3J5IG9wZW5zLgoKPiA+IFNpZ25lZC1vZmYtYnk6IEVkdmFyZCBDb25yYWQgPGVkdmFy
ZEB0dXRhLmlvPgo+ID4gLS0tCj4gPiBBcHBsaWVzIG9uIHRvcCBvZiAic3lzY2FsbHMvZmFub3Rp
ZnkyNjogQWRkIGRpcmVjdG9yeSBjYXNlcyBmb3IgdGhlCj4gPiBuZXN0ZWQgZXZlbnQiOgo+ID4g
ICBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvUDVJbnk0MS0tRi05QHR1dGEuaW8vCgo+ID4g
QXNrZWQgZm9yIGJ5IEFtaXIgb24gdGhlIGtlcm5lbCB0aHJlYWQsIHdoZXJlIGJvdGggcGF0aHMg
Y2FtZSB1cDoKPiA+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBT1E0dXhoNjcrdnMw
bXItTHhtd3o5LU4rRjhtMjlXVU56KzhxRkxMRHBPVllCNz12Z0BtYWlsLmdtYWlsLmNvbS8KCisx
Cgo+ID4gVGVzdGVkIGluIGEgVk0gb24gNmI0YjU0M2ZhMTgsIGVhY2gga2VybmVsIHJ1biBvbmNl
IGFuZCB3aXRoIC1pIDIsCj4gPiB3aXRoIHRoZSBiYWNraW5nIGZpbGVzeXN0ZW0gbWFya2VkOgoK
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsZSAgZGlyICAgbWVyZ2VkIGRp
ciAgaW1wdXJlIGRpcgo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBsaXN0ZWQgICAgICBsaXN0ZWQKPiA+ICAgbm8gZml4ICAgICAgICAgICAgICAgICAgICAg
ICAgRkFJTCAgRkFJTCAgRkFJTCAgICAgICAgRkFJTAo+ID4gICArIGMzZDM1NWY0MjdjZSAgICAg
ICAgICAgICAgICBQQVNTICBGQUlMICBGQUlMICAgICAgICBGQUlMCj4gPiAgICsgb3ZsIGRpcmVj
dG9yeSBmaXgsIHYxICAgICAgIFBBU1MgIFBBU1MgIEZBSUwgICAgICAgIEZBSUwKPiA+ICAgKyBv
dmwgZGlyZWN0b3J5IGZpeCwgdjIgICAgICAgUEFTUyAgUEFTUyAgUEFTUyAgICAgICAgRkFJTAo+
ID4gICArIHYyIGFuZCB0aGUgZm9sbG93LXVwIG9uICAgICBQQVNTICBQQVNTICBQQVNTICAgICAg
ICBQQVNTCj4gPiAgICAgdGhlIGtlcm5lbCB0aHJlYWQKCisxLiBTbyB0aGVyZSB3aWxsIGJlIDIg
a2VybmVsIGZpeGluZyBjb21taXRzLgoKPiA+IFRoZSBvdmVybGF5LW9ubHkgY2FzZXMgcGFzcyBv
biBhbGwgb2YgdGhlbS4gV2l0aG91dCB0aGUgZml4IHRoZSBpbXB1cmUKPiA+IGNhc2UgZmFpbHMg
aW4gYm90aCBpdGVyYXRpb25zIG9mIC1pIDIsIHdoaWNoIGlzIHdoYXQgbW92aW5nIHRoZSBlbnRy
eQo+ID4gb3V0IGFuZCBiYWNrIGlzIGZvci4KLi4uCj4gPiAgLi4uL2tlcm5lbC9zeXNjYWxscy9m
YW5vdGlmeS9mYW5vdGlmeTI2LmMgICAgIHwgOTIgKysrKysrKysrKysrKysrKy0tLQo+ID4gIC8q
Cj4gPiAgICogVGhlIGxpc3RlbmVyIGVpdGhlciBhbnN3ZXJzIHRoZSBldmVudCBhdCBvbmNlIG9y
IGlzIGJsb2NrZWQgZm9yIGdvb2QsIHNvCj4gPiBAQCAtNTYsMTkgKzc0LDQxIEBACj4gPiAgI2Rl
ZmluZSBXQUlUX01TRUMgICAgICA1MDAwCgo+ID4gIHN0YXRpYyBpbnQgZmRfbm90aWZ5ID0gLTE7
Cj4gPiArc3RhdGljIGludCBpZGlyX2lzX2ltcHVyZTsKCj4gPiAgc3RhdGljIHN0cnVjdCB0Y2Fz
ZSB7Cj4gPiAgICAgICAgIGNvbnN0IGNoYXIgKnRuYW1lOwo+ID4gKyAgICAgICBjb25zdCBjaGFy
ICpwYXRoOwo+ID4gICAgICAgICBpbnQgbWFya19iYWNraW5nOwo+ID4gICAgICAgICBpbnQgb25k
aXI7Cj4gPiArICAgICAgIGludCBsaXN0Owo+ID4gKyAgICAgICBpbnQgaW1wdXJlOwo+ID4gIH0g
dGNhc2VzW10gPSB7Cj4gPiAtICAgICAgIHsiT3ZlcmxheSBtYXJrLCBmaWxlIiwgMCwgMH0sCj4g
PiAtICAgICAgIHsiT3ZlcmxheSBhbmQgYmFja2luZyBtYXJrLCBmaWxlIiwgMSwgMH0sCj4gPiAt
ICAgICAgIHsiT3ZlcmxheSBtYXJrLCBkaXJlY3RvcnkiLCAwLCAxfSwKPiA+IC0gICAgICAgeyJP
dmVybGF5IGFuZCBiYWNraW5nIG1hcmssIGRpcmVjdG9yeSIsIDEsIDF9LAo+ID4gKyAgICAgICB7
Ik92ZXJsYXkgbWFyaywgZmlsZSIsIE9WTF9GSUxFLCAwLCAwLCAwLCAwfSwKPiA+ICsgICAgICAg
eyJPdmVybGF5IGFuZCBiYWNraW5nIG1hcmssIGZpbGUiLCBPVkxfRklMRSwgMSwgMCwgMCwgMH0s
Cj4gPiArICAgICAgIHsiT3ZlcmxheSBtYXJrLCBkaXJlY3RvcnkiLCBPVkxfRElSLCAwLCAxLCAw
LCAwfSwKPiA+ICsgICAgICAgeyJPdmVybGF5IGFuZCBiYWNraW5nIG1hcmssIGRpcmVjdG9yeSIs
IE9WTF9ESVIsIDEsIDEsIDAsIDB9LAo+ID4gKyAgICAgICB7Ik92ZXJsYXkgYW5kIGJhY2tpbmcg
bWFyaywgbWVyZ2VkIGRpcmVjdG9yeSwgbGlzdGVkIiwKPiA+ICsgICAgICAgIE9WTF9NRElSLCAx
LCAxLCAxLCAwfSwKPiA+ICsgICAgICAgeyJPdmVybGF5IGFuZCBiYWNraW5nIG1hcmssIGltcHVy
ZSBkaXJlY3RvcnksIGxpc3RlZCIsCj4gPiArICAgICAgICBPVkxfSURJUiwgMSwgMSwgMSwgMX0s
Cj4gPiAgfTsKCm5pdDogSSB1c3VhbGx5IHByZWZlciBkZXNpZ25hdGVkIGluaXRpYWxpemVycyBp
bnN0ZWFkIG9mIGxpc3Qgb2YgMCBvciAxCihyZWFkYWJpbGl0eSksIGJ1dCB0aGF0J3Mgb2suCgou
Li4KPiBMb29rcyBnb29kIQoKPiBPbmx5IHByb2JsZW0gSSBnb3Q6Cgo+IHRzdF9zdXBwb3J0ZWRf
ZnNfdHlwZXMuYzo2NzogVElORk86IG1rZnMuZXh0MiBkb2VzIGV4aXN0Cj4gdHN0X3Rlc3QuYzox
MzA1OiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xvb3AwIHdpdGggZXh0MiBvcHRzPScnIGV4dHJh
IG9wdHM9JycKPiBta2UyZnMgMS40Ny4yICgxLUphbi0yMDI1KQo+IFsgIDEwNy4yNzExMDVdIG9w
ZXJhdGlvbiBub3Qgc3VwcG9ydGVkIGVycm9yLCBkZXYgbG9vcDAsIHNlY3RvciA2MTQyNzIKPiBv
cCAweDk6KFdSSVRFX1pFUk9FUykgZmxhZ3MgMHgyMDgwMDgwMCBwaHlzX3NlZyAwIHByaW8gY2xh
c3MgMgo+IHRzdF90ZXN0LmM6MTMxNzogVElORk86IE1vdW50aW5nIC9kZXYvbG9vcDAgdG8KPiAv
dG1wL0xUUF9mYW5mSDdkV3IvbW50cG9pbnQgZnN0eXA9ZXh0MiBmbGFncz0wCj4gWyAgMTA3LjM1
OTM5MV0gZXh0MiBmaWxlc3lzdGVtIGJlaW5nIG1vdW50ZWQgYXQKPiAvdG1wL0xUUF9mYW5mSDdk
V3IvbW50cG9pbnQgc3VwcG9ydHMgdGltZXN0YW1wcyB1bnRpbCAyMDM4LTAxLTE5Cj4gKDB4N2Zm
ZmZmZmYpCj4gWyAgMTA3LjM2Nzk0M10gb3ZlcmxheWZzOiB1cHBlciBmcyBkb2VzIG5vdCBzdXBw
b3J0IFJFTkFNRV9XSElURU9VVC4KPiB0c3RfdGVzdC5jOjE4OTU6IFRJTkZPOiBPdmVyYWxsIHRp
bWVvdXQgcGVyIHJ1biBpcyAwaCAwMm0gMDBzCj4gZmFub3RpZnkyNi5jOjIzMjogVElORk86IFVt
b3VudGluZyAvdG1wL0xUUF9mYW5mSDdkV3IvbW50cG9pbnQvb3ZsCj4gWyAgMTA3LjM4MzI2MV0g
b3ZlcmxheWZzOiB1cHBlciBmcyBkb2VzIG5vdCBzdXBwb3J0IFJFTkFNRV9XSElURU9VVC4KPiBm
YW5vdGlmeTI2LmM6MjQ2OiBUQlJPSzogcmVuYW1lKG1udHBvaW50L292bC9tb3ZlZF9maWxlLAo+
IG1udHBvaW50L292bC9pbXB1cmVfZGlyL21vdmVkX2ZpbGUpIGZhaWxlZDogRUlOVkFMICgyMikK
Cj4gU28gSSBhZGRlZCB0byB0aGUgdGVzdDoKCj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mYW5vdGlmeS9mYW5vdGlmeTI2LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjYuYwo+IEBAIC0yNzUsNiArMjc1LDExIEBAIHN0YXRpYyBz
dHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiAgICAgICAgIC5tb3VudF9kZXZpY2UgPSAxLAo+ICAg
ICAgICAgLm5lZWRzX292ZXJsYXkgPSAxLAo+ICAgICAgICAgLm1udHBvaW50ID0gT1ZMX0JBU0Vf
TU5UUE9JTlQsCj4gKyAgICAgICAvKiBUZXN0IHJlcXVpcmVzIGEgYmFzZSBmaWxlc3lzdGVtIHRo
YXQgc3VwcG9ydHMgUkVOQU1FX1dISVRFT1VUICovCj4gKyAgICAgICAuZmlsZXN5c3RlbXMgPSAo
c3RydWN0IHRzdF9mc1tdKSB7Cj4gKyAgICAgICAgICAgICAgIHsudHlwZSA9ICJleHQ0In0sCj4g
KyAgICAgICAgICAgICAgIHt9Cj4gKyAgICAgICB9LAo+ICB9OwoKKzEsIEkgYWRkZWQgaXQgYmVm
b3JlIG1lcmdlLgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
