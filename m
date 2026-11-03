Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326C4606A332
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=TamBSuh9;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tUQOhoMG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=hmU+9+Mt;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SGMd/wYL
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C87213C6571
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 08:25:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2AB73C4F7B
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 08:24:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2948220004C
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 08:24:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09EE41F830;
 Tue,  3 Nov 2026 07:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793690698;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujUTD7I/EUMSElEZfZSGbWAJzhEEt6VG8ezpiFO5EYY=;
 b=TamBSuh9VTzaB2qdbRZAjnGxZ7a03mE+CC1C5eomDx135bVBiJv49ckWpKg+K39dCU3zql
 maqOcrT/wHCjxz1VR3DElwd+WDsB0tNuY7yMCCL44Xz43vIFu+SjQiwUrSQRRAjX0Id16p
 Y707WhohRN92CtHN3yOg5GdjvlEHlJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793690698;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujUTD7I/EUMSElEZfZSGbWAJzhEEt6VG8ezpiFO5EYY=;
 b=tUQOhoMGI7lE15qCumuGbe3EaBaknM9XqRCjEsPa2S+3scabYYCckeGwCWrh6YWIN+Axil
 jXN2pjauiK2H6JCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hmU+9+Mt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="SGMd/wYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793690697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujUTD7I/EUMSElEZfZSGbWAJzhEEt6VG8ezpiFO5EYY=;
 b=hmU+9+MtsAcYfxppBt1P/MFpnetCXgjO7e5LYKN+dC538f5cwKW/P0cDny14OgLLGsv0iR
 8Qsf9laDbPNSbHd3RVS2GJ603hB6Ly36IleyxCGXs5mDxc1qP3JCJv73pj/Cb6vzFXnOk6
 t1/XWKTYJ5PJP7Yx072L8HHd+EASVHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793690697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujUTD7I/EUMSElEZfZSGbWAJzhEEt6VG8ezpiFO5EYY=;
 b=SGMd/wYLsNuUwmJnG6ng+Vicdf4wypABdqB+WzZxIG8+wPGYATVVjUTYWR+HAJ7QdWZXLs
 uAgImFMwNU4oDcDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C178D134B8;
 Tue,  3 Nov 2026 07:24:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MMwmI0iM6WrMRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Nov 2026 07:24:56 +0000
Date: Tue, 3 Nov 2026 08:24:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20261103072455.GA35831@pevik>
References: <P5Iny41--F-9@tuta.io>
 <CAOQ4uxgqZANVT8wi_hCJX6Ym5Ea9XMCo3eSRwp-aujf767NbeA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgqZANVT8wi_hCJX6Ym5Ea9XMCo3eSRwp-aujf767NbeA@mail.gmail.com>
