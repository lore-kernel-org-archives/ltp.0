Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006E4C3ABCC
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 15:42:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A11C3CC33F
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 17:42:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F4E43CC257
 for <ltp@lists.linux.it>; Tue, 13 May 2025 17:42:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9DF0B2005F1
 for <ltp@lists.linux.it>; Tue, 13 May 2025 17:42:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E48DA211B8;
 Tue, 13 May 2025 15:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747150922;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFQ6a1fEn6Si8j0zLSkV+Mb6LLitss4am0CpE5eInFg=;
 b=xLCTCmgqB2jF3gfGQQkRc1yTup05zg/xgbvXN9lKU9ej7m+opUhy7DGjzeSGljP2/ozpTA
 gBu1Vtibw3ppSEZeFSzvikpJAtkujEcOMEZCFtirg6sRmqZwdZrmEkXCGrtkZSM1+ce1XR
 xfoFG65tj9UBU6P90/z58uqK/KFG+bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747150922;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFQ6a1fEn6Si8j0zLSkV+Mb6LLitss4am0CpE5eInFg=;
 b=zyCIW4Wq5IDOelJ4q2ro47hOyfS8MlJIu4gXcDCNEZeRJLIJqV9C8RCgl4WIUykmRZ4UpK
 4CB7sf8RrheyCoDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747150922;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFQ6a1fEn6Si8j0zLSkV+Mb6LLitss4am0CpE5eInFg=;
 b=xLCTCmgqB2jF3gfGQQkRc1yTup05zg/xgbvXN9lKU9ej7m+opUhy7DGjzeSGljP2/ozpTA
 gBu1Vtibw3ppSEZeFSzvikpJAtkujEcOMEZCFtirg6sRmqZwdZrmEkXCGrtkZSM1+ce1XR
 xfoFG65tj9UBU6P90/z58uqK/KFG+bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747150922;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFQ6a1fEn6Si8j0zLSkV+Mb6LLitss4am0CpE5eInFg=;
 b=zyCIW4Wq5IDOelJ4q2ro47hOyfS8MlJIu4gXcDCNEZeRJLIJqV9C8RCgl4WIUykmRZ4UpK
 4CB7sf8RrheyCoDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86AE81365D;
 Tue, 13 May 2025 15:42:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 02PCHEpoI2gODAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 13 May 2025 15:42:02 +0000
Date: Tue, 13 May 2025 17:41:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250513154159.GA378903@pevik>
References: <20250513050530.47541-1-liwang@redhat.com>
 <aCM2PrCrCdPqNIGc@yuki.lan> <20250513125148.GA244619@pevik>
 <CAEemH2dng7ZaxVgYUFLcqy0aamgFstoCogdOKkA2+DPJWctpig@mail.gmail.com>
 <CAEemH2f2qUqOxxEoaGhgvMWn4Y_EfDNMod=bAETWXBDZFQFRgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f2qUqOxxEoaGhgvMWn4Y_EfDNMod=bAETWXBDZFQFRgw@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: initialize lib|main_pid to zero in the
 setup_ipc
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

PiBPbiBUdWUsIE1heSAxMywgMjAyNSBhdCA5OjAy4oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgoKPiA+IE9uIFR1ZSwgTWF5IDEzLCAyMDI1IGF0IDg6NTLigK9QTSBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gPiBIaSBhbGwsCgo+ID4gPiAuLi4K
PiA+ID4gPiA+ICsrKyBiL2xpYi90c3RfdGVzdC5jCj4gPiA+ID4gPiBAQCAtNTksNyArNTksNiBA
QCBzdGF0aWMgY29uc3QgY2hhciAqdGlkOwo+ID4gPiA+ID4gIHN0YXRpYyBpbnQgaXRlcmF0aW9u
cyA9IDE7Cj4gPiA+ID4gPiAgc3RhdGljIGZsb2F0IGR1cmF0aW9uID0gLTE7Cj4gPiA+ID4gPiAg
c3RhdGljIGZsb2F0IHRpbWVvdXRfbXVsID0gLTE7Cj4gPiA+ID4gPiAtc3RhdGljIHBpZF90IGxp
Yl9waWQ7Cj4gPiA+ID4gPiAgc3RhdGljIGludCBtbnRwb2ludF9tb3VudGVkOwo+ID4gPiA+ID4g
IHN0YXRpYyBpbnQgb3ZsX21vdW50ZWQ7Cj4gPiA+ID4gPiAgc3RhdGljIHN0cnVjdCB0aW1lc3Bl
YyB0c3Rfc3RhcnRfdGltZTsgLyogdmFsaWQgb25seSBmb3IgdGVzdCBwaWQgKi8KPiA+ID4gPiA+
IEBAIC0xNDMsNyArMTQyLDkgQEAgc3RhdGljIHZvaWQgc2V0dXBfaXBjKHZvaWQpCj4gPiA+ID4g
PiAgICAgICAgICAgICB0c3RfZnV0ZXhlcyA9IChjaGFyICopcmVzdWx0cyArIHNpemVvZihzdHJ1
Y3QgcmVzdWx0cyk7Cj4gPiA+ID4gPiAgICAgICAgICAgICB0c3RfbWF4X2Z1dGV4ZXMgPSAoc2l6
ZSAtIHNpemVvZihzdHJ1Y3QgcmVzdWx0cykpL3NpemVvZihmdXRleF90KTsKPiA+ID4gPiA+ICAg
ICB9Cj4gPiA+ID4gPiAtICAgcmVzdWx0cy0+bGliX3BpZCA9IGxpYl9waWQ7Cj4gPiA+ID4gPiAr
Cj4gPiA+ID4gPiArICAgcmVzdWx0cy0+bGliX3BpZCA9IDA7Cj4gPiA+ID4gPiArICAgcmVzdWx0
cy0+bWFpbl9waWQgPSAwOwoKPiA+ID4gbml0OiBJcyBpdCByZWFsbHkgbmVlZGVkIHRvIGludCB0
aGVtIHRvIDA/IEJlY2F1c2UgdGhleSBzaG91bGQgYmUgMCBkdWUgdGhlCj4gPiA+IGRlZmF1bHQg
c3RydWN0IHZhbHVlLCByaWdodD8KCj4gVGhlIHJlc3VsdHMgc3RydWN0dXJlIG1lbW9yeSB3YXMg
ZHluYW1pY2FsbHkgYWxsb2NhdGVkIHZpYQo+IG1tYXAgc28gdGhlIGRlZmF1bHQgdmFsdWUgbWln
aHQgbm90IGJlIHplcm8uIFVubGVzcyB3ZSBkbwo+IGV4cGxpY2l0bHkgY2FsbCBtZW1zZXQoLCAw
LCAuLi4pLgoKVGhhbmtzIGZvciBpbmZvLiBPciBqdXN0IHVzZSB7fSBpbnN0ZWFkIG9mIG1lbXNl
dD8KCnN0cnVjdCByZXN1bHRzIHNhdmVkX3Jlc3VsdHMgPSB7fTsKClRpbnkgZGV0YWlsLCBqdXN0
IGl0J3MgbW9yZSByZWFkYWJsZSB0byBtZS4KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
