Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C961C3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 08:33:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD6193CC282
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 10:33:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66D363CB230
 for <ltp@lists.linux.it>; Mon, 12 May 2025 10:32:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B6A0F1A00600
 for <ltp@lists.linux.it>; Mon, 12 May 2025 10:32:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4BA51211B1;
 Mon, 12 May 2025 08:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747038768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5OHA6wFPoGNb7onu5Q3Ybl9eL9YLExb49XtLy2RZAY=;
 b=nB44wgm1A6vT5UjDM8ldsanrY1i/nJlhl3/lHWXuDfHRuRLx4nK3ckc+Ai3wkp0a6r5wbF
 9emtpS7frVsPqzR1zAst1hVU5wHWXh7TosFkKA7CfOYt1ft78f7ZvwQLaGz2L6fh9uOOGO
 I1BLlZFYIgsMzI8d5wBdQXGIYt/57LE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747038768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5OHA6wFPoGNb7onu5Q3Ybl9eL9YLExb49XtLy2RZAY=;
 b=i/Fy3Z+qe0kvNa1ck+Ro28ylUlqfwFOKqc97HPB2wbHVd+BXevk4VTdj0E6CaTYbtoBSPa
 eL93Gxq2vbjVmNBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747038768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5OHA6wFPoGNb7onu5Q3Ybl9eL9YLExb49XtLy2RZAY=;
 b=nB44wgm1A6vT5UjDM8ldsanrY1i/nJlhl3/lHWXuDfHRuRLx4nK3ckc+Ai3wkp0a6r5wbF
 9emtpS7frVsPqzR1zAst1hVU5wHWXh7TosFkKA7CfOYt1ft78f7ZvwQLaGz2L6fh9uOOGO
 I1BLlZFYIgsMzI8d5wBdQXGIYt/57LE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747038768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5OHA6wFPoGNb7onu5Q3Ybl9eL9YLExb49XtLy2RZAY=;
 b=i/Fy3Z+qe0kvNa1ck+Ro28ylUlqfwFOKqc97HPB2wbHVd+BXevk4VTdj0E6CaTYbtoBSPa
 eL93Gxq2vbjVmNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D0651397F;
 Mon, 12 May 2025 08:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dQQuDjCyIWgUIQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 12 May 2025 08:32:48 +0000
Date: Mon, 12 May 2025 10:33:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aCGyTkkA6iSQHNzg@yuki.lan>
References: <20250510205326.1353857-1-wegao@suse.com>
 <CAEemH2cJHz3aLRi0HeSvJWy=XvPMfJ_nv0F7=L7P2ubn8-zv5A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cJHz3aLRi0HeSvJWy=XvPMfJ_nv0F7=L7P2ubn8-zv5A@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix: dirtyc0w_shmem child process exit with
 error due to uninitialized lib_pid
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

