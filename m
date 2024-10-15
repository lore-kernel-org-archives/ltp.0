Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CD0D1D88B
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 16:20:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBC8E3C6757
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 18:20:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0D323C6571
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 18:19:58 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 273A62195AD
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 18:19:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB8BD21D1C;
 Tue, 15 Oct 2024 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729009197;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=db0iRKmlXKVhGkKfdM/JgcsAExiX4lOXMrb5pfsb79c=;
 b=0ZS8MgJqcfqn/0kQUs4trvJ0fAJnfO5vu0d6TqtM6lDf8YyY0b7ah3jjZ9znarqo4f8C1N
 /ESFtL/NZM1fL8hm1Yc+aTHmABO0fnsY5FuJ1djGpOjVMDx4QsPLtSWRle8z6rq11mmwjl
 1UCqjMPUba+mkK148fMICKfOpS0tpV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729009197;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=db0iRKmlXKVhGkKfdM/JgcsAExiX4lOXMrb5pfsb79c=;
 b=C+61hW8skqB++a2HHZ+JLiImzllaLRf/yGEYsZRmBTldjOlg3AL3FUhU4H/eHWjWYxOH+N
 h9gEmo4OJoXBswDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=A1KbHWGL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yhEdDCVF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729009196;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=db0iRKmlXKVhGkKfdM/JgcsAExiX4lOXMrb5pfsb79c=;
 b=A1KbHWGL2/Co+cQR+Zkcl7abwLu+yBTKFYnOkrNu7JwxJqQ+b6X4BKDI/HrscuJh89IsG+
 pa3s/bx3qrmLjOhAncwyDfq+mUlI+KjtL5Gida4lL27MxT23mUD0lSqr2nR53thFqhctZB
 GJKYtwtEh05uTorAmTAnWMk+y9moExc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729009196;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=db0iRKmlXKVhGkKfdM/JgcsAExiX4lOXMrb5pfsb79c=;
 b=yhEdDCVF51LaBfn2pf3j/C1HrCJ57QIYL034fFEGzuISzNR1iRRmMax02ZVZqBAO2rvS3z
 ZUoSOV7hK0NLGgAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9259513A53;
 Tue, 15 Oct 2024 16:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kmeZISyWDmewKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 15 Oct 2024 16:19:56 +0000
Date: Tue, 15 Oct 2024 18:19:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241015161950.GA35679@pevik>
References: <20240927101813.12643-1-chrubis@suse.cz>
 <2748318.lGaqSPkdTl@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2748318.lGaqSPkdTl@localhost>
X-Rspamd-Queue-Id: DB8BD21D1C
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include: Better documentation for TFAIL and TBROK\
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

