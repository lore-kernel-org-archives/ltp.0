Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECD6C25B78
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 12:26:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E5E03D0541
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 14:26:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27DAA3C67E5
 for <ltp@lists.linux.it>; Tue, 28 May 2024 14:25:47 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4DEC7601AC4
 for <ltp@lists.linux.it>; Tue, 28 May 2024 14:25:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 88CAE2029B;
 Tue, 28 May 2024 12:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716899145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQhA3v0ddgPTt19oJIFO//OJEJbD0CcRpM1iL2kJ3zs=;
 b=ulYcMD96oXSZVi41U6/6jMpZfcBoTMGzz5/uNQVYdOnL3ekIqehzrrsK2pwuHVNMmWGQr7
 Qg1X1WqPlZAEMBD3bwiuIQPd+dZ02wmnAE8wG2zw4j7hd+ppZHi9UeA33vJlhcKkGq6VaW
 Z6CMRXEiYa0f/YN2gNYywuTBM84Grho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716899145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQhA3v0ddgPTt19oJIFO//OJEJbD0CcRpM1iL2kJ3zs=;
 b=lbWCn7eo59hh7oZQwCdy+zPTNQ3vnCdfPt7lqZYs1mIADSPFgv1Vtxu7vX0gF6oFZRQ4kS
 5Vfbk1f2Aw8h5RCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716899145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQhA3v0ddgPTt19oJIFO//OJEJbD0CcRpM1iL2kJ3zs=;
 b=ulYcMD96oXSZVi41U6/6jMpZfcBoTMGzz5/uNQVYdOnL3ekIqehzrrsK2pwuHVNMmWGQr7
 Qg1X1WqPlZAEMBD3bwiuIQPd+dZ02wmnAE8wG2zw4j7hd+ppZHi9UeA33vJlhcKkGq6VaW
 Z6CMRXEiYa0f/YN2gNYywuTBM84Grho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716899145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQhA3v0ddgPTt19oJIFO//OJEJbD0CcRpM1iL2kJ3zs=;
 b=lbWCn7eo59hh7oZQwCdy+zPTNQ3vnCdfPt7lqZYs1mIADSPFgv1Vtxu7vX0gF6oFZRQ4kS
 5Vfbk1f2Aw8h5RCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C23613A6B;
 Tue, 28 May 2024 12:25:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UBp6EEnNVWb5PwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 28 May 2024 12:25:45 +0000
Date: Tue, 28 May 2024 14:25:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20240528122538.GB435237@pevik>
References: <20240527135718.29451-1-mdoucha@suse.cz>
 <20240527223551.GA374567@pevik>
 <8774370a-d6c7-42f6-a135-57fdf23032d9@suse.cz>
 <20240528093752.GA408250@pevik>
 <CAASaF6yh-xaVZXK8yQkrHWN7sLcSSrpWrF1NBgrSR_h=Ye_NYg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6yh-xaVZXK8yQkrHWN7sLcSSrpWrF1NBgrSR_h=Ye_NYg@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kvm_pagefault01: Do not write into tdp_mmu sysfile
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

SGkgTWFydGluLCBKYW4sCgo+IE9uIFR1ZSwgTWF5IDI4LCAyMDI0IGF0IDExOjM44oCvQU0gUGV0
ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+ID4gT24gMjguIDA1LiAyNCAwOjM1
LCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gKyBpZiAocmVhZF9ib29s
X3N5c19wYXJhbShURFBfTU1VX1NZU0ZJTEUpID4gMCkKPiA+ID4gPiA+ICsgICAgICAgICB0c3Rf
cmVzKFRJTkZPLCAidGRwX21tdSBpcyBlbmFibGVkLCBiZXdhcmUgb2YgZmFsc2UgbmVnYXRpdmVz
Iik7Cgo+ID4gPiA+IFdvdWxkbid0IGl0IGJlIGJldHRlciB0byBhZGQgIldBUk5JTkc6IiB0byBt
YWtlIGl0IG1vcmUgdmlzaWJsZT8KPiA+ID4gPiAgICAgICAgICAgICB0c3RfcmVzKFRJTkZPLCAi
V0FSTklORzogdGRwX21tdSBpcyBlbmFibGVkLCBiZXdhcmUgb2YgZmFsc2UgbmVnYXRpdmVzIik7
Cgo+ID4gPiA+IChpZiB5b3UgYWdyZWUsIEkgY2FuIGNoYW5nZSBpdCBiZWZvcmUgbWVyZ2UpCgo+
ID4gPiBJIHRob3VnaHQgYWJvdXQgaXQgZm9yIGEgd2hpbGUgYW5kIEkgc2VlIGdvb2QgcmVhc29u
cyBmb3IgYm90aCBUSU5GTyBhbmQKPiA+ID4gVFdBUk4uIEl0IHNob3VsZG4ndCBtYXR0ZXIgZm9y
IG91ciB0ZXN0cyBiZWNhdXNlIHRkcF9tbXUgZGVmYXVsdHMgdG8gb2ZmIG9uCj4gPiA+IFNMRS0x
NVNQNCBhbmQgU0xFLTE1U1A1LiBJZiBvdGhlciByZXZpZXdlcnMgYWdyZWUsIGZlZWwgZnJlZSB0
byBjaGFuZ2UgaXQgdG8KPiA+ID4gVFdBUk4uCgo+ID4gSSBzbGlnaHRseSBwcmVmZXIgdHN0X3Jl
cyhUSU5GTywgIldBUk5JTkc6IC4uLiIsIHRoYW4gVFdBUk4uIEFsdGhvdWdoIGZhbHNlCj4gPiBu
ZWdhdGl2ZSBpcyBzZXJpb3VzLCBzdGlsbCBmYWlsaW5nIHRoZSB0ZXN0IGJhc2VkIG9uIHN1c3Bp
Y2lvbiBvZiBmYWxzZQo+ID4gcG9zaXRpdmVzIGlzIG5vdCBnb29kLgoKPiA+IEBMaSwgQEphbiwg
QE1ldGFuOiBhbnkgb3BpbmlvbiBvbiBpdD8KCj4gSSdkIGdvIHdpdGggVElORk8gaGVyZSwgYXMg
eW91IHN1Z2dlc3RlZC4KClRoYW5rcyBhIGxvdCBib3RoIQoKUGF0Y2hzZXQgbWVyZ2VkIChKYW4s
IEkgZGlkIG5vdCBkYXJlIHRvIGFkZCB5b3VyIFJCVCBvciBBQlQgYXMgeW91IGRpZCBub3QgYWRk
Cml0KSwgd2l0aCBhZGRlZCBXQVJOSU5HOiAoYXMgTWFydGluIGFncmVlZCkuCgpLaW5kIHJlZ2Fy
ZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