SGkhCj4gPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF90ZXN0LmMgYi9saWIvdHN0X3Rlc3QuYwo+ID4g
aW5kZXggMmJiNDUxOWRkLi5iNjY2NzE1YjkgMTAwNjQ0Cj4gPiAtLS0gYS9saWIvdHN0X3Rlc3Qu
Ywo+ID4gKysrIGIvbGliL3RzdF90ZXN0LmMKPiA+IEBAIC01OSw3ICs1OSw3IEBAIHN0YXRpYyBj
b25zdCBjaGFyICp0aWQ7Cj4gPiAgc3RhdGljIGludCBpdGVyYXRpb25zID0gMTsKPiA+ICBzdGF0
aWMgZmxvYXQgZHVyYXRpb24gPSAtMTsKPiA+ICBzdGF0aWMgZmxvYXQgdGltZW91dF9tdWwgPSAt
MTsKPiA+IC1zdGF0aWMgcGlkX3QgbWFpbl9waWQsIGxpYl9waWQ7Cj4gPiArc3RhdGljIHBpZF90
IGxpYl9waWQ7Cj4gPiAgc3RhdGljIGludCBtbnRwb2ludF9tb3VudGVkOwo+ID4gIHN0YXRpYyBp
bnQgb3ZsX21vdW50ZWQ7Cj4gPiAgc3RhdGljIHN0cnVjdCB0aW1lc3BlYyB0c3Rfc3RhcnRfdGlt
ZTsgLyogdmFsaWQgb25seSBmb3IgdGVzdCBwaWQgKi8KPiA+IEBAIC03OCw2ICs3OCw4IEBAIHN0
cnVjdCByZXN1bHRzIHsKPiA+ICAgICAgICAgaW50IGFib3J0X2ZsYWc7Cj4gPiAgICAgICAgIHVu
c2lnbmVkIGludCBydW50aW1lOwo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgb3ZlcmFsbF90aW1l
Owo+ID4gKyAgICAgICBwaWRfdCBsaWJfcGlkOwo+ID4gKyAgICAgICBwaWRfdCBtYWluX3BpZDsK
PiA+ICB9Owo+IAo+IENhbiB3ZSBhdm9pZCBwb2xsdXRpbmcgdGhlIHN0cnVjdCByZXN1bHRzIHdp
dGggbWFpbl9waWQgYW5kIGxpYl9waWQ/Cj4gRnJvbSBhIGRlc2lnbiBzZXBhcmF0aW9uIHN0YW5k
cG9pbnQsIHJlc3VsdHMgc2hvdWxkIG9ubHkgc3RvcmUgdGVzdAo+IG91dGNvbWUgZGF0YSwgbm90
IHRlc3QgaW5mcmFzdHJ1Y3R1cmUgc3RhdGUuCgpXZSBkbyBoYXZlIHRoZSBhYm9ydF9mbGFnIGFu
ZCBydW50aW1lIHRoZXJlIGFuZCBjaGVja3BvaW50cyB1c2UgdGhlCm1lbW9yeSBhZnRlciB0aGlz
IHN0cnVjdHVyZSBhcyB3ZWxsLCBzbyBJIHdvdWxkbid0IGJlIHNvIHN0cmljdC4KCj4gQXMgTFRQ
IGxpYnJhcnkgYWxyZWFkeSBwcm92aWRlcyBhIHRzdF9yZWluaXQoKSBmdW5jdGlvbiBmb3IgY2hp
bGQgcHJvY2Vzc2VzCj4gc3Bhd25lZCB2aWEgZXhlYygpL2V4ZWNscCgpIHRvIHJlc3RvcmUgdGhl
aXIgdGVzdCBjb250ZXh0Lgo+IAo+IFdlIGNvdWxkIGNvbnNpZGVyIHR3byBhcHByb2FjaGVzOgo+
IAo+IDEuIENyZWF0ZSBhIHNlcGFyYXRlIElQQyByZWdpb24gdG8gc3RvcmUgaW5mcmFzdHJ1Y3R1
cmUgc3RhdGUoZS5nLiwKPiBtYWluX3BpZCwgbGliX3BpZCkKPiBpbiBhIG5ldyBzdHJ1Y3QgdHN0
X21ldGFfaW5mby4gVGhlIGNoaWxkIGNhbiB0aGVuIGFjY2VzcyB0aGlzIGRhdGEgdmlhCj4gdHN0
X3JlaW5pdCgpCj4gd2l0aG91dCBtb2RpZnlpbmcgdGhlIHN0cnVjdCByZXN1bHRzLgoKSSB3b3Vs
ZCBsaWtlIHRvIGtlZXAgYSBzaW5nbGUgSVBDIHJlZ2lvbiBiZWNhdXNlIHdlIGhhdmUgdG8gcGFz
cyBhCnBhdGggdG8gaXQgdG8gYWxsIGNoaWxkcmVuIHRvby4KCkFsc28gZ2l2ZW4gdGhhdCB0aGUg
bWluaW1hbCBhbW91bnQgb2YgbWVtb3J5IHdlIGNhbiBhbGxvY2F0ZSBmb3IgSVBDIGlzCmEgcGFn
ZSB3ZSBjYW4gYXMgd2VsbCBoYXZlIHR3byBzdHJ1Y3R1cmVzLCBvbmUgZm9yIGRhdGEgYW5kIG9u
ZSBmb3IKbGlicmFyeSBpbmZyYXN0cnVjdHVyZSBiaXRzIGFuZCBwbGFjZSB0aGVzZSBzdHJ1Y3R1
cmVzIGluIHRoZXJlCm1hbnVhbGx5LiBBbGwgd2UgbmVlZCB0byBkbyBpcyB0byBtYWtlIHN1cmUg
dGhhdCB3ZSBwbGFjZSB0aGVtIGF0CmFsaWduZWQgb2Zmc2V0cy4KCj4gMi4gU2ltcGx5IHBhc3Mg
bWFpbl9waWQgYW5kIGxpYl9waWQgdGhyb3VnaCBlbnZpcm9ubWVudCB2YXJpYWJsZXMgaW4gdGhl
Cj4gbHRwIGxpYnJhcnksIGFuZCByZXRyaWV2ZSB0aGVtIGZyb20gdHN0X3JlaW5pdCgpIGluIHRo
ZSBjaGlsZC4KClRoYXQgd291bGQgd29yayB0b28sIGJ1dCB0aGlzIGFkZHMgbW9yZSBjb21wbGV4
aXR5LgoKPiBPciwgbWF5YmUgb3RoZXJzIGhhdmUgc2ltcGxlciBvcHRpb25zLiBDYydpbmcgdGhl
bS4KPiAKPiBJbiBlaXRoZXIgY2FzZSwgd2Ugc2hvdWxkIHNldCAndHN0X3Rlc3QtPmNoaWxkX25l
ZWRfcmVpbml0JyBpbiB0aGUgcGFyZW50Lgo+IAo+IEBDeXJpbCwgQFBldHIsIEkgc3VwcG9ydCBt
ZXJnaW5nIHRoaXMgZml4IGJlZm9yZSB0aGUgTWF5IHJlbGVhc2UsIGFzIEnigJl2ZSBhbHNvCj4g
ZW5jb3VudGVyZWQgdGhlIHNhbWUgZmFpbHVyZSBkdXJpbmcgbXkgcHJlLXJlbGVhc2UgdGVzdGlu
Zy4KClllcywgcGxlYXNlLCBpdCdzIGdvb2QgZW5vdWdoIGV2ZW4gaWYgaXQncyBnb2luZyB0byBi
ZSBhIHRlbXBvcmFyeQpzb2x1dGlvbi4KClJldmlld2VkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnVi
aXNAc3VzZS5jej4KCi0tIApDeXJpbCBIcnViaXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
