Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E1BC48BF6
	for <ltp@archiver.kernel.org>; Sun,  3 Mar 2024 13:04:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB57E3CEC0F
	for <ltp@archiver.kernel.org>; Sun,  3 Mar 2024 14:04:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40AE23CCBCF
 for <ltp@lists.linux.it>; Sun,  3 Mar 2024 14:04:13 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 690F61A0036C
 for <ltp@lists.linux.it>; Sun,  3 Mar 2024 14:04:12 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7CE253EDB3;
 Sun,  3 Mar 2024 13:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709471051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dMNsXWNSxfOghd3KQGZfsT4QfLJ9p9wKWREFguVtow=;
 b=Y69T5OD7PSYzasfGSGeqQQ1yk/wKlhjpopFl+NF/zt8D45ghFpJ5hNZ2+L29lF9e+mzc77
 LmWG/0XunomfIIRd06Vbb+DXJASoIy874pO0RDLCFAIkPBOieldPR02k89SUl4yqmDvDYs
 OF0m1nCYvMc8bnZlZwqF7cpnojwTTqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709471051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dMNsXWNSxfOghd3KQGZfsT4QfLJ9p9wKWREFguVtow=;
 b=L0y/skOiaaB2MOwgswXPshwIlto0TB9ns9Ue3A2wC4eMdha9v4SCfyAcxQxYm/p5ezCsQo
 CvBE4ZH+/LMi5tBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709471051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dMNsXWNSxfOghd3KQGZfsT4QfLJ9p9wKWREFguVtow=;
 b=Y69T5OD7PSYzasfGSGeqQQ1yk/wKlhjpopFl+NF/zt8D45ghFpJ5hNZ2+L29lF9e+mzc77
 LmWG/0XunomfIIRd06Vbb+DXJASoIy874pO0RDLCFAIkPBOieldPR02k89SUl4yqmDvDYs
 OF0m1nCYvMc8bnZlZwqF7cpnojwTTqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709471051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dMNsXWNSxfOghd3KQGZfsT4QfLJ9p9wKWREFguVtow=;
 b=L0y/skOiaaB2MOwgswXPshwIlto0TB9ns9Ue3A2wC4eMdha9v4SCfyAcxQxYm/p5ezCsQo
 CvBE4ZH+/LMi5tBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 54551139D1;
 Sun,  3 Mar 2024 13:04:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id B3BHEkt15GXrNQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Sun, 03 Mar 2024 13:04:11 +0000
Date: Sun, 3 Mar 2024 14:04:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240303130405.GA1856074@pevik>
References: <20240301015037.22061-1-wegao@suse.com>
 <CAEemH2e_7sD==18K2174SnGcJWiA8B0Zco2GwHdavoBatXuAbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e_7sD==18K2174SnGcJWiA8B0Zco2GwHdavoBatXuAbQ@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.67 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.03)[56.01%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] libswap.c: Check free space with correct mnt
 path
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

