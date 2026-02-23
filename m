Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE015EA4FB2
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 12:03:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E3C03D0EF4
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 13:03:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8C1C3CE00D
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 13:02:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 42300600728
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 13:02:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DCFD55BD0C;
 Mon, 23 Feb 2026 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771848166;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8B/uuTVWRjthmfxSyYnRXKgwxDt6JB700M/60OnDdo=;
 b=SDe88uEiBRIeFSzVdGp791EnlTBIB/wMHr8Zlqin8cYAFuVGxgGIYEggMfMxye63MToJQT
 zZwbLDv5+AnL5jF0e82CM5ypy1JhDDuzBs2v4IWDSYR1hikyTFRtuGiU7xMx3hibh7aD4U
 mDLD4SxfKzdpiWV5udt4KIkBxgGd2do=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771848166;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8B/uuTVWRjthmfxSyYnRXKgwxDt6JB700M/60OnDdo=;
 b=jU6bC1QvSdHS+k0AOwKTOGxGEtM2Tw54Qp9n6d3Aip7u+4fB8iziDDgI86/g70IPoMHVA0
 CwT6KdqH342nWnBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771848165;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8B/uuTVWRjthmfxSyYnRXKgwxDt6JB700M/60OnDdo=;
 b=PpBcnNrnqGqNA+Fn2FoEr9o3YJD6o/m6uqOi1j5mkmsIEz2UpCxKfkrk/b7IPEH5zKJ7cn
 eG22QLyuwe4Imr1nzrlsgWFY8LDOKXX4jEROiRMJRXaUQdYJ3xqUp9+GdZf3TYDy8I/yyq
 YbcStUfkNZ54bs6X2lY1/BRWqmuhrHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771848165;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8B/uuTVWRjthmfxSyYnRXKgwxDt6JB700M/60OnDdo=;
 b=uqDxB1wKZIE3w8+cx4WtLyv0XM11QeLreTiqSPQG4F1jl0UoryZzLQau1mekSFF/nXYiQm
 aF+8Bs7k3z0yGaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31F2C3EA68;
 Mon, 23 Feb 2026 12:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CGiKCuVBnGlDTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 23 Feb 2026 12:02:45 +0000
