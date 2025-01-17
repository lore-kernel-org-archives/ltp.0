Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CF5C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 11:12:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 236003C7BC8
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 12:12:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1676B3C296C
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 12:12:28 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 421F82603B3
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 12:12:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 461AF2117A;
 Fri, 17 Jan 2025 11:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737112347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYgob3OdkwaYh3k4kgbVnsMUFa2n1ROHF+qjq8hpa5o=;
 b=qFqAunqw9qCJ3TY9PeD1A1qXZbRMp2TZ9PJFGvGQAZH8oKUXR0cFl4ewYsl3NIimc9X4gS
 2AQybO98BSHad1y0SAXnWCYnt+TVSJkUKDo/Y9xm8IwrYzMJIS7dv/iC0ZRYG9JGvrdYO7
 KXNIc43kahiodMViLN+ju37966GxONk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737112347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYgob3OdkwaYh3k4kgbVnsMUFa2n1ROHF+qjq8hpa5o=;
 b=ZFI2wLVVp0khSfaCyouHLEDOyEoyvanObckq2IQZSdqNZuw/1sfdrWaKrjlqS548jm50XY
 E0DPmTHahqKnr/Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737112347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYgob3OdkwaYh3k4kgbVnsMUFa2n1ROHF+qjq8hpa5o=;
 b=qFqAunqw9qCJ3TY9PeD1A1qXZbRMp2TZ9PJFGvGQAZH8oKUXR0cFl4ewYsl3NIimc9X4gS
 2AQybO98BSHad1y0SAXnWCYnt+TVSJkUKDo/Y9xm8IwrYzMJIS7dv/iC0ZRYG9JGvrdYO7
 KXNIc43kahiodMViLN+ju37966GxONk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737112347;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYgob3OdkwaYh3k4kgbVnsMUFa2n1ROHF+qjq8hpa5o=;
 b=ZFI2wLVVp0khSfaCyouHLEDOyEoyvanObckq2IQZSdqNZuw/1sfdrWaKrjlqS548jm50XY
 E0DPmTHahqKnr/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E8013332;
 Fri, 17 Jan 2025 11:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0cJICBs7imcUcAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 11:12:27 +0000
Date: Fri, 17 Jan 2025 12:12:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250117111221.GC754426@pevik>
References: <20250114124023.4702-1-wegao@suse.com>
 <20250114143217.21018-1-wegao@suse.com>
 <20250114143217.21018-3-wegao@suse.com>
 <20250117104041.GA753841@pevik> <Z4o0G9xPksd__CiF@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z4o0G9xPksd__CiF@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/2] ptrace06: Refactor the test using new LTP
 API
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

PiBIaSEKPiA+ID4gKy8qCj4gPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMTggTGludXggVGVzdCBQ
cm9qZWN0Cj4gPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTUgQ3lyaWwgSHJ1YmlzIGNocnViaXNA
c3VzZS5jego+ID4gPiArICovCj4gPiA+ICsKPiA+ID4gKyNkZWZpbmUgVFNUX05PX0RFRkFVTFRf
TUFJTgo+ID4gPiArI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gPiA+ICsKPiA+ID4gK2ludCBtYWlu
KGludCBhcmdjLCBjaGFyICphcmd2W10pCgo+ID4gcHRyYWNlMDZfY2hpbGQuYzoxMDoxNDogd2Fy
bmluZzogdW51c2VkIHBhcmFtZXRlciDigJhhcmdj4oCZIFstV3VudXNlZC1wYXJhbWV0ZXJdCj4g
PiAgICAxMCB8IGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCgo+ID4gPiArewo+ID4g
PiArCj4gPiBuaXQ6IGVtcHR5IGxpbmUgXgo+ID4gPiArCXRzdF9yZXMoVFBBU1MsICIlcyBleGVj
dXRlZCIsIGFyZ3ZbMF0pOwo+ID4gPiArCj4gPiA+ICsJcmV0dXJuIDA7Cj4gPiA+ICt9Cgo+ID4g
SSBzdWdnZXN0IHRvIG1lcmdlIHRoZSBwYXRjaHNldCB3aXRoIHRoaXMgY2hhbmdlIGluIHRoaXMg
Y29tbWl0LgoKPiA+IEBDeXJpbDogQ2FuIEkgYWRkIHlvdXIgUkJUPwoKPiBIYXZlIHlvdSBzZWVu
IG15IHJldmlldz8gVGhhdCBmaWxlIGlzIG5vdCB1c2VkIGF0IGFsbC4gQW5kIGFsc28gdGhlCj4g
VEVTVCgpIHN0YXRlbWVudCBpbiB0aGUgYWN0dWFsIHRlc3QuCgpJJ20gc29ycnkgSSBvdmVybG9v
a2VkIGl0LiBGaXJzdCBjb21taXQgaXMgbWVyZ2VkIHdpdGggeW91ciBSQlQuCkFuZCBJJ20gc29y
cnkgbm90IGNhdGNoaW5nIHRoZXNlLgoKRm9yIHRoaXMgcGF0Y2ggSSBwdHJhY2UwNl9jaGlsZC5j
IGFuZCBtZXJnZWQuIEJ1dCBiZWNhdXNlIHRoZXJlIGlzIFRFU1QocHRyYWNlLAouLi4gIGxlZnQs
IEkgZGFyZWQgdG8gcmVtb3ZlZCBpdCBhZ2FpbiAod2l0aCBnaXQgcHVzaCAtZiksIFdlaSBwbGVh
c2Ugc2VuZAphbm90aGVyIHZlcnNpb24gKEkgZ3Vlc3Mgd2l0aG91dCBteSBSQlQgYXMgdGhlIGNv
ZGUgY2hhbmdlZCBhIGxvdCBzaW5jZSBJIGFkZAp0aGUgdGFnKS4KCktpbmQgcmVnYXJkcywKUGV0
cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
