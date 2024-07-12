Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B310FC2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 09:08:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7B303CDED4
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 11:08:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6515D3CB579
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 11:08:19 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4E66B606749
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 11:08:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A14B1FB6C;
 Fri, 12 Jul 2024 09:08:16 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B7EE13686;
 Fri, 12 Jul 2024 09:08:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H/7xCYDykGZwEAAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 12 Jul 2024 09:08:16 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Jul 2024 11:08:15 +0200
Message-ID: <2143117.9o76ZdvQCi@localhost>
Organization: SUSE
In-Reply-To: <20240712081359.116227-1-pvorel@suse.cz>
References: <20240712081359.116227-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3A14B1FB6C
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] lib: Create tst_tmpdir.h
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

SGkgUGV0ciwKClJldmlld2VkLWJ5OiBBdmluZXNoIEt1bWFyIDxha3VtYXJAc3VzZS5kZT4KZm9y
IGJvdGggcGF0Y2hlcy4KClRoYW5rIHlvdSwKQXZpbmVzaAoKT24gRnJpZGF5LCBKdWx5IDEyLCAy
MDI0IDEwOjEzOjU34oCvQU0gR01UKzIgUGV0ciBWb3JlbCB3cm90ZToKPiBIaSwKPiAKPiBjaGFu
Z2VzIHYyLT52MzoKPiAqIEFkZCB0c3RfdG1wZGlyLmggYWxzbyB0byBpbmNsdWRlL3RzdF90ZXN0
LmggKEF2aW5lc2gpCj4gKiBTcGxpdCBkb2MgY2hhbmdlIGludG8gYSBzZXBhcmF0ZSBjb21taXQK
PiAKPiBQZXRyIFZvcmVsICgyKToKPiAgIGxpYjogQ3JlYXRlIHRzdF90bXBkaXIuaAo+ICAgZG9j
L0MgQVBJOiBBZGQgdHN0X3RtcGRpci5oCj4gCj4gIGRvYy9kZXZlbG9wZXJzL2FwaV9jX3Rlc3Rz
LnJzdCB8ICA0ICsrKysKPiAgaW5jbHVkZS90c3RfZGV2aWNlLmggICAgICAgICAgIHwgIDYgKy0t
LS0tCj4gIGluY2x1ZGUvdHN0X3Rlc3QuaCAgICAgICAgICAgICB8ICAxICsKPiAgaW5jbHVkZS90
c3RfdG1wZGlyLmggICAgICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKwo+ICBsaWIvdHN0
X3RtcGRpci5jICAgICAgICAgICAgICAgfCAgMSArCj4gIDUgZmlsZXMgY2hhbmdlZCwgMjYgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUv
dHN0X3RtcGRpci5oCj4gCj4gCgoKCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
