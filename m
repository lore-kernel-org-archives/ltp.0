Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7A1C27C75
	for <ltp@archiver.kernel.org>; Fri, 14 Jun 2024 08:18:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 209FB3D0C8B
	for <ltp@archiver.kernel.org>; Fri, 14 Jun 2024 10:18:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 802A23D0C48
 for <ltp@lists.linux.it>; Fri, 14 Jun 2024 10:18:22 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DEA6D60B2C2
 for <ltp@lists.linux.it>; Fri, 14 Jun 2024 10:18:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D1DB220207;
 Fri, 14 Jun 2024 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718353099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mYqOxoD36u8V4oSBzFdqoifR0Tb4tgfBlg3Eo3eE0WE=;
 b=MV0Zq5S3eOE414OZLyPu3UkR/Naojbvhtlvju9/XeOrGPDCYl+LHynIlLDZlbHmx4OIMAP
 MU5C1X6buO3QVCx4koU1aGwfY5FuULMVI1U4ORm/3SGtUcCbjwAKghxsYaXyQRD19NmK94
 Q05sUwJqAj1K0t2NnETtAOcl5OHysmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718353099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mYqOxoD36u8V4oSBzFdqoifR0Tb4tgfBlg3Eo3eE0WE=;
 b=yOYESIXvAqPPOplDaWgGq5jsEhnFzSOCUh3CIUpxl/CnL9NRC0v5qhO3G17rPrXpkUtygj
 b1vyOU7s38/BWeBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718353099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mYqOxoD36u8V4oSBzFdqoifR0Tb4tgfBlg3Eo3eE0WE=;
 b=MV0Zq5S3eOE414OZLyPu3UkR/Naojbvhtlvju9/XeOrGPDCYl+LHynIlLDZlbHmx4OIMAP
 MU5C1X6buO3QVCx4koU1aGwfY5FuULMVI1U4ORm/3SGtUcCbjwAKghxsYaXyQRD19NmK94
 Q05sUwJqAj1K0t2NnETtAOcl5OHysmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718353099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mYqOxoD36u8V4oSBzFdqoifR0Tb4tgfBlg3Eo3eE0WE=;
 b=yOYESIXvAqPPOplDaWgGq5jsEhnFzSOCUh3CIUpxl/CnL9NRC0v5qhO3G17rPrXpkUtygj
 b1vyOU7s38/BWeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B416E13AB1;
 Fri, 14 Jun 2024 08:18:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0lx5K8v8a2bCYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jun 2024 08:18:19 +0000
Date: Fri, 14 Jun 2024 10:18:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240614081817.GA168224@pevik>
References: <CAOQ4uxip8tD8H691qTcA8YFkcT78_iwQXy17=mJzyv6WWUaunQ@mail.gmail.com>
 <171815759406.14261.8092450471234028375@noble.neil.brown.name>
 <20240612071252.GA98398@pevik>
 <CAOQ4uxgyHrTR_-b5tKdtuCoyoKdrVWb=-h-CbiSP2pHVHM--CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgyHrTR_-b5tKdtuCoyoKdrVWb=-h-CbiSP2pHVHM--CQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] NFS: add atomic_open for NFSv3 to handle O_TRUNC
 correctly.
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
Cc: Aishwarya.TCV@arm.com, Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.de>,
 linux-nfs@vger.kernel.org, broonie@kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBXZWQsIEp1biAxMiwgMjAyNCBhdCAxMDoxMuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PiB3cm90ZToKCj4gPiA+IE9uIFR1ZSwgMTEgSnVuIDIwMjQsIEFtaXIgR29sZHN0ZWlu
