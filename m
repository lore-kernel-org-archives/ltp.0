Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B5EC36014
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 07:59:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DC973CAFD5
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 09:59:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 838C03CAE86
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 09:58:59 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 80FC510007F5
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 09:58:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81DAB21179;
 Tue,  1 Apr 2025 07:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743494337;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijtUB0Dxg3/2B/US/zNYk7DUrx9EIzcQ1xpWCP7K2cs=;
 b=MY+weWZfL81NWOAg9VQMU8t0fHTqLoloMh1KUery7stXev0ebmFoIP1rpQRtnlhHLKm47o
 Aith5J3BMaccFGcg2jYBlswdcpXksWGzzpQHdXpQ1dXisGAXRfLyXyGtkfa4yfAcTubWKM
 kZDxOZhIATydRtOPdIVYdGFUBNw2Qjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743494337;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijtUB0Dxg3/2B/US/zNYk7DUrx9EIzcQ1xpWCP7K2cs=;
 b=sgd9Xea9qc/hL9stlCimlD88xVqMNvM6iQan9WML3ioe4nfkYHCTMjNeAKiwzbEW+blhud
 kkTiMmmWP4+cjXBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MY+weWZf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sgd9Xea9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743494337;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijtUB0Dxg3/2B/US/zNYk7DUrx9EIzcQ1xpWCP7K2cs=;
 b=MY+weWZfL81NWOAg9VQMU8t0fHTqLoloMh1KUery7stXev0ebmFoIP1rpQRtnlhHLKm47o
 Aith5J3BMaccFGcg2jYBlswdcpXksWGzzpQHdXpQ1dXisGAXRfLyXyGtkfa4yfAcTubWKM
 kZDxOZhIATydRtOPdIVYdGFUBNw2Qjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743494337;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijtUB0Dxg3/2B/US/zNYk7DUrx9EIzcQ1xpWCP7K2cs=;
 b=sgd9Xea9qc/hL9stlCimlD88xVqMNvM6iQan9WML3ioe4nfkYHCTMjNeAKiwzbEW+blhud
 kkTiMmmWP4+cjXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6538D138A5;
 Tue,  1 Apr 2025 07:58:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7yB4F8Gc62cGXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 01 Apr 2025 07:58:57 +0000
Date: Tue, 1 Apr 2025 09:58:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: rbm@suse.com
Message-ID: <20250401075856.GF299271@pevik>
References: <20250327-fix_make_clean-v1-0-8b9ed2a8d96a@suse.com>
 <20250327-fix_make_clean-v1-4-8b9ed2a8d96a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250327-fix_make_clean-v1-4-8b9ed2a8d96a@suse.com>
