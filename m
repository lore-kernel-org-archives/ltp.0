Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1EEF531D9
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 21:25:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC2A53E216F
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 23:25:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFE893D0106
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 23:24:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 256F71A0034F
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 23:24:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 97CF75BE4B;
 Mon, 13 Apr 2026 21:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776115481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrH0pjrNOVBF0njUpK8tC5f/2d1SKA/d1FbQYLf+IdI=;
 b=exGQF7zzond0ROYVA8TPW+P8398WMnfgFrFwrdxVTCqWBFB4TY829y0ZKmuQEsPI6yTBCO
 8Q8IYB5DmevU7YpFM9pxtDmFjXGcQYCFoNUjGDxmTnbz3KWkjMFOgchwGpc01ATuMIgVut
 BLcse3kyaGwSMy8ehkWv+ipn0xl0New=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776115481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrH0pjrNOVBF0njUpK8tC5f/2d1SKA/d1FbQYLf+IdI=;
 b=iXmozZGHFWm8xEaJsGAx4A9t7EOPT2if0zbe0tHZops28Lg/somUW/Rs10xz4pV1FKRb8c
 PKsCKt8JaDor9oDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776115481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrH0pjrNOVBF0njUpK8tC5f/2d1SKA/d1FbQYLf+IdI=;
 b=exGQF7zzond0ROYVA8TPW+P8398WMnfgFrFwrdxVTCqWBFB4TY829y0ZKmuQEsPI6yTBCO
 8Q8IYB5DmevU7YpFM9pxtDmFjXGcQYCFoNUjGDxmTnbz3KWkjMFOgchwGpc01ATuMIgVut
 BLcse3kyaGwSMy8ehkWv+ipn0xl0New=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776115481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrH0pjrNOVBF0njUpK8tC5f/2d1SKA/d1FbQYLf+IdI=;
 b=iXmozZGHFWm8xEaJsGAx4A9t7EOPT2if0zbe0tHZops28Lg/somUW/Rs10xz4pV1FKRb8c
 PKsCKt8JaDor9oDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B6CE4B0C1;
 Mon, 13 Apr 2026 21:24:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H9v3Gxlf3WkGEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Apr 2026 21:24:41 +0000
Date: Mon, 13 Apr 2026 23:24:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260413212440.GB164377@pevik>
References: <20260413115129.30239-1-chrubis@suse.cz>
 <20260413122243.3915-1-linuxtestproject.agent@gmail.com>
 <adz_e3PJmL9RPMt7@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adz_e3PJmL9RPMt7@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TAGGED_RCPT(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Treat kernel ntfs3 as a separate FS
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgo+IEhpIQo+ID4gPiBsaWI6IFRyZWF0IGtlcm5lbCBudGZzMyBhcyBhIHNlcGFy
YXRlIEZTCgpSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CgpHcmVhdCBp
ZGVhLCB0aGFua3MhCgo+ID4gPiBNZWFud2hpbGUgdGhpcyBldmVuIGNhdXNlZCBmYWlsdXJlcywg
d2hpY2ggaXMgaG93IHRoaXMgaXNzdWUgZmluYWx5Cj4gPiA+IHN1cmZhY2VkIHdpdGggYSBmdXNl
IGJhc2VkIE5URlMgbm90IGJlaW5nIHNraXBwZWQgcHJvcGVybHkgYmVjYXVzZSB0aGUKPiA+ID4g
dGVzdCBsaWJyYXJ5IGdvdCBjb25mdXNlZCB3aXRoIGhhdmluZyBib3RoIGtlcm5lbCBhbmQgZnVz
ZSBOVEZTCj4gPiA+IGF2YWlsYWJsZS4KCj4gPiBUd28gdHlwb3M6ICJmaW5hbHkiIC0+ICJmaW5h
bGx5IiwgImNhbGxsZWQiIC0+ICJjYWxsZWQiIChhIGZldyBsaW5lcwo+ID4gYmVsb3cpLgoKPiBJ
IHdpbGwgZml4IHRoZXNlIGJlZm9yZSBjb21taXRpbmcuCgo+ID4gU2luY2UgdGhpcyBmaXhlcyBh
IHJlYWwgZmFpbHVyZSwgcGxlYXNlIGNvbnNpZGVyIGFkZGluZyBhIEZpeGVzOiB0YWcKPiA+IHBv
aW50aW5nIHRvIHRoZSBMVFAgY29tbWl0IHRoYXQgaW50cm9kdWNlZCB0aGUgYnJva2VuIG50ZnMg
aGFuZGxpbmcuIElmCj4gPiB0aGUgaXNzdWUgcHJlZGF0ZXMgYW55IHNpbmdsZSBpZGVudGlmaWFi
bGUgY29tbWl0LCBkcm9wcGluZyB0aGUgdGFnIGlzCj4gPiBmaW5lIOKAlCBqdXN0IGNsYXJpZnkg
aW4gdGhlIHJlcGx5LgoKPiBIb3dldmVyIHRoaXMgb25lIGlzIG1vcmUgY29tcGxleCwgdGhlcmUg
aXNuJ3QgYSBzaW5nbGUgcGF0Y2ggdGhhdCBjYXVzZWQKPiB0aGUgcHJvYmxlbSwgbW9yZW92ZXIg
aXQgd2FzIHRyaWdnZXJlZCBvbmx5IGJ5IGFkZGl0aW9uIG9mIHRoZSBudGZzMwo+IGRyaXZlciBp
bnRvIHRoZSBrZXJuZWwuCgorMS4KClRyeWluZywgaWYgcGF0Y2h3b3JrIC8gYjQgdGFrZXMgdGhp
cyB0YWcgKGxpbmsgdG8gbG9yZSkuIEl0J2QgYmUgZ3JlYXQgaWYgd2UgaGFkCnRvb2xpbmcgcGF0
Y2h3b3JrLmtlcm5lbC5vcmcgKyBnaXQua2VybmVsLm9yZyBoYXZlIHNvIHRoYXQgd2Ugd291bGQg
bm90IGhhdmUgdG8KYWRkIGl0IG1hbnVhbGx5LgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sdHAvMjAyNjA0MTMxMTUxMjkuMzAyMzktMS1jaHJ1YmlzQHN1c2UuY3ovCgpLaW5kIHJlZ2Fy
ZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
