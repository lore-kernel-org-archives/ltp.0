Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22CCC3DA60
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 17:56:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37A1C3D1AEB
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 19:56:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87ED93C74E7
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:55:50 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D82A960171F
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:55:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 085642119A;
 Wed, 17 Jul 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C286E136E5;
 Wed, 17 Jul 2024 17:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8FQyLKQFmGZiQwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jul 2024 17:55:48 +0000
Date: Wed, 17 Jul 2024 19:55:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240717175547.GB690776@pevik>
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
 <CAEemH2cAfjhGLv3GWPA_5xgsFNYiRf-oQwyLPhbWWSPKn=yAhw@mail.gmail.com>
 <ZpeGRluc-U1NHjNY@rei>
 <CAEemH2f4sO40tJxT2wokw=SDaeAvNhR-z8NOqW0=xWSKSv3Wsg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f4sO40tJxT2wokw=SDaeAvNhR-z8NOqW0=xWSKSv3Wsg@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 085642119A
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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

SGkgYWxsLAoKPiBPbiBXZWQsIEp1bCAxNywgMjAyNCBhdCA0OjQ54oCvUE0gQ3lyaWwgSHJ1Ymlz
IDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgoKPiA+IEhpIQo+ID4gPiBTaW5jZSBleGVjdnBlKCkg
aXMgYSBHTlUgZXh0ZW5zaW9uLCB3ZSBuZWVkIHRvIGVuc3VyZSB0aGF0Cj4gPiA+IHdlIGFyZSBj
b21waWxpbmcgd2l0aCBHTlUgZXh0ZW5zaW9ucyBlbmFibGVkLgoKPiA+ID4gYWRkIHRoaXMgbGlu
ZSBpbnRvIHRoZSBoZWFkIG9mIHRzdF90ZXN0LmM6Cj4gPiA+ICNkZWZpbmUgX0dOVV9TT1VSQ0UK
CkZZSSBiZXNpZGVzIHRoaXMgKHdoaWNoIGJyaW5ncyBDSSBidWlsZCkgaXQgZmFpbHMgdG8gY29t
cGlsZSBhbHNvIG9uIG11c2w6CgpodHRwczovL2dpdGh1Yi5jb20vcGV2aWsvbHRwL2FjdGlvbnMv
cnVucy85OTc4OTYyMzY5L2pvYi8yNzU3NzAyNTA3MQoKdHN0X3Jlc18uYzogSW4gZnVuY3Rpb24g
J21haW4nOgp0c3RfcmVzXy5jOjUyOjk6IGVycm9yOiBmb3JtYXQgbm90IGEgc3RyaW5nIGxpdGVy
YWwgYW5kIG5vIGZvcm1hdCBhcmd1bWVudHMgWy1XZXJyb3I9Zm9ybWF0LXNlY3VyaXR5XQogICA1
MiB8ICAgICAgICAgdHN0X3Jlc18oYXJndlsxXSwgYXRvaShhcmd2WzJdKSwgdHlwZSwgbXNnKTsK
CgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