X-Rspamd-Queue-Id: 09EE41F830
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.71 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_EQ_ADDR_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.cz:replyto,tuta.io:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.71
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify26: Add directory cases for the
 nested event
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Edvard Conrad <edvard@tuta.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW1pciwgRWR2YXJkLAoKPiBPbiBTYXQsIE9jdCAzMSwgMjAyNiBhdCAxMDoxM+KAr1BNIEVk
dmFyZCBDb25yYWQgPGVkdmFyZEB0dXRhLmlvPiB3cm90ZToKCj4gPiBBIGRpcmVjdG9yeSBvbiBv
dmVybGF5ZnMgcmVhY2hlcyBpdHMgcmVhbCBkaXJlY3RvcnkgdGhyb3VnaAo+ID4gb3ZsX2Rpcl9v
cGVuX3JlYWxmaWxlKCkgcmF0aGVyIHRoYW4gYmFja2luZ19maWxlX29wZW4oKSwgc28gdGhlIGZp
eAo+ID4gZm9yIHJlZ3VsYXIgZmlsZXMsIGNvbW1pdCBjM2QzNTVmNDI3Y2UgKCJmczogbGV0IGJh
Y2tpbmcgZmlsZXMKPiA+IGluaGVyaXQgRk1PREVfTk9OT1RJRlkgZnJvbSB0aGUgdXNlciBmaWxl
IiksIGRvZXMgbm90IGNvdmVyIGl0OiBhCj4gPiBsaXN0ZW5lciB0aGF0IG1hcmtzIHRoZSBiYWNr
aW5nIGZpbGVzeXN0ZW0gd2l0aCBGQU5fT1BFTl9QRVJNIHwKPiA+IEZBTl9PTkRJUiBpcyBzdGls
bCBzZW50IGEgbmVzdGVkIHBlcm1pc3Npb24gZXZlbnQgZnJvbSBpdHMgb3duCj4gPiByZWFkKDIp
IHdoZW4gdGhlIHJlcG9ydGVkIHBhdGggaXMgYW4gb3ZlcmxheSBkaXJlY3RvcnkuCgo+ID4gQWRk
IHRoZSBkaXJlY3RvcnkgY291bnRlcnBhcnRzIG9mIHRoZSB0d28gZXhpc3RpbmcgY2FzZXMuIFRo
ZQo+ID4gbGlzdGVuZXIncyBleHBlY3RlZCBldmVudCBtYXNrIHN0YXlzIEZBTl9PUEVOX1BFUk06
IEZBTl9PTkRJUiBpcyBub3QKPiA+IHJlcG9ydGVkIHRvIGEgZ3JvdXAgd2l0aG91dCBGQU5fUkVQ
T1JUX0ZJRC4KCj4gPiBUaGUgZm91cnRoIGNhc2UgZmFpbHMgb24gYSBrZXJuZWwgd2l0aG91dCB0
aGUgcGVuZGluZyBmaXggIm92bDoKPiA+IGluaGVyaXQgRk1PREVfTk9OT1RJRlkgd2hlbiBvcGVu
aW5nIGRpcmVjdG9yeSByZWFsZmlsZXMiLgoKPiA+IFNpZ25lZC1vZmYtYnk6IEVkdmFyZCBDb25y
YWQgPGVkdmFyZEB0dXRhLmlvPgoKPiBSZXZpZXdlZC1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3
M2lsQGdtYWlsLmNvbT4KCj4gPiAtLS0KPiA+IERlcGVuZHMgb24gdGhlIHBlbmRpbmcgb3Zlcmxh
eWZzIGZpeCwgcG9zdGVkIGJ5IEFtaXIgb24gdGhlIGtlcm5lbAo+ID4gdGhyZWFkOgo+ID4gICBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FPUTR1eGptPWNHUG51ZzE4VnVoS3FpTXZrV3dM
UE5MT19URTNLeE84aUxaRyt2ZVlRQG1haWwuZ21haWwuY29tLwo+ID4gV2l0aG91dCBpdCB0aGUg
Zm91cnRoIGNhc2UgZmFpbHMgb24gY3VycmVudCBtYWlubGluZSwgc28gdGhpcyBzaG91bGQKPiA+
IHdhaXQgaW4gdGhlIHF1ZXVlIHVudGlsIHRoYXQgZml4IGlzIGluIExpbnVzJyB0cmVlOyBhIGxp
bnV4LWdpdCB0YWcgZm9yCj4gPiBpdCBjYW4gdGhlbiBiZSBhZGRlZC4gVGhlIGZpcnN0IHRocmVl
IGNhc2VzIHBhc3Mgb24gdjcuNC1yYzEgbWF0ZXJpYWwKPiA+IHRvZGF5LgoKPiA+IFRlc3RlZCBp
biBhIFZNLCBlYWNoIGtlcm5lbCBydW4gb25jZSBhbmQgd2l0aCAtaSAyOgoKPiA+ICAga2VybmVs
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsZStiYWNraW5nICBkaXIrYmFja2luZwo+
ID4gICB2Ni4xMyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgICAgIEZB
SUwKPiA+ICAgNmI0YjU0M2ZhMTggKG5vIGZpeCkgICAgICAgICAgICAgICAgRkFJTCAgICAgICAg
ICBGQUlMCj4gPiAgICsgYzNkMzU1ZjQyN2NlIChmaWxlcywgaW4gTGludXMnKSAgIFBBU1MgICAg
ICAgICAgRkFJTAo+ID4gICArIHRoZSBwZW5kaW5nIG92bCBmaXggICAgICAgICAgICAgICBQQVNT
ICAgICAgICAgIFBBU1MKCj4gPiBUaGUgIm92ZXJsYXkgbWFyayBvbmx5IiBjYXNlcyBwYXNzIGV2
ZXJ5d2hlcmUuIFRoZSBkaXJlY3RvcnkgY2FzZQo+ID4gZmFpbHMgb24gdjYuMTMgdG9vOiBvdmVy
bGF5ZnMgbmV2ZXIgcGFzc2VkIHRoZSBub25vdGlmeSBzdGF0ZSBvbiB0bwo+ID4gdGhlIHJlYWwg
ZGlyZWN0b3J5LCBzbyBpdCBwcmVkYXRlcyB0aGUgNi4xNCBjaGFuZ2UgdGhhdCBicm9rZSBmaWxl
cy4KCj4gQXMgZmFyIGFzIEkgY2FuIHRlbGwgaXRzIGEgcmVncmVzc2lvbiBmcm9tCj4gMTMwZmRi
YzNkMWY5OSAoIm92bDogcGFzcyBjb3JyZWN0IGZsYWdzIGZvciBvcGVuaW5nIHJlYWwgZGlyZWN0
b3J5IikKCj4gVGhhbmtzIGZvciBhZGRpbmcgdGhpcyB0ZXN0Lgo+IEkgYWRkZWQgeW91ciBUZXN0
ZWQtYnkgdG8gdGhlIGZpeCBwYXRjaC4KCkknbSBnb2luZyB0byBtZXJnZSB0b2RheS4gU28gdGhl
cmUgd2lsbCBiZSBoYXNoIGZvciBmaXhpbmcga2VybmVsIGNvbW1pdCwKdGhhbmtzIGZvciBpbmZv
LgoKUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKPiBUaGFua3MsCj4g
QW1pci4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
