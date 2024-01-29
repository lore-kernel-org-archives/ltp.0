Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9FFC47DA9
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 12:23:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0E8F3CF9A9
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 13:23:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F6443C8E42
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 13:22:53 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1EDAF1000D9E
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 13:22:52 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D224D1FCF6;
 Mon, 29 Jan 2024 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706530972;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrtIvvxYzgFcQ4n5aPkfpy/sXHst6Y/th7cxHybxvx0=;
 b=xF4LoxcfJvM365rs2lJ/55cCfN3tpiFr3leNoKBUzBlhYmhbKQhGkEOz0t+SfMAx/Bv5jv
 DvjMabuu1v9ao/WMSSBdwQ/w+GsoUDak2rNvsLZbGTmxLFbgp1kcbyHwIE9aBNqmtLTdII
 d6+sD8qhfVIxdiUh7lP7L4jMTeftimA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706530972;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrtIvvxYzgFcQ4n5aPkfpy/sXHst6Y/th7cxHybxvx0=;
 b=3ry9yDut+tLQMJX9VU2uBdUYZBjVpUxb0JMgy+nmLY1Kz7HxMLuhmbDEOWflu9HuYEZ0JB
 zoW1ZBfd0ecdktAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706530971;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrtIvvxYzgFcQ4n5aPkfpy/sXHst6Y/th7cxHybxvx0=;
 b=ZEhb6vBjO45cmXXxWBWgHYDKJQqbj3LYNIxjdop4ysf24cSPSQvo7pmgKWShC3n0oMOdXL
 m6m1/hIdn7txMT3TaUIDaLVxi29StM4AErumX8LHNvCnWY5OD+91m3C/j0t26kbzenTCZn
 tKLhG6N5NZmWEK9TiQmclIZ5Jc3UrY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706530971;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrtIvvxYzgFcQ4n5aPkfpy/sXHst6Y/th7cxHybxvx0=;
 b=occvSnk3K/ZmPpJ/sgLo9ttzRtnOUg59GAvwTOJHHD4nr3g+oO7KDnEA/KM9ieD1Gy527W
 EE2GZObcC9fst1DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B528132FA;
 Mon, 29 Jan 2024 12:22:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id yBUBH5uYt2WmbAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jan 2024 12:22:51 +0000
Date: Mon, 29 Jan 2024 13:22:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240129122249.GA615626@pevik>
References: <20240128024838.2699248-1-liwang@redhat.com>
 <20240128024838.2699248-9-liwang@redhat.com>
 <20240129080314.GA581064@pevik>
 <CAEemH2drVzga9NqWN4i5jZ76n5Q6Np-Cra61mGbnOttRbgbYnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2drVzga9NqWN4i5jZ76n5Q6Np-Cra61mGbnOttRbgbYnQ@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZEhb6vBj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=occvSnk3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: D224D1FCF6
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 8/8] libswap: Refactor is_swap_supported
 function to return status
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

