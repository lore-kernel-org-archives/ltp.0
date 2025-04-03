Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF4AC3600C
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 13:59:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61B7C3CB292
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 15:59:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C0593CB276
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 15:59:27 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6716560047E
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 15:59:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 94857211E5;
 Thu,  3 Apr 2025 13:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743688764;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDKlgZMPN/dTRTtEBRduSkXhKzCzvchtl25zDZUNvj0=;
 b=0b+Do2wW94XlaLyhi4Y2tgFCVHD9DiYmrgT9yjvrDfx5fNpVf2mD1+pqhMW2lK3hsTKaJD
 A6WFEEDnmRuXTo/pvjRWSpRY5FYmUUA81gne/pj+mQRdvSbEUCEOlG9Y+YOi1ATfWYJ4up
 P+dM7IzN4NutqvAANoPJowXRheHgk2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743688764;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDKlgZMPN/dTRTtEBRduSkXhKzCzvchtl25zDZUNvj0=;
 b=ASCJLoZN01RWtczwCidIkKeTY5Yq604V+vNOBlZT++1hBbSKAXo2bSpBNMGa5BRUVC1VOb
 L8i1nT8u4GB8dSCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743688764;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDKlgZMPN/dTRTtEBRduSkXhKzCzvchtl25zDZUNvj0=;
 b=0b+Do2wW94XlaLyhi4Y2tgFCVHD9DiYmrgT9yjvrDfx5fNpVf2mD1+pqhMW2lK3hsTKaJD
 A6WFEEDnmRuXTo/pvjRWSpRY5FYmUUA81gne/pj+mQRdvSbEUCEOlG9Y+YOi1ATfWYJ4up
 P+dM7IzN4NutqvAANoPJowXRheHgk2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743688764;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDKlgZMPN/dTRTtEBRduSkXhKzCzvchtl25zDZUNvj0=;
 b=ASCJLoZN01RWtczwCidIkKeTY5Yq604V+vNOBlZT++1hBbSKAXo2bSpBNMGa5BRUVC1VOb
 L8i1nT8u4GB8dSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56CF913A2C;
 Thu,  3 Apr 2025 13:59:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rZhlETyU7mdvTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Apr 2025 13:59:24 +0000
