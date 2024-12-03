Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E96E74AC3
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 16:22:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C76283DE798
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 17:22:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD5323DE77D
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 17:22:27 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=dsterba@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 730EE1439983
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 17:22:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4A1B22111F;
 Tue,  3 Dec 2024 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733242944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rPsvvaWSf5EInVJ6+/I67B6CD791tTlwfTh2OD9QIo=;
 b=LjAQFJELwBc4At8UHc+cKSRonjJLGh617Iw0wki32EGM23ubMjNEBEyNnABRwTRkqmjBys
 5N7op2VJKbsgS+Y9GbGmOagREn1KQafmAm3qVGQyKFd7ceqks5M5o5JxqTgxi3ZkU32T6i
 8P/rxF1lPBj9f06yLGnkWAoo23VNRDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733242944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rPsvvaWSf5EInVJ6+/I67B6CD791tTlwfTh2OD9QIo=;
 b=Zso3rvvKrpbrXSuEEfKbxr2gdua7W6hsG9nUQAKKXZoJTS2Dumt2dp36i57NewWPK78jIg
 RJ+lsdhnKiXYguCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LjAQFJEL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Zso3rvvK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733242944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rPsvvaWSf5EInVJ6+/I67B6CD791tTlwfTh2OD9QIo=;
 b=LjAQFJELwBc4At8UHc+cKSRonjJLGh617Iw0wki32EGM23ubMjNEBEyNnABRwTRkqmjBys
 5N7op2VJKbsgS+Y9GbGmOagREn1KQafmAm3qVGQyKFd7ceqks5M5o5JxqTgxi3ZkU32T6i
 8P/rxF1lPBj9f06yLGnkWAoo23VNRDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733242944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rPsvvaWSf5EInVJ6+/I67B6CD791tTlwfTh2OD9QIo=;
 b=Zso3rvvKrpbrXSuEEfKbxr2gdua7W6hsG9nUQAKKXZoJTS2Dumt2dp36i57NewWPK78jIg
 RJ+lsdhnKiXYguCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2850813A15;
 Tue,  3 Dec 2024 16:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UM+jCUAwT2fCWQAAD6G6ig
 (envelope-from <dsterba@suse.cz>); Tue, 03 Dec 2024 16:22:24 +0000
Date: Tue, 3 Dec 2024 17:22:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <20241203162222.GD31418@twin.jikos.cz>
References: <20241201093606.68993-1-zlang@kernel.org>
 <d1682e7d-9b1d-44cc-963a-1b1c5394fb2d@gmx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d1682e7d-9b1d-44cc-963a-1b1c5394fb2d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4A1B22111F
X-Spamd-Result: default: False [-4.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HAS_REPLYTO(0.30)[dsterba@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[gmx.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmx.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] LTP random fixes for xfs and btrfs
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
Reply-To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, Zorro Lang <zlang@kernel.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU3VuLCBEZWMgMDEsIDIwMjQgYXQgMDg6MjU6MTlQTSArMTAzMCwgUXUgV2VucnVvIHdyb3Rl
Ogo+IAo+IAo+IOWcqCAyMDI0LzEyLzEgMjA6MDYsIFpvcnJvIExhbmcg5YaZ6YGTOgo+ID4gW1BB
VENIIDEvM10gaW9jdGxfZmljbG9uZTAyLmM6IHNldCBhbGxfZmlsZXN5c3RlbXMgdG8gemVybwo+
ID4KPiA+ICAgIEl0IGRvZXNuJ3Qgc2tpcCBmaWxlc3lzdGVtcyBhcyBpdHMgcGxhbiwgZml4IGl0
Lgo+ID4KPiA+IFtQQVRDSCAyLzNdIHN0YXQwNCtsc3RhdDAzOiBmaXggYmFkIGJsb2Nrc2l6ZSBt
a2ZzIG9wdGlvbiBmb3IgeGZzCj4gPgo+ID4gICAgbWtmcy54ZnMgZG9lc24ndCBzdXBwb3J0ICIt
YiAxMDI0IiwgbmVlZHMgIi1iIHNpemU9MTAyNCIKPiA+Cj4gPiBbUEFUQ0ggMy8zXSBzdGF0MDQr
bHN0YXQwMzogc2tpcCB0ZXN0IG9uIGJ0cmZzCj4gPgo+ID4gICAgVGhlICItYiIgb3B0aW9uIG9m
IG1rZnMuYnRyZnMgaXNuJ3QgYSBibG9ja3NpemUgb3B0aW9uLCB0aGVyZSdzIG5vdCBibG9ja3Np
emUKPiA+ICAgIG9wdGlvbiBpbiBta2ZzLmJ0cmZzLiBTbyBJJ2QgbGlrZSB0byBza2lwIHRoaXMg
dGVzdCBmb3IgYnRyZnMuIEJ1dCBJJ20gbm90Cj4gPiAgICBzdXJlIGlmIHRoZXJlJ3MgYmV0dGVy
IHdheSwgc28gQ0MgKmJ0cmZzIGxpc3QqIHRvIGdldCBtb3JlIHJldmlldyBwb2ludHMgZm9yCj4g
PiAgICB0aGF0Lgo+ID4gICAgKEJUVywgYmV0dGVyIHRvIGhhdmUgYSBjb21tb24gaGVscGVyIHRv
IGRlYWwgd2l0aCBkaWZmZXJlbnQgZmlsZXN5c3RlbXMnCj4gPiAgICAgYmxvY2tzaXplIG9wdGlv
bnMgaW4gdGhlIGZ1dHVyZSkKPiA+Cj4gCj4gV2VsbCwgSSdkIHNheSBXaWxjb3ggaXMga2luZGEg
Y29ycmVjdCBoZXJlLgo+IAo+IEJ0cmZzIHVzZXMgdGhlIG5hbWUgInNlY3RvciBzaXplIiB0byBp
bmRpY2F0ZSB0aGUgbWluaW1hbCB1bml0LCBha2EsIHRoZQo+IGJsb2Nrc2l6ZSBvZiBhbGwgdGhl
IG90aGVyIGZzZXMuCj4gCj4gTm90IHN1cmUgaWYgd2Ugd2lsbCBldmVuIHJlbmFtZSB0aGUgd2hv
bGUgc2VjdG9yIHNpemUgdG8gYmxvY2sgc2l6ZSBpbgo+IHRoZSBmdXR1cmUsIGl0IGxvb2tzIGxp
a2UgYSBodWdlIHdvcmsgdG8gZG8uCgpXZWxsLCBJIHRoaW5rIHdlIGNhbiBhdCBsZWFzdCBhZGQg
YW4gYWxpYXMgYmxvY2tzaXplIHRvIHNlY3RvcnNpemUgdG8KbWtmcy4gIFdlIGRvbid0IGhhdmUg
YSB0aW1lIG1hY2hpbmUgdG8gY2hhbmdlIHRoZSBpbml0aWFsIGNvbmZ1c2luZwpuYW1pbmcsIGJ1
dCBjYW4gc2xpZ2h0bHkgaW1wcm92ZSB0aGUgdXNlciBjb252ZW5pZW5jZS4gIEludGVybmFsbHkg
aW4KdGhlIGNvZGUgd2UgY2FuIGtlZXAgc2VjdG9yc2l6ZSBvciBpbmNyZW1lbnRhbGx5IHJlbmFt
ZSBpdCB0byBibG9ja3NpemUuCldoYXQgbWF0dGVycyBtb3JlIGhlcmUgaXMgdGhlIHVzZXIgaW50
cmZhY2UsIGkuZS4gdGhlIG1rZnMgb3B0aW9ucy4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
