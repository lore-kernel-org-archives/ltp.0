Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1445D35662
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 07:22:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DFB13CA670
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 08:22:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 443333C5918
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 08:21:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 732A22009B3
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 08:21:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 115645BCDF;
 Wed, 28 Jan 2026 07:21:44 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D97A23EA61;
 Wed, 28 Jan 2026 07:21:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XymeMwe5eWnhXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jan 2026 07:21:43 +0000
Date: Wed, 28 Jan 2026 08:21:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260128072142.GA13495@pevik>
References: <aWjZX0fsrTJMqq49@yuki.lan> <aXi4P0YdKx5rFZ8C@yuki.lan>
 <20260127132514.GB146899@pevik>
 <CAEemH2cK2BFnJJ-6M+=RBKDYcHuH-_TxKDAabYj5KcmOkgHQ6g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cK2BFnJJ-6M+=RBKDYcHuH-_TxKDAabYj5KcmOkgHQ6g@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 115645BCDF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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

PiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gKiBpb2N0bF9waWRmZDAy
LTA2OiBBZGQgQ09ORklHX1VTRVJfTlMgYW5kIENPTkZJR19QSURfTlMgdG8gbmVlZHNfa2NvbmZp
Z3MKPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAvcGF0Y2gvMjAy
NTEyMDkyMTE2MjkuOTU0MzYtMS10ZXJyeS50cml0dG9uQGxpbmFyby5vcmcvCj4gPiAoT3IgSSBj
YW4gcHJlcGFyZSBhbiBhbHRlcm5hdGl2ZSBmaXggdG8gZG8gYSBydW50aW1lIGNoZWNrLCBJIGFs
c28gcGxhbiB0byBzZW5kCj4gPiBhIHBhdGNoIHdpdGggZm9ybWFsaXNpbmcgdGhlIHJ1bGVzKQoK
PiBUaGUgb3JpZ2luYWwgcGF0Y2ggc2hvdWxkIGJlIHNhZmUgdG8gYmUgbWVyZ2VkLgoKPiBCZWNh
dXNlIHdlIGNhbiBkaXNhYmxlIG9yIGxpbWl0IHRoZSBjcmVhdGlvbiBvZiBuZXcgbmFtZXNwYWNl
cyBvbmx5Cj4gYnkgdHVybmluZyBvZmYgdGhlIEtjb25maWcgb3B0aW9uczoKCj4gICAtIENPTkZJ
R19VU0VSX05TCj4gICAtIENPTkZJR19QSURfTlMKCj4gSWYgdGhvc2Ugb3B0aW9ucyBhcmUgdW5z
ZXQsIHRoZSBuYW1lc3BhY2UgdHlwZSBzaW1wbHkgZG9lc27igJl0IGV4aXN0Cj4gKG5vIC9wcm9j
L3NlbGYvbnMvdXNlcikuCgo+IElmIHRoZXnigJlyZSBzZXQsIHRoZXJlIGlzbuKAmXQgYSBydW50
aW1lIGtub2IgKHN5c2N0bCwgcHJvYywgb3Igc3lzZnMpIHRoYXQgY2FuCj4gZGlzYWJsZXMgdGhl
bSBpbiBnZW5lcmFsLXB1cnBvc2Uga2VybmVscy4KClllYWgsIGl0J3MgYm9vbCwgbGV0J3MgbWVy
Z2UgaXQuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
