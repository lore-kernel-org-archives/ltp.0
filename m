Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09548C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 13:25:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07F303CF32E
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 14:25:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B55DC3C9DB1
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 14:25:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B75971000F27
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 14:25:06 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E55621114;
 Mon, 18 Dec 2023 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702905905;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsOstm5skgN1uK0zIIstfrC+BAJlaUg6CVuecOMsJAo=;
 b=rf2t9A/u01x5TgSomUWSKagWntJ3Yzi40+7IcrmNEpCxdGvflLypZSA4kLsMmgOPMThwhY
 Sa/ejmGLUcaND6vtMdYSGDWgo4DBUeN22I3Hx3kFK2mop1FBXbzWoiYPD/7mzM9T8Ib3ij
 GzglHLuGDsdDly97LgAMX+Q+7FW6XTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702905905;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsOstm5skgN1uK0zIIstfrC+BAJlaUg6CVuecOMsJAo=;
 b=U9YWpQI/ww7r6uV29/Gjwuace8e8qqXbHSSW0JnylGMCavrnHZP8mGiYuVu6rspTnFC3bZ
 eQ/mkLg43IvVA2DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702905905;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsOstm5skgN1uK0zIIstfrC+BAJlaUg6CVuecOMsJAo=;
 b=rf2t9A/u01x5TgSomUWSKagWntJ3Yzi40+7IcrmNEpCxdGvflLypZSA4kLsMmgOPMThwhY
 Sa/ejmGLUcaND6vtMdYSGDWgo4DBUeN22I3Hx3kFK2mop1FBXbzWoiYPD/7mzM9T8Ib3ij
 GzglHLuGDsdDly97LgAMX+Q+7FW6XTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702905905;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsOstm5skgN1uK0zIIstfrC+BAJlaUg6CVuecOMsJAo=;
 b=U9YWpQI/ww7r6uV29/Gjwuace8e8qqXbHSSW0JnylGMCavrnHZP8mGiYuVu6rspTnFC3bZ
 eQ/mkLg43IvVA2DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E779D13BC8;
 Mon, 18 Dec 2023 13:25:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id NQoyNjBIgGVeWwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 18 Dec 2023 13:25:04 +0000
Date: Mon, 18 Dec 2023 14:24:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231218132459.GA199735@pevik>
References: <20231214071321.9863-1-wegao@suse.com>
 <20231218122236.24917-1-wegao@suse.com>
 <20231218122236.24917-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231218122236.24917-2-wegao@suse.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.92 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.41)[90.96%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="rf2t9A/u";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="U9YWpQI/"
X-Rspamd-Queue-Id: 1E55621114
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] tst_memutils.c: Add tst_print_meminfo
 function
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

