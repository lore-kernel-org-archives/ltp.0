Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B6CC3DA6E
	for <ltp@archiver.kernel.org>; Wed, 20 Dec 2023 12:29:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B1423CA869
	for <ltp@archiver.kernel.org>; Wed, 20 Dec 2023 13:29:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8B5E3C97C9
 for <ltp@lists.linux.it>; Wed, 20 Dec 2023 13:29:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C59D1601321
 for <ltp@lists.linux.it>; Wed, 20 Dec 2023 13:29:06 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1A3F01F82B;
 Wed, 20 Dec 2023 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703075345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkqHce3bIfcgTqt+6AevFec53wxV5HFMrAFmOr5Naa4=;
 b=JFzOZh3fBSbASTrj7zqbKXI9GHqzZAW7o6ihZolhEJ+tRV2f1JnBhBEoduRr1VaPh1DB66
 7DJQP+/iJQjcbfpgEVPsdbOikXQ4+hgNCydEJeE/DIbpUMeXT9U9Wi5iMee+ApJLcEFpUU
 ipnpYmCIU8dnRWAe2xb8MGQmjxyv8xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703075345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkqHce3bIfcgTqt+6AevFec53wxV5HFMrAFmOr5Naa4=;
 b=X074tGG28BeZWV2X4sH75BDjvZlR7X9QRb0a/SyofprpWPnXMAvhbxtk4bOTPZuZ4nEBxh
 KVKTiT/EfQxA6PDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703075345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkqHce3bIfcgTqt+6AevFec53wxV5HFMrAFmOr5Naa4=;
 b=JFzOZh3fBSbASTrj7zqbKXI9GHqzZAW7o6ihZolhEJ+tRV2f1JnBhBEoduRr1VaPh1DB66
 7DJQP+/iJQjcbfpgEVPsdbOikXQ4+hgNCydEJeE/DIbpUMeXT9U9Wi5iMee+ApJLcEFpUU
 ipnpYmCIU8dnRWAe2xb8MGQmjxyv8xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703075345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkqHce3bIfcgTqt+6AevFec53wxV5HFMrAFmOr5Naa4=;
 b=X074tGG28BeZWV2X4sH75BDjvZlR7X9QRb0a/SyofprpWPnXMAvhbxtk4bOTPZuZ4nEBxh
 KVKTiT/EfQxA6PDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 759AF13927;
 Wed, 20 Dec 2023 12:29:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id odZbGxDegmXQFQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 20 Dec 2023 12:29:04 +0000
Date: Wed, 20 Dec 2023 13:29:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231220122903.GA393099@pevik>
References: <20231120154248.15048-1-andrea.cervesato@suse.de>
 <20231128125632.GB381183@pevik>
 <977d4dc47fa4c5163afc1a6646d4fb5a@suse.de>
 <CAEemH2e3rshuygLTq5LcK69ONnMAGO+Mcy_FkZJVS4OCHHf5ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e3rshuygLTq5LcK69ONnMAGO+Mcy_FkZJVS4OCHHf5ZQ@mail.gmail.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JFzOZh3f;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=X074tGG2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.70 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_SHORT(-0.19)[-0.951]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[27.84%]
X-Rspamd-Queue-Id: 1A3F01F82B
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Delete fork09 test
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
Cc: pvorel <pvorel@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUdWUsIERlYyAxOSwgMjAyMyBhdCAxMDo1NeKAr1BNIHB2b3JlbCA8cHZvcmVsQHN1c2Uu
ZGU+IHdyb3RlOgoKPiA+IEhpIGFsbCwKCj4gPiBPbiAyMDIzLTExLTI4IDEzOjU2LCBQZXRyIFZv
cmVsIHdyb3RlOgo+ID4gPiBIaSBBbmRyZWEsCgo+ID4gPj4gRnJvbTogQW5kcmVhIENlcnZlc2F0
byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KCj4gPiA+PiBUaGUgZm9yazA5IHRlc3QgaXMg
YWN0dWFsbHkgdGVzdGluZyB3aGF0IGZvcmsxMCBpcyBhbHJlYWR5IHRlc3Rpbmc6Cj4gPiA+PiBh
Y2Nlc3NpbmcgYW4gb3BlbiBjaGlsZCdzIGZpbGUgZnJvbSBwYXJlbnQuIEZvciB0aGlzIHJlYXNv
biwgd2UgZGVsZXRlCj4gPiA+PiBpdCBhbmQgbGV0IGZvcmsxMCBkb2luZyBpdHMgam9iLgoKPiA+
ID4gaW4gZm9yazA5IHBhcmVudCBvcGVucyBtYXhpbXVtIG51bWJlciBvZiBmaWxlcywgY2hpbGQg
Y2xvc2VzIG9uZSBhbmQKPiA+ID4gYXR0ZW1wdHMgdG8KPiA+ID4gb3BlbiBhbm90aGVyLiBUaGF0
IGlzIG5vdCBleGFjdGx5IHRoZSBzYW1lLCBidXQgaXQncyB2ZXJ5IHNpbWlsYXIuCgo+ID4gPiBJ
J20gbm90IHN1cmUgaWYgdGhlIHNjZW5hcmlvIHdvdWxkIHJlYWxseSB0ZXN0cyBkaWZmZXJlbnQg
Y29kZSBwYXRoIGluCj4gPiA+IGtlcm5lbC9saWJjIG9yIG5vdCBhbmQgd2UgY2FuIGhhcHBpbHkg
ZGVsZXRlIGl0Lgo+ID4gPiBDeXJpbCwgV0RZVD8KCj4gPiBATGksIFdEWVQ/CgoKPiBQZXRyLCBJ
IHRoaW5rIHlvdSdyZSByaWdodCwgdGhleSdyZSBub3QgdGhlIHNhbWUgdGVzdC4KCj4gSW4gZm9y
azEwIHBhcmVudCB0cmllcyB0byB2ZXJpZnkgdGhlIGNvbnRlbnRzIG9mIHRoZSBmaWxlIHRoYXQg
cmVzZXQgdGhlCj4gZmlsZSBvZmZzZXQgcG9pbnRlciBieSBjaGlsZC4KCj4gQnV0IGZvcjA5IGlz
IGEgYm91bmRlciB0ZXN0IHRvIHZlcmlmeSBpZiB0aGUgY2hpbGQgY2FuIG9wZW4gb25lIG1vcmUg
ZmlsZQo+IHdoZW4gJ2ZkJyBudW1iZXIgYXBwcm9hY2hlcyAoT3Blbk1heC0xKS4KClRoYW5rIHlv
dSEgQ2xvc2luZyB0aGlzIGFzIHJlamVjdGVkLCBBbmRyZWEgZmVlbCBmcmVlIHRvIHJld3JpdGUg
dGhlIHRlc3QgYXMKd2VsbC4KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