Date: Mon, 23 Feb 2026 13:02:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Enji Cooper (yaneurabeya)" <yaneurabeya@gmail.com>
Message-ID: <20260223120239.GB462451@pevik>
References: <20260205121540.329921-1-pvorel@suse.cz>
 <20260205121540.329921-2-pvorel@suse.cz>
 <aZQytH7k6pVXqdsz@yuki.lan> <20260219202051.GB341772@pevik>
 <aZhJ7h0toQVUzHnf@yuki.lan> <20260220153410.GA392516@pevik>
 <aZiNbmssVOrwSsiV@yuki.lan> <20260222202158.GA417048@pevik>
 <C2672F75-E168-4039-B13C-4E9456E96FFD@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <C2672F75-E168-4039-B13C-4E9456E96FFD@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/6] doc: INSTALL: dma_thread_diotest.c: Remove
 runltp from doc
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cj4gPiBPbiBGZWIgMjIsIDIwMjYsIGF0IDEyOjIx4oCvUE0sIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToKCj4gPj4gSGkhCj4gPj4+Pj4+PiBAQCAtMTA1LDkgKzEwNSw5IEBAIFF1
aWNrIFN0YXJ0Cj4gPj4+Pj4+PiAJJCAuL2NvbmZpZ3VyZQo+ID4+Pj4+Pj4gCSQgbWFrZSBhbGwK
PiA+Pj4+Pj4+IAkjIG1ha2UgaW5zdGFsbAo+ID4+Pj4+PiAgICAgICAgXgo+ID4+Pj4+PiAJVGhp
cyBzaG91bGQgYmUgJCAobm90IGNhdXNlZCBieSB0aGlzIHBhdGNoIGJ1dCB3b3J0aCBmaXhpbmcp
Cgo+ID4+Pj4+IEkgY2FuIGNoYW5nZSBpdCwgYnV0IElNSE8gZm9yIGNyZWF0aW5nIC9vcHQvbHRw
IGlzIG5lZWRlZCB0byBydW4gaXQgYXMgcm9vdAo+ID4+Pj4+IGZvciBhIGZpcnN0IHRpbWUuIE9y
IG9uZSBtdXN0IGNobW9kL2Nob3duIC9vcHQvbHRwIHVuZGVyIHJvb3QuCgo+ID4+Pj4gSHVoPyBU
aGUgbWFrZSBpbnN0YWxsIHNob3VsZCBqdXN0IHdvcmsgZmluZS4gSSdtIGp1c3QgcG9pbnRpbmcg
b3V0IHRoZQo+ID4+Pj4gdHlwbyAjIHZzICQuIE9yIGRpZCBJIG1pc3Mgc29tZXRoaW5nPwoKPiA+
Pj4gWWVhaCwgSSB1bmRlcnN0YW5kIGl0IGFuZCBwbGFuIHRvIGNoYW5nZSAjID0+ICQuIEkgdGFs
a2VkIGFib3V0IC9vcHQgKG91cgo+ID4+PiBkZWZhdWx0IHByZWZpeCkgdXN1YWxseSBub3QgYmVp
bmcgd3JpdGFibGUgYnkgcmVndWxhciB1c2VycyAoaW5zdGFsbGluZyBhbnkKPiA+Pj4gc29mdHdh
cmUgdXNpbmcgc3RhbmRhcmQgc3lzdGVtIHByZWZpeCB3aWxsIGhhdmUgdGhpcyBwcm9ibGVtKS4g
Um9vdCBpcyBuZWVkZWQKPiA+Pj4gb25seSBmb3IgY3JlYXRpbmcgL29wdC9sdHAuIFRoYXQgd2Fz
IHRoZSByZWFzb24gZm9yIHRoZSBvcmlnaW5hbCB1c2VyIHRvIHVzZSAnIycuCj4gPj4+IEJ1dCBh
cyBJIHdyb3RlLCBJJ20gb2sgdG8gY2hhbmdlIHRoZSBwcm9tcHQuCgo+ID4+IEFoLCB0aGF0J3Mg
YSBiaXQgY29uZnVzaW5nIHRoZW4gYmVjYXVzZSBpbiBzaGVsbCBzY3JpcHQgIyBpcyBhIGNvbW1l
bnQuCj4gPj4gSSB1c3VhbGx5IHByZWZpeCBjb21tYW5kcyB0aGF0IG5lZWRzIHJvb3Qgd2l0aCBz
dWRvIGluc3RlYWQuIFNvIHdoYXQKPiA+PiBhYm91dCAiJCBzdWRvIG1ha2UgaW5zdGFsbCIgPwoK
PiA+ICsxLCBnb29kIHBvaW50Lgo+ID4gSSdsbCBtZXJnZSB3aG9sZSBwYXRjaHNldCB3aXRoIHRo
aXMgY2hhbmdlIHRvbW9ycm93LgoKPiBVc2luZyBtYXJrZG93biBhbmQgc3VkbyB3b3VsZCBtYWtl
IGl0IHVuYW1iaWd1b3VzLiBJ4oCZbSBub3Qgc3VyZSBpZiBtYXJrZG93biBtYWtlcyBzZW5zZSBo
ZXJlLCBidXQgYXQgdGhlIHZlcnkgbGVhc3QgSSB3b3VsZCByZWZlcmVuY2Ugc3VkbyBvciBtYWRl
IHRoZSBkaXJlY3Rpb25zIGV4cGxpY2l0bHkgc3RhdGUgdGhhdCB0aGUgY29tbWFuZCBtdXN0IGJl
IHJ1biBhcyByb290LgoKPiBKdXN0IG15IDIgY2VudHMuLi4KPiAtRW5qaQoKPiBFeGFtcGxlOgoK
PiBgYGBiYXNoCj4gJCAuL2NvbmZpZ3VyZQo+ICQgbWFrZSBhbGwKPiAkIHN1ZG8gbWFrZSBpbnN0
YWxsCj4gYGBgCgpJIHdvdWxkIHByZWZlciB0byBkcml2ZSBhd2F5IGZyb20gR2l0SHViIE1hcmtk
b3duLCB3aGVuIHdlIGhhdmUgcmVhZHRoZWRvY3MKCmh0dHBzOi8vbGludXgtdGVzdC1wcm9qZWN0
LnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9pbmRleC5odG1sCgpLaW5kIHJlZ2FyZHMsClBldHIK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
