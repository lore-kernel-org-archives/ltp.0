Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59F8CD11C2
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 10:12:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3624B3CF772
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 12:12:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FF493CF73F
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 12:12:28 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B83861001848
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 12:12:27 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BF8AF5CA44;
 Wed, 10 Apr 2024 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712743946;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3TRgSX8f3W3gNxfR9TDp7UZsrRL08/THhcc33rJC1g=;
 b=oxLlZmgUaIsvbTZtgZn/fxzev+KvzY8BRZobouji1WYJ4ktBHyGkE+i7dDDKaZja2wQshf
 z3VeKvv8Kx1crC2JpmTPWMY73+qp11NhpEvLq0VcVcz127xuCgRp+OP+MO1lzCEfUdm9mW
 mGRcToy5bd2x7Xet0Jr1SHV9r3b/K6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712743946;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3TRgSX8f3W3gNxfR9TDp7UZsrRL08/THhcc33rJC1g=;
 b=CPmFaqkfPxO9/f+hZs1bGWU5KS+9Kn5QTlIFXBgHwLdNAtUcoX35+FtaaTWBc3nOxYJWh5
 stDU4+7iADWd05DQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oxLlZmgU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CPmFaqkf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712743946;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3TRgSX8f3W3gNxfR9TDp7UZsrRL08/THhcc33rJC1g=;
 b=oxLlZmgUaIsvbTZtgZn/fxzev+KvzY8BRZobouji1WYJ4ktBHyGkE+i7dDDKaZja2wQshf
 z3VeKvv8Kx1crC2JpmTPWMY73+qp11NhpEvLq0VcVcz127xuCgRp+OP+MO1lzCEfUdm9mW
 mGRcToy5bd2x7Xet0Jr1SHV9r3b/K6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712743946;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3TRgSX8f3W3gNxfR9TDp7UZsrRL08/THhcc33rJC1g=;
 b=CPmFaqkfPxO9/f+hZs1bGWU5KS+9Kn5QTlIFXBgHwLdNAtUcoX35+FtaaTWBc3nOxYJWh5
 stDU4+7iADWd05DQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8804713A92;
 Wed, 10 Apr 2024 10:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id i6MSHwpmFmacaQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 10 Apr 2024 10:12:26 +0000
Date: Wed, 10 Apr 2024 12:12:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240410101225.GA187895@pevik>
References: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
 <CAEemH2eDT6gN3hw=Lz2qgnwFnnHmNYai9tqbKduSkcWfNjpERQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eDT6gN3hw=Lz2qgnwFnnHmNYai9tqbKduSkcWfNjpERQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SUBJECT_ENDS_EXCLAIM(0.20)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_EQ_ADDR_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_FIVE(0.00)[6]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BF8AF5CA44
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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

