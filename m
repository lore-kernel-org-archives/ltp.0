Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10242D29FF2
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 11:34:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38FF33C9A5F
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 12:34:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22F433C58A2
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 12:33:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5DDA96008C8
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 12:33:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ACAC35C384;
 Wed, 14 Jan 2026 11:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768390430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azhVCHr36IsoHcExTkmmbGlPBScmmZi9r5HEVSG3F0U=;
 b=t/P8NxEAE51rOI3078jbYMgQsrD4LXHvt0AFPkURwsZQGF7EDyCgaFDnZKR4qZPf2AdwgW
 OAJXRg61MINH4W5VL5E3xRr/UWdZVXa1SvJP08y9tkFhwx8npKbMN874GTw7cBu+KfndrK
 MiA2bfXmvHDzqulNnGw7hC4xkZYK4Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768390430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azhVCHr36IsoHcExTkmmbGlPBScmmZi9r5HEVSG3F0U=;
 b=7xOkxZgAEER+EQNZU51cr5KPvG2L0hwsGAyXbrpt/CHJXUFK5gHBBzEc2/VqQEQBOx9IeH
 Tv3ZDAzYbxdjmgBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="t/P8NxEA";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7xOkxZgA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768390430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azhVCHr36IsoHcExTkmmbGlPBScmmZi9r5HEVSG3F0U=;
 b=t/P8NxEAE51rOI3078jbYMgQsrD4LXHvt0AFPkURwsZQGF7EDyCgaFDnZKR4qZPf2AdwgW
 OAJXRg61MINH4W5VL5E3xRr/UWdZVXa1SvJP08y9tkFhwx8npKbMN874GTw7cBu+KfndrK
 MiA2bfXmvHDzqulNnGw7hC4xkZYK4Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768390430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azhVCHr36IsoHcExTkmmbGlPBScmmZi9r5HEVSG3F0U=;
 b=7xOkxZgAEER+EQNZU51cr5KPvG2L0hwsGAyXbrpt/CHJXUFK5gHBBzEc2/VqQEQBOx9IeH
 Tv3ZDAzYbxdjmgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B57F3EA63;
 Wed, 14 Jan 2026 11:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Qq2uGB5/Z2kZEwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 14 Jan 2026 11:33:50 +0000
Date: Wed, 14 Jan 2026 12:33:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260114113349.GB344144@pevik>
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
 <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
 <20260113115148.GA314748@pevik>
 <CAASaF6xrnNY5gpURDqgxQBWvQ5BqzXQN07NTkVbFae0bKB5PZg@mail.gmail.com>
 <DFNI6KO750G6.13XP4I5MYH1HQ@suse.com>
 <CAEemH2d6=vmEKKf65WuAGRhfU4FE8mBf-dAzNWLmgYtFO3WA6Q@mail.gmail.com>
 <20260114085116.GB334250@pevik>
 <CAEemH2e1MVNjLJR+_h9Bvkk3b0roVxhtJRvedFhxH4ckzhW==A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e1MVNjLJR+_h9Bvkk3b0roVxhtJRvedFhxH4ckzhW==A@mail.gmail.com>
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,suse.cz,lists.linux.it,gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: ACAC35C384
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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

