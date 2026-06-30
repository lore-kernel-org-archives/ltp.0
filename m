Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0490BC43327
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 10:33:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EDD73E222C
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 12:33:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A5163C2780
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 12:33:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6398D200970
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 12:33:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C51BC7358E;
 Tue, 30 Jun 2026 10:33:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81F15779A8;
 Tue, 30 Jun 2026 10:33:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QOaxHnSbQ2qKEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jun 2026 10:33:24 +0000
Date: Tue, 30 Jun 2026 12:33:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20260630103323.GA403199@pevik>
References: <20260429105644.986278-1-pvorel@suse.cz>
 <6a4377a6.51d65a57.19e759.3280@mx.google.com>
 <CAASaF6w2cwaYmWBcJi3Dm3Pu_d0R4jUaN8wJLTbwt4M4Tv5a-g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6w2cwaYmWBcJi3Dm3Pu_d0R4jUaN8wJLTbwt4M4Tv5a-g@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C51BC7358E
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Move runtest/irq into runtest/kernel_misc
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
Cc: Tim Bird <tim.bird@sony.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSmFuLCBBbmRyZWEsCgo+IE9uIFR1ZSwgSnVuIDMwLCAyMDI2IGF0IDEwOjAw4oCvQU0gQW5k
cmVhIENlcnZlc2F0bwo+IDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPiB3cm90ZToKCj4gPiBI
aSBQZXRyLAoKPiA+IGFueSBuZXdzIGFib3V0IHRoaXM/IENhbiB3ZSBtZWdlIGl0PwoKPiArMQoK
PiBBY2tlZC1ieTogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+CgpUaGFua3MgZm9y
IHlvdXIgYWNrLiBQbGVhc2Uga2VlcCBpdCB1bm1lcmdlZCwgSSBuZWVkIHRvIHByZXBhcmUgb3Vy
CmluZnJhc3RydWN0dXJlIGZvciB0aGUgY2hhbmdlIChpdCBzaG91bGQgYmUgcmVhZHkgaW4gZmV3
IGRheXMsIEknbGwgbWVyZ2UgaXQKdGhlbikuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
