Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF00AC27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 19:54:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F10223D0B60
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 21:54:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 198683C9430
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 21:54:26 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0B7141000455
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 21:54:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0CF62005D;
 Mon, 10 Jun 2024 19:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718049263;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2j5Egki3vSh4s1sNn342bdXx96XC9DjULPfQ8vZ3SY=;
 b=cYWmoXXYI+SqpC85x60CZIbHjXw7OGFRNRm3V2Fu6uUyEd4fSLKtpfG7T8ngMaFEzoMBLx
 GfbwbZM8FUo9nnnWacOyWyMK6beBbVr1mPHzvfArjDSU24IzI3eVfwJFzjcN7wi3dMQJhK
 FVashIl4hWhKfQlEBhVgkO6hw+i/z+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718049263;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2j5Egki3vSh4s1sNn342bdXx96XC9DjULPfQ8vZ3SY=;
 b=eB/lNTUtxCR22RVxSvoA/9D7H0jwMZPIMBejNVXFRwaKqlJFfPkVx6FqopbTY/bBmtuQ3d
 ONmRqU0Wknt6/RCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718049263;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2j5Egki3vSh4s1sNn342bdXx96XC9DjULPfQ8vZ3SY=;
 b=cYWmoXXYI+SqpC85x60CZIbHjXw7OGFRNRm3V2Fu6uUyEd4fSLKtpfG7T8ngMaFEzoMBLx
 GfbwbZM8FUo9nnnWacOyWyMK6beBbVr1mPHzvfArjDSU24IzI3eVfwJFzjcN7wi3dMQJhK
 FVashIl4hWhKfQlEBhVgkO6hw+i/z+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718049263;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2j5Egki3vSh4s1sNn342bdXx96XC9DjULPfQ8vZ3SY=;
 b=eB/lNTUtxCR22RVxSvoA/9D7H0jwMZPIMBejNVXFRwaKqlJFfPkVx6FqopbTY/bBmtuQ3d
 ONmRqU0Wknt6/RCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A6AC13A7F;
 Mon, 10 Jun 2024 19:54:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4SyeD+9ZZ2ZxHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Jun 2024 19:54:23 +0000
Date: Mon, 10 Jun 2024 21:54:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Tim Orling <ticotimo@gmail.com>
Message-ID: <20240610195421.GA790951@pevik>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <CANx9H-C5KiqhVEp+Dysydsx8Kwvcy3VO+vSEfxWRFSeLEA47Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANx9H-C5KiqhVEp+Dysydsx8Kwvcy3VO+vSEfxWRFSeLEA47Ug@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBGcmksIEp1biA3LCAyMDI0IGF0IDc6NTDigK9BTSBSaWNoYXJkIFB1cmRpZSB2aWEgbGlz
dHMueW9jdG9wcm9qZWN0Lm9yZwo+IDxyaWNoYXJkLnB1cmRpZT1saW51eGZvdW5kYXRpb24ub3Jn
QGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+IHdyb3RlOgoKPiA+IE9uIEZyaSwgMjAyNC0wNi0wNyBh
dCAxNjoyNCArMDIwMCwgUGV0ciBWb3JlbCB2aWEKPiA+IGxpc3RzLnlvY3RvcHJvamVjdC5vcmcg
d3JvdGU6Cj4gPiA+IGtpcmsgaXMgbm90IHBlcmZlY3QgYnV0IGFscmVhZHkgbXVjaCBiZXR0ZXIg
dGhhbiBvbGQgcnVubHRwIHNjcmlwdC4KPiA+ID4gTGV0J3MgZGVwcmVjYXRlIHJ1bmx0cCBhbmQg
cHJvcGFnYXRlIGtpcmsuCgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4KPiA+ID4gLS0tCj4gPiA+ICBydW5sdHAgfCAxMyArKysrKysrKysrKysrCj4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQoKPiA+IEknZCBub3RlIHRoYXQgWW9j
dG8gUHJvamVjdCdzIENJIGlzIHN0aWxsIHVzaW5nIHJ1bmx0cCBhbmQgd2UgaGF2ZSBubwo+ID4g
cmVjaXBlIGZvciBraXJrLCBvciBhbnkgZXhwZXJpZW5jZSBvZiB1c2luZyBpdC4gVGhpcyBkb2Vz
IHRoZXJlZm9yZQo+ID4gd29ycnkgbWUgYSBsaXR0bGUgYml0LCB0aGVyZSBhcHBlYXJzIHRvIGJl
IGEgbG90IG9mIGNvbXBsZXhpdHkgaW4ga2lyawo+ID4gd2UgZG9uJ3QgbmVlZC4KCgo+IEkgaGF2
ZSBiZWd1biBhIHJlY2lwZSBmb3Iga2lyay4gSSBrbm93IHZlcnkgbGl0dGxlIGFib3V0IHRoZSBy
ZXN0IG9mIGhvdyB3ZQo+IChZb2N0byBQcm9qZWN0KSBydW4gbHRwIG9yIGhvdyBraXJrIGlzIG1l
YW50IHRvIGJlIHVzZWQuCgo+IGh0dHBzOi8vZ2l0LnlvY3RvcHJvamVjdC5vcmcvcG9reS1jb250
cmliL2xvZy8/aD10aW1vL2tpcmsKCisxLiBNYXliZSBSaWNoYXJkIG9yIG90aGVyIHBlb3BsZSB3
aG8gZGlkIExUUCB1cGRhdGUgaW4gWW9jdG8gaW4gdGhlIHBhc3Q/CgpCVFcgd2UndmUganVzdCBy
ZWxlYXNlZCBraXJrIDEuMyAoMS4yICsgZmV3LCBidXQgcXVpdGUgaW1wb3J0YW50IHNzaCByZWxh
dGVkCmZ1bmN0aW9uYWwgZml4ZXMpLiBQbGVhc2UgaWRlYWxseSB1c2UgOTk4ZGYxYTVhYTUwMjZj
NWM5YjkxYjBjYWEzYjExODgxNDZhYTY3OAooaGFzaCBmb3IgMS4zKS4KCktpbmQgcmVnYXJkcywK
UGV0cgoKPiA+IENoZWVycywKCj4gPiBSaWNoYXJkCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