SGkgYWxsLAoKPiBIaSBBbmRyZWEsCgo+IE9uIE1vbiwgTWFyIDE4LCAyMDI0IGF0IDg6NDHigK9Q
TSBBbmRyZWEgQ2VydmVzYXRvIHZpYSBsdHAgPGx0cEBsaXN0cy5saW51eC5pdD4KPiB3cm90ZToK
Cj4gPiBIZWxsbyBldmVyeW9uZSwKCj4gPiBhcyBhbHJlYWR5IG1lbnRpb25lZCBpbiB0aGUgbW9u
dGhseSBMVFAgbWVldGluZywgTGludXggVGVzdCBQcm9qZWN0Cj4gPiBsYWNrcyBvZiBhIG5pY2Ug
YW5kIGNsZWFuIGRvY3VtZW50YXRpb24gdGhhdCBjYW4gYmUgZWFzaWx5IGFjY2Vzc2VkIGJ5Cj4g
PiB1c2VycywgZGV2ZWxvcGVycyBhbmQgbWFpbnRhaW5lcnMuCj4gPiBUaGUgY3VycmVudCBMVFAg
ZG9jdW1lbnRhdGlvbiBpcyBhbHNvIG5vdCBtYXRjaGluZyB3aXRoIG91ciBleHBlY3RhbmN5Cj4g
PiB0b3dhcmRzIHRoZSBlbnRpcmUgcHJvamVjdCwgd2hpY2ggaXMgaGFzIGJlZW4gaGVhdmlseSBy
ZWZhY3RvcmVkIGFuZCBpdAo+ID4gaGFzIGNoYW5nZWQgaW4gdGhlIHBhc3QgeWVhcnMsIHByb3Zp
ZGluZyBhIGhpZ2hlciBxdWFsaXR5IGNvZGUgYW5kIG5ldwo+ID4gdGVzdGluZyBmZWF0dXJlcy4K
Cj4gPiBGb3IgdGhpcyByZWFzb25zLCB3ZSB0aGluayBpdCdzIHRpbWUgdG8gbW92ZSBmb3J3YXJk
IGFuZCB0byBzdGFydAo+ID4gd29ya2luZyBvbiBkb2N1bWVudGF0aW9uLCBoZWxwaW5nIHBlb3Bs
ZSB0byB1c2UsIHRvIGRldmVsb3AgYW5kIHRvCj4gPiBtYWludGFpbiBMVFAgaW4gYW4gZWFzaWVy
IHdheSwgaW5jcmVhc2luZyBxdWFsaXR5IG9mIHRoZSBvdmVyYWxsIHByb2plY3QKPiA+IGFuZCB0
byBjYWxsIG1vcmUgZGV2ZWxvcGVycyBpbiB0aGUgY29tbXVuaXR5LgoKPiA+IEkgc3RhcnRlZCB0
byB3b3JrIG9uIGRvY3VtZW50YXRpb24gcmVmYWN0b3JpbmcsIHJlLW9yZ2FuaXppbmcgdGhlCj4g
PiBvdmVyYWxsIHN0cnVjdHVyZS4gVGhlIGZpcnN0IHByb3RvdHlwZSBjYW4gYmUgZm91bmQgaGVy
ZToKCj4gPiBodHRwczovL2x0cC1hY2Vydi5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvaW5kZXgu
aHRtbAoKCj4gTG9va3MgZ3JlYXQhIFRoYW5rcyBmb3IgYnJpbmdpbmcgdGhpcy4KCj4gQW5kIEkg
anVzdCB0cmllZCB0aGF0IHRoZSBsYXRlc3QgTFRQIGNvbXBpbGVkICYgZXhlY3V0ZWQgc3VjY2Vl
ZCBvbgo+IFJIRUwtNy45Lgo+IENhbiB5b3UgdXBkYXRlIHRoZSAiT2xkZXN0IHRlc3RlZCBkaXN0
cmlidXRpb25zIiBbMV0gcGFydCBieSBhZGRpbmc6Cgo+ICAgUkhFTC03LjkgTWFpcG8gKERpc3Ry
bykgIDMuMTAgKGtlcm5lbCkgIDQuOC41KGdjYykgIDIuMTcoZ2xpYmMpICAtKGNsYW5nKQoKQWx0
aG91Z2ggaW4gdGhlIG9yaWdpbmFsIGRvY3MsIHRoZSB0YWJsZSB3YXMgbm90IHVuZGVyIHNlY3Rp
b24gIkJ1aWxkIHRlc3RpbmcKd2l0aCBHaXRIdWIgQWN0aW9ucyIsIEkgYXNzdW1lZCBpdCdzIGNs
ZWFyIHdlIHRhbGsgYWJvdXQgR2l0SHViIEFjdGlvbnMgdGVzdGluZy4KVGhhdCdzIHdoeSBJIHB1
dCB0aGVyZSBvbmx5IGRpc3Ryb3Mgd2UgYWN0dWFsbHkgaGF2ZSBpbiAuZ2l0aHViL3dvcmtmbG93
cy9jaS55bWwKYW5kIG5vdCBlLmcuIFNMRTEyLVNQMiB3aGljaCB3ZSB0ZXN0IHdpdGggbGF0ZXN0
IExUUCByZWxlYXNlLgoKSSBhY3R1YWxseSBmaW5kIHVzZWZ1bCB0byBzdGFuZCB3aGljaCBkaXN0
cm9zIHdlIHRlc3QgcHJpdmF0ZWx5LCBidXQgdGhpcyBpbmZvCnNob3VsZCBiZSBvYnZpb3VzIChl
aXRoZXIgYWRkIGEgY29sdW1uICJDSSIsIHdoZXJlIHdvdWxkIGJlICJHaXRIdWIgQWN0aW9ucyIg
b3IKIlJIRUwgcHJpdmF0ZSBDSSIgb3Igd2hhdGV2ZXIuCgpATGkgQW5kcmVhIHB1dCB0aGVyZSBh
cyBuZXcgaW5mbzogIk1pbmltYWwgc3VwcG9ydGVkIGtlcm5lbCB2ZXJzaW9uIGlzIDMuMTAuIgp3
aGljaCBpcyBub3QgaW4gb2xkIGRvY3MuIERvIHlvdSByZWFsbHkgdGVzdCBSSEVMLTcuOSAoMy4x
MCBiYXNlZCkgd2l0aCB0aGUKbGF0ZXN0IExUUCByZWxlYXNlPwoKQFlhbmcgWHUgSSBmb3VuZCB5
b3UgcmVtb3ZlZCBmYWxsYmFja3MgdXAgdG8ga2VybmVsIDMuMTA6CgowNmFkYTAzMjkgKCJSZW1v
dmUgb2xkIGtlcm5lbCB2ZXJzaW9uIGNoZWNrIHdoZW4gdXNpbmcgbWluX2t2ZXIgdW5kZXIgMy4x
MCIpCjg2MmQ5NGM0NSAoIlJlbW92ZSBvbGQga2VybmVsIHZlcnNpb24gY2hlY2sgd2hlbiB1c2lu
ZyB0c3Rfa3ZlcmNtcCB1bmRlciAzLjEwIikKOTcxODI4YzAwICgic2hlbGw6IFJlbW92ZSBvbGQg
a2VybmVsIHZlcnNpb24gY2hlY2sgYmVsb3cgMy4xMCIpCgpIb3BlZnVsbHkgSSBoYXZlbid0IG92
ZXJsb29rIGFueXRoaW5nLgoKQEFuZHJlYTogQWxzbywgSSB3b3VsZCBwcmVmZXIgdG8gcHV0IGJh
Y2sgcGFyYWdyYXBoICIxLiBCdWlsZCB0ZXN0aW5nIHdpdGgKR2l0SHViIEFjdGlvbnMiLiBJJ2xs
IHNlbmQgYSBwYXRjaCwgdG8gZm9yY2UgbXlzZWxmIHRvIGxlYXJuIGJ1aWxkaW5nIG5ldyBkb2Nz
LgoKS2luZCByZWdhcmRzLApQZXRyCgo+IFsxXSBodHRwczovL2x0cC1hY2Vydi5yZWFkdGhlZG9j
cy5pby9lbi9sYXRlc3QvdXNlcnMvc3VwcG9ydGVkX3N5c3RlbXMuaHRtbAoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