Date: Thu, 3 Apr 2025 15:59:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250403135922.GA478597@pevik>
References: <20250403-conversions-set_thread_area-v2-1-a177e5c2b28d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250403-conversions-set_thread_area-v2-1-a177e5c2b28d@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/set_thread_area01: Refactor into new
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUmljYXJkbywKCj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBz
dXNlLmNvbT4KPiAtLS0KPiBDaGFuZ2VzIGluIHYyOgo+IC0gVXNlZCB0c3RfdGVzdC50ZXN0X2Fs
bCBpbnN0ZWFkIG9mIC50ZXN0Cj4gLSBSZW1vdmVkIFZBTFVFX0FORF9TVFJJTkcgbWFjcm8KPiAt
IEFkZGVkIGxvY2FsIHdyYXBwZXJzIHRvIHRoZSBzeXNjYWxscwo+IC0gRml4ZWQgdGhlIHRlc3Qg
ZGVzY3JpcHRpb24KPiAtIEFkZGVkIGEgY29tbWVudCBxdW90ZSBmcm9tIHRoZSBzZXRfdGhyZWFk
X2FyZWEgbWFudWFsIHRvIGFkZCBjb250ZXh0Cj4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyNTAzMjctY29udmVyc2lvbnMtbW9kaWZ5X2xkdC12Mi02LTI5MDdk
NGQzZjZjMEBzdXNlLmNvbQpGcm9tIE1lc3NhZ2UtSWQ6IGdlbmVyYXRlZCBieSBiNCBpdCdzIG9i
dmlvdXMgaXQgaXMgdjIsIG5vdCB2MS4gSSBhbHNvIHRyaWVkIHRvCmZpbmQgdjEsIGJ1dCBJTUhP
IHlvdSBoYXZlbid0IHNlbnQgaXQuCgo+IC0tLQo+ICAuLi4vc3lzY2FsbHMvc2V0X3RocmVhZF9h
cmVhL3NldF90aHJlYWRfYXJlYS5oICAgICB8ICAzMSAtLS0tLQo+ICAuLi4vc3lzY2FsbHMvc2V0
X3RocmVhZF9hcmVhL3NldF90aHJlYWRfYXJlYTAxLmMgICB8IDEzMyArKysrKysrLS0tLS0tLS0t
LS0tLS0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAxMjEgZGVsZXRpb25z
KC0pCgouLi4KPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldF90aHJlYWRfYXJl
YS9zZXRfdGhyZWFkX2FyZWEwMS5jCi4uLgo+ICsjaWZkZWYgX19pMzg2X18KCj4gLSNpZiBkZWZp
bmVkKEhBVkVfQVNNX0xEVF9IKSAmJiBkZWZpbmVkKEhBVkVfU1RSVUNUX1VTRVJfREVTQykKQlRX
IG9yaWdpbmFsIHRlc3QgaGFkICNpZiBkZWZpbmVkKEhBVkVfQVNNX0xEVF9IKSAmJiBkZWZpbmVk
KEhBVkVfU1RSVUNUX1VTRVJfREVTQyksCnN1Z2dlc3RpbmcgaXQgd2FzIG5vdCBpMzg2IHNwZWNp
ZmljLgoKQUNfQ0hFQ0tfVFlQRVMoW3N0cnVjdCB1c2VyX2Rlc2MsIHN0cnVjdCBtb2RpZnlfbGR0
X2xkdF9zXSxbXSxbXSxbI2luY2x1ZGUgPGFzbS9sZHQuaD5dKQoKQW5kIHRoZXJlIGlzIGZhbGxi
YWNrIGZvciBzdHJ1Y3QgbW9kaWZ5X2xkdF9sZHRfdCBpZiBuZWl0aGVyIHN0cnVjdCB1c2VyX2Rl
c2MKbm9yIHN0cnVjdCBtb2RpZnlfbGR0X2xkdF9zIGlzIGF2YWlsYWJsZS4gVGhhdCdzIGFsc28g
c3VnZ2VzdCBvdGhlciBhcmNocy4KCkkgd2FzIGFibGUgdG8gdGVzdCBpdCBvbmx5IG9uIHg4Nl82
NCwgd2hlcmUgaXQgd29ya3Mgb25seSB3aGVuIDMyIGJpdApjb21wYXRpYmlsaXR5IGlzIHNldC4g
VGhhdCBpbmRlZWQgd29ya3MgZm9yICNpZmRlZiBfX2kzODZfXyBvciBpdCBjb3VsZCBiZSBndWFy
ZGVkIGJ5OgoKLnN1cHBvcnRlZF9hcmNocyA9IChjb25zdCBjaGFyICpjb25zdCBbXSl7Ing4NiIs
IE5VTEx9LApUaGlzIHdheSBpdCB3b3VsZCBhcHBlYXIgaW4gdGhlIHRlc3QgY2F0YWxvZyBkb2Mu
CgpUcnlpbmcgdG8gcnVuIGl0IG9uIHJlZ3VsYXIgeDg2XzY0LCBpdCBUQ09ORiBkdWUgdHN0X3N5
c2NhbGxzKCkgZ3VhcmQ6CgpzZXRfdGhyZWFkX2FyZWEwMS5jOjM5OiBUQ09ORjogc3lzY2FsbCgy
MDUpIF9fTlJfc2V0X3RocmVhZF9hcmVhIG5vdCBzdXBwb3J0ZWQgb24geW91ciBhcmNoCgpXaGlj
aCBpcyBzdHJhbmdlLCBiZWNhdXNlIEkgc2VlIGluIGFyY2gveDg2L2tlcm5lbC90bHMuYyBpbiBk
b19zZXRfdGhyZWFkX2FyZWEoKQoodGhlIGltcGxlbWVudGF0aW9uKSBwYXJ0IG9mIHRoZSBjb2Rl
IHdpdGggI2lmZGVmIENPTkZJR19YODZfNjQuCgpJZiBpdCdzIHJlYWxseSBmb3IgMzIgYml0IChJ
IGRvbid0IHRoaW5rIHNvKSBidXQgc3VwcG9ydGVkIG9uIG1vcmUgYXJjaHMsIGl0CmNvdWxkIGJl
IGd1YXJkZWQgYnkgLm5lZWRzX2FiaV9iaXRzID0gMzIgKGFnYWluIG1ldGFkYXRhIGRvYykuCgpK
dXN0IGludmVzdGlnYXRpbmcsIGxvb2tpbmcgYXQgbWFuIHNldF90aHJlYWRfYXJlYSgyKSBpdCBt
ZW50aW9uczoKCglBdCB0aGUgbW9tZW50LCBzZXRfdGhyZWFkX2FyZWEoKSBpcwoJYXZhaWxhYmxl
IG9uIG02OGssIE1JUFMsIEMtU0tZLCBhbmQgeDg2IChib3RoIDMyLWJpdCBhbmQgNjQtYml0Cgl2
YXJpYW50cyk7IGdldF90aHJlYWRfYXJlYSgpIGlzIGF2YWlsYWJsZSBvbiBtNjhrIGFuZCB4ODYu
CgpbMl0gaHR0cHM6Ly9tYW43Lm9yZy9saW51eC9tYW4tcGFnZXMvbWFuMi9zZXRfdGhyZWFkX2Fy
ZWEuMi5odG1sCgpMb29raW5nIGF0IGtlcm5lbCBjb2RlIGl0IGFsc28gc2hvd3MgdGhhdCBvdGhl
ciBhcmNocyBhcmUgaW5jbHVkZWQsCklNSE8gdGhlIHJlbGV2YW50IG5vd2FkYXlzIChiZXNpZGVz
IHg4NiopIGFyZSBvbmx5IGUuZy4gYXJtLCBhcm02NC9hYXJjaDY0LgoKJCBnaXQgZ3JlcCAtbCBz
ZXRfdGhyZWFkX2FyZWEgYXJjaC8KYXJjaC9hcm0vdG9vbHMvc3lzY2FsbC50YmwKYXJjaC9hcm02
NC90b29scy9zeXNjYWxsXzMyLnRibAphcmNoL2Nza3kvaW5jbHVkZS9hc20vc3lzY2FsbHMuaAph
cmNoL2Nza3kva2VybmVsL3N5c2NhbGwuYwphcmNoL202OGsvaW5jbHVkZS9hc20vc3lzY2FsbHMu
aAphcmNoL202OGsva2VybmVsL3N5c19tNjhrLmMKYXJjaC9tNjhrL2tlcm5lbC9zeXNjYWxscy9z
eXNjYWxsLnRibAphcmNoL21pY3JvYmxhemUva2VybmVsL3N5c2NhbGxzL3N5c2NhbGwudGJsCmFy
Y2gvbWlwcy9rZXJuZWwvc3lzY2FsbC5jCmFyY2gvbWlwcy9rZXJuZWwvc3lzY2FsbHMvc3lzY2Fs
bF9uMzIudGJsCmFyY2gvbWlwcy9rZXJuZWwvc3lzY2FsbHMvc3lzY2FsbF9uNjQudGJsCmFyY2gv
bWlwcy9rZXJuZWwvc3lzY2FsbHMvc3lzY2FsbF9vMzIudGJsCmFyY2gvcGFyaXNjL2tlcm5lbC9z
eXNjYWxscy9zeXNjYWxsLnRibAphcmNoL3NoL2tlcm5lbC9zeXNjYWxscy9zeXNjYWxsLnRibAph
cmNoL3VtL2tlcm5lbC9wdHJhY2UuYwphcmNoL3g4Ni9lbnRyeS9zeXNjYWxscy9zeXNjYWxsXzMy
LnRibAphcmNoL3g4Ni9lbnRyeS9zeXNjYWxscy9zeXNjYWxsXzY0LnRibAphcmNoL3g4Ni9pbmNs
dWRlL2FzbS9wdHJhY2UuaAphcmNoL3g4Ni9pbmNsdWRlL3VhcGkvYXNtL3NpZ2NvbnRleHQuaAph
cmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jCmFyY2gveDg2L2tlcm5lbC9wdHJhY2UuYwphcmNoL3g4
Ni9rZXJuZWwvdGxzLmMKYXJjaC94ODYvdW0vYXNtL3B0cmFjZS5oCmFyY2gveDg2L3VtL29zLUxp
bnV4L3Rscy5jCmFyY2gveDg2L3VtL3NoYXJlZC9zeXNkZXAvdGxzLmgKYXJjaC94ODYvdW0vdGxz
XzMyLmMKYXJjaC94dGVuc2Eva2VybmVsL3N5c2NhbGxzL3N5c2NhbGwudGJsCgpCdXQgdGhhdCBt
ZWFucyBub3RoaW5nLiBDaGVja2luZyBhdCBhIHJlYWwgc2V0X3RocmVhZF9hcmVhKCkgZGVmaW5p
dGlvbiBJIHNlZToKCiQgZ2l0IGdyZXAgLWwgJ1NZU0NBTExfREVGSU5FLiooc2V0X3RocmVhZF9h
cmVhJyBhcmNoLwphcmNoL2Nza3kva2VybmVsL3N5c2NhbGwuYwphcmNoL21pcHMva2VybmVsL3N5
c2NhbGwuYwphcmNoL3g4Ni9rZXJuZWwvdGxzLmMKYXJjaC94ODYvdW0vdGxzXzMyLmMKCj0+IGl0
IHByb2JhYmx5IGRvZXMgbm90IHdvcmsgb24gYXJtIGFuZCBhcm02NC9hYXJjaDY0LgoKQnV0IG1h
eWJlIGp1c3Qgbm90IHNwZWNpZnkgYW55dGhpbmc/IEJlY2F1c2UgdHN0X3N5c2NhbGwoKSB3aWxs
IHF1aXQgd2l0aCBUQ09ORgppbiBjYXNlIGtlcm5lbCBkb2VzIG5vdCBzdXBwb3J0IGl0PyBUaGF0
IGNhc2Ugd2UgZG9uJ3QgYmxvY2sgYW55Ym9keSBmcm9tIG1pcHMsCmNza3kgZm9sa3MgdG8gZG8g
dGVzdGluZyBpZiB0aGV5IHdhbnQuIEJ1dC4uLgoKPiArI2luY2x1ZGUgImxhcGkvbGR0LmgiCgou
Li4gZ2l2ZW4gaXQgcmVxdWlyZXMgJ3N0cnVjdCB1c2VyX2Rlc2MnIGZyb20gPGFzbS9sZHQuaD4s
IHdoaWNoIGlzIG9ubHkgZm9yCng4Ni9pMzg2IGFuZCB4ODZfNjQsIEkgd291bGQgY2hvc2U6Cgou
c3VwcG9ydGVkX2FyY2hzID0gKGNvbnN0IGNoYXIgKmNvbnN0IFtdKXsieDg2IiwgTlVMTH0sCgpB
aCwgdGhlIGRlcGVuZGVuY3kgWzFdIGlzIGF0IHRoZSBlbmQgaW4gYjQgdGFnOgo+IHByZXJlcXVp
c2l0ZS1tZXNzYWdlLWlkOiA8MjAyNTA0MDItY29udmVyc2lvbnMtbW9kaWZ5X2xkdC12Ni0wLTJl
NGIwZTI3ODcwZUBzdXNlLmNvbT4KCkxhdGVyIEknbGwgY2hlY2ssIGJlY2F1c2UgaXQncyBvYnZp
b3VzIHRoYXQgaXQgbmVlZHMgaW5jbHVkZS9sYXBpL2xkdC5oIGZyb20KYW5vdGhlciBwYXRjaHNl
dCwgYnV0IEkgd2FzIG5vdCBzdXJlIHdoZXRoZXIgdjYgc2hvdWxkIGJlIHVzZWQgKGFueXdheSwg
aXQncyB0aGUKbmV3ZXN0KS4gRm9yIG1lIGl0J2QgYmUgcXVpY2tlc3QgaWYgSSBjb3VsZCBqdXN0
IHNlZSB3b3JraW5nIGJyYW5jaCBvbiB0aGUKcmVtb3RlIGZvcmsgKCsgaGF2ZSBDSSBydW4gZm9y
IGZyZWUpLiBCVFcgaWYgd2Ugb25lIGRheSBpbXBsZW1lbnQgYXV0b21hdGljIENJCmZvciBzZW5k
aW5nIHBhdGNoZXMsIGl0IHdpbGwgbm90IHdvcmsgaWYgc29tZSBvZiBkZXBlbmRpbmcgY29tbWl0
cyBpcyBzZXBhcmF0ZWQuCgpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0
L2x0cC9wYXRjaC8yMDI1MDQwMi1jb252ZXJzaW9ucy1tb2RpZnlfbGR0LXY2LTEtMmU0YjBlMjc4
NzBlQHN1c2UuY29tLwoKPiArLyogV2hlbiBzZXRfdGhyZWFkX2FyZWEoKSBpcyBwYXNzZWQgYW4g
ZW50cnlfbnVtYmVyIG9mIC0xLCBpdCAgc2VhcmNoZXMKPiArICogZm9yIGEgZnJlZSBUTFMgZW50
cnkuIElmIHNldF90aHJlYWRfYXJlYSgpIGZpbmRzIGEgZnJlZSBUTFMgZW50cnksCj4gKyAqIHRo
ZSB2YWx1ZSBvZiB1X2luZm8tPmVudHJ5X251bWJlciBpcyBzZXQgdXBvbiByZXR1cm4gdG8gc2hv
dyB3aGljaAo+ICsgKiBlbnRyeSB3YXMgY2hhbmdlZC4KPiArICovCgouLi4KPiArdm9pZCBydW4o
dm9pZCkKPiAgewo+IC0JaW50IGxjOwo+IC0JdW5zaWduZWQgaTsKPiAtCj4gLQl0c3RfcGFyc2Vf
b3B0cyhhcmdjLCBhcmd2LCBOVUxMLCBOVUxMKTsKPiAtCj4gLQlzZXR1cCgpOwo+IC0KPiAtCWZv
ciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyBsYysrKSB7Cj4gLQkJZm9yIChpID0gMDsgaSA8
IHNpemVvZih0ZXN0cykgLyBzaXplb2Yoc3RydWN0IHRlc3QpOyBpKyspIHsKPiAtCQkJVEVTVCh0
c3Rfc3lzY2FsbCh0ZXN0c1tpXS5zeXNjYWxsLCB0ZXN0c1tpXS51X2luZm8pKTsKPiArCVRTVF9F
WFBfUEFTUyhzZXRfdGhyZWFkX2FyZWEoJmVudHJ5KSk7Cj4gKwlUU1RfRVhQX1BBU1MoZ2V0X3Ro
cmVhZF9hcmVhKCZlbnRyeSkpOwoKPiAtCQkJaWYgKFRFU1RfUkVUVVJOICE9IHRlc3RzW2ldLmV4
cF9yZXQpIHsKPiAtCQkJCXRzdF9yZXNtKFRGQUlMLCAiJXMgcmV0dXJuZWQgJWxpIGV4cGVjdGVk
ICVpIiwKPiAtCQkJCQkgdGVzdHNbaV0uc3lzY2FsbF9uYW1lLAo+IC0JCQkJCSBURVNUX1JFVFVS
TiwgdGVzdHNbaV0uZXhwX3JldCk7Cj4gLQkJCQljb250aW51ZTsKPiAtCQkJfQo+ICsJVFNUX0VY
UF9GQUlMKHNldF90aHJlYWRfYXJlYSgmaW52YWxpZF9lbnRyeSksIEVJTlZBTCk7Cj4gKwlUU1Rf
RVhQX0ZBSUwoZ2V0X3RocmVhZF9hcmVhKCZpbnZhbGlkX2VudHJ5KSwgRUlOVkFMKTsKCj4gLQkJ
CWlmIChURVNUX0VSUk5PICE9IHRlc3RzW2ldLmV4cF9lcnJubykgewo+IC0JCQkJdHN0X3Jlc20o
VEZBSUwsCj4gLQkJCQkJICIlcyBmYWlsZWQgd2l0aCAlaSAoJXMpIGV4cGVjdGVkICVpICglcyki
LAo+IC0JCQkJCSB0ZXN0c1tpXS5zeXNjYWxsX25hbWUsIFRFU1RfRVJSTk8sCj4gLQkJCQkJIHN0
cmVycm9yKFRFU1RfRVJSTk8pLAo+IC0JCQkJCSB0ZXN0c1tpXS5leHBfZXJybm8sCj4gLQkJCQkJ
IHN0cmVycm9yKHRlc3RzW2ldLmV4cF9lcnJubykpOwo+IC0JCQkJY29udGludWU7Cj4gLQkJCX0K
PiArCVRTVF9FWFBfRkFJTChzZXRfdGhyZWFkX2FyZWEoKHZvaWQgKiktOSksIEVGQVVMVCk7Cj4g
KwlUU1RfRVhQX0ZBSUwoZ2V0X3RocmVhZF9hcmVhKCh2b2lkICopLTkpLCBFRkFVTFQpOwoKVGhp
cyB3aWxsIGJlIGEgcHJvYmxlbSBmb3IgcG9ydGFibGl0eSBvdXRzaWRlIG9mIGkzODYgKHg4Niku
CldlIGhhdmUgdHN0X2dldF9iYWRfYWRkcihOVUxMKSwgYW5kIGl0IHdvcmtzIGZvciBtZSBvbiB4
ODZfNjQgd2l0aCAzMiBiaXQKY29tcGF0aWJpbGl0eS4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiAt
LS0KPiBiYXNlLWNvbW1pdDogODk4Y2MxNGFkNDEyZmI1MjE4NjdiNDNmZWQ1YzRlMDY3Yjc2Zjgw
OQo+IGNoYW5nZS1pZDogMjAyNTA0MDMtY29udmVyc2lvbnMtc2V0X3RocmVhZF9hcmVhLTA3YTkw
ZTBjZDQ0OQo+IHByZXJlcXVpc2l0ZS1tZXNzYWdlLWlkOiA8MjAyNTA0MDItY29udmVyc2lvbnMt
bW9kaWZ5X2xkdC12Ni0wLTJlNGIwZTI3ODcwZUBzdXNlLmNvbT4KPiBwcmVyZXF1aXNpdGUtcGF0
Y2gtaWQ6IDQ5MGEzZTZiYzQwMDRkYjUyMzQyMjRiNmZkNmQ0YmY1MDMwYjIxOWQKPiBwcmVyZXF1
aXNpdGUtcGF0Y2gtaWQ6IDk2MmJiODE1NDQ0ZWIyZGU5NzU2ZGQyNjU5ZTA5NzU2N2I2ZDZmZTgK
PiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IGE4MzU3ZmI4NzBhOGQ3Mjc4ZTIwNmI0ZmM2NWYxZDk0
NTBmZWU4MDIKCj4gQmVzdCByZWdhcmRzLAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