X-Rspamd-Queue-Id: 81DAB21179
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] configure: Add missing files for removal in
 ac-maintainer-clean target
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBGcm9tOiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKPiBUaGUgYWMtbWFp
bnRhaW5lci1jbGVhbiB0YXJnZXQgc2hvdWxkIGJlIHJlc3BvbnNpYmxlIHRvIHJlbW92ZSBhbGwK
PiBnZW5lcmF0ZWQgZmlsZXMsIGluIHRoaXMgY2FzZSBmcm9tIGBtYWtlIGF1dG90b29sc2AuIEFk
ZCB0aGUgcmVtYWluaW5nIHRvCj4gdGhlIGxpc3QgYW5kIGFsc28gbWFrZSBzdXJlIGl0IGhhcHBl
bnMgYmVmb3JlIGFueSBjYWxsIHRvIG90aGVyIHRhcmdldHMgaW4KPiBuZXN0ZWQgTWFrZWZpbGVz
LCBzbyBpZiB0aGVyZSBhcmUgYW55IGVycm9ycyBpbiB0aGVtLCB0aGV5IGhhcHBlbiBsYXN0bHku
CgoKPiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+
IC0tLQo+ICBpbmNsdWRlL21rL2F1dG9tYWtlLm1rIHwgNiArKystLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbWsvYXV0b21ha2UubWsgYi9pbmNsdWRlL21rL2F1dG9tYWtlLm1rCj4gaW5kZXggZDk2ZGE4
MzEzZGM4ZGM0ZjRkNmQ3MjhkYjcyYjBmNzQ5ZDI2OWJmZS4uNDBmYWIxMjQzNzBkN2M5YTcxZmE1
MDJmZjc1ZTM5Y2IxZDMxMTk3ZiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL21rL2F1dG9tYWtlLm1r
Cj4gKysrIGIvaW5jbHVkZS9tay9hdXRvbWFrZS5tawo+IEBAIC02MywxMSArNjMsMTEgQEAgYWMt
Y2xlYW46OgoKPiAgYWMtZGlzdGNsZWFuOjogYWMtY2xlYW4KPiAgYWMtbWFpbnRhaW5lci1jbGVh
bjo6IGFjLWRpc3RjbGVhbgo+ICsJJChSTSkgLWYgJChBVVRPTUFLRV9GSUxFUykgYWNsb2NhbC5t
NCBjb21waWxlIGNvbmZpZy5ndWVzcyBjb25maWcuc3ViIGNvbmZpZ3VyZSBtNC9NYWtlZmlsZS5p
bgoKT0ssIHRoaXMgcmVtb3ZlcyAiY29tcGlsZSIgZmlsZSAoV3JhcHBlciBmb3IgY29tcGlsZXJz
IHdoaWNoIGRvIG5vdCB1bmRlcnN0YW5kCictYyAtbycpLiBJbnRlcmVzdGluZy4gSU1ITyB0aGUg
cmVzdCBvZiBuZXdseSBleHBsaWNpdGx5IGFkZGVkIGZpbGVzIChlLmcuCmNvbmZpZy5ndWVzcywg
Y29uZmlnLnN1YiwgbTQvTWFrZWZpbGUuaW4pIHdlcmUgcmVtb3ZlZCB3aXRob3V0IHRoaXMgY2hh
bmdlIChwYXJ0Cm9mICQoQVVUT01BS0VfRklMRVMpICkuCgpybSAtZiAtZiBhY2xvY2FsLm00IGNv
bmZpZ3VyZSBjb25maWcuZ3Vlc3MgY29uZmlnLnN1YiBpbnN0YWxsLXNoIG1pc3NpbmcgbTQvTWFr
ZWZpbGUuaW4Kcm0gLWYgLWYgaW5jbHVkZS8qY29uZmlnLmguaW4KCktpbmQgcmVnYXJkcywKUGV0
cgoKPiArCSQoTUFLRSkgLUMgIiQodG9wX3NyY2RpcikvaW5jbHVkZSIgJEA7Cj4gIAlmb3IgZCBp
biAkKEFVVE9DT05GRURfU1VCRElSUyk7IGRvIFwKPiAgCSAgICAkKE1BS0UpIC1DICIkKHRvcF9z
cmNkaXIpLyQkZCIgJEA7IFwKPiAgCWRvbmUKPiAtCSQoUk0pIC1mIGFjbG9jYWwubTQgY29uZmln
dXJlICQoQVVUT01BS0VfRklMRVMpIG00L01ha2VmaWxlLmluCj4gLQkkKFJNKSAtZiBpbmNsdWRl
Lypjb25maWcuaC5pbgoKPiAgIyBEb24ndCBpbmNsdWRlIGNvbmZpZy5oLCBvciBtYWtlIHdpbGwg
KHJpZ2h0ZnVsbHkpIHdoaW5lIGFib3V0IG92ZXJyaWRpbmcKPiAgIyBydWxlcy4KPiBAQCAtODIs
MTAgKzgyLDEwIEBAIEFVVE9HRU5FUkFURURfRklMRVMJPSBcCj4gIAkJCW00L01ha2VmaWxlCgo+
ICBkaXN0Y2xlYW46OiAlOiBjbGVhbiBhYy1kaXN0Y2xlYW4KPiArCSQoUk0pIC1mICQoQVVUT0dF
TkVSQVRFRF9GSUxFUykKPiAgCWZvciBkIGluICQoQVVUT0NPTkZFRF9TVUJESVJTKTsgZG8gXAo+
ICAJICAgICQoTUFLRSkgLUMgIiQodG9wX3NyY2RpcikvJCRkIiAkQDsgXAo+ICAJZG9uZQo+IC0J
JChSTSkgLWYgJChBVVRPR0VORVJBVEVEX0ZJTEVTKQoKPiAgbWFpbnRhaW5lci1jbGVhbjo6IGRp
c3RjbGVhbiBhYy1tYWludGFpbmVyLWNsZWFuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
