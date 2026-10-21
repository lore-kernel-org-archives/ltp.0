Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FD606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 12:08:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88FEA3CC570
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 14:08:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89F463C029F
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 14:07:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2B9DE1000473
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 14:07:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BAB1A21E0B;
 Wed, 21 Oct 2026 12:07:53 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75863134FD;
 Wed, 21 Oct 2026 12:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hH6SDxmr2GqvPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 21 Oct 2026 12:07:53 +0000
Date: Wed, 21 Oct 2026 14:07:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20261021120751.GA265579@pevik>
References: <as2dZ8VBuN2NM3TZ@linux.dev>
 <4EkJ88xMyWBqTKeQ8KRctlqrIv8JfY4VYo5D@localhost.localdomain>
 <athrEiFc8i3Tf-3G@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <athrEiFc8i3Tf-3G@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: BAB1A21E0B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSEKPiA+ID4gPiB3aGF0IGFib3V0IHNjaGVkdWxpbmcgYSBuZXcgTFRQIG1lZXRpbmcgYWZ0
ZXIgdGhlIHJlbGVhc2U/Cj4gPiA+ID4gV2hlbidzIHlvdXIgZmlyc3QgYXZhaWxhYmxlIGRhdGU/
Cgo+ID4gPiBTb3VuZHMgZ29vZC4KCj4gPiA+IE15IGF2YWlsYWJpbGl0eSBpcyBvbiB3ZWVrZGF5
cywgNOKAkzYgUE0gQmVpamluZyB0aW1lIChVVEMrOCksIHdoaWNoCj4gPiA+IHNob3VsZCBiZSA5
4oCTMTEgQU0gQ0VULiAKCkBMaSBkbyB5b3UgaGF2ZSB0aW1lIG9ubHkgb24gd2Vla2VuZHM/IEkn
bSBxdWl0ZSBidXN5IG9uIHdlZWtlbmRzIGFscmVhZHkuCgo+ID4gPiBJdCBtaWdodCBiZSBiZXR0
ZXIgdG8gc2hhcmUgYW4gYWdlbmRhIG9yIGRpc2N1c3MgdGhlIHRvcGljcyBiZWZvcmVoYW5kLgoK
PiA+IHNvcnJ5IGZvciBteSBkZWxheSwgY3JhenkgdGltZXMuCgo+ID4gSSB3b3VsZCBsaWtlIHRv
IGhhdmUgYSBMVFAgbWVldGluZywgaWYgeW91IHdhbnQgd2UgY2FuIGRvIGl0IGF0IDEwYW0gdGhl
IG5leHQKPiA+IHdlZWsgaWYgd2VkbmVzZGF5IGFyZSB0aGUgb25seSBvcHRpb24uCgo+ID4gQFBl
dHIgQEN5cmlsIFdEWVQ/Cgo+IFdlZG5lc2RheSAyOC4gT2N0IGlzIGJhbmsgaG9sbGlkYXkgaW4g
Q3plY2ggcmVwdWJsaWMsIGFuIGluZGVwZW5kZW5jZSBkYXkuCgorMQoKSWYgaXQgbmVlZHMgdG8g
YmUgV2VkbmVzZGF5LCB0aGVuIG5leHQgb25lIDR0aCBPY3QgZnJvbSAxMCB3b3VsZCB3b3JrIGZv
ciBtZS4KCk9yIHdlIGNhbiB0cnkgdG8gZmluZCBhbm90aGVyIGRheSBuZXh0IHdlZWsgKDI2dGgt
MzB0aCBTZXApLCBlLmcuIFR1ZSAyN3RoIGZyb20KMTEuMDAgYW0gd291bGQgd29yayBmb3IgbWUg
KG1lZXRpbmcgZnJvbSAxMS4wMCBzaGlmdGVkIHRvIDEwLjAwKS4KCktpbmQgcmVnYXJkcywKUGV0
cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
