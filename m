Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40363C41535
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 11:42:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 004553CF22E
	for <ltp@archiver.kernel.org>; Fri, 22 Dec 2023 12:42:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57AF23C8699
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 12:42:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 221481017EFE
 for <ltp@lists.linux.it>; Fri, 22 Dec 2023 12:42:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09DAB1F895;
 Fri, 22 Dec 2023 11:42:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D79D2136D6;
 Fri, 22 Dec 2023 11:42:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CKmaMxV2hWWNBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 22 Dec 2023 11:42:13 +0000
Date: Fri, 22 Dec 2023 12:42:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <20231222114204.GA518982@pevik>
References: <20231205061639.68656-1-xuyang2018.jy@fujitsu.com>
 <20231205061639.68656-2-xuyang2018.jy@fujitsu.com>
 <87a13bad-bb69-4706-87c6-62836dbf5701@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a13bad-bb69-4706-87c6-62836dbf5701@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 09DAB1F895
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/swapon03: Use get_maxswapfiles() api
 instead of hard code
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgWHUsCgo+IEhpIExp77yMIFBldHIKCj4gSSBhbSB3cml0dGluZyB2MiBwYXRjaCB0aGF0IGlu
dHJvZHVjZSBhbm90aGVyIGxpYmx0cHN3YXAgYXBpIG5hbWVkCj4gYXMgZ2V0X3VzZWRfc3dhcGZp
bGVzIGxpa2Ugd2UgZGlkIGluIGlwYyBsaWJyYXJ5LgoKPiBCdXQgSSBmb3VuZCBsaWJsdHBzd2Fw
IGFuZCBzd2Fwb24vc3dhcG9mZiBjYXNlcyBhbGwgdXNlIHN3YXBvbi9zd2FwZmYgCj4gc3lzY2Fs
bCBkaXJlY3RseSBpbnN0ZWFkIG9mIGdsaWJjIHdyYXBwZXIuIElNTywgb24gb2xkIGdsaWJjL290
aGVyIGxpYmMgCj4gZG9lc24ndCBzdXBwb3J0IHRoaXMgd3JhcHBlciBzbyBpdCB1c2Ugc3lzY2Fs
bCBkaXJlY3RseS4gQ2FuIEkgcmVwbGFjZSAKPiB0aGVtIGJ5IGdsaWJjIHdyYXBwZXIgZGlyZWN0
bHk/Cgpob3cgYWJvdXQgdXNlIGJvdGggbGliYyB3cmFwcGVyIGFuZCByYXcgc3lzY2FsbCB2aWEg
LnRlc3RfdmFyaWFudHM/CgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gQmVzdCBSZWdhcmRzCj4gWWFu
ZyBYdQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
