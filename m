Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42EDC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 13:38:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E356F3CF830
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 15:38:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA6FA3CF816
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 15:38:24 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DB9C66233B3
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 15:38:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E6025C9A1;
 Thu, 11 Apr 2024 13:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712842701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/rDYfirXBulMG7u8dapU8x8bbbwOoaEL1wWHD3eyQo=;
 b=nkWv7rx49EubRYJdatr3jibtSg39kl0ZxUwNDqgaUMmD/mtIJa4kFgqPwdDA9Y2v54lOci
 Tns4WB7CH4Iyr6eENVBCommBKwGCHuKcs/3Yky9FOIJO2ZISSKF75csMQHAfzy/Pw3pxhH
 b40TT1GQubR/Y4hUF63S7cl8d9b2roQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712842701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/rDYfirXBulMG7u8dapU8x8bbbwOoaEL1wWHD3eyQo=;
 b=ECl/utpzKEPzEKa1V9PRjpoc1mjGKy6w1BNBysdvzDnyNST7KCJYLkmD+oTy/8xfbWaAUY
 NP3wA5rbRtqbbMAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712842701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/rDYfirXBulMG7u8dapU8x8bbbwOoaEL1wWHD3eyQo=;
 b=nkWv7rx49EubRYJdatr3jibtSg39kl0ZxUwNDqgaUMmD/mtIJa4kFgqPwdDA9Y2v54lOci
 Tns4WB7CH4Iyr6eENVBCommBKwGCHuKcs/3Yky9FOIJO2ZISSKF75csMQHAfzy/Pw3pxhH
 b40TT1GQubR/Y4hUF63S7cl8d9b2roQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712842701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/rDYfirXBulMG7u8dapU8x8bbbwOoaEL1wWHD3eyQo=;
 b=ECl/utpzKEPzEKa1V9PRjpoc1mjGKy6w1BNBysdvzDnyNST7KCJYLkmD+oTy/8xfbWaAUY
 NP3wA5rbRtqbbMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48723139DE;
 Thu, 11 Apr 2024 13:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n/MFEM3nF2bzMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 13:38:21 +0000
Date: Thu, 11 Apr 2024 15:38:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240411133815.GA338630@pevik>
References: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
 <CAEemH2eDT6gN3hw=Lz2qgnwFnnHmNYai9tqbKduSkcWfNjpERQ@mail.gmail.com>
 <20240410101225.GA187895@pevik>
 <CAEemH2e7GAQmdkcu0p3p=4Hequ4nck2+ECeSfMYpXSpvKhqsDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e7GAQmdkcu0p3p=4Hequ4nck2+ECeSfMYpXSpvKhqsDg@mail.gmail.com>
