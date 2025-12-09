Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BA1D3B98A
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 18:44:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CACA73D01D2
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 19:44:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DBB63CFF97
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 19:44:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 263E3200071
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 19:44:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6721D3375E;
 Tue,  9 Dec 2025 18:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765305842;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BGlZEtEoLR/HVSJWFSPyomvWBcE5Nn2v4lwdYy2MqA=;
 b=MRtAog7EQcSERm0C39xErGa0fVm5C3w4y7VICKZ8Z7YCtqW7Ei2qzxCn8iZEsSAnvWnpBn
 hniwAQyX/gbcgMiA2LZQbqIv0MduGEOq7QfysAeluMoI7LrOdQLMK48AkyjOQ+/fRxnBA9
 QMsit257F8FLQRiQbGKuqwEM07Tt4Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765305842;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BGlZEtEoLR/HVSJWFSPyomvWBcE5Nn2v4lwdYy2MqA=;
 b=TPdu7rfm8A5pDINKX/rHcVE3bfiejZSi1v5o/9tJATqD2V3AY2nSqiYxu/8uivvH8gSU1h
 QBo+l8DRgC5OmxDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765305842;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BGlZEtEoLR/HVSJWFSPyomvWBcE5Nn2v4lwdYy2MqA=;
 b=MRtAog7EQcSERm0C39xErGa0fVm5C3w4y7VICKZ8Z7YCtqW7Ei2qzxCn8iZEsSAnvWnpBn
 hniwAQyX/gbcgMiA2LZQbqIv0MduGEOq7QfysAeluMoI7LrOdQLMK48AkyjOQ+/fRxnBA9
 QMsit257F8FLQRiQbGKuqwEM07Tt4Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765305842;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BGlZEtEoLR/HVSJWFSPyomvWBcE5Nn2v4lwdYy2MqA=;
 b=TPdu7rfm8A5pDINKX/rHcVE3bfiejZSi1v5o/9tJATqD2V3AY2nSqiYxu/8uivvH8gSU1h
 QBo+l8DRgC5OmxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 276153EA63;
 Tue,  9 Dec 2025 18:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kQZgCPJtOGlbPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 18:44:02 +0000
Date: Tue, 9 Dec 2025 19:44:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251209184400.GA16151@pevik>
References: <20251127082638.224110-1-pvorel@suse.cz>
 <20251127082638.224110-2-pvorel@suse.cz>
 <CAEemH2cUYekSphFW_uj2w1FzYt3RWXDDnhmQ5TFAyr0T3HFxow@mail.gmail.com>
 <CAEemH2e6ivP0rzfTBp5LnZ8n-oe7moqfHszgs2QyYVMUTUQ_wQ@mail.gmail.com>
 <aTgh9CIRfVWniUZD@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aTgh9CIRfVWniUZD@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[7]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] shell: Add tst_sudo.c helper
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSEKPiA+ID4gSSBmZWVsIHRoYXQgdGhlIGZpbGVuYW1lIHRzdF9zdWRvLmMgaXMgYSBiaXQg
bWlzbGVhZGluZy4gVGhlIGhlbHBlcgo+ID4gPiBkb2VzbuKAmXQKPiA+ID4gcmVwbGljYXRlIHN1
ZG8gYmVoYXZpb3IgKGF1dGhlbnRpY2F0aW9uLCBwcml2aWxlZ2UgZXNjYWxhdGlvbiksIGl0IHNp
bXBseQo+ID4gPiBkcm9wcyBmcm9tIHJvb3QgdG8gYSBmaXhlZCBVSUQvR0lEIGJlZm9yZSBleGVj
dXRpbmcgYSBjb21tYW5kLgoKPiA+ID4gU28gcmVhZGVycyBtYXkgZXhwZWN0IGEg4oCcc3Vkby1s
aWtl4oCdIGVsZXZhdGlvbiB3cmFwcGVyIHdoZW4sIGhvd2V2ZXIKPiA+ID4gaXTigJlzIGEgcHJp
dmlsZWdlLWRyb3BwaW5nIHRyYW1wb2xpbmUuCgo+ID4gPiBXaGF0IGFib3V0IHJlbmFtaW5nIGl0
IHRvOgo+ID4gPiAgIHRzdF9ydW5hcy5jLAo+ID4gPiAgIHRzdF9ydW5hc19ub2JvZHkuYywgb3IK
PiA+ID4gICB0c3RfZHJvcF9wcml2cy5jPwoKCgo+ID4gUGVyc29uYWxseSwgSSBwcmVmZXIgdGhl
IHRzdF9ydW5hc19ub2R5LmMgYmVjYXVzZSBpdCByZWZsZWN0cyB0aGUKPiA+IGRlZmF1bHQgcHJp
dmlsZWdlLAo+ID4gYnV0IGR1ZSBpdCBzdXBwb3J0cyB0aGUgbW9yZSBlbnYgc28gY29udGFpbnMg
InN1IiBtYXliZSBiZXR0ZXI6Cj4gPiAgIHRzdF9zdV9zd2l0Y2guYywgdHN0X3N1X2NtZC5jCgo+
IE1heWJlIGp1c3QgdHN0X3J1bmFzLmMgSSB0aGluayB0aGF0ICdydW5hcycgaW4gdGhlIG5hbWUg
aXMgcHJvYmFibHkgdGhlCj4gYmVzdCBkZXNjcmlwdGlvbi4KCkxHVE0uIEknbGwgc2VuZCB2NC4K
CktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
