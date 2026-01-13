Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFF7CF45DF
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 11:52:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 239D53C5BAE
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 12:52:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3595C3C0BAA
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 12:51:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9942860076E
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 12:51:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB20E5BCCC;
 Tue, 13 Jan 2026 11:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768305111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tn3VHtIjhVHuhs4p1G4+oZ7tnYcSEkxsRjFP5WTzqKc=;
 b=20jv+hCW3TxCX18bugWQk46k3jrm+we/QsTHla1MEdDYffn+bD1pv8sF59E96HB+7IKBHE
 pABZ5rCdrZ0g7HSpbtL1gZK0RvthCd2zeHCLzrXZG1uJB93DFGFdWZvpkZhQcF4iINfrT8
 CArCuo+c5GolGUBW2LZGa2JTG0d26P4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768305111;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tn3VHtIjhVHuhs4p1G4+oZ7tnYcSEkxsRjFP5WTzqKc=;
 b=v5YhOjhCSfEDwRt9ct5wqIxWnnFyP7dJY/Xp4zFmuZ3FvNkhukoqfKP0dSPpm5PpbNQl7n
 JkgWtC7nlf19MHBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768305109;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tn3VHtIjhVHuhs4p1G4+oZ7tnYcSEkxsRjFP5WTzqKc=;
 b=QT5wA6Ns1a/hZNUhKOOWXk91hara59X/nejTG1jVpQcXHZSA8VnvKF4SRQISlmS/qWFE0l
 pxtV3sd8p+iIQOXQH0+TwuzQPlbbEh23blg8UEZoX5JYD6YgsP+RHgQCaaeE6mEpW3G3c7
 zHAuQKcfF2drrB2TAG6dK1lg6tso8oc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768305109;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tn3VHtIjhVHuhs4p1G4+oZ7tnYcSEkxsRjFP5WTzqKc=;
 b=Qs8TVLCYzM12b1Bw1JPCyVBKYZv88dUd9rI9lM06q8GggqmOUXBt1yFyeYwcthtWTLLJXb
 XL/S/lEO5a7Pg0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B89B33EA63;
 Tue, 13 Jan 2026 11:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J3L3K9UxZmm3MAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 13 Jan 2026 11:51:49 +0000