X-Spamd-Result: default: False [-7.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 SUBJECT_ENDS_EXCLAIM(0.20)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_EQ_ADDR_SOME(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] New LTP documentation!
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgo+IEhpIFBldHIsCgo+IE9uIFdlZCwgQXByIDEwLCAyMDI0IGF0IDY6MTLigK9QTSBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgYWxsLAoKPiA+ID4gSGkg
QW5kcmVhLAoKPiA+ID4gT24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgODo0MeKAr1BNIEFuZHJlYSBD
ZXJ2ZXNhdG8gdmlhIGx0cCA8Cj4gPiBsdHBAbGlzdHMubGludXguaXQ+Cj4gPiA+IHdyb3RlOgoK
PiA+ID4gPiBIZWxsbyBldmVyeW9uZSwKCj4gPiA+ID4gYXMgYWxyZWFkeSBtZW50aW9uZWQgaW4g
dGhlIG1vbnRobHkgTFRQIG1lZXRpbmcsIExpbnV4IFRlc3QgUHJvamVjdAo+ID4gPiA+IGxhY2tz
IG9mIGEgbmljZSBhbmQgY2xlYW4gZG9jdW1lbnRhdGlvbiB0aGF0IGNhbiBiZSBlYXNpbHkgYWNj
ZXNzZWQgYnkKPiA+ID4gPiB1c2VycywgZGV2ZWxvcGVycyBhbmQgbWFpbnRhaW5lcnMuCj4gPiA+
ID4gVGhlIGN1cnJlbnQgTFRQIGRvY3VtZW50YXRpb24gaXMgYWxzbyBub3QgbWF0Y2hpbmcgd2l0
aCBvdXIgZXhwZWN0YW5jeQo+ID4gPiA+IHRvd2FyZHMgdGhlIGVudGlyZSBwcm9qZWN0LCB3aGlj
aCBpcyBoYXMgYmVlbiBoZWF2aWx5IHJlZmFjdG9yZWQgYW5kIGl0Cj4gPiA+ID4gaGFzIGNoYW5n
ZWQgaW4gdGhlIHBhc3QgeWVhcnMsIHByb3ZpZGluZyBhIGhpZ2hlciBxdWFsaXR5IGNvZGUgYW5k
IG5ldwo+ID4gPiA+IHRlc3RpbmcgZmVhdHVyZXMuCgo+ID4gPiA+IEZvciB0aGlzIHJlYXNvbnMs
IHdlIHRoaW5rIGl0J3MgdGltZSB0byBtb3ZlIGZvcndhcmQgYW5kIHRvIHN0YXJ0Cj4gPiA+ID4g
d29ya2luZyBvbiBkb2N1bWVudGF0aW9uLCBoZWxwaW5nIHBlb3BsZSB0byB1c2UsIHRvIGRldmVs
b3AgYW5kIHRvCj4gPiA+ID4gbWFpbnRhaW4gTFRQIGluIGFuIGVhc2llciB3YXksIGluY3JlYXNp
bmcgcXVhbGl0eSBvZiB0aGUgb3ZlcmFsbAo+ID4gcHJvamVjdAo+ID4gPiA+IGFuZCB0byBjYWxs
IG1vcmUgZGV2ZWxvcGVycyBpbiB0aGUgY29tbXVuaXR5LgoKPiA+ID4gPiBJIHN0YXJ0ZWQgdG8g
d29yayBvbiBkb2N1bWVudGF0aW9uIHJlZmFjdG9yaW5nLCByZS1vcmdhbml6aW5nIHRoZQo+ID4g
PiA+IG92ZXJhbGwgc3RydWN0dXJlLiBUaGUgZmlyc3QgcHJvdG90eXBlIGNhbiBiZSBmb3VuZCBo
ZXJlOgoKPiA+ID4gPiBodHRwczovL2x0cC1hY2Vydi5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3Qv
aW5kZXguaHRtbAoKCj4gPiA+IExvb2tzIGdyZWF0ISBUaGFua3MgZm9yIGJyaW5naW5nIHRoaXMu
Cgo+ID4gPiBBbmQgSSBqdXN0IHRyaWVkIHRoYXQgdGhlIGxhdGVzdCBMVFAgY29tcGlsZWQgJiBl
eGVjdXRlZCBzdWNjZWVkIG9uCj4gPiA+IFJIRUwtNy45Lgo+ID4gPiBDYW4geW91IHVwZGF0ZSB0
aGUgIk9sZGVzdCB0ZXN0ZWQgZGlzdHJpYnV0aW9ucyIgWzFdIHBhcnQgYnkgYWRkaW5nOgoKPiA+
ID4gICBSSEVMLTcuOSBNYWlwbyAoRGlzdHJvKSAgMy4xMCAoa2VybmVsKSAgNC44LjUoZ2NjKSAg
Mi4xNyhnbGliYykKPiA+IC0oY2xhbmcpCgo+ID4gQWx0aG91Z2ggaW4gdGhlIG9yaWdpbmFsIGRv
Y3MsIHRoZSB0YWJsZSB3YXMgbm90IHVuZGVyIHNlY3Rpb24gIkJ1aWxkCj4gPiB0ZXN0aW5nCj4g
PiB3aXRoIEdpdEh1YiBBY3Rpb25zIiwgSSBhc3N1bWVkIGl0J3MgY2xlYXIgd2UgdGFsayBhYm91
dCBHaXRIdWIgQWN0aW9ucwo+ID4gdGVzdGluZy4KPiA+IFRoYXQncyB3aHkgSSBwdXQgdGhlcmUg
b25seSBkaXN0cm9zIHdlIGFjdHVhbGx5IGhhdmUgaW4KPiA+IC5naXRodWIvd29ya2Zsb3dzL2Np
LnltbAo+ID4gYW5kIG5vdCBlLmcuIFNMRTEyLVNQMiB3aGljaCB3ZSB0ZXN0IHdpdGggbGF0ZXN0
IExUUCByZWxlYXNlLgoKPiA+IEkgYWN0dWFsbHkgZmluZCB1c2VmdWwgdG8gc3RhbmQgd2hpY2gg
ZGlzdHJvcyB3ZSB0ZXN0IHByaXZhdGVseSwgYnV0IHRoaXMKPiA+IGluZm8KPiA+IHNob3VsZCBi
ZSBvYnZpb3VzIChlaXRoZXIgYWRkIGEgY29sdW1uICJDSSIsIHdoZXJlIHdvdWxkIGJlICJHaXRI
dWIKPiA+IEFjdGlvbnMiIG9yCj4gPiAiUkhFTCBwcml2YXRlIENJIiBvciB3aGF0ZXZlci4KCgoK
Cj4gPiBATGkgQW5kcmVhIHB1dCB0aGVyZSBhcyBuZXcgaW5mbzogIk1pbmltYWwgc3VwcG9ydGVk
IGtlcm5lbCB2ZXJzaW9uIGlzCj4gPiAzLjEwLiIKPiA+IHdoaWNoIGlzIG5vdCBpbiBvbGQgZG9j
cy4gRG8geW91IHJlYWxseSB0ZXN0IFJIRUwtNy45ICgzLjEwIGJhc2VkKSB3aXRoIHRoZQo+ID4g
bGF0ZXN0IExUUCByZWxlYXNlPwoKCj4gWWVzLCBJIGRpZCBidXQgb25seSBjaGVja2VkIG9uIFJI
RUwtNy45IHdpdGggeDg2XzY0IGFuZCBzMzkweAo+IChjb21waWxlICYgZXhlY3V0aW9uIHdlbGwp
IGxhc3QgdGltZS4KCj4gQWZ0ZXIgcmVidWlsZGluZyB0aGUgbGF0ZXN0IGJyYW5jaCBvbiBhbGwg
YXJjaGVzLCBJIGZvdW5kIHRoZSByZXN0Cj4gYXJjaGVzIGhhdmUKPiBwcm9ibGVtcyBpbiBjb21w
aWxpbmcgKGZvcmdpdmUgbWUgY2FyZWxlc3MgbGFzdCB0aW1lKS4KCj4gTm93IEkgYW0gaGVzaXRh
bnQgdG8gZml4IHRoZSBlcnJvciBvciByYWlzZSB0aGUgYmFzZWxpbmUgdG8gUkhFTDguMy4KPiAo
SSB0YWxrZWQgdG8gY29sbGVhZ3VlcyBhbmQgZ290IHRvIGtub3cgdGhleSBhbHdheXMgY2hvc2Ug
dG8gdXNlIGZpeGVkCj4gdmVyc2lvbnMgb2YgTFRQIHdoZW4gPD1SSEVMOC4yKS4KClRoYW5rcyBm
b3IgaW5mbyEgRXZlbiB5b3UgZml4IHRoZSBjb21waWxhdGlvbiBvdXRkYXRlZCBpbmZvIGlzIHdo
eSBJIHdvdWxkCmRlbGV0ZSBSSEVMIDcuOSBpbmZvIGFuZCAzLjEwIGJhc2VkIGtlcm5lbCBmcm9t
IG91ciBkb2NzLiBDdXJyZW50bHkgSSdtIG5vdApmaXhpbmcgdGVzdCBydW50aW1lIGlzc3VlcyBl
dmVuIGZvciBTTEUxMi1TUDMgKGtlcm5lbCA0LjQgYmFzZWQpLiBIYXZpbmcgIndlCnN1cHBvcnQg
a2VybmVsIDMuMTAiIGlzIGFza2luZyBmb3IgcmFuZG9tIHRlc3RpbmcgZm9sa3MgY3JlYXRpbmcg
dXNlbGVzcyBnaXRodWIKaXNzdWVzICJ0ZXN0IGJyb2tlbiBvbiBrZXJuZWwgPj0gMy4xMCA8IDQu
MTkgKG9sZGVzdCBtYWlubGluZSBsb25ndGVybSBrZXJuZWwpLgoKSSB3b3VsZCByZWFsbHkgc3Rh
dGUgd2hhdCB3ZSB0ZXN0IGluIENJIGFuZCBkaWQgbm90IGdpdmUgZmFsc2UgZXhwZWN0YXRpb24g
YWJvdXQKdGhlIGFjdHVhbCB0ZXN0IGZ1bmN0aW9uYWxpdHkuIEFuZCBpZiB3ZSByZWFsbHkgd2Fu
dCB0byBzdGF0ZSB3aGF0IHdlIGJ1aWxkIGZvciwKSSdkIHByZWZlciBtZW50aW9uaW5nIHRoYXQg
d2UgYXJlIGNvbXBpbGUgZm9yIHRoYXQgZGlzdHJvIChpLmUuIHRlc3RzIHN0aWxsIGNhbgpoYXZl
IGJ1Z3MsIGl0IG1pZ2h0IGJlIHNraXBwZWQgZHVlIG9sZCBjb25maWcgYW5kIGJ1ZyBub3Qgbm90
aWNlIG9yIHRlc3QgZmFpbHVyZQpidXQgV09OVEZJWCBldGMpLiBBZ2FpbiwgbWlzc2VkIHVwZGF0
ZSB3aGVuIHdlIGNoYW5nZSBHaXRIdWIgQWN0aW9ucyBzZXR1cCBpcwplYXNpbHkgdG8gYmUgY2hl
Y2tlZCwgYnV0IGNsYWltaW5nIHNvbWV0aGluZyBpcyB0ZXN0aW5nIHByaXZhdGUgQ0kgaXMgYXNr
aW5nIHRvCmhhdmUgb3V0ZGF0ZWQgaW5mbyBzb29uZXIgb3IgbGF0ZXIuCgpLaW5kIHJlZ2FyZHMs
ClBldHIKCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIyAzLjEwLjAtMTEzNi5lbDcucHBjNjRs
ZQoKPiAjIGdsaWJjLTIuMTctMzE2LmVsNy5wcGM2NGxlCgo+IEluIGZpbGUgaW5jbHVkZWQgZnJv
bSAvdXNyL2luY2x1ZGUvdGVybWlvcy5oOjQwOjAsCj4gICAgICAgICAgICAgICAgICBmcm9tIC91
c3IvaW5jbHVkZS9iaXRzL2lvY3RsLXR5cGVzLmg6NSwKPiAgICAgICAgICAgICAgICAgIGZyb20g
L3Vzci9pbmNsdWRlL3N5cy9pb2N0bC5oOjI5LAo+ICAgICAgICAgICAgICAgICAgZnJvbSAuLi8u
Li8uLi8uLi9pbmNsdWRlL2xhcGkvaW9jdGwuaDoxMSwKPiAgICAgICAgICAgICAgICAgIGZyb20g
aW9jdGwwMi5jOjMxOgo+IC91c3IvaW5jbHVkZS9iaXRzL3Rlcm1pb3MuaDozMzo4OiBlcnJvcjog
cmVkZWZpbml0aW9uIG9mIOKAmHN0cnVjdCB0ZXJtaW9z4oCZCj4gIHN0cnVjdCB0ZXJtaW9zIHsK
PiAgICAgICAgIF4KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gaW9jdGwwMi5jOjI5OjA6Cj4gL3Vz
ci9pbmNsdWRlL2FzbS90ZXJtYml0cy5oOjIyOjg6IG5vdGU6IG9yaWdpbmFsbHkgZGVmaW5lZCBo
ZXJlCj4gIHN0cnVjdCB0ZXJtaW9zIHsKPiAgICAgICAgIF4KCgpIbSwgbm90IGluIGh0dHBzOi8v
c291cmNld2FyZS5vcmcvZ2xpYmMvd2lraS9TeW5jaHJvbml6aW5nX0hlYWRlcnMuCgpJIHN1c3Bl
Y3Q6CjY5N2EwNmE4MiAoImlvY3RsMDI6IFVzZSBjb3JyZWN0IHRlcm1pb3Mgc3RydWN0dXJlIikK
ClRoYXQgd2FzIHJlcXVpcmVkIHRvIGZpeCBydW50aW1lIGVycm9yIG9uIHBwYzY0bGUsIG5vdCBz
dXJlIGlmIGl0J3MgZWFzeSB0byBiZQpmaXhlZCAobTQgbWFjcm8gd291bGQgYmUgcHJvYmFibHkg
cmVxdWlyZWQpLgoKSWYgbm90LCBmZWVsIGZyZWUgdG8gYmlzZWN0LCB3aGV0aGVyIG9uZSBvZiB0
aGVzZSBvciBzb21ldGhpbmcgZWxzZSBicm9rZSBpdDoKCjg4NzhmYzY4MyAoImlvY3RsLHB0eTog
QWRkIGZhbGxiYWNrIGRlZmluaXRpb24gb2Ygc3RydWN0IHRlcm1pbyIpCmZlZDYzY2U5NyAoInB0
eTAzOiBBZGQgZmFsbGJhY2sgZGVmaW5pdGlvbiBmb3IgVElPQ1ZIQU5HVVAiKQoKS2luZCByZWdh
cmRzLApQZXRyCgo+ID4gQFlhbmcgWHUgSSBmb3VuZCB5b3UgcmVtb3ZlZCBmYWxsYmFja3MgdXAg
dG8ga2VybmVsIDMuMTA6Cgo+ID4gMDZhZGEwMzI5ICgiUmVtb3ZlIG9sZCBrZXJuZWwgdmVyc2lv
biBjaGVjayB3aGVuIHVzaW5nIG1pbl9rdmVyIHVuZGVyCj4gPiAzLjEwIikKPiA+IDg2MmQ5NGM0
NSAoIlJlbW92ZSBvbGQga2VybmVsIHZlcnNpb24gY2hlY2sgd2hlbiB1c2luZyB0c3Rfa3ZlcmNt
cCB1bmRlcgo+ID4gMy4xMCIpCj4gPiA5NzE4MjhjMDAgKCJzaGVsbDogUmVtb3ZlIG9sZCBrZXJu
ZWwgdmVyc2lvbiBjaGVjayBiZWxvdyAzLjEwIikKCj4gPiBIb3BlZnVsbHkgSSBoYXZlbid0IG92
ZXJsb29rIGFueXRoaW5nLgoKPiA+IEBBbmRyZWE6IEFsc28sIEkgd291bGQgcHJlZmVyIHRvIHB1
dCBiYWNrIHBhcmFncmFwaCAiMS4gQnVpbGQgdGVzdGluZyB3aXRoCj4gPiBHaXRIdWIgQWN0aW9u
cyIuIEknbGwgc2VuZCBhIHBhdGNoLCB0byBmb3JjZSBteXNlbGYgdG8gbGVhcm4gYnVpbGRpbmcg
bmV3Cj4gPiBkb2NzLgoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCj4gPiA+IFsxXQo+ID4g
aHR0cHM6Ly9sdHAtYWNlcnYucmVhZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L3VzZXJzL3N1cHBvcnRl
ZF9zeXN0ZW1zLmh0bWwKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
