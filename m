Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB310C27C79
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 11:25:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E3BA3D0E2C
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 13:25:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E3A03D0E0C
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 13:25:23 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BD1182010F9
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 13:25:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5708B21AD0;
 Thu, 20 Jun 2024 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718882721;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K86fdCCsr+Q2BgGfKoJyIIIximjPRwaaar2Z5/scDhU=;
 b=1qiXg8R0y4RCbfJR+OBlLlw6ymChlqPlGDlSEqoQfH8dOwgCsnPn88iK4BGFdxfzHiyKWo
 1sXytQoVkDomE0D7RM+LbYPACOWMqXGd681P6CZi+Qas6NFW0gS5yGCNIVhNu3wfHNjN01
 P/z8RUnY7qB/vZeMnSOY8aW/r7qBozk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718882721;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K86fdCCsr+Q2BgGfKoJyIIIximjPRwaaar2Z5/scDhU=;
 b=kNUa2kd/GHaBjQQdu8Bog82kdjyCLZbGbRGw7f/jBYzchFyAk8z3ZmDVeP0WvGfbqaZfrM
 l6u9+t27m/2ufFBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ekKOier9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IlGC14pO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718882720;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K86fdCCsr+Q2BgGfKoJyIIIximjPRwaaar2Z5/scDhU=;
 b=ekKOier9jqaVwAVMO4grQ0zBFiQSLU3lVGcX6JgAK2GSXStxj+6/Mv4VKC+8urSJMnXcPC
 oFOpgQnFqxxEZkfWP8+6AieqEBbu2ifMJWFSAAxap0VGgc1YEcNicTLWEUGIi91LWhYsOJ
 xse9ZwAnaR97eXr/2dTDQ/r62IdZN+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718882720;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K86fdCCsr+Q2BgGfKoJyIIIximjPRwaaar2Z5/scDhU=;
 b=IlGC14pOi5p4/fSAmsZ6BFZ1CuBqWTZAWZarmr53TjuUBpW8HymiXRR8xr8M2DALqxZKx7
 8sBQScqZeA+buPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0204313AC1;
 Thu, 20 Jun 2024 11:25:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +JaVN58RdGY5IAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jun 2024 11:25:19 +0000
Date: Thu, 20 Jun 2024 13:25:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240620112514.GB594613@pevik>
References: <20240527222947.374475-1-pvorel@suse.cz>
 <37603272-8ea2-4828-96df-4b6381cc26ad@suse.com>
 <ZldFa-3CXXbVKmVW@yuki> <20240620053618.GD537887@pevik>
 <CAEemH2cnB0QAAz1CqZPdRWm5R8GP4sqqA9mw-owHkL1ASXTkMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cnB0QAAz1CqZPdRWm5R8GP4sqqA9mw-owHkL1ASXTkMQ@mail.gmail.com>
X-Rspamd-Queue-Id: 5708B21AD0
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] lib: Add TINFO_WARN
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