SGkgV2VpLAoKPiArdm9pZCBzYWZlX3ByaW50X2ZpbGUoY29uc3QgY2hhciAqZmlsZSwgY29uc3Qg
aW50IGxpbmVubywgY2hhciAqcGF0aCkKPiArewo+ICsJRklMRSAqcGZpbGU7Cj4gKwljaGFyIGxp
bmVbUEFUSF9NQVhdOwo+ICsKPiArCXBmaWxlID0gc2FmZV9mb3BlbihmaWxlLCBsaW5lbm8sIE5V
TEwsIHBhdGgsICJyIik7Cj4gKwpJJ2QgZXhwZWN0IGhlcmUgVElORk8gbWVzc2FnZToKCnRzdF9y
ZXMoVElORk8sICI9PT0gJXMgPT09IiwgcGF0aCk7Cgo+ICsJd2hpbGUgKGZnZXRzKGxpbmUsIHNp
emVvZihsaW5lKSwgcGZpbGUpKQo+ICsJCXRzdF9yZXNtXyhmaWxlLCBsaW5lbm8sIFRJTkZPLCAi
JXMiLCBsaW5lKTsKVGhpcyB3aWxsIG5vdCB3b3JrLCB0aGF0J3MgbGVnYWN5IEFQSS4KClBsZWFz
ZSBuZXh0IHRpbWUgcGF5IGF0dGVudGlvbiB3aXRoIHdhcm5pbmdzOgoKdHN0X3NhZmVfbWFjcm9z
LmM6IEluIGZ1bmN0aW9uIOKAmHNhZmVfcHJpbnRfZmlsZeKAmToKdHN0X3NhZmVfbWFjcm9zLmM6
NjIyOjE3OiB3YXJuaW5nOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJh0c3Rf
cmVzbV/igJk7IGRpZCB5b3UgbWVhbiDigJh0c3RfcmVzX+KAmT8gWy1XaW1wbGljaXQtZnVuY3Rp
b24tZGVjbGFyYXRpb25dCiAgNjIyIHwgICAgICAgICAgICAgICAgIHRzdF9yZXNtXyhmaWxlLCBs
aW5lbm8sIFRJTkZPLCAiJXMiLCBsaW5lKTsKICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+
fn5+CiAgICAgIHwgICAgICAgICAgICAgICAgIHRzdF9yZXNfCgoKQWxzbywgaWYgeW91IHB1c2gg
dG8gZ2l0aHViLCB5b3Ugc2VlIHRoaXMgaXMgZmF0YWwgZm9yIENJLCB3aGVyZSB3ZSBjb21waWxl
IHdpdGgKLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbi4KClBsZWFzZSBuZXh0
IHRpbWUgcHVzaCB0byBnaXRodWIgZmlyc3QsIHNvIHRoYXQgeW91IHNhdmUgcmV2aWV3ZXIgdGlt
ZS4KCkFsc28sIHdoZW4geW91IHJ1biB0aGUgdGVzdCwgdGhlIG91dHB1dCBjb250YWlucyBleHRy
YSBuZXcgbGluZToKCnRzdF9rY29uZmlnLmM6ODc6IFRJTkZPOiBQYXJzaW5nIGtlcm5lbCBjb25m
aWcgJy9wcm9jL2NvbmZpZy5neicKdHN0X3Rlc3QuYzoxNjkwOiBUSU5GTzogTFRQIHZlcnNpb246
IDIwMjMwOTI5LTIwMS1nZTMyNzM1MjUyCnRzdF90ZXN0LmM6MTU3NDogVElORk86IFRpbWVvdXQg
cGVyIHJ1biBpcyAwaCAxMG0gMzBzCnRzdF9zYWZlX21hY3Jvcy5jOjYxOTogVElORk86ID09PSAv
cHJvYy9tZW1pbmZvID09PQpzd2FwcGluZzAxLmM6ODg6IFRJTkZPOiBNZW1Ub3RhbDogICAgICAg
IDc3MDAyMjQga0IKCnN3YXBwaW5nMDEuYzo4ODogVElORk86IE1lbUZyZWU6ICAgICAgICAgNDA1
ODk5NiBrQgoKc3dhcHBpbmcwMS5jOjg4OiBUSU5GTzogTWVtQXZhaWxhYmxlOiAgICA0MTcyNzM2
IGtCCi4uLgoKV2UgY291bGQgcmVtb3ZlIGl0LCBidXQgYWN0dWFsbHkgcHJpbnRpbmcgaXQgdmlh
IGZwcmludGYgaXMgYWN0dWFsbHkgYmV0dGVyOgoKdHN0X2tjb25maWcuYzo4NzogVElORk86IFBh
cnNpbmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwp0c3RfdGVzdC5jOjE2OTA6IFRJ
TkZPOiBMVFAgdmVyc2lvbjogMjAyMzA5MjktMjAxLWdlMzI3MzUyNTIKdHN0X3Rlc3QuYzoxNTc0
OiBUSU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDEwbSAzMHMKdHN0X3NhZmVfbWFjcm9zLmM6
NjE5OiBUSU5GTzogPT09IC9wcm9jL21lbWluZm8gPT09Ck1lbVRvdGFsOiAgICAgICAgMTQ2NzE4
MCBrQgpNZW1GcmVlOiAgICAgICAgICA4MjAwNDAga0IKTWVtQXZhaWxhYmxlOiAgICAxMTQzMzIw
IGtCCi4uLgoKQW55d2F5LCBmaXhlZCBhbmQgbWVyZ2VkIHRoaXMgcGF0Y2guCgpLaW5kIHJlZ2Fy
ZHMsClBldHIKCj4gKwo+ICsJc2FmZV9mY2xvc2UoZmlsZSwgbGluZW5vLCBOVUxMLCBwZmlsZSk7
Cj4gK30KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