PiBPbiBXZWQsIEphbiAxNCwgMjAyNiBhdCA0OjUx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+ID4gPiA+IEknZCBrZWVwIHRoZW0gc2VwYXJhdGUgZnJvbSBjb3Jl
IGxpYnJhcnkuIEZvciBub24tY29yZSBsaWJyYXJpZXMsIEknZCBnbwo+ID4gPiA+IHdpdGgKPiA+
ID4gPiA+IHNvbWV0aGluZyBtb3JlIGRpc3RpbmN0LCBsaWtlICJsdHAiIHByZWZpeCBmb3IgZmls
ZSBhbmQgZnVuY3Rpb24gbmFtZXMuCgoKPiA+ID4gVGhhbmtzIQoKPiA+ID4gPiA+IFdoZW4gSSBs
b29rIGF0ICJsaWJudW1hLmgiIEknZCBoYXZlIHRvIHRoaW5rIGZvciBhIGJpdCBpZiB0aGlzIGlz
Cj4gPiA+ID4gPiBoZWFkZXIgZnJvbSBudW1hLWRldmVsCj4gPiA+ID4gPiBvciBMVFAuICJsdHBu
dW1hLmgiIHNlZW1zICh0byBtZSkgbW9yZSBjbGVhciB0aGF0IGl0J3Mgbm90IExUUCBjb3JlCj4g
PiA+ID4gPiBub3IgbnVtYS1kZXZlbC4KCgo+ID4gPiBHb29kIHBvaW50LCBidXQgdGhlIGx0cCog
cHJlZml4IHNvdW5kcyB0b28gc2VyaW91cyB0byBtZS4gQW55dGhpbmcgd2l0aAo+ID4gPiB0aGUg
bHRwKiBwcmVmaXggaW5zaWRlIGFuIExUUCBtYWtlcyBtZSB0aGluayBpdCdzIGNyaXRpY2FsIGlu
Zm9ybWF0aW9uLgoKPiA+ICsxCgo+ID4gPiBQZXJoYXBzIHdlIGNhbiB1c2UgYSBsaWdodHdlaWdo
dCBuYW1lIGZvciB0aGUgZXh0cmEgbGlicy86Cgo+ID4gPiBlc3RfKjogZXh0cmEgdGVzdCBsaWJy
YXJ5Cj4gPiA+IHhzdF8qOiBleHRlbmVkIHRlc3QgbGlicmFyeQo+ID4gPiBsc3RfKjogbHRwIHRl
c3QgbGlicmFyeQoKPiA+ID4gSSBwcmVmZXIgdG8gdXNlIGxzdF8qLCB3aGljaCBpcyBub3Qgb25s
eSBkaWZmZXJlbnQgZnJvbSB0c3RfKiwgYnV0IGFsc28KPiA+ID4gaW1wbGllcwo+ID4gPiB0aGlz
IGlzIGx0cCB0c3RfIHRoaW5ncy4KCj4gPiA+IFdoYXQgZG8geW91IHRoaW5rPyBvciBhbnkgYmV0
dGVyIHByZWZpeD8KCj4gPiBHaXZlbiB0aGF0IGluY2x1ZGUgImxpYmZvby5oIiBzaG91bGQgYmUg
bG9jYWwgaGVhZGVyIGFuZCBpbmNsdWRlIDxmb28uaD4gc2hvdWxkCj4gPiBiZSBoZWFkZXIgZnJv
bSAvdXNyL2xpYiogSSB3b3VsZCBiZSBvayB3aXRoIGVpdGhlciBrZWVwIHRoaW5ncyBhcyB0aGV5
IGFyZSBvcgo+ID4gdXNlIHRoZSBvcmlnaW5hbCBMaSdzIHByb3Bvc2FsLgoKPiA+IEZvciBtZSBw
ZXJzb25hbGx5IGlzIG1vcmUgdXNlZnVsIHRvIGtub3cgd2hldGhlciBoZWFkZXIgY2FuIGJlIHVz
ZWQgaW4gdGhlIG9sZAo+ID4gQVBJIChpLmUuICJ0c3RfIiBwcmVmaXggbWVhbnMgc291cmNlIGlz
IGNvbnZlcnRlZCBpbiB0aGUgbmV3IEMgQVBJKSB0aGFuIHdoZXRoZXIKPiA+IGhlYWRlciBpcyBm
cm9tIGV4dHJhIGxpYnJhcnkuCgo+IFdlbGwsIHdlIG1pZ2h0IHN1YmNvbnNjaW91c2x5IHRoaW5r
IHRoYXQgbGliZm9vLmggbWVhbnMgYW4gb2xkZXIgdmVyc2lvbiwKPiBidXQgd2UgY2FuIGNoYW5n
ZSB0aGF0IG1pbmRzLiBTb21ldGhpbmcgbGlrZSAibHN0XyIgY2FuIGFsc28gYmUgdXNlZCBpbgo+
IG9sZGVyIEFQSXMgKGFuZCBpbXBsaWVzIGV4dHJhIGxpYnMvKS4KCj4gRnVydGhlcm1vcmUsIEkg
YmVsaWV2ZSB0aGVzZSBhZGRpdGlvbmFsICdsaWJzLycgZGlyZWN0b3JpZXMgd2lsbCBjb250aW51
ZSB0byBiZQo+IGRldmVsb3BlZCBhbmQgZXhpc3QgbG9uZy10ZXJtOyB3ZSBjdXJyZW50bHkgaGF2
ZSBubyBwbGFucyB0byBtaWdyYXRlIHRoZW0KPiB0byB0aGUgY29yZSBBUEksICBzbyBleHBsaWNp
dCBuYW1pbmcgYmVjb21lcyBjcnVjaWFsIGZvciBtYWludGVuYW5jZS4KCj4gQnkgbm93LCB0aGUg
c2l0dWF0aW9uIGlzLCBpbmxjdWRlLyBjb250YWlucyBkaWZmZXJlbnQgcHJlZml4IGhlYWRlciBm
aWxlczoKPiAgICdsdHBfJywgJ29sZF8nLCAnbGliJzogbWVhbnQgb2xkIExUUCBBUEksIGJ1dCBz
aG91bGQgZXZlbnR1YWxseSBiZSBkcm9wcGVkLgo+ICAgdHN0XzogbWVhbnQgdGhlIG5ldyBjb3Jl
IExUUCBBUEkuCgo+IE5leHQsIEkgaG9wZSB0aGF0IHdlIG9ubHkga2VlcCB0d28gcHJlZml4ZXMg
aW4gTFRQIEFQSToKPiAgIHRzdF86IG5ldyBjb3JlIExUUCBBUEkKPiAgIGxzdF86IGV4dHJhIChu
b24tY29yZSkgTFRQIEFQSQoKSSdtIG5vdCBhIGJpZyBmdW4gb2YgJ2xzdF8nIChJIG1pZ2h0IG5l
ZWQgdGltZSB0byBnZXQgdXNlZCB0byBpdCA6KSkgYnV0IEknbSBub3QKYWdhaW5zdCBpdC4gIElm
IHdlIGFncmVlIG9uIHRoaXMgaXQnZCBiZSBncmVhdCB0byBkb2N1bWVudCBpdCwgc28gdGhhdCBu
ZXcKY29udHJpYnV0b3JzIHdpbGwgbm90IGhhdmUgdG8gdGhpbmsgd2hpY2ggcHJlZml4IHRvIHVz
ZS4KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
