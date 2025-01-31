Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC700C0218F
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 16:42:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9E243C7B16
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 17:42:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6C313C29ED
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 17:42:21 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E7B161415547
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 17:42:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1BBFE21169;
 Fri, 31 Jan 2025 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738341739;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeyCOSGivczsfw6Npcn6pM9AZn7xI7kESl9X5A75ZH8=;
 b=wGb1c28Aq6NudVkfu/fQVs7Xl8riJWT/C9/oEbAYd1BzYRnNoABNIBsYFYnpVBaCf8gz3A
 nuyp/Fm8JUdlDzp/J2xmO7E66QVK2Xa1uiTQpOJuYU1N62bRiWdx9V9V03CCP7/5ZfGD/i
 1TH5cDPMIYtSGRpYJiBt+oGI99JfsX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738341739;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeyCOSGivczsfw6Npcn6pM9AZn7xI7kESl9X5A75ZH8=;
 b=cpqyv5ynizzW+sQH+mA9m95R9SqOmIggvqgM6472jQ93oZowrJ6Nza07DURAkKomdFOmjK
 ZT7+wY6W+ZSPxtDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738341739;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeyCOSGivczsfw6Npcn6pM9AZn7xI7kESl9X5A75ZH8=;
 b=wGb1c28Aq6NudVkfu/fQVs7Xl8riJWT/C9/oEbAYd1BzYRnNoABNIBsYFYnpVBaCf8gz3A
 nuyp/Fm8JUdlDzp/J2xmO7E66QVK2Xa1uiTQpOJuYU1N62bRiWdx9V9V03CCP7/5ZfGD/i
 1TH5cDPMIYtSGRpYJiBt+oGI99JfsX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738341739;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeyCOSGivczsfw6Npcn6pM9AZn7xI7kESl9X5A75ZH8=;
 b=cpqyv5ynizzW+sQH+mA9m95R9SqOmIggvqgM6472jQ93oZowrJ6Nza07DURAkKomdFOmjK
 ZT7+wY6W+ZSPxtDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C04B7139B1;
 Fri, 31 Jan 2025 16:42:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RRKjLWr9nGf0IwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jan 2025 16:42:18 +0000
Date: Fri, 31 Jan 2025 17:42:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250131164217.GA1135694@pevik>
References: <20250122172440.506677-1-amir73il@gmail.com>
 <20250122205023.GA48906@pevik> <Z5NveZVCczMxwDpP@yuki.lan>
 <20250130200731.GA513192@pevik>
 <CAOQ4uxjDwVaoqWu1ix1_sv5YbkKQ8Ve+R-u37gfB4hXemNVhaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjDwVaoqWu1ix1_sv5YbkKQ8Ve+R-u37gfB4hXemNVhaQ@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-0.999];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_TO(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] LTP fanotify tests for v6.13
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
Cc: Martin Doucha <martin.doucha@suse.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUaHUsIEphbiAzMCwgMjAyNSBhdCA5OjA34oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IEhpIGFsbCwKCj4gPiA+IEhpIQo+ID4gPiA+IFdlIGhhdmUgZ2l0
IGZyZWV6ZSBiZWZvcmUgbmV3IHJlbGVhc2UuIEJ1dCBJTUhPIHRoaXMgc2hvdWxkIGdvIGluLgo+
ID4gPiA+IEl0IHdvcmtzIHdlbGwgb24gdjYuMTMsIEknbGwgcmV0ZXN0IGl0IG9uIFNMRVMga2Vy
bmVscy4KCj4gPiA+IFdlIGFyZSBnb2luZyB0byByZWxlYXNlIExUUCBuZXh0IHdlZWssIEkgd291
bGQgc2F5IHRoYXQgaXQncyBub3QgZW5vdWdoCj4gPiA+IHRpbWUgdG8gcHJvcGVybHkgdGVzdCB0
aGVzZSBjaGFuZ2VzIGFuZCB0aGF0IHRoZSB0aW1pbmcgd2FzIHRvbwo+ID4gPiB1bmZvcnR1bmF0
ZSB0aGlzIHRpbWUuIEkgd291bGQgZGVmZmVyIG1lcmdpbmcgYWZ0ZXIgdGhlIHJlbGVhc2UuCgo+
ID4gTFRQIHdhcyByZWxlYXNlZCwgdGhlcmVmb3JlIG1lcmdpbmcgdGhlIHRlc3RzLiBUaGFua3Ms
IEFtaXIhCgoKPiBUaGFua3MhCgo+ID4gSSdtIG5vdCBzdXJlIGlmIHlvdSBwbGFuIHRvIHNwbGl0
IHRoZSB0ZXN0cyAoaG9wZWZ1bGx5IHlvdSBnb3QgZW5vdWdoIGluZm8gYWJvdXQKPiA+IHRoZSBn
b2FsKS4gSWYgbm90LCBJIG9yIE1hcnRpbiBzaG91bGQgZG8gaXQuCgo+IEkgd2Fzbid0IHBsYW5u
aW5nIHRvIHNwbGl0IHRoZSB0ZXN0cy4KPiBJTU8gc3BsaXR0aW5nIHRoZSB0ZXN0cyBwcm9wZXJs
eSB0byBhdm9pZCB0b28gbXVjaCBjb2RlIGRlZHVwZQo+IHJlcXVpcmVzIGEgbG90IG9mIHJlZmFj
dG9yaW5nLCB3aGljaCBJIGhhdmUgbm8gdGltZSBmb3IgcmlnaHQgbm93LgoKU3VyZSwgdW5kZXJz
dGFuZC4KCj4gQnV0IHBsZWFzZSBmZWVsIGZyZWUgdG8gc3BsaXQgd2l0aCBvciB3aXRob3V0IGNv
ZGUgZGVkdXBlIGFuZCBDQyBtZQo+IGZvciB0aGUgcmV2aWV3LgoKU3VyZSAoaG9wZWZ1bGx5IHdp
dGhvdXQgY29kZSBkZWR1cGUpLiBJJ20gbm90IHN1cmUgbXlzZWxmIHdoZW4gd2UgZ2V0IGludG8g
aXQuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gVGhhbmtzLAo+IEFtaXIuCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