Date: Tue, 13 Jan 2026 12:51:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260113115148.GA314748@pevik>
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
 <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,suse.cz,lists.linux.it,gmail.com,redhat.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] libs: adopt lib* prefix instead of tst_* for libs/
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
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBBbmRyZWEsIEFsbCwKCj4gT24gTW9uLCBKYW4gMTIsIDIwMjYgYXQgODo1OeKAr1BNIEFu
ZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4gd3JvdGU6Cgo+ID4g
SGkhCgo+ID4gSSBnZW5lcmFsbHkgYWdyZWUgd2l0aCB0aGlzIGFwcHJvYWNoLCBidXQgSSBoYXZl
IHRoZSBmZWVsaW5nIHdlIGFyZQo+ID4gbWl4aW5nIG5hbWluZyBhIGJpdCBoZXJlLiBGb3IgaW5z
dGFuY2UsIHdlIGhhdmUgaGVhZGVycyBsaWtlIGlwY21zZy5oCj4gPiB0aGF0IGhhcyBubyBmdW5j
dGlvbnMgc3RhcnRpbmcgd2l0aCB0c3RfKiwgd2hpbGUgdHN0X251bWEuaCBkb2VzLiBBbHNvLAo+
ID4gdGhlIHRzdF8qIHByZWZpeCBmb3IgZmlsZXMgaGFzIHRoZSBjbGVhciBnb2FsIHRvIHN0YXRl
IHdlIGFyZSBpbXBvcnRpbmcKPiA+IHNvbWUgTFRQIGZ1bmN0aW9uYWxpdGllcyBpbnNpZGUgdGhl
IHRlc3RzIGNvZGUuCgo+ID4gU2FpZCBzbywgSSB3b3VsZCByYXRoZXIgcmVuYW1lIGFsbCBMVFAg
bGlicmFyaWVzIGFzIHRzdF8qLmggYW5kIHRvCj4gPiByZW5hbWUgZnVuY3Rpb25zIGluc2lkZSB0
aGVtIHdpdGggdHN0XyogcHJlZml4LiBJbiB0aGlzIHdheSwgd2Uga25vdwo+ID4gYXQgdGhlIHZl
cnkgZmlyc3QgbG9vaywgd2hlbiBhIGxpYnJhcnkgaXMgaW1wb3J0ZWQgZnJvbSBMVFAgYW5kIG5v
dAo+ID4gZnJvbSBvdGhlciBzb3VyY2VzLgoKJ3RzdF8nIHByZWZpeCBpcyBvbmx5IGZvciAqbmV3
KiBDIEFQSS4gVGhhdCdzIHdoeSBpcGNtc2cuaC9saWJzL2lwYy9saWJpcGMuYwpkb24ndCB1c2Ug
aXQuIEkgd291bGQgcHJlZmVyIHRvIGtlZXAgdGhhdCB3YXkgKG5vdCB1c2UgJ3RzdF8nIGZvciBs
ZWdhY3kgQyBBUEkKbGlicmFyeSBzb3VyY2UpLgoKVGhhdCdzIHdoeSBJIHF1aXRlIGxpa2UgTGkn
cyBhcHByb2FjaCAoSSdtIG9rIGlmIGxpYnMvIHNvdXJjZXMnIGhlYWRlcnMgd2lsbApoYXZlICds
aWInIHByZWZpeCBpbnN0ZWFkIG9mICd0c3RfJyksIGFsdGhvdWdoIEkgbGlrZWQgbW9yZQpsaWJz
L3NpZ3dhaXQvc2lnd2FpdC5jIHRoYW4gbGlicy9zaWd3YWl0L2xpYnNpZ3dhaXQuYy4KCj4gSSBp
bmRlZWQgdGhvdWdodCBhYm91dCBhbGwgdXNlIHRzdF8qIGZvciB0aG9zZSBnbG9iYWwgaGVhZGVy
IGZpbGVzLgo+IEJ1dCB0byBkaXN0aW5ndWlzaCBsaWIvIHdpdGggbGlicy8gSSBmaW5hbGx5IGZl
ZWwgdGhhdCBsaWJzLyBpcyBub3QgdGhlCj4gY29yZSBMVFAgQVBJCj4gYW5kIHNvbWV0aW1lcyBi
dWlsdCBvbmx5IHdoZW4gdGhleSBhcmUgbmVlZGVkLCBpZiB3ZSByZW5hbWUgYWxsIHRoZXNlCj4g
aGVhZGVyIGZpbGUgd2l0aCB0c3RfKiB0aGF0IHdpbGwgbWlzbGVhZCBwZW9wbGUgdG8gZmluZCB0
aGUgKi5jIGZpbGUgaW4KPiBsaWIvLCB3aGljaAo+IGlzIG5vdCB0aGUgcmlnaHQgcGxhY2UuCgo+
IFNvIGluIG15IHBhdGNoLCBrZWVwIGRlZmluZSB0c3RfKiBvbmx5IGZvciB0aGUgY29yZSBMVFAg
QVBJLCBhbmQgbGliKiBwcmVmaXgKPiByZXNlcnZlIGZvciBsaWJzLyB0aGF0IHdpbGwgYmUgY2xl
YXIgYXQgYSBnbGFuY2UuCgorMQoKPiBPciwgaWYgZ28gd2l0aCB0c3RfKi5oIGZvciBhbGwgKGFu
ZCByZW5hbWUgZnVuY3Rpb25zIHdpdGggdHN0XyopLCBJIHRoaW5rCj4gdGhlIGxpYnMvIHNob3Vs
ZCBiZSBtZXJnZWQgaW50byBsaWIvLgoKSSBkb24ndCB0aGluayB0aGlzIHdvdWxkIGJlIGdvb2Qu
IEl0IHdvdWxkIHJlcXVpcmUgYWxzbyBjaGFuZ2luZyBhIGJ1aWxkIHN5c3RlbSwKdG91Y2ggdG9v
IG1hbnkgZmlsZXMuIEFuZCBJIGRvbid0IGV2ZW4gc2VlIGEgYmVuZWZpdCBmb3IgYSBzdWNoIGNo
YW5nZS4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiBAQ3lyaWwsIFBldHIsIGFueSBjb21tZW50cz8K
CkkgYWxzbyB3b25kZXIgQ3lyaWwncyBhbmQgSmFuJ3Mgb3Bpbmlvbi4KCktpbmQgcmVnYXJkcywK
UGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
