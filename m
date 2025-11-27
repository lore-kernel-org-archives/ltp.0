Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD1AD11183
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 12:55:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE9003CCA24
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 13:55:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED4CC3C2DA2
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 13:55:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8E8982009DB
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 13:55:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 04FAE336A2;
 Thu, 27 Nov 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C06963EA63;
 Thu, 27 Nov 2025 12:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J+vdLStKKGlyLgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Nov 2025 12:55:07 +0000
Date: Thu, 27 Nov 2025 13:55:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20251127125506.GA244936@pevik>
References: <20251127082638.224110-1-pvorel@suse.cz>
 <20251127082638.224110-2-pvorel@suse.cz>
 <CAEemH2cUYekSphFW_uj2w1FzYt3RWXDDnhmQ5TFAyr0T3HFxow@mail.gmail.com>
 <CAEemH2e6ivP0rzfTBp5LnZ8n-oe7moqfHszgs2QyYVMUTUQ_wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e6ivP0rzfTBp5LnZ8n-oe7moqfHszgs2QyYVMUTUQ_wQ@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 04FAE336A2
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] shell: Add tst_sudo.c helper
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUaHUsIE5vdiAyNywgMjAyNSBhdCA3OjU34oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgoKPiA+IEhpIFBldHIsCgo+ID4gSSBmZWVsIHRoYXQgdGhlIGZpbGVuYW1l
IHRzdF9zdWRvLmMgaXMgYSBiaXQgbWlzbGVhZGluZy4gVGhlIGhlbHBlcgo+ID4gZG9lc27igJl0
Cj4gPiByZXBsaWNhdGUgc3VkbyBiZWhhdmlvciAoYXV0aGVudGljYXRpb24sIHByaXZpbGVnZSBl
c2NhbGF0aW9uKSwgaXQgc2ltcGx5Cj4gPiBkcm9wcyBmcm9tIHJvb3QgdG8gYSBmaXhlZCBVSUQv
R0lEIGJlZm9yZSBleGVjdXRpbmcgYSBjb21tYW5kLgoKPiA+IFNvIHJlYWRlcnMgbWF5IGV4cGVj
dCBhIOKAnHN1ZG8tbGlrZeKAnSBlbGV2YXRpb24gd3JhcHBlciB3aGVuLCBob3dldmVyCj4gPiBp
dOKAmXMgYSBwcml2aWxlZ2UtZHJvcHBpbmcgdHJhbXBvbGluZS4KClRoYW5rcywgbWFrZXMgc2Vu
c2UuCgo+ID4gV2hhdCBhYm91dCByZW5hbWluZyBpdCB0bzoKPiA+ICAgdHN0X3J1bmFzLmMsCj4g
PiAgIHRzdF9ydW5hc19ub2JvZHkuYywgb3IKPiA+ICAgdHN0X2Ryb3BfcHJpdnMuYz8KCj4gUGVy
c29uYWxseSwgSSBwcmVmZXIgdGhlIHRzdF9ydW5hc19ub2R5LmMgYmVjYXVzZSBpdCByZWZsZWN0
cyB0aGUKPiBkZWZhdWx0IHByaXZpbGVnZSwKPiBidXQgZHVlIGl0IHN1cHBvcnRzIHRoZSBtb3Jl
IGVudiBzbyBjb250YWlucyAic3UiIG1heWJlIGJldHRlcjoKPiAgIHRzdF9zdV9zd2l0Y2guYywg
dHN0X3N1X2NtZC5jCgpJJ2QgYmUgb2sgd2l0aCB0c3Rfc3UuYywgYnV0IHN1cmUgdHN0X3N1X2Nt
ZC5jIGlzIG9rIGFzIHdlbGwuCkknbGwgd2FpdCBsaXR0bGUgbG9uZ2VyIGZvciBmZWVkYmFjayBm
cm9tIG90aGVycy4KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