PiBIaSBQZXRyLAoKPiBPbiBNb24sIEphbiAyOSwgMjAyNCBhdCA0OjAz4oCvUE0gUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+ID4gVGhpcyB1cGRhdGVzIHRoZSBpc19zd2Fw
X3N1cHBvcnRlZCBmdW5jdGlvbiBpbiB0aGUgbGlibHRwc3dhcAo+ID4gPiB0byByZXR1cm4gYW4g
aW50ZWdlciBzdGF0dXMgaW5zdGVhZCBvZiB2b2lkLCBhbGxvd2luZyB0aGUgZnVuY3Rpb24KPiA+
ID4gdG8gY29tbXVuaWNhdGUgc3VjY2VzcyBvciBmYWlsdXJlIHRvIHRoZSBjYWxsZXIuIEl0IGlu
dHJvZHVjZXMKPiA+ID4gY2hlY2tzIGFuZCByZXR1cm5zIDAgb24gdmFyaW91cyBmYWlsdXJlIGNv
bmRpdGlvbnMgd2hpbGUgbG9nZ2luZwo+ID4gPiB0aGUgZmFpbHVyZSB3aXRob3V0IGFib3J0aW5n
IHRoZSB0ZXN0IGNhc2UuCgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVk
aGF0LmNvbT4KPiA+ID4gLS0tCj4gPiA+ICBpbmNsdWRlL2xpYnN3YXAuaCAgICAgICAgIHwgIDIg
Ky0KPiA+ID4gIGxpYnMvbGlibHRwc3dhcC9saWJzd2FwLmMgfCAyOCArKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEx
IGRlbGV0aW9ucygtKQoKPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlic3dhcC5oIGIvaW5j
bHVkZS9saWJzd2FwLmgKPiA+ID4gaW5kZXggZTY3ZDY1NzU2Li4xZTA5ZGIwMzEgMTAwNjQ0Cj4g
PiA+IC0tLSBhL2luY2x1ZGUvbGlic3dhcC5oCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGlic3dhcC5o
Cj4gPiA+IEBAIC0yMCw1ICsyMCw1IEBAIGludCBtYWtlX3N3YXBmaWxlKGNvbnN0IGNoYXIgKnN3
YXBmaWxlLCBpbnQgYmxvY2tzLAo+ID4gaW50IHNhZmUpOwo+ID4gPiAgICogQ2hlY2sgc3dhcG9u
L3N3YXBvZmYgc3VwcG9ydCBzdGF0dXMgb2YgZmlsZXN5c3RlbXMgb3IgZmlsZXMKPiA+ID4gICAq
IHdlIGFyZSB0ZXN0aW5nIG9uLgo+ID4gPiAgICovCj4gPiBSZXZpZXdlZC1ieTogUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+Cgo+ID4gVGhhbmtzIGZvciBmdXJ0aGVyIGltcHJvdmluZyBpdC4g
RmV3IGNvbW1lbnRzIHRvIGZpeCBvbGQgaXNzdWVzLCB3aGVuIHdlCj4gPiBhcmUgYXQKPiA+IGl0
IChhbmQgcGxhbiB0byBtZXJnZSBhZnRlciB0aGUgcmVsZWFzZSkuIEJ1dCBmZWVsIGZyZWUgdG8g
aWdub3JlLgoKPiA+IEJUVyBkbyB5b3UgcGxhbiB0byB1c2UgaXQgc29tZXdoZXJlPwoKPiA+IHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9mZi9zd2Fwb2ZmMDEuYwoKPiA+IG5pdDogSSB3
b3VsZCBjb21tZW50IGhlcmUgdGhlIHJldHVybiBjb2RlLgo+ID4gQWxzbyBtYXliZSB1c2UgYm9v
bCAoZnJvbSBzdGRib29sLmgpPyBUaGUgYWR2YW50YWdlIGlzIHRoYXQgd2UgZG9uJ3QgdGhpbmsK
PiA+IHdoYXQKPiA+IHRoZSByZXR1cm4gY29kZSBpcyAoc29tZXRpbWVzIHdlIHVzZSBzeXNjYWxs
cyBhcHByb2FjaCB3aGVuIDAgaXMgc3VjY2VzcywKPiA+IG90aGVyd2lzZSAtIGxpa2UgaGVyZSAt
IDAgaXMgZmFpbHVyZSkuIFNsb3dseSBjb252ZXJ0aW5nIHRvIGJvb2wgd291bGQgYmUKPiA+IHRo
ZQo+ID4gYmVzdC4KCgo+IEdvb2QgcG9pbnQsIGFjdHVhbGx5IEkgYW0gdGlyZWQgb2YgZmlndXJp
bmcgb3V0IHRoZSByZXR1cm4gMCBtZWFucyAnRkFJTCcgb3IKPiAnU1VDQ0VTUycgaW4gdGhlIGxp
YiwgaXQgbWVzc2VzIGEgbG90IGluIHNvbWUgZnVuY3Rpb25zLiBBbmQgYXMgeW91IHN1Z2dlc3Qs
Cj4gYm9vbCB2YWx1ZSBzaG91bGQgYmUgYSBnb29kIHdheSB0byByZXNvbHZlIHRoaXMuCgo+IEJ1
dCB0aGUgYm9vbCB0eXBlIGlzIG5vdCBidWlsdCBpbnRvIHRoZSBsYW5ndWFnZSBwcmlvciB0byB0
aGUgQzk5IHN0YW5kYXJkLgo+IFRoZSBDOTkgc3RhbmRhcmQgaW50cm9kdWNlZCBhIF9Cb29sIHR5
cGUgYW5kIHRoZSBoZWFkZXIgPHN0ZGJvb2wuaD4sCj4gd2hpY2ggZGVmaW5lcyBib29sIGFzIGEg
bWFjcm8gZm9yIF9Cb29sLgoKPiBJIGFtIG5vdCBzdXJlIGlmIExUUCBub3dhZGF5cyBvbmx5IHN1
cHBvcnRzIEM5OSBhbmQgbGF0ZXIuCj4gb3Igc2hvdWxkIHdlIG1ha2UgdXNlIG9mIGJvb2wgc2Fm
ZWx5IChvciB1c2Ugc3lzY2FsbHMgYXBwcm9hY2gKPiAwID09IHN1Y2Nlc3MpIGluIG91ciBwYXRj
aD8KCkZZSSBub3cgY29tcGlsZSB3aXRoIC1zdGQ9Z251OTksIHNlZSBpbmNsdWRlL21rL2NvbmZp
Zy5tay5pbgpkYzdiZTMwZTIgKCJjb25maWc6IEV4cGxpY2l0bHkgc2V0IGdudTk5IikKU28gSSB3
b3VsZCBzYXkgTFRQIHN1cHBvcnRzIEM5OSB3aXRoIEdOVSBleHRlbnNpb25zLgoKPiBAQ3lyaWwg
SHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdoYXQgZG8geW91IHRoaW5rPwoKRllJIHdlIGFscmVh
ZHkgdXNlIHN0ZGJvb2wuaCBhbmQgYm9vbCBvbiBzb21lIHBsYWNlcyBpbiB0aGUgbGlicmFyeS4K
CktpbmQgcmVnYXJkcywKUGV0cgoKCgo+ID4gPiBAQCAtMTY4LDcgKzE2OCw3IEBAIGludCBtYWtl
X3N3YXBmaWxlKGNvbnN0IGNoYXIgKnN3YXBmaWxlLCBpbnQgYmxvY2tzLAo+ID4gaW50IHNhZmUp
Cj4gPiA+ICAgKiBDaGVjayBzd2Fwb24vc3dhcG9mZiBzdXBwb3J0IHN0YXR1cyBvZiBmaWxlc3lz
dGVtcyBvciBmaWxlcwo+ID4gPiAgICogd2UgYXJlIHRlc3Rpbmcgb24uCj4gPiA+ICAgKi8KPiA+
IG5pdDogQWx0aG91Z2ggSSBkaWQgbm90IGxpa2UgZG9jIGJlaW5nIGp1c3QgYXQgdGhlIGhlYWRl
ciwgSSBub3cgcHJlZmVyIGl0Cj4gPiBub3cKPiA+IHRvIGhhdmUgaXQganVzdCBhdCB0aGUgaGVh
ZGVyIGJlY2F1c2Ugd2UgZG9uJ3QgaGF2ZSB0byBzeW5jIHRoZSBzYW1lIHRleHQKPiA+IG9uIHR3
bwo+ID4gcGxhY2VzLgoKCj4gQWdyZWUuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