PiBIaSBQZXRyLCBBbGwsCgo+IE9uIFRodSwgSnVuIDIwLCAyMDI0IGF0IDE6MzbigK9QTSBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gPiBIaSEKPiA+ID4gPiBJJ20gbm90
IHN1cmUgYWJvdXQgdGhpcy4gV2h5IG5vdCBlbmFibGluZyBUSU5GTyArIFRXQVJOIGNvbWJpbmF0
aW9uCj4gPiBpbnN0ZWFkPwoKPiA+ID4gPiB0c3RfcmVzKFRJTkZPIHwgVFdBUk4sICJteSBtZXNz
YWdlIik7Cgo+ID4gPiBUaGF0J3MgZXZlbiBtb3JlIGNvbmZ1c2luZy4gRG9lcyB0aGF0IHByb3Bh
Z2F0ZSBpbnRvIHJlc3VsdHMgb3Igbm90PwoKPiA+ID4gVG8gYmUgaG9uZXN0IHdlIGV2ZW4gaGF2
ZSBwcm9ibGVtIGRlY2lkaW5nIGlmIHdlIHNob3VsZCB1c2UgVElORk8gb3IKPiA+ID4gVFdBUk4g
aW4gc29tZSBjYXNlcyBhbmQgYWRkaW5nIHRoaXJkIHZhcmlhbnQgd291bGQgbWFrZSB0aGluZ3Mg
ZXZlbgo+ID4gPiB3b3JzZSwgc2ljbmUgd2Ugd291bGQgaGF2ZSB0aHJlZSBvcHRpb25zLgoKPiA+
ID4gU28gSSB3b3VsZCByZWFsbHkga2VlcCBqdXN0IFRJTkZPIHdoaWNoIGlzIHNvbWV0aGluZyB0
aGF0IGlzIHByaW50ZWQgYnkKPiA+ID4gZGVmYXVsdCBidXQgZG9lcyBub3QgcHJvcGFnYXRlIGlu
dG8gcmVzdWx0cyBhbmQgVFdBUk4gdGhhdCBpcyBwcmludGVkIGFzCj4gPiA+IHdlbGwgYnV0IHBy
b3BhZ2F0ZXMgaW50byByZXN1bHRzLgoKPiA+ID4gTWF5YmUgaXQgd291bGQgYmUgZXZlbiBiZXR0
ZXIgdG8gYWN0dWFsbHkgcmVtb3ZlIFRXQVJOLiBUaGF0IHdheSB3ZQo+ID4gPiB3b3VsZCBoYXZl
IG9ubHkgVEZBSUwgYW5kIFRCUk9LIHRoYXQgcHJvcGFnYXRlIGludG8gcmVzdWx0cyBzaW5jZSBU
V0FSTgo+ID4gPiBpcyBraW5kIG9mIGxlc3NlciBUQlJPSyBhbnl3YXlzLi4uCgo+ID4gVW5kZXJz
dGFuZCB0byB5b3VyIHBvaW50cy4gQnV0IHRzdF9yZXMgVFdBUk4gaXMgcXVpdGUgdW5kZXJzdGFu
ZGFibGUKPiA+IChzaW1wbGUgd2FybmluZywgd2hpY2ggcHJvcGFnYXRlcyksIElNSE8gYmV0dGVy
IHRvIHVzZSB0aGFuCj4gPiB0c3RfcmVzIFRCUk9LLiBCdXQgc3VyZSwgZmVlbCBmcmVlIHRvIGdv
IGFoZWFkIGFuZCBzZW5kIGEgcGF0Y2ggdG8gcmVtb3ZlCj4gPiBUV0FSTi4KCgo+ICsxIHRvIHJl
bW92ZSBUV0FSTi4KCgo+ID4gQlRXIEkgd2FzIGFsc28gc3VycHJpc2VkIGhvdyBtYW55IHRlc3Rz
IHVzZSB0c3RfcmVzbSBUQlJPSyAuLi4gLwo+ID4gdHN0X3Jlc20oVEJST0ssCj4gPiAuLi4pIGZv
bGxvd2VkIGJ5IGV4aXQgMSAvIGV4aXQoMSkuIFRoZXNlIHNob3VsZCBiZSBjb252ZXJ0ZWQgdG8g
dHN0X2Jya20KPiA+IFRCUk9LIC8KPiA+IHRzdF9yZXNtKFRCUk9LLCAuLi4pLgoKPiA+IE90aGVy
IHRoaW5nIGlzLCB0aGF0IEkgd291bGQgcHJlZmVyIHRvIGhhdmUgbWFjcm8gZm9yIHRzdF9yZXMo
VElORk8sCj4gPiAiV0FSTklORzogLi4uIikKPiA+IGUuZy4gV0FSTklORyguLi4pIHdvdWxkIHBy
b2R1Y2UgdHN0X3JlcyhUSU5GTywgIldBUk5JTkc6IC4uLiIpIGZyb20gc2ltcGxlCj4gPiBwb2lu
dCBJCj4gPiBkb24ndCBsaWtlIHRvIGhhcmR3aXJlIHRleHQgKHRoZXJlIGNhbiBiZSB0eXBvcyku
IEJUVyBtb3JlIHRoYW4gZm9yIHRoaXMKPiA+IHJhcmUKPiA+IGNhc2UgSSB3b3VsZCBwcmVmZXIg
dG8gaGF2ZSBtYWNyb3MgZm9yIC50YWdzLCBlLmcuIExJTlVYX0dJVCg0M2E2Njg0NTE5YWIpCj4g
PiB3b3VsZAo+ID4gcHJvZHVjZSB7ImxpbnV4LWdpdCIsICI0M2E2Njg0NTE5YWIifSBDVkUoMjAx
Ny0yNjcxKSB3b3VsZCBwcm9kdWNlIHsiQ1ZFIiwKPiA+ICIyMDE3LTI2NzEifQo+ID4gKGFnYWlu
LCB0eXBvcykuCgoKPiBXaGF0IGFib3V0IGRlZmluaW5nIG5ldyBMVFAgbWFjcm9zIGxpa2UKPiAg
IFRTVF9SRVNfVElORk8oKSwKPiAgIFRTVF9SRVNfVEZBSUwoKSwKPiAgIC4uLgo+ICAgVFNUX1JF
U19XQVJOSU5HKCksCj4gc28gdGhhdCB3ZSBjYW4gc2F2ZSB0aW1lIG9uIGlucHV0dGluZyB0aGUg
VEZBSUwvVElORk8ga2V5d29yZHMgZXZlcnkgdGltZe+8nwoKPiBhbHNvIFRTVF9MSU5VWF9HSVQo
KSwgVFNUX0NWRSgpID8KCisxCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