IHdyb3RlOgo+ID4gPiA+IE9uIFR1ZSwgSnVuIDExLCAyMDI0IGF0IDU6MzDigK9BTSBOZWlsQnJv
d24gPG5laWxiQHN1c2UuZGU+IHdyb3RlOgoKPiA+ID4gPiA+IE9uIEZyaSwgMDcgSnVuIDIwMjQs
IEphbWVzIENsYXJrIHdyb3RlOgoKPiA+ID4gPiA+ID4gSGkgTmVpbCwKCj4gPiA+ID4gPiA+IE5v
dyB0aGF0IHlvdXIgZml4IGlzIGluIGxpbnV4LW5leHQgdGhlIHN0YXR2ZnMwMSB0ZXN0IGlzIHBh
c3NpbmcgYWdhaW4uCj4gPiA+ID4gPiA+IEhvd2V2ZXIgaW5vdGlmeTAyIGlzIHN0aWxsIGZhaWxp
bmcuCgo+ID4gPiA+ID4gPiBUaGlzIGlzIGJlY2F1c2UgdGhlIHRlc3QgZXhwZWN0cyB0aGUgSU5f
Q1JFQVRFIGFuZCBJTl9PUEVOIGV2ZW50cyB0bwo+ID4gPiA+ID4gPiBjb21lIGluIHRoYXQgb3Jk
ZXIgYWZ0ZXIgY2FsbGluZyBjcmVhdCgpLCBidXQgbm93IHRoZXkgYXJlIHJldmVyc2VkLiBUbwo+
ID4gPiA+ID4gPiBtZSBpdCBzZWVtcyBsaWtlIGl0IGNvdWxkIGJlIGEgdGVzdCBpc3N1ZSBhbmQg
dGhlIHRlc3Qgc2hvdWxkIGhhbmRsZQo+ID4gPiA+ID4gPiB0aGVtIGluIGVpdGhlciBvcmRlcj8g
T3IgbWF5YmUgdGhlcmUgc2hvdWxkIGJlIGEgc2luZ2xlIGlub3RpZnkgZXZlbnQKPiA+ID4gPiA+
ID4gd2l0aCBib3RoIGZsYWdzIHNldCBmb3IgdGhlIGF0b21pYyBvcGVuPwoKPiA+ID4gPiA+IElu
dGVyZXN0aW5nLi4uLiAgSSBkb24ndCBzZWUgaG93IGFueSBmaWxlc3lzdGVtIHRoYXQgdXNlcyAt
PmF0b21pY19vcGVuCj4gPiA+ID4gPiB3b3VsZCBnZXQgdGhlc2UgaW4gdGhlICJyaWdodCIgb3Jk
ZXIgLSBhbmQgSSBkbyB0aGluayBJTl9DUkVBVEUgc2hvdWxkCj4gPiA+ID4gPiBjb21lIGJlZm9y
ZSBJTl9PUEVOLgoKPiA+ID4gPiBDb3JyZWN0LgoKCj4gPiA+ID4gPiBEb2VzIE5GU3Y0IHBhc3Mg
dGhpcyB0ZXN0PwoKPiA+ID4gPiBQcm9iYWJseSBub3QuCgoKPiA+ID4gPiA+IElOX09QRU4gaXMg
Z2VuZXJhdGVkIChieSBmc25vdGlmeV9vcGVuKCkpIHdoZW4gZmluaXNoX29wZW4oKSBpcyBjYWxs
ZWQsCj4gPiA+ID4gPiB3aGljaCBtdXN0IGJlIChhbmQgaXMpIGNhbGxlZCBieSBhbGwgYXRvbWlj
X29wZW4gZnVuY3Rpb25zLgo+ID4gPiA+ID4gSU5fQ1JFQVRFIGlzIGdlbmVyYXRlZCAoYnkgZnNu
b3RpZnlfY3JlYXRlKCkpIHdoZW4gb3Blbl9sYXN0X2xvb2t1cHMoKQo+ID4gPiA+ID4gZGV0ZWN0
cyB0aGF0IEZNT0RFX0NSRUFURSB3YXMgc2V0IGFuZCB0aGF0IGhhcHBlbnMgKmFmdGVyKiBsb29r
dXBfb3BlbigpCj4gPiA+ID4gPiBpcyBjYWxsZWQsIHdoaWNoIGNhbGxzIGF0b21pY19vcGVuKCku
Cgo+ID4gPiA+ID4gRm9yIGZpbGVzeXN0ZW1zIHRoYXQgZG9uJ3QgdXNlIGF0b21pY19vcGVuLCB0
aGUgSU5fT1BFTiBpcyBnZW5lcmF0ZWQgYnkKPiA+ID4gPiA+IHRoZSBjYWxsIHRvIGRvX29wZW4o
KSB3aGljaCBoYXBwZW5zICphZnRlciogb3Blbl9sYXN0X2xvb2t1cHMoKSwgbm90Cj4gPiA+ID4g
PiBpbnNpZGUgaXQuCgo+ID4gPiA+IENvcnJlY3QuCgoKPiA+ID4gPiA+IFNvIHRoZSBsdHAgdGVz
dCBtdXN0IGFscmVhZHkgZmFpbCBmb3IgTkZTdjQsIDlwIGNlcGggZnVzZSBnZnMyIG50ZnMzCj4g
PiA+ID4gPiBvdmVybGF5ZnMgc21iLgoKCj4gPiA+ID4gaW5vdGlmeTAyIGRvZXMgbm90IHJ1biBv
biBhbGxfZmlsZXN5c3RlbXMsIG9ubHkgb24gdGhlIG1haW4gdGVzdCBmcywKPiA+ID4gPiB3aGlj
aCBpcyBub3QgdmVyeSBvZnRlbiBvbmUgb2YgdGhlIGFib3ZlLgoKPiA+ID4gPiBUaGlzIGlzIGhv
dyBJIGF2ZXJ0ZWQgdGhlIHByb2JsZW0gaW4gZmFub3RpZnkxNiAod2hpY2ggZG9lcyBydW4gb24K
PiA+ID4gPiBhbGxfZmlsZXN5c3RlbXMpOgoKPiA+ID4gPiBjb21taXQgOTA2MjgyNGE3MGI4ZGE3
NGFhNWIxZGIwODcxMGQwMDE4YjQ4MDcyZQo+ID4gPiA+IEF1dGhvcjogQW1pciBHb2xkc3RlaW4g
PGFtaXI3M2lsQGdtYWlsLmNvbT4KPiA+ID4gPiBEYXRlOiAgIFR1ZSBOb3YgMjEgMTI6NTI6NDcg
MjAyMyArMDIwMAoKPiA+ID4gPiAgICAgZmFub3RpZnkxNjogRml4IHRlc3QgZmFpbHVyZSBvbiBG
VVNFCgo+ID4gPiA+ICAgICBTcGxpdCBTQUZFX0NSRUFUKCkgaW50byBleHBsaWNpdCBTQUZFX01L
Tk9EKCkgYW5kIFNBRkVfT1BFTigpLAo+ID4gPiA+ICAgICBiZWNhdXNlIHdpdGggYXRvbWljIG9w
ZW4gKGUuZy4gZnVzZSksIFNBRkVfQ1JFQVQoKSBnZW5lcmF0ZXMgRkFOX09QRU4KPiA+ID4gPiAg
ICAgYmVmb3JlIEZBTl9DUkVBVEUgKHRlc3RlZCB3aXRoIG50ZnMtM2cpLCB3aGljaCBpcyBpbmNv
bnNpc3RlbnQgd2l0aAo+ID4gPiA+ICAgICB0aGUgb3JkZXIgb2YgZXZlbnRzIGV4cGVjdGVkIGZy
b20gb3RoZXIgZmlsZXN5c3RlbXMuCgo+ID4gPiA+IGlub3RpZnkwMiBzaG91bGQgYmUgZml4ZWQg
c2ltaWxhcmx5LgoKPiA+ID4gQWx0ZXJuYXRlbHkgLSBtYXliZSB0aGUga2VybmVsIHNob3VsZCBi
ZSBmaXhlZCB0byBhbHdheXMgZ2V0IHRoZSBvcmRlcgo+ID4gPiByaWdodC4KPiA+ID4gSSBoYXZl
IGEgcGF0Y2guICBJJ2xsIHBvc3QgaXQgc2VwYXJhdGVseS4KCj4gPiBAQW1pciwgaWYgbGF0ZXIg
TmVpbCdzIGJyYW5jaCBnZXQgbWVyZ2VkLCBtYXliZSB3ZSBzaG91bGQgdXNlIG9uIGZhbm90aWZ5
MTYKPiA+IGNyZWF0KCkgb24gdGhlIG9sZCBrZXJuZWxzIChhcyBpdCB3YXMgaW4gYmVmb3JlIHlv
dXIgZml4IDkwNjI4MjRhNyAoImZhbm90aWZ5MTY6Cj4gPiBGaXggdGVzdCBmYWlsdXJlIG9uIEZV
U0UiKSksIGJhc2VkIG9uIGtlcm5lbCBjaGVjay4KCgo+IEkgYW0gaG9waW5nIHRoYXQgdGhlIGZp
eCBjb3VsZCBiZSBiYWNrcG9ydGVkIHRvIHY2LjkueSBhbmQgdGhlbiB3ZQo+IHdvbid0IG5lZWQg
dG8gd29ycnkgYWJvdXQgb2xkZXIgTFRTIGtlcm5lbHMgZm9yIGZhbm90aWZ5MTYsIGJlY2F1c2UK
PiBmdXNlIG9ubHkgc3VwcG9ydHMgRkFOX0NSRUFURSBzaW5jZSB2Ni44LgoKR3JlYXQhIFRoYW5r
cyBmb3IgaW5mby4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiBUaGFua3MsCj4gQW1pci4KCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