SGkgV2VpLCBMaSwKCj4gSGkgV2VpLAoKPiBHb29kIGNhdGNoIQoKR3JlYXQsIHRoYW5rcywgbWVy
Z2VkIQooVGVzdGVkIGF0IGxlYXN0IG9uIGludGVsLikKCj4gUmV2aWV3ZWQtYnk6IExpIFdhbmcg
PGxpd2FuZ0ByZWRoYXQuY29tPgoKCj4gT24gRnJpLCBNYXIgMSwgMjAyNCBhdCA5OjUx4oCvQU0g
V2VpIEdhbyB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+IHdyb3RlOgoKPiA+IFRoZSB0c3Rf
ZnNfaGFzX2ZyZWUgc2hvdWxkIGNoZWNrIGZzIHNpemUgb2YgbW50IHBvaW50Lgo+ID4gQnV0IGN1
cnJlbnQgY29kZSBjaGVjayAiLiIsIHRoYXQgbWVhbnMgY2hlY2sgL3RtcC9MVFBfeHh4Cj4gPiBp
bnN0ZWFkIG9mIC90bXAvTFRQX3h4eC9tbnRwb2ludC4KCj4gPiBBbHNvIHRzdF9mc19oYXNfZnJl
ZSdzICJzaXplIiBwYXJhbWV0ZXIncyB0eXBlIGlzIHVuc2lnbmVkIGludCwKPiA+IGl0IHdpbGwg
b3ZlcmZsb3cgaWYgZW5jb3VudGVyIGJpZyBmaWxlc3lzdGVtIGJsb2NrIHNpemUoc3VjaCBhcyBC
dHJmcwo+ID4gY2FuIHVzZSA2NGspLgoKSSB3b3VsZCBwZXJzb25hbGx5IGFkZGVkIHRoaXMgYXMg
c2VwYXJhdGUgcHJldmlvdXMgcGF0Y2gsIGJ1dCBrZXB0IGFzIGlzLgoKLi4uCj4gPiArKysgYi9s
aWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jCj4gPiBAQCAtMTM3LDYgKzEzNyw3IEBAIGludCBtYWtl
X3N3YXBmaWxlKGNvbnN0IGNoYXIgKnN3YXBmaWxlLCBpbnQgYmxvY2tzLAo+ID4gaW50IHNhZmUp
Cj4gPiAgICAgICAgIHN0cnVjdCBzdGF0dmZzIGZzX2luZm87Cj4gPiAgICAgICAgIHVuc2lnbmVk
IGxvbmcgYmxrX3NpemUsIGJzOwo+ID4gICAgICAgICBzaXplX3QgcGdfc2l6ZSA9IHN5c2NvbmYo
X1NDX1BBR0VTSVpFKTsKPiA+ICsgICAgICAgY2hhciBtbnRfcGF0aFsxMDBdOwoKPiA+ICAgICAg
ICAgaWYgKHN0YXR2ZnMoIi4iLCAmZnNfaW5mbykgPT0gLTEpCj4gPiAgICAgICAgICAgICAgICAg
cmV0dXJuIC0xOwo+ID4gQEAgLTE0OSw3ICsxNTAsOCBAQCBpbnQgbWFrZV9zd2FwZmlsZShjb25z
dCBjaGFyICpzd2FwZmlsZSwgaW50IGJsb2NrcywKPiA+IGludCBzYWZlKQo+ID4gICAgICAgICBl
bHNlCj4gPiAgICAgICAgICAgICAgICAgYnMgPSBibGtfc2l6ZTsKCj4gPiAtICAgICAgIGlmICgh
dHN0X2ZzX2hhc19mcmVlKCIuIiwgYnMgKiBibG9ja3MsIFRTVF9CWVRFUykpCj4gPiArICAgICAg
IHNzY2FuZihzd2FwZmlsZSwgIiVbXi9dIiwgbW50X3BhdGgpOwoKQWx0aG91Z2ggdGhpcyBzaG91
bGQgbmV2ZXIgZmFpbCwgSSBjaGFuZ2VkIGl0IHRvIGNoZWNrIHJldHVybiB2YWx1ZToKCi0gICAg
ICAgaWYgKCF0c3RfZnNfaGFzX2ZyZWUoIi4iLCBicyAqIGJsb2NrcywgVFNUX0JZVEVTKSkKKyAg
ICAgICBpZiAoc3NjYW5mKHN3YXBmaWxlLCAiJVteL10iLCBtbnRfcGF0aCkgIT0gMSkKKyAgICAg
ICAgICAgICAgIHRzdF9icmsoVEJST0ssICJzc2NhbmYgZmFpbGVkIik7CgpBbmQgSSdsbCBhc2sg
QW5kcmVhIE1hbnppbmkgdG8gYWRkIFNBRkVfU1NDQU5GKCkgKGVhc3kgaGFjaykuCgpLaW5kIHJl
Z2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