SGkgQ3lyaWwsIEF2aW5lc2gsCgpuaXQ6IHRoZXJlIGlzIHRyYWlsaW5nICJcIiBpbiB0aGUgdGVz
dCBzdWJqZWN0LgoKPiBIaSBDeXJpbCwKCj4gT24gRnJpZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjQg
MTI6MTg6MTPigK9QTSBHTVQrMiBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gPiBGaXhlczogIzExNjIK
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KCj4gUmV2
aWV3ZWQtYnk6IEF2aW5lc2ggS3VtYXIgPGFrdW1hckBzdXNlLmRlPgoKPiBUaGFuayB5b3UsCj4g
QXZpbmVzaAoKPiA+IC0tLQo+ID4gIGluY2x1ZGUvdHN0X3Jlc19mbGFncy5oIHwgMjMgKysrKysr
KysrKysrKysrKysrKy0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkKCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90c3RfcmVzX2ZsYWdzLmgg
Yi9pbmNsdWRlL3RzdF9yZXNfZmxhZ3MuaAo+ID4gaW5kZXggODA2OTQwZTBkLi5hNzk0MjhmYTIg
MTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL3RzdF9yZXNfZmxhZ3MuaAo+ID4gKysrIGIvaW5jbHVk
ZS90c3RfcmVzX2ZsYWdzLmgKPiA+IEBAIC05LDExICs5LDI2IEBACj4gPiAgLyoqCj4gPiAgICog
ZW51bSB0c3RfcmVzX2ZsYWdzIC0gVGVzdCByZXN1bHQgcmVwb3J0aW5nIGZsYWdzLgo+ID4gICAq
Cj4gPiAtICogQFRQQVNTOiBSZXBvcnRzIGEgc2luZ2xlIHN1Y2Nlc3MuCj4gPiAtICogQFRGQUlM
OiBSZXBvcnRzIGEgc2luZ2xlIGZhaWx1cmUuCj4gPiAtICogQFRCUk9LOiBSZXBvcnRzIGEgc2lu
Z2xlIGJyZWFrYWdlLgo+ID4gKyAqIEBUUEFTUzogUmVwb3J0cyBhIHNpbmdsZSBzdWNjZXNzLiBT
dWNjZXNzZXMgaW5jcmVtZW50IHBhc3NlZCBjb3VudGVyIGFuZAo+ID4gKyAqICAgICAgICAgc2hv
dyB1cCBpbiB0aGUgdGVzdCByZXN1bHRzLgo+ID4gKyAqCj4gPiArICogQFRGQUlMOiBSZXBvcnRz
IGEgc2luZ2xlIGZhaWx1cmUuIEZhaWx1cmVzIGluY3JlbWVudCBmYWlsdXJlIGNvdW50ZXIgYW5k
Cj4gPiArICogICAgICAgICBzaG93IHVwIGluIHRoZSB0ZXN0IHJlc3VsdHMuIEEgZmFpbHVyZSBv
Y2N1cnMgd2hlbiB0ZXN0IGFzc2VydGlvbgo+ID4gKyAqICAgICAgICAgaXMgYnJva2VuLgo+ID4g
KyAqCj4gPiArICogQFRCUk9LOiBSZXBvcnRzIGEgc2luZ2xlIGJyZWFrYWdlLiBCcmVha2FnZXMg
aW5jcmVtZW50IGJyZWFrYWdlIGNvdW50ZXIgYW5kCj4gPiArICogICAgICAgICBzaG93IHVwIGlu
IHRoZSB0ZXN0IHJlc3VsdHMuIEJyZWFrYWdlcyBhcmUgcmVwb3J0ZWQgaW4gY2FzZXMgd2hlcmUg
YQo+ID4gKyAqICAgICAgICAgdGVzdCBjb3VsZG4ndCBiZSBleGVjdXRlZCBkdWUgdG8gYW4gdW5l
eHBlY3RlZCBmYWlsdXJlIHdoZW4gd2Ugd2VyZQpuaXQ6IG1heWJlIHVzZSBwYXNzaXZlIGZvcm0/
ICJ3aGVuIHdlIHdlcmUgc2V0dGluZyB0aGUgdGVzdCBlbnZpcm9ubWVudCIgPT4KImR1cmluZyB0
aGUgdGVzdCBzZXR1cCIgb3IgImR1cmluZyBzZXR0aW5nIHRoZSB0ZXN0IGVudmlyb25tZW50Ij8K
Cj4gPiArICogICAgICAgICBzZXR0aW5nIHRoZSB0ZXN0IGVudmlyb25tZW50LiBUaGUgVEJST0sg
c3RhdHVzIGlzIG1vc3RseSB1c2VkCj4gPiArICogICAgICAgICB3aXRoIHRzdF9icmsoKSB3aGlj
aCBleGl0IHRoZSB0ZXN0IGltbWVkaWF0ZWxseS4gVGhlIGRpZmZlcmVuY2UKPiBzL2ltbWVkaWF0
ZWxseS9pbW1lZGlhdGVseSAKCisxCgo+ID4gKyAqICAgICAgICAgYmV0d2VlbiBUQlJPSyBhbmQg
VENPTkYgaXMgdGhhdCBUQ09ORiBpcyB1c2VkIGluIGNhc2VzIHdoZXJlCj4gPiArICogICAgICAg
ICBvcHRpb25hbCBmdW5jdGlvbmFsaXR5IGlzIG1pc3Npbmcgd2hpbGUgVEJST0sgaXMgdXNlZCBp
biBjYXNlcyB3aGVyZQo+ID4gKyAqICAgICAgICAgc29tZXRoaW5nIHRoYXQgaXMgc3VwcG9zZWQg
dG8gd29yayBpcyBicm9rZW4gdW5leHBlY3RlZGx5LgpuaXQgKG5vdCByZWFsbHkgc3VyZSk6ICJ0
aGF0IiA9PiAid2hpY2giCgo+ID4gKyAqCj4gPiAgICogQFRXQVJOOiBSZXBvcnRzIGEgc2luZ2xl
IHdhcm5pbmcuIFdhcm5pbmdzIGluY3JlbWVudCBhIHdhcm5pbmcgY291bnRlciBhbmQKPiA+IC0g
KiAgICAgICAgIHNob3cgdXAgaW4gdGVzdCByZXN1bHRzLgo+ID4gKyAqICAgICAgICAgc2hvdyB1
cCBpbiB0ZXN0IHJlc3VsdHMuIFdhcm5pbmdzIGFyZSBzb21ld2hlcmUgaW4gdGhlIG1pZGRsZSBi
ZXR3ZWVuCj4gPiArICogICAgICAgICBUQlJPSyBhbmQgVENPTkYuIFdhcm5pbmdzIHVzdWFsbHkg
YXBwZWFyIHdoZW4gc29tZXRoaW5nIHRoYXQgaXMKbml0IChub3QgcmVhbGx5IHN1cmUpOiAidGhh
dCIgPT4gIndoaWNoIgoKUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoK
S2luZCByZWdhcmRzLApQZXRyCgo+ID4gKyAqICAgICAgICAgc3VwcG9zZWQgdG8gYmUgd29ya2lu
ZyBpcyBicm9rZW4gYnV0IHRoZSB0ZXN0IGNhbiBzb21laG93IGNvbnRpbnVlLgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
